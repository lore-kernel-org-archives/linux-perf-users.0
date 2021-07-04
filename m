Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C83C07E95
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBF661879
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGDHTq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhGDHTp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8DC061762
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t9so14926316pgn.4
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=HF78Ns2KJ94lBFHkqHHYvCYHD4XrlhN8LrnvJOs4SzJEbXQLwLgpWDt0zU6kv9thCu
         gdLazU3mmrvpTorsHnLibdESJswhC7Ied5jYBfhzPiW58xbfw5eAPfe1mVMpniRzfofV
         +J+ihmTl+sjPqr720iwqV6ZqP6s0SpNdLr3sGr1iz5fVo1rh3ib+OWocNyxehHC6ZL8t
         oquO+TcF2/bdRIX+rLF/ytpAptqJ7/eBCGJxFrTa0XwsX4tLt95P1Xd2bg1/jOn2osH2
         tSVXGkxAjKtOsk2uUj3BWHJt5y4nI42fVH36oP0b7Pnyt8+b+M5gqyaWIBA3vLVmE+30
         aHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=dgeRU53G4U5bBZ9jMNNSNHcAiKKj6RxK2RmfoUxFsKklD+QS2a7Q8DolbA0YvLztFB
         xlT4V/PvKfAVCv1Si9IyKB/TTEYycYX6ZR/uMC9Irj3EjY1OwnR9GYFRx65ZLpz5O6vk
         gNhfiPSXgtHPKizXOBITKQ5k/By0EMhn1Mk7wmXbYHJT09bODv+750Ij2f76e9N/nVcf
         5kyGanGsm6S1OXvczhj6exIUflsbpwgwzOmg9En8lTIHeNB58MFO1x04oQHIWV3MpsF+
         VEajyjArDF3uCYjQzM0nqZLg94AQliupM/PI99jOywKyaVnm/W2N+Bpfmri3qaUEf2LC
         okJw==
X-Gm-Message-State: AOAM5333HCqjzcLxTQUQm59qDi7wAf2zn3VMWhf1mPw8+4/za+MWLbLJ
        SS0nCIekUP8kzaXifQbvkDnTeo7OZQYS+w==
X-Google-Smtp-Source: ABdhPJxikogZ+NeiWmhynh68p62mZPKUnJOdPzdcYP2HqwkcqPAR8k719kBsv+JqyjlFHGxFOLDWGA==
X-Received: by 2002:a63:f515:: with SMTP id w21mr9167878pgh.343.1625383029524;
        Sun, 04 Jul 2021 00:17:09 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id d2sm9657731pgh.59.2021.07.04.00.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:09 -0700 (PDT)
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
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 01/10] perf/ring_buffer: Add comment for barriers on AUX ring buffer
Date:   Sun,  4 Jul 2021 15:16:35 +0800
Message-Id: <20210704071644.107397-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

AUX ring buffer applies almost the same barriers as perf ring buffer,
but there has an exception for ordering between writing the AUX trace
data and updating user_page::aux_head.

This patch adds comment for how to use the barriers on AUX ring buffer,
and gives comment to ask the drivers to flush the trace data into AUX
ring buffer prior to updating user_page::aux_head.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/ring_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..5cf6579be05e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -509,6 +509,15 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		perf_event_aux_event(handle->event, aux_head, size,
 				     handle->aux_flags);
 
+	/*
+	 * See perf_output_put_handle(), AUX ring buffer applies the same
+	 * barrier pairing as the perf ring buffer; except for B, since
+	 * AUX ring buffer is written by hardware trace, we cannot simply
+	 * use the generic memory barrier (like smp_wmb()) prior to update
+	 * user_page::aux_head, the hardware trace driver takes the
+	 * responsibility to ensure the trace data has been flushed into
+	 * the AUX buffer before calling perf_aux_output_end().
+	 */
 	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
 	if (rb_need_aux_wakeup(rb))
 		wakeup = true;
-- 
2.25.1

