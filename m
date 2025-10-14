Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B103019D2
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454315; cv=none; b=S04+dNPPXdR2llHuhCuuYssfqAO0J6cPfb6ccv0xafa2PiaIfVBNMyTugwEBQ1h3aWtqP26Si53HEn9hvJPJNApd2sZyLvBD5VvLTnui5Tr1Xf2uBMnJfdlKd/Iz/qm3F/Dgc6XKoWebMZaNVX9Uy6rPXQl5NJ9webN+9G6eSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454315; c=relaxed/simple;
	bh=lnaE9Aql0p+zaBjSHyK2yyUlKYAm5n38nVhdpv7cd64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMKPJwZsmbxc6jKlT67gxvIg+Paefjlo5srL2Tr0H9fJ7pqRV0hEskfU6a1vsuZRtq5aoSJwfpbQQiAT1piTDVF4iQ/DeFJE2gG4fpEP+Oyb1y6MXPPKR25U5mkLvvl4DUbs5WCKif0QYe+0XsQEBfVv7dLHKWlGcLwpge7+2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m96IU29Y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m96IU29Y"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781010ff051so3906815b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454313; x=1761059113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdXx5WHPadAVmQPefLqhuYKaW1K4eJN9K2RwteEElB0=;
        b=m96IU29YEuSnAU9V9yGpb3EtECi38KJDGd8pA1nPzDRK6GSL4+OOEye9dGaIMpmTgG
         T0FPh5TOcaeDUJD6x/Tc4M21NyG9PFX92O6Xb4WzgcTxYknwm4dVhp9mJ7UVB1uNmF2H
         0EhgpWdY8M3GY5wVHQc7nOBeaptqGNqagSEFyn+Q8/Q8f9297CUu8ZOa59S7JRXKtFjK
         6zAYDnaIGaXQ7haBmjxa8FNca0tqGipojV0HqIQRPWApNgKzpedr8hV4d8WxFVR/cYHR
         Ia6L+5y1E5t0G4BZEo3o09neMKnUSP9JhomwIAi8SedAmc5laWoZlkm2ZdR0j+L/sK8/
         WrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454313; x=1761059113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdXx5WHPadAVmQPefLqhuYKaW1K4eJN9K2RwteEElB0=;
        b=Ss0dI/FsWgWsl4vrWud9k3L6ZGIQn1td0QDL9How/6ITQSD1koHw3aRW5MtiatzYmN
         /EdxrA1VCARYFWHiNoN0AczZlk2drsGS558shogV6lTNpP/6LW25mi9XPcEbQl0fdGSK
         NeVCHX7/DQonG91PpCxRmj7TpdTB1fnHXK7my60ROovNFm83hpVs3/qOu+2rghVWI9hS
         Cy5AKL+EDg4MpwSU9i+o0G2iTyq3zC4s4kahXjXaksI9D8ezQRQhfCQ0m/uBxwt1buoG
         Um+cZ8palL2m9PNwdWGn0KLlcxKhBRdVWHIEawT7+XLf0cDxzPt+QbcCWX+FFy8E+gyc
         ElYw==
X-Forwarded-Encrypted: i=1; AJvYcCW03+kCeZUCk4qfkSnzCs7Od/efCa2ynjntbJsrR6ja741zG5u/5H1bzf9KF9RzKTRJxoVFMqQkIwA1mW5HNb+r@vger.kernel.org
X-Gm-Message-State: AOJu0YzFu6HGYHwDOLTFnxruOIGg4AMJJj6yf0h5bx6QM875VkKHoO/l
	NdpjirY3tcSMHIA6A3mluDgp/Qsjp5fbPEaNJovhBmLrcS3cGBx2227O
X-Gm-Gg: ASbGncuD+CobuifsoP9Ng0bZOuUfEe9GtXIpVgNZ937zP8zlM7Z7j/kDjiZIqmBhkj/
	vOa8ktg1n7Qc30GjSM1wkmF4sy+RkwLGjY7WJDrU/M0hjA3QTRwnJmgcxQ+zsmzCFyely8GUL8v
	wlBfZtF/cABidRc97E7spHRJRxqf8zLRSvqcfOj+rThXU8iZWPxMM3nz/KuJ21NujhxNHg9p8HE
	T5MiYzKoiuwdslBhOP+p9b9ErzUA+HfSTtO8dPCGHj0AGCdW0KkO8FqUUMt5jOQPi5apSOHIL+/
	N4kokpo67YxraKaSQtCDgfhz6nXNJZfuEolonwiPjcNFGKaYj0wpgBx+byR/zEZdep5541kowUG
	rme5CDKw8Yze9tYDp0TcMB9q3Za9WwoF7MOwoffhfeRusk2Vs1GPp/A==
X-Google-Smtp-Source: AGHT+IHzoB9us+k1Zg476hidLtO90F3jrjp+605FzoN2M+/LQdkvNujqWL2evXPEkPxkAjKdrdfwDg==
X-Received: by 2002:a17:902:ce81:b0:288:ea7a:56b5 with SMTP id d9443c01a7336-2902723b882mr362687865ad.15.1760454312559;
        Tue, 14 Oct 2025 08:05:12 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:12 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:48 +0800
Subject: [PATCH RESEND v8 15/21] arm64: dts: apple: t7001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-15-3f94d4a2a285@gmail.com>
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
 h=from:subject:message-id; bh=lnaE9Aql0p+zaBjSHyK2yyUlKYAm5n38nVhdpv7cd64=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZubTrG7nely1tzAQg7wIlykutHNDRueaZBf
 ed+SCa1nVWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JP9aD/9O1YtQ/3d2Uh81AoFfZe3N4gJv+zw+TpF2LNskS9au5ii1jPnoSk3o3g6XP1jBFJarWrN
 pxCJsqKY37tidCii24MHmkbEuRJdiVwM+wYt7A9AgXblvhDYA+fciSOW5qHKtzhvD6+W8mNxWqF
 Ju1y/WNuqbD6uU3W/G3LJ0pZBfawka++YSU1sFtWZECr3GchFTbyIyR/Qr2+rwmlbehFQE13jbj
 z53bvkt3aG+ZtKDIAXiZOgBQ/t9vQerElHCA/ADoPBczZln8YrdsmBgR88YYSgMpnCDfUre5424
 WngPsYCCfVTxh7qG2EL91wLKxcLfmzjkzOHF9kqzq56pgOj6PJv+h6Yj6obo16bDhRURCfMeh6G
 1f5ewGz5M6+QIuEnMxXNsdMjVRVvqcV4NP2LBPULU56E7F0akXRg+DEQbaWDtE9qDjODZulY/P5
 6DDcXzdBg8tSYDrt9E5rXT6QQsxBVD1xNqaLU6fv+JpOD+8KZbtDe+eO5Djl4YQUZaFbJzta1px
 BfiFXS6HoTB/p1j/lli6vBUk/gFfZNYTkDb8Q563YKBnDMe9kVXTsOkRJSad1Yj/mC1HHUY+hOM
 B9ozCNLR6FmORwDHeEQaSrUDFQnv8A7mjB1LRmModrNWBpg3INC5aRB7OvA6WtwWsw8+hYVRD5F
 VY9Gcwd6nL+mwhQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7001.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7001.dtsi b/arch/arm64/boot/dts/apple/t7001.dtsi
index a2efa81305df47bdfea6bc2a4d6749719a6ee619..0e414018f5acbcdb10db92bec6e26ba32e53c781 100644
--- a/arch/arm64/boot/dts/apple/t7001.dtsi
+++ b/arch/arm64/boot/dts/apple/t7001.dtsi
@@ -199,6 +199,15 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,typhoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 78 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 81 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1 &cpu2>;
+	};
 };
 
 #include "t7001-pmgr.dtsi"

-- 
2.51.0

