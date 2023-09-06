Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0121BEE14AD
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Sep 2023 16:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbjIFQGe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242541AbjIFQG2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2023 12:06:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4B173A
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Sep 2023 09:06:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bee82fad0fso26228215ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Sep 2023 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694016366; x=1694621166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75Al5ao5WDqui4OmFiH4pa1bGdzkgKG2d24XEXDdpOo=;
        b=JlgeA7Dez1PBnk3Dux0cwGa9jjT3O021qBcCWlHBpZcV6A+n3HjiKVHm0JaBMHxJLz
         3w1xKauoNUzlheGOLfXSCEnXU6UqA8M+DcvdyJhxb0wi30mIfNycscbAR6D6z4S7YXsl
         ztJgnBABt5VbACwNmoFo9vuEopAruHxI6DBT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016366; x=1694621166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75Al5ao5WDqui4OmFiH4pa1bGdzkgKG2d24XEXDdpOo=;
        b=WfQArsOZixqZxfJwIDH1MPbf3hkf3DxQo/l4pEnyrG+OdVhO0SlT7Ml6oLzqLPlQqd
         gOMXSnWKfRDv1wGsehCxB9RRSo2/VYdtSLo2xcksv7lKb57/52UUSzYZjEd1YqtbR1c+
         PydbMvTr5zzWt9TcjVn63XEQlPT6z9bVMoHdfEtafPFkcskq0/dH6V7cbCRF7PTyNcpx
         83E2ANbf8YHn3TiIVLuOHsmbHjlaK0mmaw3DY/dRMwLRfc6q+Zd1t+5KheutTnNEHxLn
         aGynGbsuZAaX81SeBmX5GL6ebkdlqA7uEUdMmndwt6Qgepr+XTzwNqqTvKKmcf9mTX/6
         62fA==
X-Gm-Message-State: AOJu0YxY+BzC7JuUGK7LuYtB6lgVoB7u3KHr0g27/mwGBKzSEcUvCvJa
        Fh1yuawONfn4y7A8PWc2CfSB6Q==
X-Google-Smtp-Source: AGHT+IFaCX4dzk7MQ4n11lP2A0zTWCxziDQ4gl6uWPxHEa+/LvA96OgqNZMwWgUuk5iyV1hMWWWj0Q==
X-Received: by 2002:a17:902:c40a:b0:1c2:811:2cee with SMTP id k10-20020a170902c40a00b001c208112ceemr18484732plk.23.1694016365967;
        Wed, 06 Sep 2023 09:06:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4a07:e00a:fdae:750b])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001b8c689060dsm11338859plb.28.2023.09.06.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:06:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephen Boyd <swboyd@chromium.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: [PATCH v13 2/7] arm64: idle: Tag the arm64 idle functions as __cpuidle
Date:   Wed,  6 Sep 2023 09:02:57 -0700
Message-ID: <20230906090246.v13.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906160505.2431857-1-dianders@chromium.org>
References: <20230906160505.2431857-1-dianders@chromium.org>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
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

