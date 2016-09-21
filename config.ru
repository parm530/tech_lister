require './config/environment'

use Rack::MethodOverride
use UserProductsController
use UsersController
use ProductsController 
run ApplicationController