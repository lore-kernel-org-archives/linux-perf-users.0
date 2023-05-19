Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FABC7EE29
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 17:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjESRUz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjESRUw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 13:20:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBDE103
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:20:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae452c2777so8388415ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 May 2023 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516848; x=1687108848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcM0wR29cuHK7GXo2TdGDLyKkAwZL1B+8Gx/MlaFtWk=;
        b=kEsrUNSdU018P3kQAOdfw9NJaCojrA7xD3/FTAllGlFbLR9rgwTTVnaSMQ24q3RjJS
         P1SYLZYf5vC49grgelECTeI5RyN85bjUJxcAyZi0+ily38rBbFucpado8sslbHymGt4f
         DYRpNqivOlkaCsZZPBd57K4qVP8xrRqyy4xXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516848; x=1687108848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcM0wR29cuHK7GXo2TdGDLyKkAwZL1B+8Gx/MlaFtWk=;
        b=kIASzlsmQjuaEMB8zPZGU8aI7cqGKbswGN0MqZvqphGsWZV0IC4lUox0SNjiGVmTmJ
         iSXZS89Et+oKaMjKVFlZglD0nngxpaQ9+Kb5nVHStzBl+ziL/zU/SBn3EG/tGgccd2kE
         FEjlLStls2cH17xl6FMbUUQAmQX2CcdJa/mnBQ6bZq+psd7zFAT75lQyS8G3fT0R8Jn1
         DR50p5Nufso2AvbhzQVPdKg4o9mYcRNhJA4TAVzh68j/EwBKY1n+0N95RoMIXApX3y5l
         Da8KhPrx1tIUuxm3yEep4k09XMIi9omIVtj+CS2L64O0/AjDfAzuSPmfvhzs/1ca+zft
         41KQ==
X-Gm-Message-State: AC+VfDw8/Yft+L9e/V+pDpeEQIrRMqOtUBDS5TdBvoBMiRf9HOdjwg6e
        cbdbMGi0jzktf4E1TFT0pXGctw==
X-Google-Smtp-Source: ACHHUZ4mx58awuKpl9uflEBIjFmc7jsJQJGCBez/HRuMvDYQ6q4E3WWyPQdwWVjtEkLcf6Nf2Fj1xw==
X-Received: by 2002:a17:902:e541:b0:1ac:86b5:70d9 with SMTP id n1-20020a170902e54100b001ac86b570d9mr7160170plf.32.1684516848587;
        Fri, 19 May 2023 10:20:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:20:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 04/18] watchdog/hardlockup: change watchdog_nmi_enable() to void
Date:   Fri, 19 May 2023 10:18:28 -0700
Message-ID: <20230519101840.v5.4.Ic3a19b592eb1ac4c6f6eade44ffd943e8637b6e5@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

Nobody cares about the return value of watchdog_nmi_enable(),
changing its prototype to void.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I yanked this patch from the mailing lists [1] into my series just to
make it easier to avoid conflicts between my series and the one adding
the arm64 perf hardlockup detector, in case someone wanted to test
them both together. This is a nice cleanup and could land together
with the rest of my series if that makes sense.

I changed the patch prefix to match others in my series.

[1] https://lore.kernel.org/r/20220903093415.15850-3-lecopzer.chen@mediatek.com/

(no changes since v4)

Changes in v4:
- Pulled ("change watchdog_nmi_enable() to void") into my series for v4.

 arch/sparc/kernel/nmi.c | 8 +++-----
 include/linux/nmi.h     | 2 +-
 kernel/watchdog.c       | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..5dcf31f7e81f 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -282,11 +282,11 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
  * sparc specific NMI watchdog enable function.
  * Enables watchdog if it is not enabled already.
  */
-int watchdog_nmi_enable(unsigned int cpu)
+void watchdog_nmi_enable(unsigned int cpu)
 {
 	if (atomic_read(&nmi_active) == -1) {
 		pr_warn("NMI watchdog cannot be enabled or disabled\n");
-		return -1;
+		return;
 	}
 
 	/*
@@ -295,11 +295,9 @@ int watchdog_nmi_enable(unsigned int cpu)
 	 * process first.
 	 */
 	if (!nmi_init_done)
-		return 0;
+		return;
 
 	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
-
-	return 0;
 }
 /*
  * sparc specific NMI watchdog disable function.
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 771d77b62bc1..454fe99c4874 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
-int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
 void lockup_detector_reconfigure(void);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 582d572e1379..c705a18b26bf 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -93,10 +93,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
  * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-int __weak watchdog_nmi_enable(unsigned int cpu)
+void __weak watchdog_nmi_enable(unsigned int cpu)
 {
 	hardlockup_detector_perf_enable();
-	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
-- 
2.40.1.698.g37aff9b760-goog

