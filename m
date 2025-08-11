Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BA218AD1;
	Mon, 11 Aug 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920588; cv=none; b=eUWR62ALfe5x1qLuJCJYffYDax0vYxWuFq1FXBZaPAvtupnBWf80roUduvZGzlJBRNgJeRMSXMrWY6s2epiKp3X8MEa0hlKgHrqdXCsr/y++Bb3zLK9yg3qRA26xcZNrP94zHdvyNcf+0hDYhCuCsxNpuhhDoAMNAdIzHWPLLmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920588; c=relaxed/simple;
	bh=41txjamnPbAh5QmdirJplHpDJAfdvJArnR9bCC9UlxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hm2Vf8jjXVxFoPAKIaDk0Gw19oQjLBrmw5KJabOjfUu5IYDevpkd9hQ2WoWZxezuPrSbhYFqu+0jNqhlNv7tl93kCe/mU/ihKPZXRn57JtxMcS9QuFcUjfdgf6VCv5mZgKac2NSrKf2+wuqUbWEZCpn8bSn3DALzMPnrBehRzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrIQM4Q8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrIQM4Q8"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b6422756fso6116981b3a.2;
        Mon, 11 Aug 2025 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920587; x=1755525387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzyO9TBVlHI2cPtgob1qEX4Sc7tYhu57JbOynAF1T00=;
        b=NrIQM4Q8wJjrKwLim45sEwMB9zjt3nKnI+m6Hiv0NbqVwc/dqe+o1rGYFzPiClnGAU
         s+MEHLli1Z+mz0xsfkbOZ3I/nkNVgRdg3QYXK49mTikz3kl8ua3mYuxmRaXTvcQgryek
         t73CKXOBmKYKIRgAb3N2tbiNqBsv4GUQt7LU1miTDBC/6Mp5yJwsUW5wM7HvO5rSY/PL
         WX3bcSLQdqmB7tNzkhZ8Ix8ZENRt8yVrkvHGWIJk7Wgb3BfzLJWpfj9/J5DtKgEk9R64
         BYBtuf1hXbEbTzHf+X+GuPS50mHovvrC+aSEoclRKp/xQvpzcFlKow/DsV130Pd7h6J6
         bSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920587; x=1755525387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzyO9TBVlHI2cPtgob1qEX4Sc7tYhu57JbOynAF1T00=;
        b=hlL70BMlYcq267Hmr9IY5C+Z78VDQTTdrLp4jWcFQvADIuH4qW3YLvXPwtNuAJyIH5
         Wd4Ae7RBAus8+6qANfsv6J5amiTwOEBtlFv99Ga5rDT7fN017GSUO2SuXuDu+bnKxDEQ
         CppbA92/UhWij43adgMa8IXhjkivOSQrECC5dr6djE+eNDEprt2w1k/lYxdmCweLKwCo
         /tNYy+KA8ovnBdxX5vxpWuAdExGeWDALnbHIDx6shR9EAvpDuQSaq2Sx240zkIcXVhPV
         10kumYB4dgg5x4kmTbbtFb+2C2FxLiuTW4a5XAnFZzcPTCosGWe5JFfavxTcva/sWVcm
         5JUA==
X-Forwarded-Encrypted: i=1; AJvYcCUTmgkQxx1tmU04nmpUJf5ybFCXLufnuaQUi9s9YcByGeSO34zbw0vpdXSCF9HC3WcB9F0FwwgTMRGGjs+ZU0699A==@vger.kernel.org, AJvYcCVG703TFRBI8tobhVT8AYsEca7OP/ms7uQbgeeozi9kECnSXv2MqxstTzuWzNshNFU0QZqlERUAoPDq@vger.kernel.org, AJvYcCVqUz6Bcrpk9cpEEtOCyve+hf/Sd+9oJqTXzvLmf2hJkhHUMZ3NYTlrFwxk4xFos4dqDF8fPP/NripM6Ixq@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDOW8wmq8EYJISEvj918JmxNz6UHbEjew+xvKwG/HEjiIkoeB
	YrblynxkOmDMvdgnAj2cwaiSWh7ZmRx2TaOnCI0j3oxC0L8TMkPbaJD1
X-Gm-Gg: ASbGncvtNEW4tyWEePA5GWX5KOswKmDSkAC6Z7rWiIdzTu0pfX7eeqoTdK/+KUH6Le/
	9ibLj5NeYRSMW/ZE00BWaGLDDF8lB80W0i2vWtBz9m52JwASG7K7T29dJ9EvHd5sm6v6rAeqdTn
	G7pmsVf3LknlqmM1B+SRLw2Hf+T3wWWa+TEtGU5leLH0kcBEGMxRtcOe8jAgFNQYRGLqqsEpX2e
	u3gKb9bVSnnV+VEaTmIcmw2W0J0SxmpZnAdD4z7Ktw+/6oi5390cYC00Z/jmy2PTj81hONOuHXE
	678zmenl1y0Ft7HzFtIKez5nRiRiNc/wHPRJQJXq0yk+orqMq/Ls/PnXB5qG39rfAcmmaLNK3hz
	BTGqXs9xT0zBSdHNXf/RqJMmt3uYQgbuEYBZXzq7ihn0uoKQ=
X-Google-Smtp-Source: AGHT+IE7wVIulw5MzW+7jFqgGJ0yHStIzq5ClP2ToPWDlVbvfo0lp387iCzjoEkRqhGR8ITPJDgzGQ==
X-Received: by 2002:a05:6a20:3d19:b0:21f:bdd5:d71b with SMTP id adf61e73a8af0-2405501aaa9mr19625402637.2.1754920586681;
        Mon, 11 Aug 2025 06:56:26 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:26 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:46 +0800
Subject: [PATCH v8 14/21] arm64: dts: apple: t7000: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-14-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=41txjamnPbAh5QmdirJplHpDJAfdvJArnR9bCC9UlxE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZC6TjtYbWMvMGxoQaVIB/WaxX06xnDnzpev
 Unuhtp3YryJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QgAKCRABygi3psUI
 JKb8D/4hOvwHwoiF6SlzieHwZqka+hBILLsAnmopUlq94FibUzyOY4GVXOlX+aTz0GYmR50/VBY
 pqkCOCcRCjE7yrC4uSg87KWES4nN5pMt7iGMQyuGz2RZziMnPu9LFXy57ekbi9bQ1suG8icWe0X
 igbooTRnmvaWQcB2iLYlsKPVawrIjmkoaqyE3oWGwvwkDmqAZ5i5NKbVyBiYLPD1cHOtqxOPhwy
 wW1EAYmxk5XCjeNLOXzCTk8w9+TLgssDNbN5T3f4wunI/nL00uXEakkDxQbWzx/LScNCBg/t0ZS
 VZvZbpSvgLeyHgNje5hZX1tN92BC2CxFUP/olz1fQ6XW9oJDWvGdK5ezj8QDNK/o5/yEFQSrF/z
 Oz8rgBNjUi2gnAimdos5DxYO6O3xOEzwHyw+n4stMctffs9DiSBGxqBfrpCjU3npnsRURNlzTHS
 fu/q68vfn50UDAHz/XiRcl+Na71+JUzEE25BADPf6x5fXBUzl4ekPkcM3Hn3Lx5FhyuZoKwo9td
 B2cqNfK6p5X9q3JxSoVwE56I1QtBSNzKzGRmNl3sfz8s9xI+OW7Y/8tmWx1ODqs1fN0TkmzejPk
 AIOjAf3J9kqPky5MoJ3Fj6DN1oWiLtuwOmaW5VgKqGoUW4M8Jlt98+8vYbemNK3p+ybCtDMaNDN
 UkGuYLdY6CfB4uQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 52edc8d776a936ca5ba58537d4d68e153023f536..98c41473a84098bd70df86c2728a8080b05b41f4 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -206,6 +206,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,typhoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t7000-pmgr.dtsi"

-- 
2.50.1

