Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D862CC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE4D611EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhHUJVl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhHUJVQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144EAC0613CF;
        Sat, 21 Aug 2021 02:20:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d11so25134679eja.8;
        Sat, 21 Aug 2021 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bmu3Fw9zmgDwWJcJ4+5MOZxCKRd0DdpkeYuxgu64FQ=;
        b=BZ0kBqFERbWnZHrCk4EMplslRN4zRsOzoj7eeWeGHoHcNqT56Rk2D1nu1rPk+O/8n2
         EGh8oS9XuM8H3wlXq6MAJxukf5fLXy867ewCIqIe5RU3lujHHBK0JtFt05UsZGipYLQR
         97qp9japXOXLaLq0RT72RMnc/Zsp62qtyBiYswImys9IhtLKpT6NW8HER4K5NEy7gJYE
         PF6sZxVcM0Il6hdY/kyF2LeLAk4VpN7LIxXk2RlhKszkDA3crwwLn+/tRJb3LsxkvtS2
         YuviLTREkjyHRm2ElVPdXU55R1v/r/uVzgpxfcWL4Mxb7P4Vzm2zM1FwHjd582U5RG7I
         4wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bmu3Fw9zmgDwWJcJ4+5MOZxCKRd0DdpkeYuxgu64FQ=;
        b=ZQfJEI2z3ouzksPRfrsexX36a/ekb2rl0n/fgJcg7m8hQ/nvaQRTUFyaDsZIRhd1YT
         Drc4g7q8e792ZL9zIfQBzMcTdkE8zZstrXvPfb8X0zIF+WHFbyT1zOoJryyfNg+rLR9t
         RS5ar/hCCIbxwixhuXzLN2s7DKLmddNJijo37XWCzJSHs3Fi0ChIALhqUdlsB6hybqLo
         EVtvb/8IV8ezic0OlQxcpwfrTHf1Ywi4u3jnAVqblCQSbA29Wy3J0HyVfXa1zbF1F/Jm
         13SzIgqrfA66Vz86QHq+919cieBUnW/yFY4UKn4/fAaBlUW+NTF9x1kQN17LgyEm9NRM
         m4Og==
X-Gm-Message-State: AOAM531RqyahX3J2rBbIuoqQOaYkkucWrnCpKH7Osb18wdtUrSDWSYhj
        Qs3j4EAl25tnjsxNGli/dvLkEL9cL8GVsL4wDxM=
X-Google-Smtp-Source: ABdhPJzWtsFt2DdMrGwdN1/CTaXlQRRznR3ZMo/bJErIajlOkyiWCXGK6K3D0vzqnjtr5+FCSX+jTQ==
X-Received: by 2002:a17:906:dc51:: with SMTP id yz17mr2036023ejb.498.1629537609566;
        Sat, 21 Aug 2021 02:20:09 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:09 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 17/37] perf evsel: separate missing feature disabling from evsel__open_cpu
Date:   Sat, 21 Aug 2021 11:19:23 +0200
Message-Id: <48138bd2932646dde315505da733c2ca635ad2ee.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a preparatory patch for the following patches with the goal to
separate in evlist__open_cpu the actual opening, which could be
performed in parallel, from the existing fallback mechanisms, which
should be handled sequentially.

This patch separates the disabling of missing features from
evlist__open_cpu into a new function evsel__disable_missing_features.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 57 ++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 509a2970a94b3142..f0bc89f743915800 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1794,33 +1794,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 }
 
-static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
-		struct perf_thread_map *threads,
-		int start_cpu, int end_cpu)
+static void evsel__disable_missing_features(struct evsel *evsel)
 {
-	int cpu, thread, nthreads;
-	int pid = -1, err, old_errno;
-	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
-
-	err = __evsel__prepare_open(evsel, cpus, threads);
-	if (err)
-		return err;
-
-	if (cpus == NULL)
-		cpus = empty_cpu_map;
-
-	if (threads == NULL)
-		threads = empty_thread_map;
-
-	if (evsel->core.system_wide)
-		nthreads = 1;
-	else
-		nthreads = threads->nr;
-
-	if (evsel->cgrp)
-		pid = evsel->cgrp->fd;
-
-fallback_missing_features:
 	if (perf_missing_features.weight_struct) {
 		evsel__set_sample_bit(evsel, WEIGHT);
 		evsel__reset_sample_bit(evsel, WEIGHT_STRUCT);
@@ -1850,6 +1825,36 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
+}
+
+static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
+		struct perf_thread_map *threads,
+		int start_cpu, int end_cpu)
+{
+	int cpu, thread, nthreads;
+	int pid = -1, err, old_errno;
+	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
+
+	err = __evsel__prepare_open(evsel, cpus, threads);
+	if (err)
+		return err;
+
+	if (cpus == NULL)
+		cpus = empty_cpu_map;
+
+	if (threads == NULL)
+		threads = empty_thread_map;
+
+	if (evsel->core.system_wide)
+		nthreads = 1;
+	else
+		nthreads = threads->nr;
+
+	if (evsel->cgrp)
+		pid = evsel->cgrp->fd;
+
+fallback_missing_features:
+	evsel__disable_missing_features(evsel);
 
 	display_attr(&evsel->core.attr);
 
-- 
2.31.1

