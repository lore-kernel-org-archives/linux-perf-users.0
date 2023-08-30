Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B7C83F16
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 20:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjH3UHa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbjH3UHT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 16:07:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED7B971
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:53:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d7766072ba4so1690885276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693425117; x=1694029917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcYgzJmdMLPe2IlWA1yPnnbUqn3VnbnF5Y/j/01p/cw=;
        b=MAH1KJ7ofn8icSqyc9lDBhANHoHZsgHuPugXwdqxhPN+ar+ClbH0aKw+VWiyROjAk9
         8lw4TqqupxF48LHhuYWtwX+BTk+1JCFTqv7Ro6KdnqQzFNhriSV5BjhhcFB5B1EnIpok
         FzBATbkVz7FiyGGbaZ6bXtjoIapyTLVWGccfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693425117; x=1694029917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcYgzJmdMLPe2IlWA1yPnnbUqn3VnbnF5Y/j/01p/cw=;
        b=IyXGzUANHe9tqpWvIcHyHpgCBwQuVbF3RKEhOmo0HNqLhpVllUkMvXmYXdhWMBuYs2
         /03MrTS6LQzecYZCI2uis/+p4IRakKo/jmPWKwoaTVB0bbYwVY45NG9mBcyNZKe2K6Ia
         Pgvk5r2IhYiCcm+RnXuLx5HBmK49cC6i+4at2f86OHL/+4w64gNwJLZrOIlNfOXqkDjY
         4GYYG0XTn2BEkxQNFJWX/mDlEWvLhYiG0AUYb7AYiXwNnEm1nhZXuLCMll9RBxI03PUo
         NAPYEDAEXw296Tx6sBbWvXouyAcf0qhS84P37nvOXOtaOttaaTD0/cNPxNQnu/0CqLk7
         DWsA==
X-Gm-Message-State: AOJu0YwDW/B6ieQXQPa1a9HlWvCzbQTJkoumqE4g7tkkAB9jK54iR6/7
        d+ME5ICNBveqMhRaVFqTEVGt8a6TJ21HgQu9H278AY9f
X-Google-Smtp-Source: AGHT+IG6twoQxbusQyqNYajt9MUxkEGt9m+q9o/FOJcMdRNJj/VNJrOH6rag6dueRkF1UgSa1G+MZQ==
X-Received: by 2002:a17:903:2448:b0:1bc:7312:78e2 with SMTP id l8-20020a170903244800b001bc731278e2mr835918pls.5.1693422820749;
        Wed, 30 Aug 2023 12:13:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e315:dec6:467c:83c5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bbdf32f011sm11338928plg.269.2023.08.30.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/7] arm64: idle: Tag the arm64 idle functions as __cpuidle
Date:   Wed, 30 Aug 2023 12:11:23 -0700
Message-ID: <20230830121115.v12.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
References: <20230830191314.1618136-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As per the (somewhat recent) comment before the definition of
`__cpuidle`, the tag is like `noinstr` but also marks a function so it
can be identified by cpu_in_idle(). Let's add these markings to arm64
cpuidle functions

With this change we get useful backtraces like:

  NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98

instead of useless backtraces when dumping all processors using
nmi_cpu_backtrace().

NOTE: this patch won't make cpu_in_idle() work perfectly for arm64,
but it doesn't hurt and does catch some cases. Specifically an example
that wasn't caught in my testing looked like this:

 gic_cpu_sys_reg_init+0x1f8/0x314
 gic_cpu_pm_notifier+0x40/0x78
 raw_notifier_call_chain+0x5c/0x134
 cpu_pm_notify+0x38/0x64
 cpu_pm_exit+0x20/0x2c
 psci_enter_idle_state+0x48/0x70
 cpuidle_enter_state+0xb8/0x260
 cpuidle_enter+0x44/0x5c
 do_idle+0x188/0x30c

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v11)

Changes in v11:
- Updated commit message as per Stephen.

Changes in v9:
- Added to commit message that this doesn't catch all cases.

Changes in v8:
- "Tag the arm64 idle functions as __cpuidle" new for v8

 arch/arm64/kernel/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
index c1125753fe9b..05cfb347ec26 100644
--- a/arch/arm64/kernel/idle.c
+++ b/arch/arm64/kernel/idle.c
@@ -20,7 +20,7 @@
  *	ensure that interrupts are not masked at the PMR (because the core will
  *	not wake up if we block the wake up signal in the interrupt controller).
  */
-void noinstr cpu_do_idle(void)
+void __cpuidle cpu_do_idle(void)
 {
 	struct arm_cpuidle_irq_context context;
 
@@ -35,7 +35,7 @@ void noinstr cpu_do_idle(void)
 /*
  * This is our default idle handler.
  */
-void noinstr arch_cpu_idle(void)
+void __cpuidle arch_cpu_idle(void)
 {
 	/*
 	 * This should do all the clock switching and wait for interrupt
-- 
2.42.0.283.g2d96d420d3-goog

