Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453631A57D;
	Tue,  9 Sep 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412770; cv=none; b=M/CCBuAmRc++OruCqAq5od3/5PcyS+zqa/s/k1mukgmkzDP1Yn385qhKEcM694eRQNJqisyvwQxUXHg6WlEVTjZ3bTlGn2CfYMyN6lVq8IQDv+Fkqw4A1jvs7KtbFxo0YoEb8AqptIp6HOaZe85kLCy1JcmOTsHDTZCVcUEY4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412770; c=relaxed/simple;
	bh=PADEqRRXnGJ2fiAy5rNncQ99N3McmPE8bNar+mTVpD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQf4Lr4E1wsAhZQMEg4OMQS4BnkBG/Y8jT1r4euC9OmnKQ350yECmV751Ea11uiRaL0/zNE/ViLzFIBpLSMF7zeF1YDchCgJjBljb0Vu04k8CR7UPW727x7sb3ToGqH3R0eg4jqGdBBmQM+KN4b1g5Nc26qfcujXocJUpLLhPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwnhD7R7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwnhD7R7"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d19699240dso3819900f8f.1;
        Tue, 09 Sep 2025 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412767; x=1758017567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlK/iNZ8DIEQsXS4KP8/YUmihD2i2QrXsBZ3ReqKvlQ=;
        b=BwnhD7R7ltzHAf2Ey8mDGkJOBrGD1ixT3fFoqI6xznDoZln9RuC0tDNMb/bk0TTDgC
         O79LxBsNpMPYJpomkhCRDQVOLqWHjVfWUsSvqr5FiCRftevIQNIaLubYhax3PTy6j3hD
         xpdjgJLFpPhG8u3mH3jLl9UpsryNDJtXiSij6+YVfB3d3V0YLEuB+OFxPF8qF9tkIpl4
         4dF7yUgyk/jGVquXHPE3H5QSahM3CFlZdkkMiU7UTbfISX6JlyroLAGBtW+LpgO8qhCM
         rEIqOwbRBy27QxCw4bbdsERuUE1JeLHI2jBPSe1ZROXYUXZdCXKWGI0kQ9LUkCgobj7D
         MqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412767; x=1758017567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlK/iNZ8DIEQsXS4KP8/YUmihD2i2QrXsBZ3ReqKvlQ=;
        b=ORBEn+YykcUKO2ZggLzArkKwaCl7H9sEGglXhEeimYXXQtB/zuk3Z9SSr6N9pZt4IM
         tW1sP1Wy8Wd/wf2/PwZOVX7e7ZCGMjrTj++ElxfC4z0CSJLmpPm97s4wJDIRo/nT3fKV
         HA51iZdwl09eWo922+Tjc4n7FV4EfUbs2dKOj36ZWXmigJm6UBGdSSjtl6WYHuWldNc4
         VpaewcZU4WRf8kZffgF2Kff+cMeIeGBS+YNRCvnVOpKyJybEi6lwe3cYMQGXPEgCXbCx
         t31YlV05wp6Wph41+SVfowon8j8EuOTPyaEK34PXFoNMv6MclBSGNlAJ5daRsMObH1Hi
         qg9A==
X-Forwarded-Encrypted: i=1; AJvYcCU+rBzWGDHkBQpYPuCGH56mcbVpyVC20nsWUU/MZekH0fjhZq1UGFbKtA+HFZx6KnKpDt7LTPVHr1AX@vger.kernel.org, AJvYcCVQHKd3pHLC6xRXlxxXzKMGSoeaTR1Taist8dZgWilaW6kT1sBCq/z1emLiSb3EQ6Da+VDS0Bqkaq4FeypVz8Asag==@vger.kernel.org, AJvYcCVREfgDlnbxLqZJsvU5tAM8eKOOLogvU3sSyWU1WNS1/B+AMjcsj/9tl6HEhmMzohYHmOPqRE9ZXyhpBeya@vger.kernel.org, AJvYcCVjr6Nx1djht8lgeouzjM+AJ58n2u5yFVE4pPRH7Sjp2tBt0UgB6rrVP/r5YVag3LrVDS9MZmxRy9Xp@vger.kernel.org, AJvYcCX3TtrHBgSirRtVzB5QznsxCec5Djtj2ydHFn714CkKn8dRaKYreb0YIoIF4csFSCtoSNepmHY9+m+5@vger.kernel.org
X-Gm-Message-State: AOJu0YzmeYIjzVrCgKR9qGqoliYgewYUdsVntTpDLN3NCBu3flxrhIof
	kO40qoBViGCg4PX2K9g87j9KQNVUSLleDUR/Be4J2g7StBLCmEGc37zq
X-Gm-Gg: ASbGncur/5F9EfCPb3z238Dae9GTlwThrbOVFTaq9nf71F8Un1PNmIvWFgC2hCNMxuI
	VHogQCDIGrvJzNjtUcPHUIkAfGBRfjJ2c/OBlNRP43XPMvlfX84GaeszXiq5nUwRJbKuacDjrZy
	8VE5TPtST4CyES8rgBdG986z3jhFkCb4WgfPsegXSribmq4WY4a4k2skk/1BfHRM/saMzibTn4v
	p58U2iTPuA8+5UB1YMoGxmSSHuUaoUNvKMe8zP3x8+pvlbx7X6jYsNPiZAsEo1SUBl3JbKq8QDG
	cT+To1RW1lAppxPgVl7+JETlRwjaRzjhjM1R9QG95XP5Pfmxp8FGOKZ7ZfZL8jahW7sDpt3pKAh
	3YKokigd3TEEEDl5IIjp+HZopYrJlFyVSuTlWE49lhLi3VGTIrXgrrlhpY221f2ngU1bRm1m2Xt
	pjC9r2JvKe5QOpe88=
X-Google-Smtp-Source: AGHT+IHRIX6vr2XfK61Crfawn0MHIaaIC95LfFY/9lt6EdrZ/Z8HN/tDbVJ1BoCPFUR1QpzV15dodg==
X-Received: by 2002:a05:6000:2910:b0:3d0:c6bf:60e1 with SMTP id ffacd0b85a97d-3e305964e1fmr11645857f8f.24.1757412766899;
        Tue, 09 Sep 2025 03:12:46 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de229238fsm112894875e9.16.2025.09.09.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:46 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:24 +0200
Subject: [PATCH v6 17/20] ARM: dts: stm32: add ddrperfm on stm32mp151
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-17-ce082cc801b5@gmail.com>
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

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP151 SoC.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index 0daa8ffe2ff5..e121de52a054 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -383,6 +383,13 @@ usbphyc_port1: usb-phy@1 {
 			};
 		};
 
+		ddrperfm: perf@5a007000 {
+			compatible = "st,stm32mp151-ddr-pmu", "st,stm32mp131-ddr-pmu";
+			reg = <0x5a007000 0x400>;
+			clocks = <&rcc DDRPERFM>;
+			resets = <&rcc DDRPERFM_R>;
+		};
+
 		rtc: rtc@5c004000 {
 			compatible = "st,stm32mp1-rtc";
 			reg = <0x5c004000 0x400>;

-- 
2.43.0

