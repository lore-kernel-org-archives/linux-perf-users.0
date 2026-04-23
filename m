Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456035CB6E
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916566; cv=none; b=ojG5dODbmp3C6q8InkwIKmbgnNrot/H0JjbHzoM6Ru5wa4wLIUFjIItoBhq+YR1Tzq5lnPhcy4qQzhVKqelLXwTj/bKoz3nmJC+j8wHaAr/P6XvppxNsIBduz/zmjJTSf+/wVjf+IXzcDt1pjVGi1M/I6T6cDPKn8dGrITd1GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916566; c=relaxed/simple;
	bh=mGTGBAbs3Jg3Hhrghba97OSdcw+VPVz/oZ0Fwsba1go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I4ItPEP7mDCT8gBKtrKLUtm3Mp5j9JMbj/wu96+QO/wG0EB8ev3qLIyfA6KFU56jcCmqLwP1jKxmii447AaJFykwXMcs0qVKA+PkEfip2UOU6ff7NknQAt2mQLb3/qzfdpwFV2ep84R2kMufwPwSoZLUPXFOZrivElB/DKmiUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KV+s1JDk; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KV+s1JDk"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c35f2c09dso7469335c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916564; x=1777521364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhkvGLcAOVMcXZVbsG+iDcNEwqKiCmKSmiJyrtBC0Qs=;
        b=KV+s1JDkDuxMkQgHUcYR6z1nXvJQCKJSdpMgUeQBtwoayqWz3BQXk9vBqa8gCg3djM
         Ngd8UWn0XFuy5f2VXS1B78toAGCONC9Yb1YscD2NbXVVSsa/BaH6Z5gCYUVEzqwF9y5L
         xv1t4LL7Zc2eicZRTVsUY5u6k2gxrI39Q4ojM0S334sW1PlwVrDpl4Cihq28pv27Q4yV
         dOxF9mBsDC0D3iZ63v2OSKSBEMILsfTKT4sQXKg3aUCbhk1O7HWFOY4upGtANMfa24y2
         GOckkRSHLizZROTv97tkQdaRBcQ0brFYQl7bjOlb8mj23nxK105hC4i6WZmUVqeLQgj1
         /caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916564; x=1777521364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhkvGLcAOVMcXZVbsG+iDcNEwqKiCmKSmiJyrtBC0Qs=;
        b=JMftSEsed7zc7RrweHfEDCQBpWTcIRU22SVlJPPxGMOmysGldqvGCTePtL+gLsyxM4
         KARsv2b8/rBRSmpvriQsB+E8iPeZRxoMdBtlA49/j3F1g6GUMf62JiMfe+AEO+70y1io
         Wto872ISrWkMtBUmWL9vLS+JLcFDIHZGj+K73IcWdM8rHThzU07xQWwFME0QnXxOI/6a
         UKYkaHPDf3a4T1FxFZCzphoj420sagA9KqhtH8ExzglYxSRsGwp6cbEtmNeqBcoLeZON
         YviLq5XXKcOYKi1mgLeI+3Vh6jiHeoM8tHHXehEQ7u/wrlh1JaUbu09zyiNCHJfbyO9H
         kZOg==
X-Forwarded-Encrypted: i=1; AFNElJ8O4/AfA9pA7rfrHRZi5rVmngGHTovCJJ12DjddCTb6eB3Dkzb5z0AzJDS327XOVentKN5mhk2Y1l+BayyqYQ8b@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfv/uF6J2e1XWnVhL+rxXnWdkPHZgHxYoihlDdAwTPhsHE8e0g
	QawASM+EByq2WyX8Q4lCZqhafMzIpzj0VU6IiaXJkGs/NEHmSnTw2d5MAZX6feeQiy4SS56y9aP
	ZKU60/P6bzg==
X-Received: from dlbcy15.prod.google.com ([2002:a05:7022:b8f:b0:12d:bef6:56f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6191:b0:119:e56c:18ae
 with SMTP id a92af1059eb24-12c73f90c50mr11990645c88.22.1776916564050; Wed, 22
 Apr 2026 20:56:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:40 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-14-irogers@google.com>
Subject: [PATCH v2 13/58] perf python: Use evsel in sample in pyrf_event
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
 tools/perf/util/sample.c | 16 +++++++++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

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
index cf73329326d7..106848404fdf 100644
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
@@ -29,6 +34,7 @@ void perf_sample__init(struct perf_sample *sample, bool all)
 
 void perf_sample__exit(struct perf_sample *sample)
 {
+	evsel__put(sample->evsel);
 	zfree(&sample->user_regs);
 	zfree(&sample->intr_regs);
 	if (sample->merged_callchain) {
-- 
2.54.0.rc2.533.g4f5dca5207-goog

