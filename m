From: Len Brown <lenb@kernel.org>
Subject: [PATCH] SH, cpuidle: delete use of NOP CPUIDLE_FLAGS_SHALLOW
Date: Wed, 12 Jan 2011 03:00:46 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120258550.19140@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
 <1294396190-23031-6-git-send-email-trenn@suse.de>
 <alpine.LFD.2.02.1101120159400.19140@x980>
 <alpine.LFD.2.02.1101120229060.19140@x980>
 <alpine.LFD.2.02.1101120235390.19140@x980>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <alpine.LFD.2.02.1101120235390.19140@x980>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: Len Brown <len.brown@intel.com>

set but not checked.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 83972aa..c19e2a9 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -81,7 +81,6 @@ void sh_mobile_setup_cpuidle(void)
 	state->target_residency = 1 * 2;
 	state->power_usage = 3;
 	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_SHALLOW;
 	state->flags |= CPUIDLE_FLAG_TIME_VALID;
 	state->enter = cpuidle_sleep_enter;
 
-- 
1.7.4.rc1.7.g2cf08


