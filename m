Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC005383A3;
	Thu,  5 Sep 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556029; cv=none; b=an1y43Tf+vdaESC59sWa/Xca6BMN8nUygMcu0IY5AZHwHlgXcsCquKq1zFtAV8+5N3rxi72OpyKhAgOUm1AkWdlZs7gmP9VQXeRJfoVLO5NoRw0SuACyIsRyBTfsy4o4cVBMeCH60cwKEAsptXGBtniKIwNnfZGBPIecVmFk2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556029; c=relaxed/simple;
	bh=UiUHNMc++kpVqMqkilCV75ZItRfEtPpUg6FY//p86+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eg47q7XE4zPasmEK3HoQIMSFgjXsDnGY/yEiOmW+h1rUpEU30MrTsxmuIIsapwEOrPl52r/HdH4wRdE8UiwzeM2h7AWcGmDGiXcFXI6I3du/N1RN/L3hQBEE5l2yyuy6byBymvsXrjWOBuhUUu7gYei6pkVl5q5REoWLpomwXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nr/s0Mhe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nr/s0Mhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725556028; x=1757092028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UiUHNMc++kpVqMqkilCV75ZItRfEtPpUg6FY//p86+A=;
  b=nr/s0MhezzTsZpEBgkdOmVMExoEtdHtLlg44ho4Z9cUi8iO6gpBVKeBV
   t5BvA8JUlb+OwT3TaNj14Jy4jf8vJf2yinHVGx2PLQKs8yqp/Flbubt9h
   NYr+i6aKdU3SV698+S7UXz42NqS20+AstFO+ciO11tWbzWfiVfWWMpcES
   EzMHAYC90/ZiW0LbTdwLL/7KN0/nyuEKd+tYk+C919eClwSIRE5GKQWB6
   7tZ9GcKmYgPw8vJkbqMCLKY70HFNdxc0gTbNEmJZQdkS9XQMWBivIxBL0
   zufFL3yLFhs8Sp3+T0c4KhQxOFFtzRUuKj/wXI2cbxQwwrmLxxL53shzN
   Q==;
X-CSE-ConnectionGUID: A6Vaw8MpTd2NrqvklyCSLQ==
X-CSE-MsgGUID: kpMpYZ1+QX2iQAaXbRMoAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41769166"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="41769166"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:07:07 -0700
X-CSE-ConnectionGUID: Ly9AIMJ7Rxu1IoNMNsAmuQ==
X-CSE-MsgGUID: HZ9giLFDQ2yQzwGgnCKtlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70480522"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 05 Sep 2024 10:07:07 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org
Cc: irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] perf mem: Check mem_events for all eligible PMUs
Date: Thu,  5 Sep 2024 10:07:35 -0700
Message-Id: <20240905170737.4070743-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current perf_pmu__mem_events_init() only checks the availability of
the mem_events for the first eligible PMU. It works for non-hybrid
machines and hybrid machines that have the same mem_events.

However, it may bring issues if a hybrid machine has a different
mem_events on different PMU, e.g., Alder Lake and Raptor Lake. A
mem-loads-aux event is only required for the p-core. The mem_events on
both e-core and p-core should be checked and marked.

The issue was not found, because it's hidden by another bug, which only
records the mem-events for the e-core. The wrong check for the p-core
events didn't yell.

Fixes: abbdd79b786e ("perf mem: Clean up perf_mem_events__name()")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-c2c.c     |  2 +-
 tools/perf/builtin-mem.c     |  2 +-
 tools/perf/util/mem-events.c | 14 +++++++++++++-
 tools/perf/util/mem-events.h |  2 +-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index cd2bd573bfc3..cef95b2781c0 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3261,7 +3261,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		return -1;
 	}
 
-	if (perf_pmu__mem_events_init(pmu)) {
+	if (perf_pmu__mem_events_init()) {
 		pr_err("failed: memory events not supported\n");
 		return -1;
 	}
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 18e5f9a0ddc2..f6be7ffc9e45 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -88,7 +88,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 		return -1;
 	}
 
-	if (perf_pmu__mem_events_init(pmu)) {
+	if (perf_pmu__mem_events_init()) {
 		pr_err("failed: memory events not supported\n");
 		return -1;
 	}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index be048bd02f36..17f80013e574 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -192,7 +192,7 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
 	return !stat(path, &st);
 }
 
-int perf_pmu__mem_events_init(struct perf_pmu *pmu)
+static int __perf_pmu__mem_events_init(struct perf_pmu *pmu)
 {
 	const char *mnt = sysfs__mount();
 	bool found = false;
@@ -219,6 +219,18 @@ int perf_pmu__mem_events_init(struct perf_pmu *pmu)
 	return found ? 0 : -ENOENT;
 }
 
+int perf_pmu__mem_events_init(void)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
+		if (__perf_pmu__mem_events_init(pmu))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
 void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 {
 	int j;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index ca31014d7934..a6fc2a593938 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -30,7 +30,7 @@ extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
-int perf_pmu__mem_events_init(struct perf_pmu *pmu);
+int perf_pmu__mem_events_init(void);
 
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
 struct perf_pmu *perf_mem_events_find_pmu(void);
-- 
2.38.1

