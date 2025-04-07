Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F2225A37;
	Mon,  7 Apr 2025 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001209; cv=none; b=fS7s64ySW1Ip3kJObeZ+Xl4UbNN5QiNdDfISWnR8XrNoWB44NU4gFJRoQvZG+1nFyq4jp4fL42RXxyI4sB3Gfy+/BwC13YY3Kl7br+3SeV4uFugwi0DN3+k6uSYmFvNvQh655BllAkjpHW64J5hzGhRgy0m2kpKnyxEG1PvPrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001209; c=relaxed/simple;
	bh=LZ5pN5iqWz3OCuzIiw27nZWBzYhm/oPtBhWwt5qbJRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3VY35EO63zpzWXKQokqxy89R3/jfiGyWY5pJiw6ifXXTI6mFd2QzhNTnYblnA75e75saf7oX9mUxLeqFsdKBvBBH6l7ASrQFIZSfKuhnpHcl9ew7Uge9VAFQPaXf9VJSmhNzNte5yXEwToNZbnrrXekozORn0DSW1q0fvtLs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l67tmBrw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l67tmBrw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-303a66af07eso2915502a91.2;
        Sun, 06 Apr 2025 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001207; x=1744606007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=l67tmBrwZODso6mLbNLPOoHjrTyhaIa1vQRXiHJZPIg9fgw9lTL7oqI2pfotM4IGH9
         lftvkXEuCzm+LMYzDKsw4CFiDgBTlb+hrZ8TYhw5/Bj0iSoPRog7ZSo+WkQP3pmCResE
         jAehwpTldelySGsdypdc47rYptK9d+eieEc6q7gLjQXyZoohWniYsXIXzrFPgXYjq2vI
         JYi0o4miMR7gK9vZBFC9QnKtLC3qFkMNZkw3JgDMNgn9MfHus5djB4VPNIFHc3D+yTEL
         tsJwYwdJZe+4wjI5MdoIO+HOGquyd38g/Yh6QYWe82diBVB6LQfgyFspDUCCw3ub9pws
         VvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001207; x=1744606007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pp+kkIFVs4gp4J7ADoVk3Rc5HkxtiGkD1fRapo9f6w=;
        b=qyJlt6ElkvLPPZ8sRUu4JCOZzBppMhZDoJgYr78aX7+wD1CsaqoA1GgJGFfQ34kT/H
         uPT/dK78sfG7jyDsNOHx1seUc7igP1Bgjyg1LSSlxoSMOuchdu3vT7DOKdksQY6MdwjK
         ZZ8rwgqp4n/Cc6yU/22dTrmvz8VzpFoVkv/25uh233H7+/nFgfNA9dNjWNLpieeiaUKf
         IqYi3zwa58RNhw2Nw9wk66n9bN22fzvI6zWisvhcMmDSiBlbOVmIErb0dIMmyFN1NiyT
         ij1WUrNezD0ZEyiFPW4mWvJscj8tuHyRk7E0lTWW+tD0jbxW8fB20eSM29tulQril60k
         QBBA==
X-Forwarded-Encrypted: i=1; AJvYcCUEErqXDCyzwMAp6eHF14CD7Vf7engNJP7qDLD+bbdDEEo9+JIyyJ4T1AcBZdUDVKqTazJMvQEKz3GocRa/Hcet0A==@vger.kernel.org, AJvYcCW6gNK0o2cBtTrVMW5HGkSe7+B0uePjDkdBgDnVejRY8D5OPJ7j0rQDrNhwGzkiLrCjbmGnBfIa2CbmligO@vger.kernel.org, AJvYcCWMmc15Glp94h3cGZI9NCTmW4EjqVrRSJKjcOWbRGEH9rJNBatXIGhI48os0dL2EUtqR6Lt6xAYDlw9@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgUv7qsYdKdLvPAYM02uJdShA+8bK8rmJpMA5sdDBRnsPnnXz
	1u9VvejuAijEehnPPcKL7P3jx3pG6z5Q5MlZ8gnJw8dmDxPnjoXH
X-Gm-Gg: ASbGncun0PGrWWfGrjPU7vQQ/UKuxKg7e/bDbYs4H4gyTTT3PIFq6T6BgmjDgU9BtCa
	MXFnBUlHplSI7L+Ru8JiwKzEYIZuWh/cyhxVM9bbuzpYabtv0Wb6xVNC8R7cxGr4XVPbt9WLVKz
	Nbl+UJ9qw0l6TWtPmXiD2dUw+lSmE6danlKhHEjtrhmMnCmAD74QoifIw5+i0K3QEbk4m/Yh0AB
	+cmh5DSwNFimIQGrouC5oe4OqOPcqvHaJ39yxogxBj4LNrMR23eOkTvEkyVdYvm10Q+eO4c7T5G
	e1pX8E8gSbuuHbGRDtlDsal4xbxbNZY8e6AgvNjGcI4NW77tbLOCB8bhcA==
X-Google-Smtp-Source: AGHT+IHJMs9e++cYbiJtszqdGefR9NoF4hG72mVISh3CMPmNo7vdIqtGqf/Fr2iI/L8DP1Be2KWA1Q==
X-Received: by 2002:a17:90a:fc44:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-306af788c23mr10490130a91.28.1744001207459;
        Sun, 06 Apr 2025 21:46:47 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:47 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:22 +0800
Subject: [PATCH v6 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-13-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
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
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iHZej07K4cgcyZGTeJm6SSKprUs+DfbEz1O
 QRY0WyIqpeJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhwAKCRABygi3psUI
 JPJND/oCRoiuuMx0WjE436hra0n7lRJ23QGEwbuaKRrYxUzTehmLsZZZNAikViX1e9FoBgFDURz
 IT7+8f9AAZ3QHy8hpjGht8u31siCvpoj5i9rp9juEBzUgqG3bOyavFIalzGTYGqZC0QWdNFhNz/
 adg/FayUYDvgET64rIwipHx2mL2/rnCK43cINTtE9+ZAuksw/BHs3gfVzj9GRbEC5rhbPYhQxXX
 jiTuVbAhcPpuM4vcbIc9zG5rjsldL+P2jPzxwskJAlIat/wizYYaB03wlaPnx8yVNtvHZ9pDV9G
 b6+2+U5E+0nIbwwu5rbtKr+kcHcN15EhGab0q/xpiDpRCjaS2/OLM9XtNFGnW9Rk8CYrZc6+L+S
 ezXJvhp4dSFRHyFvM5V0fqiAb5u8qWVUrLSLrStpPQT0Y3IUyH+RGQ3v5Ar/G4Kng9kCoEqjJNi
 B7f9DM+aH9LjFbRGqVEFaxNlxRo+22tpJ6rG3/MPCS2Pv/L4zi/WwmB734iKMEAXTHzz3faJuH2
 S4dueUw8aqrxVWXkai92CxaEQSVEVJ3cSXhofEh3e6J9lVSar9FgVeq4XoTi2B0UUVvBOeAUgYt
 8C1YjgpdhFlo6T0GLP5nondqLtcbyjiI/hSGhum9P15PA8LpcTvu21Rjz2wMJANHebZn4rMiJZD
 Zr6HOVJPunwWpEQ==
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

