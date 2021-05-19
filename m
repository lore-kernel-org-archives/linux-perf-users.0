Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3139C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F4561040
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbhESHVK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 03:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhESHVJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 03:21:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18DC061760
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 27so7507025pgy.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikMzLhYHgW5Z/4bQ0Gq8qCGP1swc3iELZAURTBpDjSc=;
        b=TMGySE+iYwVL2D64hw50nAoVv8hZz6tKc0YxapGtDEd4WjYHVnU/ooPRoyMu/Zf3p2
         yhfKY1TD9QxTWAmUS9jIrAr1BITawhRV+F1/3wrBEEt51S2LlF31rAWg3Ks+EpRlVmwd
         NjgkaEdxAJ93s0zy94cCRPqShs1GZnyfI4/ZNaFtd/B66V3yKRRiJLviWkmpL44altk8
         8ybkltQrLCgFHQKt3w7yK3RPdaMWsOxfY6JRFzDY6PVV95Qvhm8Xd7OgWDknNjZBiDjq
         YMgCtFSGIUN3NZ0voD87H+1ttKUZYBbgRZA+obcKTsAXGMTn67oIS8Crc4x3p4xJzFu5
         EtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikMzLhYHgW5Z/4bQ0Gq8qCGP1swc3iELZAURTBpDjSc=;
        b=l+jmETDKMRytcB5d0J0iRhOpKQoiGpn9XypRP5FounhaFXJT3u2oPgprK/2UaslKQP
         mpHj8x8IIoInhRRFSwFYDX53DLCNdargsAWP4PjJSKqyZW3t/SsZqusShwSU9ewinq65
         rKyhJWypMxc8m48pIQilh2R1lZuRS5n+vry4yPBalR9WzXWbm52TkGVdk5siGocQqMwy
         t7KiVBFDmn6dJGttiuggchxFFRQzNoornlJidPabtI9vtw/DHwZrhowk1EcYXNa7dt4c
         HNKCL03PuT4J+ojLErLSrqEBwLBOd63G1TPxDUTXIc5iBKR//DGTeYs4jjdpvDzPYwGO
         bGFw==
X-Gm-Message-State: AOAM531BYFZkZo2zqjOZlEapcehcr+VdcVYlK+6pVXJ2d5A4ti1vRHAN
        oPiLnHD+wy0pCqgkbhAqf6eg0A==
X-Google-Smtp-Source: ABdhPJznM7CZjOHFdLYcTo+2TQoISjuHu+CGZSXrSlocSRHWq4Znr0MOsQz7Bm5d23RgRcSkZG2pew==
X-Received: by 2002:a63:205b:: with SMTP id r27mr9573031pgm.95.1621408789750;
        Wed, 19 May 2021 00:19:49 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id g4sm14533696pgu.46.2021.05.19.00.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 1/5] perf arm-spe: Save clock parameters from TIME_CONV event
Date:   Wed, 19 May 2021 15:19:35 +0800
Message-Id: <20210519071939.1598923-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

During the recording phase, "perf record" tool synthesizes event
PERF_RECORD_TIME_CONV for the hardware clock parameters and saves the
event into the data file.

Afterwards, when processing the data file, the event TIME_CONV will be
processed at the very early time and is stored into session context.

This patch extracts these parameters from the session context and saves
into the structure "spe->tc" with the type perf_tsc_conversion, so that
the parameters are ready for conversion between clock counter and time
stamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2539d4baec44..d2ae5a5c13ee 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -26,6 +26,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "tsc.h"
 #include "tool.h"
 #include "util/synthetic-events.h"
 
@@ -45,6 +46,8 @@ struct arm_spe {
 	struct machine			*machine;
 	u32				pmu_type;
 
+	struct perf_tsc_conversion	tc;
+
 	u8				timeless_decoding;
 	u8				data_queued;
 
@@ -1006,6 +1009,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
+	struct perf_record_time_conv *tc = &session->time_conv;
 	struct arm_spe *spe;
 	int err;
 
@@ -1027,6 +1031,28 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
+
+	/*
+	 * The synthesized event PERF_RECORD_TIME_CONV has been handled ahead
+	 * and the parameters for hardware clock are stored in the session
+	 * context.  Passes these parameters to the struct perf_tsc_conversion
+	 * in "spe->tc", which is used for later conversion between clock
+	 * counter and timestamp.
+	 *
+	 * For backward compatibility, copies the fields starting from
+	 * "time_cycles" only if they are contained in the event.
+	 */
+	spe->tc.time_shift = tc->time_shift;
+	spe->tc.time_mult = tc->time_mult;
+	spe->tc.time_zero = tc->time_zero;
+
+	if (event_contains(*tc, time_cycles)) {
+		spe->tc.time_cycles = tc->time_cycles;
+		spe->tc.time_mask = tc->time_mask;
+		spe->tc.cap_user_time_zero = tc->cap_user_time_zero;
+		spe->tc.cap_user_time_short = tc->cap_user_time_short;
+	}
+
 	spe->auxtrace.process_event = arm_spe_process_event;
 	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
 	spe->auxtrace.flush_events = arm_spe_flush;
-- 
2.25.1

