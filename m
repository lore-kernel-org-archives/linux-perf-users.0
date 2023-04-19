Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0888DC6FD18
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 22:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjDSW5f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjDSW5T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364435FFB
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so229119a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945032; x=1684537032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpO6xBr8GRTIiZAwOhR7DhqHQGx50IOyRoOo/b42ur0=;
        b=kscE08GAAWK411hIe/AlrpkEs4LuqorOLSZXU62OFqZbcuwAzAR8cxaFEQzLrqNjma
         eIM4oARZaGkVYYFo7UShuM6mT3sodkflb5QAh7j0/+pCO1fujDsTYb6Cdq4h4L7LheLe
         LvW+QGq9VdNSHMlXNHrY28CT0AZxYFUZ4elQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945032; x=1684537032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpO6xBr8GRTIiZAwOhR7DhqHQGx50IOyRoOo/b42ur0=;
        b=jDiMLKZZY1UYD5QYpQumvyrMqGclmMGTkyAny0dOjV+2u1dm9efs9OH6dahQUjtucr
         tWKAKE15snRbpjXnN3HvcktaDpv5pdanXjn5s8v/HUzoJ2FA+nyp9PINRC1PbNdx8Yvy
         tB5uG25n07OKuZfWfu4SlLEIwknGHC0sbdzHvhQLjvzfe788IMxgKEm4onL559hmIO6r
         /srcFYfEEIA1oCzr+oBgmXYWwsseVlrtYX67/pvdGyYjteiQNM/rhwX2AGlX5nk5yTGg
         /9HCKk3rWI2LcTpsKNY3JLD1CMRGggYq1U114FX9BX9W5hmf57ophc8GTjsPAyn+PbG4
         kg8w==
X-Gm-Message-State: AAQBX9ct8RGcx6Hea1b9YxgiXp6gytZKgFTaPyvxOFNCfecK1jYeoq/d
        54lq/TPniMcPsjbfLVPg1Wd5Sw==
X-Google-Smtp-Source: AKy350aK5ae5EGORUG+NerzBv8kCtz8aZ4AMVRXzvnaMvPW39Dl9faoU7w/z73Q50CZOVchx5jXuaw==
X-Received: by 2002:a17:90a:c297:b0:240:3dc7:4939 with SMTP id f23-20020a17090ac29700b002403dc74939mr4439076pjt.27.1681945032562;
        Wed, 19 Apr 2023 15:57:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:11 -0700 (PDT)
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
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/10] arm64: ipi_nmi: Add support for NMI backtrace
Date:   Wed, 19 Apr 2023 15:55:59 -0700
Message-ID: <20230419155341.v8.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Enable NMI backtrace support on arm64 using IPI turned as an NMI
leveraging pseudo NMIs support. It is now possible for users to get a
backtrace of a CPU stuck in hard-lockup using magic SYSRQ.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP

 arch/arm64/include/asm/irq.h |  4 ++++
 arch/arm64/kernel/ipi_nmi.c  | 18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..dc35b9d23a81 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,10 @@
 
 #include <asm-generic/irq.h>
 
+extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
 struct pt_regs;
 
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index 712411eed949..c592e92b8cbf 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -31,11 +32,24 @@ void arm64_send_nmi(cpumask_t *mask)
 	__ipi_send_mask(ipi_nmi_desc, mask);
 }
 
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	if (!ipi_nmi_desc)
+		return false;
+
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_send_nmi);
+
+	return true;
+}
+
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
-	/* nop, NMI handlers for special features can be added here. */
+	irqreturn_t ret = IRQ_NONE;
+
+	if (nmi_cpu_backtrace(get_irq_regs()))
+		ret = IRQ_HANDLED;
 
-	return IRQ_NONE;
+	return ret;
 }
 
 void dynamic_ipi_setup(void)
-- 
2.40.0.634.g4ca3ef3211-goog

