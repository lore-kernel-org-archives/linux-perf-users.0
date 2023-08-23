Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519A1EE49A0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjHWIJr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHWIJ2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617310C6
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d37b541a2so75444237b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778122; x=1693382922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPnFmXeyFkpH92acmVYaB7s7M5HAfFjCQ+0LeXyrC8o=;
        b=erD6se6wWYNxMRNnxpJKT+CkcnlF9rW5mxGvW3Hrljaky28uFZPiEaO6MslqXK5AOc
         SVMP3UixpegWhIQIlqbDZs2YOqCJmckqAwLVUWg80OWPflbvvijJeU2tInQGtCCprqrM
         nF97qa8HGpZjowMwWZI3ydfAH9IJ+0c9epGVA7OlgMnu8HvdPBv1Xc/Klp3ewjXGjZZy
         Kzc4gVOmYwrJ27ycdR1G0TBREz7yaFJcBjeVj+jRRU14tc9ThkBcmuzv8Pj8IitmmBv8
         vq2e0gsecECUiHPr+/FNa6bvqpE55N/yDk8JqlvCndNnbUWZSg3I0SCoy0WhixbhhDI2
         YzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778122; x=1693382922;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPnFmXeyFkpH92acmVYaB7s7M5HAfFjCQ+0LeXyrC8o=;
        b=ZYN2FSsNSf48JeQWLzt/GzKvGTNMUr0o0GQkcxFPC9ilIVmBOGC/XADPtyoKJw5Z53
         hIXvBdTAs+3kdqBVnYReIkZwI97Ai491+ujwm1Bt/HMOtj2YwOJqWWXyT7YOdB+ZvTnK
         MN2utlydoA5nGcG4jaVS6q19pX6ZuysYKLRrKmQVzTX7HNNCXjNCMBfqlZ1d90Mw/WdB
         khtf4pPg5+nred1F+vvqgD+ZfVWSlXIDSE1iPm7Icz6ytRfub6rOWjE1e2WEpWorwL6J
         376/l6uCaPG1kti5npjyjCdBh6Dpet/ndPetZQQ83XHlX0FTz1ix5wyGFFyO91NLioSk
         +GTA==
X-Gm-Message-State: AOJu0YyptznkHP83zNpARwIwastF6/4WUwccTWbn2Z5C9LGhzIZyu59m
        pNcyLR7eNe0dhDeMqqHcaho+FUKFDrms
X-Google-Smtp-Source: AGHT+IFtJ3nG1pLmJ6VyeysdGuexhwYFJCPbmdMqMcV4rPcyeYllKmisw8+apKwTOg7hrLiSw+0oVAHvOB1/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:690c:368b:b0:589:dbc8:3d11 with SMTP
 id fu11-20020a05690c368b00b00589dbc83d11mr169092ywb.9.1692778121920; Wed, 23
 Aug 2023 01:08:41 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:07 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-5-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 04/25] perf pmu: Reduce scope of perf_pmu_error
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move declaration from header file to pmu.y and make static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.h | 1 -
 tools/perf/util/pmu.y | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 9c9ea40b9c71..5394c85d20b9 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -227,7 +227,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 				  struct list_head *head_terms);
-void perf_pmu_error(struct list_head *list, char *name, void *scanner, char const *msg);
 
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index 9bd9e30791ff..d861a5bfa3bd 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -21,6 +21,8 @@ do { \
                 YYABORT; \
 } while (0)
 
+static void perf_pmu_error(struct list_head *list, char *name, void *scanner, char const *msg);
+
 static void perf_pmu__set_format(unsigned long *bits, long from, long to)
 {
 	long b;
@@ -93,7 +95,7 @@ PP_VALUE
 
 %%
 
-void perf_pmu_error(struct list_head *list __maybe_unused,
+static void perf_pmu_error(struct list_head *list __maybe_unused,
 		    char *name __maybe_unused,
 		    void *scanner __maybe_unused,
 		    char const *msg __maybe_unused)
-- 
2.42.0.rc1.204.g551eb34607-goog

