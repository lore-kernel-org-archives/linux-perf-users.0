Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4151DFE09
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050938; cv=none; b=Xqzi63gZLvoWCRAwEAeni9A1PxCo8Exh7eKtMwJdE2gf7a1YDfWv9HAo8u/DYMS0qoCb7HcNXumUa+N+CUiR+t65ppHCQV1XsI4mrwHLa/W510NAVNHOgpbHoSjodHzrcc5S7hOqsoBx2hjKyaDsKr1a7YyZCFw5Ux/GyWG5VY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050938; c=relaxed/simple;
	bh=yKpHM+BCHbeFrpnY+3JEnhGTh0ytgZYNLTTi4rBzWCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pVmMPhkRZumTO/78UAFLAzW+B3y60Je9T28EylDKanEAry322FaeEI85djB2sKY274TrJmM3wi4CH9roeNzIFVEGdauzlcZPkOBtOW2BzdcfgOpFhyTVHR2mqkldzW7AqDH1aKEW+q0OukqEyOXMFpf0blC6fr+9PPll1PkGkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9OgqlqL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9OgqlqL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742c03c0272so4988687b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050936; x=1750655736; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJlPf9F5g9Wk9gssd6aqu3WR8vZd4WrO7zxv/Qci614=;
        b=y9OgqlqLJx15qy2BQk7a/RMjyK3cL6qeZN1RUdITvCEGEpFViARjLXh37RdZOetHpH
         yvoDp1joMvo1WGi1muYCmUzZXmkO//rYmUbDrg1ygPr/sQlUBhymegl0tZPkn7qnxKjS
         Q1sqEJFbXFtukOpY1PvRQltEoiGGBtzDbvcm4tkHRhIw5zOjxWtlFwU6/n1HTGp84akF
         VZFOnaQfC3n2qg33js6/zEKhWH1ojKtyyC7qAys8JU+oVxGDGCoh2O87VP0M7tXTbd6A
         Ixzt+4Cs+i4DJqLtaYvM66JPExsQPEF3ttpWt5LF9MZqTqQ6tCMtxqLOiCZfWd1LF6bt
         qKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050936; x=1750655736;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJlPf9F5g9Wk9gssd6aqu3WR8vZd4WrO7zxv/Qci614=;
        b=wnz13IE+quo6vcBhbQR+Up3oH5gG08Hmi4uprXDJ3lSoAtb0WN78KORfsMyGgVLT3g
         BC7WZ9sS5sE9O7okmmLiPNTRXViIL2YqrkED0VSkHNDKO9JZeJZ4b7bsLCcE56maV7IX
         k/QPl9/oXg/zOIfG1XtBg/BMwkETA5km6Ibut7COtPw+h4elfSaDYcKSUpqhEspX45W5
         l2FcQuhkhOX1I+GKkb1dMI/2Sa6ZQO+qApcLsoD2pchMeGo+XM5ys0NQdq0yDx+otq+i
         l3pLWgJ9mnTlmS6Ats+71tmtMTdjP7zOCiKf7ZpisfkhMR4Tb+96P8eB831AU9rxJkda
         3Edw==
X-Forwarded-Encrypted: i=1; AJvYcCUGJyYe0WjDkLIOaNnGk0/G2nEq/HfxzHCkZxeCGCO+yvnEqMeYHdPoeE/BAryQ8dXS/7XfJE6A8PG3ge+hwaJ+@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8aqelwObPXGk3nEWz7G7CfKpczwEYxKSfb4qQCTh9UkIr4hB
	xZuPAmwzVskrJf5BxxQ+B3GJOXovkJvZH3rKh+xsXn17iEmq3gDe+X2+YocNoirjqG1bRGW1sQX
	efsSPzpSJww==
X-Google-Smtp-Source: AGHT+IG8/lpjRrXKSMUNfgQtOdF3/fPjhcRdKaaH7jugd3IevsUPJkeZLGKMaZeT5E8zo0HJDv/ht6QFjnmf
X-Received: from pgbdi9.prod.google.com ([2002:a05:6a02:c09:b0:b2c:3afe:6ece])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1443:b0:21d:939:18c
 with SMTP id adf61e73a8af0-21fbd4741e0mr11715398637.4.1750050936503; Sun, 15
 Jun 2025 22:15:36 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:50 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-6-irogers@google.com>
Subject: [PATCH v3 05/15] perf python: Correct pyrf_evsel__read for tool PMUs
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
2.50.0.rc2.696.g1fc2a0284f-goog

