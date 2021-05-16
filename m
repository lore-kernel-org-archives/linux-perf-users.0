Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52046C433B4
	for <linux-perf-users@archiver.kernel.org>; Sun, 16 May 2021 08:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191AD61104
	for <linux-perf-users@archiver.kernel.org>; Sun, 16 May 2021 08:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhEPIKk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 16 May 2021 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhEPIKk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 16 May 2021 04:10:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7CC061573;
        Sun, 16 May 2021 01:09:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a2so4281867lfc.9;
        Sun, 16 May 2021 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vLdi6RJTuoNrFStZDPaeBxFOgBJE/iOLGsGfKwwiURo=;
        b=fMHLkODsg3TGJisYfnSYl8iZQY8t33pCohE+muLfxWvmzWDEU5f1bHCXKHtnxhLdph
         OsRYqLXjbVldY1u+gcJ3/2vLFwQtit1h4BvXXXQDZypdDJHoHRbLHx2JYIgxB9C5686i
         8HoiJXRgTtoScOPrbR0FT9a8rjVfSWRx4ISD4rsO8lSMDwsoN34BjXsufssadQ8vjlCo
         3W3a90zVrvUdgWvar8gQPqrICUIm1UGTqGhfY8AVoyso7D9HMJ0qrw0IksaCrf74aaEt
         MLvyhZbkxD7YkkSTyc0+mckDue2SCkkQpZuk7irpbVK+qAFhP2XiC5AzAtV3KcyYXXoY
         cSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vLdi6RJTuoNrFStZDPaeBxFOgBJE/iOLGsGfKwwiURo=;
        b=ioEsUfd2xexYKtFz21vhNJrZYzbq9887MwN5S2tr/4pZs0KYVENwC8O8n1rn+qcig0
         xlj43K79YTwl6VT8CWCYnVTAZDHP10N9RRJQ4MqBcZarHKX98YaWDkP8CoTpnMd/ncyR
         GsSfX2h5LFr4ZTWr6Qwb5WYJ0P+Z5p3iKTPWv9Dt/uVCX3sO/2vmIuoRAyuNGJ7PGruv
         aEmdk4ZuhbdFMyNahqLFOa8aBx3QYD/T/uMsHk2zqQ79AQhHoNgcPOF7hzt5nHCYs8ff
         m6r52/FzAzwvURLrGhhLBJp2NYhuiincYjQ94E75Dju4gFhmOKcjkKJ3mKYGZgdF+srd
         dP0w==
X-Gm-Message-State: AOAM532FJfb8blGGH9lvY8JsAvH1jZhgqNiFGNMJmqpZGyL5lGDDqrLX
        XVmjPAFArmvWaRyX4PKqALM=
X-Google-Smtp-Source: ABdhPJwIO3r51PnUQg6Y+hcj+CR9r/NLqDCDiv88zAp9Gd1/ypjsKfESNoWUTTeI/J9aScKSnWciiQ==
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr3926154lfr.295.1621152562205;
        Sun, 16 May 2021 01:09:22 -0700 (PDT)
Received: from [0.0.0.0] ([2a00:b700:2::4:1d2])
        by smtp.gmail.com with ESMTPSA id j195sm1617373lfj.120.2021.05.16.01.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 01:09:21 -0700 (PDT)
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        src.res.211@gmail.com
From:   Haowen Hu <src.res.211@gmail.com>
Subject: [PATCH] perf/x86: Improve code format
Message-ID: <523745bf-c399-dc2e-ac57-1d580254802a@gmail.com>
Date:   Sun, 16 May 2021 16:08:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reformatted several lines of code, in order to satisfy the kernel code
format.

Signed-off-by: Haowen Hu <src.res.211@gmail.com>
---
  arch/x86/events/core.c | 2 +-
  arch/x86/events/rapl.c | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8e509325c2c3..8cd61beb97e7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2829,7 +2829,7 @@ perf_callchain_user32(struct pt_regs *regs, struct 
perf_callchain_entry_ctx *ent
  static inline int
  perf_callchain_user32(struct pt_regs *regs, struct 
perf_callchain_entry_ctx *entry)
  {
-    return 0;
+    return 0;
  }
  #endif

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 84a1042c3b01..da43975d9929 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -131,7 +131,7 @@ struct rapl_model {
      enum rapl_unit_quirk    unit_quirk;
  };

- /* 1/2^hw_unit Joule */
+/* 1/2^hw_unit Joule */
  static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
  static struct rapl_pmus *rapl_pmus;
  static cpumask_t rapl_cpu_mask;
@@ -209,7 +209,7 @@ static u64 rapl_event_update(struct perf_event *event)

  static void rapl_start_hrtimer(struct rapl_pmu *pmu)
  {
-       hrtimer_start(&pmu->hrtimer, pmu->timer_interval,
+    hrtimer_start(&pmu->hrtimer, pmu->timer_interval,
               HRTIMER_MODE_REL_PINNED);
  }

-- 
2.25.1

