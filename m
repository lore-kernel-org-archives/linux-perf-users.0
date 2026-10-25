Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965064;
	b=nls3ubUFj/Y/LvLsvygptKaJYFiYlHIqJOwnR1BzbNWIgAycoFDK0jOFPLXMsb3p5UNn
	 s91sSqORAWDiWwsEeZHmRj8e85p46yPf4YFCZfzTlqz2gm3VlUsZ78DYhTIrhFxzUpg6i
	 pONInIFclPniLKa2PNOZycnyrQ+98an7az3XLy/Qnq59Z7I+ZzDQzXGIp4RMSyWoo3G6D
	 UQ7brYbRBI9Faalgd/W9B1f9zPjHmuLZe9iPTDA4M6CYntNJM2GosNW24Sb8TeB9TQJoH
	 8y93OD6Tss0G1IU6uH9piy1wBkBSv3O3eDOI2C9OPa7H+RFaaDb/FCwXVGlPlDotrNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Content-Type;
	bh=6mBEu8QdPj4ooVI6HvdpOOBqaqB/w+5Tqv00IVdAX5w=;
	b=VtuUd8ygfqXV2uqna+FohLz4VdMH2ja0SfyJmRGlbG30EcVmpv86RGih5lOGWy7uKABO
	 xVN/nFpYhU1Rqa5DGi0qFXr5+47ON069JqSGboWy8MxDYYlLqFWbJS8EO0E+RDhYDc1gv
	 Ehs4ZloLlY39/VB3eFcGst3YXdit/nxnl2vEx2UQPssWCAHUZuS0UcGBpNTOe5xNBTUi0
	 0LElkMj8/aFnzDf/9D9N9mTpo8ZQttnV7YFEHtpEeHdYfUKL+eAtz8HKjkw2xov4nhMvI
	 27xGwxAvZr00R4oILbtqMs7zBn40kSaYVfxnZq8Nkn8qObWa0lShusr5VjCUFrsHT5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Pl8n5Bl+;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E1606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 21:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 021E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Pl8n5Bl+
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3580c07911eso8023697eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965063; x=1793569863; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6mBEu8QdPj4ooVI6HvdpOOBqaqB/w+5Tqv00IVdAX5w=;
        b=Pl8n5Bl+F15yh5lVoMpCegJwJSkZH3E1vsxK51rRk5hYpCl/PiNAEh2xtHCfCn89/b
         b7C3/H/05YQ6KGbRcPj3m+09eVyv5zkUFRpRg1f9HT1ywifYfz18D4q+EcLy6EBPkMJZ
         1x33zkGplXdFIJTSBrZ1zDfKFWb/InT8pvXTizCxOSgSwDdV+RI+LqIbFnJ1vJ4tVCJV
         t1nFjl6B+GoRlO0V4D1LRQwOF6Oqx8pE8vugy1LvP7LnZMULnJ1hKzRkU+29ANM4uGs5
         k3CqrKt9tWjLxw/hNGkWNnVEj/Y7raYc3KF7QQWWwTkyvBQEFYfG9SyYtH3HKzi02HaG
         EkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965063; x=1793569863;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6mBEu8QdPj4ooVI6HvdpOOBqaqB/w+5Tqv00IVdAX5w=;
        b=ALkoXjrt1Wr7zzIfWJrCl5utZQvLTUAig+mC9YDmX2eoMiUjluO3GAfvRvhphnjJ6Y
         ZcpiSED2beurtR/VclOVGkbu44zmWt6GCrZGCSRzi0f1Z5+XxhR1wVyWCGqws2F28pqp
         aCi00OIpcGyIPJkTmyc1E4tButdUSXkOYQitZgubSrUu9QKw0k1DD9yGZXVVX9Tga1np
         aHSxDSBgNstAyF5fXcZ4aMSMaT9E/dmXbX3JkUFddzqbNpQai6nvs2oP/CHLGggITa5h
         qOo1flfsnU53mRwo/6z8velehNuLhH3W/+cgKiMPrzUQgMbGiTi9NnuRJA6ECfSRBw9j
         bPjg==
X-Forwarded-Encrypted: i=1; AKwUvBzIXtKMtV6H8358qQYS4YE/InyxkSu9669CRhs0g5832VklD46+G8acWRgW8eF7DcsY2QFdDtBAj+I5+vJCXlyr@vger.kernel.org
X-Gm-Message-State: AFq9FYISW8f8zNLn7NMAQouKjs2MzeoBGPTk8tbWMVm5WY6Hcu0uFgEm
	j8flVmhphnqXePY0gzhLc1hNNB7VTumxvtDDW2XYcJ1donnFAu4qQzs3Nybc9sTr/bE8lM9nAjh
	Q0mC7wPbWlg==
X-Received: from dycui22.prod.google.com ([2002:a05:693c:6016:b0:369:f67f:7a43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87c8:20b0:365:f73b:510b
 with SMTP id 5a478bee46e88-369e84818cemr7217715eec.13.1792965062646; Sun, 25
 Oct 2026 14:51:02 -0700 (PDT)
Date: Sun, 25 Oct 2026 14:50:56 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025215056.1228120-1-irogers@google.com>
Subject: [PATCH v1] perf test switch-tracking: Fix hybrid cpu-cycles and spin timing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On hybrid systems, parse_event(evlist, "cpu-cycles:u") creates multiple
evsels (e.g. cpu_atom/cpu-cycles/ and cpu_core/cpu-cycles/), but
test__switch_tracking() only configured, enabled/disabled, and checked
evlist__last(evlist). If the test process ran on another core PMU during
one of the spin phases, the tracked evsel recorded no samples and the
test failed with 'Missing cycles events'. Additionally, the other core
PMU evsels did not have PERF_SAMPLE_TIME set, which add_event() missed
because __evsel__parse_sample() initializes sample.time to -1ULL rather
than 0.

Use evsel__match(evsel, HARDWARE, HW_CPU_CYCLES) to configure,
enable/disable, and check all cycles evsels created by parse_event(),
check for sample.time == -1ULL in add_event(), and use
CLOCK_THREAD_CPUTIME_ID in spin_sleep() so preemption under load does
not finish the 50ms spin without on-CPU cycles.

Fixes: 94f9eb95d954 ("perf pmus: Remove perf_pmus__has_hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/switch-tracking.c | 57 +++++++++++++++++-------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 73568c782d72..ff98f5483e7e 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -24,28 +24,26 @@
 
 static int spin_sleep(void)
 {
-	struct timeval start, now, diff, maxtime;
-	struct timespec ts;
+	struct timespec start, now, ts;
+	u64 elapsed_ns;
 	int err, i;
 
-	maxtime.tv_sec = 0;
-	maxtime.tv_usec = 50000;
-
-	err = gettimeofday(&start, NULL);
+	err = clock_gettime(CLOCK_THREAD_CPUTIME_ID, &start);
 	if (err)
 		return err;
 
-	/* Spin for 50ms */
+	/* Spin for 50ms of thread CPU time */
 	while (1) {
 		for (i = 0; i < 1000; i++)
 			barrier();
 
-		err = gettimeofday(&now, NULL);
+		err = clock_gettime(CLOCK_THREAD_CPUTIME_ID, &now);
 		if (err)
 			return err;
 
-		timersub(&now, &start, &diff);
-		if (timercmp(&diff, &maxtime, > /* For checkpatch */))
+		elapsed_ns = (now.tv_sec - start.tv_sec) * 1000000000ULL +
+			     now.tv_nsec - start.tv_nsec;
+		if (elapsed_ns > 50000000ULL)
 			break;
 	}
 
@@ -62,7 +60,6 @@ static int spin_sleep(void)
 
 struct switch_tracking {
 	struct evsel *switch_evsel;
-	struct evsel *cycles_evsel;
 	pid_t *tids;
 	int nr_tids;
 	int comm_seen[4];
@@ -164,7 +161,7 @@ static int process_sample_event(struct evlist *evlist,
 		switch_tracking->tids[cpu] = next_tid;
 	}
 
-	if (evsel == switch_tracking->cycles_evsel) {
+	if (evsel && evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 		pr_debug3("cycles event\n");
 		if (!switch_tracking->comm_seen[0])
 			switch_tracking->cycles_before_comm_1 = 1;
@@ -241,7 +238,7 @@ static int add_event(struct evlist *evlist, struct list_head *events,
 		return -1;
 	}
 
-	if (!sample.time) {
+	if (!sample.time || sample.time == -1ULL) {
 		pr_debug("event with no time\n");
 		perf_sample__exit(&sample);
 		return -1;
@@ -394,6 +391,12 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	}
 
 	cycles_evsel = evlist__last(evlist);
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
+			evsel__set_sample_bit(evsel, CPU);
+			evsel__set_sample_bit(evsel, TIME);
+		}
+	}
 
 	/* Third event */
 	if (!evlist__can_select_event(evlist, sched_switch)) {
@@ -422,9 +425,6 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 		goto out_err;
 	}
 
-	evsel__set_sample_bit(cycles_evsel, CPU);
-	evsel__set_sample_bit(cycles_evsel, TIME);
-
 	/* Fourth event */
 	err = parse_event(evlist, "dummy:u");
 	if (err) {
@@ -499,10 +499,14 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 		goto out_err;
 	}
 
-	err = evsel__disable(cycles_evsel);
-	if (err) {
-		pr_debug("perf_evlist__disable_event failed!\n");
-		goto out_err;
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
+			continue;
+		err = evsel__disable(evsel);
+		if (err) {
+			pr_debug("perf_evlist__disable_event failed!\n");
+			goto out_err;
+		}
 	}
 
 	comm = "Test COMM 2";
@@ -525,10 +529,14 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 		goto out_err;
 	}
 
-	err = evsel__enable(cycles_evsel);
-	if (err) {
-		pr_debug("perf_evlist__disable_event failed!\n");
-		goto out_err;
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
+			continue;
+		err = evsel__enable(evsel);
+		if (err) {
+			pr_debug("perf_evlist__enable_event failed!\n");
+			goto out_err;
+		}
 	}
 
 	comm = "Test COMM 4";
@@ -547,7 +555,6 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	evlist__disable(evlist);
 
 	switch_tracking.switch_evsel = switch_evsel;
-	switch_tracking.cycles_evsel = cycles_evsel;
 
 	err = process_events(evlist, &switch_tracking);
 
-- 
2.56.0.307.g5fe7bd680c-goog

