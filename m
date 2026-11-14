Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699455;
	b=ZSK/jwc6YJ0BD55nl5Ra/+ujYkifGEov+v1srym5fP5SC2AYpZbIjZQnyfUG8Qg+V+Nm
	 GcERFi7Bdqnha4Md1BSWmMirziR88ACnQzPyiNjdx3CUIl5Koequf70YxuYecfycl7BLW
	 sfcNKp0/XCfIAsjaoCOmwg2Rhyk3mNxpdY5mWO5xz7soeCr9SAjNruw27d1UPJUxLJf4z
	 XlLoiYxBD0R8R5jSx0pbNzs8PZ9HklCDDo80G11GB0cU/mXkq0ahiQUtb+/ElCUwxyVTw
	 4Q5aUybPuQbigV0+wguh7t1lCYjhsCHTAkU+YUBGrDjay4P9wn+Fg89ISuawEL9Q/LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PP00yyyHcAa49iLb09D3hdi6QOsMJJT3uiuR4Zaky8A=;
	b=NangIrFpPZS/wDuvHuEmTNwtiydYfQTHK/KuI9DkRYD7bNBpXw+RXGw6v02xmtAvhmYO
	 g6xa28sbWsUWJ3sduKExRauExhvPX5D3dTJbyr3XIV5+Y0Vy0Khsq3OVFSIPtroRSYI28
	 goZosfgCEvZZ5weoditqpmLwvd7fBPTJQJFGVunv57n8gBBnIm0zKBtsMdkivX6BBY9pr
	 78vQaAitsnLSQueAwtxgoINNDWpP2et138BQc92fmqymtyD8RKvMtqIxZf7XCcyb5J+4m
	 P4MbQ4u0xkSV0/RSulE5KXc4kd10jryc68oWcnJhmKBirvTkDaCIUs9ZwQfohV2dD0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0z9bUaI;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FF606A335
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796FF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0z9bUaI
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so2256184b3a.0
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 15:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794699454; x=1795304254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PP00yyyHcAa49iLb09D3hdi6QOsMJJT3uiuR4Zaky8A=;
        b=y0z9bUaI0gFyTfODkPjDwcCzJuaNfl1HEoKDs+v1OLTk34kcv98kdjpQoXa8CIxGZH
         jR/9gNfOhvIvweDbjwDv39CIZOqKlrKYbaa6k+592zziqxj4+LOFER63cx4fzhBNnV4Q
         RThEkgO6YOpDWdzbaUmjQzs9zgn36MqdklEaL9iig2yH1gZ5gOWqp+GI1vtDy9kN+Z3L
         lpAl+9upUBHos3/lr9758xVJ/OTUe7dqalEHeCT9EcGkQEO2obW+Au16n0rATomQvquV
         yOmck5W2ZgvmcnyTBhZy+0IrbEru+8IOp1l8nPGLa/s3IO2pZjJ+CxiwCb5OCv2Tdahl
         6j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794699454; x=1795304254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PP00yyyHcAa49iLb09D3hdi6QOsMJJT3uiuR4Zaky8A=;
        b=ESLGJOkTBs428daib7Dq7XEou9SZ4cqJ4SkZlrO400jRC/DIZ8XxsKrBuJ/5JNm7pC
         2/wwQ03YoqBSryvx98xyjAudeAsH5Vh9AuXe368BSSmvlDW5WrUG1fTsQmbDgVRxFo+x
         6hk6VrKuxP9PTpauptATd7UKLgPL4oC9TSGoNUUi+Ol/MJ+hjsI1rCSZSpt2AP/Mp2jM
         QH//D3pXLiz31jonYBlCDvwryXetV9es/rLt3BQx/rKiTTkj60RvfU2tsY6H2dhXnwQx
         83TFPf+gWphZoA0+s2v8+Yj25PlffV9Ld3V8BKFmT8N3lKF43KMiunRW6eDgRDqkbDzU
         coOg==
X-Forwarded-Encrypted: i=1; AL+hErGceuzEky5mZZSJot080Jda2KVWEMkX0mA0/O2DnaLPgnxnQAV0uhdYh8D1zvn5mcJ4C2K9aaE1E8ihaF70amok@vger.kernel.org
X-Gm-Message-State: APuU4Z9VGWeCv1EC/fTD4eRtzOLIGEvNZpclYa0hnwIRkzPm1Dt4bP1C
	bWmyHHk6xyXU/qek5WrGoflRBYD/VH0KhqH8i0LKJvQTRBSpyWpXCFFntl0jKw==
X-Gm-Gg: AYBFou2x6aTlEH5eQyiaSTAKG6mQQVdvYseB15CZx7M02x/dNVbo6lVABuS1Ix2Y4M1
	ej+na3L76RZNZo5fXmk2azfx9zcONpgzMClMYiidPCNps4ghJERjCQl+CR9tLPciFzGi7ba6JpY
	UajMfl6nS3cT4/jTr5SsQIpspaNvBAsT01ZDcHdOWv0b6rC2u9lHscHTyQSXmLbnOodTshzLgNC
	uQ9xDvZpgpnMNCOpDL6ukwX4xF5QKWKTrLOHH8pjMqdco5SSVKLSEDKkw3RWscgoidFioI/o4qE
	Ds2nhFAtT7UbRiVkXCmg7Tscu3EIYS8fKnqfh6Yt/ijcocgA3d9KkQ0Rm0WgS7Stz9qA/M3GWBU
	hnGcby/1P4sLHXA/b6VSJF5AtZyN8y6IR4apwluZvafkJKVItUbT9yI6BpAkMyMXJk05hUbDM4M
	0GDOFHI617NPe1pOiBLQWAKSF5olnDXciVbT/bpa1BLutcR6g05HD+9U4wsznRCEqhGjBfFe0gE
	7J/YFGeE9J/TAOsP8rCw/SpUbDmCRaqvpEAvQLiIg7vhb6UZNzONVVBn7ep7QpqUS2p4eqEiyGz
	2MB1Np95KYwrfQtTjEOy3wFKE+SQKXlMh8yHbYpmDvHqgExot+ych3mi/u2ZxFt4iR9kdUCrnSW
	8BL8Qf15+GIqusQBgPdLfwenBo8hpXIFOJxkTQubooA/VO8S70J+YG5unD8WX0XC7kGzvepB9fX
	RvRvlxwCOL7TrmTsbAPrNFmNM=
X-Received: by 2002:a05:6a00:94c3:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8beb658e279mr6190631b3a.21.1794699453766;
        Sat, 14 Nov 2026 15:37:33 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d0f473sm2306372b3a.53.2026.11.14.15.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:37:32 -0800 (PST)
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
Subject: [PATCH v2 3/4] irqchip/ath79-misc: convert to a platform driver
Date: Sat, 14 Nov 2026 15:37:17 -0800
Message-ID: <20261114233718.86520-4-rosenp@gmail.com>
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

The MISC interrupt controller is cascaded from a CPU interrupt, and its
users are all platform devices, which defer their probe until it is
available. The performance counter interrupt, the only one needed
before the early initcalls, is now mapped on demand.

Probe the controller as a platform driver, and use device-managed
resources, which also fixes the leak of the register mapping when the
irq domain cannot be created.

The driver now probes after plat_time_init(), which on QCA956x and
TP9343 enables the MIPS timer interrupt in the MISC controller, without
which there are no jiffies. Keep that enable bit when disabling the
other interrupts, which leaves the register as it was with the old init
order.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/irqchip/irq-ath79-misc.c | 90 ++++++++++++++++----------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index 5cedea5234e0..e69d4eca929f 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -12,8 +12,9 @@
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/time.h>
 
@@ -22,6 +23,7 @@
 
 #define ATH79_MISC_IRQ_COUNT			32
 #define ATH79_MISC_PERF_IRQ			5
+#define ATH79_MISC_SI_TIMERINT			BIT(28)
 
 static struct irq_domain *ath79_misc_domain;
 
@@ -124,65 +126,61 @@ static const struct irq_domain_ops misc_irq_domain_ops = {
 	.map = misc_map,
 };
 
-static void __init ath79_misc_intc_domain_init(
-	struct irq_domain *domain, int irq)
-{
-	void __iomem *base = domain->host_data;
-
-	/* Disable and clear all interrupts */
-	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
-
-	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
-}
-
-static int __init ath79_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
+static int ath79_misc_intc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct irq_domain *domain;
 	void __iomem *base;
+	u32 enable;
 	int irq;
 
-	irq = irq_of_parse_and_map(node, 0);
-	if (!irq) {
-		pr_err("Failed to get MISC IRQ\n");
-		return -EINVAL;
-	}
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("Failed to get MISC IRQ registers\n");
-		return -ENOMEM;
-	}
-
-	domain = irq_domain_create_linear(of_fwnode_handle(node), ATH79_MISC_IRQ_COUNT,
-				&misc_irq_domain_ops, base);
-	if (!domain) {
-		pr_err("Failed to add MISC irqdomain\n");
-		return -EINVAL;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	domain = devm_irq_domain_create_linear(dev, dev_fwnode(dev),
+					       ATH79_MISC_IRQ_COUNT,
+					       &misc_irq_domain_ops, base);
+	if (!domain)
+		return dev_err_probe(dev, -ENOMEM, "failed to add the irq domain\n");
+
+	/*
+	 * Disable and clear all interrupts, except the MIPS timer interrupt:
+	 * plat_time_init() enables it on QCA956x and TP9343, which have no
+	 * jiffies without it, and that runs before this driver probes.
+	 */
+	enable = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(enable & ATH79_MISC_SI_TIMERINT,
+		     base + AR71XX_RESET_REG_MISC_INT_ENABLE);
+	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
 
-	ath79_misc_intc_domain_init(domain, irq);
+	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
 	ath79_misc_domain = domain;
+
 	return 0;
 }
 
-static int __init ar7100_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
+static int ar7100_misc_intc_probe(struct platform_device *pdev,
+				  struct device_node *parent)
 {
 	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	return ath79_misc_intc_of_init(node, parent);
+	return ath79_misc_intc_probe(pdev);
 }
 
-IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
-		ar7100_misc_intc_of_init);
-
-static int __init ar7240_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
+static int ar7240_misc_intc_probe(struct platform_device *pdev,
+				  struct device_node *parent)
 {
 	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
-	return ath79_misc_intc_of_init(node, parent);
+	return ath79_misc_intc_probe(pdev);
 }
 
-IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
-		ar7240_misc_intc_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(ath79_misc_intc)
+IRQCHIP_MATCH("qca,ar7100-misc-intc", ar7100_misc_intc_probe)
+IRQCHIP_MATCH("qca,ar7240-misc-intc", ar7240_misc_intc_probe)
+IRQCHIP_PLATFORM_DRIVER_END(ath79_misc_intc)
+MODULE_DESCRIPTION("Atheros AR71xx/AR724x/AR913x MISC interrupt controller");
+MODULE_LICENSE("GPL");
-- 
2.56.1

