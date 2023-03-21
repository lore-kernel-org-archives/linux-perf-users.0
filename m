Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CFFC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Mar 2023 11:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCULep (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCULeo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Mar 2023 07:34:44 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788393B0E7
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Mar 2023 04:34:40 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso9243958wmq.5
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Mar 2023 04:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679398479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QnNvCWsGq2WvGGRmBmUojC/qeGT+pq1QRxOE+2rM/U=;
        b=C9voZj3tOdyK9YAL1osivPi1yy+fu2u2hTSDARUSeUHgj9nz8fnRtPlcmoEPY9xskG
         TGvCRmz9UCIK9MdtTj3BO7ap/fV3u7O9owpvwdJEt5AJ/2z3srJOQUHD6Ad48+Yqo0gQ
         /e30L1tgGi9xjP/RrSVIO62ssjlgMECtYfwzDqcYkraKS9Ux1rKCS+fyuLQ0zNJQyOof
         jJRXnpUZLaLC9aVG65dCBOv5X5eqczMcYC94xu1cj2qyflnGvB68iGR1X/FxaDshODzW
         xMtKXbecHgX9z4TgqcyuUKoGytcA+gH64gn4ah1cYoqez16tkOTK8jH941tA8EdfM5i7
         t1ng==
X-Gm-Message-State: AO0yUKUTZwQDtc7oqDP84Ot+EincxX9QdPDdzbQ/hmmdsuiaOfsdCKWK
        47T9/ZcIQqO8eOtGUETOiG8=
X-Google-Smtp-Source: AK7set85/2VSEEhwvDd+YyBsF01LqZ0nl/6iLvFQMIMsA/JAQp0g0FtncRR1/ifLDl4WDFu14v10zw==
X-Received: by 2002:a05:600c:ad7:b0:3ed:4627:ed09 with SMTP id c23-20020a05600c0ad700b003ed4627ed09mr1961751wmr.28.1679398479042;
        Tue, 21 Mar 2023 04:34:39 -0700 (PDT)
Received: from localhost (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm11089459wrt.110.2023.03.21.04.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:34:38 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, sandipan.das@amd.com,
        thomas.lendacky@amd.com
Cc:     linux-perf-users@vger.kernel.org, x86@kernel.org, leit@fb.com
Subject: [PATCH] perf/x86/amd/core: always clear status for idx
Date:   Tue, 21 Mar 2023 04:33:38 -0700
Message-Id: <20230321113338.1669660-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The variable 'status' (which contains the unhandled overflow bits) is
not being properly masked in some cases, displaying the following
warning:

  WARNING: CPU: 156 PID: 475601 at arch/x86/events/amd/core.c:972 amd_pmu_v2_handle_irq+0x216/0x270

This seems to be happening because the loop is being continued before
the status bit being unset, in case x86_perf_event_set_period()
returns 0. This is also causing an inconsistency because the "handled"
counter is incremented, but the status bit is not cleaned.

Move the bit cleaning together above, together when the "handled"
counter is incremented.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/events/amd/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8c45b198b62f..bccea57dee81 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -923,6 +923,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		/* Event overflow */
 		handled++;
+		status &= ~mask;
 		perf_sample_data_init(&data, 0, hwc->last_period);
 
 		if (!x86_perf_event_set_period(event))
@@ -933,8 +934,6 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
-
-		status &= ~mask;
 	}
 
 	/*
-- 
2.34.1

