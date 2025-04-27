db.createUser({
  user: 'nodz',
  password: 'nodz',
  roles: [{
    role: 'readWrite',
    db: 'url_short_development'
  }]
});

testDb = db.getSiblingDB('url_short_test')

testDb.createUser({
  user: 'nodz',
  password: 'nodz',
  roles: [{
    role: 'readWrite',
    db: 'url_short_test'
  }]
});
