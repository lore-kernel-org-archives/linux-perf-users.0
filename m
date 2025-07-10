Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC830B985
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191539; cv=none; b=USvmKsCvmHFNV8LtKCzU0Anji+atQySSACiT7EfdAfU0j4NTSxRaDa0YITnfQV9LHHittBqxKBu/VjB32NsqJ0dcmkgTMLUreNy8TZN6qngU8TzhiMqZYTi11z9JEgRu/hONWXr4TWHXFA3b9vng3SkfY8UB1BcVcI+oPeCHx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191539; c=relaxed/simple;
	bh=E5+kvYI2Rn6W9To+wrAcq/gxgLLQZbgSx4MLHJcahUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oKOnIIAz4mJs5NLO3HQoRKR4Qw+M4unaZAxWgJDHhMxDczwunGReF2kFDuUwsRumumti9OlYUYbEhO366JUTHJnqOWrDclf8rwcMv+zJ1fcPHeoAA8n+3/CkxytLA7uxncFiSqoUbF1SmeU2k0+n5Au0Yk4YQlhWJQ+BIQ2MDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MI8HuiFp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MI8HuiFp"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313c3915345so2272317a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191537; x=1752796337; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPzAwcY5wS+r0tfRkqlbV0oEuH3EOdPNkOfWet+RrhE=;
        b=MI8HuiFpMNnvz+uJu1EE0LlmUtlr6RueSvA2Q4yywzwzoKVeGoWxj2+OjLer8c2FEz
         gZ+FFcuVE/x6GBg68i5vuL5bBtfRiuvHjG/PYteyE1lOPzqgTIYOsdhIRnknXFazMpxw
         seoBxHQX51lJN/ygg5pO+eqSYG+uaceWDzgVJKPcCMLYQu/SxgYiTlTreCR6CWpgIkDG
         bHgDHatpy6J9CikbihKYKQuqxFHJFNa+D31PB6LFjMwFyTkrvb+Ca8zPfx+C8P6ULqCs
         usvd05dlwcl7A/mFf4MdHvQJfSUTBUN4eLRfkvL98cauxjPLnqwc8P8F2TigPaW3zYjj
         frpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191537; x=1752796337;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPzAwcY5wS+r0tfRkqlbV0oEuH3EOdPNkOfWet+RrhE=;
        b=xSTaxeJf8nvDo9vCs5Iy53sM7yizLcBFWCoXX7j6+HQmy+3bskksX5ld7ELGPbPXu7
         6c+Tiw2YsoZ6MNJF5PisS8ASh1NI99xXADYHVr/zu/ddEerXHC9PjWfvsvaL4leB/9NM
         uL/wxEVyloDI6H5Ti28qpcLxMdk+54doVmCbX+8hZbOJJLcmA0We5ZVcv53lgpmDFsT5
         egKiQdDltnWtiUzghvq4M5aUkCPOaVT27nYZ1FDgml0hfyUtgqqRRm0cXSKhVS38dlhG
         J90qLg1H4A8lqI5TUwOSmiUhGQ+oD8kk8r15d/Xy4BE46bb4lLLyt5sU/4ivzTqCUC/q
         BO4g==
X-Forwarded-Encrypted: i=1; AJvYcCWF3Qf+sngKbUXf/kU/acArDwy/5f3GQDMYlBnLkuhgC2v30t26a4WPuydOt+R3mrxt4a9y/+0kEcI8iwCoyjOP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9cYCem82V7fY7GozsVesWqlNLiJhwDGB2OBaiLleXzG1dBHG
	X5k8SKB3SbM9iA+3gIA1BHyMDWB5w2O6TFBusLuKBepqRRGwbCKjBdrmayT5uKNL7yaDDgOYmJn
	XMTiNMyA4ug==
X-Google-Smtp-Source: AGHT+IHJsuF2z6Bvn0PuYTCBRxnqhbfcAz/bXYQtjNJUh31jdC3iRUP0zoIA5a/Y12HFO1VhXy3RDUCXDmFq
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:311:a4ee:7c3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d86:b0:313:d6ce:6c6e
 with SMTP id 98e67ed59e1d1-31c4ca845e2mr1867994a91.8.1752191537223; Thu, 10
 Jul 2025 16:52:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:24 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-12-irogers@google.com>
Subject: [PATCH v2 11/13] perf python: Correct pyrf_evsel__read for tool PMUs
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
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
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

