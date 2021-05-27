Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D878BC4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1F06113E
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 10:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhE0KtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhE0KtA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 06:49:00 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC05C061760
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 03:47:27 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so84608qkd.14
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WO9CaFGqiJFMkbwzjeUNBHkoPWoyOI+XUu9S7NdEwwA=;
        b=wU3SwKlrpuWZIfHr8fLZMwogPujASUHhXs6Qe9xp/sv5KYzcDSSg0+afbNngMwC2EN
         MKY8LOgxt0ab45272HHA4EKg1apuUWJ9B7rPm+Ys0VUulN58qaDxbbY+HsqFPFywjbQ2
         eE4KlkKEH0vjGzBol/6luMI+73/EgaaL3j2jhZ8aVZrpqYM5lk+Muqui/kwruP0a3snf
         IrfAOe4GFcc7dDdyaIdo7eScuWkoW43Bep22BbcQq1903l7wqpMhMsXXvfhYO8GaprfP
         RQ3DTQv+zZFSpPuEv31y1R6O5AWrwGhlXX0LYTlaCfPo2PvNlUeidVpqYTxC/s+xxWyP
         WUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WO9CaFGqiJFMkbwzjeUNBHkoPWoyOI+XUu9S7NdEwwA=;
        b=WlsTuEqlXX3zjPGf+Gb5yTC72OWoTb6PoX/QxoC1u8qym0H0k8S6fe/N4iwATb8kqa
         Wp0JOuLtecvSSXxF3qAs5GiKjDQR/zAENJnQwXEcWbDjmbZH0CDpUoF5stbjcnVR9W8O
         85RBXHdszmxut9T7Dy9J1g9C6hLXdrJrBGQf2p6d5XGKF0gOUS+JvUMEMc89nzpozPy0
         85BUzrRnQxMxPrk5DO6gzLHzAMocnIsYb9RCqv/Qe4Q49K0LfngDAsiINgYu4+vhJ63A
         kEjC3Asr70lhvzHONr7BoBZHmwaJ/USsF2CwT7eWzLL2l4+M3GP625KkpTvHw8AbgZFB
         Ersw==
X-Gm-Message-State: AOAM532R/eBLKnHmIQsm4YQoGVG0M0CEdtO7Sayl2qbGymht+ZkRMaix
        qgL6+6FqjzEl8Zq+ac43gzZnfrbQ7Q==
X-Google-Smtp-Source: ABdhPJzhSuM/uxNdSl7Hjm/KorLANFa/2m687tbdKOv9YcnVbfIv/bF1fkNlrDI2V1RAIgTzLuRRiOUG6A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:74ba:ff42:8494:7f35])
 (user=elver job=sendgmr) by 2002:a05:6214:391:: with SMTP id
 l17mr2896057qvy.22.1622112446596; Thu, 27 May 2021 03:47:26 -0700 (PDT)
Date:   Thu, 27 May 2021 12:47:11 +0200
Message-Id: <20210527104711.2671610-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] perf: Fix data race between pin_count increment/decrement
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, dvyukov@google.com,
        syzbot+142c9018f5962db69c7e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

KCSAN reports a data race between increment and decrement of pin_count:

  write to 0xffff888237c2d4e0 of 4 bytes by task 15740 on cpu 1:
   find_get_context		kernel/events/core.c:4617
   __do_sys_perf_event_open	kernel/events/core.c:12097 [inline]
   __se_sys_perf_event_open	kernel/events/core.c:11933
   ...
  read to 0xffff888237c2d4e0 of 4 bytes by task 15743 on cpu 0:
   perf_unpin_context		kernel/events/core.c:1525 [inline]
   __do_sys_perf_event_open	kernel/events/core.c:12328 [inline]
   __se_sys_perf_event_open	kernel/events/core.c:11933
   ...

Because neither read-modify-write here is atomic, this can lead to one of the
operations being lost, resulting in an inconsistent pin_count. Fix it by adding
the missing locking in the CPU-event case.

Reported-by: syzbot+142c9018f5962db69c7e@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7e88d7..fe88d6eea3c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4609,7 +4609,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		ctx = &cpuctx->ctx;
 		get_ctx(ctx);
+		raw_spin_lock_irqsave(&ctx->lock, flags);
 		++ctx->pin_count;
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		return ctx;
 	}
-- 
2.31.1.818.g46aad6cb9e-goog

