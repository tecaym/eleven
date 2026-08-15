create table menu_items (
  id uuid primary key default gen_random_uuid(),
  categorie text not null,
  sous_categorie text,
  nom text not null,
  prix text,
  created_at timestamptz default now()
);

alter table menu_items enable row level security;

create policy "Lecture publique" on menu_items
  for select using (true);

create policy "Ecriture connecté - insert" on menu_items
  for insert with check (auth.role() = 'authenticated');

create policy "Ecriture connecté - update" on menu_items
  for update using (auth.role() = 'authenticated');

create policy "Ecriture connecté - delete" on menu_items
  for delete using (auth.role() = 'authenticated');

insert into menu_items (categorie, sous_categorie, nom, prix) values
('Champagne', null, 'Moët & Chandon Brut Impérial', null),
('Champagne', null, 'Ruinart', null),

('Vodka', null, 'Eristoff', null),
('Vodka', null, 'Benelux', null),
('Vodka', null, 'Belvedere', null),

('Vins blancs', null, 'Chardonnay', null),

('Vins rouges', null, 'Saint-Émilion Grand Cru', null),

('Liqueurs spéciales', null, 'Baileys', null),
('Liqueurs spéciales', null, 'Amaretto Disaronno', null),
('Liqueurs spéciales', null, 'Malibu', null),
('Liqueurs spéciales', null, 'Cointreau', null),

('Bières Ghost', 'Classiques', 'Duvel', '7 €'),
('Bières Ghost', 'Classiques', 'Heineken', '7 €'),
('Bières Ghost', 'Classiques', 'Carlsberg', '7 €'),
('Bières Ghost', 'Classiques', 'Corona', '7 €'),
('Bières Ghost', 'Premium spéciales', 'Leffe Blonde', '7 €'),
('Bières Ghost', 'Premium spéciales', 'Leffe Brune', '7 €'),
('Bières Ghost', 'Premium spéciales', 'Hoegaarden', '7 €'),

('Chichas', null, 'Pomme', '20 €'),
('Chichas', null, 'Pomme Menthe', '20 €'),
('Chichas', null, 'Raisin Menthe', '20 €'),
('Chichas', null, 'Menthe', '20 €'),
('Chichas', null, 'Love 66', '20 €'),
('Chichas', null, 'Mangue Passion', '20 €'),
('Chichas', null, 'Hawaii', '20 €'),
('Chichas', null, 'Lady Killer', '20 €'),
('Chichas', null, 'Mi Amor', '20 €'),
('Chichas', null, 'Candy Cherry', '20 €'),
('Chichas', null, 'Cold Lime Ice', '20 €'),
('Chichas', null, 'Ice Peach', '20 €'),
('Chichas', null, 'Limon Cello', '20 €'),
('Chichas', null, 'Raisin Royal', '20 €'),
('Chichas', null, 'Blue Ice', '20 €'),
('Chichas', null, 'Fraise Banane', '20 €'),
('Chichas', null, 'Watermelon', '20 €'),
('Chichas', null, 'Chewing Gum', '20 €'),
('Chichas', null, 'Menthe verte', '20 €'),
('Chichas', null, 'Supplément tête', '5 €'),

('Milkshakes', null, 'Vanille', '10 €'),
('Milkshakes', null, 'Fraise', '10 €'),
('Milkshakes', null, 'Chocolat', '10 €'),
('Milkshakes', null, 'Oreo', '10 €'),
('Milkshakes', null, 'Avocat', '10 €'),
('Milkshakes', null, 'Banane', '10 €'),

('Smoothies', null, 'Orange', '10 €'),
('Smoothies', null, 'Mangue', '10 €'),
('Smoothies', null, 'Ananas', '10 €'),
('Smoothies', null, 'Fraise', '10 €'),
('Smoothies', null, 'Framboise', '10 €'),
('Smoothies', null, 'Banane', '10 €'),

('Thés classiques', null, 'Thé vert nature', '5 €'),
('Thés classiques', null, 'Thé à la menthe', '5 €'),
('Thés classiques', null, 'Thé fruits rouges', '5 €'),
('Thés classiques', null, 'Thé pêche', '5 €'),

('Cafés', null, 'Espresso', '5 €'),
('Cafés', null, 'Double Espresso', '5 €'),
('Cafés', null, 'Allongé', '5 €'),
('Cafés', null, 'Cappuccino', '5 €'),
('Cafés', null, 'Latte', '5 €'),
('Cafés', null, 'Macchiato', '5 €'),
('Cafés', null, 'Café au lait', '5 €'),
('Cafés', null, 'Cecemel', '5 €'),

('Eaux / Pétillants', null, 'Eau plate / pétillante', null),

('Red Bull', null, 'Red Bull Classique', null),

('Sodas', 'Soft', 'Coca-Cola', null),
('Sodas', 'Soft', 'Coca-Cola Zero', null),
('Sodas', 'Soft', 'Fanta Orange', null),
('Sodas', 'Soft', 'Fanta Citron', null),
('Sodas', 'Soft', 'Fanta Exotic', null),
('Sodas', 'Soft', 'Sprite', null),
('Sodas', 'Soft', 'Orangina', null),
('Sodas', 'Soft', 'Ice Tea pêche', null),
('Sodas', 'Soft', 'Ice Tea citron', null),
('Sodas', 'Soft', 'Ice Tea green tea', null),
('Sodas', 'Soft', 'Schweppes Tonic', null),
('Sodas', 'Soft', 'Schweppes Agrumes', null),
('Sodas', 'Jus de fruits', 'Orange', null),
('Sodas', 'Jus de fruits', 'Pomme', null),
('Sodas', 'Jus de fruits', 'Ananas', null),
('Sodas', 'Jus de fruits', 'Cranberry', null),
('Sodas', 'Jus de fruits', 'Mangue', null),
('Sodas', 'Jus de fruits', 'Multivitamines', null),
('Sodas', 'Jus de fruits', 'Pomme cerise', null),
('Sodas', 'Jus de fruits', 'Pêche', null),

('Cocktails', null, 'Espresso Martini', '13 €'),
('Cocktails', null, 'Cosmopolitan', '14 €'),
('Cocktails', null, 'Sex on the Beach', '15 €'),
('Cocktails', null, 'Long Island', '13 €'),
('Cocktails', null, 'Caipirinha', '13 €'),
('Cocktails', null, 'Mojito', '14 €'),
('Cocktails', null, 'Pina Colada', '14 €'),
('Cocktails', null, 'Daiquiri Strawberry', '14 €'),
('Cocktails', null, 'Negroni', '14 €'),
('Cocktails', null, 'Pornstar', '16 €'),

('Mocktails', null, 'Lazy Red Cheeks', '10 €'),
('Mocktails', null, 'Mojito', '10 €'),
('Mocktails', null, 'Pina Colada', '10 €'),
('Mocktails', null, 'Daiquiri', '10 €'),
('Mocktails', null, 'Pornstar', '10 €'),
('Mocktails', null, 'Aperitivo Spritz', '10 €'),
('Mocktails', null, 'Cosmopolitan', '10 €');
