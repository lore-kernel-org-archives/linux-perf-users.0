Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097793BD22F
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360785; cv=none; b=nsbiKT7m67dU8laAQOw5SnEBc5wxi4ZpG1H0kt/i3ZbwSVQNuV8EYBRzKpHTEdEespNiHraxKeoXwc70lG4rT7RVeAGa+cIXizTTjlgC0khtsgug+sA3wItc8oL7VNAGXRbkDKZLLp6U9t0nsxvqJt9hf5S4ZD4bJ8as6RLFeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360785; c=relaxed/simple;
	bh=JjIuTOPMtNqkLvLeEeHcSTT6ZswbQar/8U61o2ubr38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KGsC/AdpTtHNRtmBMPSjbQgFh9nNNukNGBji8ZW5Cat0ti/Qqwc7cw525zUzUBTYfrzBirlVnpXlOeW5JLyBxdKtmrkOhhlFDGspiFBfuT1yIjvqpqpSZBIcVWhENhXcWPH9ZoRHnP74Er1ScB++5lFLbdlPvFivMgyoRZZdSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJmqU7hU; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJmqU7hU"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so10995978eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360783; x=1777965583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WTnvipP2as1A/df6EBdlpk0BxoJR4un9G7x1A54Ihc=;
        b=gJmqU7hU4Zy2RIPhbsrez05fPrBtGE9VuMH1jdR8KkR5gKwgEPGBVzFbOnR7RICcAX
         pE8fFtCIV8BDWjCCW5HQp5dHIkCb+rNMhQD5XeH6bFFnNYeHfXZRUIHf3C0IBQLuAFZP
         ka57FrKN2iaT7zELRSt6XtLVeC9HoDHZLzvcRuNfZpXunEyyzuBmb3RK13anLnDeYt+d
         pu6TfEEgOR5W/u1ntuq6lWpc1BYvglYYYcFaI64Gw14L2ZZyG3dYWSIU5LgtR7sPaOQX
         1xIe6oSJQbI1CbdvSVvEmmDgFDaQpe+usraRPIzLX/nOguZu9w3t4D9OSwg/9wVQ6n0A
         pNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360783; x=1777965583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WTnvipP2as1A/df6EBdlpk0BxoJR4un9G7x1A54Ihc=;
        b=SJRbtg0N9fn04p61OyH873qgKnn4xnhN2IzNxAG7xKxMFdWH6VCp54KI/q2PIwsUT9
         VyjUxScLgAQ3xFQNrFSOXE9QqFSx1d6LajBcTjJq9hKIdxHlcPFopTwfeVEjWqejgERZ
         5Mh22B/sIP7IBj5yjYD3nTA0Ant/xZtN2MwzgzKruAtgCg9jwgXH/w7ZoVUEVb4vqBbj
         KRZxbl5nM5WAZPLgKYKNlVuJJsPBX0Q5Sb3mXYlpfqr68qnU6N03H2KJlK11gW5zVFda
         ylNROoP21IVtWifekl+0rxHTMLSxFOr+Yz4x6IURPs+6Q825EmJqGa0MiC2mOLiVMfPq
         FpSw==
X-Forwarded-Encrypted: i=1; AFNElJ8ADAg6g8jDWVOtVsZW5lMQ7rR4bBsUS0Sos1kmyKDkmkr4ZqaP962SWmfnLzKqSJjhVjos3pjFt4++XK95uDBu@vger.kernel.org
X-Gm-Message-State: AOJu0YztCRFnVHkez7abMp6vnBjJec887t62h6L/g5ZhbQQeeu8cr3C6
	5hWge9/laEXd7/33DaqtUMrxKcD46OeX97kTtk89eC32rnmPthG/yY/Bcmufi7NU8WkniTpKFMq
	t6bHxUVAXvg==
X-Received: from dlbpt10.prod.google.com ([2002:a05:7022:e80a:b0:12d:b1c5:1596])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6726:b0:12c:3d30:37ba
 with SMTP id a92af1059eb24-12ddd9e2b2bmr744392c88.25.1777360783035; Tue, 28
 Apr 2026 00:19:43 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:17 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-13-irogers@google.com>
Subject: [PATCH v8 12/58] perf python: Use evsel in sample in pyrf_event
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid a duplicated evsel by using the one in sample. Add
evsel__get/put to the evsel in perf_sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c  |  2 +-
 tools/perf/util/python.c | 10 +++-------
 tools/perf/util/sample.c | 17 ++++++++++++-----
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3015b9b4b4da..9b16d832810f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3235,7 +3235,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	union u64_swap u;
 
 	perf_sample__init(data, /*all=*/true);
-	data->evsel = evsel;
+	data->evsel = evsel__get(evsel);
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4b8d6349b7b1..61a7ee1f4c2f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -43,7 +43,6 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
-	struct evsel *evsel;
 	struct perf_sample sample;
 	union perf_event   event;
 };
@@ -274,7 +273,6 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
-	evsel__put(pevent->evsel);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -296,7 +294,7 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
-	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
@@ -343,7 +341,7 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	struct evsel *evsel = pevent->evsel;
+	struct evsel *evsel = pevent->sample.evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
@@ -509,7 +507,7 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL) {
 		memcpy(&pevent->event, event, event->header.size);
-		pevent->evsel = NULL;
+		perf_sample__init(&pevent->sample, /*all=*/false);
 	}
 	return (PyObject *)pevent;
 }
@@ -1798,8 +1796,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return Py_None;
 		}
 
-		pevent->evsel = evsel__get(evsel);
-
 		perf_mmap__consume(&md->core);
 
 		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index cf73329326d7..7ec534dedc5c 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -1,18 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include "sample.h"
+
+#include <stdlib.h>
+#include <string.h>
+
+#include <elf.h>
+#include <linux/zalloc.h>
+
 #include "debug.h"
+#include "evsel.h"
 #include "thread.h"
-#include <elf.h>
+#include "../../arch/x86/include/asm/insn.h"
+
 #ifndef EM_CSKY
 #define EM_CSKY		252
 #endif
 #ifndef EM_LOONGARCH
 #define EM_LOONGARCH	258
 #endif
-#include <linux/zalloc.h>
-#include <stdlib.h>
-#include <string.h>
-#include "../../arch/x86/include/asm/insn.h"
 
 void perf_sample__init(struct perf_sample *sample, bool all)
 {
@@ -29,6 +34,8 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 
 void perf_sample__exit(struct perf_sample *sample)
 {
+	evsel__put(sample->evsel);
+	sample->evsel = NULL;
 	zfree(&sample->user_regs);
 	zfree(&sample->intr_regs);
 	if (sample->merged_callchain) {
-- 
2.54.0.545.g6539524ca2-goog

