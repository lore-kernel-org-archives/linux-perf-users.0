Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C662F7468;
	Mon,  8 Sep 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325726; cv=none; b=R5x/32/62b6/50qK7lnlNAoj0XEssyji+p/WLKoy69EIIoapLhPFwCIDo/XzEbbvKjFgJ9B48MmPO9snW3rFNy1/a4m+E3AoOWQJgEpicWtx+D7V85e05vcTEIt37FRRVO/fISVlEV4sZ6w2olY5qh4O3vRUITSLRem59f5HxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325726; c=relaxed/simple;
	bh=q41LAG04mQN+h/yjsDMGUnk4+iW5c6zrOTH+jcEbjrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c92NwpNL3OezozDtWeO99/K4FH+PljKow2JsUde3iO3xBHLyavVyuhH33QfKxzIsDUiMYDAJ9YD3YVoVoZM/eB7PlQiQxLUWYY4LnuHS9poWnaK8vi/HSp4zanbKZ9lbFqoBdUscbn6B+QaYBnr+FwKSdobrYYBXAgdQB7VMG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQP43vze; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQP43vze"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c863e852aso37865535ad.1;
        Mon, 08 Sep 2025 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325723; x=1757930523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1i7iqUxmgg/DXwXQpNr1KmCqr3Rj4mhCflPyxgc9Us=;
        b=lQP43vzeHA5WKq3decbaNM7Btdjerj9J4ZPNGWHhK5LjRYTiP5UXKaAozbSTHNRrOt
         R5K36xEi4Mtdo1xpQze9FEUHBfdLGL8fSVlqWw0csHVRZ2bQQwEuj1ut4lT+sCNoAppD
         O2NVVUiV1CMLRkyyKTb66rCZa4dZD3oRSDBK1uSpRkit8s5TxhXsGYEhpIvGM5PS7O55
         Vvs71XL69xlgdD/V09EVLqwxTQna1vnoJw5FiYGVQ+2yKYyrdUu3nOKbNjcChv56gM7b
         6urktp2H0HTTvaw+uUmwTKtlWp75kvgccXzgXDT2RCQYiDKtZy/iSsHBrpPrjyQiG5fd
         TvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325723; x=1757930523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1i7iqUxmgg/DXwXQpNr1KmCqr3Rj4mhCflPyxgc9Us=;
        b=EWcD3gw7TMzJR4c0BfJYSBQUHBP2HtBWysMAZitbp8ZE23IZj9y7li13doyGlxuXXU
         KUGj5IaL2pTYClENNR/g/iRuVugEnKVjcB6KiuT96ke2qOU7eGS2Gb/IR+3Oy5RCN0eh
         qQS14WLGPCfKvW2ltUH2X1jlfBgP9b8+FYjR2QbhCYz6DWC2bhjGBKOOv4zFN4dGKPjD
         ONtCnUMGeMyNyQI6/U2u/3+qrJkhaG4kuF07xHdrtG58GcBpcL6d3OwY+vjeUCGLhWrC
         5R6ws3PB0jvFnQdkDSyUvxoMeZTqfj+LcJ+CPf5Aas7n6spWGXrn5GLp7ZlP0GRdiwQw
         4XuA==
X-Forwarded-Encrypted: i=1; AJvYcCUUmDNqG5hBevcnLwYkeE1uezwrFaAYldwZ/ZrjAlej6Cv89+JUdxqAciSOmMJvRMH3yTjukMjuH84F@vger.kernel.org, AJvYcCUtuvvNhu9Qggx/b7/DRZKsP4ICwlkjf4VC1cJva+OWJskF3tduaEgSyLWsAvzftlOpkLRw8TdH2NVPygzD@vger.kernel.org, AJvYcCWQqzqV39TttEfNTyPZK5B1NaoVD/q1el52qL/MDJxXLp3aeZUL+mOjHJCOz/Ufk6CbVboWswCFqq88A32MgW0QvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJx7Fb/nCY2DvBsAXobgnfxLely8katlKINSl49nTDao5i3sA
	bMZSL2vhOeyP6HNPj3bZwlhrPxhWNquHdD3F6jz4mVqBf49IiHIp0sUI
X-Gm-Gg: ASbGncuJio4yECJu2Bd8NVTDQwzF5qxH0YB1GcEHAO2RCe5CFu8VnS+Be8eYj+AHYDD
	9yx8luDzhLSJVaMmUeGvJfINGyeTod2yPGXr3nGP/2lHZEetY3lCMO300cBa1Z40X3C4LcOx4EK
	5alcEGKAMWceSvmXRVbR1qZHQswK5mQILFY2xVSe/yqLMEGrvgV2+sBHtLCgc7XyPXt4xSZRMtb
	jBfg3eFtCRLmUm2aMjAujqTn15yS5O69SQ64DplU0Cd3P2HcmbnFpyRSagxTs+JKgHJp4huZGD9
	CTX61Mh7VouJ7myTrqOD/9sr7VWdGefgrSsFlxjLT1K0Ldu1yOtbFyBwlEstBVEe1ta8l1bYsbz
	EdRelpyKS7PNmSztpwtzVE9kJs54=
X-Google-Smtp-Source: AGHT+IEephzG6wPv+SDfh/QNJZfyYYZEGiN9nvrRGlXcpvwgSrHUd5DTgv1ApG48nCxk+8qMKPMzuQ==
X-Received: by 2002:a17:902:ea11:b0:246:e230:a99c with SMTP id d9443c01a7336-2516e97e544mr97305725ad.20.1757325722576;
        Mon, 08 Sep 2025 03:02:02 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:02:02 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:41 +0800
Subject: [PATCH RESEND v8 17/21] arm64: dts: apple: s8001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-17-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=q41LAG04mQN+h/yjsDMGUnk4+iW5c6zrOTH+jcEbjrs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlFdIPv4SPsQfS6q50PvS6+jpXMZuVxHeFTQ
 rKoKjDWLbiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRQAKCRABygi3psUI
 JD1XEACgJgkU1uz5AspTlaQ/vskTVHNVVJbTFwN29DKlUvF5uCFpzsIXD83ZajprFY2ZgAlL2Ds
 CZmwmM8JvwbHtT0IMBZYLkMj4V2j8k2fQYv+HoThtLD7q5t6xkkqIHkGQsth8Kp9bnTsbjwAy2N
 eXy8BKTMHlHMbBVNsFgws/1FSIeQgDTSquG7I21zxR8dZe0tIZQMy4q7b5QqLPEY7pKgGzBCORA
 /hfEtDf6TrAIHmSbfDL/aJXylc0IXCHZATjd6jj4OWhEVO2vSO7jBJ7niapmSoMPyDSN0ISzfd4
 wtD7pmHaw/ojoSYcDzYQJQDtCraK5PX6C4DHS2cdGbAmJo/iSbGs/NfLfGA1VU6FVqJUzPHW8vF
 HGrDmpPQ3r7BlfFbYq+hvw1SaEAKFAKCUwoxd5qNXnw32G/uSwnNJ01tsAFvPrs47+mN7fX1Owy
 ai1rjW+8cJKEx5rscsq4BER7DcBLTUUffna70buak+VESiKYCrU1UgejvJob/E8BEN6oHkY9kHQ
 sNvmWfYy2wAQkEGYzDSpACkEW/32J28diUq7GoWhZk2ka3Wqo2xnKx/PnW62VNpIMaxHOwoR/52
 yA5zRmSLUR6W9+oY3gNkgF2YS1F+5tcG4P4o/DUztQZPQR2SNHj4nu1HPzOX4LpvVWVWR3aYWiv
 lV/Nos227stGHUA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index fee3507658948a9b4db6a185665fdff9f5acc446..ee2702fc807b678023915f72b5276cc5a31e1222 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -222,6 +222,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s8001-pmgr.dtsi"

-- 
2.51.0

