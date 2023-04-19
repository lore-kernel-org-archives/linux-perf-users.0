Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9E2C77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjDSW56 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjDSW5i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7057A9F
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b60365f53so514402b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945042; x=1684537042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWZTrwd5TxmiYLg/mD/63PXcodsl+Y0F8uDPTGYpPFY=;
        b=ENMXPNPKpUB8x1TeX9CInNTf6Pzm3ER8KeB8ofn5pxz8+lYuSyslgYS+81+WV7V/1A
         LEf1UqVF5i1wcOYXFEEwNvpTG7LVOyK7V5Mhz7v0lcNNeXQSBJN/9y2kPBa/eges+Jb3
         b6xm1J9kPVn558DdKvWhugxeLv8noIfLhyE0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945042; x=1684537042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWZTrwd5TxmiYLg/mD/63PXcodsl+Y0F8uDPTGYpPFY=;
        b=EzKNdh0VhLGofzGztmuL29btNPxd8sAZ1XU8ZyNm2JRpaKLY1W7vq8PzkQJ2DTrG4R
         szHHA7UKxmsb9d8UHLtoIZWHEW2GLBkEJY/OMoX3a1sk05vTVt5uxcCUlNsqJ0dHMPXj
         jmQsIXgYKb7eSuNIfZzFAnDQdygA470gotUXgFN3yGQ4GTk+aMIYb6CW8g4vbrQnA+oe
         DdicB99Ytxs9VIEU/Fa+/Qsj/oGsdpELtrdyiFxyk14sgjMJxVpD4OS/MHFaiTC8Sf6h
         34I60MIG7XY70kOY2Hk94i9GdL1FXQjStUDtedlbtusJDcODPVHiCj9z3/wfMZSiRb0L
         YalA==
X-Gm-Message-State: AAQBX9c9YrwBf3nHXFAoUDm+zEIONq7b2IQ4vZqKSDCCLCy8KbWeoSKl
        ozztkIdEerHinZXQcxXXedi6W4Rbmh7ww6QrmE4=
X-Google-Smtp-Source: AKy350bzal91TPSNwTZw0WiWqcU5p5zvcdk0BkVsNFuBNbks1jS5AwavXMPCBAcH6HwZUkYAxgIWew==
X-Received: by 2002:a05:6a20:8b2f:b0:cc:5f27:d003 with SMTP id l47-20020a056a208b2f00b000cc5f27d003mr42212pzh.56.1681945041867;
        Wed, 19 Apr 2023 15:57:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:21 -0700 (PDT)
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
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/10] arm64: kgdb: Roundup cpus using IPI as NMI
Date:   Wed, 19 Apr 2023 15:56:03 -0700
Message-ID: <20230419155341.v8.9.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to roundup CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to roundup CPUs using IPI turned as NMI. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
it will switch back to default kgdb CPUs roundup mechanism.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/kernel/ipi_nmi.c |  5 +++++
 arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index c592e92b8cbf..2adaaf1519e5 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kgdb.h>
 #include <linux/nmi.h>
 #include <linux/smp.h>
 
@@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
+	unsigned int cpu = smp_processor_id();
 
 	if (nmi_cpu_backtrace(get_irq_regs()))
 		ret = IRQ_HANDLED;
 
+	if (!kgdb_nmicallback(cpu, get_irq_regs()))
+		ret = IRQ_HANDLED;
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index cda9c1e9864f..2c85bc1df013 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,6 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/nmi.h>
 #include <asm/patching.h>
 #include <asm/traps.h>
 
@@ -354,3 +355,20 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	if (!arm64_supports_nmi()) {
+		kgdb_smp_call_nmi_hook();
+		return;
+	}
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arm64_send_nmi(&mask);
+}
-- 
2.40.0.634.g4ca3ef3211-goog

