Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BB259C92;
	Sat, 10 May 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889934; cv=none; b=LpVGu5W7b6fbe3UCw9EPwgAqxHbU6ZnFQz3KJab4+1uAvPqiDhr+kmbXBnXQV7r1oZwag7s29UruOEgboZ3retHPTBu2omK7dvDQGxVg0s570xaqIyKdRWsVUx/1wgVT7jRTGVAvZzI6/5TD2gAlztIWRGlWGaGm1R3HPdZb8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889934; c=relaxed/simple;
	bh=LZ5pN5iqWz3OCuzIiw27nZWBzYhm/oPtBhWwt5qbJRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kf5I6zSVW7GGpuidVcvrjcLoX43hPgNdHmwfxnmnN3pctVe685v9n/cztlkwjoY2+jLb9pIUi17EUZr9CDSKMtySw+fB0gUS1eS1+6+h7wiCQc7Thaa0Q52FsKorTWllSduK8tbmoQbJFoFkYNURdoID3d/V8cn7dMzAj4csp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtqhU01+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtqhU01+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30c47918d84so1659238a91.3;
        Sat, 10 May 2025 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889932; x=1747494732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=FtqhU01+3SDF78U3xqdcFLOHmKM43Mei0Pi55aU24VLQaBaWiBnztKwJx+/8uOnpac
         zGGlg44KrLrW5PVPGcROAHiCYshl6U9y3zTZXAWvmn2PoIeUVO+IFTYVhJv9+lfqHXMX
         iEySwBAt1iX13OFNgjTtiQGk5mLcqFiBgngMiqkkThLktcI79MO3qBjc0AD1sqhsEL/C
         IKQFx8ZiFzm97XKrw4Ftnwlm/BiFQzvABfLebzPKhsar0+8GF97bTnvWR9gP3PtQRpzX
         Ea/LIZnNkj8hB1s/3enEa21V9GF68iWL/qe3GwxQAxAB08Li0DkmC8lNUZ8c5TT+0lqa
         zApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889932; x=1747494732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=JA7IOJdCQwNoRN8GJsLLHC2RQZxDeJZQiON7tZjvJuMclheOanI6Z2AVBVEF7um9u6
         K7pLHTZjQkYhVGdEbccOuUEKfFquA3iDm1FnvKtxKJ5Lmb9VlhARDQcvF32800Hr47TD
         Mu5a8FG9w5nEKJZwE4NPmKE2VtvfhlMhT1k+gLcrKQelmcW73un3MQk6BXMDSamjS4jp
         sZGOf1cxVbsoGiCTEiAchXeZJXHALw9fgq/EE2hCbhgVf38ptdJivMrdIzX/kF/ol3AB
         QORN+9ULAWPs2XkjprglFQl7qzcpQhLwRfiLRtumsq5aSYaRb+Fi3pgKe7QOm3ej9igQ
         6HfQ==
X-Forwarded-Encrypted: i=1; AJvYcCULkH0GCRhvBGE2acI9AZii+QPiQku1TW6XorxpVE7XbREccN0lXqxDzgVufTfK2S8SFOwNZPqOUoCU0Az3@vger.kernel.org, AJvYcCWds17A8dYMJQ3Zyj9smRHVmq1VoT6j7JwETbIk9ZSVRXf6GFGJ8THzVA8tzPoJ3ty4rcjUGGOwF7XS@vger.kernel.org, AJvYcCXsUb/N6XtGPS2R8sxD0b/YLMEbzbD6e+AoHt4UQR/1Hx2SmZI9IgdJid45Sl6uwl8Mb+rhGoiYCU+gSKpUaXz8Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaSfpYLHnvhyLGISeciLpPDGFFZzQEihiXteM56s1Hr47Ma0O
	0qkTiepCJ4tTrW/tdZ2mel6oVF7rzIs+XgCypQt3pZ0MDqXfYBWA
X-Gm-Gg: ASbGncsivcJ3D9Dq5KTEGK1ilTf6hFRvOIhTeZb8mWVbi2ET1OH95EsV1DOZ9GBEVCV
	wnOLP3FsotJ7YFwmLcy+49250KLc3vOtRsMgk4/zzSWUBqm/ZsG6eN9L4Fx5E3JQYrvXXFQmxjF
	I45KJc6phEWC87D9cCL1w220IXkrYObVMh7Jn7ag03JaFqhHyvk0PEQGqezcCa7eobHfuN/TQXm
	gAjQlYUW1lYIr31MLdt8VJWbDk6wlK6+pjZ5wEH7ZX344ifUEOxuwtim0+mYQObnYhappYDTy26
	dPH89b5HjS20GAqTf1dYYSOS0e4Iv9ZqBeCT3xxJ6sI3+XaSJpHxpA==
X-Google-Smtp-Source: AGHT+IF6SK68sLmJtQC8ae8t2fY32cS0CBR0w+qieqNRm3VrN23qLRaQmpfkG9X/qBR6YMGEaFOk/g==
X-Received: by 2002:a17:90b:1b4a:b0:2ff:4f04:4266 with SMTP id 98e67ed59e1d1-30c3d6442c9mr9677158a91.23.1746889932396;
        Sat, 10 May 2025 08:12:12 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:12 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:54 +0800
Subject: [PATCH v7 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-13-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yb5y2fqoC/fdcSp3Ef1ys5pQjLi/c/28MOY
 hzwkrGe63KJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smwAKCRABygi3psUI
 JLtJEACGtvi7PRtgcZg5JXXQY5yb0eNp6s2gfhYT6L/7fV2P/+UfVvZzFMvdkZ8QX6Yt1RDSdCJ
 m3zmx9qHc0lIC5S/Yb5DdJ3yZo8KS4X63zfaxl1ILugx807I8wstIDyITdkEwSVxE7FUnD16kNC
 pjnrT0sEXbc/4fXECpJ/fvsV88zM+Vez/8dz3KpxhUtuPjumhUIHQzJSoxOeHPpD6DUnvzGD6nn
 qKxBaLRvpfgr83d2xzwtgUzY467Z3UBjlQQ3CYn5hk9qiLlLDxsIVB6l/88RELYFq1955W+98t1
 SP92R6N073rRUgLu4nG0mkx32PI8izDVwTXIKmMAFpXH4RGKITl1DhcLHrwxdHPf8y5SwurJAw8
 XswTwtH7IJF6S5sLwVpLZFz6wWG/4aKPIv1IhIr+si9NuXL+o0/3lNyQrZ11r7xH4lwPM/tp7yK
 HmBeGF6Ibk/rNrqBxiM/H3glFCDyB71T2uWbq2NqIMvgx2ClHHbmCYU4ZxE3wX15bquXLuvKyTQ
 o9d+ft6xPzsWioVouaQomogVD48C+p25kFknFSTqr9/DugRje3mjGDP6+ra2+7P9ecB+PRC0GF1
 lmK4xL44CvKzgIXtMBwK91lNfTlyhef4w4x7Y0D5waN1zWzhthMuN3f8SVph03902ui7vYmJtE5
 ZQJZUsxKzzLKljg==
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

