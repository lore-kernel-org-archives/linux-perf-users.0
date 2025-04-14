Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15610291140
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652537; cv=none; b=GI+NNDy3ymX84VT7XfNgq6xOTyG1k2u4WknUQwq7voSqHWjjTBHvCMAsN1LGUjcZkj0ic3angNC7bZWZIItIpnKD7QbDvUMCxa3wh+CRT4Ld2kkSRduUSROzrq/9xQC3QH/3OrLQvlcFoKhskUwDhnc99USYxDM492r+0RqbKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652537; c=relaxed/simple;
	bh=MgG4bnT5Y/IoeACL6/FF7p03vqokpT32ooyjAmiA7KQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ibp9QGcqYXX7TciAvSirZZ6dmlA2JAdYxrH5IhAkteXQdTDZl3OVjQ7HnC+yxNtLnb6/+lO6ZAgG0/GSeQO8QencrZqL5v9kKKKDXadWQ7FUXbJMpdwSHBG5WB5KYLBQekQRGUTyPLbkCDZOzQvHDgtv53tj0iDSDw6+3Nx7kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVUxIVoA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVUxIVoA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so33862405ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652535; x=1745257335; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vv8qTLQ3WWzCt/xaflHVEhOOne4O1wpQ1+AlCg4wrv0=;
        b=nVUxIVoALamMCHdbgj9aa7JF3cd+eLlJcOqJrXi4fmQhXufLxCxbvAH1IO5kSCsb5G
         OzIA09+CX9O1SalVbmoTxmvdILgpy7AN+tIOVXgAOtlvJiHo+zuVop1dR+olBrSAVvtO
         9AT3gmt1/G96U4JqLn7It1kwROubXuRZWXdbVc+d3vouDQw9y8808hUpDaaTLSSB8Sbo
         9+NSdB3BMD4GpAZo7QlAy84JCx5dp44txrC3gZLE1yXAoBoh6YvhMfnPvodc8v8ctwbL
         Ba/FE2x+Qx0ZltEOtha9iaumWGr58zOEo3mudOY490nd+HPS8JjgMBQsNc0lDmWr1nBv
         JBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652535; x=1745257335;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv8qTLQ3WWzCt/xaflHVEhOOne4O1wpQ1+AlCg4wrv0=;
        b=VMnvEQOHzf+6Lddx5yyEKc0NMhftuTu6oFH+rnqpce3bjfk12CpRnyLkqKWYLB6BWv
         W0YYGp8liwcX3zS8THVVsfFfGe8drnmU49EXotWb4M2kq4WMtexQF/IDX5yPM+tHRiqF
         ofI8mmBsa/rWSnkvnhGnwznwfkCOK5N3NpsZxTC4b8STp2vBSyUvuo5QvCbJu3QrO1Fj
         w1ShMAk1RwK6CqpVybWp7X0Nu3vXn6RO2gkADyrxxOJtQ75fNlQIcvGjKk/+g0B+2dhf
         73Q+THanJpKOXAkrsTvqVjCZIQHmwe99SV9zzKLIoDzRcDJ4FbFyVyyjALpc/1fQON3U
         WZZg==
X-Forwarded-Encrypted: i=1; AJvYcCW24IzrP8QFM/ptqM/ITCs0nga/4eanynF+2oQan95OdB6t3o5ldwCD/5lXDWVIF7NOSd7r3dqRCWzcrjOtfW1i@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ5RJQh4Y9Cp2XZZJ4GEsKC6DzmKD0C5nAiiMI5hHTdMacRlZA
	rCnxZFbu/lMkLjcAnrB3sYuzXn4OKXwif7gbWxuwQ+/loLS5hhzaBSLomsavG9NvBZXIJA3iWAC
	GhzCgXA==
X-Google-Smtp-Source: AGHT+IGPF0PMmdXij8fuZdV6Cs9uvdSOjaLLJifCXxrH0wvmcTSs20hI4FLmxC0qgXO/FnO1nhSJhEjWPXAS
X-Received: from pldy12.prod.google.com ([2002:a17:902:cacc:b0:226:453a:f2db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f705:b0:220:e9ac:e746
 with SMTP id d9443c01a7336-22bea4fdc7amr214690705ad.53.1744652535173; Mon, 14
 Apr 2025 10:42:15 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:28 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-11-irogers@google.com>
Subject: [PATCH v5 10/16] perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename to reflect evsel argument and for consistency with other tpebs
functions. Update count from prev_raw_counts when
available. Eventually this will allow inteval mode support.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.49.0.604.gff1f9ca942-goog

