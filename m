Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39975421A00
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686939; cv=none; b=m+OMI1JouB3ePLA9MO88K6eID7y5wsmp80pdOF4DgV3yQqRJvCXv5vzJcAT0U/f3h7WSrunQo/sVQ6BQZH+N8bfJF67rb1Ey7SH031A5cK7UoPhS9OZZkxZbVPRZXlOWLH5CayaH7MUwCWuQ92n9iwQvgV8g45PZ0iiwNxW0iRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686939; c=relaxed/simple;
	bh=xmtIENNajy6s2avADkic3uk2mTmWfZy7KD5pWYP2COk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3ommGf9942noqmbUv0E98Yc6BgpEoN1LsLmC6qgs24ht0urzsvgt6B7B9onSoeWfsija2OJc8sv1KwmQaRn2siCdEXku6IUJAs5QlCs86SEyjPM2wNKcLM8u9iSepB5qb6AePACHOFAlCmleB48XNVaRx7xC3KZhJR783Iwi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U13m0lvr; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U13m0lvr"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30762d67a64so3304173eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686929; x=1781291729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9w81A1e/wdJiOZvP0teOaZnpSggvivJtvNKbzR4KV0=;
        b=U13m0lvr9LoY2zcfufeBDYsx0gv/kXtDTv+7ER5sA0/qmePyLctT8PTOdIx9/OHNuq
         G9zRCi/bcx52N5Eg1j5ew4+m4mGYhq83N4rkjqXYfERpwXOT9oh0Mdd1AvQn0dqMaYDY
         yTrUQrWw3NA00WVYQ4g+sMm69ZO34wfv+KAe0kvusxGhqX9a4QQWq86z84Ls8T77Pu7V
         68n3ImCT9+mGIxuCjZdawL2hwU7cWvS14Pyp7jQcXADr5iBf2kSFKA3MJ2oC6oHZ82Nn
         5P1rzTVmCER4BEoFdF0YVeN49vW9LWlI0K7mmXyfJlrW579gh1ipsiI+5ZaQXGPkHM8a
         mdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686929; x=1781291729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9w81A1e/wdJiOZvP0teOaZnpSggvivJtvNKbzR4KV0=;
        b=pwuOsUFW9r/CCyqwJLCIChC/iQ9tfuSrhx3qur5SEoOdEQ0XXGysA8Ly9q6GegqbU/
         olhOPKAgm61G0QoUTnXkwWYimeGHo3D/3ZAmkOJ9DDYXBAQ/KI2otNhMWRQwoQqIirpw
         9nQ8sxJ5pTwSjmhXbkZGkD6O9uDTjjiiheIiUNLqilp8PZhwDOBtNuZmaXEjilOQLPw4
         PM3wd2B4EnERiYAoSKtSDcC0Rlmhmx44lxz25jmcQvgjBeQ1AAlIYt09hyEQEw8ZyPnv
         DGy+eQU5NaVvxrg5RaxRpvAg69WJwGmmr9QqxlFn/3FDY/aI4VJPdvbr7bBJKaL/p2Rd
         nyow==
X-Forwarded-Encrypted: i=1; AFNElJ+EViEenDe6llseGRDMzsAFh8gY36iN45vmnl2STDsSfZUzGsQRnE0sYUqOJZQkNAOR8vKvZYq5/cD1h4yj8FW6@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSuErzJmtOtX9aWZn7szNXURXnyK8bXjvj1LHA1b+MrME0EpP
	3pSy8LeuQenR5qjmiWno9ajQByFRWf/NTh53yjsl1mcMdNmid1CeU2r5anbpxm+CXBOpyz6Rxfu
	V8hTPxK/Qag==
X-Received: from dycnc21.prod.google.com ([2002:a05:7301:b95:b0:304:d831:cdfc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e619:b0:304:6448:dfd7
 with SMTP id 5a478bee46e88-3077b5950admr2501720eec.18.1780686928895; Fri, 05
 Jun 2026 12:15:28 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:49 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-9-irogers@google.com>
Subject: [PATCH v11 08/19] perf python: Use evsel in sample in pyrf_event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
index ba88c29ebe5c..d01c78da51e2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3365,7 +3365,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	union u64_swap u;
 
 	perf_sample__init(data, /*all=*/true);
-	data->evsel = evsel;
+	data->evsel = evsel__get(evsel);
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index efe8c3b898ea..8b922d3013f2 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -63,7 +63,6 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
-	struct evsel *evsel;
 	struct perf_sample sample;
 	union perf_event   event;
 };
@@ -294,7 +293,6 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
-	evsel__put(pevent->evsel);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -316,7 +314,7 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
-	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
@@ -363,7 +361,7 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	struct evsel *evsel = pevent->evsel;
+	struct evsel *evsel = pevent->sample.evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
@@ -529,7 +527,7 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL) {
 		memcpy(&pevent->event, event, event->header.size);
-		pevent->evsel = NULL;
+		perf_sample__init(&pevent->sample, /*all=*/false);
 	}
 	return (PyObject *)pevent;
 }
@@ -1899,8 +1897,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return Py_None;
 		}
 
-		pevent->evsel = evsel__get(evsel);
-
 		perf_mmap__consume(&md->core);
 
 		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index cf73329326d7..bccc19e2aaf2 100644
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
+#include "../../arch/x86/include/asm/insn.h"
 #include "debug.h"
+#include "evsel.h"
 #include "thread.h"
-#include <elf.h>
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
2.54.0.1032.g2f8565e1d1-goog

