Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4C0C2B9F7
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 03:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89A86138C
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 May 2021 03:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhEZD1O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 23:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEZD1O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 23:27:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6EC061574;
        Tue, 25 May 2021 20:25:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c12so13594044pfl.3;
        Tue, 25 May 2021 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YoZUck6mACAcFeCLCeOjEWHKBtPQRIKZClOKQNYjnV8=;
        b=NQg9lJsdWkQlNt69XaB6VRnMQSBFOvlm9U/Mu3gumJFlXWi00/wrkcqodoms17ET4t
         EWT8TYN2opkKmeeRfoSAwO1Byj2dWIzwhORbCltlT46BV7o41g8PmRiSspIyYunhhaEK
         q8dX/TUL18wGrr9KPlocUad5i0LKBQ3A1tHIVDMPFLSA/T+P9P8dsLWaD2nhVyHaNoKp
         o4wYtaeNpVXozxnF+XNSITA3ABDjK05C3pTHyZQIEIEYTcnXKcAvwrk+dk/vvESe0TTW
         a7P0qaVmFfczk52jlcc3m0UZG3BwJkYs2amUyclxECN7T1wC2vh0wnT1Hwy8FQ7MzHLx
         Ezyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YoZUck6mACAcFeCLCeOjEWHKBtPQRIKZClOKQNYjnV8=;
        b=SDmXnWZMBqJG884q7u6R0RQspjHEGbMZXakicvofBOf+kD22DetutH4bne6wVKZGVV
         F75IUgyCiVdh7AfMtEGRj/Pc064M9mU9GYOYIA93X0IQvBpXq2+tkevSPpoO6Qn+5HPV
         1F5IvgAqA5hi4p0THdWFpDN9i2CHmhkxXy2XKEnf1763td52UVPmoxWtHnG++G2vgikc
         6djdhgRJkyQyOGHr0iaKBFFnB2ayIc1EZ8KSCH4k+esbl98BUyrRfzONg9CRmkC4LO1N
         bmQMVKexawmf5uY1uAeyXAy6YzvPv3nI2gd+nR5bbQsDLM7cYLBaY5TGo+sypZcuRao9
         uwGA==
X-Gm-Message-State: AOAM533DVPEv/uL3UgjYxQBoOnkIbfuHSuI8oLgOszRh/J4yKpGna5wk
        GuArl7aHy91G4LnMldQsXTe7myyGQn2ogA==
X-Google-Smtp-Source: ABdhPJyL8FX9RtAiLvygAG1nAIBG5IreWjv8N0bqibFr2ZHmLnKtyCUHebH+aPoxgTuUMROiMbwCeg==
X-Received: by 2002:a05:6a00:22c1:b029:2dc:edbe:5e9 with SMTP id f1-20020a056a0022c1b02902dcedbe05e9mr33462045pfj.51.1621999543297;
        Tue, 25 May 2021 20:25:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id m2sm15340128pgu.85.2021.05.25.20.25.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 20:25:42 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: [PATCH] perf core:  Make local function perf_pmu_snapshot_aux() static
Date:   Wed, 26 May 2021 11:25:26 +0800
Message-Id: <20210526032526.17660-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fixes the following W=1 kernel build warning:
  kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7..0d98d6a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6667,7 +6667,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	return data->aux_size;
 }
 
-long perf_pmu_snapshot_aux(struct perf_buffer *rb,
+static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
 			   struct perf_event *event,
 			   struct perf_output_handle *handle,
 			   unsigned long size)
-- 
2.9.5

