Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042CC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CD361244
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhESHVS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbhESHVR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 03:21:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D8EC061760
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so9286649pfl.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xZ1JYU86x9GDV6Fl4hcG6dEfcPMAOex7K5iW9hqWQM=;
        b=U6+8lJ4Pk8JtHFn8B024BbgRWRFCyCrkDS0Bgs8PLztCnYHkfhatiRfpMWjiupEcbw
         VWSNho5nhCcuqMwrsP3+97N0oCgO55Nmt9yrooRm4khn+AUa3GHRIjgyiBb2HydObi5r
         XIHkFtW9YXZ5hnqV2qWhjy4xCiLqtuApq30qrKI/iTn3QKnFythlXlyLKSxmp1bDGo7T
         WtNKIDrIo8g07o2/M9A+4syHOxP1NtVEXlxz6HhKP5UsXaeIfLmFTQhqZsMzypzsNwiu
         P7nXmkz2Be/mo70TN1OXu6sk4r2j0maJDqHoNViETayhTVyJSMF/QEOc2GaK+ufAGk+L
         6NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xZ1JYU86x9GDV6Fl4hcG6dEfcPMAOex7K5iW9hqWQM=;
        b=tt0Bt5PDxyuko4DZ8iaLK6iAtrQlFkRTCw0FISCTnP7LXPtPeGQkV8moAhsHwMaiF7
         TXVhl83YARnobI68DDtlsvneG/FmsaUIhDAJ21I1WYcZ8svK5LLAeHBxO0LwQSlvqTXl
         prHL6dWGaFBqqiW9mlwslODTwz41NbvlfmaMzOlSQOnvvwM/IgpiGo3QgHQiOs33ou7i
         8lrjFNrxa+/PAedWxfq1RABwR4TI5yBAYHSgUtqoSZk/YyftkXohoNHu0DsVJrJHdN1C
         YXCRpYqk7N+h9P06/i4PnlB5TkLenFn9HCYe3zIStQp/TWt9z3OQ1pZ7oVS6ME3/fXB9
         B3vw==
X-Gm-Message-State: AOAM53384Onc/c/ziCQv+AIsB6Y3oOhV/T1i10IEavcq5jBbEdxWVRHZ
        99Zzr2aFxSMAKX1IUVDTYbtujYqQ7Pynoi1sUS0=
X-Google-Smtp-Source: ABdhPJxXKjh4+Y0yqeqxJSJMdI5LxN2W4oL2rsmllBC4cnpR8GGbCdPaAXDKugAwhd//EA1cw4x5eA==
X-Received: by 2002:a62:3101:0:b029:2de:4f8d:2ca0 with SMTP id x1-20020a6231010000b02902de4f8d2ca0mr7454623pfx.65.1621408797702;
        Wed, 19 May 2021 00:19:57 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id r22sm14267134pgr.1.2021.05.19.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:57 -0700 (PDT)
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
Subject: [PATCH v5 3/5] perf arm-spe: Assign kernel time to synthesized event
Date:   Wed, 19 May 2021 15:19:37 +0800
Message-Id: <20210519071939.1598923-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In current code, it assigns the arch timer counter to the synthesized
samples Arm SPE trace, thus the samples don't contain the kernel time
but only contain the raw counter value.

To fix the issue, this patch converts the timer counter to kernel time
and assigns it to sample timestamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index ff8b52e6d475..da379328442c 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -234,7 +234,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	struct arm_spe_record *record = &speq->decoder->record;
 
 	if (!spe->timeless_decoding)
-		sample->time = speq->timestamp;
+		sample->time = tsc_to_perf_time(record->timestamp, &spe->tc);
 
 	sample->ip = record->from_ip;
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
-- 
2.25.1

