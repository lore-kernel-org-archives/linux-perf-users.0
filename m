From: Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [RFC 2/2] perf/core: change errno for sampling event not
 supported in hardware
Date: Mon, 9 May 2016 22:53:43 +0530
Message-ID: <5730C79F.3060307@synopsys.com>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
 <1462786660-2900-3-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1605090923460.27332@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33891 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbcEIRXv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2016 13:23:51 -0400
In-Reply-To: <alpine.DEB.2.20.1605090923460.27332@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org, acme@redhat.com, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org

On Monday 09 May 2016 07:24 PM, Vince Weaver wrote:
> On Mon, 9 May 2016, Vineet Gupta wrote:
> 
>> This allows userspace to identify this case specifically from the
>> catch all error msg it prints currently.
>>
>> This is an ABI change
> 
> An ABI change which will probably break things.


Right thats what I feared. But hold on, I don't think we need to change the ABI to
achieve what we want. Gosh why did I even take that path.

Currently the errno switch case in perf_evsel__open_strerror() in doesn't handle
ENOTSUPP. So how about we add that - augmented with the same sample_period !0
check to barf for lack of sampling support.

Do you see anything wrong with that ?

-Vineet

> 
> The original change from ENODEV to ENOTSUPP managed to break things 
> although it took four kernel releases before anyone noticed.
> 
> The usage of ENOTSUPP was my fault, though I feel like at the time I was 
> told that ENOTSUPP is for internal kernel usage and would be converted to 
> EOPNOTSUPP when returning an error to userspace.  But now I 
> can't find any sort of reference for that at all, except the fact that
> 
> 	/usr/include/x86_64-linux-gnu/bits/errno.h
> 
> has
> 	/* Linux has no ENOTSUP error code.  */
> 	# define ENOTSUP EOPNOTSUPP
> 
> in it... but wait, that's ENOTSUP not ENOTSUPP.  Blargh.
> 
> Vince
> 
