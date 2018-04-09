From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: Add s390 support for detailed/verbose pmu event description
Date: Mon,  9 Apr 2018 13:00:15 +0200
Message-ID: <20180409110015.20793-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Perf list with flags -d and -v print a description (-d) or
a very verbose explanation (-v) of CPU specific counter events.
These descriptions are provided with the json files in
directory pmu-events/arch/s390/*.json.

Display of these descriptions on s390 requires the
corresponding json files.

On s390 this does not work because function is_pmu_core()
does not detect the s390 directory name where the
CPU specific events are listed. On x86 it is
  /sys/bus/event_source/devices/cpu
whereas on s390 it is
  /sys/bus/event_source/devices/cpum_cf
  /sys/bus/event_source/devices/cpum_sf

Fix this by adding s390 directory name testing to
function is_pmu_core(). This is the same approach as taken for
arm platform.

Output before:
[root@s35lp76 perf]# ./perf list -d pmu
List of pre-defined events (to be used in -e):

  cpum_cf/AES_BLOCKED_CYCLES/      [Kernel PMU event]
  cpum_cf/AES_BLOCKED_FUNCTIONS/   [Kernel PMU event]
  cpum_cf/AES_CYCLES/              [Kernel PMU event]
  cpum_cf/AES_FUNCTIONS/           [Kernel PMU event]
  ....
  cpum_cf/TX_NC_TEND/              [Kernel PMU event]
  cpum_cf/VX_BCD_EXECUTION_SLOTS/  [Kernel PMU event]
  cpum_sf/SF_CYCLES_BASIC/         [Kernel PMU event]

Output after:
[root@s35lp76 perf]# ./perf list -d pmu
List of pre-defined events (to be used in -e):

  cpum_cf/AES_BLOCKED_CYCLES/      [Kernel PMU event]
  cpum_cf/AES_BLOCKED_FUNCTIONS/   [Kernel PMU event]
  cpum_cf/AES_CYCLES/              [Kernel PMU event]
  cpum_cf/AES_FUNCTIONS/           [Kernel PMU event]
  ....
  cpum_cf/TX_NC_TEND/              [Kernel PMU event]
  cpum_cf/VX_BCD_EXECUTION_SLOTS/  [Kernel PMU event]
  cpum_sf/SF_CYCLES_BASIC/         [Kernel PMU event]

3906:
  bcd_dfp_execution_slots
       [BCD DFP Execution Slots]
  decimal_instructions
       [Decimal Instructions]
  dtlb2_gpage_writes
       [DTLB2 GPAGE Writes]
  dtlb2_hpage_writes
       [DTLB2 HPAGE Writes]
  dtlb2_misses
       [DTLB2 Misses]
  dtlb2_writes
       [DTLB2 Writes]
  itlb2_misses
       [ITLB2 Misses]
  itlb2_writes
       [ITLB2 Writes]
  l1c_tlb2_misses
       [L1C TLB2 Misses]
  .....

cfvn 3:
  cpu_cycles
       [CPU Cycles]
  instructions
       [Instructions]
  l1d_dir_writes
       [L1D Directory Writes]
  l1d_penalty_cycles
       [L1D Penalty Cycles]
  l1i_dir_writes
       [L1I Directory Writes]
  l1i_penalty_cycles
       [L1I Penalty Cycles]
  problem_state_cpu_cycles
       [Problem State CPU Cycles]
  problem_state_instructions
       [Problem State Instructions]
  ....

csvn generic:
  aes_blocked_cycles
       [AES Blocked Cycles]
  aes_blocked_functions
       [AES Blocked Functions]
  aes_cycles
       [AES Cycles]
  aes_functions
       [AES Functions]
  dea_blocked_cycles
       [DEA Blocked Cycles]
  dea_blocked_functions
       [DEA Blocked Functions]
  ....

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1111d5bf15ca..8675ddf558c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
 	if (stat(path, &st) == 0)
 		return 1;
 
+	/* Look for cpu sysfs (specific to s390) */
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
+		  sysfs, name);
+	if (stat(path, &st) == 0)
+		return 1;
+
 	return 0;
 }
 
-- 
2.14.3
