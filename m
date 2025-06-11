Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891B202C5A
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657742; cv=none; b=hHM77fMdE2lzEI54Q/BvO9X41c2AhhY06ZuFWMRPxP0nrumvvAZZyO02eOt6O3yaSWg/+7/4vMfvfmohU7l1zh6DWU2QQbIIM8MDWLwVJ+KRAfFMIUy8Xj6Wroh96fBePHHs+CB75mlo+AV+VuFFBKrHFLYxEipFwL0vt7nuIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657742; c=relaxed/simple;
	bh=5UP/Uh+baE5hu8ZriWWaikkxKZ2IVDQvVgt8SzI9hYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VGuSkHmF8k/JgnDm64wmqOFyqv6ym5llkaZXiqzGtLaLrdfwjn7TbM7KWJZV+GNO8o8h13Nq/USfAI1gC/W7kzeWPjiZ3ZR3YXma6NUzPwNgo6C3goLim0IZWv66NTQqMsMnlcgcEAfij6xnCu/SK3VsRjDV6CawKYN1Ii1TQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROa0iRmk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROa0iRmk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74620e98ec8so1002960b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657740; x=1750262540; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCZ/k0i1gq0AzAhn4fq1c48xkyywewYDsGvNpD6T3W0=;
        b=ROa0iRmkLA/Ia/ZhjXzAKmX7/HslPymNv1JQECvR2dXqpdUgub69V5uHzN9N3h3O2l
         Y9+iMzmQ6aa/KXmDGUlIp7tn+W3VTEBS/5G31kUS81BleTvA6zeJpzEwuEQS5I9td+z5
         bAtbwbAE8pgag0I0MI2H0IeehIKo1g9JoS9czmAaI1HFJdaqXwm9AESc3og4Te8g3bF+
         uUbAaMFBlwf7xePg8YNX0w1MAjyndo6R6epfxIN/b4rdFLZCbc+gx6Fhf4moGSE6WO5F
         sDNNgbiqWoebgbB0R/kw17L0Bvv7usH0I+a5RPUM4BtYghVw60pOnmW68o+e0BO1ErUx
         /vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657740; x=1750262540;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCZ/k0i1gq0AzAhn4fq1c48xkyywewYDsGvNpD6T3W0=;
        b=VmdixuFUGixbyuUczPytDUV2r3RZfRYO6fPxvcHiNZDei1Mo0f8lgrUeusczhjqsdz
         6qJ87Lqnk0uyxUvKvQYtHbXEpF/tqjNRpWxH6L4Hw5XaQFtO5K39YxglaLa4cln5kSEo
         Oi8FEaZtP7UVPblkCPh3bciA/w81PV7niOaM0WmhV79iGqnsHo3wAeh2PHfwXvzNwP0v
         gkml3/Oj0Hcmzjs72e8I1+EsAMIN18nyuFH8FRL40KU7U5dXdtJgrpZ4oHX/oC3nyXyj
         uNdh5So1jFCnt/TtOqpzt7dffcaKLy7iL1Wervhggw6yyuPvzJIhA/Y4LNZaK3/ccOIN
         joHw==
X-Forwarded-Encrypted: i=1; AJvYcCXBqNQw0y84ztm1WW+WVYbjNU2K2jyAHvmUt3ugNzSTjTaFUkYBxllCKAva8+jskVYzIuuJVG0MrgUFiqsoGT4U@vger.kernel.org
X-Gm-Message-State: AOJu0YwdU1kA6qdueKAK44KAC4PAiHrEamSWCymzjmzys2agXnG5PI/7
	UbEoQAZkJw5CHg73KJCxuME9yCaoUzdROH+7BvCLqCgXjcYm9iQIJcmedgz0T8bUt+ZJUrWlmiY
	SHpTk5zyD2Q==
X-Google-Smtp-Source: AGHT+IG0ZLZ/nkBWVfSY6dXkVV2WwCDI0h4rjtwWi23plFtJ5RNDkDznvEK6svyIfsqMxVXo7kX/WVBqL1tz
X-Received: from pfbih24.prod.google.com ([2002:a05:6a00:8c18:b0:747:abae:78e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac2:b0:740:58d3:71a8
 with SMTP id d2e1a72fcca58-7486d292d6fmr4653966b3a.1.1749657739944; Wed, 11
 Jun 2025 09:02:19 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:56 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-6-irogers@google.com>
Subject: [PATCH v2 05/15] perf python: Correct pyrf_evsel__read for tool PMUs
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

