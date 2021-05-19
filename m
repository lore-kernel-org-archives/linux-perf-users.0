Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7906C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D17760FE4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 04:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhESERW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 00:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhESERU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 00:17:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15264C061760
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:16:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h7so6299291plt.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hP472i8tu0x2oWr2ZZdW3TiExRRKywLv6WAxBp0eH4=;
        b=ZqWbS934HXeMusilkVQHGpZ3Q7vGiO7M0MUhqBwrcrwXi+yiv+LfI1IFFgG55aPJ3F
         AqPEzAT7IbucWE+hJY1kLI3IgxoGc26uDeR8hTERW6r4mUhqr/wj25zAXWpckxqMyJaQ
         e9wa8PoKnLRs6YM2oykFuACMjKlfifKrW/fRG8dH5auH3N++J40GsQb/mOGRSbp7AVtt
         63ew5qNPYMksJ374gKdWGU3yxvOlLUj5a2GWDAzzBIOolZT8BYehXPx47F5zXJe1ZxIp
         oS0+kaCHvPBfeER/gIuQpIjD4BQ2cJJOugivvlmBYPxNN3J+NmK1UfzRCeFHqoyRV6gW
         IqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hP472i8tu0x2oWr2ZZdW3TiExRRKywLv6WAxBp0eH4=;
        b=lPyp4YY0ourIGa2WdPHs0fZ8K01k+beeKihj73uc6JsddbV/JhD2q1g9FtQ7eocEp/
         VKZYOp2BDlbHR0X211wkDYB3yeeHy10Qw+KSvgVrRHn+MbK94HBiQaosYg7ExuwmUq68
         TUkZrUPcUPSHCAyEBmh2BC9lIa5Wh1X/E6JIvAOKWaSW+CB1We6TFduz1uCQrOlVBMrp
         K8X5r45xGUpwabg5Fn43uKjAD3HSOaIDUvcRQtIfC5Z58J/DIrSxsFoBoUUr8oKfFX9K
         kMTI4G0XFczo900OjdK9SvJB6a6aVY0Hpz/GPgz+PIissfYZyAt1iiR89b6WiWwePRJ/
         wlMg==
X-Gm-Message-State: AOAM530DXd4ThamRkG49lazUvfFjdrASbcLSXqY0RAGFPvLaxh+hRrP6
        53epr8A5noNOHWi7Wvas+DKoCA==
X-Google-Smtp-Source: ABdhPJyGVQQN0GIEUbL3koaYY2sK4NeUkK5gEA8vO0yJRRxu3bib5xdQI2HlfpWuxUUBFFDAnKf5BA==
X-Received: by 2002:a17:90a:1a43:: with SMTP id 3mr9090485pjl.154.1621397760560;
        Tue, 18 May 2021 21:16:00 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id kk7sm2993954pjb.16.2021.05.18.21.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:16:00 -0700 (PDT)
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
Subject: [PATCH v2 2/4] perf arm-spe: Correct sample flags for dummy event
Date:   Wed, 19 May 2021 12:15:44 +0800
Message-Id: <20210519041546.1574961-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The dummy event is mainly used for mmap, the TIME sample is only needed
for per-cpu case so that the perf tool can rely on the correct timing
for parsing symbols.  And the CPU sample is useless for mmap.

The BRANCH_STACK sample bit will be always reset for the dummy event in
the function evsel__config(), so don't need to repeatedly reset it for
Arm SPE specific.

So this patch only enables TIME sample for per-cpu mmap.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 902e73a64184..4c916626c203 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -135,9 +135,10 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 
 	tracking_evsel->core.attr.freq = 0;
 	tracking_evsel->core.attr.sample_period = 1;
-	evsel__set_sample_bit(tracking_evsel, TIME);
-	evsel__set_sample_bit(tracking_evsel, CPU);
-	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
+
+	/* In per-cpu case, always need the time of mmap events etc */
+	if (!perf_cpu_map__empty(cpus))
+		evsel__set_sample_bit(tracking_evsel, TIME);
 
 	return 0;
 }
-- 
2.25.1

