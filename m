From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: [PATCH 1/1] perf/x86/intel: make L1D_PEND_MISS.FB_FULL not
 constrained on haswell
Date: Mon, 23 Nov 2015 20:42:08 -0500
Message-ID: <CAJh9x3r50kGhcryDWdHi++dCtSpJ_1+3eCeGwaQmCORo4uCnAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37077 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbbKXBmK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Nov 2015 20:42:10 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>

From 47d52ccfae56a8eb702fee6ccf327780265df2cf Mon Sep 17 00:00:00 2001
From: Yuanfang Chen <cheny@udel.edu>
Date: Mon, 16 Nov 2015 21:53:53 -0500
Subject: [PATCH 1/1] perf/x86/intel: make L1D_PEND_MISS.FB_FULL not
 constrained on haswell

Signed-off-by: Yuanfang Chen <cheny@udel.edu>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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
