Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AD33B6F4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049294; cv=none; b=Vp387znIYxRLDTIA8QA+02tGSlGsGKhX3a269aBAuXXjcYk8qx4AybhfMRkOxypH6bv4zMd+hKL+f90PB8oHqwyKZ0A1mLUWoRb4/478MBOxQ/mev+eCY4BDbtfgvF/DeueITQY00fvIzwVXF5e87XlRRgoDkciDh7lzk6oBabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049294; c=relaxed/simple;
	bh=DwbJ+esftuq3MGeFWhJtoZwMccklCZAo7UAdBP22Dc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vark9Dikz1TZ1j3OV/c5dcFcc+wyMXg4JlR3d2RHl6OFCdvZvbwh2+p5rDV17UhPUH4aNlADmPnaPhie2vlEt/hcpU12igJrOSPYYtefSQlE+td5cYF8y68vGAG3Kz6YuI4oZqYntp2n3BJZuBTH7uBvVQI9NoFcjPQKMMR7OJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tW/Ysepz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tW/Ysepz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so9027669eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049292; x=1777654092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcG6S8sD2yT7zpeIqrswUwSHsWXSEMkUZJMomhjZP3s=;
        b=tW/YsepzOpFuve/olmEM3KtwL4q4O/XLNz7rqsvsumTtCi8hLiH32e9sTwm8QstUso
         E4j4bAFosaV04+gue54LlngZtUX7o173owYn2Y326BhuXQqbwn1/hOs0MTGYVklvp8Y/
         RM/gtXT14SIxok2c0Ne5939iTJdCQUfYzKWzbxySffLcwXUY9gtodc7ReALuaCWiruCC
         L/+xWcDdMEpxPp1k9u+IBuNiJ8E7EPSOYujXggPrkN/wWt0ZwdiNtKNDCfWa6UzKl/uV
         ZMRKsPfqcquUtLaGatOnC20EVb4rzorqtQm8BJOZgPt6d8Mglkbeu8oAgrXZDWVgwNVw
         FuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049292; x=1777654092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcG6S8sD2yT7zpeIqrswUwSHsWXSEMkUZJMomhjZP3s=;
        b=Dg42ykGTc3xXkH+DCFfE7EtaP+3aJ+bE58axlHUPGZyAfbl8hGzKhmBXr3nG6LlvfZ
         dmrUU9d5yyT6VqPR4RXwbzsWQ8j7OWfNDfXO7zb3yWxNc9lalNSPJfw1I9ip/JNgJi82
         xN8ozWsLl+8RoH66paLOWnlDhLFFRAE2Vw0gI8ZLALy+h2aym7f+qF5paNPCWcAznY6u
         rL9/DibA+wsVk41REpXDb6Ey7eZpYqym5y7iNXTs270R50giy2KAeV6j25zB8FjjJHAE
         rH3C7xe7zhRPdViCqjhEuXq72DkDoBkyTz/EPm31Og9dVbIivPYDdeHorCj7PIniNpGn
         pTyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+w9BFKCXOYmWAkJyA2VxAvcS3/55cRaPlPaSukBm5h6VVmg7CqIQiV+f2IfCsZWxAoWA8PaRsR36TOIoHBb4ZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YygKBJNHFzNcvLcxKMOdtbvz7w/NC+HqUgFfg/3D64miA9HNSsL
	veba42KmCCyB05pjXaQYJz0dDQx+IN+Js4QJ/4YGDTsM+fRlYSdFu44e1e2BG451ylWiGYyhf8/
	Yhjks9Cdcxg==
X-Received: from dled13-n1.prod.google.com ([2002:a05:701b:42cd:10b0:12a:ad8d:be18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6289:b0:12c:33dd:fa15
 with SMTP id a92af1059eb24-12c73fb4362mr18237669c88.34.1777049292407; Fri, 24
 Apr 2026 09:48:12 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:35 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-14-irogers@google.com>
Subject: [PATCH v5 13/58] perf python: Use evsel in sample in pyrf_event
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
index 0162d8a625de..0424290f8b77 100644
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
@@ -1788,8 +1786,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
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

