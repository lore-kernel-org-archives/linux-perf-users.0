Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13610C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1E861363
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhESERR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 00:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhESERQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 00:17:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8AC06175F
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:15:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so8506532pga.11
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSvPMJ6ajKYTaE4dMLmv0bU7XqFPvynhF+nhCSjEXqk=;
        b=aaCOTZsa/3yjYLdqdA/OfbMLWzu9RyJRXuZPYfr+wm3AI9457kCSoFMDCrIsLQrGLt
         ByoCDOENXrICY1ExhAww4HbaQCkuMYnaHUi2moXVW/S5cevx0U9KeGKRAg+EdufUBA+V
         1ZxFBOdj8svbSNooNQOceeTijJZm1lZDYEkpSXhTi+1d8Lr1q4cCdCLsaO/eKDLf19ez
         2YkqD0JJR1s5x88/GXM+P0fpjAOd+F+NR7xfHvvKO4rjabQ2boL8aHUt8jn1GFkgTkj3
         8xlRFRQ1K2K41Dhesb7oEyVgmMTj+CsIX46gFK77ODinRCHexWx2mKDAQQu7iBu65BYz
         ZwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSvPMJ6ajKYTaE4dMLmv0bU7XqFPvynhF+nhCSjEXqk=;
        b=Okh5i+X3UAveCkUJ7lwwWnQEfkdmfjd8LumlQVt67BppLkRnh3mLRI3LpmjVnbfI+d
         a2YE7yiYRAKjWWCojXwKpKLqcmPEya3OVcIXs0PbLYqVJ2uZG/3cdhiUmOh7xsvBOmrF
         U1zYV+JI2QgRj3Qb9DViNYFLZLAEfWGZk6yrIri9TO20d10XhCo8u99C5yZYUfrwnsb3
         czqWBjZTkfOxGC4uWnDYvtR+gDcR2wA8uSExJVtJq7cNLsUM7U0hPLqY4O8R3121MgNf
         +OBOEreH4U/UgdEMO+JC5GlsdvCN0u5aF1so6afq+SALDdsIG1RAMPSAeQlE6SGx9B6p
         GJ5w==
X-Gm-Message-State: AOAM531IL9yeUEKdRd+EPW4G+nb5I6Xk+hJ1lKHr752GLQiQLqDNftv8
        c//lU8BTt9NPYeyu2GAQpBA7zA==
X-Google-Smtp-Source: ABdhPJypI2NKauTPCzBLknKllWhLQ9Zb5c+DwOn8mkNjD/GPp1xQGsoaRdyiZLKLGIK9pw/p+X+/Tg==
X-Received: by 2002:a65:5248:: with SMTP id q8mr8763715pgp.176.1621397756718;
        Tue, 18 May 2021 21:15:56 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id d3sm13588742pfn.141.2021.05.18.21.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:15:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] perf arm-spe: Correct sample flags for SPE event
Date:   Wed, 19 May 2021 12:15:43 +0800
Message-Id: <20210519041546.1574961-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
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
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
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

