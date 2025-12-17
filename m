Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922234EEE5
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988725; cv=none; b=lUK327TpTGD3PN4+8EtC/8u3W6JRxKgbkkTwHhbETn96CbIFJ3/LV0c1KHHHG79dGqmYRpFellUZmnPVHFIYol7fKd06OrnJRD8Ec+jWWF+IVRf46LJbtIywelBna4CtWI/1+WICUn5BhwRMYmXITc84BpJcnSsf5F1O9SNjOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988725; c=relaxed/simple;
	bh=6LjbldlF3OoWMCnhY7fHqRvAfCOGSBQ1ExvFhoCzNxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZcjUTUbOBTOsgpiVNaJTAIPsYqbhJgBNopux8RiUPKDlA/mump5nNh1DzioN+xd7VjbIY7cvG82SJtxQHtT1cnRpZWDnsFcrmZRTxPWUDJ43F353B0xl1srIH0j/3x8wyFPYwyvaxCk2Pdfvd1bzaOxo9ItDsw3c+QhXuUdIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZowlmGW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZowlmGW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a1360e1392so20299965ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988721; x=1766593521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx92mpsjRydjbKNezVplOe9ZgSTsezLCchII9GIIrGo=;
        b=YZowlmGWmJPc9TiNEVMNemIFYmPN/kvSEtVhMO9DXyWYBMcAcKcdBB9/9af3oB+7CO
         JIA/AK+4S6XQqSdT/vFKnehsdAk/j8fYGWwEdBI4AvKOlt/re3HdrY5BAUbgh49FJo3v
         cV3F1hQ80T5nI1f4Nzor8gPe6lG3KYvpx7g6P4Dbm7iCYqPoPOn9vPu7iKFh4BzY6J+G
         7Wf/HIremCdQwQc0CzVP8saK533qdQB2XRGapt5EOSFgpJM4Mc2OQuxYzVWqgSablsfl
         zh1SyieNluYtBLk4neS6OpZWJov8zLMKMPSD6x7G4iY7ksONz5i5ekSuHp7F2DKuUL4F
         hJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988721; x=1766593521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yx92mpsjRydjbKNezVplOe9ZgSTsezLCchII9GIIrGo=;
        b=KydVtaLcxDUV3vLoy879YfDrrIlhkmO92SoAiTfewNeYtC46gsc7Xp2oDHqCsJSvJS
         CkwMj/HJe8etpWFZpTVlpsO8Cd6k6GTNzdLTeeLXgVZIwEbXd1r3ECAn8lv0wEMrDS2x
         ZpJJiNxAiHHegK5L4pR/knJOOt8Kl3vWrMNb5hSlIugvDV8HncSmhHiCyKCg7WzOH4r1
         SrmVECbgYj/PnN+tI+ZIH88gg7plwi/rugp3i37r+P7/D4roFo6cCGxF4mel2QJH1ZRW
         q/adDn6qrRYAmBD7spj7dPrrVkT8q4Fd6tS9ymqblyy9YF4UaccTySNe+oKLjbUmhB/A
         BzYA==
X-Forwarded-Encrypted: i=1; AJvYcCUfJBDXTfQQfKP+hv4kUJpBKrhsoj99NPgPhY57dR49GUKO8ktfkQnsiu7f5ZrDQkZQth2YSuMILsLKwnWxEKf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+dYoq88w32D3+Xtsb/0f01e5/nYRey4d4xL25zvNDgvlKvln
	UfI6gBMnm0arr4swO4bvRJiTsaNJLC7QD1OrHTKyjW4JWfEEExG5/nmz
X-Gm-Gg: AY/fxX7ALNLJjP2tchus0KhGB/F+kLZPe/QDw2B3+upj/F3jRZ/uQIksOrsyXPgHnW7
	/lQeJOBeVewmOId+lRcn0Tsf4w7C2p50rjz6gfr5RImg575LxqOhzA2Rz2pxmraAUI1hvxDbIug
	VAJAI+uMAukgf7o0c9MJfC3cBDnAPuaYzgUE3ciIS3LUb1Q/j+ProqdYoH/X5qxjdZ6Yp2C6Hrm
	xbpOoCEee/rJsVsuMLaMYjLbfD6TvtlP4gXPFknHO62sQFmTZ/bgqEbTp2oZZecA/6+n5r2Lw40
	JNP9F3kPOwRBGFuJYn1cb5cue5EOPYcn+oluFnii6c0WnLw7nnDfGRkmw2zmwlc0G3dv5bvwPAB
	Dz3aMFfwWzEYN5fA4ZUUXtI7MkPgMnCsfYLhRnVYKeV9QmrmyBL/0i8DO2FHbUTgs7Nh4PzGUCJ
	38evoM0CyiYGwE
X-Google-Smtp-Source: AGHT+IF7B3HOGs7poX5/sJEvWU5wHnYg5DS9Wk9uSkNrADU4CHuaQXTQoglGtMoHKKgXqB8/eL9B1Q==
X-Received: by 2002:a17:902:ccc8:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a0823f4e6bmr133717945ad.50.1765988720769;
        Wed, 17 Dec 2025 08:25:20 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:20 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:26 +0800
Subject: [PATCH v9 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-13-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=6LjbldlF3OoWMCnhY7fHqRvAfCOGSBQ1ExvFhoCzNxY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlBWlRtK8fFZOggW0gRKimen2m37MOO5vrnf
 Etv7BkdrRuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQQAKCRABygi3psUI
 JIT/EAC0nDegP45eFiq6zKOvzllfwjkCQO2MKS5faldtXHkXIwSRRT8b7VeKPzBD3X52sVnN9+F
 lpFKKATIVC4kmxROD/OqVnvW1nhRsdPo7NupCCpzC1d2FgmJqA9WZx+KSPYpwKL63hiEKNe+YEd
 +sMkijYl/9qzwLf0qL/K2S2rWg+xh9AgWYHpyw03Ec+76O6IcKBQQP9KJ1UVd8m9scXbweOVsgX
 s+008dpPi8RPfSbKL5ONyq0CP7uc/rOv0pwwSGBq4s1ijYa0CbDrEY9wUBr89FpNenZI9Heo9JF
 PbtFtV2DdaUxjCVeOo6JwYUzZLwV5nCBU8QDBK8CKCglDYLl+g5ezH6VjnHTxq2J38ADkfFhgao
 646jhqsLpzBUfgv0fCbqPPQr5HPYVsUHD22uidyW99begHvLY2ya7h7lUpdE8S5oGBkAU1l1PqL
 JAW0HU0xeeEmUo83Q43m3t9+khjoNvU6yG+MiPcIJcfv9pwKDoGsxp93Qh3Q5HNeos22cnHyhoX
 4csuVwEL8pG9P6ucMtRVQS3bG6QxCAUvw5knCbNaoYJdoDhycRfm1uwFRbzFLaT/l/CszXl5cwT
 20Dj8u8rVBJJJM26yxbBlRDh2vHsKbpEARB81h0FSlLwMtEEczin0405Pp0SRinzk20zCc0u1pj
 nf9XufhyGMKQxog==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 462ffdd348fc893d8e1d597b11d063dc5f88bdf3..d7a9cf1bb4911805a946d64e5892c1fe4b832186 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -227,6 +227,14 @@ timer {
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
2.52.0

