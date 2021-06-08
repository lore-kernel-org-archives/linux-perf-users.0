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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57796C47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD5061185
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 16:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhFHQZo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhFHQZo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 12:25:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60DC061574;
        Tue,  8 Jun 2021 09:23:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r5so33080477lfr.5;
        Tue, 08 Jun 2021 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfFMl3am+sUPFNSf4fDjW2+vXmdiKfqC71c04UOJfps=;
        b=d7EaHTFLXzr5TtKAV7jeDuItdyTVd7ODZsLltz0PyXKF7VPAHxwFt8uGV58MmnnR/x
         rRzV6JJYLhrCUx/CNSgcsVpl6ec/doehFchqAkhwPjlEcXrajk1NbpgPUVi5HasAdLRM
         7g2TH5gtRVvVIC12avqXuRJfsHHDq6zoHBbBsfOjqOBbTobAhqz4yqLS34ZZY46rzYms
         YvUD6iWueIpbpS5eJoI965Wgl5J1RQ+VvjHN6kdUW6ov7BcY+AGi9jr5Lq/XKebSQvMt
         ppJFwa43t6QdRwLhiZyiTxldnT3hUcXQEl51mRMh9h6VEi9Tn2wJLx0Qx/vkaFAiNHxb
         tpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfFMl3am+sUPFNSf4fDjW2+vXmdiKfqC71c04UOJfps=;
        b=cQv85LxNgw4FAIPMtDlTGFt/j/cxhNE49xEfNHzUMGLlUsKf+Dsh5f/AvSOVtuFZVx
         Fwy5uFzTDpue02P5vqExegBXSC7b1Ih2Hc2g1/pwSzwpjaGYOBQ4mTiStNCLOPgU0z3Q
         VIY1RrfxtWcO9t/qYBvY4IUi5mrEubY3KRIjrbOOGxt0liMEYSCtQTSXgvqARSwYvSip
         vV8diUnoGgxdyaFb6gTeLXhstIdatuIhCYHZJ+tT+21O5pTQ6RSQw2OzdKjnl2Z0TP1v
         QytgHY0PcoVcIxY4pJDDfI08GDvLfEv6y7KgLwEX+RoZTlqqdLOv/WwBf+4oJwo1ELbI
         lV0g==
X-Gm-Message-State: AOAM530l68tp3+qZxDb4IUigya7AMu78IJx5yUH7edbR8+1iTXCoTGTw
        i+64aXHEyVYotqQgJ3BXYd8=
X-Google-Smtp-Source: ABdhPJxjT5X2T5QpFpMWB/5L1wgeYYbachqJPHrqKu3NHxDQuuZhLm5q9k1rzCCcOvmwAl3g5qyiLA==
X-Received: by 2002:a19:651b:: with SMTP id z27mr15487172lfb.43.1623169429115;
        Tue, 08 Jun 2021 09:23:49 -0700 (PDT)
Received: from localhost.localdomain ([94.103.224.40])
        by smtp.gmail.com with ESMTPSA id x83sm15760lff.125.2021.06.08.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:23:48 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] events: core: make perf_pmu_snapshot_aux static
Date:   Tue,  8 Jun 2021 19:22:53 +0300
Message-Id: <20210608162253.23351-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Sparse says:
  warning: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?

Since perf_pmu_snapshot_aux() is not used outside this file,
it can be made static

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7e88d7..0d98d6a6f949 100644
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
2.31.1

