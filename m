Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B3199923
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981454; cv=none; b=iHlM4SdeL9Bi7gNaaABPsHTK1f4fT2R8ZwgLv06BRMoGC6LUMpS4sWmisst4mMgigSilkC+/0k7B0fZyF90jxdbzCB2jFTb05jxJaaC05S30PliTYri5aMwr3OiwDQkkoqktOsOCkwTw+Av/5xQ+kfsY8qkX1fAwJPMQUlMuV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981454; c=relaxed/simple;
	bh=ZO0cjcf70UOuKOoHRZFkYxmjxvF57AkLik+p1Nx6jLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNO2wOvcsasOalYMU1QXxg4/gTCLvwW3lYT0PU6fVkv/hjz2cDkfZlO0fHO4kvo7hgGGP2hQrRHYRlhSwWjHu1O7KhDCk00tR+K3KY2LDOac5FreKNQominB8Dqn86hCy6N5JkK96dyKgG4xGMcUDOROP1qMK7RjwC9BOKYSN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NMPHWh4k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMPHWh4k"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso8575265e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981451; x=1726586251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFDCbwWLYHtewDSmMSa5dxxCwM5A38zDayLzJ0EVNJs=;
        b=NMPHWh4kiXh+gb9EsHf3I9mSIZVJUTVw4QR291TzaBPRhtgTqh8IHX48e3SiUozNgI
         FbfQQ7cCIlyMSXRR+bSY7kBMctQ7zgMdzVT3kwwT/SgJ+Ymm6Kj65HB8vf20FlEuXZ0C
         58eZTY0PJD4kUHO4zhhRqhKJnXD6sXGdf23ySzWHWwRFqXOstve/zP3Ma+rfNjQ0jQHI
         s5o04BsoF8dd9VRR37/72jPkKKBgdRZi0cl1sO3sMZkcz0xUt/w25hZ4QiYTDQeUz5QV
         l+T0PqPpfwPsP7inekR+Oq9c30lGYP7sRk2N2RO9zjiqn5VPtxeAhuk5yO8gjdfd1h1d
         6eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981451; x=1726586251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFDCbwWLYHtewDSmMSa5dxxCwM5A38zDayLzJ0EVNJs=;
        b=sjtM60ueCWgr/WISvIBz1ZOvPGPtQ/5Nqr8u02YZkKWaulhWUdHHcynSwemxDsh8N3
         a2VTlNhJpVz8rIUuP8gol2P3YhC8TujxUXQZYLYsDFvqb/HPClS/mnhCyiHR8GRieX/c
         /4ebhRpToDzywDVhQtC7ZpMmd8A6m1FUiVTXEiqWwy3EXSDie72xTO0JLIlilfRLcVdn
         59+5R6EGcDGWMi/FNkXCnPsvuj0W9XmuF79QS29Q4WZZhTrY1qesBMkkQQJyGnskj6Th
         IzCKuy+cVGvh3evbhSCfph99747K4JA7J4xKybkbAm51dE+RW5cRXMjNBypII4bzjki7
         rKag==
X-Forwarded-Encrypted: i=1; AJvYcCXHHW62rue0QsV7Ezqiv96wTsqFp0mhhpDyjlw7X1trmtVct2pUGJmfXcVjY4I9fZBe4qaAUxuHSUe4kdITexEf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hFbug8N8pdnHMa6sEOwvV3of3Dkv+LlIZHANFoEZXOhoofx8
	mEcX1VYNtUgnrKX2IrwRQ8SAFPQAIWx2tKol4Otrros3JNlPCB4CPtsLqBOxnK4wQHy3947TtHz
	M4uDQJQ==
X-Google-Smtp-Source: AGHT+IHGOqmfICWBH72NIu+jj0wdIAL5x8avGpXcKrAFVtiPuEoZPA6ZZQtEfVUU25gZymM2vqN12A==
X-Received: by 2002:a05:600c:35cc:b0:42c:bfd6:9d4d with SMTP id 5b1f17b1804b1-42ccd30c326mr270615e9.2.1725981450497;
        Tue, 10 Sep 2024 08:17:30 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm9440844f8f.36.2024.09.10.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:17:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/7] perf stat: Uniquify event name improvements
Date: Tue, 10 Sep 2024 16:16:20 +0100
Message-Id: <20240910151640.907359-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910151640.907359-1-james.clark@linaro.org>
References: <20240910151640.907359-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

Without aggregation on Intel:
```
$ perf stat -e instructions,cycles ...
```
Will use "cycles" for the name of the legacy cycles event but as
"instructions" has a sysfs name it will and a "[cpu]" PMU suffix. This
often breaks things as the space between the event and the PMU name
look like an extra column. The existing uniquify logic was also
uniquifying in cases when all events are core and not with uncore
events, it was not correctly handling modifiers, etc.

Change the logic so that an initial pass that can disable
uniquification is run. For individual counters, disable uniquification
in more cases such as for consistency with legacy events or for
libpfm4 events. Don't use the "[pmu]" style suffix in uniquification,
always use "pmu/.../". Change how modifiers/terms are handled in the
uniquification so that they look like parse-able events.

This fixes "102: perf stat metrics (shadow stat) test:" that has been
failing due to "instructions [cpu]" breaking its column/awk logic when
values aren't aggregated. This started happening when instructions
could match a sysfs rather than a legacy event, so the fixes tag
reflects this.

Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
[ Fix Intel TPEBS counting mode test ]
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/stat-display.c                | 101 ++++++++++++++----
 2 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
index c60b29add980..9a11f42d153c 100755
--- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
+++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
@@ -8,12 +8,15 @@ grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
 # Use this event for testing because it should exist in all platforms
 event=cache-misses:R
 
+# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
+alt_name=/cache-misses/R
+
 # Without this cmd option, default value or zero is returned
-echo "Testing without --record-tpebs"
-result=$(perf stat -e "$event" true 2>&1)
-[[ "$result" =~ $event ]] || exit 1
+#echo "Testing without --record-tpebs"
+#result=$(perf stat -e "$event" true 2>&1)
+#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
 
 # In platforms that do not support TPEBS, it should execute without error.
 echo "Testing with --record-tpebs"
 result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
-[[ "$result" =~ "perf record" && "$result" =~ $event ]] || exit 1
+[[ "$result" =~ "perf record" && "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea96e4ebad8c..cbff43ff8d0f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -871,38 +871,66 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 static void uniquify_event_name(struct evsel *counter)
 {
-	char *new_name;
-	char *config;
-	int ret = 0;
+	const char *name, *pmu_name;
+	char *new_name, *config;
+	int ret;
 
-	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
-					   strlen(counter->pmu_name)))
+	/* The evsel was already uniquified. */
+	if (counter->uniquified_name)
 		return;
 
-	config = strchr(counter->name, '/');
+	/* Avoid checking to uniquify twice. */
+	counter->uniquified_name = true;
+
+	/* The evsel has a "name=" config term or is from libpfm. */
+	if (counter->use_config_name || counter->is_libpfm_event)
+		return;
+
+	/* Legacy no PMU event, don't uniquify. */
+	if  (!counter->pmu ||
+	     (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type != PERF_TYPE_RAW))
+		return;
+
+	/* A sysfs or json event replacing a legacy event, don't uniquify. */
+	if (counter->pmu->is_core && counter->alternate_hw_config != PERF_COUNT_HW_MAX)
+		return;
+
+	name = evsel__name(counter);
+	pmu_name = counter->pmu->name;
+	/* Already prefixed by the PMU name. */
+	if (!strncmp(name, pmu_name, strlen(pmu_name)))
+		return;
+
+	config = strchr(name, '/');
 	if (config) {
-		if (asprintf(&new_name,
-			     "%s%s", counter->pmu_name, config) > 0) {
-			free(counter->name);
-			counter->name = new_name;
-		}
-	} else {
-		if (evsel__is_hybrid(counter)) {
-			ret = asprintf(&new_name, "%s/%s/",
-				       counter->pmu_name, counter->name);
+		int len = config - name;
+
+		if (config[1] == '/') {
+			/* case: event// */
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 2);
 		} else {
-			ret = asprintf(&new_name, "%s [%s]",
-				       counter->name, counter->pmu_name);
+			/* case: event/.../ */
+			ret = asprintf(&new_name, "%s/%.*s,%s", pmu_name, len, name, config + 1);
 		}
+	} else {
+		config = strchr(name, ':');
+		if (config) {
+			/* case: event:.. */
+			int len = config - name;
 
-		if (ret) {
-			free(counter->name);
-			counter->name = new_name;
+			ret = asprintf(&new_name, "%s/%.*s/%s", pmu_name, len, name, config + 1);
+		} else {
+			/* case: event */
+			ret = asprintf(&new_name, "%s/%s/", pmu_name, name);
 		}
 	}
-
-	counter->uniquified_name = true;
+	if (ret > 0) {
+		free(counter->name);
+		counter->name = new_name;
+	} else {
+		/* ENOMEM from asprintf. */
+		counter->uniquified_name = false;
+	}
 }
 
 static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config)
@@ -1559,6 +1587,31 @@ static void print_cgroup_counter(struct perf_stat_config *config, struct evlist
 		print_metric_end(config, os);
 }
 
+static void disable_uniquify(struct evlist *evlist)
+{
+	struct evsel *counter;
+	struct perf_pmu *last_pmu = NULL;
+	bool first = true;
+
+	evlist__for_each_entry(evlist, counter) {
+		/* If PMUs vary then uniquify can be useful. */
+		if (!first && counter->pmu != last_pmu)
+			return;
+		first = false;
+		if (counter->pmu) {
+			/* Allow uniquify for uncore PMUs. */
+			if (!counter->pmu->is_core)
+				return;
+			/* Keep hybrid event names uniquified for clarity. */
+			if (perf_pmus__num_core_pmus() > 1)
+				return;
+		}
+	}
+	evlist__for_each_entry_continue(evlist, counter) {
+		counter->uniquified_name = true;
+	}
+}
+
 void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
 			    struct target *_target, struct timespec *ts,
 			    int argc, const char **argv)
@@ -1572,6 +1625,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		.first = true,
 	};
 
+	disable_uniquify(evlist);
+
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
-- 
2.34.1

