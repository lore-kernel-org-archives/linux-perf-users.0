From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/9] acpi: processor->cpuidle: Only set cpuidle check_bm flag if pr->flags.bm_check is set
Date: Fri,  7 Jan 2011 11:29:46 +0100
Message-ID: <1294396190-23031-6-git-send-email-trenn@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1294396190-23031-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, lenb@kernel.org, j-pihet@ti.com, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
---
 drivers/acpi/processor_idle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index b28693e..82f74c9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1039,7 +1039,8 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 			snprintf(state->abbr, CPUIDLE_ABBR_LEN, "C3");
 			state->flags |= CPUIDLE_FLAG_DEEP;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
-			state->flags |= CPUIDLE_FLAG_CHECK_BM;
+			if (pr->flags.bm_check)
+				state->flags |= CPUIDLE_FLAG_CHECK_BM;
 			state->enter = pr->flags.bm_check ?
 					acpi_idle_enter_bm :
 					acpi_idle_enter_simple;
-- 
1.7.3.1

