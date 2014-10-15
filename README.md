# Neo4j CSV reader

##To install:
gem install 'neo4j'
gem install 'activemodel'
gem install 'railties'

and run.

##Description:
A plain Ruby script that will upload a CSV in the format of user_a_id, user_b_id and create a bidirectional relationship between them.

If the User node cannot be found it it will be created.

The user_id must only contain numeric characters
