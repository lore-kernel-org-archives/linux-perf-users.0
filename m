From: David Ahern <dsahern@gmail.com>
Subject: Re: perf for analyzing userspace contention
Date: Mon, 17 Oct 2011 18:12:09 -0600
Message-ID: <4E9CC459.8080209@gmail.com>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com> <20111017234332.GA9745@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:32956 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab1JRAMQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Oct 2011 20:12:16 -0400
Received: by pzk36 with SMTP id 36so116194pzk.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2011 17:12:16 -0700 (PDT)
In-Reply-To: <20111017234332.GA9745@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Roland Dreier <roland@kernel.org>, linux-perf-users@vger.kernel.org



On 10/17/2011 05:43 PM, Arun Sharma wrote:
> On Thu, Oct 13, 2011 at 11:36:23PM -0700, Roland Dreier wrote:
>> Hi everyone,
>>
>> Hope this question from a kernel hacker about profiling userspace
>> isn't too dumb...
>>
>> Anyway, suppose I have a multithreaded userspace app that uses a bunch of
>> pthread_mutexes, and I want to figure out which locks are hot and/or heavily
>> contended.  What's the best way to do that?  Is perf the right, or is there
>> something better?  (This seems like such an obvious thing to want that there
>> must be some good way to get this data, I hope)
> 
> Sampling on sys_futex entry/exit is a good start. But it doesn't tell
> you if the thread spent 1us or 1ms waiting on the futex. We really need
> to add weights to the profile based on sleep times (or other criteria).

Doesn't the delta tell you the time it spends waiting?

> 
> You might want to follow further discussion in the thread with the
> subject "Profiling sleep times?".
> 
> perf record -ag -e cs -- sleep 1

And augmenting with cs (isn't the -c1 required? I've always added it for
software events) tells you if it was scheduled out.

David


> 
> is a more general version of this. It helps in understanding what's
> causing the thread to give up CPU voluntarily (you might have to filter
> the output a bit).
> 
>  -Arun
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
