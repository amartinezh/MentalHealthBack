--    growPOS - Touch Friendly Point Of Sale
--    Copyright (c) 2019 uniCenta
--    http://www.growpos.co

/*
 * Script created by amartinez and ceul, growPos 16/07/2019 11:11:11.
 *
 * Creating for version gropos.0.01
*/

CREATE TABLE `applications` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`version` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `attribute` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `attributeinstance` (
	`id` varchar(255) NOT NULL,
	`attributesetinstance_id` varchar(255) NOT NULL,
	`attribute_id` varchar(255) NOT NULL,
	`value` varchar(255) default NULL,
	KEY `attinst_att` ( `attribute_id` ),
	KEY `attinst_set` ( `attributesetinstance_id` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `attributeset` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `attributesetinstance` (
	`id` varchar(255) NOT NULL,
	`attributeset_id` varchar(255) NOT NULL,
	`description` varchar(255) default NULL,
	KEY `attsetinst_set` ( `attributeset_id` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `attributeuse` (
	`id` varchar(255) NOT NULL,
	`attributeset_id` varchar(255) NOT NULL,
	`attribute_id` varchar(255) NOT NULL,
	`lineno` int(11) default NULL,
	KEY `attuse_att` ( `attribute_id` ),
	UNIQUE INDEX `attuse_line` ( `attributeset_id`, `lineno` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `attributevalue` (
	`id` varchar(255) NOT NULL,
	`attribute_id` varchar(255) NOT NULL,
	`value` varchar(255) default NULL,
	KEY `attval_att` ( `attribute_id` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `breaks` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`visible` tinyint(1) NOT NULL default '1',
	`notes` varchar(255) default NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `categories` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`parentid` varchar(255) default NULL,
	`image` mediumblob default NULL,
	`texttip` varchar(255) default NULL,
	`catshowname` smallint(6) NOT NULL default '1',
	`catorder` varchar(255) default NULL,
	KEY `categories_fk_1` ( `parentid` ),
	UNIQUE INDEX `categories_name_inx` ( `name` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `closedcash` (
	`money` varchar(255) NOT NULL,
	`host` varchar(255) NOT NULL,
	`hostsequence` int(11) NOT NULL,
	`datestart` datetime NOT NULL,
	`dateend` datetime default NULL,
	`nosales` int(11) NOT NULL default '0',
	KEY `closedcash_inx_1` ( `datestart` ),
	UNIQUE INDEX `closedcash_inx_seq` ( `host`, `hostsequence` ),
	PRIMARY KEY  ( `money` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `csvimport` (
	`id` varchar(255) NOT NULL,
	`rownumber` varchar(255) default NULL,
	`csverror` varchar(255) default NULL,
	`reference` varchar(255) default NULL,
	`code` varchar(255) default NULL,
	`name` varchar(255) default NULL,
	`pricebuy` double default NULL,
	`pricesell` double default NULL,
	`previousbuy` double default NULL,
	`previoussell` double default NULL,
	`category` varchar(255) default NULL,
	`tax` varchar(255) default NULL,
	`searchkey` varchar(255) default NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `customers` (
    `id` varchar(255) NOT NULL,
    `searchkey` varchar(255) NOT NULL,
    `taxid` varchar(255) default NULL,
    `name` varchar(255) NOT NULL,
    `taxcategory` varchar(255) default NULL,
    `card` varchar(255) default NULL,
    `maxdebt` double NOT NULL default '0',
    `address` varchar(255) default NULL,
    `address2` varchar(255) default NULL,
    `postal` varchar(255) default NULL,
    `city` varchar(255) default NULL,
    `region` varchar(255) default NULL,
    `country` varchar(255) default NULL,
    `firstname` varchar(255) default NULL,
    `lastname` varchar(255) default NULL,
    `email` varchar(255) default NULL,
    `phone` varchar(255) default NULL,
    `phone2` varchar(255) default NULL,
    `fax` varchar(255) default NULL,
    `notes` varchar(255) default NULL,
    `visible` bit(1) NOT NULL default b'1',
    `curdate` datetime default NULL,
    `curdebt` double default '0',
    `image` mediumblob default NULL,
    `isvip` bit(1) NOT NULL default b'0',
    `discount` double default '0',
    KEY `customers_card_inx` ( `card` ),
    KEY `customers_name_inx` ( `name` ),
    UNIQUE INDEX `customers_skey_inx` ( `searchkey` ),
    KEY `customers_taxcat` ( `taxcategory` ),
    KEY `customers_taxid_inx` ( `taxid` ),
    PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = DYNAMIC;

CREATE TABLE `draweropened` (
	`opendate` timestamp NOT NULL,
	`name` varchar(255) default NULL,
	`ticketid` varchar(255) default NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `floors` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`image` mediumblob default NULL,
	UNIQUE INDEX `floors_name_inx` ( `name` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `leaves` (
	`id` varchar(255) NOT NULL,
	`pplid` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`startdate` datetime NOT NULL,
	`enddate` datetime NOT NULL,
	`notes` varchar(255) default NULL,
	KEY `leaves_pplid` ( `pplid` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `lineremoved` (
	`removeddate` timestamp NOT NULL,
	`name` varchar(255) default NULL,
	`ticketid` varchar(255) default NULL,
	`productid` varchar(255) default NULL,
	`productname` varchar(255) default NULL,
	`units` double NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `locations` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`address` varchar(255) default NULL,
	UNIQUE INDEX `locations_name_inx` ( `name` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `moorers` (
	`vesselname` varchar(255) default NULL,
	`size` int(11) default NULL,
	`days` int(11) default NULL,
	`power` bit(1) NOT NULL default b'0'
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `payments` (
	`id` varchar(255) NOT NULL,
	`receipt` varchar(255) NOT NULL,
	`payment` varchar(255) NOT NULL,
	`total` double NOT NULL default '0',
	`tip` double default '0',
	`transid` varchar(255) default NULL,
	`isprocessed` bit(1) default b'0',
	`returnmsg` mediumblob default NULL,
	`notes` varchar(255) default NULL,
	`tendered` double default NULL,
	`cardname` varchar(255) default NULL,
        `voucher` varchar(255) default NULL,
	KEY `payments_fk_receipt` ( `receipt` ),
	KEY `payments_inx_1` ( `payment` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `people` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`apppassword` varchar(255) default NULL,
	`card` varchar(255) default NULL,
	`role` varchar(255) NOT NULL,
	`visible` bit(1) NOT NULL,
	`image` mediumblob default NULL,
	KEY `people_card_inx` ( `card` ),
	KEY `people_fk_1` ( `role` ),
	UNIQUE INDEX `people_name_inx` ( `name` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `pickup_number` (
	`id` int(11) NOT NULL default '0'
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `places` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`seats` varchar(6) NOT NULL DEFAULT '1',
	`x` int(11) NOT NULL,
	`y` int(11) NOT NULL,
	`floor` varchar(255) NOT NULL,
	`customer` varchar(255) default NULL,
	`waiter` varchar(255) default NULL,
	`ticketid` varchar(255) default NULL,
	`tablemoved` smallint(6) NOT NULL default '0',
	`width` int(11) NOT NULL,
	`height` int(11) NOT NULL,
    `guests` int(11) DEFAULT 0,
    `occupied` datetime DEFAULT NULL,
	UNIQUE INDEX `places_name_inx` ( `name` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `places`
  ADD type varchar(1) NOT NULL default 't'
    AFTER `occupied`;

CREATE TABLE `products` (
	`id` varchar(255) NOT NULL,
	`reference` varchar(255) NOT NULL,
	`code` varchar(255) NOT NULL,
	`codetype` varchar(255) default NULL,
	`name` varchar(255) NOT NULL,
	`pricebuy` double NOT NULL default '0',
	`pricesell` double NOT NULL default '0',
	`category` varchar(255) NOT NULL,
	`taxcat` varchar(255) NOT NULL,
	`attributeset_id` varchar(255) default NULL,
	`stockcost` double NOT NULL default '0',
	`stockvolume` double NOT NULL default '0',
	`image` mediumblob default NULL,
	`iscom` bit(1) NOT NULL default b'0',
	`isscale` bit(1) NOT NULL default b'0',
	`isconstant` bit(1) NOT NULL default b'0',
	`printkb` bit(1) NOT NULL default b'0',
	`sendstatus` bit(1) NOT NULL default b'0',
	`isservice` bit(1) NOT NULL default b'0',
	`attributes` mediumblob default NULL,
	`display` varchar(255) default NULL,
	`isvprice` smallint(6) NOT NULL default '0',
	`isverpatrib` smallint(6) NOT NULL default '0',
	`texttip` varchar(255) default NULL,
	`warranty` smallint(6) NOT NULL default '0',
	`stockunits` double NOT NULL default '0',
	`printto` varchar(255) default '1',
	`supplier` varchar(255) default NULL,
    `uom` varchar(255) default '0',
    `flag` bit(1) NOT NULL default b'0',
    `description` VARCHAR(2048),
    `short_description` VARCHAR(1024),
    `weigth` DOUBLE DEFAULT '0',
    `length` DOUBLE DEFAULT '0',
    `height` DOUBLE DEFAULT '0',
    `width` DOUBLE DEFAULT '0',

	PRIMARY KEY  ( `id` ),
	KEY `products_attrset_fx` ( `attributeset_id` ),
	KEY `products_fk_1` ( `category` ),
	UNIQUE INDEX `products_inx_0` ( `reference` ),
	UNIQUE INDEX `products_inx_1` ( `code` ),
	INDEX `products_name_inx` ( `name` ),
	KEY `products_taxcat_fk` ( `taxcat` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = DYNAMIC;

CREATE TABLE `products_bundle` (
    `id` varchar(255) NOT NULL,
    `product` VARCHAR(255) NOT NULL,
    `product_bundle` VARCHAR(255) NOT NULL,
    `quantity` DOUBLE NOT NULL,
    PRIMARY KEY ( `id` ),
    UNIQUE INDEX `pbundle_inx_prod` ( `product` , `product_bundle` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `products_cat` (
	`product` varchar(255) NOT NULL,
	`catorder` int(11) default NULL,
	PRIMARY KEY  ( `product` ),
	KEY `products_cat_inx_1` ( `catorder` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `products_com` (
	`id` varchar(255) NOT NULL,
	`product` varchar(255) NOT NULL,
	`product2` varchar(255) NOT NULL,
	UNIQUE INDEX `pcom_inx_prod` ( `product`, `product2` ),
	PRIMARY KEY  ( `id` ),
	KEY `products_com_fk_2` ( `product2` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `receipts` (
	`id` varchar(255) NOT NULL,
	`money` varchar(255) NOT NULL,
	`datenew` datetime NOT NULL,
	`attributes` mediumblob default NULL,
	`person` varchar(255) default NULL,
	PRIMARY KEY  ( `id` ),
	KEY `receipts_fk_money` ( `money` ),
	KEY `receipts_inx_1` ( `datenew` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `reservation_customers` (
	`id` varchar(255) NOT NULL,
	`customer` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` ),
	KEY `res_cust_fk_2` ( `customer` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `reservations` (
	`id` varchar(255) NOT NULL,
	`created` datetime NOT NULL,
	`datenew` datetime NOT NULL default '2015-01-01 00:00:00',
	`title` varchar(255) NOT NULL,
	`chairs` int(11) NOT NULL,
	`isdone` bit(1) NOT NULL,
	`description` varchar(255) default NULL,
	PRIMARY KEY  ( `id` ),
	KEY `reservations_inx_1` ( `datenew` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `resources` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`restype` int(11) default 0 NOT NULL,
	`content` mediumblob default NULL,
	PRIMARY KEY  ( `id` ),
	UNIQUE INDEX `resources_name_inx` ( `name` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `roles` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`permissions` mediumblob default NULL,
	PRIMARY KEY  ( `id` ),
	UNIQUE INDEX `roles_name_inx` ( `name` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `sharedtickets` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`content` mediumblob default NULL,
	`appuser` varchar(255) default NULL,
	`pickupid` smallint(6) NOT NULL default '0',
	`locked` varchar(20) default NULL,
        `products` VARCHAR (20480) default NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `shift_breaks` (
	`id` varchar(255) NOT NULL,
	`shiftid` varchar(255) NOT NULL,
	`breakid` varchar(255) NOT NULL,
	`starttime` timestamp NOT NULL,
	`endtime` timestamp NOT NULL,
	PRIMARY KEY  ( `id` ),
	KEY `shift_breaks_breakid` ( `breakid` ),
	KEY `shift_breaks_shiftid` ( `shiftid` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `shifts` (
	`id` varchar(255) NOT NULL,
	`startshift` datetime NOT NULL,
	`endshift` datetime default NULL,
	`pplid` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `stockcurrent` (
	`location` varchar(255) NOT NULL,
	`product` varchar(255) NOT NULL,
	`attributesetinstance_id` varchar(255) default NULL,
	`units` double NOT NULL,
	KEY `stockcurrent_attsetinst` ( `attributesetinstance_id` ),
	KEY `stockcurrent_fk_1` ( `product` ),
	UNIQUE INDEX `stockcurrent_inx` ( `location`, `product`, `attributesetinstance_id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `stockdiary` (
	`id` varchar(255) NOT NULL,
	`datenew` datetime NOT NULL,
	`reason` int(11) NOT NULL,
	`location` varchar(255) NOT NULL,
	`product` varchar(255) NOT NULL,
	`attributesetinstance_id` varchar(255) default NULL,
	`units` double NOT NULL,
	`price` double NOT NULL,
	`appuser` varchar(255) default NULL,
	`supplier` varchar(255) default NULL,
	`supplierdoc` varchar(255) default NULL,
	PRIMARY KEY  ( `id` ),
	KEY `stockdiary_attsetinst` ( `attributesetinstance_id` ),
	KEY `stockdiary_fk_1` ( `product` ),
	KEY `stockdiary_fk_2` ( `location` ),
	KEY `stockdiary_inx_1` ( `datenew` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `stocklevel` (
	`id` varchar(255) NOT NULL,
	`location` varchar(255) NOT NULL,
	`product` varchar(255) NOT NULL,
	`stocksecurity` double default NULL,
	`stockmaximum` double default NULL,
	PRIMARY KEY  ( `id` ),
	KEY `stocklevel_location` ( `location` ),
	KEY `stocklevel_product` ( `product` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `suppliers` (
	`id` varchar(255) NOT NULL,
	`searchkey` varchar(255) NOT NULL,
	`taxid` varchar(255) default NULL,
	`name` varchar(255) NOT NULL,
	`maxdebt` double NOT NULL default '0',
	`address` varchar(255) default NULL,
	`address2` varchar(255) default NULL,
	`postal` varchar(255) default NULL,
	`city` varchar(255) default NULL,
	`region` varchar(255) default NULL,
	`country` varchar(255) default NULL,
	`firstname` varchar(255) default NULL,
	`lastname` varchar(255) default NULL,
	`email` varchar(255) default NULL,
	`phone` varchar(255) default NULL,
	`phone2` varchar(255) default NULL,
	`fax` varchar(255) default NULL,
	`notes` varchar(255) default NULL,
	`visible` bit(1) NOT NULL default b'1',
	`curdate` datetime default NULL,
	`curdebt` double default '0',
	`vatid` varchar(255) default NULL,
	PRIMARY KEY  ( `id` ),
	KEY `suppliers_name_inx` ( `name` ),
	UNIQUE INDEX `suppliers_skey_inx` ( `searchkey` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = DYNAMIC;

CREATE TABLE `taxcategories` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` ),
	UNIQUE INDEX `taxcat_name_inx` ( `name` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `taxcustcategories` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` ),
	UNIQUE INDEX `taxcustcat_name_inx` ( `name` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `taxes` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`category` varchar(255) NOT NULL,
	`custcategory` varchar(255) default NULL,
	`parentid` varchar(255) default NULL,
	`rate` double NOT NULL default '0',
	`ratecascade` bit(1) NOT NULL default b'0',
	`rateorder` int(11) default NULL,
	PRIMARY KEY  ( `id` ),
	KEY `taxes_cat_fk` ( `category` ),
	KEY `taxes_custcat_fk` ( `custcategory` ),
	UNIQUE INDEX `taxes_name_inx` ( `name` ),
	KEY `taxes_taxes_fk` ( `parentid` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `taxlines` (
	`id` varchar(255) NOT NULL,
	`receipt` varchar(255) NOT NULL,
	`taxid` varchar(255) NOT NULL,
	`base` double NOT NULL default '0',
	`amount` double NOT NULL default '0',
	PRIMARY KEY  ( `id` ),
	KEY `taxlines_receipt` ( `receipt` ),
	KEY `taxlines_tax` ( `taxid` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `taxsuppcategories` (
	`id` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `thirdparties` (
	`id` varchar(255) NOT NULL,
	`cif` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`address` varchar(255) default NULL,
	`contactcomm` varchar(255) default NULL,
	`contactfact` varchar(255) default NULL,
	`payrule` varchar(255) default NULL,
	`faxnumber` varchar(255) default NULL,
	`phonenumber` varchar(255) default NULL,
	`mobilenumber` varchar(255) default NULL,
	`email` varchar(255) default NULL,
	`webpage` varchar(255) default NULL,
	`notes` varchar(255) default NULL,
	PRIMARY KEY  ( `id` ),
	UNIQUE INDEX `thirdparties_cif_inx` ( `cif` ),
	UNIQUE INDEX `thirdparties_name_inx` ( `name` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = DYNAMIC;

CREATE TABLE `ticketlines` (
	`ticket` varchar(255) NOT NULL,
	`line` int(11) NOT NULL,
	`product` varchar(255) default NULL,
	`attributesetinstance_id` varchar(255) default NULL,
	`units` double NOT NULL,
	`price` double NOT NULL,
	`taxid` varchar(255) NOT NULL,
	`attributes` mediumblob default NULL,
	PRIMARY KEY  ( `ticket`, `line` ),
	KEY `ticketlines_attsetinst` ( `attributesetinstance_id` ),
	KEY `ticketlines_fk_2` ( `product` ),
	KEY `ticketlines_fk_3` ( `taxid` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `tickets` (
	`id` varchar(255) NOT NULL,
	`tickettype` int(11) NOT NULL default '0',
	`ticketid` int(11) NOT NULL,
	`person` varchar(255) NOT NULL,
	`customer` varchar(255) default NULL,
	`status` int(11) NOT NULL default '0',
	PRIMARY KEY  ( `id` ),
	KEY `tickets_customers_fk` ( `customer` ),
	KEY `tickets_fk_2` ( `person` ),
	KEY `tickets_ticketid` ( `tickettype`, `ticketid` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `ticketsnum` (
	`id` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `ticketsnum_payment` (
	`id` int(11) NOT NULL,
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `ticketsnum_refund` (
	`id` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `uom` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `vouchers` (
   `id` VARCHAR(100) NOT NULL,
   `voucher_number` VARCHAR(100) DEFAULT NULL,
   `customer` VARCHAR(100) DEFAULT NULL,
   `amount` DOUBLE DEFAULT NULL,
   `status` CHAR(1) DEFAULT 'A',
  PRIMARY KEY ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `credit_note` (
    `id` INT NOT NULL AUTO_INCREMENT,
	`receipt` varchar(255) NOT NULL,
	`date` datetime NOT NULL,
    `note` varchar(255),
    `state` bit(1) NOT NULL default b'1',
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `datenew` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` varchar(255) DEFAULT NULL,
  `type` varchar(2) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `log_fk_user` (`user`),
  CONSTRAINT `log_fk_user` FOREIGN KEY (`user`) REFERENCES `people` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Update foreign keys of attributeinstance
ALTER TABLE `attributeinstance` ADD CONSTRAINT `attinst_att`
	FOREIGN KEY ( `attribute_id` ) REFERENCES `attribute` ( `id` );

ALTER TABLE `attributeinstance` ADD CONSTRAINT `attinst_set`
	FOREIGN KEY ( `attributesetinstance_id` ) REFERENCES `attributesetinstance` ( `id` ) ON DELETE CASCADE;

-- Update foreign keys of attributesetinstance
ALTER TABLE `attributesetinstance` ADD CONSTRAINT `attsetinst_set`
	FOREIGN KEY ( `attributeset_id` ) REFERENCES `attributeset` ( `id` ) ON DELETE CASCADE;

-- Update foreign keys of attributeuse
ALTER TABLE `attributeuse` ADD CONSTRAINT `attuse_att`
	FOREIGN KEY ( `attribute_id` ) REFERENCES `attribute` ( `id` );

ALTER TABLE `attributeuse` ADD CONSTRAINT `attuse_set`
	FOREIGN KEY ( `attributeset_id` ) REFERENCES `attributeset` ( `id` ) ON DELETE CASCADE;

-- Update foreign keys of attributevalue
ALTER TABLE `attributevalue` ADD CONSTRAINT `attval_att`
	FOREIGN KEY ( `attribute_id` ) REFERENCES `attribute` ( `id` ) ON DELETE CASCADE;

-- Update foreign keys of categories
ALTER TABLE `categories` ADD CONSTRAINT `CATEGORIES_FK_1`
	FOREIGN KEY ( `parentid` ) REFERENCES `categories` ( `id` );

-- Update foreign keys of customers
ALTER TABLE `customers` ADD CONSTRAINT `customers_taxcat`
	FOREIGN KEY ( `taxcategory` ) REFERENCES `taxcustcategories` ( `id` );

-- Update foreign keys of leaves
ALTER TABLE `leaves` ADD CONSTRAINT `leaves_pplid`
	FOREIGN KEY ( `pplid` ) REFERENCES `people` ( `id` );

-- Update foreign keys of payments
ALTER TABLE `payments` ADD CONSTRAINT `payments_fk_receipt`
	FOREIGN KEY ( `receipt` ) REFERENCES `receipts` ( `id` );

-- Update foreign keys of people
ALTER TABLE `people` ADD CONSTRAINT `people_fk_1`
	FOREIGN KEY ( `role` ) REFERENCES `roles` ( `id` );

-- Update foreign keys of products
ALTER TABLE `products` ADD CONSTRAINT `products_attrset_fk`
	FOREIGN KEY ( `attributeset_id` ) REFERENCES `attributeset` ( `id` );

ALTER TABLE `products` ADD CONSTRAINT `products_fk_1`
	FOREIGN KEY ( `category` ) REFERENCES `categories` ( `id` );

ALTER TABLE `products` ADD CONSTRAINT `products_taxcat_fk`
	FOREIGN KEY ( `taxcat` ) REFERENCES `taxcategories` ( `id` );

-- Update foreign keys of product_bundle
ALTER TABLE `products_bundle` ADD CONSTRAINT `products_bundle_fk_1` 
        FOREIGN KEY ( `product` ) REFERENCES `products`( `id` );

ALTER TABLE `products_bundle` ADD CONSTRAINT `products_bundle_fk_2`     
        FOREIGN KEY ( `product_bundle` ) REFERENCES `products`( `id` );

-- Update foreign keys of products_cat
ALTER TABLE `products_cat` ADD CONSTRAINT `products_cat_fk_1`
	FOREIGN KEY ( `product` ) REFERENCES `products` ( `id` );

-- Update foreign keys of products_com
ALTER TABLE `products_com` ADD CONSTRAINT `products_com_fk_1`
	FOREIGN KEY ( `product` ) REFERENCES `products` ( `id` );

ALTER TABLE `products_com` ADD CONSTRAINT `products_com_fk_2`
	FOREIGN KEY ( `product2` ) REFERENCES `products` ( `id` );

-- Update foreign keys of receipts
ALTER TABLE `receipts` ADD CONSTRAINT `receipts_fk_money`
	FOREIGN KEY ( `money` ) REFERENCES `closedcash` ( `money` );

-- Update foreign keys of reservation_customers
ALTER TABLE `reservation_customers` ADD CONSTRAINT `res_cust_fk_1`
	FOREIGN KEY ( `id` ) REFERENCES `reservations` ( `id` );

ALTER TABLE `reservation_customers` ADD CONSTRAINT `res_cust_fk_2`
	FOREIGN KEY ( `customer` ) REFERENCES `customers` ( `id` );

-- Update foreign keys of shift_breaks
ALTER TABLE `shift_breaks` ADD CONSTRAINT `shift_breaks_breakid`
	FOREIGN KEY ( `breakid` ) REFERENCES `breaks` ( `id` );

ALTER TABLE `shift_breaks` ADD CONSTRAINT `shift_breaks_shiftid`
	FOREIGN KEY ( `shiftid` ) REFERENCES `shifts` ( `id` );

-- Update foreign keys of stockcurrent
ALTER TABLE `stockcurrent` ADD CONSTRAINT `stockcurrent_attsetinst`
	FOREIGN KEY ( `attributesetinstance_id` ) REFERENCES `attributesetinstance` ( `id` );

ALTER TABLE `stockcurrent` ADD CONSTRAINT `stockcurrent_fk_1`
	FOREIGN KEY ( `product` ) REFERENCES `products` ( `id` );

ALTER TABLE `stockcurrent` ADD CONSTRAINT `stockcurrent_fk_2`
	FOREIGN KEY ( `location` ) REFERENCES `locations` ( `id` );

-- Update foreign keys of stockdiary
ALTER TABLE `stockdiary` ADD CONSTRAINT `stockdiary_attsetinst`
	FOREIGN KEY ( `attributesetinstance_id` ) REFERENCES `attributesetinstance` ( `id` );

ALTER TABLE `stockdiary` ADD CONSTRAINT `stockdiary_fk_1`
	FOREIGN KEY ( `product` ) REFERENCES `products` ( `id` );

ALTER TABLE `stockdiary` ADD CONSTRAINT `stockdiary_fk_2`
	FOREIGN KEY ( `location` ) REFERENCES `locations` ( `id` );

-- Update foreign keys of stocklevel
ALTER TABLE `stocklevel` ADD CONSTRAINT `stocklevel_location`
	FOREIGN KEY ( `location` ) REFERENCES `locations` ( `id` );

ALTER TABLE `stocklevel` ADD CONSTRAINT `stocklevel_product`
	FOREIGN KEY ( `product` ) REFERENCES `products` ( `id` );

-- Update foreign keys of taxes
ALTER TABLE `taxes` ADD CONSTRAINT `taxes_cat_fk`
	FOREIGN KEY ( `category` ) REFERENCES `taxcategories` ( `id` );

ALTER TABLE `taxes` ADD CONSTRAINT `taxes_custcat_fk`
	FOREIGN KEY ( `custcategory` ) REFERENCES `taxcustcategories` ( `id` );

ALTER TABLE `taxes` ADD CONSTRAINT `taxes_taxes_fk`
	FOREIGN KEY ( `parentid` ) REFERENCES `taxes` ( `id` );

-- Update foreign keys of taxlines
ALTER TABLE `taxlines` ADD CONSTRAINT `taxlines_receipt`
	FOREIGN KEY ( `receipt` ) REFERENCES `receipts` ( `id` );

ALTER TABLE `taxlines` ADD CONSTRAINT `taxlines_tax`
	FOREIGN KEY ( `taxid` ) REFERENCES `taxes` ( `id` );

-- Update foreign keys of ticketlines
ALTER TABLE `ticketlines` ADD CONSTRAINT `ticketlines_attsetinst`
	FOREIGN KEY ( `attributesetinstance_id` ) REFERENCES `attributesetinstance` ( `id` );

ALTER TABLE `ticketlines` ADD CONSTRAINT `ticketlines_fk_2`
	FOREIGN KEY ( `product` ) REFERENCES `products` ( `id` );

ALTER TABLE `ticketlines` ADD CONSTRAINT `ticketlines_fk_3`
	FOREIGN KEY ( `taxid` ) REFERENCES `taxes` ( `id` );

ALTER TABLE `ticketlines` ADD CONSTRAINT `ticketlines_fk_ticket`
	FOREIGN KEY ( `ticket` ) REFERENCES `tickets` ( `id` );

-- Update foreign keys of tickets
ALTER TABLE `tickets` ADD CONSTRAINT `tickets_customers_fk`
	FOREIGN KEY ( `customer` ) REFERENCES `customers` ( `id` );

ALTER TABLE `tickets` ADD CONSTRAINT `tickets_fk_2`
	FOREIGN KEY ( `person` ) REFERENCES `people` ( `id` );

ALTER TABLE `tickets` ADD CONSTRAINT `tickets_fk_id`
	FOREIGN KEY ( `id` ) REFERENCES `receipts` ( `id` );

ALTER TABLE `credit_note` ADD CONSTRAINT `credit_note_recepits_fk`
	FOREIGN KEY ( `receipt` ) REFERENCES `receipts` ( `id` );

-- ADD resources --
-- MENU
INSERT INTO resources(id, name, restype, content) VALUES('0', 'Menu.Root', 0, '');

-- IMAGES
INSERT INTO resources(id, name, restype, content) VALUES('1', 'moneda-100', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('2', 'moneda-200', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('3', 'moneda-500', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('4', 'moneda-1000', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('5', 'moneda-50', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('6', 'img.cash', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('7', 'img.cashdrawer', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('8', 'img.discount', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('9', 'img.discount_b', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('10', 'img.empty', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('11', 'img.heart', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('12', 'img.keyboard_32', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('13', 'img.kit_print', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('14', 'img.no_photo', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('15', 'img.refundit', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('16', 'img.run_script', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('17', 'img.ticket_print', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('18', 'img.user', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('19', 'billete-1000', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('20', 'billete-2000', 1,'');
INSERT INTO resources(id, name, restype, content) VALUES('21', 'billete-5000', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('22', 'billete-10000', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('23', 'billete-20000', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('24', 'billete-50000', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('25', 'billete-100000', 1, '');
-- PRINTER
INSERT INTO resources(id, name, restype, content) VALUES('26', 'Printer.CloseCash.Preview', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('27', 'Printer.CloseCash', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('28', 'Printer.CustomerPaid', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('29', 'Printer.CustomerPaid2', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('30', 'Printer.FiscalTicket', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('31', 'Printer.Inventory', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('32', 'Printer.OpenDrawer', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('33', 'Printer.PartialCash', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('34', 'Printer.PrintLastTicket', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('35', 'Printer.Product', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('36', 'Printer.ReprintTicket', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('37', 'Printer.Start', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('38', 'Printer.Ticket.P1', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('39', 'Printer.Ticket.P2', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('40', 'Printer.Ticket.P3', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('41', 'Printer.Ticket.P4', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('42', 'Printer.Ticket.P5', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('43', 'Printer.Ticket.P6', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('44', 'Printer.Ticket', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('45', 'Printer.Ticket2', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('46', 'Printer.TicketClose', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('47', 'Printer.TicketRemote', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('48', 'Printer.TicketLine', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('49', 'Printer.TicketNew', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('50', 'Printer.TicketPreview', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('51', 'Printer.TicketTotal', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('52', 'Printer.Ticket.Logo', 1, '');

-- SCRIPTS
INSERT INTO resources(id, name, restype, content) VALUES('53', 'script.AddLineNote', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('54', 'script.Event.Total', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('55', 'script.Keyboard', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('56', 'script.linediscount', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('57', 'script.ReceiptConsolidate', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('58', 'script.Refundit', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('59', 'script.SendOrder', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('60', 'script.ServiceCharge', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('61', 'script.SetPerson', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('62', 'script.StockCurrentAdd', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('63', 'script.StockCurrentSet', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('64', 'script.totaldiscount', 0, '');

-- SYSTEM
INSERT INTO resources(id, name, restype, content) VALUES('65', 'payment.cash', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('66', 'ticket.addline', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('67', 'ticket.change', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('68', 'Ticket.Buttons', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('69', 'Ticket.Close', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('70', 'Ticket.Discount', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('71', 'Ticket.Line', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('72', 'ticket.removeline', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('73', 'ticket.setline', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('74', 'Ticket.TicketLineTaxesIncluded', 0, '');
INSERT INTO resources(id, name, restype, content) VALUES('75', 'Window.Logo', 1, '');
INSERT INTO resources(id, name, restype, content) VALUES('76', 'Window.Title', 0, '');

-- ADD CATEGORIES
INSERT INTO categories(id, name) VALUES ('000', 'Categoria Estandar');

-- ADD TAXCATEGORIES
INSERT INTO taxcategories(id, name) VALUES ('000', 'Excento de Impuestos');
INSERT INTO taxcategories(id, name) VALUES ('001', 'IVA');
INSERT INTO taxcategories(id, name) VALUES ('002', 'Impuesto al consumo');

-- ADD TAXES
INSERT INTO taxes(id, name, category, custcategory, parentid, rate, ratecascade, rateorder) VALUES ('000', 'Sin Impuestos', '000', NULL, NULL, 0, FALSE, NULL);
INSERT INTO taxes(id, name, category, custcategory, parentid, rate, ratecascade, rateorder) VALUES ('001', 'IVA', '001', NULL, NULL, 0.19, FALSE, NULL);
INSERT INTO taxes(id, name, category, custcategory, parentid, rate, ratecascade, rateorder) VALUES ('002', 'Impuesto al consumo', '002', NULL, NULL, 0.19, FALSE, NULL);

-- ADD PRODUCTS
INSERT INTO products(id, reference, code, name, category, taxcat, isservice, display, printto) 
VALUES ('xxx998_998xxx_x8x8x8', 'xxx998', 'xxx998', 'Propina', '000', '000', 1, '<html><center>Propina', '1');

-- ADD PRODUCTS_CAT
INSERT INTO products_cat(product) VALUES ('xxx998_998xxx_x8x8x8');

-- ADD LOCATION
INSERT INTO locations(id, name, address) VALUES ('0','Ubicacion 1','Local');

-- ADD SUPPLIERS
INSERT INTO suppliers(id, searchkey, name) VALUES ('0','GrowPOS','GrowPOS');

-- ADD UOM
INSERT INTO uom(id, name) VALUES ('0','Unidad');
INSERT INTO uom(id, name) VALUES ('1','Minuto');
INSERT INTO uom(id, name) VALUES ('2','Hora');
INSERT INTO uom(id, name) VALUES ('3','Dia');

-- ADD FLOORS
INSERT INTO floors(id, name, image, type) VALUES ('0', 'Piso del Restaurante', '', 't');
INSERT INTO floors(id, name, image, type) VALUES ('1', 'Piso del Parqueadero', '', 'p');

-- ADD PLACES
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('1', 'Mesa 1', 100, 50, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('2', 'Mesa 2', 250, 50, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('3', 'Mesa 3', 400, 50, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('4', 'Mesa 4', 550, 50, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('5', 'Mesa 5', 700, 50, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('6', 'Mesa 6', 850, 50, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('7', 'Mesa 7', 100, 150, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('8', 'Mesa 8', 250, 150, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('9', 'Mesa 9', 400, 150, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('10', 'Mesa 10', 550, 150, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('11', 'Mesa 11', 700, 150, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('12', 'Mesa 12', 850, 150, '0', '1', 90, 45, 't');

INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('13', 'Mesa 13', 100, 250, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('14', 'Mesa 14', 250, 250, '0', '1', 90, 45, 't');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('15', 'Mesa 15', 400, 250, '0', '1', 90, 45, 't');

INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('p01', 'Lugar 1', 100, 250, '1', '1', 90, 45, 'p');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('p02', 'Lugar 2', 250, 250, '1', '1', 90, 45, 'p');
INSERT INTO places(id, name, x, y, floor, seats, width, height, type) VALUES ('p03', 'Lugar 3', 400, 250, '1', '1', 90, 45, 'p');

-- ADD SHIFTS
INSERT INTO shifts(id, startshift, endshift, pplid) VALUES ('0', '2020-01-01 00:00:00.001', '2020-01-01 00:00:00.002','0');

-- ADD BREAKS
INSERT INTO breaks(id, name, visible, notes) VALUES ('0', 'Descanso de almuerzo', TRUE, NULL);
INSERT INTO breaks(id, name, visible, notes) VALUES ('1', 'Descanso del algo', TRUE, NULL);
INSERT INTO breaks(id, name, visible, notes) VALUES ('2', 'Descanso de medio tiempo', TRUE, NULL);

-- ADD SHIFT_BREAKS
INSERT INTO shift_breaks(id, shiftid, breakid, starttime, endtime) VALUES ('0', '0', '0', '2020-01-01 00:00:00.003', '2020-01-01 00:00:00.004');

-- ADD SEQUENCES
INSERT INTO pickup_number VALUES(1);
INSERT INTO ticketsnum VALUES(1);
INSERT INTO ticketsnum_refund VALUES(1);
INSERT INTO ticketsnum_payment VALUES(1);

-- ADD APPLICATION VERSION
-- INSERT INTO applications(id, name, version) VALUES($APP_ID{}, $APP_NAME{}, $APP_VERSION{});

-- Version 0.01

ALTER TABLE categories ADD COLUMN type VARCHAR(1);


----------------------------------------------------------------------

CREATE TABLE `parkingfee` (
	`id` VARCHAR(255) NOT NULL,
	`type` VARCHAR(255) NOT NULL,
	`rate` VARCHAR(255) NOT NULL,
	`starttime` TIME default NULL,
	`endtime` TIME default NULL,
	`graceperiod` INT(11) default 0,
	`time` INT (11) NOT NULL,
	`isMonthly` bit(1) NOT NULL default b'0',
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `parkingfee` ADD CONSTRAINT `type_fk`
	FOREIGN KEY ( `type` ) REFERENCES `categories` ( `id` );

ALTER TABLE `parkingfee` ADD CONSTRAINT `rate_fk`
	FOREIGN KEY ( `rate` ) REFERENCES `products` ( `id` );

CREATE TABLE `parking_mov` (
    `id` INT NOT NULL AUTO_INCREMENT,
	`places` varchar(255) NOT NULL,
	`plate` varchar(255) NOT NULL,
	`receipt` varchar(255) NOT NULL,
	`date_arrival` datetime NOT NULL,
	`date_departure` datetime NOT NULL,
	`type` varchar(255) NOT NULL,
	`fee` varchar(255) NOT NULL,
    `note` varchar(255),
    `state` bit(1) NOT NULL default b'1',
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `vehicles` (
	`id` varchar(255) NOT NULL,
	`plate` varchar(8) NOT NULL,
	`model` varchar(32) DEFAULT NULL,
	`color` varchar(32) DEFAULT NULL,
	`description` varchar(255) DEFAULT NULL,
	`type` varchar(255) NOT NULL,
	KEY `plate_vehicle` ( `plate` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;


CREATE TABLE `contract` (
	`id` varchar(255) NOT NULL,
	`customer` varchar(255) NOT NULL,
	`datestart` datetime NOT NULL,
	`price` double default 0,
	`vehicle` varchar(255) NOT NULL,
	`state` int(11) default NULL,
	KEY `vehic_contract` ( `vehicle` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `vehicles` ADD CONSTRAINT `vehicles_type_fk`     
        FOREIGN KEY ( `type` ) REFERENCES `categories`( `id` );

ALTER TABLE `contract` ADD CONSTRAINT `contract_customer_fk`     
        FOREIGN KEY ( `customer` ) REFERENCES `customers`( `id` );
        
ALTER TABLE `contract` ADD CONSTRAINT `contract_vehicle_fk`     
        FOREIGN KEY ( `vehicle` ) REFERENCES `vehicles`( `id` );

ALTER TABLE `parking_mov` ADD CONSTRAINT `parking_mov_type_fk`     
        FOREIGN KEY ( `type` ) REFERENCES `categories`( `id` );
        
/*ALTER TABLE `parking_mov` ADD CONSTRAINT `parking_mov_fee_fk`     
        FOREIGN KEY ( `fee` ) REFERENCES `products`( `id` );*/


CREATE TABLE `rel_contract_ticket` (
	`id` varchar(255) NOT NULL,
	`contract` varchar(255) NOT NULL,
	`ticket` varchar(255) NOT NULL,
	KEY `contract_rel_contract_ticket` ( `contract` ),
	PRIMARY KEY  ( `id` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;
        
ALTER TABLE `rel_contract_ticket` ADD CONSTRAINT `rel_contract_ticket_contract_fk`     
        FOREIGN KEY ( `contract` ) REFERENCES `contract`( `id` );

ALTER TABLE `rel_contract_ticket` ADD CONSTRAINT `rel_contract_ticket_ticket_fk`     
        FOREIGN KEY ( `ticket` ) REFERENCES `tickets`( `id` );

CREATE TABLE `orders` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`state` varchar(2) NOT NULL,
	`type` varchar(2) NOT NULL,
	`start_date` datetime NOT NULL,
	`end_date` datetime,
	`user` VARCHAR(255) NOT NULL,
	`external_id` VARCHAR(255) NOT NULL,
	PRIMARY KEY  ( `id` )
)ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `order_type`(
	`id` varchar(255) NOT NULL,
	`name` varchar(32) NOT NULL,
	PRIMARY KEY  ( `id` )
)ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `order_state`(
	`id` varchar(255) NOT NULL,
	`name` varchar(32) NOT NULL,
	PRIMARY KEY  ( `id` )
)ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `orders` ADD CONSTRAINT `orders_user_fk`     
        FOREIGN KEY ( `user` ) REFERENCES `tickets`( `id` );

ALTER TABLE `orders` ADD CONSTRAINT `orders_type_fk`     
        FOREIGN KEY ( `type` ) REFERENCES `order_type`( `id` );

ALTER TABLE `orders` ADD CONSTRAINT `orders_state_fk`     
        FOREIGN KEY ( `state` ) REFERENCES `order_state`( `id` );

CREATE TABLE `rel_product_order`(
	`id` VARCHAR(255) NOT NULL,
	`product` VARCHAR(255) NOT NULL,
	`order` INT NOT NULL,
	`note` VARCHAR(255) ,
	`qty` INT NOT NULL,
	PRIMARY KEY  ( `id` )
)ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `rel_product_order` ADD CONSTRAINT `rel_product_order_product_fk`     
        FOREIGN KEY ( `product` ) REFERENCES `products`( `id` );

ALTER TABLE `rel_product_order` ADD CONSTRAINT `rel_product_order_order_fk`     
        FOREIGN KEY ( `order` ) REFERENCES `orders`( `id` );

INSERT INTO `order_state` (`id`, `name`) VALUES ('1', 'PROCESS');
INSERT INTO `order_state` (`id`, `name`) VALUES ('2', 'READY');
INSERT INTO `order_state` (`id`, `name`) VALUES ('3', 'ON_DELIVERY');
INSERT INTO `order_state` (`id`, `name`) VALUES ('4', 'FINISH');

INSERT INTO `order_type` (`id`, `name`) VALUES ('1', 'TABLE');
INSERT INTO `order_type` (`id`, `name`) VALUES ('2', 'DELIVERY');
INSERT INTO `order_type` (`id`, `name`) VALUES ('3', 'BAR');

CREATE TABLE `notifications` (
	`id` VARCHAR(255) NOT NULL,
	`type` VARCHAR(2) NOT NULL,
	`content` mediumblob NOT NULL,
	PRIMARY KEY  ( `id` )
)ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE external_platform(
	id VARCHAR(255) NOT NULL,
	name VARCHAR(32) NOT NULL,
	version VARCHAR(16) NOT NULL,
	url VARCHAR(100) NOT NULL,
	token VARCHAR(255),
	api_key VARCHAR(255) NOT NULL,
	PRIMARY KEY  ( `id` )
)ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

-- Version 0.02
-- GrowAccounting

CREATE TABLE `third_party_type` (
	`id_third_party_type` INT NOT NULL AUTO_INCREMENT,
	`description` varchar(255) NOT NULL,
	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_third_party_type` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

INSERT INTO `third_party_type`(description, state) VALUES('Cliente', 1);

RENAME TABLE `customers` TO `third_party`;

ALTER TABLE `third_party` ADD COLUMN `id_third_party_type` INT NOT NULL;
UPDATE `third_party` SET `id_third_party_type`= 1;

ALTER TABLE `third_party` ADD COLUMN `id_people` varchar(255);

ALTER TABLE `third_party` ADD CONSTRAINT `customers_fk_people` FOREIGN KEY ( `id_people` ) REFERENCES `people` ( `id` );
ALTER TABLE `third_party` ADD CONSTRAINT `third_party_fk_third_party_type`  FOREIGN KEY (`id_third_party_type`)  REFERENCES `third_party_type` (`id_third_party_type`);

CREATE TABLE `_branch_offices` (
	`id_branch_office` INT NOT NULL AUTO_INCREMENT,
	`description` varchar(255) NOT NULL,
	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_branch_office` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `_account_types` (
	`id_account_type` INT NOT NULL AUTO_INCREMENT,
	`description` varchar(255) NOT NULL,
	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_account_type` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `_banks` (
   `id_bank` varchar(128) NOT NULL,
   `description` varchar(255) DEFAULT NULL,
   `state` bit(1) default b'1' COMMENT '1: Active, 0: Inactive',
  PRIMARY KEY ( `id_bank` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `_cost_centers` (
	`id_cost_center` INT NOT NULL AUTO_INCREMENT,
	`description` varchar(255) NOT NULL,
	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_cost_center` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `_niif_concepts` (
	`id_niif_concept` varchar(255) NOT NULL,
	`id_father` varchar(255) NOT NULL,
	`description` varchar(255) NOT NULL,
	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_niif_concept` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `_attributes` (
	`id_attribute` varchar(255) NOT NULL,
	`description` varchar(255) NOT NULL,
	`type` bit(1) NOT NULL default b'1' COMMENT '1: Alphanumeric, 0: Numeric',
	PRIMARY KEY  ( `id_attribute` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `_accounts` (
  `id_account` varchar(128) NOT NULL,
  `id_father` varchar(128) NOT NULL,
  `id_account_type` int NOT NULL,
  `id_branch_office` int NOT NULL,
  `id_niif_concept` varchar(255) NOT NULL,
  `id_cost_center` int NOT NULL,
  `allows_transact` bit(1) NOT NULL default b'1' COMMENT '1: Yes, 0: No',
  `minimum_base` int default 0,
  `description` varchar(255) NOT NULL,
  `sign` bit(1) NOT NULL default b'1' COMMENT '1: Positive, 0: Negative',
  `state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
  PRIMARY KEY (`id_account`)
) ENGINE=InnoDB AUTO_INCREMENT=3910 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

ALTER TABLE `_accounts` ADD CONSTRAINT `account_fk_account_type` FOREIGN KEY (`id_account_type`) REFERENCES `_account_types` (`id_account_type`);
ALTER TABLE `_accounts` ADD CONSTRAINT `account_fk_branch_office` FOREIGN KEY (`id_branch_office`) REFERENCES `_branch_offices` (`id_branch_office`);

ALTER TABLE `_accounts` ADD CONSTRAINT `account_fk_niif_concepts` FOREIGN KEY (`id_niif_concept`) REFERENCES `_niif_concepts` (`id_niif_concept`);
ALTER TABLE `_accounts` ADD CONSTRAINT `account_fk_cost_centers`  FOREIGN KEY (`id_cost_center`)  REFERENCES `_cost_centers` (`id_cost_center`);

CREATE TABLE `_attributes_accounts` (
  `id_account` varchar(255) NOT NULL,
  `id_attribute` varchar(128) NOT NULL,
  PRIMARY KEY (`id_account`, `id_attribute`)
) ENGINE=InnoDB AUTO_INCREMENT=3910 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

ALTER TABLE `_attributes_accounts` ADD CONSTRAINT `attributes_accounts_fk_account` FOREIGN KEY (`id_account`) REFERENCES `_accounts` (`id_account`);
ALTER TABLE `_attributes_accounts` ADD CONSTRAINT `attributes_accounts_fk_attribute` FOREIGN KEY (`id_attribute`) REFERENCES `_attributes` (`id_attribute`);

CREATE TABLE `_accounts_banks` (
  `account_number` varchar(255) NOT NULL,
  `id_bank` varchar(128) NOT NULL,
  `id_account` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=3910 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

ALTER TABLE `_accounts_banks` ADD CONSTRAINT `account_banks_fk_banks` FOREIGN KEY (`id_bank`) REFERENCES `_banks` (`id_bank`);
ALTER TABLE `_accounts_banks` ADD CONSTRAINT `account_banks_fk_accounts` FOREIGN KEY (`id_account`) REFERENCES `_accounts` (`id_account`);

CREATE TABLE `_movements` (
	`id_movement` INT NOT NULL AUTO_INCREMENT,
	`id_third_party` varchar(255) NOT NULL,
	`date` datetime NOT NULL,
	`description` varchar(255) NOT NULL,
  	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_movement` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `_movements` ADD CONSTRAINT `movements_fk_third_party` FOREIGN KEY (`id_third_party`) REFERENCES `third_party` (`id`);

CREATE TABLE `_movement_row` (
	`id_movement_row` INT NOT NULL AUTO_INCREMENT,
	`id_movement` INT NOT NULL,
	`id_account` varchar(128) NOT NULL,
	`sign` bit(1) NOT NULL default b'1' COMMENT '1: Positive, 0: Negative',
  	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_movement_row` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `_movement_row` ADD CONSTRAINT `movement_row_fk_account` FOREIGN KEY (`id_account`) REFERENCES `_accounts` (`id_account`);
ALTER TABLE `_movement_row` ADD CONSTRAINT `movement_row_fk_movement` FOREIGN KEY (`id_movement`) REFERENCES `_movements` (`id_movement`);

CREATE TABLE `_movement_attributes` (
	`id_movement_attributes` INT NOT NULL AUTO_INCREMENT,
	`id_movement_row` INT NOT NULL,
	`id_attribute` varchar(128) NOT NULL,
	`note` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id_movement_attributes` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `_movement_attributes` ADD CONSTRAINT `movement_attributes_fk_movement_row` FOREIGN KEY (`id_movement_row`) REFERENCES `_movement_row` (`id_movement_row`);
ALTER TABLE `_movement_attributes` ADD CONSTRAINT `movement_attributes_fk_attributes` FOREIGN KEY (`id_attribute`) REFERENCES `_attributes` (`id_attribute`);

CREATE TABLE `permissions` (
	`id_permission` int NOT NULL,
	`father` int NOT NULL,
	`level` INT NOT NULL,
	`name` varchar(64) NOT NULL,
	`icon` varchar(64) NOT NULL,
	`url` varchar(128) NOT NULL,
	PRIMARY KEY  ( `id_permission` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `people`
	DROP FOREIGN KEY `people_fk_1`;

DROP TABLE roles;

CREATE TABLE `roles` (
	`id` int NOT NULL,
	`name` varchar(64) NOT NULL,
	PRIMARY KEY  ( `id` ),
	UNIQUE INDEX `roles_name_inx` ( `name` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

CREATE TABLE `people_roles` (
	`id_people` varchar(255) NOT NULL,
	`id_rol` int NOT NULL,
	PRIMARY KEY  ( `id_people` , `id_rol`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `people_roles` ADD CONSTRAINT `people_roles_fk_people` FOREIGN KEY (`id_people`) REFERENCES `people` (`id`);
ALTER TABLE `people_roles` ADD CONSTRAINT `people_roles_fk_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);

CREATE TABLE `permissions_roles` (
	`id_permission` int NOT NULL,
	`id_rol` int NOT NULL,
	PRIMARY KEY  ( `id_permission` , `id_rol`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `permissions_roles` ADD CONSTRAINT `permissions_roles_fk_permissions` FOREIGN KEY (`id_permission`) REFERENCES `permissions` (`id_permission`);
ALTER TABLE `permissions_roles` ADD CONSTRAINT `permissions_roles_fk_roles` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);

ALTER TABLE `people` DROP `role`;

INSERT INTO roles(id, name) VALUES(00, 'SuperUser');
INSERT INTO roles(id, name) VALUES(11, 'Administrador POS');
INSERT INTO roles(id, name) VALUES(12, 'Empleado POS');
INSERT INTO roles(id, name) VALUES(13, 'Invitado POS');
INSERT INTO roles(id, name) VALUES(21, 'Administrador Parking');
INSERT INTO roles(id, name) VALUES(22, 'Empleado Parking');
INSERT INTO roles(id, name) VALUES(23, 'Invitado Parking');
INSERT INTO roles(id, name) VALUES(31, 'Contador');
INSERT INTO roles(id, name) VALUES(34, 'Auxiliar Contable');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(1, -1, 0, 'Principal', 'icon-basket-loaded', '-');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(2, -1, 0, 'Administracion', 'icon-settings', '-');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(3, -1, 0, 'Parqueadero', 'icon-flag', '-');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(4, -1, 0, 'Contabilidad', 'icon-loop', '-');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(11, 1, 1, 'Ventas', 'icon-basket', '/sales');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(12, 1, 1, 'Pagos de clientes', 'icon-user-follow', '/customer/customer-payments');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(13, 1, 1, 'Movimientos de caja', 'icon-handbag', '/close-cash/cash-movement');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(14, 1, 1, 'Cierre de caja', 'icon-calculator', '/close-cash');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(15, 1, 1, 'Facturas', 'icon-book-open', '/close-cash/receipts');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(16, 1, 1, 'Ordenes', 'icon-basket', '/orders');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(17, 1, 1, 'Ordenes Listas', 'icon-basket', '/orders/list-ready');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(21, 2, 1, 'Proveedores', 'icon-user', '/supplier');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(22, 2, 1, 'Clientes', 'icon-user', '/customer');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(23, 2, 1, 'Inventario', 'icon-home', '/stock');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(24, 2, 1, 'Reportes de Ventas', 'icon-basket', '/sales/menu');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(25, 2, 1, 'Mantenimiento', 'icon-wrench', '/maintenance');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(26, 2, 1, 'Configuración', 'icon-settings', '/configuration');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(31, 3, 1, 'Ingreso', 'icon-arrow-right', '/parking/places/p');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(32, 3, 1, 'Vehiculos', 'icon-rocket ', '/parking/vehicle-panel');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(33, 3, 1, 'Reportes', 'icon-book-open', '/parking/rep');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(34, 3, 1, 'Configuración', 'icon-settings', '/parking/configuration');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(41, 4, -2, 'Administracion', 'icon-wrench', '/menu/41');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(42, 4, -1, 'Comprobantes', 'icon-book-open', '/parking/rep');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(43, 4, -1, 'Reportes', 'icon-book-open', '/parking/rep');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(44, 4, 1, 'Configuración', 'icon-settings', '/parking/configuration');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(411, 41, 1, 'Cuentas', 'fa-newspaper-o', '/accounts');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(412, 41, 1, 'Tipos de Cuenta', 'fa-address-card', '/accounting/ac_types');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(413, 41, 1, 'Sucursales', 'fa-building', '/accounting/branch_office');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(414, 41, 1, 'Bancos', 'fa-bank', '/accounting/banks');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(415, 41, 1, 'Cuentas Bancarias', 'fa-usd', '/accounting/accounts_banks');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(416, 41, 1, 'Centros de Costo', 'fa-dot-circle-o', '/accounting/cost_centers');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(417, 41, 1, 'Conceptos NIIF', 'fa-gear', '/accounting/niif_concepts');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(418, 41, 1, 'Atributos Cuentas', 'fa-calculator', '/accounting/attributes');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(419, 41, 1, 'Terceros', 'fa-user', '/user');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(4120, 41, 1, 'Tipo Terceros', 'fa-group', '/accounting/third_party_type');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(421, 42, 1, 'Ingreso', 'icon-basket', '/sales');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(422, 42, 1, 'Buscar', 'icon-user-follow', '/customer/customer-payments');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(423, 42, 1, 'Reportes', 'icon-handbag', '/close-cash/cash-movement');

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(431, 43, 1, 'Balances General', 'icon-basket', '/sales');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(432, 43, 1, 'Mayor y Balances', 'icon-user-follow', '/customer/customer-payments');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(433, 43, 1, 'Caja Diario', 'icon-handbag', '/close-cash/cash-movement');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(434, 43, 1, 'Libro Diario', 'icon-handbag', '/close-cash/cash-movement');


-- ADD people
INSERT INTO people(id, name, apppassword, visible, image) VALUES ('0', 'adm', '$2a$10$UB6bY4tBPmWLy6unp8pdqeN9yT9X5DQ2vbU.ASd4wCYzBzwbDzvfu', TRUE, NULL);
INSERT INTO people(id, name, apppassword, visible, image) VALUES ('1', 'gerente', '$2a$10$UB6bY4tBPmWLy6unp8pdqeN9yT9X5DQ2vbU.ASd4wCYzBzwbDzvfu', TRUE, NULL);
INSERT INTO people(id, name, apppassword, visible, image) VALUES ('2', 'vendedor', '$2a$10$UB6bY4tBPmWLy6unp8pdqeN9yT9X5DQ2vbU.ASd4wCYzBzwbDzvfu', TRUE, NULL);
INSERT INTO people(id, name, apppassword, visible, image) VALUES ('3', 'invitado_pos', '$2a$10$UB6bY4tBPmWLy6unp8pdqeN9yT9X5DQ2vbU.ASd4wCYzBzwbDzvfu', TRUE, NULL);
INSERT INTO people(id, name, apppassword, visible, image) VALUES ('4', 'park', '$2a$10$UB6bY4tBPmWLy6unp8pdqeN9yT9X5DQ2vbU.ASd4wCYzBzwbDzvfu', TRUE, NULL);
INSERT INTO people(id, name, apppassword, visible, image) VALUES ('5', 'accountant', '$2a$10$UB6bY4tBPmWLy6unp8pdqeN9yT9X5DQ2vbU.ASd4wCYzBzwbDzvfu', TRUE, NULL);

INSERT INTO people_roles (id_people, id_rol) VALUES(0, 00);

INSERT INTO permissions_roles (id_permission, id_rol) VALUES(1, 00);
INSERT INTO permissions_roles (id_permission, id_rol) VALUES(2, 00);
INSERT INTO permissions_roles (id_permission, id_rol) VALUES(3, 00);
INSERT INTO permissions_roles (id_permission, id_rol) VALUES(4, 00);

--------------------------------
-- Version 0.03
-- Grow-eCommerce  Hypervisor
-- Author: amaritnez
-- Date: 31 May 2020

ALTER TABLE `log` MODIFY `description` text DEFAULT NULL;

CREATE TABLE `characteristics` (
	`id_characteristic` INT NOT NULL AUTO_INCREMENT,
	`description` varchar(255) NOT NULL,
	`state` bit(1) NOT NULL default b'1' COMMENT '1: Active, 0: Inactive',
	PRIMARY KEY  ( `id_characteristic` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

INSERT INTO `characteristics` VALUES (1,'Modelo',1),(2,'Tipo',1),(3,'Megapíxeles',1),(4,'Calidad de grabación',1),(5,'Incluye memoria',1),(6,'Memoria expandible',1),(7,'Zoom óptico',1),(8,'Zoom digital',1),(9,'Color',1),(10,'Compatibilidad con lentes',1),(11,'Tipo de sensor',1),(12,'Tipo de sensor',1),(13,'Tipo de visor',1),(14,'Número de píxeles (efectivos)',1),(15,'Duración de la batería (CIPA, fotografía)',1),(16,'Tipo de monitor',1),(17,'Compatibilidad con lentes',1),(18,'Montura de lente',1);

CREATE TABLE `product_characteristic` (
	`id_characteristic` INT NOT NULL AUTO_INCREMENT,
	`id_product` varchar(255) NOT NULL,
	`val` varchar(255) NOT NULL,
	PRIMARY KEY  ( `id_characteristic`, `id_product` )
) ENGINE = InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT = Compact;

ALTER TABLE `product_characteristic` ADD CONSTRAINT `product_product_characteristic_fk_1` 
        FOREIGN KEY ( `id_product` ) REFERENCES `products`( `id` );

ALTER TABLE `product_characteristic` ADD CONSTRAINT `characteristic_product_characteristic_fk_1` 
        FOREIGN KEY ( `id_characteristic` ) REFERENCES `characteristics`( `id_characteristic` );

ALTER TABLE `floors`  ADD type varchar(1) NOT NULL default 't' AFTER `image`;

INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(35, 3, 1, 'Movimientos', 'icon-arrow-right', '/parking/mov');
INSERT INTO permissions (id_permission, father, level, name, icon, url) VALUES(36, 3, 1, 'Mensualidad', 'icon-arrow-right', '/parking/monthly-payment-panel');