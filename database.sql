drop table if exists users;
drop table if exists television_wall_brackets;
drop table if exists remote_controllers;
drop table if exists ci_modules;
drop table if exists wall_brackets;
drop table if exists televisions;
drop table if exists products;

create table users(
                      id int generated always as identity,
                      user_name varchar(255) unique,
                      password varchar(255) unique
);

create table products(
                         id int generated always as identity,
                         name varchar(255) not null unique ,
                         brand varchar(255) not null,
                         price float not null,
                         current_stock int,
                         sold int,
                         primary key (id)
);

create table televisions (
                             id int generated always as identity,
                             type varchar(255) not null,
                             available float,
                             refresh_rate float,
                             screen_type varchar(255) not null,
                             primary key (id),
                             constraint fk_product foreign key (id) references products(id)
);

-- one to one relation between remote_controllers and televisions
create table remote_controllers (
                                    id int generated always as identity,
                                    compatible_with varchar(255) not null,
                                    battery_type varchar(255) not null,
                                    constraint fk_product foreign key (id) references products(id),
                                    constraint fk_televisions foreign key(id) references televisions(id)
);

--one to many relatie an ci_modules can have more televisions, television can have one/zero ci_modules
create table ci_modules(
                           id int generated always as identity,
                           type varchar(255) not null,
                           brand varchar(255),
                           primary key (id),
                           constraint fk_product foreign key (id) references products(id),
                           constraint fk_televisions foreign key(id) references televisions(id)
);

create table wall_brackets(
                              id int generated always as identity,
                              adjustable boolean,
                              primary key(id),
                              constraint fk_product foreign key (id) references products(id)
);

-- many to many relation (extra table)
create table television_wall_brackets (
                                          television_id INT,
                                          wall_bracket_id INT,
                                          primary key (television_id, wall_bracket_id),
                                          constraint fk_televisions foreign key (television_id) references televisions(id),
                                          constraint fk_wall_brackets foreign key (wall_bracket_id) references wall_brackets(id)
);

insert into users(user_name, password)
values('gebruiker1', 'wachtwoord1'),
      ('gebruiker2', 'wachtwoord2'),
      ('gebruiker3', 'wachtwoord3'),
      ('gebruiker4', 'wachtwoord4'),
      ('gebruiker5', 'wachtwoord5');

insert into products(name, brand, price, current_stock, sold)
values('LGTV', 'LG', 100.00, 50, 10),
      ('Product2', 'Merk2', 150.00, 30, 5),
      ('Product3', 'Merk3', 200.00, 20, 8),
      ('Product4', 'Merk1', 120.00, 45, 12),
      ('Product5', 'Merk2', 180.00, 40, 6);

insert into televisions(type, available, refresh_rate, screen_type)
values('SMART', 25.0, 60.0, 'LED'),
      ('4K', 15.0, 120.0, 'OLED'),
      ('HD', 30.0, 50.0, 'LCD'),
      ('8K', 10.0, 240.0, 'QLED'),
      ('Full HD', 20.0, 75.0, 'LED');

insert into remote_controllers(compatible_with, battery_type)
values('SMART', 'AAA'),
      ('4K', 'AA'),
      ('HD', 'AAA'),
      ('8K', 'AA'),
      ('Full HD', 'AA');

insert into wall_brackets(adjustable)
values(true),
      (false),
      (true),
      (false),
      (true);

insert into ci_modules(type, brand)
values('CI+ module', 'LG'),
      ('CI+ module', 'Sony'),
      ('CI+ module', 'Samsung'),
      ('CI+ module', 'Panasonic'),
      ('CI+ module', 'Philips');


select
    p.name as product_name,
    p.brand as product_brand,
    p.price as product_price,
    t.type as television_type
from
    products p
        join
    televisions t on p.id = t.id;



