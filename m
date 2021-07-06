Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED893C07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25FD61C23
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhGFPUn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232752AbhGFPUk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHU8f2icdK+j46ssBwyIWeDWF8/W9yG0Xo/wNsnnNmg=;
        b=bZSQXJ1ZCxa0gEBCceoTSi+mSPo7WuLn5QzyjmFQzilyo/KxDiH3fZhq2HAxJtKuyHP56a
        DdMxeJMu+3Qj1qu2tsgUtRutCQdMuRR4m4xoxBNICfLSTxpW8Q+1BRCDc/12/MKAwxDElZ
        NhJR1P0theNBisqXwvE8/gllpAaNlSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-WaRB_aDaN5iZhLkSgxtqCQ-1; Tue, 06 Jul 2021 11:18:00 -0400
X-MC-Unique: WaRB_aDaN5iZhLkSgxtqCQ-1
Received: by mail-wm1-f69.google.com with SMTP id i3-20020a05600c3543b02902075ed92710so1239188wmq.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 08:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHU8f2icdK+j46ssBwyIWeDWF8/W9yG0Xo/wNsnnNmg=;
        b=IrtkYY/94Vphaw8nvbefa0DnTcuxMYPGKmzEbKgyQXGNqczbLiH3NCYTww5YwsUDSy
         XSudKntYaIwUYN34PVLm7TrZbVMDdo2haDm1WEed73WSpEfwacizSJtzkZKwHorxCErr
         /CKtcsY47WLpducUTzOzwxZP8XwIMsyj+MzL8dR1Ssb09cPffyCPMT9l7mhZaFhoJZHF
         3GB6ZnEyMNjtkkCV4XGdCjiw/0RbMAHmlWQHwUymsgKDjP70xaGMkU+VuclBmbr0aS98
         RKLndNoNNFCDFI2UokPyzhJ09MLE0ps2TTLoskR0B0ZAkDJk3httNlm6Jlwf5GSRFhvd
         3WLw==
X-Gm-Message-State: AOAM533Im19mFFAvEDqc2cpBLgK07OaKhgl2F2rL7eqzv0G9bzHh7Jqa
        wt3Q4Vx6M7/7u6WtLX/j4nvEWNl6J/jt0nDUdJLXCTyzJH6uBfoFTucucL1ytvzeo+7RPRRb5/a
        PBgc6Mfn6Go22dJsUsfh5s/Iy+TZ7PQ==
X-Received: by 2002:a7b:c449:: with SMTP id l9mr1427009wmi.98.1625584679241;
        Tue, 06 Jul 2021 08:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0kDQxyTU40RhSOP4XdynNUVKVspoVcd0adKoz+VHvkWSxUG7AOUL3eWDR0YFZt/bXmjmybg==
X-Received: by 2002:a7b:c449:: with SMTP id l9mr1426990wmi.98.1625584679129;
        Tue, 06 Jul 2021 08:17:59 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id t16sm17028123wrp.44.2021.07.06.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:58 -0700 (PDT)
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
Subject: [PATCH 7/7] libperf: Add tests for perf_evlist__set_leader function
Date:   Tue,  6 Jul 2021 17:17:04 +0200
Message-Id: <20210706151704.73662-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding test for newly added perf_evlist__set_leader function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/tests/test-evlist.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 7435529fb21c..c67c83399170 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -19,6 +19,7 @@
 #include <internal/tests.h>
 #include <api/fs/fs.h>
 #include "tests.h"
+#include <internal/evsel.h>
 
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
@@ -30,7 +31,7 @@ static int test_stat_cpu(void)
 {
 	struct perf_cpu_map *cpus;
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
+	struct perf_evsel *evsel, *leader;
 	struct perf_event_attr attr1 = {
 		.type	= PERF_TYPE_SOFTWARE,
 		.config	= PERF_COUNT_SW_CPU_CLOCK,
@@ -47,7 +48,7 @@ static int test_stat_cpu(void)
 	evlist = perf_evlist__new();
 	__T("failed to create evlist", evlist);
 
-	evsel = perf_evsel__new(&attr1);
+	evsel = leader = perf_evsel__new(&attr1);
 	__T("failed to create evsel1", evsel);
 
 	perf_evlist__add(evlist, evsel);
@@ -57,6 +58,10 @@ static int test_stat_cpu(void)
 
 	perf_evlist__add(evlist, evsel);
 
+	perf_evlist__set_leader(evlist);
+	__T("failed to set leader", leader->leader == leader);
+	__T("failed to set leader", evsel->leader  == leader);
+
 	perf_evlist__set_maps(evlist, cpus, NULL);
 
 	err = perf_evlist__open(evlist);
@@ -85,7 +90,7 @@ static int test_stat_thread(void)
 	struct perf_counts_values counts = { .val = 0 };
 	struct perf_thread_map *threads;
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
+	struct perf_evsel *evsel, *leader;
 	struct perf_event_attr attr1 = {
 		.type	= PERF_TYPE_SOFTWARE,
 		.config	= PERF_COUNT_SW_CPU_CLOCK,
@@ -104,7 +109,7 @@ static int test_stat_thread(void)
 	evlist = perf_evlist__new();
 	__T("failed to create evlist", evlist);
 
-	evsel = perf_evsel__new(&attr1);
+	evsel = leader = perf_evsel__new(&attr1);
 	__T("failed to create evsel1", evsel);
 
 	perf_evlist__add(evlist, evsel);
@@ -114,6 +119,10 @@ static int test_stat_thread(void)
 
 	perf_evlist__add(evlist, evsel);
 
+	perf_evlist__set_leader(evlist);
+	__T("failed to set leader", leader->leader == leader);
+	__T("failed to set leader", evsel->leader  == leader);
+
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
@@ -136,7 +145,7 @@ static int test_stat_thread_enable(void)
 	struct perf_counts_values counts = { .val = 0 };
 	struct perf_thread_map *threads;
 	struct perf_evlist *evlist;
-	struct perf_evsel *evsel;
+	struct perf_evsel *evsel, *leader;
 	struct perf_event_attr attr1 = {
 		.type	  = PERF_TYPE_SOFTWARE,
 		.config	  = PERF_COUNT_SW_CPU_CLOCK,
@@ -157,7 +166,7 @@ static int test_stat_thread_enable(void)
 	evlist = perf_evlist__new();
 	__T("failed to create evlist", evlist);
 
-	evsel = perf_evsel__new(&attr1);
+	evsel = leader = perf_evsel__new(&attr1);
 	__T("failed to create evsel1", evsel);
 
 	perf_evlist__add(evlist, evsel);
@@ -167,6 +176,10 @@ static int test_stat_thread_enable(void)
 
 	perf_evlist__add(evlist, evsel);
 
+	perf_evlist__set_leader(evlist);
+	__T("failed to set leader", leader->leader == leader);
+	__T("failed to set leader", evsel->leader  == leader);
+
 	perf_evlist__set_maps(evlist, NULL, threads);
 
 	err = perf_evlist__open(evlist);
@@ -254,6 +267,7 @@ static int test_mmap_thread(void)
 
 	evsel = perf_evsel__new(&attr);
 	__T("failed to create evsel1", evsel);
+	__T("failed to set leader", evsel->leader == evsel);
 
 	perf_evlist__add(evlist, evsel);
 
@@ -339,6 +353,7 @@ static int test_mmap_cpus(void)
 
 	evsel = perf_evsel__new(&attr);
 	__T("failed to create evsel1", evsel);
+	__T("failed to set leader", evsel->leader == evsel);
 
 	perf_evlist__add(evlist, evsel);
 
-- 
2.31.1

