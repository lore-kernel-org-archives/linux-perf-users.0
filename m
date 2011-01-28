From: David Ahern <daahern@cisco.com>
Subject: Re: [RFC] --dump-sym-trace
Date: Fri, 28 Jan 2011 14:41:37 -0700
Message-ID: <4D433811.7020904@cisco.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>	<4D3F871B.3060906@cisco.com> <AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:22642 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab1A1Vlj (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Jan 2011 16:41:39 -0500
In-Reply-To: <AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: linux-perf-users@vger.kernel.org



On 01/28/11 14:18, Arun Sharma wrote:
> On Tue, Jan 25, 2011 at 6:29 PM, David Ahern <daahern@cisco.com> wrote:
>> From a brief glance seems similar to the timehist patch I proposed. See:
>> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
>> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
>> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html
> 
> The output could be a bit more compact (eg: print some info once per
> stack trace rather than once per frame). Also, it doesn't seem to
> print the DSO name when symbol lookup fails?

I am certainly interested in ideas on how to improve the output.

That version was derived from a local patch; in our case I wanted a
simple format for the output. Essentially, the timehist output is a
'text' version of the samples, with timestamps and address conversions
where possible.

Arnaldo has started a new version of it wherein the wall clock is a new
event that can be sampled (e.g., perf top) or generated at given rate. I
spent time looking at the changes to perf command, but have been
sidetracked with other priorities.

David


> 
> Otherwise looks great. I'll drop the other patch.
> 
>  -Arun
