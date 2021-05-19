Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F309C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1224761363
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhESER0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhESERY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 00:17:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE1C061763
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:16:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so2732892pjb.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnv8F8uuj2iGeObVVsabQBsjZH5xCx4JzTz8peGn5X8=;
        b=Y+RMOePPmr4kW5SydrzVYc81VRZiT9Pdaw7+lMi1c/3VQAJnwsVKJZ+Owg4oqkoImN
         VQ/xQHlYqld5wGmU3OvkCbAK6+LLB12H9EfoDb8qfgMLqCfFItZMQjUX1NhPRHHb0zg4
         u3ALxImkgMy4kfxfidk4xgaKDK/53HBYifOz5BQMJZL75y1MJ+cFXmGu+VgTSMkvT274
         64uQuhmXUWh9sb5p7LndkI/DAoEuUOfLL2At1xAMn88XQ/8H+jssdSXFofc3ef1vzkdb
         /tmX5nIfzFoAcKgfrMlZz2GElZHwA6QkrsYvzmUwL19070gJ+1AYJ+pfQbYkzz8Ped4B
         98ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnv8F8uuj2iGeObVVsabQBsjZH5xCx4JzTz8peGn5X8=;
        b=EWHGIXMstFOc7Jz3n0BtFOGO7+SM/QPKUprWs8wGbWaWwj3BkiJhhqbrHUriyX/RS+
         KWx3cjnVEbBLP3WOtLUnqnZP7HwlidGFW2OX5W3TuA8Di5LAsCQelvlItJ+4zRaKf4xb
         Br+FrU99/3lebydufIhRAvOixCnEtYcvtZISf8rdiyXRJWQjylV5FWPRjYB+mURkVptI
         iQZezemR4mvhvadK4lAPLrbH44jOJlrZwvoX9/TbFlEstrVjlQErjbb9qX4ppeXt1a8H
         BeyxtvQjYGnTlSbOGZz5bxqNMRMeJkdoleCmfC++PtUw/VWhhicQ6cOGYwMUf23CfE3e
         Y0mg==
X-Gm-Message-State: AOAM532RsoE8zRZkZJE03KEFQvzCFeVF94VtTJrpCtcHyQPnGSfDfxG8
        1DVom/BMTeFTW5hRnRmMyjs+kw==
X-Google-Smtp-Source: ABdhPJxqPnecAC2BAEyYAoyFzR9V9h/+elZ/KCxFqPwDX2Iiya4EEcsqoiloKy2Ce3eTob3HDqmniQ==
X-Received: by 2002:a17:902:a58b:b029:ee:d13a:2642 with SMTP id az11-20020a170902a58bb02900eed13a2642mr8544241plb.35.1621397764039;
        Tue, 18 May 2021 21:16:04 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id n23sm811091pff.93.2021.05.18.21.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:16:03 -0700 (PDT)
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
Subject: [PATCH v2 3/4] perf arm-spe: Enable timestamp for per-cpu mode
Date:   Wed, 19 May 2021 12:15:45 +0800
Message-Id: <20210519041546.1574961-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

For per-cpu mmap, it should enable timestamp tracing for Arm SPE; this
is helpful for samples correlation.

To automatically enable the timestamp, a helper arm_spe_set_timestamp()
is introduced for setting "ts_enable" format bit.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 33 ++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4c916626c203..bacdf366040d 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -14,6 +14,7 @@
 #include "../../../util/cpumap.h"
 #include "../../../util/event.h"
 #include "../../../util/evsel.h"
+#include "../../../util/evsel_config.h"
 #include "../../../util/evlist.h"
 #include "../../../util/session.h"
 #include <internal/lib.h> // page_size
@@ -32,6 +33,29 @@ struct arm_spe_recording {
 	struct evlist		*evlist;
 };
 
+static void arm_spe_set_timestamp(struct auxtrace_record *itr,
+				  struct evsel *evsel)
+{
+	struct arm_spe_recording *ptr;
+	struct perf_pmu *arm_spe_pmu;
+	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	u64 user_bits = 0, bit;
+
+	ptr = container_of(itr, struct arm_spe_recording, itr);
+	arm_spe_pmu = ptr->arm_spe_pmu;
+
+	if (term)
+		user_bits = term->val.cfg_chg;
+
+	bit = perf_pmu__format_bits(&arm_spe_pmu->format, "ts_enable");
+
+	/* Skip if user has set it */
+	if (bit & user_bits)
+		return;
+
+	evsel->core.attr.config |= bit;
+}
+
 static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		       struct evlist *evlist __maybe_unused)
@@ -121,9 +145,14 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 */
 	evlist__to_front(evlist, arm_spe_evsel);
 
-	/* In the case of per-cpu mmaps, sample CPU for AUX event. */
-	if (!perf_cpu_map__empty(cpus))
+	/*
+	 * In the case of per-cpu mmaps, sample CPU for AUX event;
+	 * also enable the timestamp tracing for samples correlation.
+	 */
+	if (!perf_cpu_map__empty(cpus)) {
 		evsel__set_sample_bit(arm_spe_evsel, CPU);
+		arm_spe_set_timestamp(itr, arm_spe_evsel);
+	}
 
 	/* Add dummy event to keep tracking */
 	err = parse_events(evlist, "dummy:u", NULL);
-- 
2.25.1

