# StarPOINT Loyalty Reward

## Event

**Approval**

to log approval process from member to partner to let partner used token on member behalf.

**Transfer**

to log transfer token process between members.

**Issue**

to log new minted token and added to partners balance.

**Reward**

to log partner rewarding member a token.

**Redeem**

to log member redeem token process.

**PartnerRedeem**

to log when partner redeem member token on their behalf.

**RegisterPartner**

to log new partner register.

**RegisterMember**

to log new member register.

## Modifier

**onlyOwner**

to check if msg.sender is owner of smart contract.

**onlyPartner**

to check if msg.sender is partner.

**onlyMember**

to check if msg.sender is member.

## Function

**registerPartner**

function to register an address as a partner. can only called by owner.

**registerMember**

function to register an address as a member. can only called by owner.

**issue**

function to mint a token and add new minted token to partner address. address must be registered as a partner before. can only called by owner.

**reward**

function to reward token to members. address must be registered as a member before. can only called by partner.

**approve**

function to let other address to use msg.sender token on their behalf. this mostly used when member redeem point for a service like hotel room where payment done after member used the service. this function will ensure that partner can take member token after they used the service.

**redeem**

function to redeem member token to registered partner. can only called by member.

**partnerRedeem**

function to let partner redeem member token on their behalf. can only called by partner.

**transfer**

function to let member transfer token between members. can only called by member.
