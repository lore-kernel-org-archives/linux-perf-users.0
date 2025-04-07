Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6812550BA
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060241; cv=none; b=F9z//5mlzpsvIWYMh4f6bAKjlc6QpKBKVReUecrdSmt9qKhJAlilvXOXcY8vTUsaB5v4mIKcB4Klz+ryHHEfW5bvGUZANId7PEXtta5hp3Wcvj0bxbGz1J5nv9JB/T7gJPFAhgfeGoRJaUVe2AQN0kwyOqPr7uLzGpOYwXzDMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060241; c=relaxed/simple;
	bh=midHO3Z3byxoUBHfKzM92TodrGzwSNi/xUV5ijTnPeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XYn+lpJrNVBjyEVNeXCxPE2kQVS7uaeXLqoH6PiGB3VulAOkyyHlPcvwgFD9jyqwqIvD8IpAhRHKt+O+6T6kARvU8khmwPvXCQXJnWzC44KKIqh0A1QEqxQdYsVOlymr4Jf41HJ+siGQFMLe26p7iUuEttlU05tz8yaIhEfxhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mb0MEax6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb0MEax6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so38060865ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060239; x=1744665039; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1vjvtqlcWS/+dNR0OE++xaid1m3UsjjNffN8GtQ4ds=;
        b=Mb0MEax6JUqQd2OotEHLXGOJrfdKwhKK50VRq5JFGx8rItq4mX9d1B805DSdaMXalP
         Bu9f6M8NrbJCbdbrWz1zTIUAtRSqnQed3mSqDsT9gau0GU9B3FlJIOHHqDrUnswxT+K7
         Iiyhru9do947dIv+VofzVDsliFAWCoV35iND5PML5BZY5sl8fHDQZEXcR6Xz6MurDbMv
         0QK6YMCz5agGWMnl85tq3wfET37ngV4NkWhN5iRGBHEgGvtDLHXAzxh/MteWF6VN176B
         3eRBfFidQMy4kM5F9uRMEdBQZ6v05jgbroOZAzGxtjKmW7z+9uyUwjUQCnjNJ0K83FBe
         +QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060239; x=1744665039;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1vjvtqlcWS/+dNR0OE++xaid1m3UsjjNffN8GtQ4ds=;
        b=qbjySMsebKd6d6EyaoYQx1Jf8F/oo4s7+OnUXmv5at/sUUexfXzginrpe3hMkzs9e4
         jiNerxHihIBuHDiPCfGyYYBfD0wiX8M73c1aN1N2NTVZJfLjapwmF+gsv8pi4L8lOAMG
         l8h3Pxf/9XP6U9M8JKJ4BI7dsErK8KYz/Re4+kA+MpKenZyf00/yNe5dEJavjZYBjxPQ
         vX3K1FXYYhpTf4itqGkO2Kkj0w+b9O9XEinT4EJKf6iSYlrRg90Ej39TR0bvOC67cRr0
         TNbR+TP8OwKjsN1V3+FT7PDrIh+nlvWn8qVEx6CaorjkH9/wN4rP9FIXHtl0bFStLwYg
         fVzA==
X-Forwarded-Encrypted: i=1; AJvYcCUbgBcuiHASvrX+PTehzIpE9eeUw/b0AU27mrW0bAd0vwi+VO5qA8nM4z2eKMwv02wVqniPxU+3yebvpkG2H1FV@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1geT2EoQZ7+5aSIKiAUCAJYvv4SKLkBRwvnGHsdd+vsUZ4li
	UjPi6jvPfLuH3wnTbYBtPs3Spe/Ag+emkWh082S2MQO7S9yHHbAwEAsS0wat35+sRVeWtP/s74e
	oeKf4yA==
X-Google-Smtp-Source: AGHT+IGADpgsCuG4PHa3Qu9sgQTTobjrW0PuIpK1wi9mW1TmFE2abMLBb0bRgk7WFEzx8RlVsADBzs7CRw5z
X-Received: from plnu5.prod.google.com ([2002:a17:903:1a45:b0:223:58e2:570d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c6:b0:221:78a1:27fb
 with SMTP id d9443c01a7336-22a8a049ee7mr143568095ad.11.1744060239381; Mon, 07
 Apr 2025 14:10:39 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:31 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-11-irogers@google.com>
Subject: [PATCH v3 10/16] perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename to reflect evsel argument and for consistency with other tpebs
functions. Update count from prev_raw_counts when
available. Eventually this will allow inteval mode support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       | 11 ++------
 tools/perf/util/intel-tpebs.c | 52 ++++++++++++++---------------------
 tools/perf/util/intel-tpebs.h |  2 +-
 3 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 554252ed1aab..1d343f51225b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1718,11 +1718,6 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
-static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
-{
-	return tpebs_set_evsel(evsel, cpu_map_idx, thread);
-}
-
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 			     u64 val, u64 ena, u64 run, u64 lost)
 {
@@ -1730,8 +1725,8 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
 	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
-	if (counter->retire_lat) {
-		evsel__read_retire_lat(counter, cpu_map_idx, thread);
+	if (evsel__is_retire_lat(counter)) {
+		evsel__tpebs_read(counter, cpu_map_idx, thread);
 		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 		return;
 	}
@@ -1889,7 +1884,7 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
 
 	if (evsel__is_retire_lat(evsel))
-		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
+		return evsel__tpebs_read(evsel, cpu_map_idx, thread);
 
 	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index a723687e67f6..f648fca17556 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -415,49 +415,39 @@ int evsel__tpebs_open(struct evsel *evsel)
 	return ret;
 }
 
-
-int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
+int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	__u64 val;
+	struct perf_counts_values *count, *old_count = NULL;
 	struct tpebs_retire_lat *t;
-	struct perf_counts_values *count;
+	uint64_t val;
+
+	/* Only set retire_latency value to the first CPU and thread. */
+	if (cpu_map_idx != 0 || thread != 0)
+		return 0;
+
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 
-	/* Non reitre_latency evsel should never enter this function. */
-	if (!evsel__is_retire_lat(evsel))
-		return -1;
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
 	/*
 	 * Need to stop the forked record to ensure get sampled data from the
 	 * PIPE to process and get non-zero retire_lat value for hybrid.
 	 */
 	tpebs_stop();
-	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
 	t = tpebs_retire_lat__find(evsel);
-
-	/* Set ena and run to non-zero */
-	count->ena = count->run = 1;
-	count->lost = 0;
-
-	if (!t) {
-		/*
-		 * Set default value or 0 when retire_latency for this event is
-		 * not found from sampling data (record_tpebs not set or 0
-		 * sample recorded).
-		 */
-		count->val = 0;
-		return 0;
+	val = rint(t->val);
+
+	if (old_count) {
+		count->val = old_count->val + val;
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+	} else {
+		count->val = val;
+		count->run++;
+		count->ena++;
 	}
-
-	/*
-	 * Only set retire_latency value to the first CPU and thread.
-	 */
-	if (cpu_map_idx == 0 && thread == 0)
-		val = rint(t->val);
-	else
-		val = 0;
-
-	count->val = val;
 	return 0;
 }
 
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 5c671181ec60..218a82866cee 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -12,6 +12,6 @@ extern bool tpebs_recording;
 
 int evsel__tpebs_open(struct evsel *evsel);
 void evsel__tpebs_close(struct evsel *evsel);
-int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
+int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
 #endif /* __INTEL_TPEBS_H */
-- 
2.49.0.504.g3bcea36a83-goog

