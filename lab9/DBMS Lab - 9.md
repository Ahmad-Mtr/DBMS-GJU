# 1.
![[HU.png]]
# 2. 
## SubForm Model - One Entity
![[Sub-1E.png]]
## SubForm Model - two entities
##### The Relationship name is `Subscription`
	Edit: Relationship line is like this --|-O--------|-|--
	
![[Pasted image 20231216151328.png]]

| Parent   | Child        | Type                                               | Max | Min |
|----------|--------------|----------------------------------------------------|-----|-----|
| Customer | Subscription | 1:1 Relationship having Weak Entity (Subscription) whose existence depend on an existing customer. | 1   | 1   |
	`Note`: It is **1:1** because, in order for a subscription to exist, its parent or owner should exist (Customer), and no more that **one** customer can buy that subscription instance, so 1:X.
	``
	And the Customer subscribes to one sub (in the case of the form provided), for `example`: No one subscribes to the same YT channel from *multiple* accounts, no one subscribes to same Alghad newspaper subscription *twice* to have the same newspaper *twice* at your doorstep, so 1:1.

## 4.

```diff
+ Having not so many attributes.
+ Customer's data are only important in the context of that unique subscription service.
+ Having only one unique subscription service, and so no need to track Customer's data across all of their subscriptions.

- When the Subscription relationship needs to be tracked.
```
## 5.

```diff
+ When there's a seperate relationship entity like Subscription.
+ When the Subscription relationship needs to be tracked.
+ Having multiple different subscription services.
+ Customer's data only are required to be tracked for Analysis
+ When Scaling, updating, inserting enourmous sets of data, And it's often easier to seperate things.

- Not efficient to seperate when having only one unique subscription service, AND not many attributes for both entities, AND Customer's data are only needed in that subsricption relationship.
```
