From: David Ahern <dsahern@gmail.com>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Fri, 23 Oct 2015 13:35:43 -0600
Message-ID: <562A8C0F.4090607@gmail.com>
References: <562A81ED.70900@redhat.com> <562A82F5.8090306@gmail.com>
 <562A8A08.9010101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35615 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbbJWTfp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Oct 2015 15:35:45 -0400
Received: by oifu63 with SMTP id u63so28811894oif.2
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2015 12:35:45 -0700 (PDT)
In-Reply-To: <562A8A08.9010101@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: =?UTF-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>, oprofile-list <oprofile-list@lists.sourceforge.net>

On 10/23/15 1:27 PM, William Cohen wrote:
> On 10/23/2015 02:56 PM, David Ahern wrote:
>> On 10/23/15 12:52 PM, William Cohen wrote:
>>> Earlier this month Rei Odeira found that the oprofile tool operf would
>>> have problems attaching and monitoring a process that created many
>>> very short-lived threads.  It looks like the kernel's perf tool also
>>> has issues when attempting to attach and monitor a process that is
>>> creating many short-lived threads.
>>
>> known a problem. If this is the problem I think it is you will find that strace shows perf stuck walking /proc directory.
>>
>> David
>>
>
> Hi David,
>
> Is the following thread related to the problem?
>
> [PATCH 1/1] perf,tools: add time out to force stop endless mmap processing"
>   http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02251.html
>
> Or is there some other thread about the problem?

That's a different problem as I recall -- a single process constantly 
changing mmaps such that perf never has a chance to read the file.

I was referring to something like 'make -j 1024' on a large system 
(e.g., 512 or 1024 cpus) and then starting perf. This is the same 
problem you are describing -- lot of short lived processes. I am fairly 
certain I described the problem on lkml or perf mailing list. Not even 
the task_diag proposal (task_diag uses netlink to push task data to perf 
versus walking /proc) has a chance to keep up.

David
