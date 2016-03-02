From: Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: Re: user-defined static trace points
Date: Wed, 02 Mar 2016 12:21:42 +0530
Message-ID: <56D68D7E.6080601@linux.vnet.ibm.com>
References: <5632782.TcXtSY8oxg@milian-kdab2> <871t7unh0j.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:53829 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbcCBGwt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Mar 2016 01:52:49 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <hemant@linux.vnet.ibm.com>;
	Wed, 2 Mar 2016 16:52:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id D740D2BB0057
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Mar 2016 17:52:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u226qOX623396482
	for <linux-perf-users@vger.kernel.org>; Wed, 2 Mar 2016 17:52:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u226pxlC027196
	for <linux-perf-users@vger.kernel.org>; Wed, 2 Mar 2016 17:52:00 +1100
In-Reply-To: <871t7unh0j.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Andi Kleen <andi@firstfloor.org>, Milian Wolff <milian.wolff@kdab.com>, perf group <linux-perf-users@vger.kernel.org>



On 03/02/2016 12:48 AM, Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
>
>> Hey all,
>>
>> I'm aware that we can add custum user-defined dynamic trace points using `perf
>> probe`. But this is unwieldy for some larger applications, esp. if we
>> recompile them often. Is there a public API (that I could not find so far), to
>> define static trace points in userspace code?
>>
>> I found
>> http://www.brendangregg.com/blog/2015-07-03/hacking-linux-usdt-ftrace.html
>> which references https://www.sourceware.org/systemtap/wiki/
>> AddingUserSpaceProbingToApps for systemtap, but on my machine I don't have a
>> <sys/sdt.h> header.
> You need to install systemtap-devel or similar.
>
>> Would such trace points be useable by perf? https://
>> lwn.net/Articles/570818/ doesn't seem to be included, i.e. I don't have `perf
>> probe --markers` with a recent build of perf.
> There is a patch to teach perf about SDT probes, but so far it has not
> been integrated. You can use them from systemtap or gdb though.
>
> https://lwn.net/Articles/569622/
>
> Perhaps Hemant needs to resubmit?
>

So far, the patches for SDT support for perf have undergone several changes
and ultimately got picked up by Masami. Masami was working on the probe 
cache
feature along with the SDT support and sent a v3 :
https://lkml.org/lkml/2015/8/15/52
(" [RFC PATCH perf/core v3 00/17] perf-probe --cache and SDT support")

Although, I don't think the SDT related patches got picked up.

Masami, are you working on a v4 patchset?

-- 
Thanks,
Hemant Kumar
