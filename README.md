# Velours — Mise en route

Ton site a 4 fichiers principaux :
- `index.html` → le site public (charge les soirées et la carte depuis Supabase)
- `admin.html` → l'espace admin pour gérer les soirées et la carte (protégé par code, voir étape 1.4)
- `config.js` → les clés de connexion à Supabase (à remplir, voir étape 2)
- `supabase-menu-items.sql` → à exécuter une fois dans Supabase pour activer la carte (voir étape 5)

---

## 1. Créer le projet Supabase

1. Va sur [supabase.com](https://supabase.com) → crée un compte → **New project**.
2. Choisis un nom, un mot de passe de base de données, une région proche (ex: Europe).
3. Une fois le projet créé, va dans **SQL Editor** (menu de gauche) → **New query**, colle ceci et clique **Run** :

```sql
create table soirees (
  id uuid primary key default gen_random_uuid(),
  nom text not null,
  date date not null,
  genre text,
  created_at timestamptz default now()
);

alter table soirees enable row level security;

-- tout le monde peut lire (site public)
create policy "Lecture publique" on soirees
  for select using (true);

-- seul un utilisateur connecté peut ajouter/modifier/supprimer
create policy "Ecriture connecté - insert" on soirees
  for insert with check (auth.role() = 'authenticated');

create policy "Ecriture connecté - update" on soirees
  for update using (auth.role() = 'authenticated');

create policy "Ecriture connecté - delete" on soirees
  for delete using (auth.role() = 'authenticated');

-- table des réservations (envoyées depuis le formulaire du site)
create table reservations (
  id uuid primary key default gen_random_uuid(),
  nom text,
  telephone text,
  date_souhaitee date,
  invites text,
  notes text,
  created_at timestamptz default now()
);

alter table reservations enable row level security;

-- tout le monde peut envoyer une réservation (le formulaire du site est public)
create policy "Envoi public" on reservations
  for insert with check (true);

-- seul un utilisateur connecté (toi) peut voir et gérer les réservations
create policy "Lecture connecté" on reservations
  for select using (auth.role() = 'authenticated');

create policy "Suppression connecté" on reservations
  for delete using (auth.role() = 'authenticated');
```

4. Crée ton compte admin : va dans **Authentication → Users → Add user**.
   - **Email** : mets exactement `admin@eleven-brussels.local` (c'est un email technique, tu ne le tapes jamais nulle part — laisse `config.js` tel quel, voir étape 2).
   - **Password** : mets le code que tu veux utiliser pour te connecter sur `admin.html` (6 caractères minimum). C'est ce code, et lui seul, que tu taperas sur la page admin.
   - Coche "Auto Confirm User" si l'option est proposée.
   - Pense à désactiver les inscriptions publiques : **Authentication → Providers → Email**, décoche "Allow new users to sign up" (tu es le seul admin, pas besoin que d'autres puissent créer un compte).

5. Récupère tes clés : **Project Settings → API**.
   - Copie **Project URL**
   - Copie la clé **anon public**

---

## 2. Remplir `config.js`

Ouvre `config.js` et remplace :

```js
window.SUPABASE_URL = "https://TON-PROJET.supabase.co";
window.SUPABASE_ANON_KEY = "TON-ANON-KEY-PUBLIQUE";
```

par tes vraies valeurs copiées à l'étape précédente. C'est sans danger que cette clé soit visible publiquement : c'est la clé "anon" faite pour le navigateur, et les règles de sécurité (RLS) que tu as créées empêchent quiconque de modifier les données sans être connecté.

Laisse la ligne `window.ADMIN_EMAIL` telle quelle — c'est un email technique utilisé en coulisses, pas un vrai email à consulter. Sur `admin.html`, tu ne verras et ne taperas qu'un simple champ "code" (voir étape 1.4).

---

## 3. Déployer sur Vercel

1. Mets ces 3 fichiers dans un dépôt GitHub (crée un repo, ajoute les fichiers, commit, push).
   - Si tu ne connais pas Git : sur [github.com](https://github.com), tu peux créer un repo puis glisser-déposer les fichiers directement depuis l'interface web ("Add file → Upload files").
2. Va sur [vercel.com](https://vercel.com), connecte-toi avec GitHub.
3. **Add New → Project**, choisis ton repo. Comme c'est un site statique (pas de framework), Vercel le détecte automatiquement — laisse les réglages par défaut et clique **Deploy**.
4. Ton site est en ligne sur une URL du type `ton-projet.vercel.app`.

---

## 4. Brancher ton nom de domaine

1. Dans Vercel : **Project → Settings → Domains** → ajoute ton nom de domaine.
2. Vercel t'indique les enregistrements DNS à créer (souvent un `CNAME` ou des `A records`).
3. Va chez ton registrar (OVH, Gandi, Namecheap...) → zone DNS → ajoute ces enregistrements.
4. Attends la propagation (de quelques minutes à quelques heures).

---

## 5. Activer la carte des boissons (à faire une fois)

La carte (Champagne, Vodka, Cocktails...) est maintenant gérée depuis l'admin, comme les soirées. Il faut créer la table une fois dans Supabase :

1. Va dans **SQL Editor** → **New query**.
2. Ouvre le fichier `supabase-menu-items.sql` (à la racine du projet), copie tout son contenu, colle-le et clique **Run**.
   - Ça crée la table `menu_items`, les règles de sécurité, et importe la carte actuelle (tous les articles et prix déjà sur le site) pour ne rien perdre.
3. Recharge `index.html` : la carte s'affiche maintenant depuis Supabase.
4. Sur `admin.html`, un nouvel onglet **Boissons** permet d'ajouter, modifier le prix ou supprimer un article.

---

## Utilisation au quotidien

- Pour gérer les soirées ou la carte : va sur `tondomaine.com/admin.html`, tape le code créé à l'étape 1.4.
- Toute modification (soirée ou boisson) se répercute automatiquement sur le site public (`index.html`) au prochain chargement de page.

## Prochaines étapes possibles

- Enregistrer aussi les réservations de table dans Supabase (actuellement le formulaire ne fait qu'un message de confirmation, sans sauvegarde).
- Ajouter une image par soirée.
- Envoyer un email de confirmation automatique à chaque réservation.
