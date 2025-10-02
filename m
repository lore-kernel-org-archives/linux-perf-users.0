Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0F2874F7
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435570; cv=none; b=KYK+tseV8jZQuKadhKEi4Twq1TAKyt91ihP+cSVskppY/nbwRqWyFCCdg9AgnIBgXyBM5hcg27vvAmGdi/l59P7xZ5YR4owNQDZkEw9GeqQrwmXR7QAtnlJai0onkNv6apTgC8WFsx46bwmNnSexhmFslXlXehTALwvNLdGezTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435570; c=relaxed/simple;
	bh=r+uE1WFm8d59B/9GQ5U9y4YXsxkXuSQea+Owcaqjl7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TIeDTG0NAEH6zn4bN71x6tjolYaHpdOYGwUF5wThntno+pYwls6ZWkigwPJSr5CwphHlqu92ylvK3Ha2H7XIsKGVMksepYfAQoEDv2Q5sz1QkXkQAyGhVCoFlSlmvqjyyy4/od3PTxcpy5KeJA5J+AIg1W+0LUKp8osfr5y+Ejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kN+YATDo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kN+YATDo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso1306416a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759435568; x=1760040368; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fw5vkeOAxyYTZQE/8F6wMtOywp3niBYC/dWA3qYObnw=;
        b=kN+YATDodZHWJ1CBWZoZcRiFJlkNxiYEYlpt5sd5ZaMy2qtMgggNJ0/SymorssB3sc
         npWYYCLf33Pre6+ot8CWFmaGva5lW/tPkMjkKsBLV43oeTfmsvG1U3WFGncHMTWVOozk
         +nDJvAlhc4N69KrRcV6uO6Txp8te/OivJ6eju9wK/dlWr314A0mDImHLTSq7fa4AdXPZ
         rrHvJ3TPuh/Fu07lU/jOMQm+8+JZ1y+8c9WyISqInfnOPoVyjgJhhjXgSO4yRwZwo35s
         EDeqd1xGv4evMHxtig/nsGIdLFE6Qw13lOFKR12Sn9LESLkMCLBtJYneIt/hcmvj9WIk
         T/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435568; x=1760040368;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fw5vkeOAxyYTZQE/8F6wMtOywp3niBYC/dWA3qYObnw=;
        b=dztPldpdV6CYUqheAiSrOlWp9XOA9uhetCAEYbZye6bTopn0Nm4211+Wgz1v+B7rOQ
         Lt8qY42bMEnYPfw4N8BaCpGsSXQtjRbsoxKXRGj76z7jbYq8csdvCK5pTqwMgZrqjnFI
         UO2C/qvZJChtNy6nttXdzHvaTE7yIPUx21jvctSmEpqVmJsPskEHWCajwAOCBAXFUV5Q
         XlSDzB/idufZhQvlxnwKoIFbOolHUK4x6g9UH1V8r68GnflZLJi1i/H/64Mc2WfRTH4e
         Z91u3hiAyzdC1iuH7iubevmhIQ0FA7n82obfFljNxs6y/dvVncz51cPk3k73Pgs5v5k1
         UB4A==
X-Forwarded-Encrypted: i=1; AJvYcCXI8VEcAMeBapz0wzrZOboTBsAfFCEUavE1aaf0LGZ98VdRxW2RUDP26fKslHUNidcf+5rAxGp1hSKWXzIuQuj7@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRrjMEZPBF7sZyRJdoeBYXKYkPa56LKRS1nCnuxH2NnRJ5Rgv
	TK9QHV7eDxvD7IcwlGEE1qhUzWluTOktKbWWwC2Ru4ahIJ41WwYV7ioZTCa72v5ZEwGFILRJgIF
	8qMgEwBd05g==
X-Google-Smtp-Source: AGHT+IFFOjckP0EJKCyNbyzCK89dCCHgcJMtS+AjfD42m8RDRFhRe5NGRaL0CpKGL2kDjBHjio86TSEDUZYW
X-Received: from pjbgd14.prod.google.com ([2002:a17:90b:fce:b0:32b:8b8d:c2ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1805:b0:336:b60f:3936
 with SMTP id 98e67ed59e1d1-339c2735492mr796317a91.12.1759435568045; Thu, 02
 Oct 2025 13:06:08 -0700 (PDT)
Date: Thu,  2 Oct 2025 13:06:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002200604.1792141-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf stat: Move create_perf_stat_counter to builtin-stat
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The function create_perf_stat_counter is only used in builtin-stat.c
and contains logic about retrying events specific to
builtin-stat.c. Move the code to builtin-stat to tidy this up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 60 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/stat.c    | 56 ------------------------------------
 tools/perf/util/stat.h    |  4 ---
 3 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab567919b89a..75b9979c6c05 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -676,6 +676,62 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 	return COUNTER_FATAL;
 }
 
+static int create_perf_stat_counter(struct evsel *evsel,
+				    struct perf_stat_config *config,
+				    int cpu_map_idx)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	struct evsel *leader = evsel__leader(evsel);
+
+	/* Reset supported flag as creating a stat counter is retried. */
+	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			    PERF_FORMAT_TOTAL_TIME_RUNNING;
+
+	/*
+	 * The event is part of non trivial group, let's enable
+	 * the group read (for leader) and ID retrieval for all
+	 * members.
+	 */
+	if (leader->core.nr_members > 1)
+		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
+
+	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
+
+	/*
+	 * Some events get initialized with sample_(period/type) set,
+	 * like tracepoints. Clear it up for counting.
+	 */
+	attr->sample_period = 0;
+
+	if (config->identifier)
+		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
+
+	if (config->all_user) {
+		attr->exclude_kernel = 1;
+		attr->exclude_user   = 0;
+	}
+
+	if (config->all_kernel) {
+		attr->exclude_kernel = 0;
+		attr->exclude_user   = 1;
+	}
+
+	/*
+	 * Disabling all counters initially, they will be enabled
+	 * either manually by us or by kernel via enable_on_exec
+	 * set later.
+	 */
+	if (evsel__is_group_leader(evsel)) {
+		attr->disabled = 1;
+
+		if (target__enable_on_exec(&target))
+			attr->enable_on_exec = 1;
+	}
+
+	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
+					      evsel->core.threads);
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -736,7 +792,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (evsel__is_bperf(counter))
 			continue;
 try_again:
-		if (create_perf_stat_counter(counter, &stat_config, &target,
+		if (create_perf_stat_counter(counter, &stat_config,
 					     evlist_cpu_itr.cpu_map_idx) < 0) {
 
 			/*
@@ -794,7 +850,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				continue;
 try_again_reset:
 			pr_debug2("reopening weak %s\n", evsel__name(counter));
-			if (create_perf_stat_counter(counter, &stat_config, &target,
+			if (create_perf_stat_counter(counter, &stat_config,
 						     evlist_cpu_itr.cpu_map_idx) < 0) {
 
 				switch (stat_handle_error(counter, errno)) {
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 50b1a92d16df..101ed6c497bc 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -716,59 +716,3 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 
 	return ret;
 }
-
-int create_perf_stat_counter(struct evsel *evsel,
-			     struct perf_stat_config *config,
-			     struct target *target,
-			     int cpu_map_idx)
-{
-	struct perf_event_attr *attr = &evsel->core.attr;
-	struct evsel *leader = evsel__leader(evsel);
-
-	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
-			    PERF_FORMAT_TOTAL_TIME_RUNNING;
-
-	/*
-	 * The event is part of non trivial group, let's enable
-	 * the group read (for leader) and ID retrieval for all
-	 * members.
-	 */
-	if (leader->core.nr_members > 1)
-		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
-
-	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
-
-	/*
-	 * Some events get initialized with sample_(period/type) set,
-	 * like tracepoints. Clear it up for counting.
-	 */
-	attr->sample_period = 0;
-
-	if (config->identifier)
-		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
-
-	if (config->all_user) {
-		attr->exclude_kernel = 1;
-		attr->exclude_user   = 0;
-	}
-
-	if (config->all_kernel) {
-		attr->exclude_kernel = 0;
-		attr->exclude_user   = 1;
-	}
-
-	/*
-	 * Disabling all counters initially, they will be enabled
-	 * either manually by us or by kernel via enable_on_exec
-	 * set later.
-	 */
-	if (evsel__is_group_leader(evsel)) {
-		attr->disabled = 1;
-
-		if (target__enable_on_exec(target))
-			attr->enable_on_exec = 1;
-	}
-
-	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
-					      evsel->core.threads);
-}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4b0f14ae4e5f..34f30a295f89 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -223,10 +223,6 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 
-int create_perf_stat_counter(struct evsel *evsel,
-			     struct perf_stat_config *config,
-			     struct target *target,
-			     int cpu_map_idx);
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts, int argc, const char **argv);
 
-- 
2.51.0.618.g983fd99d29-goog

