From: David Ahern <dsahern@gmail.com>
Subject: Re: how to get a kernel callgraph starting from a syscall
Date: Thu, 21 Apr 2011 13:49:47 -0600
Message-ID: <4DB08A5B.3060706@gmail.com>
References: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>	<4DB04BF3.8080206@gmail.com> <BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59221 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1DUTtt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Apr 2011 15:49:49 -0400
Received: by pvg12 with SMTP id 12so30712pvg.19
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Apr 2011 12:49:48 -0700 (PDT)
In-Reply-To: <BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org



On 04/21/11 12:48, Francis Moreau wrote:
> On Thu, Apr 21, 2011 at 5:23 PM, David Ahern <dsahern@gmail.com> wrote:
>>
>>
>> On 04/21/11 01:46, Francis Moreau wrote:
>>> Hello,
>>>
>>> Sorry if the question is dumb but I'm a bit lost about this.
>>>
>>> I know that ftrace exists but I think that perf can do this too: I
>>> have a userspace application which is calling a libc C function (read)
>>> which ends up doing a sys_read.
>>>
>>> For the sys_read, I'd like to see what's happening in the kernel by
>>> displaying the call graph.
>>>
>>> Can perf do that ?
>>
>> Have you tried 'perf record -g'?
>>
> 
> Well, I don't see how it can be done with perf record -g.
> 
> Let's say I'm interested to see the path taken in the kernel when a
> process is calling sys_sleep:
> 
>   $ perf record -g sleep 1
> 
> Then I can use:
> 
>   $ perf report -g
> 
> But I don't see what I am asking for.
> 
> What am I missing ?

You want the individual samples? if so, perf script dumps them and you
can see the callchain for each sys_read.

David

> 
> Thanks
