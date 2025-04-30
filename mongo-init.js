db.createUser({
  user: 'mongo',
  pwd: 'mongo',
  roles: [{
    role: 'readWrite',
    db: 'url_short_development'
  }]
});

testDb = db.getSiblingDB('url_short_test')

testDb.createUser({
  user: 'mongo',
  pwd: 'mongo',
  roles: [{
    role: 'readWrite',
    db: 'url_short_test'
  }]
});
