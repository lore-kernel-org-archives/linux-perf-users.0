Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A5390985
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487509; cv=none; b=C4TZb4nwFLGZAdLXWUewtYdMv9qLA0fOTmz+3bAQdKUsRwk+fwVKUrGe8/fNbNZXXeYOP7FOdFpxD9xOdj78cp5cdlyZTEUPc/zRfAH6DZk4QRQLRgqwC+WN24OzzYchVKK+EWmoCb0QN/lgK9P/zGA493MhbDv4R3FCt2AFTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487509; c=relaxed/simple;
	bh=M0rwChGT90H425KH15dEkzggJKx9AS7L316Ocxgc/2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCCymsegRauS+gkIMZACfKPofgnkTwU6FBfVdmcPUaYZQqg8G5/QrFyLv1RYJKOTgPtIoxgOizOxDYrOrJKWHMQFFKFtuOsXwZlUxVgtCVDGsn+KcyLi5hMXh/GjaYhTOnYnBNkLdvbx6ifveVRmJi1boc/3k2X9m8NU9Ngm5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISVOH+7h; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISVOH+7h"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f2d983d109so4312325eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487507; x=1780092307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDdmXqvEMI43mhKt8ZAE/A+JQXqAF6Df2G8xQMsdPH0=;
        b=ISVOH+7h60wQYOqyjSyFeRIKpMOztqLIsWq4w98grkA7GT27Y2124hL8ebnnGVMuHy
         ouYnPrZUml1J+2E4WZ32LHKEN9uDwgMLRHbrGI/HrmX79vM11O39OLRlwol0tdnuVyhq
         ZAacv14jRa+aRYqW/HtKCgfWUEUIlqk+i1Tyc3s9ID9Q067QJbl+Is4AOhXrrlIf2o1z
         HrvEkYjUncIeu2p4KzuLzRmNy3Z3dfQqTJy3z+AqUoS+glN9VrW14wtaeQlYoBPJbArb
         3iADS1ZxjwuV3hhIUOb3QgianhlFUPacnBcMKW9vLKBkqVPBYPAVfbb/9PAIbMsLXOV/
         3R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487507; x=1780092307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDdmXqvEMI43mhKt8ZAE/A+JQXqAF6Df2G8xQMsdPH0=;
        b=GyrqpPsoxPtYe1Eld0pSH6gCPc4YlDGz6pOTxUEJ8IqhlPAumgz2FaBgGljVvo3ytT
         YeH0v1XOpDQgxlC5vrGUK0Ko4mlmkXptzXe6OGMnF6PWr2zm3eZ8JD92jFOkiNgDN3xT
         8YObJcmuwJTbed9N55+M1C+WVKgMrJu/DVOAAKT6mroNT12aSSfAY/S5U38o7HBpAjXZ
         QH4zUlKiVYiAhdgRe9jbd91AYCYKvRaB+Ulv9yMRBj94eUxpR/q1TDWJyBSBk9TAStw/
         mTlR/aF59h0JUBfNkga1qUcwEicqMjjeR4XOegsjFc/Yi1U3H447fgaWO4SVZ9/B/brl
         89fA==
X-Forwarded-Encrypted: i=1; AFNElJ8iSl785qt54VVo50nymnUIVNLu77y2Lnp9dfVhFf5awdknVRU4ztEMMjrX/UTHp+LwscdpGrdQGrAlNGT6o53z@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiCA9ykcZIPqa58IQWI0gypj2nxALzuTgY16Ql2Hab9uG1SIk
	S/vIBtno68E3/jxFRFA5OdLUNnGxIRhwmUOQ74+w3+PC8nDbGUL1NFrJw09JQeBgwGbC7Co7iBq
	eC5dKVZJaZQ==
X-Received: from dybtv21.prod.google.com ([2002:a05:7300:f495:b0:2f9:af7:503f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7f9f:b0:2d8:97d6:6ac8
 with SMTP id 5a478bee46e88-30449141470mr2895866eec.21.1779487506383; Fri, 22
 May 2026 15:05:06 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:23 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-13-irogers@google.com>
Subject: [PATCH v9 12/23] perf python: Use evsel in sample in pyrf_event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index 37e8950ee990..957983e4fd53 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3244,7 +3244,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	union u64_swap u;
 
 	perf_sample__init(data, /*all=*/true);
-	data->evsel = evsel;
+	data->evsel = evsel__get(evsel);
 	data->cpu = data->pid = data->tid = -1;
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->core.attr.sample_period;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7778f88c3810..e14e857cf90b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -45,7 +45,6 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
-	struct evsel *evsel;
 	struct perf_sample sample;
 	union perf_event   event;
 };
@@ -276,7 +275,6 @@ static PyMemberDef pyrf_sample_event__members[] = {
 
 static void pyrf_sample_event__delete(struct pyrf_event *pevent)
 {
-	evsel__put(pevent->evsel);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -298,7 +296,7 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
-	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
+	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
@@ -345,7 +343,7 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 static PyObject*
 get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
-	struct evsel *evsel = pevent->evsel;
+	struct evsel *evsel = pevent->sample.evsel;
 	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
@@ -511,7 +509,7 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	pevent = PyObject_New(struct pyrf_event, ptype);
 	if (pevent != NULL) {
 		memcpy(&pevent->event, event, event->header.size);
-		pevent->evsel = NULL;
+		perf_sample__init(&pevent->sample, /*all=*/false);
 	}
 	return (PyObject *)pevent;
 }
@@ -1802,8 +1800,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
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
2.54.0.794.g4f17f83d09-goog

