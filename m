Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474F228CA3
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613582; cv=none; b=Oio44Gh/zOVC1znh4B8zNBAV58Snj95OY1thxiGV7gxMktVTs8NSugljWf5jcyWSfwCAsBsTtWkbSDlWvl2TtXW4PnfAH2ku7WWABWVxM1wG/A9BhUB/n1AXoaANFAWYQuTNx1nljXAR00hvIssdalehLapDeI3Xj3s2aOxAkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613582; c=relaxed/simple;
	bh=5UP/Uh+baE5hu8ZriWWaikkxKZ2IVDQvVgt8SzI9hYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a0JvkTr2s+phUvhwHl4ulfw0CacXvNdqquaholTBJsIt4yE/ZVG1u3gdD79/NjU0lp4vjQeSXLd2X0qEGYAwHU7PcSPUiQ+uSweQAgxWmPT/IqxBOdFKRErm1XS1f+Lx67yNvmijsPqcv34uuJgP1FBhZIX8Qn/VsxWcBrnKb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MW17tKq2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MW17tKq2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2358430be61so55631795ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613580; x=1750218380; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCZ/k0i1gq0AzAhn4fq1c48xkyywewYDsGvNpD6T3W0=;
        b=MW17tKq2pSwIS/8P1IvuNSvAm9bhapLkd9LIYoabmWGlNFveFHm/kGMo+B+1nQrmJI
         Gw4Hh5vmWhhH2HLs3K0eRqVfHt9gO+f2EqB6NZo+zgLKCvgkrhXb0vT0qE9zBVZ8AF1V
         CvPhvsLpp/VnxYBwKrWCfquzXItHwp3WEd6BuWJOtD5h8Cwf0IwUQyVXdDAaqJ2FpGMy
         6rn7jNBddma0Uop6NTI0vgftPsm6E4bSvIOW9ofl3MW8BPNaNPehn3nK/R4mmu46C1Kg
         UlUQb6KUgqpBPiITW41RuHnMvKHseziMH5FquzKNuacro5H0/l+2ecoOgRmTCI4nwPTd
         nc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613580; x=1750218380;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCZ/k0i1gq0AzAhn4fq1c48xkyywewYDsGvNpD6T3W0=;
        b=picAo9/fkUWnqBOCrxY8vCaG0aaM6FhqDqiA/UKndQd3yHnT5l79TJXukUXq0MtZgG
         2gjpviOESo3TPP7DFGAk7mg1r93TPOBbt9kh+0IiC/LtmWatCCjx0+m3djT134y1NAzC
         jl6SqnqaHYwCom242GQ1wp30Ht12UrTqG8tmGbXoBZ3cercK3/7IiHGxCCnrBckrIo8/
         pkYXSWO71gbMz6maJnVOpPHc0qezB9UyhDYHyO3m6TQjbziR5Id3UVZd3SuLC9KeqF5B
         nyyHzc8RnxzRF/6XTKVJ/qR7kLWueP+RN/Si+ygi0X+E8zwXUyLvjvVV2CfgyuroRHIw
         H58g==
X-Forwarded-Encrypted: i=1; AJvYcCWe4Fv2r5sSnc3a7PcNFm8j8cJyOPJwKcJps+JFqiYr8FvpI5RGfxa+wWpbVxM2JoxMf5SG47eQ+QvLjTXaqCFn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdm8aUZyAuRg+BG1zPywJ/jyKUcVNMy3mr4R+mvL7+WLjHRa9d
	1pcMRvhhUYJJBNqPDHSVthD0I0cZwc7kTwcDXxT0fsshDynvIM2ndJUIZirBUL9NzwD7AMdOGy0
	lwtKDnqnj7w==
X-Google-Smtp-Source: AGHT+IE5QHWGvTfiXwKHIDg/j0GNfWNRQYnCHEayjBDuxpkEbplYkKii4tXQQ92lHmRj0gXTPmMN3iik7zeY
X-Received: from plnx17.prod.google.com ([2002:a17:902:8211:b0:234:cfe1:44a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aae:b0:22e:62f0:885f
 with SMTP id d9443c01a7336-236426b4f7amr18100125ad.40.1749613580382; Tue, 10
 Jun 2025 20:46:20 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:19 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-6-irogers@google.com>
Subject: [PATCH v1 05/15] perf python: Correct pyrf_evsel__read for tool PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tool PMUs assume that stat's process_counter_values is being used to
read the counters. Specifically they hold onto old values in
evsel->prev_raw_counts and give the cumulative count based off of this
value. Update pyrf_evsel__read to allocate counts and prev_raw_counts,
use evsel__read_counter rather than perf_evsel__read so tool PMUs are
read from not just perf_event_open events, make the returned
pyrf_counts_values contain the delta value rather than the cumulative
value.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b724478fe34a..201fe04fb6dd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,6 +10,7 @@
 #endif
 #include <perf/mmap.h>
 #include "callchain.h"
+#include "counts.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "event.h"
@@ -893,7 +894,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 {
 	struct evsel *evsel = &pevsel->evsel;
 	int cpu = 0, cpu_idx, thread = 0, thread_idx;
-	struct perf_counts_values counts;
+	struct perf_counts_values *old_count, *new_count;
 	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
 							       &pyrf_counts_values__type);
 
@@ -914,8 +915,35 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 			     thread);
 		return NULL;
 	}
-	perf_evsel__read(&(evsel->core), cpu_idx, thread_idx, &counts);
-	count_values->values = counts;
+
+	/*
+	 * Ensure evsel's counts and prev_raw_counts are allocated, the latter
+	 * used by tool PMUs to compute the cumulative count as expected by
+	 * stat's process_counter_values.
+	 */
+	if (evsel->counts == NULL) {
+		int nthreads = perf_thread_map__nr(evsel->core.threads);
+		int ncpus = perf_cpu_map__nr(evsel->core.cpus);
+
+		evsel->counts = perf_counts__new(ncpus, nthreads);
+		if (evsel->counts == NULL)
+			return NULL;
+		evsel->prev_raw_counts = perf_counts__new(ncpus, nthreads);
+		if (evsel->prev_raw_counts == NULL)
+			return NULL;
+	}
+	/* Set up pointers to the old and newly read counter values. */
+	old_count = perf_counts(evsel->prev_raw_counts, cpu_idx, thread_idx);
+	new_count = perf_counts(evsel->counts, cpu_idx, thread_idx);
+	/* Update the value in evsel->counts. */
+	evsel__read_counter(evsel, cpu_idx, thread_idx);
+	/* Copy the value and turn it into the delta from old_count. */
+	count_values->values = *new_count;
+	count_values->values.val -= old_count->val;
+	count_values->values.ena -= old_count->ena;
+	count_values->values.run -= old_count->run;
+	/* Save the new count over the old_count for the next read. */
+	*old_count = *new_count;
 	return (PyObject *)count_values;
 }
 
-- 
2.50.0.rc0.642.g800a2b2222-goog

