Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796B26ADD;
	Thu,  1 May 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124922; cv=none; b=kNXNdY1BiyNYOPpXdYwwv2TlTcREQURoE/X3RZ7eiUbLLV2B3qMKkP+zXlQs2z6Voc3TRW6nFSGr0qWHm4b4aRXsCdjR4Zhs6GNX34Z/gcY3FjJql6J1SiHYA5MqWakHvpd+Y/EBNW+RfZ1/jdbnvuCiQBIFB1WmDVAS4xZO1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124922; c=relaxed/simple;
	bh=8qtcsAanPDMiYbgqm1wJQ+JhBnwTnN0EQq/sTw0wVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vv67MfQBFZuZVxQAyU9cWhbynfHTo6ty1WmNLvsjrgsqRYjkXfDRvCTVHg9StPbN4oh2LdbIHbAAdthSDxAkSu/T+r/W/XTr1gb7hkNEg1MfM94q3abGcOhdmbF8PnJ5jTvMyMGAl2+dTNnpp6k92pxZ0JVBS23F/b+Y4CLORYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuQgwo6D; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuQgwo6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746124921; x=1777660921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8qtcsAanPDMiYbgqm1wJQ+JhBnwTnN0EQq/sTw0wVH0=;
  b=GuQgwo6DvBEMjRIcKavhGb51QLeK/R86spFF/xhkUOWBS1TdPdZokUcR
   aCoqdal8xLFAqicqgCZ4FRoFk51PXnDNVAfkQfObcz94VVfTdN9Wf6Mp7
   eTecUIEMA6Qzr4AZSB9ujt7+G1b/KARURo4lLoQfweMaqYPbEIVP7z/hE
   OtPyNlHQ9WSpXXcqYD1quWQ3WNWMQYDV7K2hl7x9Bjco0k4xfSr/qmY8J
   Z7xHcfbAoA9K5UT7yLWD062V0ZOsCPIJF3GRcVUQY36H2ThbhcEMeKQyA
   UJifHMAju6c/3KN/K0h/GfOT0yd7AtjUDuPe+TToqju5S264EQlqMvDSl
   Q==;
X-CSE-ConnectionGUID: /SWgMc+dQxybYlS2W+e8Dw==
X-CSE-MsgGUID: 47fI7DqASLy9JqLToiJAFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58793613"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58793613"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 11:42:00 -0700
X-CSE-ConnectionGUID: 3Wa1chpERi2qba44yA+3jQ==
X-CSE-MsgGUID: nKElqJEMQ/Svg1Y4V2P/wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="139431744"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.220.41])
  by orviesa004.jf.intel.com with ESMTP; 01 May 2025 11:41:59 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH] perf top: populate PMU capabilities data in perf_env
Date: Thu,  1 May 2025 13:41:43 -0500
Message-ID: <20250501184143.873536-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling perf top with brach filters enabled on Intel hybrid CPU's
with branch counter event logging support results in a segfault.

$ ./perf top -e '{cpu_core/cpu-cycles/,cpu_core/event=0xc6,umask=0x3,\
	frontend=0x11,name=frontend_retired_dsb_miss/}' -j any,counter
perf: Segmentation fault
-------- backtrace --------
./perf() [0x55f460]
/lib64/libc.so.6(+0x1a050) [0x7fd8be227050]
./perf() [0x57b4a7]
./perf() [0x561e5a]
./perf() [0x604a81]
./perf() [0x4395b5]
./perf() [0x601732]
./perf() [0x439bc1]
./perf() [0x5d35b3]
./perf() [0x43936c]
/lib64/libc.so.6(+0x70ba8) [0x7fd8be27dba8]
/lib64/libc.so.6(+0xf4b8c) [0x7fd8be301b8c]

The cause is that perf_env__find_br_cntr_info tries to access a
null pointer pmu_caps in the perf_env struct. Presumably this would
also be an issue when using the cpu_pmu_caps structure available for
homogeneous core CPU's.

Fix this by populating cpu_pmu_caps and pmu_caps structures with
values from sysfs when calling perf top with branch stack sampling
enabled.

Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-top.c |   8 +++
 tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h    |   1 +
 3 files changed, 123 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1061f4eebc3f..c2688e4ef3c4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
 	if (opts->branch_stack && callchain_param.enabled)
 		symbol_conf.show_branchflag_count = true;
 
+	if (opts->branch_stack) {
+		status = perf_env__read_core_pmu_caps(&perf_env);
+		if (status) {
+			pr_err("PMU capability data is not available\n");
+			goto out_delete_evlist;
+		}
+	}
+
 	sort__mode = SORT_MODE__TOP;
 	/* display thread wants entries to be collapsed in a different tree */
 	perf_hpp_list.need_collapse = 1;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 36411749e007..37ed6dc52cf3 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct perf_env *env)
 	return env->nr_cpus_avail ? 0 : -ENOENT;
 }
 
+static int __perf_env__read_core_pmu_caps(struct perf_pmu *pmu,
+					  int *nr_caps, char ***caps,
+					  unsigned int *max_branches,
+					  unsigned int *br_cntr_nr,
+					  unsigned int *br_cntr_width)
+{
+	struct perf_pmu_caps *pcaps = NULL;
+	char *ptr, **tmp;
+	int ret = 0;
+
+	*nr_caps = 0;
+	*caps = NULL;
+
+	if (!pmu->nr_caps)
+		return 0;
+
+	*caps = zalloc(sizeof(char *) * pmu->nr_caps);
+	if (!*caps)
+		return -ENOMEM;
+
+	tmp = *caps;
+	list_for_each_entry(pcaps, &pmu->caps, list) {
+
+		if (asprintf(&ptr, "%s=%s", pcaps->name, pcaps->value) < 0) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		*tmp++ = ptr;
+
+		if (!strcmp(pcaps->name, "branches"))
+			*max_branches = atoi(pcaps->value);
+
+		if (!strcmp(pcaps->name, "branch_counter_nr"))
+			*br_cntr_nr = atoi(pcaps->value);
+
+		if (!strcmp(pcaps->name, "branch_counter_width"))
+			*br_cntr_width = atoi(pcaps->value);
+	}
+	*nr_caps = pmu->nr_caps;
+	return 0;
+error:
+	while (tmp-- != *caps)
+		free(*tmp);
+	free(*caps);
+	*caps = NULL;
+	*nr_caps = 0;
+	return ret;
+}
+
+int perf_env__read_core_pmu_caps(struct perf_env *env)
+{
+	struct perf_pmu *pmu = NULL;
+	struct pmu_caps *pmu_caps;
+	int nr_pmu = 0, i = 0, j;
+	int ret;
+
+	nr_pmu = perf_pmus__num_core_pmus();
+
+	if (!nr_pmu)
+		return -ENODEV;
+
+	if (nr_pmu == 1) {
+		pmu = perf_pmus__scan_core(NULL);
+		if (!pmu)
+			return -ENODEV;
+		ret = perf_pmu__caps_parse(pmu);
+		if (ret < 0)
+			return ret;
+		return __perf_env__read_core_pmu_caps(pmu, &env->nr_cpu_pmu_caps,
+						      &env->cpu_pmu_caps,
+						      &env->max_branches,
+						      &env->br_cntr_nr,
+						      &env->br_cntr_width);
+	}
+
+	pmu_caps = zalloc(sizeof(*pmu_caps) * nr_pmu);
+	if (!pmu_caps)
+		return -ENOMEM;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (perf_pmu__caps_parse(pmu) <= 0)
+			continue;
+		ret = __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].nr_caps,
+						     &pmu_caps[i].caps,
+						     &pmu_caps[i].max_branches,
+						     &pmu_caps[i].br_cntr_nr,
+						     &pmu_caps[i].br_cntr_width);
+		if (ret)
+			goto error;
+
+		pmu_caps[i].pmu_name = strdup(pmu->name);
+		if (!pmu_caps[i].pmu_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		i++;
+	}
+
+	env->nr_pmus_with_caps = nr_pmu;
+	env->pmu_caps = pmu_caps;
+
+	return 0;
+error:
+	for (i = 0; i < nr_pmu; i++) {
+		for (j = 0; j < pmu_caps[i].nr_caps; j++)
+			free(pmu_caps[i].caps[j]);
+		free(pmu_caps[i].caps);
+		free(pmu_caps[i].pmu_name);
+	}
+	free(pmu_caps);
+	return ret;
+}
+
 const char *perf_env__raw_arch(struct perf_env *env)
 {
 	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d90e343cf1fa..135a1f714905 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -152,6 +152,7 @@ struct btf_node;
 
 extern struct perf_env perf_env;
 
+int perf_env__read_core_pmu_caps(struct perf_env *env);
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
-- 
2.49.0

