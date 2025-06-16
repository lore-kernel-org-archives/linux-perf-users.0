Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8828151E;
	Mon, 16 Jun 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037579; cv=none; b=PnXK41O4jBf8+BKjpEBrgvEqPyg7X94KLcyz+5X5JGWk2DpxO+dku0/i95sPNq8sOXhXpkA2kCmGxCCGoUK35g/i/3q+U0YzJHB6pSHirSyRjO40W3CoYikJhshQQZQNrjauBFzrLviPhbnkjRbiMXNmJF4r3BHDvKsMkz63KhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037579; c=relaxed/simple;
	bh=LZ5pN5iqWz3OCuzIiw27nZWBzYhm/oPtBhWwt5qbJRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3Bvp6PE+nd35A96Js6ClbnmbpsD/y3MwkevHNXJlZk55oSLlipWqBOTWcUbONyN4CIGX9IFsU8yBsdZ8dMPaFEkyhbUStoMbD1+EDD4kUrFFTTb8PMl9wI1bYB584OW16O6FyjTHXv5lZzQue5VHMq5ax6N83lDZ+UL53pQN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbIwDChG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbIwDChG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234bfe37cccso49167925ad.0;
        Sun, 15 Jun 2025 18:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037577; x=1750642377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=BbIwDChGzpxU82DDf+rXjLVy6SKjO+GGCqHI8heNNdw3DkATbzOdFuzMKmgnNP4oRc
         vlKX7hy40bx34HNbO3XSphiFCsYDNBh9QVtRWrWlhSrjlxa3Fb9Euz696HmJp+zuc6tr
         8wCO1mj7GbExZnc52ghHNwCSV7xeYkCLvued5gmsCjh+pyoN71+bPYSrb8Adk5XSLVCu
         c2XfE4v7w6IAnIOaU3LYSQc7br03YH5gIIHUjwNFsvgRwZ5toE+DqvCfF/nBbGBMlNKu
         d+Lfpd1fHdGhBPtW/ZYjxbbSciOGnlIAqInrf4pd55ltF6AW/hgnXOS0zmMunI4/IUls
         RvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037577; x=1750642377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=e1cnf2LWcJIUjHSJW75CtzGdlRwMCF3ginYEsE/Y7isn7qh8P8nT+vneTJKMC0PBjb
         I1cHymRcdJ4Yoq9f9mC7m0IFVNoAvAKght5hO9YHlgHGcgGLBM440OF+UHWhO9cpfTtW
         4kuhll2+hgCRqAiV9nbNsvNccq+xkCI/D+2eAFPPPNJt/vjJ9vDaUz8CJ2BTvgLvmj+9
         SncrqT1uF/aWL9yUg/zfHkhFuHMekRRYR5MceTeIDANg/39QbBhHN7z/mmq0UoQpvWb5
         Xy/g5vSIgwlQEFfii11oWbiWrJqkik6EfWISdcKtR/w+C3/HnT63xJN5l6k2CCA4/hYF
         L/+g==
X-Forwarded-Encrypted: i=1; AJvYcCUccJioefQndSmquzdjFHjdKWTD9aJvpPBCdzrP0rrJhbO0yOn8WDxOBCVdscx/hl76ViRuEU9GLJEoDdux@vger.kernel.org, AJvYcCWpgh96ACQxy5iZFWecJ/tMx5bCSm4YoHf4TfXW2NrrRHoL+/6NfgLzm/2bI3/C9oHaqgUV2Vwct0PC@vger.kernel.org, AJvYcCXh+EYIU5g3Co2U8gVkIyfc98nyBAcY3hpUCU//vt6hSdCo0mAhr50LwNZVJA3w5EjOqGOHYxfW/DfdM3BxFqJQQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzemGC04m9gnRjIQntFgQepXXFr8Anv4+MlHYbasO0dZSLna+rI
	yEdO2aAW0GoG2yWpdd9fbsFelwy5NvlpY85gqp6VoWwaitzK3bp16KV9MoOERQ==
X-Gm-Gg: ASbGnctWvpc4MUgivBlrFIrraeOBNBPafV4enRkvN8I83DgXzQwoPVQ99RZgzJHrbfn
	4RlR+3A2X33rKDN1nMKUk310MbFObMVbF5aOBY+eeWgrKLeWREiiBzHggYdZEJKKdw64uhYV92X
	/WfgOi5SCiF8H1VH7xk/Dxeo9lu+Gum1YzcABYkACTSjnnh73kJgEYuU391HKntaAkPD7R5njlo
	4DOwl2pvGZD9OaugCN7dQwNkOiEOAumqyapgBD8siJMxHWtd5ioywOBcZBf3/K6kJgFxtb768RJ
	wCmUYeIkDhLWkNcEImsHtC5kSDhupS2WFWb6/DC5wDEF82S24BgPrpuayNLJ0pVJNEd3pkPMreA
	Ni/w=
X-Google-Smtp-Source: AGHT+IEVCoFVOutZOc58iIzo5g4oFAqueJ0SPgfdmz6BnSJcYj7dC2KnJRB7dzwQBr0haF+R+zbkNw==
X-Received: by 2002:a17:902:ce0f:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-2366b00eedemr118831265ad.21.1750037576712;
        Sun, 15 Jun 2025 18:32:56 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:56 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:02 +0800
Subject: [PATCH RESEND v7 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-13-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=LZ5pN5iqWz3OCuzIiw27nZWBzYhm/oPtBhWwt5qbJRc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QYaNhoHNVpoP2f2HSS8k4EzqiYo9wg7u9tE
 CJZOqsVlqCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GAAKCRABygi3psUI
 JLN4D/0XYiURgf560pd5iqzLJHOqI/H1/M8LUyqN0RZfrm2CAKpRHah6xfBnNtOQbAo0ZJARO9w
 2jdbUvU1Aj9DWOjiRLM5AwS1l6C5n4kyAcn2OtRFgQlAhjgwpw9Mhy7TGwhpfSA+QWZvg62Qc7A
 VA3wbGfk/pgaOdbrEZ13wxie4Ats7ZOPyJck6YRGeHChb8onEOsPQoBprEt5byAGO7z89zaBOa+
 028KIs6+OZOhmv6I2FvvjhLluiLjphCs8QM89gJuL704Gt1UqcstaMqfRyWflt2UdyKNZHCDA/O
 suhAfiU+MpVBgXC1I7GSFiR7oHSc7jl02GIN2tD/QqUBlMuHCBBG4XZbF6R5T0rAa/8yGscCgC5
 vqFAPyWGOgjsp/8l8iHhMKTOI/bW8L/ZP3vOB8kbdPDaCbZ+yqVT6hgM8BKUbG6U1MKxkj4qz5i
 jnhF0MxPUcOHcmP9xF0mCK2CM17obf3mBHACb+87D3v1zEXkbEn10913GE72DAGkxiWbfHvkq1/
 0GdlXm6h3aejsyTiVEIaJFiIjMIxbmZ+67QWNRqERjUsfbLrHK7ak+lmhNFzJ8kz/QNcnf1pTcs
 20aj7HHtsBXThGqOfGfLYXwU+vJqP2KZSaqcaCbnr/jvuZAjCxoNclniNzNtrCf8fs+6tGnIkiH
 r/dvfmOymQjqd6Q==
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

