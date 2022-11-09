Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F58C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiKISvy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiKISvZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B518B13
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 10:51:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3691846091fso168571777b3.9
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sLyT/Gr9bkwApsNO104BHOJyfG2Scy1gd5V/ZkjXU8=;
        b=EXPYNDw8q5sMJw/9h7sXe54NaX+ABlrBG1Wkq3hZtn7Ly9uN7CJRP3sLwHDwmnARdX
         NUKekK7B9YJ6VUBNcmn/rOeUdBvy7RW/PLXTvopZRWHqpbh+5pXYy8iQyfOKfmp1srRh
         k5ZtFsZMK9cOdTujKz1D8zGojY+haXTOh8gGHObFlO4iLcTC7e5TII5AJ+YD2CWH29MG
         g+gqUe66dVtnGOsdBFEONBILr/BpnP7rMG5w2KIeg7i+csPdrqcW67ek2hD2JJ1YYCDq
         zj0gzDbNdDNIeL/CmiutymV23VmKicaFyhrv3F4ghu2BIX1essHFw2dCtlNs0RE25sqE
         7ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sLyT/Gr9bkwApsNO104BHOJyfG2Scy1gd5V/ZkjXU8=;
        b=eejYU836l8zOLAikjnp06bD32wSJx4DlD8YSF1WZmrO95+O/Eo4FtfEd8975auKNgo
         /82OmURw1FKA8gj/S6c5dN2cSIyMM7RJZKJNKN9CL4kyDE1B+oeON4nJS882246oGU2f
         uBG8r/qgcLLMlX0on2Ueau8+RNP/AN/92sLoLAnmREKKCMXQbRY7xlVoUlemmji6G/JO
         /MUH8lGEh8IVH9n785jxUMI7VZRg57Cs7Yvy/xPYdoLYrhpiqcqC/frKHLLvwOLO9+M6
         6027ukN+62CRAnd6ifqob/tYk29ore2aD6eiJ/0vXXWaCBdfB7rygZ4a22DL70o2fxB6
         84Vw==
X-Gm-Message-State: ANoB5pmB3ctYCLNCAUTlrFntbZ8R4i8C+3InceD1kaNHb/wuIzOx3H4r
        GR2M6A6kh2Cy236fOCU51cyC32ngZ2Xk
X-Google-Smtp-Source: AA0mqf4HxDGA952FGpZO3fPfjGLbv9zXSjWQY5CePCx7XUHVmB1pNjrB3rDzlhFh2UsrbPTXX7k1tQCSGVMa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a81:19cb:0:b0:373:e88c:bc61 with SMTP id
 194-20020a8119cb000000b00373e88cbc61mr905833ywz.226.1668019865531; Wed, 09
 Nov 2022 10:51:05 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:12 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-13-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 12/14] perf thread_map: Reduce exposure of libperf internal API
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove unnecessary include of internal threadmap.h and refcount.h in
thread_map.h. Switch to using public APIs when possible or including
the internal header file in the C file. Fix a transitive dependency in
openat-syscall.c broken by the clean up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                              | 1 +
 tools/perf/builtin-trace.c                             | 4 ++--
 tools/perf/tests/openat-syscall.c                      | 1 +
 tools/perf/tests/thread-map.c                          | 1 +
 tools/perf/util/bpf_counter.c                          | 2 +-
 tools/perf/util/evsel.c                                | 1 +
 tools/perf/util/python.c                               | 6 +++---
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/thread_map.c                           | 1 +
 tools/perf/util/thread_map.h                           | 2 --
 10 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d5e1670bca20..fb2d13650e42 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -93,6 +93,7 @@
 
 #include <linux/ctype.h>
 #include <perf/evlist.h>
+#include <internal/threadmap.h>
 
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5690c33c523b..c554dd9bcfee 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4093,8 +4093,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	}
 
 	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
-				  evlist->core.threads->nr > 1 ||
-				  evlist__first(evlist)->core.attr.inherit;
+		perf_thread_map__nr(evlist->core.threads) > 1 ||
+		evlist__first(evlist)->core.attr.inherit;
 
 	/*
 	 * Now that we already used evsel->core.attr to ask the kernel to setup the
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 7e05b8b5cc95..131b62271bfa 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -7,6 +7,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include "thread_map.h"
 #include "evsel.h"
 #include "debug.h"
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index e413c1387fcb..74308c1368fe 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -11,6 +11,7 @@
 #include "util/synthetic-events.h"
 #include <linux/zalloc.h>
 #include <perf/event.h>
+#include <internal/threadmap.h>
 
 struct perf_sample;
 struct perf_tool;
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ef1c15e4aeba..eeee899fcf34 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -561,7 +561,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 
 		if (filter_type == BPERF_FILTER_PID ||
 		    filter_type == BPERF_FILTER_TGID)
-			key = evsel->core.threads->map[i].pid;
+			key = perf_thread_map__pid(evsel->core.threads, i);
 		else if (filter_type == BPERF_FILTER_CPU)
 			key = evsel->core.cpus->map[i].cpu;
 		else
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2139e8b0e401..2e212ae73b9f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -53,6 +53,7 @@
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
+#include <internal/threadmap.h>
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5be5fa2391de..b5941c74a0d6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -718,17 +718,17 @@ static Py_ssize_t pyrf_thread_map__length(PyObject *obj)
 {
 	struct pyrf_thread_map *pthreads = (void *)obj;
 
-	return pthreads->threads->nr;
+	return perf_thread_map__nr(pthreads->threads);
 }
 
 static PyObject *pyrf_thread_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_thread_map *pthreads = (void *)obj;
 
-	if (i >= pthreads->threads->nr)
+	if (i >= perf_thread_map__nr(pthreads->threads))
 		return NULL;
 
-	return Py_BuildValue("i", pthreads->threads->map[i]);
+	return Py_BuildValue("i", perf_thread_map__pid(pthreads->threads, i));
 }
 
 static PySequenceMethods pyrf_thread_map__sequence_methods = {
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 1985d1a42a22..1cf65db8f861 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1654,7 +1654,7 @@ static void python_process_stat(struct perf_stat_config *config,
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
-	for (thread = 0; thread < threads->nr; thread++) {
+	for (thread = 0; thread < perf_thread_map__nr(threads); thread++) {
 		for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 			process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
 				     perf_thread_map__pid(threads, thread), tstamp,
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943..e848579e61a8 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -18,6 +18,7 @@
 #include "thread_map.h"
 #include "debug.h"
 #include "event.h"
+#include <internal/threadmap.h>
 
 /* Skip "." and ".." directories */
 static int filter(const struct dirent *dir)
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 3bb860a32b8e..00ec05fc1656 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -4,8 +4,6 @@
 
 #include <sys/types.h>
 #include <stdio.h>
-#include <linux/refcount.h>
-#include <internal/threadmap.h>
 #include <perf/threadmap.h>
 
 struct perf_record_thread_map;
-- 
2.38.1.431.g37b22c650d-goog

