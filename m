From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 2/2] perf/core: change errno for sampling event not
 supported in hardware
Date: Thu, 12 May 2016 11:58:43 +0530
Message-ID: <5734229B.90706@synopsys.com>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
 <1462786660-2900-3-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1605090923460.27332@macbook-air>
 <5730C79F.3060307@synopsys.com>
 <20160511193627.GH3190@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43466 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbcELG3C (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 May 2016 02:29:02 -0400
In-Reply-To: <20160511193627.GH3190@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@redhat.com, Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-snps-arc@lists.infradead.org, mingo@kernel.org

On Thursday 12 May 2016 01:06 AM, Peter Zijlstra wrote:
> On Mon, May 09, 2016 at 10:53:43PM +0530, Vineet Gupta wrote:
> 
>> > Right thats what I feared. But hold on, I don't think we need to change the ABI to
>> > achieve what we want. Gosh why did I even take that path.
>> > 
>> > Currently the errno switch case in perf_evsel__open_strerror() in doesn't handle
>> > ENOTSUPP. So how about we add that - augmented with the same sample_period !0
>> > check to barf for lack of sampling support.
>> > 
>> > Do you see anything wrong with that ?
>
> Should work I think.

Tried that and doesn't even compile. Reconfirms what Vince said, ENOTSUPP is not
exposed to userspace (being in include/linux and not include/uapi/linux)
