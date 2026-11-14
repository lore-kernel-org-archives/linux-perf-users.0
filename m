Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699458;
	b=F8gnx5UV8Lep3MM2Te3v+VlHD6KbubdOy7UdnJ1jdbwW/Q++bhow8OnMLmjVDL1XfY/3
	 dH/akzqAKxe5heJNjMTMC9Hh0AouafLz0ar8+dbxA88xyWkzSxTzVJ5a7utRVHGbZvzOT
	 e+fCW9gmqTY6g8zgUnqNYFfpuMgnDkNvrsSqhLdTxSJtWr/Nhsgh1aNcyQVa7lYbn5U5b
	 irGC5kaBy6VGMSS/jepnBbTR/lds1++ZI4S0PKsyXVED64s9euK6UKlb1GE6hh7OsdjLb
	 fKetd5HUe33PrhKQKGlzaBAwsJaqMRT/d0pdrOKhzQzlkz5kfBJqnnkXGF6/28A3efg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zPxwQZ24qNZrX3J3/HAoM3bM0nDSHqnSDrrlD4YRwII=;
	b=OsGInVcgIssylAs5/LlihTu0msfqPmcDCo4zaCtgoNR77ZYGDPdrlnZD2iCUWgSU0qtR
	 tRe14LTEnvkibUOkBQ+XyU7YzcqADHQCT76zPtxxtrLAi8XgXurNNjANbsrbJ8kjP9LWv
	 VM2omfhN4c5u8xbvtFyf6k4oiMUOPWVxhs/uc3xfwsJNSPaKMnrPDPWltT+5Z0IfIDrwK
	 0+pl9v8fOCxfuZ5ECEckvZoWGTsCXLTOGexcOvklhKE6YVIXcyOP6v5x90vi3HxxEMj8S
	 R2BeyI1Zf+r4G9oPQd2nzXrXNI/uJ0nlaTQcPQ2CZLULGBo5VH3oHSjRDomeOQv8Dpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqkD68Kq;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74418606A8AA
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74418606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqkD68Kq
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso977898a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794699458; x=1795304258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPxwQZ24qNZrX3J3/HAoM3bM0nDSHqnSDrrlD4YRwII=;
        b=NqkD68KqiFujgPDXz4hpk/E8NENKbPH+Io2MzZfurch0T/qeDpe5CQQTTtl5RFlXSN
         cb0oWbI6tA4jvOg5OjuFfBdV8OKEVvCX9BSeYKhxgl+LXpKoJ578QA6DpRRVwiGs2jK7
         CwtTNlKIJANFa/JkRM0SlHaf5oJ5jlcdmXUuIOGBxIRu+++8Ho0sQJRfpZ5Yu8LDhk2S
         n6BdJRhFExZ4V+ulIHlfsK8Ft73eeZ5137FXsFhWDLpDoEiNXIM5x23RSP3wqLH6+QPX
         4hBYZ3puw0ja4MzVfmqQZCQZTufYWqkD+Pni+SgY+WPb098TcmKfXvp+Nb7pVfaoFpe8
         C8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794699458; x=1795304258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPxwQZ24qNZrX3J3/HAoM3bM0nDSHqnSDrrlD4YRwII=;
        b=WxDDKk0KjlPB75ZgSo7tCnkCEnEaHc1GjP8dUnMkc0+sAO8k4JLA1bHLTUqY1KajcG
         TZtJhMZhJ6I/i+XIXffCZqvfloBUF0PZObHf6Ns0yd3LSOdMCsYmb/srsVD1/Obb0Nnk
         Rvexxqljf68fHlE3AQAHj+spgRgSdsUxLv91osCqax2uCzR8MqqNSdupSxDU8CTAnybl
         5jxyrDelynlqcvMqGDT3yH8HldfY0LkvqYZ9tXaBO4kTL8q+gPmhIpJSt9ufWxwFpV0c
         eHR1IWH/2kX42yUhtX+ioOCqz4RIVdypfM/HbuCyW+9kdrZGfWDfWO0826JLWxfoCQ2A
         9WCA==
X-Forwarded-Encrypted: i=1; AL+hErHCiN0Ce6YNR3wrzb2Q/QM+nqhUCDwJbsdFJVBiZg9V02GFoRjeFmRqAfwijVwtL0fw9+Jvig2B+oXL8SEnp93A@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ve8J0/2SmMbBi/TmUPRKY2vVaTdk8Bg1JZmJbLSBhJB86/DR7
	ppV5lEKXRlCKi1qSq4/w/IlQBkp5DtH6MOINIoN2zF6exyXSnPvnGOdR
X-Gm-Gg: AYBFou2ytFvh93j+d7CZ3Fr/Pt4txCO3Ac5nEaHJCCULGRG/TeerWxjQWrl0p3mFqb6
	VN7v9Dtt91KnTV+itPhPfy/XtEuqoAtE7HdHqO2QTKQ9oUcVE5scwVPWjxaKDG4EZa5HyWoqL3s
	pXE73P+lZQFEr9yR3R6T31LfbFbLQ/PgxmgaPO3zYJXuzyT59ntEEbzlr9nQrTPpg+yJ4tK0WNG
	KZcUqKw8VJ/Vrm4HZMKPc4vsy2z65I3rOlpzXbIcDxvzj3yFsQAmh8VMB6V5VMkm/KpYq0x+Taw
	HEqTPGnKpEZ4Ui4yparKqzaz9+m5zaVWlEo/f6UHtfUwuEJDddQEmGn6UHIVprpPM6Tc0UlRSeU
	NpYOwuOJF0u3Hn+DsukQT1C280Esdl1taHYK8NGCmwyyZtVkLG7UDnxb8WQdkhWResnYPdlMx1u
	QL2V1ixE7hSZJptA/cdc7sdLjaVdp+J317tA6ap4VK7kPPi8S4jx+5m3isYwL033MnBn5AqcITw
	Nen0e40wV91gy97sMR3UaZ6OTMkjNgF8fbk6ipVXxiLoZnEHENSNSicthVx6es9m6hgeEKwTrky
	PJIOvWNIenolROsHhdbRVHqQQxt2nc+3pXfC9ZTlUWJL5AGj24mx2GCpf5AYaHZ2K2h5S7RUVPX
	JLuihrjAfWvvIKVeRrosRSJ7BkwP7werDcNuUaeqCjyvbHlod/Kji2SIUuZ8lFq9uUi64jb6zlz
	fJlA==
X-Received: by 2002:a05:6a21:3989:b0:3fa:3e8f:4b3e with SMTP id adf61e73a8af0-3fa3e8f4d04mr751659637.44.1794699457752;
        Sat, 14 Nov 2026 15:37:37 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d0f473sm2306372b3a.53.2026.11.14.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:37:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Radu Rendec <radu@rendec.net>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v2 4/4] irqchip/ath79-misc: allow COMPILE_TEST builds
Date: Sat, 14 Nov 2026 15:37:18 -0800
Message-ID: <20261114233718.86520-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114233718.86520-1-rosenp@gmail.com>
References: <20261114233718.86520-1-rosenp@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is only built with ATH79, so only ath79 kernels build it. As
a platform driver, its only MIPS-specific parts are the performance
counter hook and the call to spurious_interrupt().

Add a Kconfig symbol that defaults to ATH79 and can be enabled with
COMPILE_TEST. Build the performance counter hook only with ATH79, as
other MIPS platforms provide their own. Drop the call to
spurious_interrupt(), which only exists on MIPS: a cascaded interrupt
with nothing pending only bumped the error count in /proc/interrupts,
and the handler now just returns.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/irqchip/Kconfig          | 14 ++++++++++++++
 drivers/irqchip/Makefile         |  2 +-
 drivers/irqchip/irq-ath79-misc.c | 19 ++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8aee8f731848..f83fe64f066b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -127,6 +127,20 @@ config ASPEED_AST2700_INTC_TEST
 
 	  If unsure, say N.
 
+config ATH79_MISC_IRQ
+	bool "Atheros/Qualcomm ath79 MISC interrupt controller" if COMPILE_TEST
+	depends on ATH79 || COMPILE_TEST
+	depends on OF
+	depends on HAS_IOMEM
+	default ATH79
+	select IRQ_DOMAIN
+	help
+	  Support the MISC interrupt controller of the Atheros/Qualcomm
+	  ath79 SoCs. It is cascaded from a CPU interrupt and collects the
+	  interrupts of the UART, GPIO, timers, watchdog and performance
+	  counters, among others. It is enabled by default on ath79, and
+	  only needs to be selected by hand for compile testing.
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index eb539d41251e..c51e79d3621c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 obj-$(CONFIG_AL_FIC)			+= irq-al-fic.o
 obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
-obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
+obj-$(CONFIG_ATH79_MISC_IRQ)		+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index e69d4eca929f..c25676a1c1cd 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -16,7 +16,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#ifdef CONFIG_ATH79
 #include <asm/time.h>
+#endif
 
 #define AR71XX_RESET_REG_MISC_INT_STATUS	0
 #define AR71XX_RESET_REG_MISC_INT_ENABLE	4
@@ -25,8 +27,14 @@
 #define ATH79_MISC_PERF_IRQ			5
 #define ATH79_MISC_SI_TIMERINT			BIT(28)
 
+#ifdef CONFIG_ATH79
 static struct irq_domain *ath79_misc_domain;
 
+static void ath79_misc_set_perf_domain(struct irq_domain *domain)
+{
+	ath79_misc_domain = domain;
+}
+
 /* Called by the MIPS perf code when the first event is created. */
 int get_c0_perfcount_int(void)
 {
@@ -40,6 +48,9 @@ int get_c0_perfcount_int(void)
 	return irq ? irq : -1;
 }
 EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
+#else
+static void ath79_misc_set_perf_domain(struct irq_domain *domain) { }
+#endif
 
 static void ath79_misc_irq_handler(struct irq_desc *desc)
 {
@@ -53,12 +64,6 @@ static void ath79_misc_irq_handler(struct irq_desc *desc)
 	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
 		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 
-	if (!pending) {
-		spurious_interrupt();
-		chained_irq_exit(chip, desc);
-		return;
-	}
-
 	while (pending) {
 		int bit = __ffs(pending);
 
@@ -159,7 +164,7 @@ static int ath79_misc_intc_probe(struct platform_device *pdev)
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
 
 	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
-	ath79_misc_domain = domain;
+	ath79_misc_set_perf_domain(domain);
 
 	return 0;
 }
-- 
2.56.1

