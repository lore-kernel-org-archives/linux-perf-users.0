Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0FAC433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B426143B
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhD2PB7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbhD2PB7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Apr 2021 11:01:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD65C06138B
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Apr 2021 08:01:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so4676548pju.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Apr 2021 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE2j4G0rnU+RbiAnIU0X9z105Hwk3a+nEYNJ2sTp6CU=;
        b=o2ddHO/AJTn4nUM9kptqP2uMHAMJ+tXCezYjcHsPtHtR80o3MLq8ZcI0kgffb1PEfg
         YzVpScqWNeHsXdYbKZD/1Dn1dqBQQCHG+AuDXc5TXsUlYKmJ/IXGBqvUJhmE9e5Bp0rG
         AXSAhRsjkIjhCW3rnSIFonB08/nLdXVP+rlcb4QdcnUTmEtQWSHLQCJQqLCROz4BeUDG
         nzCk76wnyt2npPUsVmwQeHWlhBOMmqJkBnsECFgxrlTEaHPlrceAgHkwo82nBbvKsrOr
         Gm6kmwW/TlN3MRUppOT0xr7TuVUxXUseXw8agsFhll17BSzCcN5uIae2xBoycb3vMscr
         tA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE2j4G0rnU+RbiAnIU0X9z105Hwk3a+nEYNJ2sTp6CU=;
        b=FNbOtqzQt/0lAxuP1sxy6kr7dFg68Wr5/9MuX2KgnpoAK5ob4a/wiv3Vhba6GxSby5
         RSKKMesiXB8aMCvFWIZkbnQ1thLWxoNgOAs24HuU5AdP5Uiq9p9/ngq8bu2kPuhQEr0J
         j1bOIdpsplmRYqUspP3FS4fHvB0LOAMTvG5a7jqyLrRBNE3B/izTGXG4QD6povAe3omS
         IENQY7XOo3tAVk7Y2hZgm0CFGWBxWOMmDh1H7RNIxUSp2uK0WSo/GjJGVDfVIivFkOXu
         8iQ1yNxRgsD8Ow8t487smmK6Lz9PMsIEZHm6k/h5+WX4966tCP/kMXjb1ZBLBOKQU4YK
         D+vQ==
X-Gm-Message-State: AOAM531hqA2K2ISL+Bgch3cI+YcbsvG0AAXN2Jx7JB2IbDB68q4d6+2p
        Ers/fMlB8HrTMHN0WAx/DXmn9dDz+aWGZJ1j
X-Google-Smtp-Source: ABdhPJwf7g1oC6ruN3H77OZGGIRAb6C00AkhUyagpmFnha9GKdP+iU7Pm4OP9a7ydWBuovm7owxq/A==
X-Received: by 2002:a17:902:778f:b029:ec:d04d:4556 with SMTP id o15-20020a170902778fb02900ecd04d4556mr152564pll.43.1619708472144;
        Thu, 29 Apr 2021 08:01:12 -0700 (PDT)
Received: from localhost ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id e2sm2627677pjk.31.2021.04.29.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:01:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <James.Clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] perf arm-spe: Correct sample flags for SPE event
Date:   Thu, 29 Apr 2021 23:00:58 +0800
Message-Id: <20210429150100.282180-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429150100.282180-1-leo.yan@linaro.org>
References: <20210429150100.282180-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now it's hard code to set sample flags for CPU, TIME and TID for SPE
event, which is pointless.

The CPU is useful for sampling only for per-mmap case, it is used to
indicate the AUX trace is associated to which CPU.

The TIME sample is not needed for AUX event, since the time for AUX
event is not really used and this time is a different thing from the
timestamp in Arm SPE trace, the timestamp tracing which is controlled
by Arm SPE's config bit.

The TID sample is not useful for AUX event.

This patch corrects the sample flags for SPE event, it only set CPU
sample bit for per-cpu mmap case.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 414c8a5584b1..902e73a64184 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -68,6 +68,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 	struct evsel *evsel, *arm_spe_evsel = NULL;
+	struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = perf_event_paranoid_check(-1);
 	struct evsel *tracking_evsel;
 	int err;
@@ -120,9 +121,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 */
 	evlist__to_front(evlist, arm_spe_evsel);
 
-	evsel__set_sample_bit(arm_spe_evsel, CPU);
-	evsel__set_sample_bit(arm_spe_evsel, TIME);
-	evsel__set_sample_bit(arm_spe_evsel, TID);
+	/* In the case of per-cpu mmaps, sample CPU for AUX event. */
+	if (!perf_cpu_map__empty(cpus))
+		evsel__set_sample_bit(arm_spe_evsel, CPU);
 
 	/* Add dummy event to keep tracking */
 	err = parse_events(evlist, "dummy:u", NULL);
-- 
2.25.1

