Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03115C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CA961353
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhESHVd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 03:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbhESHVY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 03:21:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AAC06138A
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:20:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q15so8797146pgg.12
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Chi1IofC1LVT5Y+rvN1rFC7UBLdb7aCrIZYrC4aASeE=;
        b=yddoojxF7uDWUZxGOObcD+IlaNc0Vem+McpvUNJ2n8STiIA4foAtRSyH8S9KUwPZoL
         1gUIlCXqAMOix/+Y7tC0ugzNucy0olkHIEBWFGXlw+Gl5Q7NiR4BuEmpjJYXixc6BjWX
         5EhXx6M4e+0i16NhYRfgN1IxfjFwZL9KZyUpVqE9/Zk4btLAPhZ7/C/87x3MwhznE4jX
         +1uZgRKHYei6bbA+TZZs5FQJ7fguXPlmy5XeiDhy6BLEXMcG3/Z5EAshSElmYfDpFqed
         mXj5BwK86pxLbJGCUcvexKME+VMwvAuoCtrA7uiYy2a6xCs5s3Hxzm0701ZniCICa7BF
         /qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Chi1IofC1LVT5Y+rvN1rFC7UBLdb7aCrIZYrC4aASeE=;
        b=YbYofM5yqi3b3KRtuTRgSTDGqeHbCEi04Ub8IPsZ/4/LjJIvi90fUInsLTyvkt/0Ew
         jacGfeFViE5fKolBqC3dyQOZz50CQWfPbYYJbsvBnGdewd4l6usK5NSZ0UXcH9hXN6rY
         L68mcm4DwuiSldZiGJXhjYcKX+ASpuVAZA1uf1x+MKWbIWHi05O5qPogw/AnEsEKD7r2
         yZCIvCVLuHFhc67RR+jUZFgNmFfrZ8SyVOGc1HlmbW11jyakw85WyST7uTElhcBxp8Lg
         wm0AzwYLp2gsDOcYiOKr6FX/leUfK7MeMsqRzgxDSGCd2StQiuvqtBG9XQrnZVdg/ZqJ
         XPGg==
X-Gm-Message-State: AOAM530MNQUHN4bcWgOTNNh93ra3/PtXwqD3J2aH8TyQgKgZ3XBtZjrb
        SxLzDfD/mIAyk59zh5qUTjPR0LwA1w2QayFq+YE=
X-Google-Smtp-Source: ABdhPJyTH2gc1bFlj5R2BhX7fJGAX8sT+U1KvjUgM9c8MPmMkLckOB8aCI0UxWShd2iT49crzw0oyA==
X-Received: by 2002:a63:4648:: with SMTP id v8mr9458082pgk.34.1621408804623;
        Wed, 19 May 2021 00:20:04 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id y14sm12448747pgl.21.2021.05.19.00.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:20:04 -0700 (PDT)
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
Subject: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT event
Date:   Wed, 19 May 2021 15:19:39 +0800
Message-Id: <20210519071939.1598923-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
perf event) for processing trace data, which is needless and even might
cause logic error, e.g. it might fail to correlate perf events with Arm
SPE events correctly.

So this patch removes the condition checking for PERF_RECORD_EXIT event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 5c5b438584c4..58b7069c5a5f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -717,11 +717,7 @@ static int arm_spe_process_event(struct perf_session *session,
 					sample->time);
 		}
 	} else if (timestamp) {
-		if (event->header.type == PERF_RECORD_EXIT) {
-			err = arm_spe_process_queues(spe, timestamp);
-			if (err)
-				return err;
-		}
+		err = arm_spe_process_queues(spe, timestamp);
 	}
 
 	return err;
-- 
2.25.1

