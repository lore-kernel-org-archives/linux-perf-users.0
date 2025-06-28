Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F66184F
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069388; cv=none; b=Qba62vH+yRw2pmlduuT81UUPq2bwi7PGrngjS48GBhegUAE2ANnSZciauL6kg5d40Z2JredCFrh+l83dXoGfNiUCz2TLUcgrhqDcPPxPZy68l86olp+IY/V1MYkizdOF/JcokPITb83xLr2Gtm4tqI1woI+4FRY2ZI1SvUI4eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069388; c=relaxed/simple;
	bh=fo0r240oHzpIwxpAOm3xs8m1o38s6/S9m0BaZW72G60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jXGeMSH0IiAU4lfwpldYmA0SK/Xqdd4oNfb3FFNkV8iqPL0Z+2kUIUQJBCUOQFAQ+v7DR0fY8R/qX9qZIHohDUaJyGd+uzA3434OGt744Z124ubDek+nxvPFOtxAJO15uz7zTCNU7p1RO0M96qPXinvzwz4hYOWdhNAiUD2JXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GJvbUOO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GJvbUOO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748764d84feso921733b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069385; x=1751674185; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfCNuQAe9HbC089g4sg7a1ik2VZAO1ML1zW0HGkG2nY=;
        b=4GJvbUOO/Q5qDTKf1kdkzxtkGkLQFiQmsEQaxWjmTE7C4UVSbSvwGh6OV6GQcwrvFD
         11QO4xRVpQlBWXUiNm5xbeuSht7UNPuURIW2X98h0Hd5Kt/K1sMb8WqlvxhegdYq+Ei1
         q5KrUkV0+ghp+8OHrDTM71+byXx3AAqElKoOz3FpeF3SRWmGBFBIxnec3LJOgdiZRntk
         AkRx9tCNhCfLv6OKfn3yuGhbpjqCfgp4cupVBil05Xqr2wTGohLQedXvXNhlnzwqbx60
         k3JkzrKzQbLO3FDVnlNuHeJ/oWDebHo7KE884Szzx3IiPdYFWs6SLO5bKNGG6iD44kgn
         9/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069385; x=1751674185;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfCNuQAe9HbC089g4sg7a1ik2VZAO1ML1zW0HGkG2nY=;
        b=MhwwpOOFZFoq7mH7TTbWroieQT9LhNq/ySYyBNwdvGxguD/pZpFqDwSVuUI80lPINk
         o1hfWaB+CxAx4S795nwWIQTUgGq58DiAlBdoJEEiAL0Pc9MajpxmxVDviO/fb1I6dgGH
         f6zIuAZ/EnwCIIZSiXWq3QsVz4MUdcxRSpiMHH+OE1dFE3fTLIrISvCiPq8SCNddEvrs
         DOBTYXBfIRlNkk4ySzgYQycXc+WhhBtP4UWLDYJ75DVksvkFHPv9OmgAvZPFdGXay3nx
         6YIOd6cL/DRa/6eVNSM8v+8ld6Bh2LVGXWrjtPOmZnR/WlwdpGk5lPllo2RrCqsmDHL7
         XjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzJ0Hy3FwPzgJaRNnqG31Mq/pYpsL2vOZTlPdsY4LfWdjnbPOsZOnrd1UdA24EhSO8dtqOV4sq2QVIuZZf9U93@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xgg7zt0Lrw6DQcMhkgPjlmu6QFwjvItzK837611lhYl06RwW
	5JdJhsxGIhjKwejcfh9ZNg/43XdequXl7r71c3PJpyJh8uNkSa0KbCFRlT0BcSl0fTYRDegCaqa
	AM12Hcg/FCw==
X-Google-Smtp-Source: AGHT+IHYrPuyNcxRNZkv92pYoCGxK6FD0ZGQWmWeIIB811AyLZuxmsar+jXhV4T0x/m8l+FiUYUiW35A9qh5
X-Received: from pfbiv27.prod.google.com ([2002:a05:6a00:66db:b0:748:ea16:c7ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9194:b0:1fa:9819:c0a5
 with SMTP id adf61e73a8af0-220a1277105mr7507317637.11.1751069384940; Fri, 27
 Jun 2025 17:09:44 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:19 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-6-irogers@google.com>
Subject: [PATCH v4 05/15] perf python: Correct pyrf_evsel__read for tool PMUs
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
2.50.0.727.gbf7dc18ff4-goog

