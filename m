Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5EAC77B60
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 07:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbjDZHIG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbjDZHHo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 03:07:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D49A49F1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:06:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b922aa3725fso12913632276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492743; x=1685084743;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=0z/PrK6g6Xg4czeVIlj/pX3dWF4UNtJWqvXu+++3gH/z292bUXYL+CP5liRdzaOXwK
         G0FMKhhAKAFSTw9bYZ0YvNnJhYCTYp1Iogw8KjhJLvRS6ut+2nRWuUIKZKySwKNpDE04
         6qql3m+G/H0iVxs0/09IG1lOCs/N6J2G2XR2nEzo4PgiW639yuwiNHXbOLIfSEprwr1G
         AYECmWQuGkvgI0wWw9a2B1j5kj8IE/9ymlXpo/Fx12X33R5K96yesB0lXUK9B0HUyOzw
         Xr9plpsGCYkbzwKZ9HEzUopdL4/Tt4Yw4D5C1sVuBsfMtpkhzu0epGLIhrqimnyLobPq
         7Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492743; x=1685084743;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=Ox25iignKWqNI4hAN9VkYpmS296NHfRv9grlY+t8eh4ZTnkABR8C9EunshpstNRhhP
         pTp1xpghxhkUj+X5fHngMtgZ9+bhUkMJHO2PPvZBRtLElinNPg02OPpXGvjXVY01R5Hj
         x+Xj/unCCJ4+Ok/puF6UVByKVItKn1Q8vyuD8BHZcAZZ37HFVEzs+prmETbjW5eHv5M3
         m551POjB4ulUEk6HX/3oOs5zK2i8Xrw+ihqkHv5vkb4NjvwCxlcrF8OO1VSk1e6UPjU5
         sY9+1x7TSLBnM6tirAq5HF3gK15VX4hB0BOMxtLtejmKi82PXCM4WnMseAExgJoLKscF
         MKnA==
X-Gm-Message-State: AAQBX9ekQKS7SJAVPwKJPd4sV235T9Q3zXamBk5uAfrj0oT/ulQjPnNf
        yTE0E7nP1aMmLXykmMJ9Nxxh6IMbUo4j
X-Google-Smtp-Source: AKy350ZW/8qb50C6+D2zOw6h8DWAL4oDMWu5eMmEbwxOsS26DXiiJWDPDp4nKg7TB/ukOVNir4OT10PfxKQK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:d7d8:0:b0:b78:8bd8:6e77 with SMTP id
 o207-20020a25d7d8000000b00b788bd86e77mr11071249ybg.8.1682492743662; Wed, 26
 Apr 2023 00:05:43 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:44 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-35-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 34/40] perf parse-events: Don't reorder atom cpu events
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On hybrid systems the topdown events don't share a fixed counter on
the atom core, so they don't require the sorting the perf metric
supporting PMUs do.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index d4193479a364..1b6065841fb0 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -6,6 +6,7 @@
 #include "util/event.h"
 #include "util/pmu-hybrid.h"
 #include "topdown.h"
+#include "evsel.h"
 
 static int ___evlist__add_default_attrs(struct evlist *evlist,
 					struct perf_event_attr *attrs,
@@ -67,8 +68,7 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
-	if (topdown_sys_has_perf_metrics() &&
-	    (!lhs->pmu_name || !strncmp(lhs->pmu_name, "cpu", 3))) {
+	if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
 		/* Ensure the topdown slots comes first. */
 		if (strcasestr(lhs->name, "slots"))
 			return -1;
-- 
2.40.1.495.gc816e09b53d-goog

