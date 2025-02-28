Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2A17A307;
	Fri, 28 Feb 2025 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715926; cv=none; b=TpkQ/GIOxqYn2KZDg5HjSJFIO7g0/mxAXwYUXmcxVDHrQ5uYZFXgc4I3VBKspwXKlKMiGfrEzYHxDv3bHCjA/ctiUigcujyV7eh2coRqLhwEFc92CH3wcF3023UY3+6st/ON3qOFctqSOZk8n9KcWecLZBb3KZ2OllsgjVLdpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715926; c=relaxed/simple;
	bh=gbMJbPuP8ggCUDDTugVSbzAiMEjb5T+FHE+EE/UhRsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnzqDZfVu8utlaRGlW7XSeOKI5JtHMbhOE+r6OWsIflWioDwBPO9zgnoW+s/unRVGQm1Y8KowRHOi/E7kKTb9ah0zGv5Z8Al58XAMvPRf7G5LW0d7Efanm4hHDXweY4GbwfQTfEfbRGZ9W1TKxw46L2g/kGi1bzYzkMLrOHf4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mir2LOJv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mir2LOJv"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso2830839a91.1;
        Thu, 27 Feb 2025 20:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740715924; x=1741320724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdYvUWAb7XTZZfCxvHyVpJfqR01oQeWoaD5JV/9jAh4=;
        b=Mir2LOJvmb+mdESOR60yTrac5qD50WZJqjIoDgAlOClszazKnmIk8KMpDymjsqucIV
         CXldjXZU0QrYH6UlQWwVwuYroLM+kAgiKg+sLu/e+s0sGMNctHvskEfvaV3LEy4faKps
         CYlP/KYqJxaLaMri4CHWp671UuBqvx+Sfj+BQPoSQdOWagMvz6t6KaVCdmX5fVBFXIui
         2BDr3dJj1ZxKlll9PVoaqK8xAB7xYPmk/upmXoEGAxKHim2rt34sibSDE8IdwT/0Pfhg
         NGibfw7Qa24lnhPkwHLN+NyWxWl6r7RT4aHfU59PsqhxnATuq5Rv4GCWut2OkRl7/LRA
         jhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715924; x=1741320724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdYvUWAb7XTZZfCxvHyVpJfqR01oQeWoaD5JV/9jAh4=;
        b=hSWWMEKHEKUvMbxZ4b3f2yT0Dk74LThvPt2WdTGFPhOyPoTCaZCN6R20JsYkuIvU3y
         /t9n9d5+aWeeN/gqPxDI2v2MlOWxm5OKis9DMGfJfkWm17P/hjxNH4kb7dkNaoKMH2K0
         TVpeRkkobbfs1vmRDSbsAyIrbZtZiLTFXya/H4m3d4nr5k5SQurw76h8K2753UHQGMJ0
         xMhx1C33AfLbEaEAiJRzvGXX7BnalURsFFj6GSfDwz/sr9MYwKlsUtaFjOhQ7Gpht4IS
         BTPTXkHmiIvvfOP2yLS4fDkjsliw/uUjFsPiRJjVPPfIFs0dQxIfLPigZao2jnySiiD9
         qTNg==
X-Forwarded-Encrypted: i=1; AJvYcCVZR29McE8l48pxhm8v+UbmhF1ZmLhmlNzRYn2sFp8/iHU0YiQvtu2xG9kVuwVAqYdK746/bNgHqkG48huy@vger.kernel.org, AJvYcCXEd03VbZ6pdYW4tIYTkbXzTaEGvOr8WzzuO2LaJV+9C/6UjG1EEsmQhxHD/8YtvDtIjmMvGrnaJ334xrwF/6Y4yA==@vger.kernel.org, AJvYcCXz1gU43PdPbhVsggHcPYUTloCxhtXYyAVwfhn57lZ0Je3VQvSZWNKiqJDj1mR4j0vKIhFmtRbH31tM@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTJV2Xc4k5B+ABG/qJyYWHVwkBaQEjq6LhJeo/RPZ1Cju/B1p
	03ANgxVsN0mMcsKKmXL5d0VZm+0l172Q/NWF0nzSIPpf0uMfPBcY
X-Gm-Gg: ASbGncvE6i/B111SWqZtyynFP+jFM0q6DN1hWMwlfTlxl02t7tsuBUwWL75hykEmFER
	kY2TtQoquFd+mwL32Ns3LChfv0GUj5iW26F37PnQP0H0/v7kQCRYp+tM09x+MvPU/r930ApuaFG
	JMgTQn/eWMDniIMKxHr2F5eDZNYrlRtvHETojSK0rFNgof7/yTBmnrxglGvt2yIBmgpgT+u5RHq
	S5UTZRqeg/vP8jFSclZSI+oqd64U1kLh//1ESxLeK7SmZh31m++c1WyGk3kuMEGpX/9lkNoxOH9
	PEWvQE91SdT7PnNLSF4FpX1pne0=
X-Google-Smtp-Source: AGHT+IEZUDDAXLavQwDXUSG1W13QFrekWn1iP4y3s5pFZHode2QXMI3+ncgQHGdyNcHsE7wI8qqVmw==
X-Received: by 2002:a05:6a21:9988:b0:1f0:e4e7:ef7c with SMTP id adf61e73a8af0-1f2f4e10369mr3442876637.28.1740715924154;
        Thu, 27 Feb 2025 20:12:04 -0800 (PST)
Received: from [127.0.1.1] ([49.130.74.133])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-aee7dec4114sm2387856a12.57.2025.02.27.20.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:12:03 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:06:41 +0800
Subject: [PATCH v5 01/11] dt-bindings: arm: pmu: Add Apple A7-A11, T2 SoC
 CPU PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-apple-cpmu-v5-1-9e124cd28ed4@gmail.com>
References: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
In-Reply-To: <20250228-apple-cpmu-v5-0-9e124cd28ed4@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=gbMJbPuP8ggCUDDTugVSbzAiMEjb5T+FHE+EE/UhRsE=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTeHIP4AdceqgfqxLnsvMGDhSyXATgprKvgaa
 Qf2+iYrtMuJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E3hwAKCRABygi3psUI
 JFzuD/9gYz+RAoruClJw73GI5SFqh8fyk3LiF5737RSNGLV7U/CDN+EykGjIgKhR4GgDqsmkw+r
 tliJKzZf2aWdpvqNlHBnOLA1rd4us2L0rYCv0a0vQk2tL2uFIwcLruKJuYZKRAX6ldZnMcixNHB
 zi07woYDiS/gqHtxca+5BHc2Y7EJLz0XGAOKuwTK13SNtXJTrGnadJbs0NyeiPwMZEXlpCUJii7
 BrzGnbE5r1eIir0kPNy+Vfq6NW630pUeCgeuN5eCpoNZ19hNSkzi2Zh1t/ayQwEu0zvj9/8h79F
 4OasT7nq9Dt3fIHNFklDSUihpGVOsb45PQxK5J6oCAje6EwCbkmsP7XqqzJ+gAIriYaA4ALXaRo
 CAtfDAChnIQ0zB0ygioHtykCJcFnn5uofSppoa48y8sLRYPpc93+zZ5JzRL3w9nc8Eem+hpeFKL
 YDaHD2svRQnItWmAbTv6M6iObzf0KtFTZfHAYMvc1yApfdYtaHaMpNsHcH8TL8NsO42j4N7IG0J
 zfpyzSVZ5cJU3G1EyZmc3g+PocymlIVkLoUYODskLq3iXz8svgNkRhUcjUm2MassRUVfxxJyB/n
 wiiA3ddz0cJ+Dc5cltKtfWF4OQuGvGCDQN2a05PayEUv0HXhb7oq68dgYrMhL3RcrYn23kByQBi
 PjJvDiA2PWqdHPA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11, T2 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index a148ff54f2b8a92fa3fcfa78c1bcc525dba1c6dd..d2e7f19cf6a2d7d2348d163d37c2787c7a36bbd4 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,14 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,cyclone-pmu
           - apple,firestorm-pmu
+          - apple,fusion-pmu
           - apple,icestorm-pmu
+          - apple,monsoon-pmu
+          - apple,mistral-pmu
+          - apple,twister-pmu
+          - apple,typhoon-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.48.1

