Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6F189517;
	Mon,  9 Sep 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907298; cv=none; b=JC+s+HplSIzgzLG8KffWV2tVXw6YA7QHT0PLk+tJmexYB+CU45kYozvpEXdHAN0KwKY+ho+lb7pWfBXHCwaZzCaLnCh7FuG36sAUXiu4nxuBcwL7SS+Ile1GiKTu1CgLHFUDEiUiqvdd0FS2ErTpDZtUH+MFT6EWBC2Sfjwvmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907298; c=relaxed/simple;
	bh=WnCghRFlzYOP5F1Yp27TU0E0lq5lDZ+J31399wd0VDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IPuOItkSuzmMM8vNPzusNZqEap+cHFGrcJWVK8h6esH3Emrln9j4U1rF0G6do7ZuyJ5IygR9Eh03HlLe5hodzCtmAt3a8/AslZOE2sceGTeo1W3PQZivY7pnQXQoTkCIPEaTdWXuC6LKrIVgay+eutHJC8lu5sjpMfUAtEsr704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnplpmEX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnplpmEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725907296; x=1757443296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WnCghRFlzYOP5F1Yp27TU0E0lq5lDZ+J31399wd0VDk=;
  b=jnplpmEXk52Gn5joU4fsrTiqmx6Oxau5j4tFS71AzWOEBX0jKEqLSlIc
   RjQMJh6idf4VLEIAcfVJL9TyK7846jMNPhj2iL5A/7mGovi/2DUrvoiof
   vZIrd02gSdxVz2AuJLTMzMdkRTcxyOapZx6gqjAA4g/+bK4o7vCgJtrXA
   3mZycoOtH35QUEfQxA9njh6tfvqj3AG1BbiDCWsbAJHqJF7E+aIxM09hN
   6J7SknLwPdKhgrl2JjP4xykMLPUkx/VnaoyPW9rGX4mtNWey4X6t4QOn4
   bEh5bkuRVaZH/+XlnOUrM7YoAYabexpkDSNP5jXml7V4y7aS+V7pVwgZP
   g==;
X-CSE-ConnectionGUID: p29RZ0mDTM+FWtfy5hMDhA==
X-CSE-MsgGUID: Ml0uglGpScGdeU6oQEwXcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="13446609"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="13446609"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 11:41:36 -0700
X-CSE-ConnectionGUID: fJ+mdhOMSNGHkjCwZHdHAA==
X-CSE-MsgGUID: lANOy5GLS56lgBnND42pYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="97469002"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2024 11:41:35 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf env: Find correct branch counter info on hybrid
Date: Mon,  9 Sep 2024 11:42:00 -0700
Message-Id: <20240909184201.553519-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

No event is printed in the "Branch Counter" column on hybrid machines.

For example,
 $perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S"
 -j any,counter
 $perf report --total-cycles

 # Branch counter abbr list:
 # cpu_core/branch-instructions/pp = A
 # cpu_core/branches/ = B
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles  Branch Counter
 # ...............  ..............  ...........  ..........  ..............
           44.54%          727.1K        0.00%           1   |+   |+   |
           36.31%          592.7K        0.00%           2   |+   |+   |
           17.83%          291.1K        0.00%           1   |+   |+   |

The branch counter information (br_cntr_width and br_cntr_nr) in the
perf_env is retrieved from the CPU_PMU_CAPS. However, the CPU_PMU_CAPS
is not available on hybrid machines. Without the width information, the
number of occurrences of an event cannot be calculated.

For a hybrid machine, the caps information should be retrieved from the
PMU_CAPS, and stored in the perf_env->pmu_caps.

Add a perf_env__find_br_cntr_info() to return the correct branch counter
information from the corresponding fields.

Fixes: 6f9d8d1de2c6 ("perf script: Add branch counters")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-script.c |  5 +++--
 tools/perf/util/annotate.c  |  5 +++--
 tools/perf/util/env.c       | 15 +++++++++++++++
 tools/perf/util/env.h       |  3 +++
 tools/perf/util/session.c   |  6 ++++--
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index dbe792b52c5c..a644787fa9e1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1241,10 +1241,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 	}
 
 	if (PRINT_FIELD(BRCNTR)) {
-		unsigned int width = evsel__env(evsel)->br_cntr_width;
-		unsigned int i = 0, j, num, mask = (1L << width) - 1;
 		struct evsel *pos = evsel__leader(evsel);
+		unsigned int i = 0, j, num, mask, width;
 
+		perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
+		mask = (1L << width) - 1;
 		printed += fprintf(fp, "br_cntr: ");
 		evlist__for_each_entry_from(evsel->evlist, pos) {
 			if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4990c70b1794..c6ebde9d40a8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -333,14 +333,15 @@ static int symbol__account_br_cntr(struct annotated_branch *branch,
 {
 	unsigned int br_cntr_nr = evsel__leader(evsel)->br_cntr_nr;
 	unsigned int base = evsel__leader(evsel)->br_cntr_idx;
-	unsigned int width = evsel__env(evsel)->br_cntr_width;
 	unsigned int off = offset * evsel->evlist->nr_br_cntr;
-	unsigned int i, mask = (1L << width) - 1;
 	u64 *branch_br_cntr = branch->br_cntr;
+	unsigned int i, mask, width;
 
 	if (!br_cntr || !branch_br_cntr)
 		return 0;
 
+	perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
+	mask = (1L << width) - 1;
 	for (i = 0; i < br_cntr_nr; i++) {
 		u64 cntr = (br_cntr >> i * width) & mask;
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index a459374d0a1a..1edbccfc3281 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -624,3 +624,18 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 	free(cap_eq);
 	return NULL;
 }
+
+void perf_env__find_br_cntr_info(struct perf_env *env,
+				 unsigned int *nr,
+				 unsigned int *width)
+{
+	if (nr) {
+		*nr = env->cpu_pmu_caps ? env->br_cntr_nr :
+					  env->pmu_caps->br_cntr_nr;
+	}
+
+	if (width) {
+		*width = env->cpu_pmu_caps ? env->br_cntr_width :
+					     env->pmu_caps->br_cntr_width;
+	}
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 2a2c37cc40b7..51b36c36019b 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -192,4 +192,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap);
 
 bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
+void perf_env__find_br_cntr_info(struct perf_env *env,
+				 unsigned int *nr,
+				 unsigned int *width);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b492300ec959..dbaf07bf6c5f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -856,7 +856,6 @@ static void branch_stack__printf(struct perf_sample *sample,
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	bool callstack = evsel__has_branch_callstack(evsel);
 	u64 *branch_stack_cntr = sample->branch_stack_cntr;
-	struct perf_env *env = evsel__env(evsel);
 	uint64_t i;
 
 	if (!callstack) {
@@ -900,8 +899,11 @@ static void branch_stack__printf(struct perf_sample *sample,
 	}
 
 	if (branch_stack_cntr) {
+		unsigned int br_cntr_width, br_cntr_nr;
+
+		perf_env__find_br_cntr_info(evsel__env(evsel), &br_cntr_nr, &br_cntr_width);
 		printf("... branch stack counters: nr:%" PRIu64 " (counter width: %u max counter nr:%u)\n",
-			sample->branch_stack->nr, env->br_cntr_width, env->br_cntr_nr);
+			sample->branch_stack->nr, br_cntr_width, br_cntr_nr);
 		for (i = 0; i < sample->branch_stack->nr; i++)
 			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, branch_stack_cntr[i]);
 	}
-- 
2.38.1

