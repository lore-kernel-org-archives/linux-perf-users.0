From: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: --mmap-pages option seemingly has no effect to help with LOST
 samples
Date: Mon, 25 Jun 2012 09:10:27 -0500
Message-ID: <4FE87153.8010502@us.ibm.com>
References: <4FD7ACB9.70205@us.ibm.com> <4FD7AF0C.1030300@gmail.com> <4FD8B32C.60608@us.ibm.com> <4FD8B641.9040907@gmail.com> <4FE49663.7000908@us.ibm.com> <4FE49A6F.7020503@gmail.com> <4FE4C589.5080802@us.ibm.com> <4FE4CB21.90005@gmail.com> <4FE4D446.5000906@us.ibm.com> <4FE4D7A8.5080607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:41940 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2FYOL1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 25 Jun 2012 10:11:27 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Mon, 25 Jun 2012 08:11:26 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 025F5C4000C
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Jun 2012 14:11:06 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5PEAjUw260022
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Jun 2012 08:10:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5PEATdj021810
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Jun 2012 08:10:30 -0600
In-Reply-To: <4FE4D7A8.5080607@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, suka@us.ibm.com

On 06/22/2012 03:38 PM, David Ahern wrote:
> On 6/22/12 2:23 PM, Maynard Johnson wrote:
>> On 06/22/2012 02:44 PM, David Ahern wrote:
>>> On 6/22/12 1:20 PM, Maynard Johnson wrote:
>>>> I was seeing this on both my Intel Core 2 Duo and an IBM POWER7 server, both running RHEL 6.2.  Also tried on another POWER7 running RHEL 6.3 beta, and got the same results.  I found another POWER server that had RHEL 6.2 but was temporarily booted on a 3.5 kernel and ran the test there -- the counts were good there. :-)  Just to be sure, I rebooted that system to the stock RHEL 6.2 kernel and reproduced the problem.  So it seems there's an upstream fix for this.  Can someone help me find the commit?
>>>
>>> emails crossing in the ether.
>>>
>>> 2.6.32 is real early in the perf history. I flipped a system to the Fedora 14 2.6.35.14 kernel -- and it does not handle multiple events either. With Arnaldo's last updates I did notice something curious about the events:
>> Yes, I realize that 2.6.32 is early perf, but a lot of our customers are stuck with it.  Too bad I didn't discover this before RHEL 6.3 GA'ed.  Again, I'm hoping that someone in the perf community watching this list might be able to point to an upstream commit for the problem so we can push that fix into RHEL 6.4 (at least).  Is there someone you would suggest to be cc'ed?
>>
> 
> I maintain a backport to WRL3. As part of debugging your problem I found my backport version is susceptible as well. In my testing I had only looked at single events, not multiple. For my version adding :uk did not help, but :u did. I'll find some time to do a bisect and see if I can find commit(s) that fix the problem, but it will be a background task.
David,
Just an FYI -- adding ":u" doesn't help for RHEL 6.2.  Thanks much for the help so far.

-Maynard
> 
> David
> 
> 
> 
> 
