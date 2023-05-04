Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2E4C77B73
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 22:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEDWPM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDWPK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 18:15:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5212082
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 15:15:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6439b410679so344088b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238509; x=1685830509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OARDe2WGhGJ9YL28VnMtRA2erbfr4XRakwTJsFcap5I=;
        b=GLyo2ZwV6SkVu4yg4BDy7JLcH5ZAP2+/Qea63V/wdOAwvbUwjlMysbyaZ2Vj0B5Ivh
         0GPXL/8FkhlOU43tb+ABkKZjcnWdf+kvyUm0Z0zfqPTn+HG53phy8ghQfqsDqk1tvDdK
         aPeNvzoOAj5cm8jOtnggXAtEE/QJY2OQ3iXcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238509; x=1685830509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OARDe2WGhGJ9YL28VnMtRA2erbfr4XRakwTJsFcap5I=;
        b=iseoT+oh9faT1yPe+UouUvHUye9YjQ8/nWkPQwHUHYvY85m3knSmCyKPyyfCCbynGu
         uJ+Tt3WioYH4rYT20vLZA3aF/y1MVmbTZYqBmdt1w0n/yRB7TCANZ4qw/dKRXHZxcLUy
         tsL2A9dcgwkrcF9JrEZFCo6SVr/UYOZIvKhXomraOmUMIXQaWS/WCp09/HPDo8FX4xW8
         dPVgXmchRWQx920Sni+T+8CCgP3gnpGnxoDTAfBiPKLRSMk0kry/x8n2MUayfXhCxbfD
         ICNJKtuyoKjdh+JLMOz+bUiLiirGB7cau4li2y7QFhjk1t5dtWoY2ZffVyHzgBX/KOn3
         uDyg==
X-Gm-Message-State: AC+VfDxBQOwBdWiPVDrV6Nw3Cz2fbOaSv7YuEre81pnkw/ffOQVAqc/i
        dCWuuMDUy6e+/BgUBP8bUO1C1Q==
X-Google-Smtp-Source: ACHHUZ6K/GWZgHBRK8tXvn/IygmeZOoqhhON0G5s9GMpGhU7noise7S5Zr5rOpk3+MOxdT0Gz+Ye2Q==
X-Received: by 2002:aa7:8885:0:b0:643:74a1:6dbd with SMTP id z5-20020aa78885000000b0064374a16dbdmr4174511pfe.30.1683238508951;
        Thu, 04 May 2023 15:15:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 08/17] watchdog/hardlockup: Style changes to watchdog_hardlockup_check() / ..._is_lockedup()
Date:   Thu,  4 May 2023 15:13:40 -0700
Message-ID: <20230504151100.v4.8.I818492c326b632560b09f20d2608455ecf9d3650@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These are tiny style changes:
- Add a blank line before a "return".
- Renames two globals to use the "watchdog_hld" prefix.
- Store processor id in "unsigned int" rather than "int".
- Minor comment rewording.
- Use "else" rather than extra returns since it seemed more symmetric.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- ("Style changes to watchdog_hardlockup_check ...") new for v4.

 kernel/watchdog.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 2d319cdf64b9..f46669c1671d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -89,8 +89,8 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
 
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
-static DEFINE_PER_CPU(bool, hard_watchdog_warn);
-static unsigned long hardlockup_allcpu_dumped;
+static DEFINE_PER_CPU(bool, watchdog_hardlockup_processed);
+static unsigned long watchdog_hardlockup_dumped_stacks;
 
 static bool watchdog_hardlockup_is_lockedup(void)
 {
@@ -100,6 +100,7 @@ static bool watchdog_hardlockup_is_lockedup(void)
 		return true;
 
 	__this_cpu_write(hrtimer_interrupts_saved, hrint);
+
 	return false;
 }
 
@@ -110,21 +111,20 @@ static void watchdog_hardlockup_interrupt_count(void)
 
 void watchdog_hardlockup_check(struct pt_regs *regs)
 {
-	/* check for a hardlockup
-	 * This is done by making sure our timer interrupt
-	 * is incrementing.  The timer interrupt should have
-	 * fired multiple times before we overflow'd.  If it hasn't
+	/*
+	 * Check for a hardlockup by making sure the CPU's timer
+	 * interrupt is incrementing. The timer interrupt should have
+	 * fired multiple times before we overflow'd. If it hasn't
 	 * then this is a good indication the cpu is stuck
 	 */
 	if (watchdog_hardlockup_is_lockedup()) {
-		int this_cpu = smp_processor_id();
+		unsigned int this_cpu = smp_processor_id();
 
-		/* only print hardlockups once */
-		if (__this_cpu_read(hard_watchdog_warn) == true)
+		/* Only handle hardlockups once. */
+		if (__this_cpu_read(watchdog_hardlockup_processed))
 			return;
 
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
-			 this_cpu);
+		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", this_cpu);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
@@ -137,18 +137,16 @@ void watchdog_hardlockup_check(struct pt_regs *regs)
 		 * generating interleaving traces
 		 */
 		if (sysctl_hardlockup_all_cpu_backtrace &&
-				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
+		    !test_and_set_bit(0, &watchdog_hardlockup_dumped_stacks))
 			trigger_allbutself_cpu_backtrace();
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-		__this_cpu_write(hard_watchdog_warn, true);
-		return;
+		__this_cpu_write(watchdog_hardlockup_processed, true);
+	} else {
+		__this_cpu_write(watchdog_hardlockup_processed, false);
 	}
-
-	__this_cpu_write(hard_watchdog_warn, false);
-	return;
 }
 
 #else /* CONFIG_HARDLOCKUP_DETECTOR_PERF */
-- 
2.40.1.521.gf1e218fcd8-goog

