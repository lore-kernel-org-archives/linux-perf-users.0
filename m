From: Len Brown <lenb@kernel.org>
Subject: [PATCH] cpuidle: CPUIDLE_FLAG_CHECK_BM is omap3_idle specific
Date: Wed, 12 Jan 2011 03:04:03 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120303160.19140@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
 <1294396190-23031-6-git-send-email-trenn@suse.de>
 <alpine.LFD.2.02.1101120159400.19140@x980>
 <alpine.LFD.2.02.1101120229060.19140@x980>
 <alpine.LFD.2.02.1101120235390.19140@x980>
 <alpine.LFD.2.02.1101120258550.19140@x980>
 <alpine.LFD.2.02.1101120301530.19140@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:51972 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab1ALIEI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 12 Jan 2011 03:04:08 -0500
In-reply-to: <alpine.LFD.2.02.1101120301530.19140@x980>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 ++
 include/linux/cpuidle.h           |    1 -
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d50b45..f9be4e3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -47,6 +47,8 @@
 
 #define OMAP3_STATE_MAX OMAP3_STATE_C7
 
+#define CPUIDLE_FLAG_CHECK_BM	0x10000	/* use omap3_enter_idle_bm() */
+
 struct omap3_processor_cx {
 	u8 valid;
 	u8 type;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 6be722c..36719ea 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -47,7 +47,6 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
-#define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
 #define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle period */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
-- 
1.7.4.rc1.7.g2cf08
