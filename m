Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964D9C77B75
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 22:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjDSW5i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjDSW5U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2412D4A
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2472dc49239so255665a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945035; x=1684537035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAvgM/34n0JSYhh4m4RBiwXsllZsYs4Vm4Z5FlxDAmU=;
        b=na1XodKzWaW2Z6wPGGKRe2iz49sCLIx47dGIaumaf/glZ+STubFDyQ2ys5ORZkrctf
         OB6zllbubw5lW84ZgxLPkfIlj8eehdM7wa7uzlUOFC6PZ4MtmJu0+GNyytMFGKPRxPpc
         brH7JrALzbYRHB7bOwxZCAaopLhqvJNyA7mI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945035; x=1684537035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAvgM/34n0JSYhh4m4RBiwXsllZsYs4Vm4Z5FlxDAmU=;
        b=j0kS3nrb+UH6yMvWPruu4kEG0K/iignYZHBDYjeP+1mleTCtxqYs2KjSRAsjhso3vR
         QAqgR7uXR03+2IXHoopghJ0QYa2mzSadYs5r/z5tgENVriqe5497M1bLo9JAKkq9Q9Yh
         G6sVRiQ4P0KCKXN+XuIwAy6fNnY7pZ/n3H8VREHbyU3uRykzW2xwDfEJIlwjdsJtLcWS
         ruDr20fcPYXfD2jEXOVlDyEODca+Fj4+ny1KE4YmGPQ4Zab3G3XrKDqB9+DZYvaVDAS3
         Vf9N7+aHmlV6/zYhP2BdQ1zr0tLMIdTwUf8NCd8uTEHhll0hHVvaPYuGH2CeQx1HoWdZ
         6tDw==
X-Gm-Message-State: AAQBX9cT6bS3cqtgWSGMlRzJR0/ulAZvHb6o9Cu3G3YqbbDq4f+WEQF4
        +9yOb8ZoAG2TnGFlaV4DQI9l0Q==
X-Google-Smtp-Source: AKy350bskGi3gG2BFNjKoT98Z8InQIICEe7cMAmD5y5HyxnPAhqsWk+2bK2ye8CnL2CNs3knUxa76Q==
X-Received: by 2002:a17:90a:4142:b0:247:19c5:aa3d with SMTP id m2-20020a17090a414200b0024719c5aa3dmr4050436pjg.36.1681945035028;
        Wed, 19 Apr 2023 15:57:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/10] arm64: idle: Tag the arm64 idle functions as __cpuidle
Date:   Wed, 19 Apr 2023 15:56:00 -0700
Message-ID: <20230419155341.v8.6.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As per the (somewhat recent) comment before the definition of
`__cpuidle`, the tag is like `noinstr` but also marks a function so it
can be identified by cpu_in_idle(). Let'a add this.

After doing this then when we dump stack traces of all processors
using nmi_cpu_backtrace() then instead of getting useless backtraces
we get things like:

  NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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
2.40.0.634.g4ca3ef3211-goog

