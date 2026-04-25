Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8892236F2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139369; cv=none; b=Tys5FQa8bht9K/GVj/30OWNyvEvWWLjziU43ArxRZpmQqQ7HN3rQy6B2MX59cOsIXdpWtyKtMvHrui1AIWv9cwYO3r5V6DyEnlw9cwKorzN8QsfWoIuWJI0SRMSWH9USdC6Y2xwfqYD+3/n7C/V6JAdg0+pSlhKtfxhAfV/IejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139369; c=relaxed/simple;
	bh=DwbJ+esftuq3MGeFWhJtoZwMccklCZAo7UAdBP22Dc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IEKzZ0Pijw66QHGltaRw4Xmb54GXwjKOillvUh3/rrmynzZXIcRfvuCAS2trnbRktWqQBZfqh/v40jyj9wI1IxxL1qo6eZazme3YvBG3qCF5HuIfw5DW/tM1SZbG2HMURpz4wOxyTpvL0Pi6RY2Bch8gcs+8F+IdLLJDdj9g+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CToFjrLZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CToFjrLZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so12313783eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139367; x=1777744167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcG6S8sD2yT7zpeIqrswUwSHsWXSEMkUZJMomhjZP3s=;
        b=CToFjrLZXdvQfKgNEdKzxukoRHJSM63HVE3n9z4RjztG87k5q6/UcAdFf26NGEl/Uq
         dxnzogqJ5hv5ZV7QwoKzQMPxH5986RE4tm3IbPaAAmm5m87zxhErDPjJoGmVYDFT8Y/l
         GPs46CO9j1wZMZAG3EXn/Uj1vhdm43ueVMQoLo9wr7SGN+/iHm8/4ZhbrLV3FdO+uZbq
         JX7M1HcsyxO9tigNrDrKtfAPtFDyjGFB7s2ClSPCAlIMqegLgpDFidoz3WjcuLX8fV/r
         nVq8w8IFXili34SklWW3N88Z49C201R0aSsXvpZcOPzx647z5Ep7RmCXlUETQTvskM7S
         iBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139367; x=1777744167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcG6S8sD2yT7zpeIqrswUwSHsWXSEMkUZJMomhjZP3s=;
        b=pjnPZ5FIFg1MMaiC0ZaBRh6LRSXn/DEahoZBU9YHYdI0D+bbnAU6nw1bOwRx+XEePj
         FYSbcGGtCe6YY5T3jbw2oxGQvz0Bhx1INdnUZTgX4jXH1uFRhLmyrAYVAssbggHZUywR
         NCs543vEwYeNbRHV7x/PC4hhnQdopWFWDb/8zhbwafAlf3eF05m86VLlXdBYepEsVqTw
         WFQ1hyGOt7ryTCNQn4x8tUXvhSH2J72xgeKE53gW+NE2TLEpZCtg5A77KASdFp2m5rWO
         KYwb8k2R5zLfEme5SwzFgXHpDPObJkYUei1jHDEa+qqxWogyyfxGhHBuOyR7UO8tJjAB
         gXyA==
X-Forwarded-Encrypted: i=1; AFNElJ9iYcF5gt7MyxEX/xFHgHrGiTE2NoCaSzNty66paiD8s3lwWd9DZcrSnD+yMyuv4wqOtIeHgUm7Vjw+OKwVyLzc@vger.kernel.org
X-Gm-Message-State: AOJu0YzSM9EsMyruL/UI7ymw9dMOZ+wUHDnYcgKnrSgUanAZETwbPkck
	EAbCEwjxlSjRC9cAlptOD+NeQFjFThnlXbqjBqSgI7XnX4npocMsBCwR3XP44M/idA6eHNtb3IR
	1S53yLrUD7g==
X-Received: from dycme6.prod.google.com ([2002:a05:693c:2406:b0:2d9:8c75:b19e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7fa6:b0:2d9:6373:ad09
 with SMTP id 5a478bee46e88-2e479019158mr21380798eec.25.1777139366672; Sat, 25
 Apr 2026 10:49:26 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:11 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-14-irogers@google.com>
Subject: [PATCH v6 13/59] perf python: Use evsel in sample in pyrf_event
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

