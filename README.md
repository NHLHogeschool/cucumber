# Catalogue

## College 1: Cucumber

> Mogelijk komen hier nog notities van.

## College 2: I18n

Lees alles over I18n op de [Rails Guides][i18n_guides];

```I18n``` is een losstaande gem waarvan Rails gebruik maakt.
```I18n``` geeft 2 methods die van belang zijn:

1. ```translate```: geeft een vertaalde string terug vanuit een taalbestand;
2. ```localize```: localiseert (in vrijwel alle gevallen) een datum / tijd / timestamp.

Je kunt deze methods gebruiken in de console (```I18n.t``` of ```I18n.l```);

```ruby
I18n.locale # => :en
I18n.t :hello # => "Hello world"
I18n.l Time.now # => "Mon, 11 Nov 2013 21:48:25 +0100"
I18n.l Time.now, format: short # => "11 Nov 21:48"
I18n.locale = :nl # => :nl
I18n.t :hello # => "translation missing: nl.hello"
```

We kunnen de default locale instellen voor een Rails-app in ```config/application.rb```.

```ruby
config.i18n.default_locale = :nl
```

Standaard gaat dat niet werken, want het taalbestand voor de Nederlandse taal bestaat nog niet.
We kunnen dat bestand toevoegen onder het volgende pad: ```config/locales/nl.yml```.
In dat bestand beginnen we met de volgende content;

```yaml
nl:
	hello: Hallo wereld
```

Als we nu de console opnieuw starten met ```rails c``` en ```I18n.t :hello``` uitvoeren zien we ```Hallo wereld```.

Hiermee is de basis van meertaligheid door middel van ```I18n``` uitgelegd.
Rails voegt daar een aantal heel handige defaults aan toe, bijvoorbeeld;

* Conventies voor het vertalen van attributen in je models;
* Hierarchie in het taalbestand;
* Interpolatie in je vertalingen;
* Werken met verschillende valuta en datum-notaties.

De conventie voor je models is eenvoudig, maar moet je net even weten (zie ook de [Rails Guides][i18n_guides]).

```yaml
nl:
	activerecord:
		models:
			product: Artikel
		attributes:
			product:
				title: Titel
				details: Details
```
Als je die toevoegt zul je zien formulieren automatisch vertaalde labels (bijv. ```f.label :title```) gebruiken.
In het voorbeeld zie je ook meteen hoe hierarchie werkt, je kunt de naam van het model opvragen met ```t('activerecord.models.product)```.

Hierin past nog een conventie, stel je voor dat je verschillende schermen een andere titel wilt geven, uit een vertaalbestand. Het risico bestaat dan dat je overal lange hierachische vertalingen op loopt te vragen, bijvoorbeeld ```t('products.index.title')```.
Als je in je vertaalbestand de conventie uit het volgende voorbeeld hanteert kun je gewoon ```t('.title')``` gebruiken.

```yaml
nl:
	products:
		index:
			title: Alle producten
		new:
			title: Nieuw product
```

Interpolatie is het gebruik van variabelen in je vertaling, bijvoorbeeld voor een welkomstgroet: ```Welkom Raymond!```.
Je zou dat zo kunnen oplossen:

```erb
<%= t(:welcome) %> <%= current_user.name %>
```

Een meer conventionele oplossing is zo:

```yaml
nl:
	welcome: Welkom %{name}
```

en

```erb
<%= t(:welcome, name: current_user.name) %>
```

Valuta en vertalingen worden verwerkt met ```localize``` method, niet met ```translate``` zoals alle voorgaande voorbeelden.
Een goed idee is om de conventies te downloaden die rails zelf aanbiedt via hun [Github project][github_i18n_nl].

Sla dit bestand op als ```config/locales/nl.rails.yml``` en alles werkt.
Loop het bestandje eens door in je vrije tijd om ook daarin de conventies te ontdekken.

[i18n_guides]: http://guides.rubyonrails.org/i18n.html
[github_i18n_nl]: https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/nl.yml