From: Paul Clarke <pc@us.ibm.com>
Subject: Re: perf annotate with sample counts
Date: Thu, 16 Jul 2015 09:59:10 -0500
Message-ID: <55A7C6BE.40700@us.ibm.com>
References: <55A70107.3030106@us.ibm.com> <55A76492.8030203@suse.cz> <55A7A724.8010506@us.ibm.com> <55A7A90A.5070008@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:50197 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbbGPO7Q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Jul 2015 10:59:16 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
	Thu, 16 Jul 2015 08:59:15 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6493619D8040
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 08:50:11 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6GExBgH54657138
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 07:59:11 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6GExBq6009686
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 08:59:11 -0600
In-Reply-To: <55A7A90A.5070008@suse.cz>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>, linux-perf-users@vger.kernel.org

On 07/16/2015 07:52 AM, Martin Li=C5=A1ka wrote:
> On 07/16/2015 02:44 PM, Paul Clarke wrote:
>> On 07/16/2015 03:00 AM, Martin Li=C5=A1ka wrote:
>>> On 07/16/2015 02:55 AM, Paul Clarke wrote:
>>>> Is there a way to get perf annotate to display sample counts inste=
ad of, or in addition to, percentages?
>>>>
>>>> The percentages seem relative to the function, which isn't as help=
ful in a global context.
>>
>>> I think you are exactly looking for: https://lkml.org/lkml/2015/6/1=
9/742, which
>>> I implemented couple of weeks ago :)
>>
>> Near-perfect timing, I guess!  Thanks, Martin!

>> Isn't this function analogous to perf report's "-n, --show-nr-sample=
s" option?  For consistency and usability, would it not be better to us=
e those options instead of "--show-total-period" ?

> Agree with you that it should be renamed to --show-nr-samples, I can =
come with a patch for that.

Could you include "-n" as a synonym, just like perf report?  That's=20
exactly what I tried at first to see if it was supported with perf anno=
tate.

Really appreciate it!

PC
