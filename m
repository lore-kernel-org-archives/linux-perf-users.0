From: David Ahern <dsahern@gmail.com>
Subject: Re: spin_lock cause ?
Date: Wed, 1 Jun 2016 15:10:27 -0600
Message-ID: <bfebe136-5f0c-2fb7-4892-954e7f271e2c@gmail.com>
References: <574F15E4.5070008@lexisnexis.com>
 <4716588.WReR5L1Wkn@milian-kdab2> <loom.20160601T194103-83@post.gmane.org>
 <20160601181153.GU2563@kernel.org> <loom.20160601T204307-459@post.gmane.org>
 <574F2F20.2090007@hpe.com> <loom.20160601T211807-101@post.gmane.org>
 <574F447F.1000503@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36378 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcFAVKf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 17:10:35 -0400
Received: by mail-pf0-f170.google.com with SMTP id f144so22107175pfa.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2016 14:10:34 -0700 (PDT)
In-Reply-To: <574F447F.1000503@hpe.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Rick Jones <rick.jones2@hpe.com>, M Kelly <mark.kelly@lexisnexis.com>, linux-perf-users@vger.kernel.org

On 6/1/16 2:24 PM, Rick Jones wrote:
> On 06/01/2016 12:25 PM, M Kelly wrote:
>> I think I recall you from hp, years ago when I was there :-)
>> Thanks for the info.  I suspect we are too heavy on
>> pthread_mutex_lock()/unlock()
>
> HP-UX has some ways/tools to track mutex contention.  Some extensions to
> give names to mutexes and then get stats on how often one went to grab
> them and it was held etc etc.  Been ages since I used them - I'd hope
> there was something similar for Linux but I've not played with threads
> in a very long time.

If the kernel is new enough (3.8 or 3.10, I forget when userspace return 
probes were added) you can use probes + futex system call to analyze 
lock contention.

 From an old script for x86:

PL=/lib64/libpthread.so.0
perf probe -x ${PL} -a 'mutex_lock=pthread_mutex_lock addr=%di'
perf probe -x ${PL} -a 'mutex_trylock=pthread_mutex_trylock addr=%di'
perf probe -x ${PL} -a 'mutex_timedlock=pthread_mutex_timedlock addr=%di'
perf probe -x ${PL} -a 'mutex_unlock=pthread_mutex_unlock addr=%di'

perf probe -x ${PL} -a 'mutex_lock_ret=pthread_mutex_lock%return ret=%ax'
perf probe -x ${PL} -a 'mutex_trylock_ret=pthread_mutex_trylock%return 
ret=%ax'
perf probe -x ${PL} -a 
'mutex_timedlock_ret=pthread_mutex_timedlock%return ret=%ax'


perf record -a -e probe_libpthread:* -e 
syscalls:sys_enter_futex,syscalls:sys_exit_futex -- <workload spec>

perf script -g python

--> edit perf-script.py for analysis of interest.

perf script -s perf-script.py

e.g., you can track the thread id holding a lock and for a how long, how 
many contentions, who got the lock when it was released, etc.

Many years ago I used the above to understand a nasty apparent deadlock 
in a process.
