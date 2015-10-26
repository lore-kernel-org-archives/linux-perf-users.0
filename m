From: David Ahern <dsahern@gmail.com>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Mon, 26 Oct 2015 15:42:01 -0600
Message-ID: <562E9E29.1080003@gmail.com>
References: <562A81ED.70900@redhat.com> <562A82F5.8090306@gmail.com>
 <562A8A08.9010101@redhat.com> <562A8C0F.4090607@gmail.com>
 <20151026194933.GS27006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34417 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbbJZVmE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 26 Oct 2015 17:42:04 -0400
Received: by padhk11 with SMTP id hk11so199686806pad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2015 14:42:03 -0700 (PDT)
In-Reply-To: <20151026194933.GS27006@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, =?UTF-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>, oprofile-list <oprofile-list@lists.sourceforge.net>

On 10/26/15 1:49 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 23, 2015 at 01:35:43PM -0600, David Ahern escreveu:
>> I was referring to something like 'make -j 1024' on a large system (e.g.,
>> 512 or 1024 cpus) and then starting perf. This is the same problem you are
>> describing -- lot of short lived processes. I am fairly certain I described
>> the problem on lkml or perf mailing list. Not even the task_diag proposal
>> (task_diag uses netlink to push task data to perf versus walking /proc) has
>> a chance to keep up.
>
> Yeah, to get info about existing threads (its maps, comm, etc) you would
> pretty much have to stop the world, collect the info, then let
> everything go back running because then new threads would insert the
> PERF_RECORD_{FORK,COMM,MMAP,etc} records in the ring buffer.
>
> I think we need an option to say: don't try to find info about existing
> threads, i.e. don't look at /proc at all, we would end up with samples
> being attributed to a pid/tid and that would be it, should be useful for
> some use cases, no?

Seems to me it would just be a lot of random numbers on a screen. 
Correlating data to user readable information is a key part of perf.

One option that might be able to solve this problem is to have perf 
kernel side walk the task list and generate the task events into the 
ring buffer (task diag code could be leveraged). This would be a lot 
faster than reading proc or using netlink but would have other 
throughput problems to deal with.
