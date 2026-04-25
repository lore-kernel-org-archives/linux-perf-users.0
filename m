Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443B39282F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157441; cv=none; b=LzVWPjIwHiCyQiD/IKAMfc2EnlFV+23H9/4/q6erTw5zg4CetYAwYatFO2VUEIT21i7JcPK0fe9Ff23zviFy6T8F490OAe97hYZqs0WJNLXHGZlnZmBWH39O4FUQO+3Ra3CAEKhtHsvRyIH+DAbP510iFNXjwFY4bUc3e5WgRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157441; c=relaxed/simple;
	bh=Xy1jdvXXR0/CcW74V/SbsmucLwmcO9cvRlkHAX93Xiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bWddN9fN9ZDib0B/G5mOwHxwhFwcM93dB7pfFv3lmFMC/wLO3YKQMCWClXnLTJUp8SQNMd+evsHkNTQyvm4p/9AdImxJ1yWlaAnq1DwUYoDi5xdspVXGL5rzCFrlTMF9L3k0t9wzM82a5FnynSQgJppoUC+PTLRKLMApvOhzTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DrQ1hPH6; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrQ1hPH6"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2de07c12745so25488296eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157439; x=1777762239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vR8VHmbPIJQPTIZrNWt9fCtSF5PQGv7sK1eCsyjJo0=;
        b=DrQ1hPH6lkcxsuEERQyIL8UsbJgw60gVowXWOtcL8l10l8JvBaNTeR53npdpOlejct
         8Yl43TjeNcWU5wbtuHlCO48JhSKCbrqtj+m+qgR0o8P0rIt4LMoZaKcg2MeHNTROHfzU
         VJR4Ad8p6TMnbpM9bjWkcQyUiMItONHZr3iBZH8Z/A9rnjwPFl+9KJBUdMqbX1cOnSfZ
         OMTujXx4Bc3zT/abxyiJY3nsESMH9LTd70rkEQEKlsGDbYMfnnfbq/GsFrssc84umB0I
         erw8/5hev4YYB/4squq4N1Rm0GLl8+LWew224OQYBeBilaQfIR2ldbD9baPqSDfA53Re
         TYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157439; x=1777762239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vR8VHmbPIJQPTIZrNWt9fCtSF5PQGv7sK1eCsyjJo0=;
        b=oRvWoMxwDLpWRBk8UgbcVtFqxqdGqO0MoflhGMScKOgd3UnBynKtWuFcB7NY2qaUJr
         zxIfne4uCTymCc8CuTzVOqHpaWsdNYSemG+oifASQ+aXaTW0j6H5RNRB5LkY9rn0cKWJ
         cDOnMalBi4i7G9EQpek2MXyGCFJOrNHx83V/FEM3uiyZFDbatClSwpbuNKzC9vV/Ft3n
         Pq9W1QmBIY/m3gEcGreA3ZkDX3+2RzYYdVKHGVJ6RCqeUgvYLMSXG2rQyosbfwqlhwJg
         D+PtTS+7xkVHcmUUpjoqciEUgYiY31jht3QO5/HmHqfJCYccStAsPEIvV/nHNZsD9uU6
         fWbA==
X-Forwarded-Encrypted: i=1; AFNElJ9qmHS7qmAtUzW56WuzmOoHONhVUV9+KIC43GA13UXoDYkoPbfSYhjfe42NwKe6C+LwOabKXDjnDD0Ok1PMvGlq@vger.kernel.org
X-Gm-Message-State: AOJu0YwksoYS53xBlqXy8kEA+IE6VY9q7SNHbptb/lc+drSex2BmfhJ8
	9h6xmtwtdgRc4wUx7WJLqyruuciyQi6lp8BxWaGvK7hafx7XjTaf+tVztKFir6TBi2m7OqfSucf
	Q/fsWGXHqMQ==
X-Received: from dlbqq1.prod.google.com ([2002:a05:7022:ed01:b0:12c:8bfc:84e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:397:b0:128:d438:cad
 with SMTP id a92af1059eb24-12c73f973a7mr21020269c88.18.1777157438616; Sat, 25
 Apr 2026 15:50:38 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:05 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-14-irogers@google.com>
Subject: [PATCH v7 13/59] perf python: Use evsel in sample in pyrf_event
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
index 22cc57914ad4..2ba3556c4f16 100644
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

