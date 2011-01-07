From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/9] cpuidle: Rename X86 specific idle poll state[0] from C0 to POLL
Date: Fri,  7 Jan 2011 11:29:43 +0100
Message-ID: <1294396190-23031-3-git-send-email-trenn@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294396190-23031-1-git-send-email-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, lenb@kernel.org, j-pihet@ti.com, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

C0 means and is well know as "not idle".
All documentation out there uses this term as "running"/"not idle"
state. Also Linux userspace tools (e.g. cpufreq-aperf and turbostat)
show C0 residency which there is correct, but means something totally
else than cpuidle "POLL" state.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: arjan@linux.intel.com
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
---
 drivers/cpuidle/cpuidle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 08d5f05..99cc8fc 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -260,7 +260,7 @@ static void poll_idle_init(struct cpuidle_device *dev)
 
 	cpuidle_set_statedata(state, NULL);
 
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
+	snprintf(state->name, CPUIDLE_NAME_LEN, "POLL");
 	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
 	state->exit_latency = 0;
 	state->target_residency = 0;
-- 
1.7.3.1
