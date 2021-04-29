Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44EC43461
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 15:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F09261449
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhD2PCH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbhD2PCH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Apr 2021 11:02:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01FC06138B
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Apr 2021 08:01:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id p12so47329037pgj.10
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Apr 2021 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKzTGaXq5BgNlLNQghWJCOtAajFRMnz38uWkb37Btq0=;
        b=vdjfp6T9ELO/U/TE5+KkR/ljxb5dDEpn3eDZXxEznvnTdj+ZlDuigDbJwQjcvfNe2f
         1RcVpsKvKgb/ZD7swSBbi63tgsGSduD86CHVXwlIuLk/ujREs7DH0bElJskIzdbDFvhW
         mYUOe3rnGk8q9s477H8WBr/1YeX2hfIOawdSqcwQEfKVhmj+kC8adnIDT4lYJoknNNhP
         QCLIRTG94fjMOCZF4jRqd5AmS+SKMXDwY83iJp7jm8KQAH0WGSnot94JmMopYJA428aS
         gut3YCjn5qIm5pyTaXBrEXnhZ4QOx10MH/XmrW3l9W2XmLalk+ihm3ZQxs7DauIo53e9
         4QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKzTGaXq5BgNlLNQghWJCOtAajFRMnz38uWkb37Btq0=;
        b=PmK46mZjvKxT/R8L62osc7B6g+HTR1r40aYya5HCi38S2aBLBZLpdEjOZASLUip7Mu
         s6hHeixbJaArH/rxhcbBgZQy3d25y7ruaqIxb7NLrGYycuk8ZYr+PnkqI1t/FoRvNzU+
         6MyJCLnEnnG6Hmq3GzpcIHc63feYIs7uNJnBpVvbiy42TGT0s5WnPnvT5pVp9xUdpNBn
         ZGn/pzAJJNtUnc1J57de375tWgUhWhJ0nXLwPm81fNXgzWlcDz8aqUYfqlAklnUJcTzb
         oNMP79cFBkzAorfK0rzPst+fazmCa40POp+2bahRSzchDHnzD8bI5YrbwPqfhcHgJpO/
         eqnQ==
X-Gm-Message-State: AOAM532VaYXDE6JZIlwqFiLQ36Ppx7Vcf4A1RRLXNKJ7SCRWUzWRk503
        f2QpJMQdWNV3eb+WBC6igI/xdw==
X-Google-Smtp-Source: ABdhPJxlUPcxM98q94BIRDqtl6qiB6XI4IIX8WgyoEZUYoolY68FW0vRSchkJ6LPoCXuhU9Ncw4q7Q==
X-Received: by 2002:a62:55c6:0:b029:21c:4dfc:d6e2 with SMTP id j189-20020a6255c60000b029021c4dfcd6e2mr127505pfb.60.1619708479686;
        Thu, 29 Apr 2021 08:01:19 -0700 (PDT)
Received: from localhost ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id f135sm2726924pfa.102.2021.04.29.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:01:19 -0700 (PDT)
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
Subject: [PATCH v1 3/3] perf arm-spe: Enable timestamp for per-cpu mode
Date:   Thu, 29 Apr 2021 23:01:00 +0800
Message-Id: <20210429150100.282180-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429150100.282180-1-leo.yan@linaro.org>
References: <20210429150100.282180-1-leo.yan@linaro.org>
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
---
 tools/perf/arch/arm64/util/arm-spe.c | 33 ++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index f6eec0900604..dae115dd458e 100644
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
@@ -120,9 +144,14 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
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
 	if (opts->full_auxtrace) {
-- 
2.25.1

