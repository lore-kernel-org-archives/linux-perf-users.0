Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2229E040;
	Tue, 29 Apr 2025 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898284; cv=none; b=XTFcPOquGvm3zH0tMnKh8r6qNHKe1lXrDG7jTjyydrlAEgwSaa3duYCZiJrcdvfLaapZtDvxRCdZTR1bEii6Ilbh04Doz1qOWYXscymaZdsnIQfg8oGNeJA249ebmxsY41eJYgbk0DOYRTD1Um7Hw7vzuvPIEL+nY1Btv4NHEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898284; c=relaxed/simple;
	bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hys/rheVmz+hXMS5qoH2VrB87JNOGQunY6qzg/qUpBtasPGw5hmhD8g99bg6tAJqIo5noIqlvqIo2JC6eW0rCJ/dFPKYqjEXu5MT+CNXsS+Cgn9ZBnoRV9a/283T6xbhWkwFZARQ7+I9rKp8e3HpSFNsKQXo98RcfS94azy3U/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjSpQg8t; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjSpQg8t"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b12b984e791so5332666a12.2;
        Mon, 28 Apr 2025 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898282; x=1746503082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=ZjSpQg8t9biSjlWZ5dQMwT3x/63QpN3z90wNy+GGaIPFoKDKRRPLj+rTwG90Fj1w8u
         fBIguwRLXc2nSZUN3YaY3RAp/VmBs+We4PAEN6Fc2V6f+M87YEdp012YLT8GSXXmBkYi
         FdvtjkWqw/pLvNaOOY0YG7TUNO0wASfn/MnxRaQRxXue1ROMVmmqQn89ThjswKQh4nFl
         zkOO/BpVE4BMFrahvQdxpYRzO2Uj2JdVMVahf/NuwQdtnhoeHb/SXlsDy5S9rriSEUFP
         jy7cX6szNmKP6QqKQDDwdEYuUMAdTHsgX+6+MmfXBbIgqGhfVZfd2Yi9XWP8SumEFtBz
         s2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898282; x=1746503082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=NY18cemtROnKmHjthTflyGjrmdxtXVEtOx/18ZkbSylkStUeU31Ll83Lu2T6sE8WY3
         advSdyterPO3RR7RFyzCosFaLC5Ug7mEqSrCo/QgtNzX5P6KrU1t3rhnpqS/zeQq/MLs
         QW0tR7PKgp+oxVcEiLNoecFU8P5VjzTbpYRn33jj4/e40h6IMcvEiQuNb1BdepdVZ7cv
         WzwdW2IeZ8BrzSmkKlIiM3VKTy6/fRF1vZ2ayA7VChLncILmJC4bKNtssMLNyTWgn04S
         ClR6wFZVYAEfEksD+YHh5rEAe96gEU6mzku9e7VUuHFfvMV1bUkK/qERJJq7tsBUO83G
         tG9w==
X-Forwarded-Encrypted: i=1; AJvYcCVJi2nLK1tuXPpGvndrZY424O0hU8TiYzToZqBTLZCco0VZXhp9sTNdY/TT6++4WBKJAkzo3Xz+4hhXp1TvUWX6OA==@vger.kernel.org, AJvYcCVyd/ESelm/5NZSC1mNjbMnCDlGnXtgoOz7tKhbwpRtBvpE+SiZ8wiVRtgrCnLTR0aRKWfyFyRnC+Nb@vger.kernel.org, AJvYcCWVIWXKGQkWyLhnmaLiot5qytTPg/hRpEP7FXmSaMd7gfjQI/6E261DmrQSo4mlJ8245qgWnaZDhbo7FPa+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9Hjw1TU58DD5jAQaXOR8C6dFMR4brGKBu4MYHp2Dbdckwq9v
	O6qp3gYhVyX67/oBpAW3AJZ8VlZnsgNokFtQ4YifJGlXU71Hao1f
X-Gm-Gg: ASbGnct1LHEBQoq8uCHWulA/Bg+BFG1QTN4a8XiVHNg0ewCBp69e3jqh+rPyUNkwM7N
	US8hQQiEFo3KVk+kJYaKf2hyyxP3BRbExDGE4m10D+izwoukE0i+3N2yjVG9O89YQBKhoSDbJMp
	1/KRNYhYioAgo+s9/JVPl9cZThNkvz41ACFHhPryU9sJyCAvipK6/jruxTtIJ9cQnCBj03Ww3tk
	4XFilWDZWw7Oe58xDkGPFrC4E45vFeO/Sc8ebGhcKM6cdUKGYtjJ7XqblVwN1/IV+qqXOJNGHwb
	GUjKnxCXF/5GNQBLUtR39Z6uplB7eVJjq3MIOzajL/1PUuoe0J2jmbpfWg==
X-Google-Smtp-Source: AGHT+IFzFXVneivf9OPokQY3zw9bSNPj8zkSDTlCOwbCoaI+2d7wrwaio94T7tzORQTF6aRrfbAhmg==
X-Received: by 2002:a17:90b:4984:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-30a21546c8amr3148992a91.2.1745898281922;
        Mon, 28 Apr 2025 20:44:41 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:43 +0800
Subject: [PATCH RESEND v6 19/21] arm64: dts: apple: t8011: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-19-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErmhAaAeRuhpFbi6gLnsvgpq48CyERFohMo0
 o05klQB3lKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5gAKCRABygi3psUI
 JJ2oD/9vTAubABP6miBhIXITGpYPldj+/FlKBXzefi6FCtClttM1Vh58xbYEO36GkrWeGDOZ7jZ
 VhKAap3FjIz6Umg6gO3TTPtaEgE8lxoACUUkB7d8EjXlm4BGIhELKMdlVu9hNqNREMpA0X5HoY4
 5IijZygjLtt1g6wP8oa08TSi7CApM9FILAkaYRuKNzXh/1BfWsslseDmpJ7VINmMzmmZEUtS6sC
 fVZiehj8FMwcwjFLNdf6/NlPaOmes9aIl5quoIC2XH30LBCY4L0Nt95xXyDMldkLtkCI51Zdpgs
 9fyzSeVjf0YH42rkH0G5tdytxLMUuyNigaoJLaVD/nQWswN7QJGhZBWcpOt6XC9xglliCFjvZAS
 mF3lU+nMuhA/u3qscGRrck8aTS46io12eWrAmhUEHp3hQC3jn/9S1Nu1Ww4ivON7v/EhxLxSaie
 12QNz5nlzAYQQcCOz4blxc2AuNxVJjYi0W1JvIHfNuOwPR5Jhy1bEcF+kbBLvqp7q7B7Ux3cS85
 gaCa62HWVailnmqVgkzLbav/DevA8Swc6kQ1k2gq2vqhsiorBqsOTWIyl93SHM2Ub/usGbdQCn9
 8e5HIvILx1jjsNBP2LRBxpgORNuFYqgu7hrHnh/qA0/muSE/IHnIHY+io2RhQBnLuQc4V31Hzsn
 cKZ6gFO450NZrxg==
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

