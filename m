From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: Re: event group without multiplexing
Date: Mon, 16 Nov 2015 22:03:28 -0500
Message-ID: <CAJh9x3oq8fzEuQytCfGNZ1us8ZLLZgs=Fjr1qJBTeETSd-uA2g@mail.gmail.com>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
	<CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
	<CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
	<1447350001.15375.95.camel@Rudolf-RHEL-7>
	<alpine.DEB.2.20.1511121248050.7597@vincent-weaver-1.umelst.maine.edu>
	<alpine.DEB.2.20.1511121257380.7597@vincent-weaver-1.umelst.maine.edu>
	<20151117003937.GF10150@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33694 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbKQDDa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 22:03:30 -0500
Received: by wmec201 with SMTP id c201so206628645wme.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2015 19:03:28 -0800 (PST)
In-Reply-To: <20151117003937.GF10150@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>

Is this ok?


From 47d52ccfae56a8eb702fee6ccf327780265df2cf Mon Sep 17 00:00:00 2001
From: Yuanfang Chen <cheny@udel.edu>
Date: Mon, 16 Nov 2015 21:53:53 -0500
Subject: [PATCH 1/1] perf/x86/intel: make L1D_PEND_MISS.FB_FULL not
 constrained on haswell

Signed-off-by: Yuanfang Chen <cheny@udel.edu>
---
 arch/x86/kernel/cpu/perf_event_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel.c
b/arch/x86/kernel/cpu/perf_event_intel.c
index f63360b..e2a4300 100644
--- a/arch/x86/kernel/cpu/perf_event_intel.c
+++ b/arch/x86/kernel/cpu/perf_event_intel.c
@@ -232,7 +232,7 @@ static struct event_constraint
intel_hsw_event_constraints[] = {
  FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
  FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
  FIXED_EVENT_CONSTRAINT(0x0300, 2), /* CPU_CLK_UNHALTED.REF */
- INTEL_EVENT_CONSTRAINT(0x48, 0x4), /* L1D_PEND_MISS.* */
+ INTEL_UEVENT_CONSTRAINT(0x148, 0x4),  /* L1D_PEND_MISS.PENDING */
  INTEL_UEVENT_CONSTRAINT(0x01c0, 0x2), /* INST_RETIRED.PREC_DIST */
  INTEL_EVENT_CONSTRAINT(0xcd, 0x8), /* MEM_TRANS_RETIRED.LOAD_LATENCY */
  /* CYCLE_ACTIVITY.CYCLES_L1D_PENDING */
--
1.9.1

On Mon, Nov 16, 2015 at 7:39 PM, Andi Kleen <ak@linux.intel.com> wrote:
> On Thu, Nov 12, 2015 at 01:00:09PM -0500, Vince Weaver wrote:
>>
>> ccing Andi Kleen as he's the one who introduced the Haswell constraint
>> code in 3a632cb229bfb18b6d09822cc842451ea46c013e so maybe he knows why
>> it is contraining all L1D_PEND_MISS.* events rather than just
>> L1D_PEND_MISS.PENDING on IVB and BDW.
>
> Yes it looks like Haswell could use the more limited constraint as Broadwell
> or IvyBridge. I don't remember why it ended up this way.
> Please submit a patch.
>
> -Andi
