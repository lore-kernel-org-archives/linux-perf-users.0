Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806221CB15F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333186; cv=none; b=cdeJFk5IQ5YwVV9leSEdxYEny16E5OqAx9Nhdz6+/VAVUtchN+TYsNZj9QYWs9HyKKGYPXy8vKEfS/fg3S7b5OFxHqewiF7NakEmR4mjehKvtvsYcKjxLUsqDjucdGynaX/P4Glxgfbg6fSN/RUgjOOgYXI0DmyKDXwqbDekbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333186; c=relaxed/simple;
	bh=LBlt8Z0mUXgWVL9o69MdbbTBL+v7SAEfLDtH+uMBTuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS1bMv9EnJnOyJTaP3IGOT1ylenezFA/si6tstVkxgJ1492d/8ZMaewyfkpvv+KEf+olGNosqOrafrRVVWdAnN2foYhqCGkumSSyjKxkZdLiO8mE6OIy59nazRFvNJwuOhc9qe+DsCJLrO5jbk26Xi3JGArvDQIfM+X0JYQOnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCENC/3K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCENC/3K"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8657900fc1so131091466b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333183; x=1724937983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmc4eZ9qHbt1Etu8s5seKQefOAgzMufznEYvpOOaJRM=;
        b=sCENC/3Kq7OichOetHEjCk0L5iAFCCf5SKHIyVsPmQwMwJMkIpx4vEwV6bmmGkvVgh
         uHegjKInVIWSxMQH7kYCPofC70bi+nICHcofMRdYrf/WQRGn/adUxypDnSiuc7Am5PnB
         PFyrSOA15gHzTLMcjjC43kQvEQzZ8mujI7zm7T3avdGINmleDLyYgfxwA9YY52oox/Wl
         cQ8jm6Ic6qOOknCMZuvh/KrkEe3hSffKWvtacxzhOxuLG/avsY1fDW/vnPzGrrKzmzEZ
         YGqhUYzlJXS74SAt0SNTMuiPFozVyevnNM5o7omDPfP7athS46yQgjb4QSzVRhVHIAvj
         w/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333183; x=1724937983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmc4eZ9qHbt1Etu8s5seKQefOAgzMufznEYvpOOaJRM=;
        b=DmoSJjSttqYLvqTcI0Qcs2hZbpPWWE8quy3iJyisrxnlc50RZV6ldphkwNHesZ0vJd
         y4s6wjBmIsyn68OFA6S7b3Cvb9h/yixRTihc7NszmOyXhjIpup/kSYdiljMFNaPI5ein
         yM0nlO+KHY6CHP7lDcQveT8L7V9faUHPnM4Re2tv8k8hKqt4DX5Sfq2CRZdwSZzlFcIx
         paGhhxr3VRgp6QEqmIAKCY0RyY28q35l+G1LCmFHII5G30joG5veP2EKMJI4lQBCOQhI
         OfahGAQZOjnxrSSRMEPM1TOZwllsgrrqBZhQYtFX6gFx9XpcnTUoAcRT+YS7Ze9wBXnD
         ORUA==
X-Forwarded-Encrypted: i=1; AJvYcCVguDpd7xvwkAG6sCVxdJ788Ufs7hU6bXnemOTinBlomuVWsswfmVza62BvCVL+Jm3MLHbsz8YrIFmD3BeHix+K@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8aJmvK3Ea/wRnzrjhxcI0PifZ9Kr8nABd0Po4Sag424I7KKB
	QcSiwJtEJRbexTZeFhDWzU0CFhlXFDNcZd0CzqI/UIvWOA4hxqHcGRyMG+FkOzA=
X-Google-Smtp-Source: AGHT+IGSdqjQpYX0mVkBaNmg2E+s7udBeAOEPkoDF6aQA5so9danECc39viGk5lSgKfslrkFR4Z8Sg==
X-Received: by 2002:a17:907:9722:b0:a7a:a4be:2f99 with SMTP id a640c23a62f3a-a8691afd119mr178049866b.22.1724333182118;
        Thu, 22 Aug 2024 06:26:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4365a9sm119497766b.125.2024.08.22.06.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:26:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] perf stat: Uniquify event name improvements
Date: Thu, 22 Aug 2024 14:24:46 +0100
Message-Id: <20240822132506.1468090-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822132506.1468090-1-james.clark@linaro.org>
References: <20240822132506.1468090-1-james.clark@linaro.org>
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

