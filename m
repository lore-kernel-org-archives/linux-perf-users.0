Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CC262FED
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097259; cv=none; b=ViyVhvAgngKIXSYv9j17tDYawCM/JD7bmhc4VDKYVtPSQLmIpGSTevmJYD2xCA8h4xac/RoOu0CfQ4Di5+Jg3MC+EC0kfUcmXa9t3WfYoRBom5k+y5DyTihrT0BCU5kcZd3OC3RLyTkGXG+JIyrOjZ5XXfGrphh14YvOnXsUWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097259; c=relaxed/simple;
	bh=E5+kvYI2Rn6W9To+wrAcq/gxgLLQZbgSx4MLHJcahUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=is2EQAxmYdg3Oqt0Tde9J86Vvs4fOkZB/VSlR20S/0vmUAsq4Pco3ks/SkYPsPbktZ9Y8a8RSsvhEDgkg+VZy6oZaFNq345A5z993MN+eXcfomSKzyt6Oi9ZBAWo1+OJ99zioiASwXNRNEBM3wgF9jk+zz8JVG5Qj/nrbuXbob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvxw8i4h; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvxw8i4h"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748cf01de06so423546b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097257; x=1752702057; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPzAwcY5wS+r0tfRkqlbV0oEuH3EOdPNkOfWet+RrhE=;
        b=cvxw8i4hPFeu8AI/dRWkVIm4epLpc6eL3IPRWDFZNBQEXkt8avfPYn9mOYWJH3rB6G
         3+3A5CU7a4viQIY6l/2OEzByupY9E7SK8MzfkLbQ0NYt4CDbGJBFYKErX0jZypM+VRFz
         leUAXrYU6DqlR8FDWHEA4ch/0dP0SqCOsO5H8JGXg2k3JV6nqZITLjg8sSnnXupBKr6J
         Kzz3W0I7CZ8VHVW9n4dy5oDIhw6sy5QbOwtGHQgbaw4b5E0LtIaqfNdt8bWEvwDHBd32
         W9bMP4JH2PGVO4QCR187nlO20rynQP73+LFjYI0A9G/+pZDqpw7sZx9bI69JezIV/Fys
         KP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097257; x=1752702057;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPzAwcY5wS+r0tfRkqlbV0oEuH3EOdPNkOfWet+RrhE=;
        b=Lcd/cNBFYJ9h4I8nq0CBFN53FL5jShp8EtR30mOvLiv9J+OEboo3eW2b7U5vUQPhl3
         iIUo4Al7v4Ctiq61Q9tRIjj89SB3IXZ/y0ZZ/0Z0pEJL8Qwhab/MViq9oHBwpXER4iyP
         XN6eyDkq5FpxK5bASmbGR8JuRmv4QaUv2Gbl/+sW3N6jW98yhGBPtYSEL3+kl28DlTge
         t/E+RTAXmSSsXUYcWSLWzV1FoV6GO6tlI74m0+RMiZalvct12uf+FTzVu8M2GN/itdBw
         v8QuuoV621aKsNpGjbGezcxRN95ZCN6vfP2ivtLJe3synyjqckEuGg4J02edMuVkiDbW
         smeg==
X-Forwarded-Encrypted: i=1; AJvYcCUb4DYSkVkwg5WNwSKkFET0gut7+GYFbptQ3cO/2ua3LCbAXNDfYG0opnEo+eXHe2yGLt+JiakxM696GtemeTDf@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbbp7jqnF+dIX4+6/tLbb6FQhL/FU8pbvej+WvWp0yFG+EgIA
	8Kvk6BMEfcpUqTvFnio+CGTSh4ENKiOR2rfyRM2pDdiHiaQsiVcZM0XlPyQk1y/XtlaBdS9CK+b
	YjM1Ehp8uiw==
X-Google-Smtp-Source: AGHT+IHL51fC9ib1TAeOQOpDuRYctIEJ481bXGA827xdlsrjNXSyz3KO6lUfEvpnf7effYW5jNRaUhpYIczi
X-Received: from pgmw27.prod.google.com ([2002:a63:935b:0:b0:b2e:c3bd:cf90])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d07:b0:21f:77e2:13a0
 with SMTP id adf61e73a8af0-23003fdf125mr305814637.5.1752097256732; Wed, 09
 Jul 2025 14:40:56 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:28 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-12-irogers@google.com>
Subject: [PATCH v1 11/12] perf python: Correct pyrf_evsel__read for tool PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
 tools/perf/util/python.c | 47 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4a3c2b4dd79f..f689560192f4 100644
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
@@ -889,12 +890,38 @@ static PyObject *pyrf_evsel__threads(struct pyrf_evsel *pevsel)
 	return (PyObject *)pthread_map;
 }
 
+/*
+ * Ensure evsel's counts and prev_raw_counts are allocated, the latter
+ * used by tool PMUs to compute the cumulative count as expected by
+ * stat's process_counter_values.
+ */
+static int evsel__ensure_counts(struct evsel *evsel)
+{
+	int nthreads, ncpus;
+
+	if (evsel->counts != NULL)
+		return 0;
+
+	nthreads = perf_thread_map__nr(evsel->core.threads);
+	ncpus = perf_cpu_map__nr(evsel->core.cpus);
+
+	evsel->counts = perf_counts__new(ncpus, nthreads);
+	if (evsel->counts == NULL)
+		return -ENOMEM;
+
+	evsel->prev_raw_counts = perf_counts__new(ncpus, nthreads);
+	if (evsel->prev_raw_counts == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 				  PyObject *args, PyObject *kwargs)
 {
 	struct evsel *evsel = &pevsel->evsel;
 	int cpu = 0, cpu_idx, thread = 0, thread_idx;
-	struct perf_counts_values counts;
+	struct perf_counts_values *old_count, *new_count;
 	struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
 							       &pyrf_counts_values__type);
 
@@ -915,8 +942,22 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 			     thread);
 		return NULL;
 	}
-	perf_evsel__read(&(evsel->core), cpu_idx, thread_idx, &counts);
-	count_values->values = counts;
+
+	if (evsel__ensure_counts(evsel))
+		return PyErr_NoMemory();
+
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

