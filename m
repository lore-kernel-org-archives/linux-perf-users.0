Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9A34E767
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988727; cv=none; b=sHnEFmeX+Uqbljs+KoLFcgPV7cZY2AJRuoPCNCjhJ2hgnt+3dr1kZp0cStetzTf0aXByPpPsv2ck2lFGduYZYEhCh9npullVk1Js5a2LV7or6K4BpfKhnwIF6D7GvCiLL0S7skR1T2k90KawvBqNnqvjJuHqtquLtuigKdFJ70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988727; c=relaxed/simple;
	bh=xASpZevNHcaVzYbv63kfOr+Ypk6TFwui56ogxDHDMcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Snc1I4oLR8Eg0isNLFhKgiBy5NnRJHYq94zZWejI6pDFUstgrkydlrX3tU21ZROfv0L3Njb4aDE6W+qo1uOtzSoo8H0ss220QD/3z9RYA+EhQqZNT3rhiVOj+kfNJ7FzXfqaiKtSy0NW/6CxaDXfnogayJW1JfOBY/7BD8GncMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deR2dPIW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deR2dPIW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0bae9aca3so52440615ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988724; x=1766593524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5cND4kPk2t5DX6paIOqq4zpW3qf1DLe+UW4i1yJRWA=;
        b=deR2dPIWS9ocMUOODZphHn9cgjSSq2tQgdNu1akDzdLfYuYK5+Q0JDLfLqn++BRAaK
         mKiUpP4UX8Z7U5ZkhIKCsyMk7bbBWYJnW540XROxyQiMmkH8V0tHd7gswXkI5wFS/+i1
         ry1ydLtXEA3wIfrtJEEkciobkRxYwMk3sEo4+3e+jyiogA4+6Tu2rqsuAkzs90Sh3T8W
         nPsxiuYa2TvbszFMnjbvn6FzM2QThNkTrNKfktBSEesu9ZwB8kNnC11Ef6NLdXQby+8e
         NVuczQILbGlGfPoZWPTq+Mm3awCKO6VtqLwZ8CcFF92PXcSJQYuTdR51GDV+OIxQPDhq
         67kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988724; x=1766593524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5cND4kPk2t5DX6paIOqq4zpW3qf1DLe+UW4i1yJRWA=;
        b=U1WDQUt7Zt9FjaYc+uCwqVE8Wv35SdiK1S5XqprMn+Zt7lgZYGjMnDZUrnDvR51ZNl
         EvGkKfFoLgsQF1kXqiRjSklVKglwVe4YL9ObvWT6oduDkRWRFel1wnCkKG7skEwpCil/
         yfaOQXfhJ0svUocQn/6j5W9y6q8HhmCpwMlrOjVoTNYGpSZyAFheUC2AqH2mpQHY6BJi
         ZO7E8T8EbaUwEOPV6Xzd1Zet3jPTZyZjDT2eBl542hg7VvqOindQARv8iLUu9crsnJC7
         TEqMPgt/BXnuBQGPj/t2XTBSadAm1lXQvJyTRBjRifauLTtRRAffjD8llvHW9su36h3M
         wIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU1d0XOFB7ubJoVwVxEctppLRRWG4GDyF+V249AA8g0AGcCPJg2EM2fyVAFnz+DVmgLgEga5dOVz8nabBiMVnM@vger.kernel.org
X-Gm-Message-State: AOJu0YxmncnS70RlmyVuamkmNsOWcnSV/1jByCzh5rLIhJ66GKP36GOP
	xdRKWchHdYer7pWYI/vQeYffmwKxtnqXinBedItWyk8MQEvomWX5zoc9
X-Gm-Gg: AY/fxX6kC8LFVd77D4brfkKGqxxDwgW2j+VzJi982XtttXvMvvd9TKXYyYHZtHuXOy0
	AIlO8+3ecmyvu+dkwce18kQjeBlZgYxgkDe6MJxYqmhEjIBVCegS+nHBqM2h6Exienk5pYK5G+3
	b5Rg5JaeNfr14iC2DnlPnZH5akp9r9PcE+lHpri+adBO1hq2zt4aQUuTXeGfjiVJejO9MYQB53x
	M2KtGxYj8xYGajD4koaepni+xc1jV9GRMwrCKRkGAkDjjkrwOe91EVSWZ+lzdntsJeEks6Ft7uQ
	G02ApMuMqDamcC4sJhIOzB0ymvp15RoZs3y23n8n4fMLBjRn6lHoaqSqljoKRjjX+BEldeFfCZD
	6EA5tc/hCLkAfoxH4aC4NCvbcwU81dVX/ihA+I7wifDbRmqD1LEjEapDdhBaz1r8bU9iSICG2v+
	GoarVIHY368lrd
X-Google-Smtp-Source: AGHT+IFZoc6y1b1pXP5cQ0PFfnGzbWz6vwnhHPvENZwP09tZuV+Gdcyz37t9lePCfwf5hB/837//4w==
X-Received: by 2002:a17:902:ef07:b0:29f:1fb:730d with SMTP id d9443c01a7336-29f26d2fb39mr203552795ad.25.1765988723895;
        Wed, 17 Dec 2025 08:25:23 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:23 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:27 +0800
Subject: [PATCH v9 14/21] arm64: dts: apple: t7000: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-14-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=xASpZevNHcaVzYbv63kfOr+Ypk6TFwui56ogxDHDMcc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlCfqtnj3K7LLG1583f9fJoNwcOfr9dxkt87
 NMURcTfSY6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQgAKCRABygi3psUI
 JJ4oD/9wGXL0RPwz7RwA+udXKga6NOZMvPE6AWK2GLo+Q54NI8kf4ppSwtCkcXeBXP11SmVFDi1
 VHlNNMEA+MMbnwVnX++oHN7jkn2Ag0KGIPzLKzRiFBMID/Hz3XAN0qSstl+LGSIAQZWfa5JG9hW
 aDby8qRg8x0AvST6KJdgK6thxZbTponO5XTFoH4+kdU7YsPKN7paZodsc8aB3zi4rIeuLNejFFU
 OwNTRNwa6KaRFg/VbEnIswe14p06hGMqczn+pdw0KaSOVNFfUApQC6Ts6yOY6mhL4xU+jIJCLV8
 KEXN936EuEJUIjwaCizOwol06/GXwPQ32GGcN3HXdljSy1YDYgrVc+MCLQnWmJ+C0E4SvPLl9+G
 1kd4HV8OzPLcYpDEAJLsa3pBMXtF2pqLC4KuFIK4rzo+tifUWci3D6ugxXzYCe1uoTndGmf81Ia
 XNCc8TKqz2yueBPl08DjmJWWKCQ20tIthfhmegmGvFn6a990QC3VsGqU9mmlmpwytBr4KiRrRN/
 CC9Gy1T4CBSASNdHO+WyV/Wa8WhtFliLJ2kASnpd5rbGLk8qVIqRvV24wf8IGt4l4r6k2bzc2Mc
 rKENc69LVKhwX/UMU9aNd+zFdWv2nE4jclbhgNQK6Jjsr0Ol7B2MZlAoaBvM53PrteYke4CSfra
 nWAG6vi3ijyme7A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 0342455d344474d34f7924a089bf5f5915e68d55..a416cf8204173d4e45eb7baab42302eefd0e55ab 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -282,6 +282,14 @@ timer {
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
2.52.0

