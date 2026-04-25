Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5138E126
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156920; cv=none; b=RVNjj37XiOsXWI/zEfLwc2Q+MIRS9CKjC/HAHeBs05q4yak5vW4SFO7f+TYdGjH9vps2O2ZALhK0WvmAkxoTOh4PtUvl/+AdAiQhx+LJM2f4qsB6u9t1VKuQNoAIWKB8mZDVX7r03qZRIK5De4IjsHzC2Xqgbq83a/vKhBTrR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156920; c=relaxed/simple;
	bh=Xy1jdvXXR0/CcW74V/SbsmucLwmcO9cvRlkHAX93Xiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLk2t2cCN0QZpR5xVO+VYpgwqlwmEzJVAeyUAoxatQJyCiIvJhQfTGtO/lGHrvjPQ8X9gOcYNSNTXVtMKaBEYH2/P+xhKUC3MNwC+dA2PgDVyt5ZfWel9q04GlvLz+rxoHMrd03ZF/qu/P0y+3VmASwteMb1yDKSdFslh7mgAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5T9NKD/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5T9NKD/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c91ef7009so23889865c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156918; x=1777761718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vR8VHmbPIJQPTIZrNWt9fCtSF5PQGv7sK1eCsyjJo0=;
        b=c5T9NKD/A5uXwVCCx+jqox6hfIWUEo4ckCnr8XoV8ddeAKrRSzA8kUnjXRZdrceGFt
         gdUmnVFogj3g+YIi+DwWu0VDopqpLeNOvQ/BCpVNWhZeIK9SCyv7krK9JIe+zY2UA7s0
         M+uul0619NFRaA/k4tnRArnReCEji4xNxLA7giOx78FM6kg3aJ29cGmr+SOACbstwbnz
         DbcEvmH2MNw1v7ysvNYm+fkiOXpcQnt6GH9XooqNbjsp8a5rwTxpObAR0MesUbjsZIIh
         bSCDXF/9F6GopllblGPkGjcJrRMuswR6z5NEz0vq138+h1MHa5MInv5lcoud4hRJW837
         Wpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156918; x=1777761718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vR8VHmbPIJQPTIZrNWt9fCtSF5PQGv7sK1eCsyjJo0=;
        b=Bq2c3im8AJqZnn9HL23TKLS8TRyIfUEioaEVjdLxxbvDqqdBGRb+MhR9S063fl7Ccp
         bqUrWzLksVz4XJa3ckvXbjQZIdHUqxKgLv6/zGU00yGdirWqg7jNjjnPpQ/y3GVXVEsD
         K9YHqcXutdmzu8oMSs3DyXRXZcgVK4G/tJI6XpFIYnZtTWUcIsmkap+LmHJ3EnvRXr3N
         p3JN6FBVPRXA+BQJy87T1F3qEuwpBT8dMIP7vIIQ+HLJFFT2PM3JiMm5LK6W+P7bruIx
         0RWz3lJI3X6IHCtzLF/TaDtI6qNpHmVtK0G/7zKwNqDDTz8NheQCnIHF49hdB3R9PTGt
         ESkg==
X-Forwarded-Encrypted: i=1; AFNElJ/8MbJotYk1bePtmviH3L+0dJ7/93F/iSNrA3cZPp6N2uq2/7pMfJbTwZfyKj1XaAur6YBaAx5blaCgtm4O3Sx1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2RKlbmXPdKf4BPMpSMGzWspK/Gtj2W5xRB2YWQlVAaEL4aq5
	k9GQVrXDOrUcXzCVr7l4imxTzlIzDb/vR5u5rD32UqC3Qx9Igx2Z9oD+eY+xBYzP4vS9ZgrPKDx
	lDMkGYmx1AQ==
X-Received: from dlbsj13.prod.google.com ([2002:a05:7022:f90d:b0:12d:b591:4bad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d0e:b0:12d:ca31:f19d
 with SMTP id a92af1059eb24-12dca31f3f7mr3121822c88.28.1777156917931; Sat, 25
 Apr 2026 15:41:57 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:38 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-14-irogers@google.com>
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

