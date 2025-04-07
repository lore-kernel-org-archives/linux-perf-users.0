Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F962288F4;
	Mon,  7 Apr 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001229; cv=none; b=BOJvagiZ1bERB3E0KaW7aV8O+33YqJtCKQdzqtX14buLYKd4xwQXnFeWANf7uP8mYQoLzc0wK5L3NPzPnRC+WWZjuiOr+IEIoYH9xyFaqBH+478YMpzO1A5RNrY5jmkUCkzhl6r03+hBlkboEvjxMT7eRl9KjPfBUchB5+ADIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001229; c=relaxed/simple;
	bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OG7R7MDeY0Vm4avUsBPc4IWNEaDCLSldcwz35C3TOwG0XsPid5xXqgL9ayrtqi6Fcug/RmRdjBs5iw/Oyyc67tJ59B/D/ianmKDr+nYwTBpFBNRvtulMAAM73M6rijfXSNIhz7oMbGkjZzguSu4Y8cdh3cDg/9KnLPtEgbjtwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WamUPbLO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WamUPbLO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so34159845ad.3;
        Sun, 06 Apr 2025 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001227; x=1744606027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=WamUPbLOujnq0RC3uSN/oVKVZfit2iMkrIzkvUna17IjZ/2DYGAXFYkaq9Dm77DSw4
         UnjF7VvtQnDJ4h9Vsc2CsAwq26Wtfn4o2MV7ZAm2DiWiMHn4t2NnKjCUupScgFEVjDQT
         cEyFoG5XGVgkJO6IXhCggL6xE0J2onqDhugqlmE0FEZ4zilil7ovASnbXTytWPNYZzMY
         06JAV9PYykDW7XaiBObNcTaqyFYXf0R3r/n5i9behCIiSWW6IWyrb/SeodiwhCB4D9az
         ULL97empHkRizr/YFnadfZUcVFP2BvTwSH4smSWoKxtC0Qw06LTk5mfFHy0OGAlAgewy
         T7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001227; x=1744606027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=YVFLaoYWgWyMMbp82v8L9T+BxuUXTwD07im8txSLEqNjBCVYARlvkTiFNHkVqyLaB8
         R+153KZJm6aU6czMNH1YjXK6XjoRdFDPE8J6FIsl3W1tDaPuUVdiAWZ9iRvz9LKmtzQe
         h5IfGwrBgy6MNyq+NaGV4WafkU+CVT92lX7OiuLYi5q+3EO9s1AQKMp+M+ohIaO8YW2K
         mwubMuJdM31M1DeMny+yA+duV40Eqxql5Ccd205QLD5devt7ExCBsLFeJlsvrvTYHX3A
         cgrgj6DfKF4TrM2hWVqMDU8hSHBU+Wkk02KefrgME8agIg0LBSukbQ6TL9tjmifrdrsr
         J05w==
X-Forwarded-Encrypted: i=1; AJvYcCUl0Nf8wDH6NIO9QsdR+IQPkLB6nWDaZ1esXAKYXUgoA+OLHrcpZEkjELCLSVW6r0SKvn3TWMj6W6DX4Q/asMWmMw==@vger.kernel.org, AJvYcCWvqFDnB6VxwODsUpkHhlcuxiTn4/UThW5duiVyC0dWDEPB7oV6u7R5OYOVSdRuBFwMoGVQiGd1fXjEOI2g@vger.kernel.org, AJvYcCX8CAlNr6KPsc50Tow4vXSx6VJtl6mLemksBXcUHeP93hmsT+XuMoUVeVsw207aLczTfSu04SSri55d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08vGzfpQzoxcsU32fOOhkpxouVoLY2Kd+9xCUxs1gTpM7l6sg
	Sts6WZsYKDBrGI/TQT7M3JwhEYq3DXTqZi+V9yxFPDM6P3wzynxR
X-Gm-Gg: ASbGnctvFyrJBoNWT4O9ZC09js+10qaDckP40HtWDnpmR210XHrAJa527pBQZ8iZOOZ
	i/d0N/zs3EPDGiSoMBEStDbCztxJNjmMXPt20TYCmvmB/j8LIfc+BqWFM7GseOASKY4b2bZbJnK
	fJ25ysT9SMQIvg/GeYRTM6xkzA+WXme+6SR9F20r+yVchTIjNNf+l8f/hpH6q37FWYjvkl0uEcU
	b+c7NZ6rXKs+/okSoyx5MtzmHG7f8PhLUkSSRkzxq4q2nGCtUemjcafE0ykflRON4bkAv2e2Lz5
	obBWefKpbNXFoboZK/694tBNx21PElzypri61COcywKRWhM=
X-Google-Smtp-Source: AGHT+IE+DE3EWv1aKlh94Bz8JA4seu3KmM9WM0s08sjhFrEsGSmGeJUNiSmwpLsmoUUQY8pv5LSvsw==
X-Received: by 2002:a17:902:d489:b0:223:4341:a994 with SMTP id d9443c01a7336-22a8a045de7mr125661005ad.9.1744001227288;
        Sun, 06 Apr 2025 21:47:07 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:47:06 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:28 +0800
Subject: [PATCH v6 19/21] arm64: dts: apple: t8011: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-19-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iIDBYKpxvsCOwL2YFra0cWiIJPhOHO7+VIH
 kzb6LTpKzuJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYiAAKCRABygi3psUI
 JA7ED/4qJeX7OAK2IxaDn3lKAvbwATBH3e9eb6/T4aEt3yPf2dphL2hEPRe308zOPQgjxDdRwgu
 VTbRUMG44ch6lWi1op3uRNWG5Hz+C1dfV/gPmJ5PcBJEIup+xYIgSQSV/v6I11H7oODuzcnwFSU
 p2SrthI0VbLdpX0U2QevBc/Q4NYvFtcijRssy6a+MaBIW1WeoPBm2QUDj/H4rlKLJQ607KSwIaP
 uNdX+P2cXjJj0wErJyWbSEQqgm+MWYiOS6TGIZSn3YaS4Kw8yTG3wlQIF6+Ei9E6hulkfzabyrl
 Co0dT0cXQXCfLI1vmpGLgbUohPBf3EOTmJe/6dUfWTmdrf06Vh5lCAzLU1Ks+EHDSk92ayMh4tJ
 STPc0re8YtkTUPG6N3tYltGJTWJPS5gUniPl6qugSHTXJF4eEvj443FAqNVrKVy8N6PJIVvFkox
 jWa04QGoA9EKGADBWqNfe1K92iCaTeMfXHoucWH1Dd7qKZ3dnCXzspLX5Eo2gszqq2ffsDqHZnw
 9jOhf7wJVt+OJEguvxiRMZ+kMeVSKIrjTlkQmTY3J1B6vxr/Iz+zZn8pJkA1DSSfbzMXRWhm+bj
 BSeIWwWnW5nonD49y54h1L1tjgV2r01C6ZxqsCSlCnlqtWFgM33gsodoOgIfl00spTbTaKNamdu
 kvcREvQW2nhXT/w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodse for Apple A10X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 5b280c896b760dc8b759bf38dae79060e34dfc19..7fb3ab738f67583d9a19a542bf36ab2806268d55 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -237,6 +237,15 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1 &cpu2>;
+	};
 };
 
 #include "t8011-pmgr.dtsi"

-- 
2.49.0

