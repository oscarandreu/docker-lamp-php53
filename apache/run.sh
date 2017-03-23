#!/bin/bash
set -e

PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING:-"E_ALL & ~E_DEPRECATED & ~E_NOTICE"}
sed -ri 's/\;date\.timezone\ \=/date\.timezone\ \=\ America\/Los_Angeles/g' /etc/php5/cli/php.ini
sed -ri 's/\;date\.timezone\ \=/date\.timezone\ \=\ America\/Los_Angeles/g' /etc/php5/apache2/php.ini
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/apache2/php.ini
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/cli/php.ini
sed -ri "s/^error_reporting\s*=.*$//g" /etc/php5/apache2/php.ini
sed -ri "s/^error_reporting\s*=.*$//g" /etc/php5/cli/php.ini
sed -ri 's/post_max_size = 8M/post_max_size = 50M/g' /etc/php5/apache2/php.ini
sed -ri 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /etc/php5/apache2/php.ini

echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php5/apache2/php.ini
echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php5/cli/php.ini

source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND