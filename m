From: William Cohen <wcohen@redhat.com>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Fri, 23 Oct 2015 15:27:04 -0400
Message-ID: <562A8A08.9010101@redhat.com>
References: <562A81ED.70900@redhat.com> <562A82F5.8090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45507 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbbJWT1G (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 23 Oct 2015 15:27:06 -0400
In-Reply-To: <562A82F5.8090306@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: =?UTF-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>, oprofile-list <oprofile-list@lists.sourceforge.net>

On 10/23/2015 02:56 PM, David Ahern wrote:
> On 10/23/15 12:52 PM, William Cohen wrote:
>> Earlier this month Rei Odeira found that the oprofile tool operf would
>> have problems attaching and monitoring a process that created many
>> very short-lived threads.  It looks like the kernel's perf tool also
>> has issues when attempting to attach and monitor a process that is
>> creating many short-lived threads.
> 
> known a problem. If this is the problem I think it is you will find that strace shows perf stuck walking /proc directory.
> 
> David
> 

Hi David,

Is the following thread related to the problem?

[PATCH 1/1] perf,tools: add time out to force stop endless mmap processing" 
 http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02251.html 

Or is there some other thread about the problem?

-Will
