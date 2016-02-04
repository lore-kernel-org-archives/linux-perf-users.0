From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC] perf: fix building for ARCv1
Date: Thu, 4 Feb 2016 09:43:38 +0530
Message-ID: <56B2CFF2.4030503@synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA23075F44C9DD2@IN01WEMBXA.internal.synopsys.com>
 <1445166916.9672.10.camel@synopsys.com> <87a8rf6a6p.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44C9E9A@IN01WEMBXA.internal.synopsys.com>
 <8761235rwe.fsf@tassilo.jf.intel.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44CAFF9@IN01WEMBXA.internal.synopsys.com>
 <20151019093549.GK3816@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F44CB023@IN01WEMBXA.internal.synopsys.com>
 <20151019095157.GM3816@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F44CB43D@IN01WEMBXA.internal.synopsys.com>
 <20151020101133.GA17308@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F44CB4BF@IN01WEMBXA.internal.synopsys.com>
 <1446134296.3203.27.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44CE67A@IN01WEMBXA.internal.synopsys.com>
 <1454516455.2811.4.camel__10775.5710989752$1454516490$gmane$org@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:46297 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbcBDEN7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Feb 2016 23:13:59 -0500
In-Reply-To: <1454516455.2811.4.camel__10775.5710989752$1454516490$gmane$org@synopsys.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acme@redhat.com" <acme@redhat.com>, "andi@firstfloor.org" <andi@firstfloor.org>, "noamc@ezchip.com" <noamc@ezchip.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "giladb@ezchip.com" <giladb@ezchip.com>

+CC Noam

On Wednesday 03 February 2016 09:50 PM, Alexey Brodkin wrote:
>> I agree with the current solution to add -atomic to for arc700 builds.
>> > Although making that default for arc700 tools will be better but that will not fix
>> > things before next release of tools etc.
>> > 
>> > But we *do* need to improve generic solution
>> > 1. Add atomics detection in perf to add fall back arch stubs
>> > 2. ARC needs to add syscall for facilitating atomic r-m-w !
> So the most recent ARC GNU tools (2015.12) were just released yesterday
> and still atomics are disabled by default for ARCv1.
> That means perf will continue to fail on building for now.
> 
> Do you think we may apply my initial fix to 4.5 while it is in development and
> then to stable trees as well?

Noam, what's the atomic story for EZChip. Do you support such things for user
space in GNU tools. If -atomic is added to perf user space builds are you guys OK!

-Vineet
