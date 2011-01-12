From: Len Brown <lenb@kernel.org>
Subject: [PATCH] cpuidle: delete unused CPUIDLE_FLAG_SHALLOW, BALANCED,
 DEEP definitions
Date: Wed, 12 Jan 2011 03:01:45 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120300580.19140@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
 <1294396190-23031-6-git-send-email-trenn@suse.de>
 <alpine.LFD.2.02.1101120159400.19140@x980>
 <alpine.LFD.2.02.1101120229060.19140@x980>
 <alpine.LFD.2.02.1101120235390.19140@x980>
 <alpine.LFD.2.02.1101120258550.19140@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:51790 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730Ab1ALIBv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 12 Jan 2011 03:01:51 -0500
In-reply-to: <alpine.LFD.2.02.1101120258550.19140@x980>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cpuidle.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index dee3285..c252953 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -48,9 +48,6 @@ struct cpuidle_state {
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
-#define CPUIDLE_FLAG_SHALLOW	(0x20) /* low latency, minimal savings */
-#define CPUIDLE_FLAG_BALANCED	(0x40) /* medium latency, moderate savings */
-#define CPUIDLE_FLAG_DEEP	(0x80) /* high latency, large savings */
 #define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle period */
 #define CPUIDLE_FLAG_TLB_FLUSHED (0x200) /* tlb will be flushed */
 
-- 
1.7.4.rc1.7.g2cf08
