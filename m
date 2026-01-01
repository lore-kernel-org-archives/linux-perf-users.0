Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45102868AB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258203; cv=none; b=eqP4oOqhYFf6HEv6pg2kC9oaY362C5smIgPczrTW5gc9uQuJFnEZlFrmd4q3ng4rPQhbehFpoSq0AI+IJNmk8K6mO6i5irXH3NDDmpGY/1p0lY8333KSZwBNPQZZZypI3sIcb0i7ZG1AxZsU5MsNpHNsVih1qAkQWuSYGJbgbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258203; c=relaxed/simple;
	bh=6LjbldlF3OoWMCnhY7fHqRvAfCOGSBQ1ExvFhoCzNxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CD9gU2KGfOxb8u9MDXafqvC4QGOX8tZFkTRepDrVsSxSDt7PhervbZ5intV6o3I+yUIsrnv4h9HIo0jP3BZ/JXG1jyqfIgA5LY8t5FodoxAGe9sngQe/WRW+Ftyq0KUdeMIlNYETPNAqVcF/rBqjTNeL68PXyQj5sBWGTWqQls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5aeAeWN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5aeAeWN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso16086337b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258199; x=1767862999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx92mpsjRydjbKNezVplOe9ZgSTsezLCchII9GIIrGo=;
        b=Y5aeAeWNtpsR43312Q30o+xdpEJYFjFQWSg7ThyrJxe5v5JidS+01ojwrro61l03yR
         rO9jOWHL57hGz8hC/9vRXZSThgYtmhvspLvGfa4X8AiE2OcN2lU6AorC2woOcsZJx1H4
         zUs/B4hsV5WNfdMfcdEuSq8CQ+L1dREVEJQ9AUTxo1hfZ72j1MSudcm9SC4LMkvJXPYe
         O5QSuG93teuuoaPUF9SBczUN9099hWSQnolIQ4I1qSHAzy385kBBQSUENAfJtymavPWQ
         YTReBHEXcr5L8T60iXYKyyPJEe7SGEwzD24M4CkgO5A3/beycWSu/6i0XQticgI+EaiH
         WxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258199; x=1767862999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yx92mpsjRydjbKNezVplOe9ZgSTsezLCchII9GIIrGo=;
        b=illJc5OE/BvSX65xXNyD6ZISzGcQX+AIxzgKW/xrQ0MnTXjltvKNHBw/vzS6JPzlIe
         F2V7wYdfnCyBJBlvrNO4lu5vfCmiGCjBIUfLJuCzrtJ0ipkSL+253/qO233ayOm2EHXo
         ujDFPZph9Gi/zbjWLtMcoZexb/nenmTp4JZYx4WweGS50z9AOACT9w/R1RlDxE4DaWal
         nTIez1ME8eSIYwc5c0S/XFZGYQhZ9FADTGG0th+6Ree0/XS6rNa7ASkUOefgdJZfaUdv
         87+MLHV44brQhJjPHV9uoXP8DycTwGGTNsoXG+2Yg4/QDhQmwg9hgsWILM4RlO5pw8/o
         3iSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnXXiovhEY0ORYN2CxX+ZShUKTFBDVHrsJ5deY9JAViy76Rc6hqnTmWeLG+7FyOexNkZyu9xwCRW57D5JDRmw6@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7lzrCs80CqP4sPodwcL1FYdSnoY6K/IBjJEYNQFcE+VhtKKF
	/weVwSRKPLtRGOH+MUkOtBBg/JDI2DQBgCwoRTWzq85KaEz9q14Toi2Y
X-Gm-Gg: AY/fxX4gIoM2m1Pdjfhp/1tIXI/0fs/1y4m1+FBMgIuGcEwZOGf5Cvx2Q/1zwmcQq21
	iZRSTvZnQsJGbjVwvpZEDDvZ/FaG7MXmesba7SyMcM90IKFkyOsv96X+EjI9uf7Y1HsLxpcI66I
	yef2oXNGc0Sx8FmUYcmjj2gQH83Xv6yaQax+mI50iEEecMK9tjDPgz9S/QEldnzRjLpuVtFMHFF
	CGs+pXeL1JsBQI5g7wugrXTkzjAfYLdDT4pl4ncfxYd1wNXKM9VvQzEjo1F0a1c6YkpIAxV0vay
	V7bm+kf3ZdqI5+6bEWk5R80HeZOsuBilRElgQqCr69vO92O8WsAEgqAtTVp9oU+zBRg/hnJKmGk
	UJCQmG7b6V02zlLIp6WcX96RPGAGu+yEJ46hTzAAVKXeFNiVU8pWLxkmGEe98oeJ+1ttr4NLPEE
	eCT0obEH30RUt0
X-Google-Smtp-Source: AGHT+IHXyupRiKKKb/4zoV1JNUxwD3K40/cUxyX9Y3ajY/gxIhNiwbzT7FWVFkk23aFojsc3KZwObw==
X-Received: by 2002:a05:6a00:3016:b0:7af:19bc:ca71 with SMTP id d2e1a72fcca58-7ff64dcdacfmr33662579b3a.19.1767258199200;
        Thu, 01 Jan 2026 01:03:19 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:18 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:49 +0800
Subject: [PATCH v10 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-13-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgoYJSa3RInwv5nD+sjZTycFbc7veNNrVV2u
 Q9bgE3qS4uJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KAAKCRABygi3psUI
 JDV1D/4qSa+sm02aX09GOAHOuuJpgNky+qBCXNLWI1+AcOBN9LiZpYQ+Fr90I8D97ZQblOanbo4
 Bm5YkCE191yV0uwSprrmzRCbfOCtbF+/YQWJaANV5VvkXpQ4CNiC5svCuQOWUDd1h5AjoE9vp2R
 +RDzd852r7hJf2NDv75NIU1oLo987J3afoAJ6l/jhq4vO3CUsOKFUrPUXA0Kq9MF0uRZSwj34WV
 8LI4nH41oOLLGiGP5hEJlHJZmum8gKhRRs0N4OH66OhdsWjdDqfV+zOk1/E0kBCWmCuZNQ0KBcr
 dw68Y5w3EWMaIuDZj7dBeJQdDqojMLrQnBMe/9mT9ITUjwYb/2DheKcn7EnzWZDC8nSHtDEIviq
 kQbuSGcKst3sOXRYpUr0W5KpfgJqTVQk1XLbjwpzHg1mNM6U+EsWXmB9+nDFmVAQ2dj6KmGMeXw
 dRQIGucMqE9rV1rB40KBG+ieJF9X5lA1TkyF45Qlzn67TRGBr64Jd0fzbnqDtBtuvxGiY/MUdMb
 WO+Rd2rbV9XmSgoC+xUz0krZSKIx0FCehBMT5nZLLf9m5bc0ni/m090vXq4ZTjZc6LImlcQty7C
 SjnuDbsMj0gt9FooHtsPHqClPaixtwRkrEhQpm5aXqjOdN35zG092nyc4k19xGPHjn2DftgrEhH
 SPQGCU9hqN5jfXQ==
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

