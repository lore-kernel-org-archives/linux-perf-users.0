Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE431AF1D;
	Tue,  9 Sep 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412748; cv=none; b=TLtemVA51u32tpZ/g+4hq12Ybwuvwyy7hP97pdPHN+TToSDLETgRc6HA1CorL3zgm4y8mYjH6kN/eByYwSoZMBldM6ADn36xxTf635V810GcZ8aHixCOt/sf2tx4QoOZ+ewzsVS9HurYdfqEcTq6zq9wrvG81PYS+Z8nlUq17hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412748; c=relaxed/simple;
	bh=ciJyOR3eGK2gidrZT8YeI5fy6dg+FxklvW19mrX4w1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haZb0d0g9UIorE1mXpbbVNlXiw1GSc+e14zXN+eEw39QivNK2EbBy4kjUs7WYv5749jYlsvlFEUoYOI+XGLc0894JrcA6gq9Zfviy2z7W4kO7UwwXyRtjbWYTkSlp2sIKMXfj36J4b/rQrupwPD1bZ8/M6AJQXxTRl7TGs7OaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpas5YKI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpas5YKI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso4663315e9.0;
        Tue, 09 Sep 2025 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412744; x=1758017544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPzMl9444DyFsyhIlxZU2alp+KEUomV9x8N6sGCMpt4=;
        b=Mpas5YKI5ekTCXdsyJkl0AtfBk0M61NJJnbLvddhF4wYZCp7CWeLojC66Vgu1HkEk7
         nGpmS8hWEJ+fnwUK++fpnevU4Z3lxMD/8odjUSZy6gEO65YWxUhQaRlAsrMh7+vFb7NA
         IvGdUw2p9royABxiuPW1xvXCvSgGi+6PRh/D+/+uvzgNCqoOm2jYOnvIHuSgHk8zLZ71
         h40YNmZ7OA4p2L7yvvvOnlcngrxPNr06HUQvf1tOP1ugwozX1QOwhUJCCAoubcgbDf0e
         QyxN1DmKZR3XdUKGAkItse3mpYtiAhNwtXYkf6b6EKXTpFBGKkh7mer+QegBUEhm1vV+
         bjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412744; x=1758017544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPzMl9444DyFsyhIlxZU2alp+KEUomV9x8N6sGCMpt4=;
        b=YvUtErNI1AZzt+HYy3KDO37ZG58scfG8Ez5wXFHI+CuCvvBrPHUrth1XeWU3uKBzlE
         JUSfSWIeutE4upOFDqzLifKdx8gUyFsaIQJ6VKR4O5JEnIEXIrDB+UvDzI7h/btpSOMm
         PyeyUW27CeCSgtPyIR4sSiApRUHmNVc60+TNiKAGici0RtJ//cKI9NLT3A+lWA3dB2pG
         8DeXEjNHX0d2v16QYAyzU7rH+NUPq/KirTn8IHZscSgFFGLIbGzL2b17TWS32VJWRXNs
         DDuWZJD8Dcpa1mHzeUfGlwSRAsStVj5N/WWlkqy7hNWkRkhFMHxqgMVzvOMcX/ZMvF+w
         wplQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/9i0inBAkPjv/MtxHYr9DwFbsG6pKlSGACQZtGbgYCodPkINiJTTl0nzmiD8daUbvehCsPi+Aq6i@vger.kernel.org, AJvYcCVloEzdgy/KslrKA/cR8o3aVGPVZQavgqIgXSXTWbXx1YHPllD6VZotPj3X9oVNiNL1DcelEgpu19yK@vger.kernel.org, AJvYcCVr0LWi1gAYS9ASdI4fuEYRIgk3IFOIWXHRo7OswkDctUr+s1QyTUbqFtD0ygQYh39d0nBXb7Ula2c/u6mOEy7zsA==@vger.kernel.org, AJvYcCWn0joCqjzjhGcQQr6mWY/IgB4v8h8/U6B52dxYMu60WL950BKaPCYsGtCQGojh6ZAxBzAO47rJWDcP@vger.kernel.org, AJvYcCWy/0Qac0evaXonJkQuIqu+WRAvy3X9Ucu2IxByn1lZke1rezaZJtrszpExwqP21kwvR35LPHDPshFc0som@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHzCJtTjFuVLAAFzXvdSDpPhmZ6YRETohu/J+VbP3jS8ADzzx
	lryBNyhVBsW6kGqI8tBP8bGbRkfD+jzBAanzNTaY1u4njpyiiLXdaJ8k
X-Gm-Gg: ASbGncv9geR2UUCsy61+jNSwr7Yl+Z18CHeapeunh3X7aOsZXrt9rK4ymLy9UD97TOU
	JgiLJ6YQDdJhxPwSxrKpbXzlsa8SZuYDxb7p1BM7LqjSYk0bJ/JcbyTFntQ/iYeJoiwm10Avg1L
	lhQPV+iwUY2LKhA7dcFF479zsSM2AeCgp+FRRHX1W9IonWCnkXjEMGM8+ExQ35ZCnEGIEePBI7R
	2dAaD+OZMMi+7rTIfg7rNwrA1X2uhQIrnt8q/cdWTMhPkJOeR/fxdE8+0kvfSqGcmf0LQkpuGxb
	pdh4LfLUJg8bBB3Ppf+EoBnyyE4gneI9hgc1RhIkU0zKEyvfK7SYr4nwZtldVH3vpUNmy2msTgn
	hWpmMhMwcg2xcIHeDigpiPm34awhRdo9mok+E1Usjr94LyhzTyGQxtDh0c0SHU1mp9pP5yDkKVz
	B7ZnRNLOA0FmFr/NGCjnQ0DMc6bg==
X-Google-Smtp-Source: AGHT+IGPh09/AgyRGnk3hh/JVjy55HRoX4WeFY5HxCNx6I/w3RAwA6apcDwreywzBjxWgSeV51SF/Q==
X-Received: by 2002:a05:600c:4587:b0:45d:d94b:a8fc with SMTP id 5b1f17b1804b1-45ddde8c757mr122875745e9.16.1757412744214;
        Tue, 09 Sep 2025 03:12:24 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df2cb1d77sm9627225e9.3.2025.09.09.03.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:23 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:10 +0200
Subject: [PATCH v6 03/20] clk: stm32mp25: add firewall grant_access ops
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-3-ce082cc801b5@gmail.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

From: Clément Le Goffic <clement.legoffic@foss.st.com>

On STM32MP25, the RCC peripheral manages the secure level of resources
that are used by other devices such as clocks.
Declare this peripheral as a firewall controller.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 drivers/clk/stm32/clk-stm32mp25.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
index 52f0e8a12926..af4bc06d703a 100644
--- a/drivers/clk/stm32/clk-stm32mp25.c
+++ b/drivers/clk/stm32/clk-stm32mp25.c
@@ -4,8 +4,10 @@
  * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
  */
 
+#include <linux/bus/stm32_firewall.h>
 #include <linux/bus/stm32_firewall_device.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
@@ -1602,6 +1604,11 @@ static int stm32_rcc_get_access(void __iomem *base, u32 index)
 	return 0;
 }
 
+static int stm32mp25_rcc_grant_access(struct stm32_firewall_controller *ctrl, u32 firewall_id)
+{
+	return stm32_rcc_get_access(ctrl->mmio, firewall_id);
+}
+
 static int stm32mp25_check_security(struct device_node *np, void __iomem *base,
 				    const struct clock_config *cfg)
 {
@@ -1970,6 +1977,7 @@ MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
 
 static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
 {
+	struct stm32_firewall_controller *rcc_controller;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	int ret;
@@ -1982,7 +1990,36 @@ static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return stm32_rcc_init(dev, stm32mp25_match_data, base);
+	ret = stm32_rcc_init(dev, stm32mp25_match_data, base);
+	if (ret)
+		return ret;
+
+	rcc_controller = devm_kzalloc(&pdev->dev, sizeof(*rcc_controller), GFP_KERNEL);
+	if (!rcc_controller)
+		return -ENOMEM;
+
+	rcc_controller->dev = dev;
+	rcc_controller->mmio = base;
+	rcc_controller->name = dev_driver_string(dev);
+	rcc_controller->type = STM32_PERIPHERAL_FIREWALL;
+	rcc_controller->grant_access = stm32mp25_rcc_grant_access;
+
+	platform_set_drvdata(pdev, rcc_controller);
+
+	ret = stm32_firewall_controller_register(rcc_controller);
+	if (ret) {
+		dev_err(dev, "Couldn't register as a firewall controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void stm32mp25_rcc_clocks_remove(struct platform_device *pdev)
+{
+	struct stm32_firewall_controller *rcc_controller = platform_get_drvdata(pdev);
+
+	stm32_firewall_controller_unregister(rcc_controller);
 }
 
 static struct platform_driver stm32mp25_rcc_clocks_driver = {
@@ -1991,6 +2028,7 @@ static struct platform_driver stm32mp25_rcc_clocks_driver = {
 		.of_match_table = stm32mp25_match_data,
 	},
 	.probe = stm32mp25_rcc_clocks_probe,
+	.remove = stm32mp25_rcc_clocks_remove,
 };
 
 static int __init stm32mp25_clocks_init(void)

-- 
2.43.0

