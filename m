Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C6C07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6995D61205
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhGKKoG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhGKKoG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003EC0613DD
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso8742255pjp.2
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=RtX0qI4MGvgBvDGGTerEq7GxtH+wniuNEW7utX4Sj0O4q4Q26d6jcMwwestxzCiHzf
         QNREUyk2x12NqOorPsbS3FoidmVIpuT/X9x1hAaaDwk5vvIg5bJeUN/xIvP+5jXZxRNx
         u/oWY3EUWzmjc8kBz9+LguNLGpCx88gDP2zAl34xnTCTXim7dSVTNN4jzMPHY5CZfNP3
         rQ+MsT5YTP5b2k71mOiwnmQObvk5ATNEF1tVHNUWlJA56zt5qd8az7VglCncXoOBA7Zf
         bgX5cPJFk47D0smGeeKZxFnYCvrVO30Dz7ypy3OlOpHsT0reQULiqgBvOOWyCoycLp+D
         xZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUfdU9WBYmi8/NBmndyLWLFFhQ6mqBUwjCh/GuP5qb8=;
        b=l43tzLdqk80PzYIt6grC/mQo1n4KW+VUaF4bpy0fDNggn/EtdAUKO/TMbyhkzZ8WSU
         QmN39f5fQtyrFVFgCmSrXICS+1AsH7mo5V5aJLdep78BohU5GD07dNP8i0grLWwlJFgH
         hvGL1rs6VLxEV0vFvSEEr+I4z+0BshHTn/PjzEfDkHjWlaPJZgH81SH0unNqn7XcE+JW
         K0X7yN4IhvacIe3wWMa+R9HQ+DVuFvFr+GSilvLwRX8E1ArtjHTuQcVObwXmZJUOeaKm
         x/e5okfDmOMVCwKn1mcei4xLZC/F/AbHE5sMsstNxuuW4faVphTVwbGmPYI8nNM4dZEk
         zV8w==
X-Gm-Message-State: AOAM531lRmjqCT50qASoORzCZosczdOQrpRg9S+ycWi4nK1xG8lPeSt7
        6l6fXmxYzxFVph71HvBaEaCnuw==
X-Google-Smtp-Source: ABdhPJyQ8XxCLn1vu+B0STHNwIFTAWH9uvWnYEj6A61rhx5yfvxHRMAmDfZWPGYHsUsY0F9uNVDSvg==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr48277859pjo.108.1626000079190;
        Sun, 11 Jul 2021 03:41:19 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id t2sm16735752pjq.0.2021.07.11.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:18 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 01/11] perf/ring_buffer: Add comment for barriers on AUX ring buffer
Date:   Sun, 11 Jul 2021 18:40:55 +0800
Message-Id: <20210711104105.505728-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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

