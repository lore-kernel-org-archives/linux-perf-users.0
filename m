Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A91FE103
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026401; cv=none; b=WAagVbj2gjAjWS42qvxGBp9ng3wj2axHDd0LM6Ca3O7xfLNV4OBNY97INTmQ6ZUPiLcdY3KD2elpnPgvWP9lbrsHtAVpuiJWbnasQnLO6rjUJ3YZKgRkKBsk1SwfoMFF4zIKX8V5e9INFy0RkbP2Rc2zj0WzYhe4Bw2QF5gfyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026401; c=relaxed/simple;
	bh=Oc8ClCxVsaSNYgooDger5/duQRh6U+YDBA8f5hiUFH0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WTPeLdMEN5ziL8JzrCkHT27S+4OI6xdeiWWMb8vuGdVBhOILMj33jLrYwqxCynEIr184n3ESqy8ysCajdVx5NrSsVFjc1u3yWchYKf67F1IXxnUWnrSt0KfRqlojC2FSE/aPGY0iaur+uNNDhxq41dpKgfqFazkEQ+PIkWcxuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+hBlA0R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+hBlA0R"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so43260607b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026399; x=1729631199; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bBid4S83yP862BWCiO6Sw79EjN9WeWCpPO/pEo3YWg=;
        b=x+hBlA0RCuBWHWCVI7FL8CZJ6UVXh89gEBdNfaZDt1ZTfd6chvfRnWBsWFmt/TeyWK
         gkAhW42QVToW3rSv6Oxgncnf8yYSOlTA+osXt9AtJzKQlNvSAVjol77zI5C7xjpSyyjX
         ncg+KPcoVJeOf4KUkZC4LDzBP4or0h81ReirNGUm0nMrgNAm0Ee9QIX4hfig+e6HXpkX
         vuMSz+v3NOAjtt4nY/WAl6a1DOGE4X3VZSXXsX1DljY0bkTnIrZK8K1vEWu/L/7gnOOJ
         gQLu/5XNxEm/gwGcQ57fgjL5C8J4yl523URX8KzOduphhxYXnOwlsynMwK6zg/ScU0os
         zVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026399; x=1729631199;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bBid4S83yP862BWCiO6Sw79EjN9WeWCpPO/pEo3YWg=;
        b=KG6QOAhbivvZGFfoelq/WuAhm6eyiDgEorcoXfThqCzXMES5JS4KWsWYZedUEyswlS
         jBTuz14PxW+X/76sx4+nSKAKuBa0fmsRa8f7pXL9BDqp7WPUzt9fG4HiStZO64TorafC
         YqXvKxh6u4S6Mpgo1eZi5b20D5nE6x6B7Lqzcnzfjo7Rbhdk5R36qJI5YjtEFHbUinGi
         dLO5NpvbuNh1ZtFCuqIzvcYifgP16LA6nNFgPqMq/pZsB+uOBRI19yQ2Go9pxrIpHmdp
         oMJg2wtJ9tCFGc6f+Eb8NAzUozvq8xImUG8ItT/HlVEzyuXmFqKDDbQiDjGPj+fNOldQ
         rNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFCJU7bGe85Gt6TSBWWEP/+K7Vf0tztLt9OiVem3HbMBBShcIjFvgwUUMPuG+9tD0WEI+uaIsETnZvB6DoPBS2@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgnjB3lwA88/82BUfrq35zdMRLWj564qiUrn598BgGU9w5t9k
	BH8SYiIzBhay4vq8gDv/agimd8gZCPIlFpTOgh2GcsOUM3MgDmwd1K5ZcR1dbPLuGlZmlNMWa2/
	kq3cVWg==
X-Google-Smtp-Source: AGHT+IFuf5Zq432sMgB7zAdZ9lez0gSQmyl7JVY6cuU+PctKBUYc3+Tj53t0rCEwycgn9K5rYWwSqR5Yz0Wu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:690c:d8b:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6e3d41e6b49mr219257b3.7.1729026398657; Tue, 15 Oct 2024
 14:06:38 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:26 -0700
In-Reply-To: <20241015210629.1150428-1-irogers@google.com>
Message-Id: <20241015210629.1150428-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015210629.1150428-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 3/5] perf pmu: Add calls enabling the hwmon_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the base PMU calls necessary for hwmon_pmu(s) to be
created/deleted and events found, listed, opened and read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c |  9 +++++++++
 tools/perf/util/pmu.c   | 20 ++++++++++++++++++++
 tools/perf/util/pmus.c  |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ed0d4d20e357..f5e528a5d177 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -50,6 +50,7 @@
 #include "off_cpu.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
@@ -1680,6 +1681,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_hwmon(evsel))
+		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+
 	if (evsel__is_retire_lat(evsel))
 		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
 
@@ -2124,6 +2128,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 					    start_cpu_map_idx,
 					    end_cpu_map_idx);
 	}
+	if (evsel__is_hwmon(evsel)) {
+		return evsel__hwmon_pmu_open(evsel, threads,
+					     start_cpu_map_idx,
+					     end_cpu_map_idx);
+	}
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0789758598c0..a02df2c80f42 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -18,6 +18,7 @@
 #include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
+#include "hwmon_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
 #include <util/pmu-bison.h>
@@ -1529,6 +1530,9 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
 {
 	struct parse_events_term *term;
 
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__config_terms(pmu, attr, terms, err);
+
 	list_for_each_entry(term, &terms->terms, list) {
 		if (pmu_config_term(pmu, attr, term, terms, zero, apply_hardcoded, err))
 			return -EINVAL;
@@ -1661,6 +1665,11 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	info->scale    = 0.0;
 	info->snapshot = false;
 
+	if (perf_pmu__is_hwmon(pmu)) {
+		ret = hwmon_pmu__check_alias(head_terms, info, err);
+		goto out;
+	}
+
 	/* Fake PMU doesn't rewrite terms. */
 	if (perf_pmu__is_fake(pmu))
 		goto out;
@@ -1834,6 +1843,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return false;
 	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
 		return false;
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
@@ -1845,6 +1856,9 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__num_events(pmu);
+
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
@@ -1908,6 +1922,9 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	int ret = 0;
 	struct strbuf sb;
 
+	if (perf_pmu__is_hwmon(pmu))
+		return hwmon_pmu__for_each_event(pmu, state, cb);
+
 	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
@@ -2303,6 +2320,9 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 
 void perf_pmu__delete(struct perf_pmu *pmu)
 {
+	if (perf_pmu__is_hwmon(pmu))
+		hwmon_pmu__exit(pmu);
+
 	perf_pmu__del_formats(&pmu->format);
 	perf_pmu__del_aliases(pmu);
 	perf_pmu__del_caps(pmu);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 107de86c2637..5c3e88adb9e6 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -15,6 +15,7 @@
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
+#include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
@@ -234,6 +235,7 @@ static void pmu_read_sysfs(bool core_only)
 	if (!core_only) {
 		tool_pmu = perf_pmus__tool_pmu();
 		list_add_tail(&tool_pmu->list, &other_pmus);
+		perf_pmus__read_hwmon_pmus(&other_pmus);
 	}
 	list_sort(NULL, &other_pmus, pmus_cmp);
 	if (!list_empty(&core_pmus)) {
-- 
2.47.0.rc1.288.g06298d1525-goog

