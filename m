Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535C284B41;
	Mon, 16 Jun 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037589; cv=none; b=scJrmGBqgMR2cfyPpPm6fHHx0rzx+s02lrIzRcCuaSoQFmcRk8kgaDAwfACq+9LjyhNFuhyN7Fn1lSJH3YxJVPomZCm5/d9jKgEuyyK9XZ8n5Fq5TOljaLYRTAOGWnEmV6C6bQn2TsGaEvQjVaqwF95Bh/8mSQ3cg+v3wwilAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037589; c=relaxed/simple;
	bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l05eQxcjBshLrOVYRDrFCayJ4fXYX3UtdLeh0uayIFFqXUJhI8DN3ZloemIHMAhbAotcpkCOcG5YytYD1yuE327OF6/VlQuPgVYs59HTy36iBKU6kl1iQm/e0NNfxfbY542KpMGYiKorwilqC9qOylEPw8oOhNZj1f0ZWmVhj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZVbrOS3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZVbrOS3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2351227b098so31196215ad.2;
        Sun, 15 Jun 2025 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037587; x=1750642387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=dZVbrOS3qjk11GkDfLtsBOho4qBtRGlsXBUoQiqU8DyjMANoi21GZKgwvB4j2ycuqR
         lf+R14LzDvInTE2xI2Se+WcsN2ULRns3gx36iwN+CDEzrmJEAzG86dwIQm+lsmpD8nDB
         8tZDmD3lJCDA6ml5eZL31Yk/8VgHJplmTEgp6YpcTo4GR7JgjW3moxPDC7gmkzKr1x39
         uyiIaxnJhUR7g8+bVKqT+8vnqK7wQDPfEYo2Nx+ArVuyxIZMExPgnXnp37UhwBadBVm8
         xlxHrbX+zSUfoDjzivc9jjXfhndX8Q3Jo3e34wxZHjI9nHKm3jQEknxLEyBD8f3XRb4b
         KZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037587; x=1750642387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=QZPJ2cYVwZoyGWeVoGFS+ydWrCVZVBncR3fP537ybgwMwLYA0YrmbHzIaRYGb44Kvq
         zuiOykzblf4ytyxaIDxzErlc3bC1u6Rk1rhRVdTa+V0D+/a2hqSDUPAEd54bFixogsmh
         WoXUN+m4pr6KeaT9Xy+3BEjLKh/IAqi+8OVRFFafMtguFsut9dnYS7wxgsCXpeiBxDsg
         yHis0kj7ccHG2v3FwljXdP4OdfqgyzuYatmNfkmQdimomTwgUK0OQ/EKQS1psgU5h7eG
         2Bp6Mo5nJap9AZuKIngbFFGNrmRtOCZmX1uM2lGrVCssJaLl2sO3vb267gXCKLBfZ/Ky
         t8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKy9ZvTz6BAnQK/DEhaSYWWIJt85B5O9p2v5DHVCmxW5aoscbNBgI1yw77WswuCqZjFw63+DooT0cF@vger.kernel.org, AJvYcCXmJtNC/A7uT4meND0fTgHddo5NvSAdXiGN3FWT3jfEBIYsFH+kd6XIBxhcq6jrUNrem+FFirPDraiOsbWO@vger.kernel.org, AJvYcCXze58A2whx7JCEy4u140rBNQqpC87NT2u/m5kjTpd4zwCJ9D3N3XoLkozyre7ugBusX+USupbqtwybDZqeOPLfNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyheL5EpnlfuO1ssY0lKZWDXnqROTEjJzC4edWCE0AGphouJPUr
	PPfuIQMyospLowwI+RwPameBLL7qeKGEl4VjIFE/grqMT6gAMGNdFM3SmlUY5Q==
X-Gm-Gg: ASbGnctLIaaY6t2dr/Usv9Z28QSSZw11epTduRlNTzfud/ssutdw+ENfqjYomUJijd3
	YsHtvdZ99E/TdvO9df8BAjCAoHLqgq7OXLilLEV90Mo6xFQwNkooZlNUlSboZtvGj8YDCGQH8G1
	myTLl+UvnTuod6Ljmv0jx5K1ZvU0oItjDtan58hhzWneDWly9J4uKDX8QypvrHTXWDSo20GWcHU
	uupSJ8aPScTN5UTEUuox05I2QO7HSUcIhGWVvwJ3SgcERwGpzyjqJX/SbDHNT0s421dbIZE9cdt
	euxRKcRCaZCKtdKO/CLB4OP+XLNQx0hznPRdKdplNDnEaUTBbGQqbpRXD/NFvR1msI3r1pmFSKP
	xl6k=
X-Google-Smtp-Source: AGHT+IFpbr54K3SfdE93vU1A9Oail3ZLAXjkWYwnHo6reahgj/sU43SY534nUHgzqBMAkVdbvSdeYg==
X-Received: by 2002:a17:902:c404:b0:234:a139:1215 with SMTP id d9443c01a7336-2366b3c2d99mr114617475ad.35.1750037586747;
        Sun, 15 Jun 2025 18:33:06 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:06 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:05 +0800
Subject: [PATCH RESEND v7 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-16-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QZtAIOFydNI0UsOg3Wz7XY2kVVbbfBFx8gW
 DWWfdoyWRSJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GQAKCRABygi3psUI
 JIjFD/40KiOG42X4vGHbzrl1x6NHjCpJkBsofgm/VOP+pjivJpEKor59cT9VmSmAAOEfNvdHYV8
 WzGZd+Kbavq21FyX5zYGsiojNaSpnNempliFZb44Z0+jc3Hta6h4bFs+YEb6aF2hDUv5wx4tY25
 jOVp7WRjT+PNExOpKda1cfbw1ehdKXCtz/TD4gIIjDlR8dkGp7cOuwm0A1rNhTwNNKclttSU4Z6
 dvn2o7Vwg6v+GYgLsvtl6RojajsSAgF0D7reCZtCwJWpeciZB20XADA7NUywlgRXV+NXGgRqCMp
 CaKm7m+CJT7wAd68jxuwRpjVrzNmNt6UAX/3mpvs5moscr8ZOs8PpaOGfQ1aWBFGpjG3uTCI39I
 m2O9zrH7SDb4OhbPLMa21Bitr6hH1CgN4ibcchAwv3Erp8QDT32CbowiWMm3uAXolH8EhWt+UdB
 DNvwCgVlyZKX3qC6lcJZT7EUcWpR8qL/qJU5EYyXy2Uc83TPx/7eKIC5yEZbZbXHuI1nRgcIexI
 ymKcMR/3UFRSVxhGz4OH/bBpt3txEKV5KCPRo/Qhe5y40xpxm4ADYhf0MauI2pUDt3w02545205
 eGYsvKU4315MXpZNqdm2lMoPk5bE7W7+NA1A3ZyTGbItjZXzFcOSPrI9zfrGFECEKAPsSVfnIfX
 37XFEWHlYvooq8A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index c0e9ae45627c8150bc0ddcdc1e6ab65d52fa7219..56ac6e7f3803a16beacc74764262b02c75a96fce 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -167,6 +167,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s800-0-3-pmgr.dtsi"

-- 
2.49.0

