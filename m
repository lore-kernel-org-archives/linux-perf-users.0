Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828B276032;
	Tue, 29 Apr 2025 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898264; cv=none; b=ZIPphl2/8L/K7dysZ8fPBro+kMiGa4j91E20kiOeJ9GemeJjcvneiaNLUU8FaXkfq928DSQWgpio2J7l1FYmGVk/maRFTXD5i39gaOwuabSXFUridVM7RG3WoslabMrGzlNRerNnzZfRWHPwLm30yJzCO/JZ+3eiYAR79Q8nDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898264; c=relaxed/simple;
	bh=LZ5pN5iqWz3OCuzIiw27nZWBzYhm/oPtBhWwt5qbJRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbm1HsT0HOZGdtLQMeyc36uKK4uEEi70nbkSOYlwPMoJZM/XsG0GBAXMKCTB927RMyiFU5jNYHUFIugBq8i00WIsVRLtZWrPN3X+P7JWnZIjs7NhXiD9oRjcSWfKkuFjjzI23coWK1hYdAJy99+GAeOvJke0h+Vtxyg2i920+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEYaCFks; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEYaCFks"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736b98acaadso5266361b3a.1;
        Mon, 28 Apr 2025 20:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898262; x=1746503062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=DEYaCFksrSSZkfC9rhCmx6ZCFK8tW81bYdnOGqR+okyvvoKTUnjFSmzpDX5agn0UmG
         PMI/UtI074O/4ksO1Zjmh3GbfW1OA9DlEzrJWlwEexiIsMpDcqOtedPytr6qHECzxVwf
         FcPJjEQUqtJ/mHaFOGrzx45hHgWZRUEB0pDSDLDx1DMubIPUEtYMg/vcxPx9wk4fyGuG
         WM+ZAUrYDlNaQiIPjEU8pMYNSr0agavj9N8rfmNYZ85g6oI7hleo2xf8hDHIJ7mXxBLv
         Zx2wnIB5eGaFdenOzd+7lZsZKadkGbYsf0ENQVAlaVV13s/n2U5POjSzrInosCqW6DOx
         2Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898262; x=1746503062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=OrqpYCAAUJp+a8gJBux8LVQHvWuv88a5r3OIG1W9CcsarNtXJLuKxI/NEUtI7DWhUC
         Yfc+vSTlvZMT1SeY1/nilYrcgOzk8IBZyumLU1yxW39ik7aEhJNNOcQDrJsJc6Xq3JA4
         77RvWwrFLyWzpnVw5u57LLvSGmQktjGECG6BPoibzb7AJDGoD6HcIMRvNoWQL+KF8T4D
         xKZXobD5tACSMtjx6sZ3bquL+m420dbnYmNmk6g6YgdESezwpQakSTxKfN8rnLH5Cohu
         pnjtor6Vsf201wrHtmnDmihrivKwM+/bcanVQadjLdDF/1RcFGWmnvw1pZc3HeGPYZj9
         Fzeg==
X-Forwarded-Encrypted: i=1; AJvYcCVWyrwLhRN1uRL2/CsricsFiM/SMshENkPWQaemOuYbvCvkmDgPCFoGT4V4i1yMVW/37Ixn3N8J13eB@vger.kernel.org, AJvYcCVgURsow5h6LqOf8dQ9X9z9ysdxfs0ftGAbaHVz92GjQGjU8yxfmRNNDLWZaYLOHr+0YloMUD5LGS9+ByraS6FAyQ==@vger.kernel.org, AJvYcCVxc+bphcMgCw/icmpk0ZanrqmIRPXdji7eawZOHLvkGahS6H3ydrdoWJhCsrXKz3kbWFTzMteUQO4IF/JV@vger.kernel.org
X-Gm-Message-State: AOJu0YyghWiftDEwLCjjN0XyNKCOSWiyHNX2nm/UiN1qGGts5V73X8ZS
	R4MchF1BxES0SM3sCfB7hwBRNZQ6TN1ymiRCyNTGCPYBX5C44tx8
X-Gm-Gg: ASbGncsnteosXjlh/KHYNbtcg9bnZ7G+vDR/ZQOa1q8XO6YBrauAdumPRbZGwPz8Su5
	kTb7Qkz7jZQN0t86Z6cXJndlejuwzwtGEsjXUzmNz+q2CdLR7wGdlsj7yRdWYwCxlto/aA3st+t
	ezuSdqyTP6d9YxvH5cwc1Urwty97+I1jZe0vPOtDELbWIEsLUq69TTe3fX9Ym8a2nBISM+3p8iF
	r2qrk4D8cbkjQ2Ex9j4hIdKD2WIGWglt3AmiLtw27kxVlq/tPJWivYgiHiXZG+rKkVKn4WqVm5E
	HSBFgdNfyCJ6iq2n4x/I71C6FjEhjbg82sazwlE7MCvee95Pc1kMZNDckQ==
X-Google-Smtp-Source: AGHT+IETjuI0siCRS9u2pXvps9EUIDQ4wR7KluYQHkBdrJXS9KMX45n+wsExNcKlbrDR5a+B01PX7w==
X-Received: by 2002:a17:90b:2750:b0:2ff:7ad4:77af with SMTP id 98e67ed59e1d1-30a23de91d4mr1580390a91.20.1745898261883;
        Mon, 28 Apr 2025 20:44:21 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:21 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:37 +0800
Subject: [PATCH RESEND v6 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-13-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=LZ5pN5iqWz3OCuzIiw27nZWBzYhm/oPtBhWwt5qbJRc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErlfTyUVAy1ePsjHsSm1CJiFAxVuwctbhmdB
 xH4ukXVRrmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5QAKCRABygi3psUI
 JEouEACzAD0sTgca0HLK6vqrrH2FMirQbIejbUzE91zU8/GE8ilbJPoJabc4+Yqgc20c44LHZ0A
 Ak/TsqoF6C9ppinHmYUuu7YiRF1vsG0DOgF+Ge0crlrxgwNyh5bk9tBPKkSjXMZ5glfwNI2i5tl
 h2ylYSy9PLj5CrKZJ+QQ1Lw8a+1qokfSHdzYMAxURp4fxyScyjNFCUN/ptIMaSbZAf7D/64EJOy
 BNH4hiqY4W9d94cr58UUxO7ZPxPQIDfKEJEhpPuHMix3Q+nBcAB5wUZEY1x6BGR1lYyzLrSqCW5
 aV75k4SHDC4dfLA/2QH549hkVWy48rSYfcpuVhdsLl3Q7NjJobWlZ/GP7/6lt1e0fZ1elGXxKRj
 ET+Y6WzpGhTmloIPF/Eci/U77IVneCcuO/DzHCXFtWCjJwBSMvnsV2mbnUNf09Vsg/sVVNxbcsJ
 0ngrGAEc0KcbN26+f71/VO6bMG0l96zXAm16BTklsWaFQ7kZ+M7wMg1L+vghuFFRnrFdM5kgOIQ
 FmsrgdzyVDo4B+buorhmXNlsICqKg5iHCYFhWPvHwXpqoTXVVvJSYa/K0R/y9+4xLXaw25929o2
 WvZbnvYdNrSeyq2nXtwnvBzrNP3QpY7YFMZCrtDNf9xAYBheq0y1XIn0UKHKPvR4FGy24DH9KLR
 i3JkZ6ljQoCI1qg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index d820b0e430507f681a5f2aa13a498be98080e1db..62d528d4b7204af28b66a90d68e27e1c78e2df26 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -138,6 +138,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,cyclone-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 181 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s5l8960x-pmgr.dtsi"

-- 
2.49.0

