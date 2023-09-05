# WALLET SERVICE API 

quick wallet service api example with transactional database execution

## how to setup 
- clone this repository to your local
```
git clone git@github.com:endjay/wallet_service_api_rails.git
```
- setup potsgres database
- set environment variable below
```
export DB_USERNAME=[YOUR DB USERNAME]
export DB_PASSWORD=[YOUR DB PASSWORD]
export DB_NAME=[YOUR DB NAME]

```
- run `rails db:migrate` to setup the db structure
- run  `rails s` to start the service 


# API LIST

## Create user 
```
    [POST] /users

    {
        "name":"any name"
    }
```
## Delete user
```
    [DELETE] /users/{USER_ID}
```
## Get users
```
    [GET] /users
```
## Create wallet
```
    [POST] /wallets

    {
        "user_id':USER_ID,
        "amount": ANY_FLOAT_NUMBER
    }
```
## GET wallets
```
    [GET] /wallets
```
## Delete wallet
```
    [DELETE] /wallets/{WALLET_ID}
```

## Create transaction
```
    [POST] /transactions

    {
          "user_id":USER_ID,
          "status":"IN_PROGRESS",
          "tx_type": "TRANSFER",
          "to_user":USER_ID,
          "amount":ANY_FLOAT_AMOUNT
    }
```

## Update transaction
```
    [PUT] /transactions/{TRANSACTION_ID}

    {
        "status": "SUCCESS"
    }

```

## Get transactions
```
    [GET] /transactions
```




