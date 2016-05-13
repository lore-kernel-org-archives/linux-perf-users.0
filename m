From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 2/2] perf/core: change errno for sampling event not
 supported in hardware
Date: Fri, 13 May 2016 14:06:40 +0530
Message-ID: <57359218.6030105@synopsys.com>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
 <1462786660-2900-3-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1605090923460.27332@macbook-air>
 <5730C79F.3060307@synopsys.com>
 <20160511193627.GH3190@twins.programming.kicks-ass.net>
 <5734229B.90706@synopsys.com>
 <20160512064201.GL3192@twins.programming.kicks-ass.net>
 <573428A1.3060402@synopsys.com>
 <20160512072542.GM3192@twins.programming.kicks-ass.net>
 <alpine.DEB.2.20.1605121903470.18777@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:54055 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbcEMIhA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 04:37:00 -0400
In-Reply-To: <alpine.DEB.2.20.1605121903470.18777@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, linux-snps-arc@lists.infradead.org, mingo@kernel.org

On Friday 13 May 2016 04:34 AM, Vince Weaver wrote:
> On Thu, 12 May 2016, Peter Zijlstra wrote:
> 
>> Ah.. which might be a hint that nobody is actually explicitly testing
>> for this and we might just get away with changing the ABI.
>>
>> Vince, what say you; shall we try and get away with it? ;-)
> 
> It's probably worth trying.
> 
> The only other time anyone else noticed was in this thread
> 	https://lkml.org/lkml/2015/6/11/136
> and I think the conclusion at the end of that was also that it's probably 
> worth changing.

I presume that the RFC patches I posted are fine or do we want any changes.
