Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9F1BC20
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112455; cv=none; b=BpfgB2PSeDSENKU4pWp8zlkph00h6o/7+I/h4Td+ZUPkA59eoiUyKEkUle36IJ8rigrLVQNCcqVgoZJ8VM3I56WzUj5sCriQBgvINAkjxB0H6pw81ybZUfeA1DJdNeaiAkW8zm856lFUldnwF3ar6ydUsbQsmZZDZv/U0AWQLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112455; c=relaxed/simple;
	bh=ZhWpi/y0IU48IBt0+u5WIP11qQFZYZwVjrYO5lrfaHY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M2b4oZKnQm/T2YUSFPq+W5eRug2VkSlyzE1XOoHjuE6JbjB4R1XsQ4ItpTafF7dZghLXwzovcjUoOPKeR7n1LMF9lF/csLFRxSPBgOwTGSigEkFithbcY7qa7ao+qj+tJt7IqqUKz86IzFMay7IIzxnWLIam7MWK3X6EuECX4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8uHI/eA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8uHI/eA"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30cd709b40so4707945276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112453; x=1731717253; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3pEKqmDVF94310Lcc6dZMS2bWB1ZbAcb+eC42TYfHQ=;
        b=J8uHI/eA87OHRToKcK00IaNg088303wm6zoTCis9Chn03tl5iEpfHqLdcoXmhwSV3y
         qyHvnQ64T0A2jAGWJWBKR/jbOFs/XNX/JdT1ZEfIwqWfX5aJ4Pfpmv5xvZe2+2yKFexE
         73Ts5xq8EjcTmSN+ZygR5kY4QshljRL336ES2rvuY2u0XdQMsxyUmshO1XWqyxMqhf19
         VK86VJz4DQ/UDpXblcJ5EKOixo7rIDETkh1an6qu2vKEGWGCbTCHXL6yvvQr63G7aWZs
         m5yHaNumxWI8BuILZQVnVXyc0gPt4NgRRscbTZAjagVjagkbLeC8ChTla8b9Ozmc/KgN
         I8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112453; x=1731717253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3pEKqmDVF94310Lcc6dZMS2bWB1ZbAcb+eC42TYfHQ=;
        b=VUAvtxm7R13vo/kLHjlvjZ12CbDXj9oo3IS0EbQrUCG8Vu+r4u3FHyVIAuf+tRoxFp
         6BUv8yPW4SCBTYlHm21Qs2yVB/CGMIYMQp/BrTv1pkuMoHP6uzo/w6KF+r8851owWOp6
         LCf34V8mrI7HnbyWZPiiM5HjcMqpeZJjAEJdoKgxkpv60ZmFaa37vxXV90zD7Xh3Pz6d
         OV7gnKxoqR5rfn/LDUWPGMUx+hVjlL9lFi1wn+Hq6vjl9I9yGhVVmfarNrH+5WCSQ6pk
         g7lpn925RYmloPga+yEmCTfQejvCQbbvUuC5Wrj0POvxbuRNCvHHM6Ivw4xM2KfAR3dk
         WaSA==
X-Forwarded-Encrypted: i=1; AJvYcCUdbxVOhatDycGshn70ttlq/uRzHZXVsF/QThWiBHYf+rDWZPcFBGv/s+3MeEH8HXdmdQfPuOXK0Hg2Fh/2+VJv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/jQeRbyFbMW1woLCNPH5WaDNmRyfRtOoFJ4EnCjdKHHDcG8S
	B47dERRuXkRfJdP3IUsq71SEpZSaSMtT4V2joyzaIDhj+2Vg4/2xLWRODfvqFJaNYJUFfgMoNKv
	eJRRgdw==
X-Google-Smtp-Source: AGHT+IHwXisb0jQtCfPXPATX9x3aIDrrVh9nNhkJfzC+5h6GeQ12glFc4TQS/m4qo0uUqtt926B7rRvv1w4p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:2706:0:b0:e33:3af2:4631 with SMTP id
 3f1490d57ef6-e337f861c85mr9853276.4.1731112452780; Fri, 08 Nov 2024 16:34:12
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:33:56 -0800
In-Reply-To: <20241109003358.461437-1-irogers@google.com>
Message-Id: <20241109003358.461437-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109003358.461437-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v8 5/7] perf pmu: Add calls enabling the hwmon_pmu
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
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index f780e30aa259..fc1bf86c5063 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -56,6 +56,7 @@
 #include "off_cpu.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "hwmon_pmu.h"
 #include "tool_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
@@ -1799,6 +1800,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_hwmon(evsel))
+		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
+
 	if (evsel__is_retire_lat(evsel))
 		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
 
@@ -2465,6 +2469,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
2.47.0.277.g8800431eea-goog

