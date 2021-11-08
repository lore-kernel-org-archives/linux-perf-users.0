Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16151C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E4B61244
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhKHNp6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237322AbhKHNp6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PDDNCRmEiDn8uerPysJFgJA98+Y+CmkwBTTlca1IOQ=;
        b=MlyssLMia+ZlZw5tMBFn+P7ZbgxTqkn0MHNzIjDtfBIG58N39UMkCivEKlt3iI/aLSdcrC
        HACNlrUerrH+SWy+08hOAd7wR/C83MRBknoj9GSh66Gqiwd9R05CGi+PvKELSFg+g6nW6T
        dJNX+nxDDz/+YpLhrsVM4NL1cKciEbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-bwz-yMQnMC6B53FFvsroyw-1; Mon, 08 Nov 2021 08:43:12 -0500
X-MC-Unique: bwz-yMQnMC6B53FFvsroyw-1
Received: by mail-wm1-f72.google.com with SMTP id y9-20020a1c7d09000000b003316e18949bso6232707wmc.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PDDNCRmEiDn8uerPysJFgJA98+Y+CmkwBTTlca1IOQ=;
        b=2L4oHI0o9T+l2Qke/vVG5TcT7HqTyjlMm8byaIFY+p3WZVEDtnz2JYww80VOKxQPMt
         ValJeihxcwZK3XTwFtjsyIjKRli0zYjw32Y9iAM7hbZ/ThwguW77fVglgF9gi8ModZTS
         nf3XiJbSrF+rQoZnVdAnH6rY3zsFpv/tNR26M0/NYtCmQt0wbTPbCU0JIlKeQ6zWu9Es
         NVycg5KmREzHAmBrDYjCTkx5D1AkhdTZrUXvx+sUpmpNdUY2IK45w5JSjn/nYF2xK/bX
         q2z9gHWXoOQ3raAVa/B4n6M3klzQAxM/Ez0YByFlcvdQSs+lpXXRaJjYjdhrV5Rg9PMB
         Hs4g==
X-Gm-Message-State: AOAM530kR3Jvpx5R1gVz47TunayummuHj7UojBCntybgv78WOtiWTuv7
        +ug2Kp6Afe0G5vqQJfXItxBtOi5YAApXJIKqJpDCIVe/fzJAcGLr46SqcVfbQumhCNeRvZVRapz
        8ut/E8t8op32qKR5gUXXPesR8/vUVYQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr71349018wrt.126.1636378991145;
        Mon, 08 Nov 2021 05:43:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWjclft1tGbe+kioihP/DHH2QX4RWNsnPSUG9p2nQWiv7I98vFAwuZUUWn+ujYgjhPq76VoQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr71348997wrt.126.1636378990995;
        Mon, 08 Nov 2021 05:43:10 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 6sm16398670wma.48.2021.11.08.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:43:10 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 59/59] libperf: Add parse-events test
Date:   Mon,  8 Nov 2021 14:37:10 +0100
Message-Id: <20211108133710.1352822-60-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding parse-events test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/tests/Build               |  1 +
 tools/lib/perf/tests/main.c              |  1 +
 tools/lib/perf/tests/test-evlist.c       |  2 ++
 tools/lib/perf/tests/test-parse-events.c | 41 ++++++++++++++++++++++++
 tools/lib/perf/tests/tests.h             |  1 +
 5 files changed, 46 insertions(+)
 create mode 100644 tools/lib/perf/tests/test-parse-events.c

diff --git a/tools/lib/perf/tests/Build b/tools/lib/perf/tests/Build
index 56e81378d443..f1d1133d8dae 100644
--- a/tools/lib/perf/tests/Build
+++ b/tools/lib/perf/tests/Build
@@ -3,3 +3,4 @@ tests-y += test-evsel.o
 tests-y += test-evlist.o
 tests-y += test-cpumap.o
 tests-y += test-threadmap.o
+tests-y += test-parse-events.o
diff --git a/tools/lib/perf/tests/main.c b/tools/lib/perf/tests/main.c
index 56423fd4db19..bfa8ba05c422 100644
--- a/tools/lib/perf/tests/main.c
+++ b/tools/lib/perf/tests/main.c
@@ -7,6 +7,7 @@ int tests_verbose;
 
 int main(int argc, char **argv)
 {
+	__T("test parse_events", !test_parse_events(argc, argv));
 	__T("test cpumap", !test_cpumap(argc, argv));
 	__T("test threadmap", !test_threadmap(argc, argv));
 	__T("test evlist", !test_evlist(argc, argv));
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index ce91a582f0e4..199451a605a1 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
+#endif
 #include <sched.h>
 #include <stdio.h>
 #include <stdarg.h>
diff --git a/tools/lib/perf/tests/test-parse-events.c b/tools/lib/perf/tests/test-parse-events.c
new file mode 100644
index 000000000000..5f913f82de7f
--- /dev/null
+++ b/tools/lib/perf/tests/test-parse-events.c
@@ -0,0 +1,41 @@
+#include <stdio.h>
+#include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <internal/evlist.h>
+#include <internal/tests.h>
+#include "tests.h"
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+int test_parse_events(int argc, char **argv)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	int err;
+
+	__T_START;
+
+	libperf_init(libperf_print);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	err = libperf_parse_events(evlist, "mem:0:rw");
+	__T("failed to parse events", !err);
+
+	evsel = perf_evlist__first(evlist);
+
+	__T("wrong type", PERF_TYPE_BREAKPOINT == evsel->attr.type);
+	__T("wrong config", 0 == evsel->attr.config);
+	__T("wrong bp_type", (HW_BREAKPOINT_R|HW_BREAKPOINT_W) == evsel->attr.bp_type);
+	__T("wrong bp_len", HW_BREAKPOINT_LEN_4 == evsel->attr.bp_len);
+
+	__T_END;
+	return tests_failed == 0 ? 0 : -1;
+}
diff --git a/tools/lib/perf/tests/tests.h b/tools/lib/perf/tests/tests.h
index 604838f21b2b..b4f27fc9c46d 100644
--- a/tools/lib/perf/tests/tests.h
+++ b/tools/lib/perf/tests/tests.h
@@ -6,5 +6,6 @@ int test_cpumap(int argc, char **argv);
 int test_threadmap(int argc, char **argv);
 int test_evlist(int argc, char **argv);
 int test_evsel(int argc, char **argv);
+int test_parse_events(int argc, char **argv);
 
 #endif /* TESTS_H */
-- 
2.31.1

