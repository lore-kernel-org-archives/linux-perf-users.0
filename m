Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D382741B5
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312981; cv=none; b=FAWGFdgpdl/wM+suAqDtWvSdTMsIU+/JOaLDGB8ugtt2sf4j8vALz1ht78czHFjgP8pgx/8iPX1P5iDQDGo/SUFF93T4u2GjafyCAtdj4OKyiHtNWJT4V3Gx5ofjnMDYvr7Mc+f/U1EBC9vHTF3Fx4cnT+Ysm5W8c02TqO6GOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312981; c=relaxed/simple;
	bh=lPXmRk8uXh05O798oSMHwJXgWz4TAAy36TccZE5ZHik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MuKH8uYQ9UYFWvTZxT4VLTxUiPiRFXdX6lkAR8Dq8zsmS2t8LIuQID2EV8FPZUdFKFoHlareRNRJxf0b4RwbEL5xcFg0HY6By+bHH3zVi0ICgZLSlCqGLbbk1CsXDchcKCrpAi/cDtdI3CAXk+dfNc3wjKSp5NT7IQ2ANKDuFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MM2MdW1R; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MM2MdW1R"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2369261224bso3373125ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312980; x=1753917780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iO4rKgWRrLvd7Hy4UwJjm8FO19N1xYwxxMcu1mvGBiY=;
        b=MM2MdW1RW8FXKHHr0dGvbyAaK+V4TjxYlDXdDnDVBlLnARJnZtrYaCWJDbr0e6lWwv
         5J78VZfpWcDv/X3hCzgc1pXyqCrT53JPkq8xMKlMeLLPv7jUIXGHK7nSSPYjDgi+ImV3
         T78zZRl4Q1XVJ85BpjIL3044EbDqNrC9VOCw2tdiOH3c6YzxJk7kFsX60wGs0rEh60Xl
         9jwxtL5HVyZol1FQDfgh4mQDExeJFqSCZ0TrINlJQPWxPGC+J1sYvp0kkuwqIg/maM6G
         HOkIZd7AipFWKL5QuFHIoYZDAmJ1/5LqDDIaF1zCoUwFnl4tG6wV1mAap7pz0GwbHm6s
         tPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312980; x=1753917780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO4rKgWRrLvd7Hy4UwJjm8FO19N1xYwxxMcu1mvGBiY=;
        b=TFvIEH2FzLXXZlAIydUu2vmKrshB1frLSgZOJm4XeRFhXAZ2H2Iy88wqNKBiVZWFvI
         Djse4l7GYHX/ty9Te77pQXo554bZcr0dJF27H1DOjCZ4qrfF6bEus5iuEO0hE/qBJEC9
         AAgOfiHbJZq+Ka4pQbg0sRpQnP9JMF5QLepJVAT6rh4Xc7Cy8SoCv1LewWBkF2wr4WK4
         fNiZrnsH9pPhM+V5XYjwQKemMpUz3r3D5E5Aa9Uyo9JTsawZI9ItEbgyKWYnzFBYrw6r
         wUfjDWuAlrG3SHnqi5+NBnL4Wp02bmubxhPYvhPHNwmpN4TBM3jYi+asILdMS2Sz0I2d
         7tVg==
X-Forwarded-Encrypted: i=1; AJvYcCUzgbezW28P1xdcydfbHtdlEH5zQ+tgeTMpWYKLRxGUWwZNO8T5g9Swsnv2bTNyZ8RGSIx7c6o066PpQXFG+q4x@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZumhU9YBWKVjkrOJ84SBr1rONvcMW9/UaS81WJAbA0DgtuW9
	YWnUkMO+qd72qdPQ2Dzk1iaBM/iLBKqvIpNW6h52uVmPJRpO+hjI+fr9JvvpM8D16oJgIuqwGFt
	CtgeRobXWMA==
X-Google-Smtp-Source: AGHT+IElv9rsFOM3ePu7WcxiudoaJmlciEvfReOd45LNZWjcTIH+iNrkjFGLct1Xtx5g9/pH5/yAG1iz3G/n
X-Received: from plbmz3.prod.google.com ([2002:a17:903:3503:b0:234:c104:43f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68c:b0:223:619e:71da
 with SMTP id d9443c01a7336-23f981d3162mr75760735ad.49.1753312979629; Wed, 23
 Jul 2025 16:22:59 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:06 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-6-irogers@google.com>
Subject: [PATCH v8 05/16] perf tp_pmu: Add event APIs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Add event APIs for the tracepoint PMU allowing things like perf list
to function using it. For perf list add the tracepoint format in the
long description (shown with -v).

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c    |   7 +++
 tools/perf/util/tp_pmu.c | 115 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tp_pmu.h |   7 +++
 3 files changed, 129 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b09b2ea2407a..dc05233e8232 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -24,6 +24,7 @@
 #include "hwmon_pmu.h"
 #include "pmus.h"
 #include "tool_pmu.h"
+#include "tp_pmu.h"
 #include <util/pmu-bison.h>
 #include <util/pmu-flex.h>
 #include "parse-events.h"
@@ -1983,6 +1984,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 		return false;
 	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
 		return false;
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__have_event(pmu, name);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__have_event(pmu, name);
 	if (perf_pmu__is_drm(pmu))
@@ -1998,6 +2001,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__num_events(pmu);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__num_events(pmu);
 	if (perf_pmu__is_drm(pmu))
@@ -2068,6 +2073,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct hashmap_entry *entry;
 	size_t bkt;
 
+	if (perf_pmu__is_tracepoint(pmu))
+		return tp_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_hwmon(pmu))
 		return hwmon_pmu__for_each_event(pmu, state, cb);
 	if (perf_pmu__is_drm(pmu))
diff --git a/tools/perf/util/tp_pmu.c b/tools/perf/util/tp_pmu.c
index 42bd967a4530..e7534a973247 100644
--- a/tools/perf/util/tp_pmu.c
+++ b/tools/perf/util/tp_pmu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 #include "tp_pmu.h"
+#include "pmus.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <api/io_dir.h>
@@ -93,3 +94,117 @@ int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
 	close(events_dir.dirfd);
 	return ret;
 }
+
+bool perf_pmu__is_tracepoint(const struct perf_pmu *pmu)
+{
+	return pmu->type == PERF_TYPE_TRACEPOINT;
+}
+
+struct for_each_event_args {
+	void *state;
+	pmu_event_callback cb;
+	const struct perf_pmu *pmu;
+};
+
+static int for_each_event_cb(void *state, const char *sys_name, const char *evt_name)
+{
+	struct for_each_event_args *args = state;
+	char name[2 * FILENAME_MAX + 2];
+	/* 16 possible hex digits and 22 other characters and \0. */
+	char encoding[16 + 22];
+	char *format = NULL;
+	size_t format_size;
+	struct pmu_event_info info = {
+		.pmu = args->pmu,
+		.pmu_name = args->pmu->name,
+		.event_type_desc = "Tracepoint event",
+	};
+	char *tp_dir = get_events_file(sys_name);
+	char path[PATH_MAX];
+	int id, err;
+
+	if (!tp_dir)
+		return -1;
+
+	scnprintf(path, sizeof(path), "%s/%s/id", tp_dir, evt_name);
+	err = filename__read_int(path, &id);
+	if (err == 0) {
+		snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%x/", id);
+		info.encoding_desc = encoding;
+	}
+
+	scnprintf(path, sizeof(path), "%s/%s/format", tp_dir, evt_name);
+	put_events_file(tp_dir);
+	err = filename__read_str(path, &format, &format_size);
+	if (err == 0) {
+		info.long_desc = format;
+		for (size_t i = 0 ; i < format_size; i++) {
+			/* Swap tabs to spaces due to some rendering issues. */
+			if (format[i] == '\t')
+				format[i] = ' ';
+		}
+	}
+	snprintf(name, sizeof(name), "%s:%s", sys_name, evt_name);
+	info.name = name;
+	err = args->cb(args->state, &info);
+	free(format);
+	return err;
+}
+
+static int for_each_event_sys_cb(void *state, const char *sys_name)
+{
+	return tp_pmu__for_each_tp_event(sys_name, state, for_each_event_cb);
+}
+
+int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+{
+	struct for_each_event_args args = {
+		.state = state,
+		.cb = cb,
+		.pmu = pmu,
+	};
+
+	return tp_pmu__for_each_tp_sys(&args, for_each_event_sys_cb);
+}
+
+static int num_events_cb(void *state, const char *sys_name __maybe_unused,
+			 const char *evt_name __maybe_unused)
+{
+	size_t *count = state;
+
+	(*count)++;
+	return 0;
+}
+
+static int num_events_sys_cb(void *state, const char *sys_name)
+{
+	return tp_pmu__for_each_tp_event(sys_name, state, num_events_cb);
+}
+
+size_t tp_pmu__num_events(struct perf_pmu *pmu __maybe_unused)
+{
+	size_t count = 0;
+
+	tp_pmu__for_each_tp_sys(&count, num_events_sys_cb);
+	return count;
+}
+
+bool tp_pmu__have_event(struct perf_pmu *pmu __maybe_unused, const char *name)
+{
+	char *dup_name, *colon;
+	int id;
+
+	colon = strchr(name, ':');
+	if (colon == NULL)
+		return false;
+
+	dup_name = strdup(name);
+	if (!dup_name)
+		return false;
+
+	colon = dup_name + (colon - name);
+	*colon = '\0';
+	id = tp_pmu__id(dup_name, colon + 1);
+	free(dup_name);
+	return id >= 0;
+}
diff --git a/tools/perf/util/tp_pmu.h b/tools/perf/util/tp_pmu.h
index 49537303bd73..30456bd6943d 100644
--- a/tools/perf/util/tp_pmu.h
+++ b/tools/perf/util/tp_pmu.h
@@ -2,6 +2,8 @@
 #ifndef __TP_PMU_H
 #define __TP_PMU_H
 
+#include "pmu.h"
+
 typedef int (*tp_sys_callback)(void *state, const char *sys_name);
 typedef int (*tp_event_callback)(void *state, const char *sys_name, const char *evt_name);
 
@@ -9,4 +11,9 @@ int tp_pmu__id(const char *sys, const char *name);
 int tp_pmu__for_each_tp_event(const char *sys, void *state, tp_event_callback cb);
 int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb);
 
+bool perf_pmu__is_tracepoint(const struct perf_pmu *pmu);
+int tp_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+size_t tp_pmu__num_events(struct perf_pmu *pmu);
+bool tp_pmu__have_event(struct perf_pmu *pmu, const char *name);
+
 #endif /* __TP_PMU_H */
-- 
2.50.0.727.gbf7dc18ff4-goog

