From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/13] perf pmu: Fix parser error for uncore event alias
Date: Fri, 29 Mar 2019 10:38:01 -0300
Message-ID: <20190329133801.21004-14-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf fails to parse uncore event alias, for example:

  # perf stat -e unc_m_clockticks -a --no-merge sleep 1
  event syntax error: 'unc_m_clockticks'
                       \___ parser error

Current code assumes that the event alias is from one specific PMU.

To find the PMU, perf strcmps the PMU name of event alias with the real
PMU name on the system.

However, the uncore event alias may be from multiple PMUs with common
prefix. The PMU name of uncore event alias is the common prefix.

For example, UNC_M_CLOCKTICKS is clock event for iMC, which include 6
PMUs with the same prefix "uncore_imc" on a skylake server.

The real PMU names on the system for iMC are uncore_imc_0 ...
uncore_imc_5.

The strncmp is used to only check the common prefix for uncore event
alias.

With the patch:

  # perf stat -e unc_m_clockticks -a --no-merge sleep 1
  Performance counter stats for 'system wide':

       723,594,722      unc_m_clockticks [uncore_imc_5]
       724,001,954      unc_m_clockticks [uncore_imc_3]
       724,042,655      unc_m_clockticks [uncore_imc_1]
       724,161,001      unc_m_clockticks [uncore_imc_4]
       724,293,713      unc_m_clockticks [uncore_imc_2]
       724,340,901      unc_m_clockticks [uncore_imc_0]

       1.002090060 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")
Link: http://lkml.kernel.org/r/1552672814-156173-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6199a3174ab9..e0429f4ef335 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -732,10 +732,20 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 
 		if (!is_arm_pmu_core(name)) {
 			pname = pe->pmu ? pe->pmu : "cpu";
+
+			/*
+			 * uncore alias may be from different PMU
+			 * with common prefix
+			 */
+			if (pmu_is_uncore(name) &&
+			    !strncmp(pname, name, strlen(pname)))
+				goto new_alias;
+
 			if (strcmp(pname, name))
 				continue;
 		}
 
+new_alias:
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
-- 
2.20.1
