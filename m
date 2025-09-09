Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25C320CCA;
	Tue,  9 Sep 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412772; cv=none; b=F9MCDUL2EY36Bo2NVQUp8WdSycSAswOQ8Co2Rw8RTtMAZa5/lEL1y1F2Jm56gUMvLjZFzbls+mYZPLkpKmCNjk/OU2inRtwlA1tUzEigegPkhjWhoEiyWmi3QcRW9NBAioYwH2Hvj0MGEISxVIayoIgi41DautQxlv1BULmfsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412772; c=relaxed/simple;
	bh=RtdhzO6P9ZvX6WJwSMLms7Y7sv3jFsFx2qpOpQIASFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rnakf2KZ4SJ5CQO4YAzKWKdtTZsbAu0VJt+8UMkK/4ypviAjs4QSttUKA6+L9kxzJnznxggqxM+eMSOu0Ie8dORo0B4DbjiJltc1Xj+kDTfT0DisrnhAAccyTdtZjZFiuKew58ZwNv0S9z7z3CtsZBeWz7kSbcdW3elZKRHjSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/S4h44y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/S4h44y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so21603225e9.3;
        Tue, 09 Sep 2025 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412768; x=1758017568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSHpkOd4uK0+LGgGfUUkh18hfW5funXXjdKKM0dPo6M=;
        b=K/S4h44yFC4mIsQZ8Lbxlzy40ROSFAYTcNXAqiagsOowI0ORBnl22QlszcAleSP59q
         WDM/yyFvLRPOQitu+cnOftGVHNyjIMsfYJ1djCbNj4GBy185IAmgzDqG5jShu5TPe59b
         ZxYcXRVPRvo/y/gRalrFsgRfcr7dGC+3FnXddH9qBLIbciY4oEt9Dx3NMQT5F2hLzgt7
         cIHjQP3bfjfgU6UN0C3Nh71DFPOaLchqjTlrMAhNSmFxWXTjDpTcgPQN1U1ulpgZuQrr
         VtL/oZZMxfpWS0aepLkSq1s8YOGx5VGhVL3UPjjIVE4w1u6OCtThKC+26WDKKiJeZJqc
         O7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412768; x=1758017568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSHpkOd4uK0+LGgGfUUkh18hfW5funXXjdKKM0dPo6M=;
        b=Rr375TCD3aWFRtIzvUO3ToFPtj7HJrux8oByp1yxoZH4oYiSZF8CEhNTHit1sVzhm5
         6TYHKVcsZOBPEm2iTSrXlCQra4ppIz6ucWMFdt5LoVUAuyUDVY7GuMp0Mx3aFR/sVb/d
         gNkmvwhQ1o7lCPKp4hswhjk0y1InSRjoKCxjkgCBnCjNfSO1Og2xc8nCykgtMcZzLFEL
         iqXU71pK1ADbDfEgFTLNM4xuFZKpjLQwYOnsc3sVy6b05MLH6hfZfInHma3+XenaQnz9
         wpxg0jqlnEkUUEW2kBXH0kgYSqINMrR8UA4Nm6nPmeK96Sm2g7TONGBCluhZmeXf72H7
         2O2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHcNAHjMOcmOu/OxMtYhlSHKSDC6gJbrKPnjAWSh1I4jFoGIB//nMh1eRC/FgWwtr/8RnqENWkvNgW@vger.kernel.org, AJvYcCUhmPZXWzN4mwl19Ep9MKLWvykjvV9ViNTEN+AqHPB/FirJhYg8IHehOT7HtCXK+/9pikG3/yy4ayqt891NCe7yUw==@vger.kernel.org, AJvYcCVR7EaabYg0n3JuRU+L7X0htzQH5n/ANk+EHoH2U4sBABhRRVuJZtqToTM61dpKhbYtEmPXJnGkE4gnCw39@vger.kernel.org, AJvYcCVTQZ8k6OtoyCS0Bru0W59suC1HrYU43Y/YPKQvCmgh0C3e8P7LnB98BprUPU/J5jqRZvKsrF+MrZXJ@vger.kernel.org, AJvYcCXl0y5G07mU/7RrW34ZeTwWPfC3eJ0/8kNf6stKka2l0b1G/BYxKFsPGT5cKzjFaUkBNALNwfvvDXB6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcy4sB0qnm2iBrbYUuk5JFJmbUMIPHnHYY6VXA/vkhc41cH2O4
	zt+jZV9CTptX9Y96wle5ee3Y67zG/pMDo4tbch2tpD0zP3Z1e2xeMCBg
X-Gm-Gg: ASbGncsooT1svZcrBszlWAoHVLO6QA9oVTA0NXj1QmpgiVCvOftnCDaMP7bm2v/VqbX
	AMtRIAaTJ58yXwPUEOvgvVvF3PktCol23VtoZnImnR797uspbD8nA5zwqHdoZu/5OJ7Wjy5msCq
	J+d6vfvRMwIhNeNtjzW8ikWRXxnyI6+v+4WNDMxqwFLDLBijIdom3xMZS4Sv24kyLxoTy+WqiqR
	ajHi/uPNWLfXThlt53Dpa1f2s+16C31k+fOkawuH6Inw3duDadpPEWzr4KJtgBdUaK0WIJ+Uw6Q
	tnfCvQ0wmAsfU+zdQNXStGCyfd063kEmamWvQ70gEcTBS3SJm3dXYyvk+OijVnYxPtY2kI24VHX
	s7qZRJqw/SNJD6NM5kPrmDplBeaDO6OYhyGNbBhbdeKLWeCGdsdw6qt8DEF7wkiPcu4reSQcESS
	HJpT00Da6gkTsSrA4=
X-Google-Smtp-Source: AGHT+IEBMPQ+x6q1DQHn6tfQDdXdqZ5wpu49XiP27S3xqO3Tqwiv+/CrXaWQp/nERl98m+vIT28Mxg==
X-Received: by 2002:a05:6000:2003:b0:3de:d33c:60da with SMTP id ffacd0b85a97d-3e642f9057amr7829659f8f.21.1757412768431;
        Tue, 09 Sep 2025 03:12:48 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238820sm2018879f8f.35.2025.09.09.03.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:48 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:25 +0200
Subject: [PATCH v6 18/20] arm64: dts: st: add ddrperfm on stm32mp251
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-18-ce082cc801b5@gmail.com>
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

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP251 SoC.

Keep the node disabled at SoC level as it requires the property
`st,dram-type` which is provided in board dtsi file.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index fbedf23def52..69f0276d3324 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -2100,5 +2100,12 @@ exti2: interrupt-controller@46230000 {
 				<0>,
 				<&intc GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
 		};
+
+		ddrperfm: perf@48041000 {
+			compatible = "st,stm32mp251-ddr-pmu";
+			reg = <0x48041000 0x400>;
+			access-controllers = <&rcc 104>;
+			status = "disabled";
+		};
 	};
 };

-- 
2.43.0

