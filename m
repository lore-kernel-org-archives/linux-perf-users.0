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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1FC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328B1611EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhHUJV7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbhHUJVZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB050C061756;
        Sat, 21 Aug 2021 02:20:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i6so17675032edu.1;
        Sat, 21 Aug 2021 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ll29t2ph8DtISGKSm4m+CMcxpNqDMVgepL0wvoiS6hU=;
        b=CgzTartnOriqkGirMWqliPXDGH5PGCpv+D/qdUW1i9fR2s1C9BtC2cF/XoXNLyrryq
         8ZHAbf1hyn8sZnmVeVIOyUMYuIAg4gAh6efjV9jYVmw3GfYQKQwkHj3/k5q9Vl28Be4m
         rEeIVkBRbliXGfTxH1OV3TJTJrLEPK+/0kcIZn6SvUaybQ0Q9kjZhcbujeOaAvF+U3nq
         ZYiGujReVBp/1x/7VcahP4s4zMPAR4yIN30QFAQ/HEzr/Qdnhht2mLkf63aoQS/tsrZg
         fCjtrmDk3pXap01DO9QDvSYmxn0+O0Z8BQ1p9H8lSeTMIk6MuCPXuRmmZC2XwK82Fu27
         VK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ll29t2ph8DtISGKSm4m+CMcxpNqDMVgepL0wvoiS6hU=;
        b=iCRqDeoeI0/Fi/GKbw4PYu7K+J5rQNe9WosSGlW0SICdwHqVbDHQ4Bd9WjrEg449yH
         pIN15h1OeKWX5NvJIdmL7qUReQKJn0bggXfHtndjuiGbfgGfPdyfJOv969j/V4DQpAfx
         AOlFwoxUKSQN8xFVUmed88KyWigcBXO1ZWiR8Ze6L3Ec4y/8DXxaa9+JlIXMAaE7wq7M
         OrTRmTBdAh3cFJRIGe7JaUeEJz9D5WuDMlppVvZWvgRvYFEeUc26UsLc4XNjxzU6EFNW
         3agF4d9jwIaZWFHqBrDsP6OtnfH5db+nJ7peG/KhLk8eilyK+YQCKUh1TPk6qBObBn+R
         h/RA==
X-Gm-Message-State: AOAM5325KySwxinFzUQZOh7yOac5uEEauosUZApt+fqPNBqaMp43Sk0G
        Z9miFWhpku9iPoXmzEV/jYUWWb8u8IIe4AuWleY=
X-Google-Smtp-Source: ABdhPJykrvcRa/raNWIGISNIyfzOPR8QcM4B5ud6L6Py1INPYHktiIl58OUXtTtS6tgdLBe/JypO9g==
X-Received: by 2002:aa7:c2da:: with SMTP id m26mr7579123edp.351.1629537612166;
        Sat, 21 Aug 2021 02:20:12 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:11 -0700 (PDT)
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
Subject: [RFC PATCH v1 19/37] perf evsel: separate missing feature detection from evsel__open_cpu
Date:   Sat, 21 Aug 2021 11:19:25 +0200
Message-Id: <cba0b7d939862473662adeedb0f9c9b69566ee9a.1629490974.git.rickyman7@gmail.com>
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

This patch separates the missing feature detection in evsel__open_cpu
into a new evsel__detect_missing_features function.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 174 +++++++++++++++++++++-------------------
 tools/perf/util/evsel.h |   1 +
 2 files changed, 92 insertions(+), 83 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4e9a3e62075305f1..c393bd992322d925 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1841,6 +1841,96 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
+bool evsel__detect_missing_features(struct evsel *evsel)
+{
+	/*
+	 * Must probe features in the order they were added to the
+	 * perf_event_attr interface.
+	 */
+	if (!perf_missing_features.weight_struct &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
+		perf_missing_features.weight_struct = true;
+		pr_debug2("switching off weight struct support\n");
+		return true;
+	} else if (!perf_missing_features.code_page_size &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) {
+		perf_missing_features.code_page_size = true;
+		pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.data_page_size &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
+		perf_missing_features.data_page_size = true;
+		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+		perf_missing_features.cgroup = true;
+		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.branch_hw_idx &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
+		perf_missing_features.branch_hw_idx = true;
+		pr_debug2("switching off branch HW index support\n");
+		return true;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+		perf_missing_features.aux_output = true;
+		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
+		perf_missing_features.bpf = true;
+		pr_debug2_peo("switching off bpf_event\n");
+		return true;
+	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
+		perf_missing_features.ksymbol = true;
+		pr_debug2_peo("switching off ksymbol\n");
+		return true;
+	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
+		perf_missing_features.write_backward = true;
+		pr_debug2_peo("switching off write_backward\n");
+		return false;
+	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
+		perf_missing_features.clockid_wrong = true;
+		pr_debug2_peo("switching off clockid\n");
+		return true;
+	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
+		perf_missing_features.clockid = true;
+		pr_debug2_peo("switching off use_clockid\n");
+		return true;
+	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
+		perf_missing_features.cloexec = true;
+		pr_debug2_peo("switching off cloexec flag\n");
+		return true;
+	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
+		perf_missing_features.mmap2 = true;
+		pr_debug2_peo("switching off mmap2\n");
+		return true;
+	} else if (!perf_missing_features.exclude_guest &&
+		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
+		perf_missing_features.exclude_guest = true;
+		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+		return true;
+	} else if (!perf_missing_features.sample_id_all) {
+		perf_missing_features.sample_id_all = true;
+		pr_debug2_peo("switching off sample_id_all\n");
+		return true;
+	} else if (!perf_missing_features.lbr_flags &&
+			(evsel->core.attr.branch_sample_type &
+			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
+			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
+		perf_missing_features.lbr_flags = true;
+		pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
+		return true;
+	} else if (!perf_missing_features.group_read &&
+		    evsel->core.attr.inherit &&
+		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
+		   evsel__is_group_leader(evsel)) {
+		perf_missing_features.group_read = true;
+		pr_debug2_peo("switching off group read\n");
+		return true;
+	} else {
+		return false;
+	}
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu, int end_cpu)
@@ -1979,90 +2069,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err != -EINVAL || cpu > 0 || thread > 0)
 		goto out_close;
 
-	/*
-	 * Must probe features in the order they were added to the
-	 * perf_event_attr interface.
-	 */
-	if (!perf_missing_features.weight_struct &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
-		perf_missing_features.weight_struct = true;
-		pr_debug2("switching off weight struct support\n");
+	if (evsel__detect_missing_features(evsel))
 		goto fallback_missing_features;
-	} else if (!perf_missing_features.code_page_size &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) {
-		perf_missing_features.code_page_size = true;
-		pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support, bailing out\n");
-		goto out_close;
-	} else if (!perf_missing_features.data_page_size &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		perf_missing_features.data_page_size = true;
-		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
-		goto out_close;
-	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
-		perf_missing_features.cgroup = true;
-		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
-		goto out_close;
-        } else if (!perf_missing_features.branch_hw_idx &&
-	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
-		perf_missing_features.branch_hw_idx = true;
-		pr_debug2("switching off branch HW index support\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
-		perf_missing_features.aux_output = true;
-		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
-		goto out_close;
-	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
-		perf_missing_features.bpf = true;
-		pr_debug2_peo("switching off bpf_event\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
-		perf_missing_features.ksymbol = true;
-		pr_debug2_peo("switching off ksymbol\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
-		perf_missing_features.write_backward = true;
-		pr_debug2_peo("switching off write_backward\n");
-		goto out_close;
-	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
-		perf_missing_features.clockid_wrong = true;
-		pr_debug2_peo("switching off clockid\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
-		perf_missing_features.clockid = true;
-		pr_debug2_peo("switching off use_clockid\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
-		perf_missing_features.cloexec = true;
-		pr_debug2_peo("switching off cloexec flag\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
-		perf_missing_features.mmap2 = true;
-		pr_debug2_peo("switching off mmap2\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.exclude_guest &&
-		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
-		perf_missing_features.exclude_guest = true;
-		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.sample_id_all) {
-		perf_missing_features.sample_id_all = true;
-		pr_debug2_peo("switching off sample_id_all\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.lbr_flags &&
-			(evsel->core.attr.branch_sample_type &
-			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
-			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
-		perf_missing_features.lbr_flags = true;
-		pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
-		goto fallback_missing_features;
-	} else if (!perf_missing_features.group_read &&
-		    evsel->core.attr.inherit &&
-		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
-		   evsel__is_group_leader(evsel)) {
-		perf_missing_features.group_read = true;
-		pr_debug2_peo("switching off group read\n");
-		goto fallback_missing_features;
-	}
 out_close:
 	if (err)
 		threads->err_thread = thread;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 58aa998e1814ac9e..a83fb7f69b1ead73 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -288,6 +288,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 void evsel__close(struct evsel *evsel);
 int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
+bool evsel__detect_missing_features(struct evsel *evsel);
 
 struct perf_sample;
 
-- 
2.31.1

