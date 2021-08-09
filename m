Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D6C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FCD61078
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 11:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhHILPx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhHILPq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 07:15:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F1AC06179C
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Aug 2021 04:15:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so15919954plk.13
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Aug 2021 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZ/7kJOb7OY5ptxZfvGqxtGsWJ55PVJlZ2QX0AXu9A8=;
        b=kdAvEdB/yldBJNpXv5zSGItPMdpNTknsNOOyo0nT3IXC0awSQfbwp3stGSyCdLu+Cd
         1fd3XlStrOjWcpdWlPsk6NDyWhQIuNZ6FXksrIU6j7OUC6VxgdValWi4EgDf7XADTkGF
         eSxGJeQSdkb+GRbB2RGvnkreGGGxwEAXzByw4hiR2lfXtK8sWlYyJbODOSQ8/G1Ci5XX
         OFT+JoHYBZQvVMf9pBCZ7ynIQp/i5HgrpBFSATop8yU3dmejoFw+r4l2T3i5NIJgWrRM
         zDt+pLk5D/im4eR0A29vyYPoOPmV3nXiFANUjZoQoaqaDyDNortvkJq8pdgFP0DW6HB7
         Z3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZ/7kJOb7OY5ptxZfvGqxtGsWJ55PVJlZ2QX0AXu9A8=;
        b=s5TaeyZ7uZIGVGS5tjaeN5OGMaqVk+Jv+3NkMKvXHBn0KtMVb+aZzzVUaNO1Oxy5ND
         sb4XpCuFNQkGLHHKxrHhoFoJZlXyS+8K9DqkDSd/OkHu/pkP2at4bpkHTshJJMt3dAqo
         8oIBKLZJZjksDQcD5lql98vwl5w3C6lwtMZkO1OM1O1jkFhUjdJTUDUdiAOcbrX6aEI3
         PH+FU1qI6TH80DH73Y+3vodEgqhNSsTqMZ0/gXM12MjYpCMQPgR/GGdrbHyYZ/wr/kOK
         QM6lk4FsnZsyLO7mn9P9mHavdpBYVDYva1QnNgUe5o45zpf366qLJzFM2rdj4ZG4VTX5
         mvzw==
X-Gm-Message-State: AOAM530MFvcMqZI1I8aYokRsS67HkfdqKXQADbeoomC6vcS1iV5Jx5HD
        GxHiT+Ky0Mnhumqx7FPcLgaakQ==
X-Google-Smtp-Source: ABdhPJw30uCIZl48Vo0v+CpxJamxTo4LAr6gws5su6sX5H9i6/3icWWjZ6QV5LRtx5/+c2IHKMe9jw==
X-Received: by 2002:a17:90b:4a90:: with SMTP id lp16mr24619127pjb.74.1628507725704;
        Mon, 09 Aug 2021 04:15:25 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id a21sm20504697pfi.15.2021.08.09.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:15:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 3/9] coresight: tmc-etf: Add comment for store ordering
Date:   Mon,  9 Aug 2021 19:14:01 +0800
Message-Id: <20210809111407.596077-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809111407.596077-1-leo.yan@linaro.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the function CS_LOCK() has contained memory barrier mb(), it
ensures the visibility of the AUX trace data before updating the
aux_head, thus it's needless to add any explicit barrier anymore.

Add comment to make clear for the barrier usage for ETF.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index cd0fb7bfba68..8debd4f40f06 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -553,6 +553,11 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (buf->snapshot)
 		handle->head += to_read;
 
+	/*
+	 * CS_LOCK() contains mb() so it can ensure visibility of the AUX trace
+	 * data before the aux_head is updated via perf_aux_output_end(), which
+	 * is expected by the perf ring buffer.
+	 */
 	CS_LOCK(drvdata->base);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.25.1

