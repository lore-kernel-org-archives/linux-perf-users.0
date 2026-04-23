Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80D379991
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960637; cv=none; b=d0nR+rC1cjjqqWIEDVq6q48XeRlOPh26y9JE/EUB+HhEqhgpff8W5PQ+er3c7PkkKfYrN1fs+XxlZqZFT/GSQAIkrFE3gdu/vvH61ahrB+vEeJh9MnUDUJ2ea9c+ZEBzGOYPPmbNAHGhfHROPRR060YVjZQ5SEiX8g0+4EUJ9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960637; c=relaxed/simple;
	bh=SddOEk71s5ZNjyMSXVIiJTxbAbNJCkJjg57RoW56KlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDmnaqqueaPjGbg13VPEFZ9dOuXb66wKpAJ4l9apipaZ3MTke48IUnFXbuzCRqwudMj5SBDKlISWBZT09UH6PSOYJqsKzJpOY+xs50qwsL6QZBREsDnQ3VWtpYi4Qtyw9IaJ0//KaV5tiKf8wpqdUw7zwnsrwk1N8OGC5J0sG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMuLQuuQ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMuLQuuQ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d889997495so16316990eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960635; x=1777565435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8jf+KmiYWt405SLVCkdGEX6YLKwma920ZC5K+EWf6U=;
        b=pMuLQuuQyzmwOukP+Zrc2PB+5GO08+tlWTvyGYFPMRWH4jMNwSIpq0ruCpVE2gze17
         wO+0LOK9RSSZ1kVGf1m+mSH6GnQCgyItauE8GON6ENpOKQgSNGzoi5K8WNm15DzJrHzj
         lsxuiZhrr5df1dkcvuK1gHI6J7a/oNWTQ8MYORZKqzEwEp5ehyNy/VYaCoN5JO5eQK5h
         2x4XARCoKR0yYPeCi5RAVBFC1a8Xjm6QAIBpAMHmozueOn27Hp9tSO+jF2S6puidLtU1
         4sfAZRUubMQxqF8+efqYqhKfWUSbWEKcvbp7RY1kHjcKSX6bW6tQ/D2dzbdANNgrU/Mp
         mMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960635; x=1777565435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8jf+KmiYWt405SLVCkdGEX6YLKwma920ZC5K+EWf6U=;
        b=qKS6b4chB1DJESHn+Njmw96lgVHr7no/EIEcc3GqpoZ2NqN5dQWQF6qf9FG3INRff6
         cvshcupDp1LLDboCizcutQk789ZlgwIJw7lnoTkmx0IxmTQrWs/SHdAhLEH2QnYo6wq9
         icHt9EE3/B4xuUsP8ucg0kso26aDYFHsbmtMeXvApYJYw0GWtmO02EBW+6BBRoohiEvJ
         +cYgCLSj4Wrnd84Z04h7um9h29PwvaaZalnKqymZah7dP2LNYC82s/SrV+atnI0k9tbK
         BgsxLGvDKcrl7L9lAUCmEbSl51U8zRzOUNc4dlDBFsqM7A1RldgMbxFTZpLb2oDKET20
         uHEA==
X-Forwarded-Encrypted: i=1; AFNElJ+7BG/5eafHRfBaXZBJz8T4VlGJhowI/+K/cnqEqaaMjs85RtnE+cfuEUKPozk7LLu3buucpR1So/xzvv8V6D+7@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3gBdztCa+3uud4WhIZA6WJQrqScjags6u18lzIXOrGwfZ8nQ
	AXHlOYOp+NydeuU1H4lLlIonH0meIOQJ9B8RxP6kb6Y4gjKCrWAuT8ubAK7aazKYRuvP2Vv7P6l
	3B1aVo1ZzAw==
X-Received: from dybnl24.prod.google.com ([2002:a05:7300:cf98:b0:2e6:238:66f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c0f:b0:2c1:7b61:8731
 with SMTP id 5a478bee46e88-2e46519e340mr15018276eec.10.1776960634134; Thu, 23
 Apr 2026 09:10:34 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:19 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-13-irogers@google.com>
Subject: [PATCH v3 12/58] perf python: Use evsel in sample in pyrf_event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

