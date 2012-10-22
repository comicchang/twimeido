module TwiMeido
  module UtilityCommand
    extend Command

    define_command :help, /\Ah(elp)?(!)?\Z/i do |user, message, params|
      h_not_allowed = !params[1]
      dont_panic = params[2]

      if h_not_allowed
        'H 的事情是不可以的！'
      elsif dont_panic
        "Don't panic!"
      else
        <<-HELP

*本机器人基于@rainux的twi-meido项目，部分命令依个人习惯略有修改*
*可以到 http://goo.gl/x8awn 查看帮助文件的最新版本*
* Send messages to me, I'll tweet them for you. 
* Any messages begin with " "(space) or "-" character are treat as commands. 
* Start use me by send " oauth" command to bind your Twitter account. 
* Follow @TwiMeido for development news. 

Available commands:

-oauth
Start an OAuth process to bind your Twitter account.

-bind PIN_CODE
Use the PIN code you've got from -oauth command to actually bind your Twitter account.
==========================================
-on [notification_type]
Turn on a specified type of real-time notification.
Run without parameter to show available notification types and current status.

-off [notification_type]
Turn off a specified type of real-time notification.
Run without parameter to get available notification types and current status.

-track [keywords]
Add keywords to tracking keyword list, keywords are delimited by space.
Run without parameter to show currently tracking keywords.
You can control real-time notification for tracked keywords by `-on track` and `-off track` command.
CAUTION: Never track very hot keywords like "Twitter", "is", "awesome", etc.

-untrack [keywords]
Add keywords to tracking keyword list, keywords are delimited by space.
Run without parameter to show currently tracking keywords.
You can control real-time notification for tracked keywords by `-on track` and `-off track` command.

-reset
Reset short id to 1. Short id will be reset automatically when it reaches 1000.
I will generate short id for any tweets you've viewed like this: [ ID: 85 << 19043509017247744 ... ].
You can use short id with any commands that require a tweet id parameter.

-reconnect
Reconnect the stream api. This is useful when twimeido stop pushing messages.
==========================================
*[Count] means optional, default value is 20*

-home [count]
-ho [count]
Show your friend's timeline. 

-@ [count]
Show the tweets mentioned you.

-d
Show the direct messages sent to you.

-me [count]
-tl [count]
Show your tweets.

-tl [username] [count]
Show the specified user's tweets.

-profile [username]
-st [username]
Show the specified user's tweets.
==========================================
-fo username
Follow the specified user.

-unfo username
Unfollow the specified user.

-if username
Show follow relationship between the specified user and you.
==========================================
-re tweet_id
-r
Retweet the specified tweet, this is the "official retweet".

-rt tweet_id [comment]
Retweet the specified tweet with your comment.

-r tweet_id text
-@ tweet_id text
Reply the specified tweet with the text.

-ra tweet_id text
Reply the specified tweet with the text, and mention all users mentioned by the original tweet.

-del [tweet_id]
Delete the specified tweet of yours.
Run without parameter will delete the latest tweet.

-show tweet_id [conversation_length]
-msg tweet_id [conversation_length]
Show the specified tweet, with conversation if available.
Conversation length default to 5.
==========================================
-help
Show this help.

*可以到 http://goo.gl/x8awn 查看帮助文件的最新版本*
*有任何疑问可以联系 @Orz_C*

        HELP
      end
    end
  end
end
