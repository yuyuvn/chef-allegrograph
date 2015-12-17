chef-allegrograph
=================
Installs and configures Allegrograph server 5.1.1

You can clone it and import it to Chef as
```
cd cookbooks
git clone git://github.com/yuyuvn/chef-allegrograph.git allegrograph
knife cookbook upload allegrograph
```
You can also install the latest version of the cookbook using Berkshelf. Add the following to your Berksfile:
```
cookbook "allegrograph", github: "yuyuvn/chef-allegrograph"
```

Requirements
------------
none

Attributes
----------
* http_port
* super_user
  * name
  * password

Usage
-----
#### allegrograph::default

Just include `allegrograph` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[allegrograph]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License
-------------------
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
