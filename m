Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17712C544
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442854; cv=none; b=GlM/RFVPmDZ5me7+jydG/9Vl3r6v6KsjAtD108O3PxxAu/shmx6lHtLNGKE1quzIFIfqEippOEHF4vaxAFshRntnTiwGogegAFMnoSurB4d9WdRSgYkKw0A7OXbin/LU+vV621nqvYBxvcQWZNCVf1IYw64NvmCYqdb8y/i/rEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442854; c=relaxed/simple;
	bh=r+uE1WFm8d59B/9GQ5U9y4YXsxkXuSQea+Owcaqjl7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=T3/R9wDs5y8k0mw29ukFWmsC+z70W7h/NkZg/PA0VA8xGXthkqIhf33RRkogL9M8dkoaANScM+GXqVRmvfuO0nGheSTllkd231525OowTx9dNsjYGW1Ee5bmrZo2ga7I2+J+E2FR2FJmqwwTEfl9QK+oa0cInObRGR8OU3XuUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDKDZ4Z8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDKDZ4Z8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6fc6so32257655ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759442852; x=1760047652; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fw5vkeOAxyYTZQE/8F6wMtOywp3niBYC/dWA3qYObnw=;
        b=XDKDZ4Z8fybNlNJDHMM8Wv5gPBo9ywlZ9pAW+/vdwAY17hGuysS+xXVNbUUYIfgKni
         sCROmpugK6xyjAnb0xPqikgJaQlULLDaaFwOB3d84SdES0ZH8bo5I4qIwVr3SsVBwFrm
         c07d0NSLkOaAESBYHLyRnmQv/7DBKmaQBmLXjIsMLMRNmXKo6gIA6n+/TcagarmaZIB9
         SvNEds2naxYQ8nXWGJ+UOezYWCTzpR6xl3zQYHhvKjgvmc1SCR9aSitJSXkPu3KYGJek
         WdhPP19WnSJR3BiUDSmy2/5VHpqjgAySOLBBzGtZL4zwS+iEZ0+sBSioAglr5tYacPDK
         KGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759442852; x=1760047652;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fw5vkeOAxyYTZQE/8F6wMtOywp3niBYC/dWA3qYObnw=;
        b=uCa06/VBCjTrKA3smrbVc7Iy4bbqKiLBkSlrPFHEqgGOpSC9LuFErXZRyNRBszvmkM
         WPwzZt7FbbvvySUahJ09GcCf34fn84JOUB8wHvDwsocxi9spiCsSpUkZx7tyhiS2FiUm
         /RjsK2UumF7J4alLWH//g9rpT8GFLHlGLYCD/6eSf7p3CtWg8cMHLMzweilosyerpP6W
         UOLMFJwHrlOjyldzEd2RIbA+qMscSMxUIRRTYT1ZG8YECHgUfU6XIiuS9G/vWkoAjvh9
         htSfPLYmmQNdkKKyZuHtG40+9BOAnZBhFwnYxaSDnD2ySgUtGy/5dSFc93vO00Dvmj8n
         6RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSF4kNDeQiPhB/Jue0EHIcfrCyDrbzuKg77egvzSI/+g62TT1sR0r/CfwEsW/0cOBsaEgtHkjgmLTpjMwqB8L@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKY52YGKL412SQ1lSwwa7SgrHzUYd1yRwIfZOqvx6KnU9+gsv
	hrVCD8s3vdA+8zqoedlJU23OZPQYQHih6vDsrZOkYU6LFxGmWiiDtnNqU8TJgm4oP32PcRpHk8H
	neP2wJQZARA==
X-Google-Smtp-Source: AGHT+IG+3dTGppB+owJbqWjOJmlsi7q6946ThoxezRTJIU8YUsMFZyVYwN9PkolCuqiqx16BoZKoJbRaOCZG
X-Received: from plw21.prod.google.com ([2002:a17:903:45d5:b0:27e:dc53:d244])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4e:b0:24b:e55:360
 with SMTP id d9443c01a7336-28e9a5f6858mr8825685ad.23.1759442852196; Thu, 02
 Oct 2025 15:07:32 -0700 (PDT)
Date: Thu,  2 Oct 2025 15:07:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002220727.1889799-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf stat: Move create_perf_stat_counter to builtin-stat
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

