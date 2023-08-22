Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC11EE49B1
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjHVVau (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 17:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHVVat (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 17:30:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA89E42
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 14:30:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbff6b2679so32408825ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692739848; x=1693344648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRXZdprKPZs0xk/TIH25QXtGg9YiAlfKIIpohS5vrjQ=;
        b=VC9hZKzbdMPhWPoT/CJpgKx+lHz3MuRKi7xqq07FBHgIMAV6jdjAsGxc2oPCq5LdiD
         FT9TBosfHaLzOnTftw1blVl3kZEL5lLkpIenrJsSd4HqMrukFEHtIYNNkoT19AyNPYqZ
         XWLrShyvPU7jO3ZGVV82MhHq4fTZ7rwjwD5kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739848; x=1693344648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRXZdprKPZs0xk/TIH25QXtGg9YiAlfKIIpohS5vrjQ=;
        b=ksMxMqnSvLsZYkV2biap1p9DkDsW/FaFbOTD4X/BRW/TGV+vNgtpZ50CmrNecuRAzz
         Ee/MRpsY01qFzghbke/8BiY22tCml+E4p31zewkDj1FB3DcvWgD0a1OCr/JN1CvR1rMq
         O4Q0GO52GA74/eEnIhkpIHrNLXUIEzrDBer7/W/OL81eb8yQorVo9p+BpduymIF9UCgx
         t2ZWfJ+0RiPxAyWXTNogGWHpQn5gVr7uqPkIsPx9YpU/SJ0VT0OJcrCoOizvLcGDzKDr
         AvDAiasDRPlFNn6fZzMbRU1hHdvH5nfdVnO4vuhmSIfMvoAqdEjmZI1xgSn9iFBt+pAB
         N+Jg==
X-Gm-Message-State: AOJu0YyyrrVr8eFJH4L9yWnmGGxXS6KP24Cw+WKC7x3BcD/JGvGeY2VG
        h8j1kuMpAogMYOHpOddLxAoGkA==
X-Google-Smtp-Source: AGHT+IHOe4StZk9p/o2Zvwe4Q/iRgNulteHoQQ85TwT9W8Rl6RYQ6kjOCWG1GGHBmeC9Gt4Hw7/U1A==
X-Received: by 2002:a17:903:234a:b0:1bf:4833:9c2b with SMTP id c10-20020a170903234a00b001bf48339c2bmr10564192plh.31.1692739847743;
        Tue, 22 Aug 2023 14:30:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001befac3b3cbsm9451475plg.290.2023.08.22.14.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:30:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/6] arm64: idle: Tag the arm64 idle functions as __cpuidle
Date:   Tue, 22 Aug 2023 14:26:57 -0700
Message-ID: <20230822142644.v10.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822212927.249645-1-dianders@chromium.org>
References: <20230822212927.249645-1-dianders@chromium.org>
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
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v9)

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
2.42.0.rc1.204.g551eb34607-goog

