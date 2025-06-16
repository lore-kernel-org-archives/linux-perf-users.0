Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFD28642A;
	Mon, 16 Jun 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037601; cv=none; b=Xl25hjuq8nT/Z0zONaUUWd/hLa5QliD5g9GP4PYpUk0N/cMB50mw4QXx16F6qbcD8XdTLvX8zASDJRYukSv6xmOqH8BxU3xUZxzXArLUuit7s0POMqhfR/eqA9OZNLT4njMC+IU6VvTiyU1LFIqkou3b8NmMbVskbVIn96DF/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037601; c=relaxed/simple;
	bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSZQ+VzC6KGQ63bku13DQJShtevh6AVd+wjNifMbNJ0w2RxRlSxcjgWwkLF4gYh7WPDGV7ILniTS5kb8zrU0VSvHfUo9HjxxZVFA8rhBxBxMsrNVO2hO+rbtqXJl1/0axsphcCGdkqvUm3aakRmO+hCd25aVMndvTUGaxXUWrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5VyxDVQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5VyxDVQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235ef62066eso58228675ad.3;
        Sun, 15 Jun 2025 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037597; x=1750642397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=U5VyxDVQ9AUyUhBsLjBNIy796UPo6UMtsDsCFIdMnEI3IOXxkzlzRjKKu15AvquOor
         gnhI8inoo1iaM2mOOrx5y4cRtQ0ZvbTFHqeFz1wMGbT5XKUbIgvGdg5fC3lGhB5Py2Xq
         VFxJO8p1lESrQdq39Gc++y5mDjCF5j1KwtrFPqcZN+RtriHJSNExoK8NzHNj+pbn4qwX
         Krv39ogWFQXj507yNwrKIss4kyiDrIwhdnt9FUvR+fCAS/QQfqKaYo9+hOLc9ZFikw/Q
         rbbe4ynbVnz6bHWRQ4o7fK1WugErFdy4zzJ9bmmICdoSuJyjJqjW2EP349mGPMxx6+bZ
         RS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037597; x=1750642397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=rjK6eqfpqP8jbBc4+60iZz90dFtI/hC0hDdvD6NDWm5lCMPTthUdk0/WqHohe4o2JW
         HGh9b0XoTrY5dhS80zYLZKNwcybmsNB+gDsx8XQGBs0tV1Ohyeadxsx1feFa7uqw0/+l
         u6kSab3l3um902BsmE6YgXtC5Vzy2HMHxiKBCLidr3tHMRBBXFbAbTu4/KRMOXhy295x
         C+1qUInoAEIFDcKv+GDyRMWMjBgUROkG2MTaoD12drLUReebfBHad6Htt+ClsnTcTR7E
         Ul+Yz7fQL25lWerZfJEsxAiKghPAYCh4aiaODITd2sIVP6j5eFm0t4i4/yQy4A4oRCGW
         Rh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFWmUXAZkZvpLawvrdDTqdC0npHCWz1Fs1UuFpxrD62rQ6s5qIwhcO2mXvMIRUJtE4dOyL6E2A7dne46hj@vger.kernel.org, AJvYcCVvNSp+lPWHX/vGBYt+FjIf+KDUzAEp4VbRefOh0YsKTsjHinWafKttQDrzGVwXqt75q8c6ZOoQaHF7qc94hLg8yg==@vger.kernel.org, AJvYcCXCdAAB3asaKJzDQ0ZemEuB87J9rKNVrrEO6J0pDFGnhWqcu74MRucqOSKKEaOzu/dD/+wYFrPlxaFz@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNS9l5kjT1DmbC3DKO+riyrbreGI19MLUxP9AZC9ffabpqVgd
	yxyXk0t0/FjPj3Qv5XD9HVcvWYA07xc7swAHz4En0xuJR1YLd3NalsyS5/XKBw==
X-Gm-Gg: ASbGnct1mH4K48Ph+bWvFa3n7ZQRvtUVjRSiHxr04J8/Y4PLzg29+EwmPp8fRwfIaaS
	OArHpXqaZW8zuIiHyiRpxJtOHQxqW05lgGkXqOqXs8jzL1floDgcJGY/STtfnGg+u87Sdq7UO9r
	X8CE/6rXtg1WjVeQal6/XahHCyq1SKqstaY3vXln1BLU3pYZ1L9ltLqvC3PIVvyL4kaBeabv84M
	4wX2m7kOgoowPgnkrOJq93J6rUj8V5DCg2TZ9OWQRkpVnT8qbrllZhWr4nhh1s0/g7nVhW55u9c
	M/3r5Ftq4Mfsjqr13up814in8//uD0uURdt9ZU8h+eeoKdxvw1BgBfvpznxRuuoVIfC83xifyi2
	OaGATTdqAkq/nBA==
X-Google-Smtp-Source: AGHT+IFC4kmacTH0NlpuXw2+AHIez/RWDk16sXkzaRQ7d+t9yRZVbTRSeBAnjLskCJcp8Tm9FYJVhg==
X-Received: by 2002:a17:902:f786:b0:234:986c:66d4 with SMTP id d9443c01a7336-2366b3df1bbmr107762165ad.26.1750037596711;
        Sun, 15 Jun 2025 18:33:16 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:16 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:08 +0800
Subject: [PATCH RESEND v7 19/21] arm64: dts: apple: t8011: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-19-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QZWdhHDCiZqkvL5f6HSoNB9nSWhxYFVv8Y9
 Q5y9dGYYNmJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GQAKCRABygi3psUI
 JAywD/4t8Ntu1bnuUwZ9C2UgMJtMiWBnFnEccj46criNwf2bRK91G23yflsorhR+WyOJlvMVPUx
 BWM09BOztn1FDKIKjQEz15R083BGOlEC2TVI6oxhGiuDYmyG1WQBugsOcNsi8ZLs5kZuUZYsd3y
 0gdo6r5UCozs8OU0Bp0YLJ2BZoansPF7XfL1Fr0yz4FI1ukV7e2Jdhv4bpd70CU2ihw34FajulR
 AVzrNQi/ZYuuFGMbZaAk1ON/lYxjffEWyBkZIbbFgN3x0doi+M4PdtImZde5KQJq2ApUhzsFPzz
 HuhngbjIs2sGlUBwE1dWAvPYF8tsagQ1Myx/vgdDBUGMdvbXEeg3oHmHJY1BI4yC5e/8jvZ1y+1
 c2p5K53d/aGrFGYpXzDtyekmmo5nLkGX4oz/vFvyx//ItHiO5UdAQZLn2soaZuef+6/AGk3u5tm
 udgh4C+WqOh1lIuqX+FkYDzM20877vZFN76TJxN9Sh+RLHZOM4MsCzBVS8LDNoSEaomATSLDbKD
 1fQ/6TrTFedYy6fooLi5kumNKnBo96jAMl7i/s4OKSq64X0LyWzRZrtJrphOt7+OP0XnW+b5iCk
 8KWusZYlyiJBFKXCvHZqyWqBXHUy5c9PMfbE0VuNUMOtFH8Zb9sjetrwYiJrRdXo7XqFePFWKCS
 uqNAR3lt5xMOQEA==
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

