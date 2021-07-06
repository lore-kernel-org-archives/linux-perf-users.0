Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0CC07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046D461C30
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 13:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGFNXc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbhGFNXb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625577652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtJX128tv+UNtyzf1HLYJY3jxB5LgvqObhQjAuBIOkU=;
        b=C0mA2lsL15P+VB/U7VxRnnnrQ6QBEEjIB30ZwWaivy+xv5y2+NY68qVfRyPZ4nosFDZtE6
        0qJkzTDik8XJNsuV+9KB+6dJIVtbnByuHjmDxD7/ZZdQ3IU5r2UPWzTUNjVppLfhiVX7wV
        n8bsBbegeTkmk7WSBlhRnaYC50sF+fI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-SpdeydndMrGaoCxQhzbObQ-1; Tue, 06 Jul 2021 09:20:51 -0400
X-MC-Unique: SpdeydndMrGaoCxQhzbObQ-1
Received: by mail-wm1-f70.google.com with SMTP id 13-20020a1c010d0000b02901eca51685daso1098664wmb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 06:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtJX128tv+UNtyzf1HLYJY3jxB5LgvqObhQjAuBIOkU=;
        b=Vjrx6uhLhCDqazSarXb/Jd8dM9xjF5fFqUyHwYO97e7OahsW2HyfIivK36aPEWMxmf
         erxeCgsimK1sO4F1vhSu8bWq+Xn0cjeVZdfwcRvKFSc14RRQvO2TeWW6THQ7PbXt1PTB
         ePgfmkfg8PdotGZp384bMjkVccu28IjzmYYHaB+umNu6Lp3cZHMWhkaI0iq8XyC7drWQ
         1K3zqPOh/zmc/PflH2qccDYIwtvH4Blrik2bisDJ0oRi9upAYCkB/glP6t/bG/0QAUPL
         FSkzXitxeJni8+qJg5/JUtkcbqXqZH6iZvRhfoCp9G0O0Tj6ZShjWr7tS6LJfNcsooTg
         /8tw==
X-Gm-Message-State: AOAM5301k994rvyyzSE6p8ZLUMJRAd0YCA/8ud47TW4QUR1SepUIoMp5
        ufMliEQzdni8OxR42Mpyq8YhXcuZHzIPV1QaaPCSkZUW6r1sNmUlfgk0aAUHKnW0EvLjoY1HT77
        AsXi86ItTOibNRGwfdBuVysvrh8A3Hg==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr675547wmq.135.1625577650219;
        Tue, 06 Jul 2021 06:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyImga9cAVnlM75/yPCPHh8g0C4NvxvA/LG4JAlzDlm/I0ZjmTVqx9CCjrGoDXKK+hUIn0i/A==
X-Received: by 2002:a05:600c:3541:: with SMTP id i1mr675517wmq.135.1625577650003;
        Tue, 06 Jul 2021 06:20:50 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id t11sm17119412wrz.7.2021.07.06.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 06:20:49 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/7] libperf: Change tests to single static and shared binaries
Date:   Tue,  6 Jul 2021 15:20:37 +0200
Message-Id: <20210706132043.70195-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706132043.70195-1-jolsa@kernel.org>
References: <20210706132043.70195-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make tests to be two binaries 'tests_static' and 'tests_shared',
so the maintenance is easier.

Adding tests under libperf build system, so we define all the
flags just once.

Adding make-tests tule to just compile tests without running them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build                    |  2 ++
 tools/lib/perf/Makefile                 | 30 +++++++++++++++----
 tools/lib/perf/include/internal/tests.h |  4 +--
 tools/lib/perf/tests/Build              |  5 ++++
 tools/lib/perf/tests/Makefile           | 40 -------------------------
 tools/lib/perf/tests/main.c             | 15 ++++++++++
 tools/lib/perf/tests/test-cpumap.c      |  3 +-
 tools/lib/perf/tests/test-evlist.c      |  3 +-
 tools/lib/perf/tests/test-evsel.c       |  3 +-
 tools/lib/perf/tests/test-threadmap.c   |  3 +-
 tools/lib/perf/tests/tests.h            | 10 +++++++
 11 files changed, 67 insertions(+), 51 deletions(-)
 create mode 100644 tools/lib/perf/tests/Build
 delete mode 100644 tools/lib/perf/tests/Makefile
 create mode 100644 tools/lib/perf/tests/main.c
 create mode 100644 tools/lib/perf/tests/tests.h

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index 2ef9a4ec6d99..e8f5b7fb9973 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -11,3 +11,5 @@ libperf-y += lib.o
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+tests-y += tests/
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3718d65cffac..08fe6e3c4089 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -52,6 +52,8 @@ else
   Q = @
 endif
 
+TEST_ARGS := $(if $(V),-v)
+
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
@@ -136,12 +138,30 @@ all: fixdep
 
 clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
-	$(Q)$(MAKE) -C tests clean
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
+                $(TESTS_STATIC) $(TESTS_SHARED)
+
+TESTS_IN = tests-in.o
+
+TESTS_STATIC = $(OUTPUT)tests-static
+TESTS_SHARED = $(OUTPUT)tests-shared
+
+$(TESTS_IN): FORCE
+	$(Q)$(MAKE) $(build)=tests
+
+$(TESTS_STATIC): $(TESTS_IN) $(LIBPERF_A) $(LIBAPI)
+	$(QUIET_LINK)$(CC) -o $@ $^
+
+$(TESTS_SHARED): $(TESTS_IN) $(LIBAPI)
+	$(QUIET_LINK)$(CC) -o $@ -L$(if $(OUTPUT),$(OUTPUT),.) $^ -lperf
+
+make-tests: libs $(TESTS_SHARED) $(TESTS_STATIC)
 
-tests: libs
-	$(Q)$(MAKE) -C tests
-	$(Q)$(MAKE) -C tests run
+tests: make-tests
+	@echo "running static:"
+	@./$(TESTS_STATIC) $(TEST_ARGS)
+	@echo "running dynamic:"
+	@LD_LIBRARY_PATH=. ./$(TESTS_SHARED) $(TEST_ARGS)
 
 $(LIBPERF_PC):
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
index 29425c2dabe1..61052099225b 100644
--- a/tools/lib/perf/include/internal/tests.h
+++ b/tools/lib/perf/include/internal/tests.h
@@ -5,8 +5,8 @@
 #include <stdio.h>
 #include <unistd.h>
 
-int tests_failed;
-int tests_verbose;
+extern int tests_failed;
+extern int tests_verbose;
 
 static inline int get_verbose(char **argv, int argc)
 {
diff --git a/tools/lib/perf/tests/Build b/tools/lib/perf/tests/Build
new file mode 100644
index 000000000000..56e81378d443
--- /dev/null
+++ b/tools/lib/perf/tests/Build
@@ -0,0 +1,5 @@
+tests-y += main.o
+tests-y += test-evsel.o
+tests-y += test-evlist.o
+tests-y += test-cpumap.o
+tests-y += test-threadmap.o
diff --git a/tools/lib/perf/tests/Makefile b/tools/lib/perf/tests/Makefile
deleted file mode 100644
index b536cc9a26dd..000000000000
--- a/tools/lib/perf/tests/Makefile
+++ /dev/null
@@ -1,40 +0,0 @@
-# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-TESTS = test-cpumap test-threadmap test-evlist test-evsel
-
-TESTS_SO := $(addsuffix -so,$(TESTS))
-TESTS_A  := $(addsuffix -a,$(TESTS))
-
-TEST_ARGS := $(if $(V),-v)
-
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -Wall
-endif
-
-all:
-
-include $(srctree)/tools/scripts/Makefile.include
-
-INCLUDE = -I$(srctree)/tools/lib/perf/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
-
-$(TESTS_A): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
-
-$(TESTS_SO): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) $(LIBAPI) -lperf
-
-all: $(TESTS_A) $(TESTS_SO)
-
-run:
-	@echo "running static:"
-	@for i in $(TESTS_A); do ./$$i $(TEST_ARGS); done
-	@echo "running dynamic:"
-	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i $(TEST_ARGS); done
-
-clean:
-	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
-
-.PHONY: all clean FORCE
diff --git a/tools/lib/perf/tests/main.c b/tools/lib/perf/tests/main.c
new file mode 100644
index 000000000000..56423fd4db19
--- /dev/null
+++ b/tools/lib/perf/tests/main.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <internal/tests.h>
+#include "tests.h"
+
+int tests_failed;
+int tests_verbose;
+
+int main(int argc, char **argv)
+{
+	__T("test cpumap", !test_cpumap(argc, argv));
+	__T("test threadmap", !test_threadmap(argc, argv));
+	__T("test evlist", !test_evlist(argc, argv));
+	__T("test evsel", !test_evsel(argc, argv));
+	return 0;
+}
diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
index c70e9e03af3e..d39378eaf897 100644
--- a/tools/lib/perf/tests/test-cpumap.c
+++ b/tools/lib/perf/tests/test-cpumap.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <perf/cpumap.h>
 #include <internal/tests.h>
+#include "tests.h"
 
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
@@ -10,7 +11,7 @@ static int libperf_print(enum libperf_print_level level,
 	return vfprintf(stderr, fmt, ap);
 }
 
-int main(int argc, char **argv)
+int test_cpumap(int argc, char **argv)
 {
 	struct perf_cpu_map *cpus;
 
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index e2ac0b7f432e..7435529fb21c 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -18,6 +18,7 @@
 #include <perf/event.h>
 #include <internal/tests.h>
 #include <api/fs/fs.h>
+#include "tests.h"
 
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
@@ -397,7 +398,7 @@ static int test_mmap_cpus(void)
 	return 0;
 }
 
-int main(int argc, char **argv)
+int test_evlist(int argc, char **argv)
 {
 	__T_START;
 
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 288b5feaefe2..a184e4861627 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -6,6 +6,7 @@
 #include <perf/threadmap.h>
 #include <perf/evsel.h>
 #include <internal/tests.h>
+#include "tests.h"
 
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
@@ -184,7 +185,7 @@ static int test_stat_user_read(int event)
 	return 0;
 }
 
-int main(int argc, char **argv)
+int test_evsel(int argc, char **argv)
 {
 	__T_START;
 
diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
index 384471441b48..5e2a0291e94c 100644
--- a/tools/lib/perf/tests/test-threadmap.c
+++ b/tools/lib/perf/tests/test-threadmap.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <perf/threadmap.h>
 #include <internal/tests.h>
+#include "tests.h"
 
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
@@ -10,7 +11,7 @@ static int libperf_print(enum libperf_print_level level,
 	return vfprintf(stderr, fmt, ap);
 }
 
-int main(int argc, char **argv)
+int test_threadmap(int argc, char **argv)
 {
 	struct perf_thread_map *threads;
 
diff --git a/tools/lib/perf/tests/tests.h b/tools/lib/perf/tests/tests.h
new file mode 100644
index 000000000000..604838f21b2b
--- /dev/null
+++ b/tools/lib/perf/tests/tests.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TESTS_H
+#define TESTS_H
+
+int test_cpumap(int argc, char **argv);
+int test_threadmap(int argc, char **argv);
+int test_evlist(int argc, char **argv);
+int test_evsel(int argc, char **argv);
+
+#endif /* TESTS_H */
-- 
2.31.1

