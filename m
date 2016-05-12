From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC 2/2] perf/core: change errno for sampling event not
 supported in hardware
Date: Thu, 12 May 2016 12:24:25 +0530
Message-ID: <573428A1.3060402@synopsys.com>
References: <1462786660-2900-1-git-send-email-vgupta@synopsys.com>
 <1462786660-2900-3-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1605090923460.27332@macbook-air>
 <5730C79F.3060307@synopsys.com>
 <20160511193627.GH3190@twins.programming.kicks-ass.net>
 <5734229B.90706@synopsys.com>
 <20160512064201.GL3192@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43962 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbcELG4M (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 May 2016 02:56:12 -0400
In-Reply-To: <20160512064201.GL3192@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, acme@redhat.com, linux-snps-arc@lists.infradead.org, mingo@kernel.org

On Thursday 12 May 2016 12:12 PM, Peter Zijlstra wrote:
>> Tried that and doesn't even compile. Reconfirms what Vince said, ENOTSUPP is not
>> > exposed to userspace (being in include/linux and not include/uapi/linux)
> Durr, so what does userspace see?

It sees the "value" of ENOTSUPP, i.e. 524 but there is no symbolic reference to it :-)
