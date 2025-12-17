Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92833352940
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988742; cv=none; b=bFQwBMlU6gxJD1bDE4ADlSHs1MM1KNcUSs5ZzG3x/s5QtmcsuRxuaSYDMTP+qdaI0zgEUQB33znhGNOWo+GyruMSFzgIVTIg8c3ARjKwZPibpZcUD8uiJF+XNqC97aVewUWdR3gcRkaD8K28m6gD2TlblYkjOxPc/i103HrNcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988742; c=relaxed/simple;
	bh=OX5KL+MG6sfpo1KjHjEhXoAalFtdpPr6gBFVJvOaFLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odAy81mw1qlmSIR5/0GuwIGNQJYdZVRxSblEYsYwinVRtQqckaPBv/gjBOy5YNr4yYn0++o3inWoLd/q4Yu4l7KBQWuBAXk/hjferhZXfzEq6SAJ3Ruw92OO4mU0mJ6nePgjshhvU+cYkYdfD135CMIt+CFtZ73+SsCPrgNL5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyApYakX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyApYakX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d52768ccso45619565ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988740; x=1766593540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS7rXNvu/k+fb0x7YdnIE3Agpb80vBTRZvlvmIIsndw=;
        b=WyApYakXQSeE+NNVMF9Rxunkch1VGU9imBLQVFh2LLbKlfr8c4vL9llRySePzNS9pt
         kTpEpBG4IIg/sSYIm6fkF3Nh/6Z+InXTK6jwZvwqa2ONQDmgEiRZGMiTftn2bg9ycXdT
         4G9RKNFWaDF/TMBpIV/RkZEri7KwMSzzGSLeSX8P/TAFEL1zkRIMbXt+o452erw6md6h
         Sf5hGga5YETkLHFRDqt14RL2xThMDTkVWNAXr6+b7TxvoKx7Odg4F2/bWqZhZf0Xna0i
         /zg9m/eJ3ajbUPhh84VWgRp/glOgie/LSr5+UD73OZqOwtNGaul9LAKU9RcyYpTv9X7K
         RKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988740; x=1766593540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NS7rXNvu/k+fb0x7YdnIE3Agpb80vBTRZvlvmIIsndw=;
        b=jOFA3spkSLN9RNWovIDQ5yHjSnNHw54EcSSrUPS/BzMBnzRxajXm8gO5Hhs78Wp7zL
         Q4DRjPfmIHdXdRjPsvZQ2EGzbMPSjn4LCFlmQqMnMKqSp3b/dcIqyb/hCFDe4vYVrFQC
         8Y7Utevh9TGMxkH9JO+AqZOsPt7t7TfrZ3nlUMAd3MDcmu+EjcTNLDfmCKDJGBtlQKg3
         bmZuYRP5llVQYPaYVL/asLjTPwKMRbWMEc1Yrpnq6clsTmOnCnc/28z5v6uD9rYMpAka
         6aMKUYlzWL3NOwZXYM8Njzmhg5PFYg5o4HEFWpTEk7+z22rsxXnn1O9PKuy7cw7llz6l
         hbRA==
X-Forwarded-Encrypted: i=1; AJvYcCXK359iX7ezFiC7lsnrjO14msDdmz41p5Q5AZyHX5vAEnN0X2kmdTeqfwBOCbQZ3k1s9j+yfYYn5HJuq8Nccass@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf21piNDKqwVBk3/xu1T4TUblx1Ye1YxpjXp7/S/V4aWfTFWOL
	i6cdNo7+sIjhV9N/XFQzlpjw4n/da49FVFWwd1TUCh3yrQPnwEuWYcg5
X-Gm-Gg: AY/fxX4e2cryQ2vDc8g6GK4BQQJu9E/w5PNfScF3PtrFMBvD2f4AiGPZCNEUFfIwk38
	pSZIRLxQvhXPy8rJNv748FZN7TBu6yqkEY9dBadhOjiNJ1PY+53zNM9PSYVmLB+k18JvOftcpwz
	3chuzhlDXhDdz2vmRf5GGFaLeJSOO6uNdUhmz04gdc+ceYf9itPlyfb2phjDu9mVyqEn0P3ViX1
	aFaKR5V5yBZ1f4IXIL1z5IgArxx4x4aUuKej97YVNolr90uwjEgghfLDCC6D6KKGSLTHoQNCHqI
	5W/x/HxJj0ddNbat31+9bx8tIDrTPxd7ddnYB0CDRNBD6jIRvJnSfypU32+9WamXAVHDfkrAZWF
	PvsB1ScWusQjgT6zny+6tVf1mfQYVwaXsXvUIjuHqPbOo5zqyvvPK468K2NXhd627XOmiCF4wb5
	rHBMZtNFNxFT3X
X-Google-Smtp-Source: AGHT+IGQGMr0AmGgbN4xg0sghCxcRIAwjDwaNdSGUd1h1vpKA5x1f2e8ppoipUpn3JG6UhCjVxeliw==
X-Received: by 2002:a17:903:244f:b0:29d:9755:9bd8 with SMTP id d9443c01a7336-29f23e6fa91mr197349105ad.22.1765988739788;
        Wed, 17 Dec 2025 08:25:39 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:39 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:32 +0800
Subject: [PATCH v9 19/21] arm64: dts: apple: t8011: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-19-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=OX5KL+MG6sfpo1KjHjEhXoAalFtdpPr6gBFVJvOaFLI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlCu5cj/TLrZWC6mrH7YYJbkqAiAC7pEfyDd
 Hj0f2vlWA6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQgAKCRABygi3psUI
 JM2jD/49XIhE+QSFJovMK9EioD8JZ2370zRmv2bettLyrYyNn0ozJMj8eqHpFbPUdAOJzworI53
 0pQpcWVYu1W21pzI01Ux5JtTxTozyJicMOWFMyQQNnKGK6bCr4id9v8mlTDLjOJgBXuVbxW28Qq
 eucnSDjLgwQqC6aMe3lftGDTSYaA0cz9o1BeAA1/vhrJjqUMYWxf19ZeQRqLOjn5lXaZT08K27p
 t1JB9P3kXgPlz5x0RX6Pkc3aVeS5XW42v9j4CEl+j70kYzdPLRBHarrvMSXua7Pi9sBkjzHtjhz
 3aCG0hVdDnKh+g9dhIZBiMptatnjb/1RQPFabtZgG34GtKUhbJQD2XiuoZx7IEwAokW6/KOhu7/
 ewMCbVe+Nk+mzlerzFzB3hktV7zUZfFaQXkFgtqAVpMgC4MQMyOATSP3K+/NyMIZ+prHnwJZyA6
 3VGKjR91dL3QVEjh4vDPbt2QUz1skKsPyR5NqhWCUf+USPuTNoIuDXzF31INwSNpEaX9ee4eXON
 hyK60T8cN+1zlC2BrwYKZYlGjiwQcut0Z5T0Le1NFCnxqGbTOTxWvl+QbtppK00jOHhIIl5D6Ts
 1pfTwx1wjiBZYCxLiEtmy9byA/NiDYMToyRt6eHVxMGwI2rfrw+Ki9SmrQxqYzQ7EDqYo+fc9y0
 s5uk4hc5IzzYy+w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodse for Apple A10X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 039aa4d1e887625e7b6ad789bfd9aa032dc58d01..7f7b0230cd648eba2533f860622f683771197bff 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -329,6 +329,15 @@ timer {
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
2.52.0

