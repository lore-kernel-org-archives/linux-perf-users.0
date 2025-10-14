Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326242FFFBE
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454329; cv=none; b=pGjy0a6mBzgKheH8Ipj9Wb8tGzvKoMJgFJYqk8cefLZ6nLMI94iZ8SEgFOWoFqAAMFtWP4ZGDQ8W54ClF86KOpNj9aW6SmGLZ8RkGiO80Rz24Ro9FwimJDDL8W/ltS9Rdl9d+L3qNYOv1XvMEHkTvFIbs0gkpHJevNiQElxA4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454329; c=relaxed/simple;
	bh=K4a8tKqeVL9BaqFzY33bqex26zqvwpxkE6HkJdl3Qlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeFbnjrdJO5oDqZg/haFjY23E5BoSety2K3rRknhgwi6l1NSXwK2r0UiWo3DPafi2hgJY1zyc0p7URe73f+J7mosIBd1Pe3C944tlXJqgtzQ1wxkI83n2dxtP+KIHCfZ5EM+N4obCSEFROY0DMqslr+Z0BMWKwEb289B+nVEoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNG57BsQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNG57BsQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782023ca359so5576847b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454326; x=1761059126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7llkAP8rKH/Oo92VHhR1v/h5PxCOy9CRKJV3/2nzc+0=;
        b=PNG57BsQHnDfnWQFEsYNBNEC3iFvC9hMPaf4vC+eVhFS7uGMEbLkdDFVA8e8FZSghJ
         erkbrpniFlCqxXXcnbLNY80aPJ5iw+6iLENb93LFh4KgIQ4uCjZKuRRb71gOO67yP9ZY
         nt1VEqJKQLV/4DX//35aO82iq7joRxNyYjP/mbh1nwGm1Orqbub1Bd/Fc33ZFBo04IsP
         Jog+AkeAQF6ojjnMURl4sbOJ71VfId+X3TFdiGitCe7bmRyssK104DuEtsfQruzCp6GD
         DCgCgAsl+rfRUJMVFVOAxyfG/cggVhyfwEajRFpO/qsheOVrWo8BCI1/zMUaOn4ZJwJ8
         VyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454326; x=1761059126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7llkAP8rKH/Oo92VHhR1v/h5PxCOy9CRKJV3/2nzc+0=;
        b=a0JQ8Y/2m3Fsz28p0xstDdNt1ELRu7qgadJtiY5xhz3zQsOKP6hQrkAVK1QrguHbEO
         dkOz+NXiEOSnmh9uuxHF5PuHXq1w+Fp7nimFcT4WDDtuDAae46M1FZ0SjBSECuQGSxfv
         RyRzw+FIZYTOMl+dOIbDc8gS2O3pxkWZW32MaLIH8i79Q3tWfLWYYwIKdpCSsoB6rEcN
         xfF9XHFJu17swGU3SvJSacAoWkS+kTkWlq05vbULVvEsNcp1F7ziVYqDe0ruiWRrfmeL
         Z68lStFaBWQZrVKlpJudoRcAcpuFp34sNm7lJvRzbzHnnQh4zT2bBEpR5OCLgswXxDwl
         55QA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/90mY0Ha70EFjO1iRwDMrFn9MVd6W+2y9BhsqFCuwNFOX/8golhMGF2tfq8PhqIcLBXqMwYx9mUYrMN3nXwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMSkLLQvGmnWYCPhdNT9jNk3M68cLuPD70lYcykWFzzQIobcA
	GbtZOiV8jPTSDMl6ESx4/17B/lja28flfZZtW9zMVL4At9QZ2QMRIqqE
X-Gm-Gg: ASbGncu6j2YaRG01aAyia9ri9CYT6h3t1XMd8Bw19LpdFnQ0s5GmgqtywdOL5VEfAvD
	urSWgbOpE9df3sg/rrk3WW68FNQyo5Mlxfv1W0Yhr7b9RYiTfE2X8RuRuQDuZTmXh07FrZJydZO
	G1BsTD+imDlcnxdgHQJfDLjh4LBKeSL4hn16rmR59gRBSg//mXUyOqsTvxRTca8CCc6ABTtztPK
	+tNqwbzuZ2vJ+aJZN2qcts9pEEra1r4qgNz/j6ZUHKc/iZIunAXP0VYs4JmOChwJ/clOLwwpPPi
	CVnrtVsWW8lE+wLKmkiqILRGTgBdlo91x0R9lylKrM89jXOVbGyg8Jhg4XM0kSUI+f3wVftjn+2
	ZOpMuuHhcLKvbedtkJ7NCLAM8mW9d1B8FxDdz9fTwTEw=
X-Google-Smtp-Source: AGHT+IE3NxAaEns2gk2qdEx9c+kwoggzTSTvFkrcp8epRBoP1K1fTKpenPt9+hbz3q8VSwNcOXWsnw==
X-Received: by 2002:a05:6a21:6da1:b0:2fb:4ac6:6662 with SMTP id adf61e73a8af0-32da8139364mr35196981637.13.1760454326327;
        Tue, 14 Oct 2025 08:05:26 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:25 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:52 +0800
Subject: [PATCH RESEND v8 19/21] arm64: dts: apple: t8011: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-19-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=K4a8tKqeVL9BaqFzY33bqex26zqvwpxkE6HkJdl3Qlk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZv94ncF/y/perEeYBY8+y70nwkVMNq1VRMG
 6Ac1teUQH6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbwAKCRABygi3psUI
 JNd1EACsHjSDCSxZDW6ph7m64UGBZOj0NCWE4q8pP2G2+ojKWdMmmM2B+m+uPXfdxyQBGim6jbX
 ef/OEysjJkFl1lD7pueuCDnH/yOyiOAJtf/Ew5BJVSqRc0pJZKj9HW1vAcjuBO7s/aokKO2NdbD
 d4PFX5dhOZS6dY6dZddHT32Q/r2Uwa//W5LyquKm14YpY2pS/7IEg7wYeyuHCjrVPTQflRtBL6E
 2ZobaDsC2cMVo9qt/PTqF/EzIV0p5A8i4DLHNdckv+R2mivu7oUEXlJPeAygORYT5jYE2jc4sns
 5TS4B2SjwWkf0qppUxUXj7X15U8BXGdkC5M85omLBRiXmFCf2vuvLBuWQ4LhS4CKpi3tXo4HQ3p
 VJyhn/yxyHfr9ZSbO2a3GAvmPf3AIAEInCD3wSdk1ovr9s/g+gGuc5g6ElVy+Gtzm+gR8pWvl9i
 A4bEcW2QSi3HRMk31eW7VKeCYW7p8FwRpb4YrQCo0u8Spfl1gzXrcC2oh7Ar7L0shlvfydUb/XV
 sWSMDoN5aeGNmjzkfeM/zmfDchwwRt+w3Wy9TYdY/PNvY+x2qkul2dVhGhw9kla/78WbO4R88Nh
 vaDg3NFpU7aOxG+r47otn04n+jaa3zgkV40PVqL6zg/mfJZzQ0VJMXs5lD4tG5HvZs7uLmAnvf0
 SkiHDA6Dxhfn4Dg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodse for Apple A10X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 974f78cc77cfe28d3c26a52a292b643172d8f5bd..ac203ac4d6eca75655cd590deba5c361accf2375 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -253,6 +253,15 @@ timer {
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
2.51.0

