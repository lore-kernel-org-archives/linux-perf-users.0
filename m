From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Misleading hint to select CONFIG_PERF_EVENTS if driver sets
 PERF_PMU_CAP_NO_INTERRUPT
Date: Thu, 28 Apr 2016 10:05:13 +0530
Message-ID: <57219301.10505@synopsys.com>
References: <1461331523.3403.11.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E9F42D@us01wembx1.internal.synopsys.com>
 <1461770030.5970.8.camel__5728.3871378333$1461770054$gmane$org@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55952 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcD1Efa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 00:35:30 -0400
In-Reply-To: <1461770030.5970.8.camel__5728.3871378333$1461770054$gmane$org@synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Wednesday 27 April 2016 08:43 PM, Lada Trimasova wrote:
> On Tue, 2016-04-26 at 12:42 +0000, Vineet Gupta wrote:
> 
> On Friday 22 April 2016 06:56 PM, Lada Trimasova wrote:
> I think what we have now is sufficient - but u seem to want a prettier failure output.
> 
> Anyhow, this print is coming from util/evsel.c: perf_evsel__open_strerror()
> At the very least you want another entry in switch case for ENOTSUPP and then
> check if event was sampling one (
> evsel->attr.sample_period) - use that as a hint for saying sampling events not
> supported.
> 
> 
> 
> 
> ENOTSUPP is not visible for user programs. So it's impossible to add this entry
> 
> to mentioned switch.
> 
> I think that there is no good way to make error message more understandable
> 
> without breaking existing api.

I meant EOPNOTSUPP. Any errno value has to be visible to user programs otherwise
there is no point defining it.
