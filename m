Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B498613A6
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhKHNkg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239997AbhKHNkd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhwyqHCMBPcxZ48OiFWHCCWpLV1ENk31Vp2O50HIlaQ=;
        b=dpfJMRkT/QN+arRjHp/GRYWKovwSYspqUfJJYa+4KCBPHvybZyDXMM0tKFtWYyJO08h/0Y
        w7cG4e8sEHrjZSBbZRfc+buywJshCTQthKSFBgqmFnNee3S2YXKrGYM8bnGC/IbG+34wHc
        +7F/t5z5FIBwawOTKWKvme2xhkHO2nE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-5QkEv76jMp68b6-l4XDz2Q-1; Mon, 08 Nov 2021 08:37:47 -0500
X-MC-Unique: 5QkEv76jMp68b6-l4XDz2Q-1
Received: by mail-wm1-f72.google.com with SMTP id y9-20020a1c7d09000000b003316e18949bso6226401wmc.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhwyqHCMBPcxZ48OiFWHCCWpLV1ENk31Vp2O50HIlaQ=;
        b=oyykZNkqR0AMgueiW68FfUNFAURGTgrq8cJZFwqfTWn32e24QAumi6d3iv1Vas1oYi
         68hrI60qHguQKaAqb6UJPb4755hPYAZ4a5RIzhpZEJwVZj4pTehgCP3G9IrmepsnR+u3
         JsAEnpNyMT9HnfPVDCdi+ANT2l/u8YbRyR7/M353im2c5Bw3yFaWtNp2ngkkQdKZyG3I
         2dCCvwNdTidpRtoI+rrUSTLCACaadXD86yLTxrT90eQjj7mASX+EWiIhygwadVXLfX6T
         EXi/23KYEhAGAgd9vOh8MCOuH2LiowmnMTFJ8U9KwJERYktIaOgOPlkfDUm2Q+ifGoXu
         yAFA==
X-Gm-Message-State: AOAM530S2NCBRECZpajoaxGv+r9Eqi+UXXTi5avn+AuODj7wUNgO/6LD
        dikbIcRiAueYrLygyXbj9W8v53Gl8DZdSiBfqoimxP2hGXQvSEMNNUdDLqaLtmzPghz+XqCdWip
        ZMp97/cmubEkh1aR0NzdupPD8EcpskA==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr36819744wrd.114.1636378666211;
        Mon, 08 Nov 2021 05:37:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiW/Jw12PvaWJt2oUzSw97rJn5suwTnRHMuNQ4uoKaTZy5wkbRHt8Gs3PSRkeUq5p9EStJ7A==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr36819724wrd.114.1636378666000;
        Mon, 08 Nov 2021 05:37:46 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g18sm17704192wmq.4.2021.11.08.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:37:45 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 04/59] libperf: Move perf_pmu__format_parse to libperf
Date:   Mon,  8 Nov 2021 14:36:15 +0100
Message-Id: <20211108133710.1352822-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move perf_pmu__format_parse function into new
pmu.c object under libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build                  | 30 +++++++++
 tools/lib/perf/Makefile               |  8 ++-
 tools/lib/perf/include/internal/pmu.h | 29 +++++++++
 tools/lib/perf/pmu.c                  | 83 ++++++++++++++++++++++++
 tools/lib/perf/pmu.l                  | 44 +++++++++++++
 tools/lib/perf/pmu.y                  | 92 +++++++++++++++++++++++++++
 tools/perf/util/Build                 | 15 -----
 tools/perf/util/pmu.c                 | 77 ----------------------
 tools/perf/util/pmu.h                 | 12 +---
 tools/perf/util/pmu.l                 | 43 -------------
 tools/perf/util/pmu.y                 | 92 ---------------------------
 11 files changed, 286 insertions(+), 239 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/pmu.h
 create mode 100644 tools/lib/perf/pmu.c
 create mode 100644 tools/lib/perf/pmu.l
 create mode 100644 tools/lib/perf/pmu.y
 delete mode 100644 tools/perf/util/pmu.l
 delete mode 100644 tools/perf/util/pmu.y

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index e8f5b7fb9973..275ec24cad7b 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -7,9 +7,39 @@ libperf-y += mmap.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
 libperf-y += lib.o
+libperf-y += pmu-flex.o
+libperf-y += pmu-bison.o
+libperf-y += pmu.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
 tests-y += tests/
+
+
+$(OUTPUT)pmu-flex.c $(OUTPUT)pmu-flex.h: pmu.l $(OUTPUT)pmu-bison.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)pmu-flex.c \
+                --header-file=$(OUTPUT)pmu-flex.h $(PARSER_DEBUG_FLEX) $<
+
+$(OUTPUT)pmu-bison.c $(OUTPUT)pmu-bison.h: pmu.y
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
+                -o $(OUTPUT)pmu-bison.c -p perf_pmu_
+
+FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
+ifeq ($(FLEX_GE_26),1)
+  flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-declarations
+  CC_HASNT_MISLEADING_INDENTATION := $(shell echo "int main(void) { return 0 }" | $(CC) -Werror -Wno-misleading-indentation -o /dev/null -xc - 2>&1 | grep -q -- -Wno-misleading-indentation ; echo $$?)
+  ifeq ($(CC_HASNT_MISLEADING_INDENTATION), 1)
+    flex_flags += -Wno-misleading-indentation
+  endif
+else
+  flex_flags := -w
+endif
+
+CFLAGS_pmu-flex.o  += $(flex_flags)
+CFLAGS_pmu-bison.o += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
+
+$(OUTPUT)pmu.o: $(OUTPUT)pmu-flex.c $(OUTPUT)pmu-bison.c
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index a7a919fb9e62..bb6f53c215ad 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -22,6 +22,11 @@ endif
 
 INSTALL = install
 
+FLEX    ?= flex
+BISON   ?= bison
+
+export FLEX BISON
+
 # Use DESTDIR for installing into a different root directory.
 # This is useful for building a package. The program will be
 # installed in this directory as if it was the root directory.
@@ -164,7 +169,8 @@ clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
                 $(TESTS_STATIC) $(TESTS_SHARED) \
-                $(OUTPUT)pmu-events/pmu-events.c $(OUTPUT)pmu-events/jevents
+                $(OUTPUT)pmu-events/pmu-events.c $(OUTPUT)pmu-events/jevents \
+                $(OUTPUT)*-bison* $(OUTPUT)*-flex*
 
 TESTS_IN = tests-in.o
 
diff --git a/tools/lib/perf/include/internal/pmu.h b/tools/lib/perf/include/internal/pmu.h
new file mode 100644
index 000000000000..2c742acd933c
--- /dev/null
+++ b/tools/lib/perf/include/internal/pmu.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_PMU_H
+#define __LIBPERF_INTERNAL_PMU_H
+
+#include <linux/list.h>
+#include <linux/bitmap.h>
+
+enum {
+	PERF_PMU_FORMAT_VALUE_CONFIG,
+	PERF_PMU_FORMAT_VALUE_CONFIG1,
+	PERF_PMU_FORMAT_VALUE_CONFIG2,
+};
+
+#define PERF_PMU_FORMAT_BITS 64
+
+struct perf_pmu_format {
+	char *name;
+	int value;
+	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+	struct list_head list;
+};
+
+int perf_pmu__new_format(struct list_head *list, char *name,
+			 int config, unsigned long *bits);
+void perf_pmu__set_format(unsigned long *bits, long from, long to);
+void perf_pmu_error(struct list_head *list, char *name, char const *msg);
+int perf_pmu__format_parse(char *dir, struct list_head *head);
+
+#endif /* __LIBPERF_INTERNAL_PMU_H */
diff --git a/tools/lib/perf/pmu.c b/tools/lib/perf/pmu.c
new file mode 100644
index 000000000000..2fa361516ca8
--- /dev/null
+++ b/tools/lib/perf/pmu.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/list.h>
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <internal/pmu.h>
+
+extern FILE *perf_pmu_in;
+
+int perf_pmu_parse(struct list_head *list, char *name);
+
+int perf_pmu__new_format(struct list_head *list, char *name,
+			 int config, unsigned long *bits)
+{
+	struct perf_pmu_format *format;
+
+	format = zalloc(sizeof(*format));
+	if (!format)
+		return -ENOMEM;
+
+	format->name = strdup(name);
+	format->value = config;
+	memcpy(format->bits, bits, sizeof(format->bits));
+
+	list_add_tail(&format->list, list);
+	return 0;
+}
+
+void perf_pmu__set_format(unsigned long *bits, long from, long to)
+{
+	long b;
+
+	if (!to)
+		to = from;
+
+	memset(bits, 0, BITS_TO_BYTES(PERF_PMU_FORMAT_BITS));
+	for (b = from; b <= to; b++)
+		set_bit(b, bits);
+}
+
+/*
+ * Parse & process all the sysfs attributes located under
+ * the directory specified in 'dir' parameter.
+ */
+int perf_pmu__format_parse(char *dir, struct list_head *head)
+{
+	struct dirent *evt_ent;
+	DIR *format_dir;
+	int ret = 0;
+
+	format_dir = opendir(dir);
+	if (!format_dir)
+		return -EINVAL;
+
+	while (!ret && (evt_ent = readdir(format_dir))) {
+		char path[PATH_MAX];
+		char *name = evt_ent->d_name;
+		FILE *file;
+
+		if (!strcmp(name, ".") || !strcmp(name, ".."))
+			continue;
+
+		snprintf(path, PATH_MAX, "%s/%s", dir, name);
+
+		ret = -EINVAL;
+		file = fopen(path, "r");
+		if (!file)
+			break;
+
+		perf_pmu_in = file;
+		ret = perf_pmu_parse(head, name);
+		fclose(file);
+	}
+
+	closedir(format_dir);
+	return ret;
+}
diff --git a/tools/lib/perf/pmu.l b/tools/lib/perf/pmu.l
new file mode 100644
index 000000000000..372cd75ea70b
--- /dev/null
+++ b/tools/lib/perf/pmu.l
@@ -0,0 +1,44 @@
+%option prefix="perf_pmu_"
+
+%{
+#include <stdlib.h>
+#include <linux/bitops.h>
+#include <linux/bitmap.h>
+#include <internal/pmu.h>
+#include "pmu-bison.h"
+
+static int value(int base)
+{
+	long num;
+
+	errno = 0;
+	num = strtoul(perf_pmu_text, NULL, base);
+	if (errno)
+		return PP_ERROR;
+
+	perf_pmu_lval.num = num;
+	return PP_VALUE;
+}
+
+%}
+
+num_dec         [0-9]+
+
+%%
+
+{num_dec}	{ return value(10); }
+config		{ return PP_CONFIG; }
+config1		{ return PP_CONFIG1; }
+config2		{ return PP_CONFIG2; }
+-		{ return '-'; }
+:		{ return ':'; }
+,		{ return ','; }
+.		{ ; }
+\n		{ ; }
+
+%%
+
+int perf_pmu_wrap(void)
+{
+	return 1;
+}
diff --git a/tools/lib/perf/pmu.y b/tools/lib/perf/pmu.y
new file mode 100644
index 000000000000..715201e3b06f
--- /dev/null
+++ b/tools/lib/perf/pmu.y
@@ -0,0 +1,92 @@
+
+%parse-param {struct list_head *format}
+%parse-param {char *name}
+
+%{
+
+#include <linux/compiler.h>
+#include <linux/list.h>
+#include <linux/bitmap.h>
+#include <string.h>
+#include <internal/pmu.h>
+
+extern int perf_pmu_lex (void);
+
+#define ABORT_ON(val) \
+do { \
+        if (val) \
+                YYABORT; \
+} while (0)
+
+%}
+
+%token PP_CONFIG PP_CONFIG1 PP_CONFIG2
+%token PP_VALUE PP_ERROR
+%type <num> PP_VALUE
+%type <bits> bit_term
+%type <bits> bits
+
+%union
+{
+	unsigned long num;
+	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+}
+
+%%
+
+format:
+format format_term
+|
+format_term
+
+format_term:
+PP_CONFIG ':' bits
+{
+	ABORT_ON(perf_pmu__new_format(format, name,
+				      PERF_PMU_FORMAT_VALUE_CONFIG,
+				      $3));
+}
+|
+PP_CONFIG1 ':' bits
+{
+	ABORT_ON(perf_pmu__new_format(format, name,
+				      PERF_PMU_FORMAT_VALUE_CONFIG1,
+				      $3));
+}
+|
+PP_CONFIG2 ':' bits
+{
+	ABORT_ON(perf_pmu__new_format(format, name,
+				      PERF_PMU_FORMAT_VALUE_CONFIG2,
+				      $3));
+}
+
+bits:
+bits ',' bit_term
+{
+	bitmap_or($$, $1, $3, 64);
+}
+|
+bit_term
+{
+	memcpy($$, $1, sizeof($1));
+}
+
+bit_term:
+PP_VALUE '-' PP_VALUE
+{
+	perf_pmu__set_format($$, $1, $3);
+}
+|
+PP_VALUE
+{
+	perf_pmu__set_format($$, $1, 0);
+}
+
+%%
+
+void perf_pmu_error(struct list_head *list __maybe_unused,
+		    char *name __maybe_unused,
+		    char const *msg __maybe_unused)
+{
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 15b2366ad384..03d5d6ed7fe4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -70,8 +70,6 @@ perf-y += trace-event-parse.o
 perf-y += parse-events-flex.o
 perf-y += parse-events-bison.o
 perf-y += pmu.o
-perf-y += pmu-flex.o
-perf-y += pmu-bison.o
 perf-y += pmu-hybrid.o
 perf-y += trace-event-read.o
 perf-y += trace-event-info.o
@@ -233,16 +231,6 @@ $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/expr-bison.c -p expr_
 
-$(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/pmu-flex.c \
-		--header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
-
-$(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
-		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
-
 FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
 ifeq ($(FLEX_GE_26),1)
   flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-declarations
@@ -254,7 +242,6 @@ else
   flex_flags := -w
 endif
 CFLAGS_parse-events-flex.o  += $(flex_flags)
-CFLAGS_pmu-flex.o           += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
 
 bison_flags := -DYYENABLE_NLS=0
@@ -265,11 +252,9 @@ else
   bison_flags += -w
 endif
 CFLAGS_parse-events-bison.o += $(bison_flags)
-CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
-$(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
 $(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
 
 CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f3072c71d132..55d834160428 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -31,57 +31,9 @@
 
 struct perf_pmu perf_pmu__fake;
 
-struct perf_pmu_format {
-	char *name;
-	int value;
-	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
-	struct list_head list;
-};
-
-int perf_pmu_parse(struct list_head *list, char *name);
-extern FILE *perf_pmu_in;
-
 static LIST_HEAD(pmus);
 static bool hybrid_scanned;
 
-/*
- * Parse & process all the sysfs attributes located under
- * the directory specified in 'dir' parameter.
- */
-int perf_pmu__format_parse(char *dir, struct list_head *head)
-{
-	struct dirent *evt_ent;
-	DIR *format_dir;
-	int ret = 0;
-
-	format_dir = opendir(dir);
-	if (!format_dir)
-		return -EINVAL;
-
-	while (!ret && (evt_ent = readdir(format_dir))) {
-		char path[PATH_MAX];
-		char *name = evt_ent->d_name;
-		FILE *file;
-
-		if (!strcmp(name, ".") || !strcmp(name, ".."))
-			continue;
-
-		snprintf(path, PATH_MAX, "%s/%s", dir, name);
-
-		ret = -EINVAL;
-		file = fopen(path, "r");
-		if (!file)
-			break;
-
-		perf_pmu_in = file;
-		ret = perf_pmu_parse(head, name);
-		fclose(file);
-	}
-
-	closedir(format_dir);
-	return ret;
-}
-
 /*
  * Reading/parsing the default pmu format definition, which should be
  * located at:
@@ -1513,35 +1465,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 	return 0;
 }
 
-int perf_pmu__new_format(struct list_head *list, char *name,
-			 int config, unsigned long *bits)
-{
-	struct perf_pmu_format *format;
-
-	format = zalloc(sizeof(*format));
-	if (!format)
-		return -ENOMEM;
-
-	format->name = strdup(name);
-	format->value = config;
-	memcpy(format->bits, bits, sizeof(format->bits));
-
-	list_add_tail(&format->list, list);
-	return 0;
-}
-
-void perf_pmu__set_format(unsigned long *bits, long from, long to)
-{
-	long b;
-
-	if (!to)
-		to = from;
-
-	memset(bits, 0, BITS_TO_BYTES(PERF_PMU_FORMAT_BITS));
-	for (b = from; b <= to; b++)
-		set_bit(b, bits);
-}
-
 void perf_pmu__del_formats(struct list_head *formats)
 {
 	struct perf_pmu_format *fmt, *tmp;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 31a52ee963c8..3127c877e043 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -9,16 +9,11 @@
 #include <stdbool.h>
 #include "parse-events.h"
 #include <perf/pmu-events.h>
+#include <internal/pmu.h>
 
 struct evsel_config_term;
 struct perf_cpu_map;
 
-enum {
-	PERF_PMU_FORMAT_VALUE_CONFIG,
-	PERF_PMU_FORMAT_VALUE_CONFIG1,
-	PERF_PMU_FORMAT_VALUE_CONFIG2,
-};
-
 #define PERF_PMU_FORMAT_BITS 64
 #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
@@ -98,12 +93,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 				  struct list_head *head_terms);
-void perf_pmu_error(struct list_head *list, char *name, char const *msg);
 
-int perf_pmu__new_format(struct list_head *list, char *name,
-			 int config, unsigned long *bits);
-void perf_pmu__set_format(unsigned long *bits, long from, long to);
-int perf_pmu__format_parse(char *dir, struct list_head *head);
 void perf_pmu__del_formats(struct list_head *formats);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
deleted file mode 100644
index a15d9fbd7c0e..000000000000
--- a/tools/perf/util/pmu.l
+++ /dev/null
@@ -1,43 +0,0 @@
-%option prefix="perf_pmu_"
-
-%{
-#include <stdlib.h>
-#include <linux/bitops.h>
-#include "pmu.h"
-#include "pmu-bison.h"
-
-static int value(int base)
-{
-	long num;
-
-	errno = 0;
-	num = strtoul(perf_pmu_text, NULL, base);
-	if (errno)
-		return PP_ERROR;
-
-	perf_pmu_lval.num = num;
-	return PP_VALUE;
-}
-
-%}
-
-num_dec         [0-9]+
-
-%%
-
-{num_dec}	{ return value(10); }
-config		{ return PP_CONFIG; }
-config1		{ return PP_CONFIG1; }
-config2		{ return PP_CONFIG2; }
--		{ return '-'; }
-:		{ return ':'; }
-,		{ return ','; }
-.		{ ; }
-\n		{ ; }
-
-%%
-
-int perf_pmu_wrap(void)
-{
-	return 1;
-}
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
deleted file mode 100644
index bfd7e8509869..000000000000
--- a/tools/perf/util/pmu.y
+++ /dev/null
@@ -1,92 +0,0 @@
-
-%parse-param {struct list_head *format}
-%parse-param {char *name}
-
-%{
-
-#include <linux/compiler.h>
-#include <linux/list.h>
-#include <linux/bitmap.h>
-#include <string.h>
-#include "pmu.h"
-
-extern int perf_pmu_lex (void);
-
-#define ABORT_ON(val) \
-do { \
-        if (val) \
-                YYABORT; \
-} while (0)
-
-%}
-
-%token PP_CONFIG PP_CONFIG1 PP_CONFIG2
-%token PP_VALUE PP_ERROR
-%type <num> PP_VALUE
-%type <bits> bit_term
-%type <bits> bits
-
-%union
-{
-	unsigned long num;
-	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
-}
-
-%%
-
-format:
-format format_term
-|
-format_term
-
-format_term:
-PP_CONFIG ':' bits
-{
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG,
-				      $3));
-}
-|
-PP_CONFIG1 ':' bits
-{
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG1,
-				      $3));
-}
-|
-PP_CONFIG2 ':' bits
-{
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG2,
-				      $3));
-}
-
-bits:
-bits ',' bit_term
-{
-	bitmap_or($$, $1, $3, 64);
-}
-|
-bit_term
-{
-	memcpy($$, $1, sizeof($1));
-}
-
-bit_term:
-PP_VALUE '-' PP_VALUE
-{
-	perf_pmu__set_format($$, $1, $3);
-}
-|
-PP_VALUE
-{
-	perf_pmu__set_format($$, $1, 0);
-}
-
-%%
-
-void perf_pmu_error(struct list_head *list __maybe_unused,
-		    char *name __maybe_unused,
-		    char const *msg __maybe_unused)
-{
-}
-- 
2.31.1

