Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA714600C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685730; cv=none; b=gVeROBHUCggEe7zEZoL9+3MSy3KSaCFNGtQziPq2H2PIroVwTN4EzYbWk6ln1Z2f07Wxsq1e+bP/PUbQsLgNajefZoqNu0EYaht/76iGxy31Zf4SOxsZXa26mB7xYwWw74hFMdPbBFY6hqUr0K31eEJPMQuKfcc8DYa3Z0B5KYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685730; c=relaxed/simple;
	bh=WFu+5y8QRKtMZSfoRCTOTpmMOyl9HcFrp2FvXFrJg7w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RIg0j19XzkwNUzKW88yBT5sBe1KwXsi4POJxUOXAto7Hr0onC4aSpwo7V7g1zbx3G4I81DvG7lXH9+h3CovRF0OAlpIADQC+NkVoJis5VReSHALiqPr9EKRQlS4pM/uuPu5ZphO1sOWxmaW4UxIZNNqKu8RuE+w6NYVlgQUpOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtHnvi7b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtHnvi7b"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d7124939beso86711017b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685727; x=1726290527; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnJ5bQcxWcBEjqFa4fDewaQZBBcymf58nuYFxDuPtGE=;
        b=BtHnvi7byvG0m5YvfCvhNiJ+IUTTS8ba6CDz2Zw/W5EjlUAeVZBpwXafnXMKJFNgv0
         NrD1IwiS1WKqQr3zRu/sCgZnYgPeK4PmknvXi9w7XGYXkbWM+Nrh4O62v627yscDkO0Y
         LGWelmL+OEMyjnoQKN9pXGxfMBE8ZLH5CrkmFHhaa8q4jOZWoq65PVioxzbdR8fZTRti
         lribxgDsdCZHV9rJ5aRccrLCk4Q+3cmZw5InfiwJRcyQ42YE3HDVBzWqWnKW9VQiU1C0
         qRAGEo03/o3RDx53GxHCtM2Z0Q6N8HTPor0fMkGmVxxvVHMAk4/tXhHn4IDRrheKu9/s
         XMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685727; x=1726290527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnJ5bQcxWcBEjqFa4fDewaQZBBcymf58nuYFxDuPtGE=;
        b=B5zUK6PNcKUMTHHt5A5tz2vkMQMw28lZG4nQZBqQ/WRrlfN5KP93Es4FMwtpdAiIyW
         QWjY4n9Znel2Caho5sy6LspLFyM1ILU3DYPZw7xmNWoowUBpQuMpug8CotAbck6MNuQH
         MQCvRvDWjdYfpB0E5SlcwBg6xOEvR4N2wn/TkWR7kwYA2S3CjjbJHvgKy6rgDPqF4qmj
         io2kMdmmVjUAjcJr16z8Wv76ki0tJq9lWP7Aej+qYqzPg9qkdWfAxZa6S0xPHYSN6KJ4
         aRQsShPmeP2z/lI37clBkbK+xAEMSY47Nx1nQtKAMqvcir3f3M/uoizupEAdawvevDhr
         xJjA==
X-Forwarded-Encrypted: i=1; AJvYcCXNXw0LcWtaKoAasGg8pRCbGaJPW1TbMOfZFb7z50bDhb23LJRLs1E2cBKKkIni9XVsXRr/uRdFq/LCRjjhX3HA@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTqzkiSHoLiOQWSK/f8iH9hOOL96Bw4SLAFXSPlPmWz4XBV46
	S0ebmICKBe2hJR8gbtJZfhW76+9M9oP6ubEht+PqUxUoH5kvoKNLkkH7vkOrz7Ak+lF4AVwL2c3
	+KuD0MQ==
X-Google-Smtp-Source: AGHT+IFTJ0A52z3gMmDUeSdc9NNKQBO5uzT/5BCT5fI3Wi24F4j+wnthp1Ie8Bb6r90x5y4Inys9YsFccWPt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:6c81:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6db4526c2c0mr1787397b3.7.1725685727310; Fri, 06 Sep 2024
 22:08:47 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:18 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 03/15] perf evsel: Add accessor for tool_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently tool events use a dedicated variable within the evsel. Later
changes will move this to the unused struct perf_event_attr config for
these events. Add an accessor to allow the later change to be well
typed and avoid changing all uses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |  6 +++---
 tools/perf/util/evsel.c       | 24 ++++++++++++------------
 tools/perf/util/evsel.h       |  5 +++++
 tools/perf/util/stat-shadow.c |  2 +-
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cf985cdb9a6e..689a3d43c258 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -294,14 +294,14 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
 	 * terminates. Use the wait4 values in that case.
 	 */
 	if (err && cpu_map_idx == 0 &&
-	    (counter->tool_event == PERF_TOOL_USER_TIME ||
-	     counter->tool_event == PERF_TOOL_SYSTEM_TIME)) {
+	    (evsel__tool_event(counter) == PERF_TOOL_USER_TIME ||
+	     evsel__tool_event(counter) == PERF_TOOL_SYSTEM_TIME)) {
 		u64 val, *start_time;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
-		if (counter->tool_event == PERF_TOOL_USER_TIME)
+		if (evsel__tool_event(counter) == PERF_TOOL_USER_TIME)
 			val = ru_stats.ru_utime_usec_stat.mean;
 		else
 			val = ru_stats.ru_stime_usec_stat.mean;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 49cc71511c0c..dbf9c8cee3c5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -773,7 +773,7 @@ const char *evsel__name(struct evsel *evsel)
 
 	case PERF_TYPE_SOFTWARE:
 		if (evsel__is_tool(evsel))
-			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
+			evsel__tool_name(evsel__tool_event(evsel), bf, sizeof(bf));
 		else
 			evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
@@ -811,7 +811,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
 		return evsel->metric_id;
 
 	if (evsel__is_tool(evsel))
-		return perf_tool_event__to_str(evsel->tool_event);
+		return perf_tool_event__to_str(evsel__tool_event(evsel));
 
 	return "unknown";
 }
@@ -1503,8 +1503,8 @@ void evsel__exit(struct evsel *evsel)
 	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
-	if (evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
-	    evsel->tool_event == PERF_TOOL_USER_TIME)
+	if (evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
+	    evsel__tool_event(evsel) == PERF_TOOL_USER_TIME)
 		xyarray__delete(evsel->start_times);
 }
 
@@ -1785,7 +1785,7 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	switch (evsel->tool_event) {
+	switch (evsel__tool_event(evsel)) {
 	case PERF_TOOL_DURATION_TIME:
 		/*
 		 * Pretend duration_time is only on the first CPU and thread, or
@@ -1800,7 +1800,7 @@ static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
 		break;
 	case PERF_TOOL_USER_TIME:
 	case PERF_TOOL_SYSTEM_TIME: {
-		bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+		bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
 		fd = FD(evsel, cpu_map_idx, thread);
@@ -2072,8 +2072,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
-	if ((evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
-	     evsel->tool_event == PERF_TOOL_USER_TIME) &&
+	if ((evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
+	     evsel__tool_event(evsel) == PERF_TOOL_USER_TIME) &&
 	    !evsel->start_times) {
 		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
 		if (!evsel->start_times)
@@ -2262,7 +2262,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
-	if (evsel->tool_event == PERF_TOOL_DURATION_TIME) {
+	if (evsel__tool_event(evsel) == PERF_TOOL_DURATION_TIME) {
 		if (evsel->core.attr.sample_period) /* no sampling */
 			return -EINVAL;
 		evsel->start_time = rdclock();
@@ -2304,9 +2304,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-			if (evsel->tool_event == PERF_TOOL_USER_TIME ||
-			    evsel->tool_event == PERF_TOOL_SYSTEM_TIME) {
-				bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+			if (evsel__tool_event(evsel) == PERF_TOOL_USER_TIME ||
+			    evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME) {
+				bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
 				__u64 *start_time = NULL;
 
 				if (evsel->core.attr.sample_period) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15acf293e12a..15e745a9a798 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -330,6 +330,11 @@ static inline bool evsel__is_retire_lat(const struct evsel *evsel)
 	return evsel->retire_lat;
 }
 
+static inline enum perf_tool_event evsel__tool_event(const struct evsel *evsel)
+{
+	return evsel->tool_event;
+}
+
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 6bb975e46de3..99376c12dd8e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -380,7 +380,7 @@ static int prepare_metric(const struct metric_expr *mexp,
 			struct stats *stats;
 			double scale;
 
-			switch (metric_events[i]->tool_event) {
+			switch (evsel__tool_event(metric_events[i])) {
 			case PERF_TOOL_DURATION_TIME:
 				stats = &walltime_nsecs_stats;
 				scale = 1e-9;
-- 
2.46.0.469.g59c65b2a67-goog

