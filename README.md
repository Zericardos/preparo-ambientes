# preparo-ambientes
Compilado de scripts que configuram o sistema, instalam os programas que mais uso e os configuram
`bash -x init.sh`

# Rápido usos e configs sobre alguns pacotes
## redshift
### Post Installation
#### Playing around with Redshift
There are only a few parameters you need for finding the right settings. These are:

- v for verbose output.
- g R:G:B for RGB colour (ratio as a percentage).
- O TEMP for temperature.

See below the command where settings are used in my config file:

`redshift -v -g 1.1:0.8:0.7 -O 4500`

To see all the command for Redshift, run the following in the terminal:

`redshift -h`

### Config File
Once you’re happy with your settings the next step is to create a config file in the folder *~/.config/*

Run the following commands:

`touch ~/.config/redshift.conf`

Mousepad is one the default editors in Manjaro Xfce, otherwise use your favorite editor
`mousepad ~/.config/redshift.conf`

And this is the config file that I’ve created:

```
; Global settings for redshift
[redshift]
; Set the day and night screen temperatures
temp-day=6500
temp-night=4500

; Enable/Disable a smooth transition between day and night
; 0 will cause a direct change from day to night screen temperature.
; 1 will gradually increase or decrease the screen temperature.
transition=1

; Set the screen brightness. Default is 1.0.
;brightness=0.9
; It is also possible to use different settings for day and night
; since version 1.8.
brightness-day=1.0
brightness-night=0.6

; Set the screen gamma (for all colors, or each color channel
; individually)
;gamma=0.8
;gamma=0.8:0.7:0.8
; This can also be set individually for day and night since
; version 1.10.
;gamma-day=0.8:0.7:0.8
gamma-night=1.1:0.8:0.7

; Set the location-provider: 'geoclue', 'geoclue2', 'manual'
; type 'redshift -l list' to see possible values.
; The location provider settings are in a different section.
location-provider=geoclue2

; Set the adjustment-method: 'randr', 'vidmode'
; type 'redshift -m list' to see all possible values.
; 'randr' is the preferred method, 'vidmode' is an older API.
; but works in some cases when 'randr' does not.
; The adjustment method settings are in a different section.
adjustment-method=randr

; Configuration of the location-provider:
; type 'redshift -l PROVIDER:help' to see the settings.
; ex: 'redshift -l manual:help'
; Keep in mind that longitudes west of Greenwich (e.g. the Americas)
; are negative numbers.
[manual]
lat=-33.1 
lon=81.82
```
Just a few things to remember for this config file:

If you’re using another distro, make sure that the location-provider library is installed.
In Manjaro Xfce; geoclue2 installed by default.
For adjustment-method, most modern laptops will support randr.
And lastly, for lat and lon I used http://www.latlong.org/convert-address-to-latitude-and-longitude.php to work out my longitude and latitude values.
Lastly, make sure enabled and Autostart and checked on the status icon.
<br>Credits: [zamkblog](https://zamkblog.wordpress.com/2019/04/25/manjaro-and-redshift/)