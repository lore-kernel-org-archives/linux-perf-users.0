Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC02257AC1
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469543; cv=none; b=Z5Hzt98iZzXj18NPDeCF54b7Uy2gKYI6YFnIQ7A3CXZpkGMghbFUgHGMnhLzKzNGcYKcCPtKv2aXD66XEMXnqrkumz8yLX55H+THHC6UJ47/D2WVi/1cxyu7N45mN/DPgS3NsbGgCq+TAzvMuNqh9uRWYJlLZGmgiLuqF+zJ720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469543; c=relaxed/simple;
	bh=0fW5uKhoqUMu6t/2+fOCxERGXZX+hkR8WxQ95mw2OFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmNRQ0o8FfVBKWbipEG3mEqgmtimoYgnSa2Zgs8Vm3p+ef2XlXd7l0wdal7Pt5uJcVDxfpalVFIQI3QrIlo82TBYQ+KCyAM+4rh9+/phmk8W+Vw3RUoRpgc/7UB9hRDF2m0OAofOKUara9OTMNQs8/fIXDkgV9PPiwq4KUqug+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hkIKyJu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hkIKyJu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af08594fso2254612a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469541; x=1754074341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iY4LHvEGR54Ap9oyuafzbxQtWKQpZaO9JTXpL1G/L5Y=;
        b=0hkIKyJuHSJSkweIZn8FaaBJw+/9ImK6yNoBHMuqGq/1pGCqc9WzYFza8ptJGwa68+
         cUYHWBTozXcEE8CScPswMkgXuibQNlschS7vBXQkoEQZPfD2f+FXZBxhQfQS9e3c+yW7
         m1PT3YTvAKnH7v/0YSezAi+ughKXnZwtu8iqA9noC+OpUyr7TqJALeQf4GhVdfCHDJD7
         OjdO6aYrowwCMNykKXBtnL/AewMTA248dh2s9OqVVH92NYe7WFZTHGwwSez2J2sjvYco
         6WqjVV2ACge5S6CBXOkuqazNOZbnKpUUX9aGm5U11tUNYspBSwnzUwrLYUQ3Gp/v26wJ
         N74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469541; x=1754074341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY4LHvEGR54Ap9oyuafzbxQtWKQpZaO9JTXpL1G/L5Y=;
        b=bXNrx00VYdqa24LoSj9JJAvIwZ9oLDvV9fmfvMC2idkQdp7ADyqtvR4AyhEeB8IC2/
         NdDlR33YgC/vrlP1H2r7s7oTqgCuwnFPzIWiTVHtYB4mJ+46gy3GMJK1twVgXKOS50+r
         b/VHd+TcfwBsOawRcei7Z+OXkHk2LSbKoqxbw8xNhci0YAubqGVDDfKae5Snp7KLKhy5
         ZtPJiLLGW0gQNA6s7H3/csmVw5hY3BkolzLmlnNfqcyy0b1EacWyMT5BBVL/2gVx0djB
         XQwLPridBXJmIVsrJF8XV92LKPgUqg8ZMOyo1E21wa5nPl4uQ8aZ8qGtZJK+tYc+15lF
         LAMA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGkhW5ZukLRbn9F7GgN7UFeRENNcdKP6aNOmdL0/JIOYagU6rdw7ly7LT0vl/HEN1Er6ccdpFhdDW9NcFvVEL@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMV4qSWRPnjs2dFjwc8mAEVV09pW9DiRVrddI0oyQQw0nO/2U
	NU5fRyFD9QGzmUkkxAfcdpjEkZHGfp35ks0Df1Ve7qtWjAT049DpiXJi5TcTcJL+dXn4XHmPnGa
	iXvGa8m7jKQ==
X-Google-Smtp-Source: AGHT+IFTbpi7Qo/ciLALO0Gyufr7lG9u28hr2ETmyaA2R8YBtZ0mm7hNkzV+Dxa5kLDsJMnRCI07qseDccgq
X-Received: from pjqz1.prod.google.com ([2002:a17:90a:b101:b0:31e:74cb:7677])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134e:b0:311:9c9a:58ca
 with SMTP id 98e67ed59e1d1-31e7788a6aemr4681561a91.8.1753469541405; Fri, 25
 Jul 2025 11:52:21 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:51:51 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-6-irogers@google.com>
Subject: [PATCH v9 05/16] perf tp_pmu: Add event APIs
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
index f3da6e27bfcb..5a291f1380ed 100644
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
2.50.1.552.g942d659e1b-goog

