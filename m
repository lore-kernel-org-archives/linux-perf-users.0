Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A67C43460
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928A061040
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 07:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbhESHVa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 03:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbhESHVV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 03:21:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85517C0613ED
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:20:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t4so6507408plc.6
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HLKjHZhIBhBalvzJERpkXJjZoyK1pVa98izDi+oudk=;
        b=Vkb+RSaUrncycku51JjTfgxLWD7nfn6WVa6dnXFVlRc74kyKIsfINKlbTgbq256PWp
         Xsj9U3hJ5opMGPGZyEtzd8Bif1lcZTboOpUU1GS8y/MgpmIf8V911M8bXWmyx22/uhCS
         TsRZyGqvKi8R5v9k+M5c9JstE3JNKNqEO5L9S2We+SBVj3BSDflGkJutXB5abXXou0x5
         k0XAc+zbBnU9mnht3JK3Hs9c+2gaMJ7ElgF/3kOPedn7JLSNrbx/NbOPMwb9Gv1k0oTp
         PNgUeK1bniNUReh5BNWriTbCmgCC/IjG6k4gGfk22JStaDVbd4LYZjSFWYUNY9vmVj/A
         AnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HLKjHZhIBhBalvzJERpkXJjZoyK1pVa98izDi+oudk=;
        b=PvL/rNHd38sVbLpPLDp+qvwM96JsS9OnlCwHFFpJhr2Lqh5b2Gr39mCgtAS/N5H9Hw
         3ehL7JSYkZScAhrJEEUnfDUuQDSH90PIOpskRFo+t7zgkFTA9QaibP0OIqrPfSs1OHQ/
         a63Qb6+8fymyK1Qn4gLsA2hcFM755tjPVEqi0jY7igKDhNVO6EgqKgyWgoiLIWaJMHZZ
         RLXIpqEt0TLkp58uL7GHvIufPmtY0p6k/FX2AoRj0wIOlrZ1SXpUaeEs8K2ysR/IlPMb
         h9U8JZHF2o8m1ufe+XG5SJIdgKtdj1Y/QsvV9BvMRdq7qvFAyaRUeIR6wXlfJlq+Tjav
         V8TA==
X-Gm-Message-State: AOAM531jczkm/zjAX3HIbXGxhN7mb3OWDlJYzHNbnXuVa3zzROlR6yDK
        IpcO0CON09dFpbI3HwiFztslNw==
X-Google-Smtp-Source: ABdhPJxH+FfhS7v/rIT7/nAN95pSske5ns6xd6dL4Q3aqHkMFXtGGucbz/fuBv4oMzZJHlAhsKJdzw==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr9874044pjb.93.1621408801073;
        Wed, 19 May 2021 00:20:01 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id ch24sm3692712pjb.18.2021.05.19.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:20:00 -0700 (PDT)
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
Subject: [PATCH v5 4/5] perf arm-spe: Bail out if the trace is later than perf event
Date:   Wed, 19 May 2021 15:19:38 +0800
Message-Id: <20210519071939.1598923-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's possible that record in Arm SPE trace is later than perf event and
vice versa.  This asks to correlate the perf events and Arm SPE
synthesized events to be processed in the manner of correct timing.

To achieve the time ordering, this patch reverses the flow, it firstly
calls arm_spe_sample() and then calls arm_spe_decode().  By comparing
the timestamp value and detect the perf event is coming earlier than Arm
SPE trace data, it bails out from the decoding loop, the last record is
pushed into auxtrace stack and is deferred to generate sample.  To track
the timestamp, everytime it updates timestamp for the latest record.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index da379328442c..5c5b438584c4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -434,12 +434,36 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 {
 	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record;
 	int ret;
 
 	if (!spe->kernel_start)
 		spe->kernel_start = machine__kernel_start(spe->machine);
 
 	while (1) {
+		/*
+		 * The usual logic is firstly to decode the packets, and then
+		 * based the record to synthesize sample; but here the flow is
+		 * reversed: it calls arm_spe_sample() for synthesizing samples
+		 * prior to arm_spe_decode().
+		 *
+		 * Two reasons for this code logic:
+		 * 1. Firstly, when setup queue in arm_spe__setup_queue(), it
+		 * has decoded trace data and generated a record, but the record
+		 * is left to generate sample until run to here, so it's correct
+		 * to synthesize sample for the left record.
+		 * 2. After decoding trace data, it needs to compare the record
+		 * timestamp with the coming perf event, if the record timestamp
+		 * is later than the perf event, it needs bail out and pushs the
+		 * record into auxtrace heap, thus the record can be deferred to
+		 * synthesize sample until run to here at the next time; so this
+		 * can correlate samples between Arm SPE trace data and other
+		 * perf events with correct time ordering.
+		 */
+		ret = arm_spe_sample(speq);
+		if (ret)
+			return ret;
+
 		ret = arm_spe_decode(speq->decoder);
 		if (!ret) {
 			pr_debug("No data or all data has been processed.\n");
@@ -453,10 +477,17 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		if (ret < 0)
 			continue;
 
-		ret = arm_spe_sample(speq);
-		if (ret)
-			return ret;
+		record = &speq->decoder->record;
 
+		/* Update timestamp for the last record */
+		if (record->timestamp > speq->timestamp)
+			speq->timestamp = record->timestamp;
+
+		/*
+		 * If the timestamp of the queue is later than timestamp of the
+		 * coming perf event, bail out so can allow the perf event to
+		 * be processed ahead.
+		 */
 		if (!spe->timeless_decoding && speq->timestamp >= *timestamp) {
 			*timestamp = speq->timestamp;
 			return 0;
-- 
2.25.1

