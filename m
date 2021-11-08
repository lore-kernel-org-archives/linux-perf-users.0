Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796DC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9906115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhKHNps (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238651AbhKHNpq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyBDHxbNyW4Nzt9EycQQk9knBHog5c5AL/iWkAczMQc=;
        b=FdMm9421ywuHmR6s4+h8bR6XPHfFS9d5H6jntrLT+HRuEi2letAXYE5MOdZU8/yoCJx8T0
        yGLYkPvjFf+a3E8Ml84RYZZM1xR+FekJOmulsjufi5IkR8mTr7bjSrOB/ZAgbRK7b3e8av
        M6EgHM7MV0kOeoM3yIHujHY4zy9jAdk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-F6tJPQ_DMUCVNMEEmN6-8A-1; Mon, 08 Nov 2021 08:43:00 -0500
X-MC-Unique: F6tJPQ_DMUCVNMEEmN6-8A-1
Received: by mail-wm1-f70.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so6241331wmb.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyBDHxbNyW4Nzt9EycQQk9knBHog5c5AL/iWkAczMQc=;
        b=QYwRXbVQ0ah1dMJhxjPJ9HaoIHWV8XGP1HM95BZfwHlBnk0nBYKUxeuf5UmyqQAChR
         dAOsJJVkwdzWYHoaC1XEl8kcG/F6atQzkVv64/I+8BiAxaoqdnZsgY2tEgAq8n166r8O
         kHqwV01y9oL92/bZww3lKJFAqFyaC94vmSoJqL9dp+K//S1PjlxTpF7txvPVY17NvdZg
         G49VukqHBHzW3/K0JluKa/CpFJfU+a1cuJXBeO04XLdfudCSQhtcxbkpxdgBsxpHbvyi
         6NsIgM7Y1k0YNyXlkmQIcdT0sc5GtKP4p8YQ5NbPMdU2xHDBufkFm2K+psEOkyIgyazM
         44cQ==
X-Gm-Message-State: AOAM5327H4xqGIngyd+UCeXtTb/t4l0t/L/Ugp1ehafd/OlEkRTcrnbM
        i4zKL7PHRILfJWXcJche4SCkyk7Wr2HI3Iv5kGsu72lszJTXGoYHCJvJrot7preGw3t9d19QGb/
        tFS7uFKolVWfZdgIGAYk6eQO9sRDkoA==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr13868084wrz.159.1636378979388;
        Mon, 08 Nov 2021 05:42:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJys25uA8zBT9x8liuJgAK516zDbdMSARz/YqhltWG55idnDDJnA/5hjXxh4Xdk/zGyPBqAcpA==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr13868066wrz.159.1636378979253;
        Mon, 08 Nov 2021 05:42:59 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h7sm16300803wrt.64.2021.11.08.05.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:59 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 57/59] libperf: Move in some lib objects from perf
Date:   Mon,  8 Nov 2021 14:37:08 +0100
Message-Id: <20211108133710.1352822-58-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

New libperf code needs several libapi objects,
moving them from perf in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build  | 24 ++++++++++++++++++++++++
 tools/perf/util/Build | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index 3e29d173e0ec..06ea39ee84ac 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -14,11 +14,35 @@ libperf-y += pmu-hybrid.o
 libperf-y += parse-events.o
 libperf-y += parse-events-flex.o
 libperf-y += parse-events-bison.o
+libperf-y += bitmap.o
+libperf-y += find_bit.o
+libperf-y += vsprintf.o
+libperf-y += hweight.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)bitmap.o: ../../lib/bitmap.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)find_bit.o: ../../lib/find_bit.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)vsprintf.o: ../../lib/vsprintf.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)hweight.o: ../../lib/hweight.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
+CFLAGS_bitmap.o   += -Wno-unused-parameter
+CFLAGS_find_bit.o += -Wno-unused-parameter
+CFLAGS_hweight.o  += -Wno-unused-parameter
+
 tests-y += tests/
 
 $(OUTPUT)parse-events-flex.c $(OUTPUT)parse-events-flex.h: parse-events.l $(OUTPUT)parse-events-bison.c
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ad9e2de899da..fdafde48dad1 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -16,7 +16,6 @@ perf-y += evsel.o
 perf-y += evsel_fprintf.o
 perf-y += perf_event_attr_fprintf.o
 perf-y += evswitch.o
-perf-y += find_bit.o
 perf-y += get_current_dir_name.o
 perf-y += kallsyms.o
 perf-y += levenshtein.o
@@ -32,8 +31,6 @@ perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
 perf-y += libstring.o
-perf-y += bitmap.o
-perf-y += hweight.o
 perf-y += smt.o
 perf-y += strbuf.o
 perf-y += string.o
@@ -123,7 +120,6 @@ perf-y += term.o
 perf-y += help-unknown-cmd.o
 perf-y += dlfilter.o
 perf-y += mem-events.o
-perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
 perf-y += expr-flex.o
@@ -240,11 +236,8 @@ CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
 
-CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
-CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
-CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_parse-events.o  += -Wno-redundant-decls
 CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
@@ -257,18 +250,10 @@ $(OUTPUT)util/argv_split.o: ../lib/argv_split.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-$(OUTPUT)util/bitmap.o: ../lib/bitmap.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
 $(OUTPUT)util/ctype.o: ../lib/ctype.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-$(OUTPUT)util/find_bit.o: ../lib/find_bit.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
 $(OUTPUT)util/rbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
@@ -277,14 +262,6 @@ $(OUTPUT)util/libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-$(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
-$(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
 $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-- 
2.31.1

