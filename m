From: David Ahern <dsahern@gmail.com>
Subject: Re: help with porting perf lkm to later kernel
Date: Wed, 28 Aug 2013 17:04:27 -0600
Message-ID: <521E81FB.2030302@gmail.com>
References: <CANFySve_0Mw48knK-1ueWjibBQfzfgLQzOhJde5zWL9OZO3iYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55948 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3H1XEj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 28 Aug 2013 19:04:39 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so81668pab.15
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2013 16:04:38 -0700 (PDT)
In-Reply-To: <CANFySve_0Mw48knK-1ueWjibBQfzfgLQzOhJde5zWL9OZO3iYw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: cfreehill@alumni.utexas.net
Cc: Chris Freehill <cfreehill@gmail.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

[Added Ingo, Peter and Arnaldo for opinions on the symbol exports - or 
lack of]

On 8/28/13 4:53 PM, Chris Freehill wrote:
> Another way to ask this, is why are these symbols no longer exported
> (previously exported in core.c with EXPORT_SYMBOL_GPL), and how are
> people who built lkm's using the previously existing interface
> supposed to port them? Is it perhaps documented somewhere? I have not
> been able to find this via google or in git comments.
>
> Is this the wrong forum for this question (which I grant may be a
> "newbie" question), or is there just no good answer?
>
> thanks,
> chris
>
>
>> I am trying to get my linux kernel module that extends perf support to work
>> in a later kernel version. The lkm had been working in 3.0.51.
>>
>> In the new target kernel to which I am trying to port, 3.8.13, I get
>> warnings at the modpost stage complaining about symbols that can no longer
>> be found. If I attempt to load that module, I get errors saying the same
>> thing (those symbols can't be found).
>>
>> The symbols that can't be found are
>>
>> ".perf_pmu_enable"
>>
>> ".perf_event_update_userpage"
>>
>> ".perf_pmu_disable"
>>
>> ".perf_event_overflow"
>>
>> ".perf_pmu_unregister"
>>
>> ".perf_pmu_register"
>>
>> Does anyone have any tips or advice as to how code that calls these
>> previously working functions should now be handled when built against later
>> kernels?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
