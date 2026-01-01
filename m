Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F44285C99
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258204; cv=none; b=hM0j71BMm92FQ0j8V9OgWaCbByMNblDvk0YA0mNvPfcvHgotbYPRKbSaKIQwOrU6ufPfnWJ+OeyuEV3kFjS2hmS8M2/TM88mFNEqfZdcM1lIPE0FNYa4zWtHQMHL7YajRZOi95KQ+Ho7LvT+glI/KSIf+rt4xmaZUEI10jA9fyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258204; c=relaxed/simple;
	bh=xASpZevNHcaVzYbv63kfOr+Ypk6TFwui56ogxDHDMcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1mXF5uLOUl6sb3Uax/qWy0bNJ7YruWcmTj0dujKUAcDZNMCwQ6tI664AxYIl5pbkkCm1H9d9cB3uwzHPN5ZUFZ3g2R4H6N9MY/PoiP2YoNVCcqT5S/4rn0l+594lo6CZVhL/xjuvDbJ1Dg0k6MbuY3DiQUm4sy2Aeb6LcFvkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1cu3A4W; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1cu3A4W"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso9172932b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258202; x=1767863002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5cND4kPk2t5DX6paIOqq4zpW3qf1DLe+UW4i1yJRWA=;
        b=H1cu3A4W8dxEp6oL9s1O1JbB2dus7ag68wobZb2/v1ttlpgUhobGPUyA15WiqR2r4u
         QZxE1oMg6Vvw75Kfqse/Mn5xKv+sjIXA5tWFpYhGIfv/I0CikTkDoC+fZDreVKP5HOpP
         kZmYb31BapF+C3fUzKC+7tGhmr3zzX2MR4/Ag6T7Xpm/7yva1HHiJoaMPDnmvcF4Iwev
         WSNHYhnw+9MXLVYGupgH47GuNSlh9W+w4DWMst95BXJlAaS8yZ8v1oNoGnxUhbwahra8
         S/7b/fIvTrmx4eR/I250nPgonFcPk4jeE3AOy2xgnKj6/AMMmpSRzIHfKuxIe/Zg8kMC
         WW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258202; x=1767863002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5cND4kPk2t5DX6paIOqq4zpW3qf1DLe+UW4i1yJRWA=;
        b=wNWGJdOrR+JYEa/bdJiVyf3h668LD56Zv9G/VsjH/mGISjfuFFDyD88XZBmAanjJMe
         wTaLxUTPPt4RFFqvhhYwbzxHRexyBakRgD6oFo7oLXszBNroHirUbWiMGeBLSb9lzTS7
         NIToFRi2AeKjTfQ1wKGyYzf8wW0MH6mDxHK+9RE8b58jrSJZotW0yzSJnPzEQKjrRdsc
         twMLapVzAGZEN8VayJBm8RaZxBoBGXTfnnrOaPnfBh6MWCSlg78Pru1qq0ljt4/cO31r
         Ci0hVP6TwA/K9G4XydaDHLwwruvpigqFJFYx7/enR16s2HkSN9bxENsn1UjEUcP4/sbX
         LzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqXBdhxAQtvKqnqChboGkgogL9WRueYf62Z54sL189jyEHoOgJTmmwZrJEuSK4DgZQM+zn737We1BI5yXGIhsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzNY8JfHo4Eg1oS78Gr63c8efK43LE30c9zWB56Hr1yuFDLiZoU
	YLC3RT51a8D2CVTKeMbsxJ7Svdrdnb+tLoqJrPpGurgqSn8yCXfmzXV4
X-Gm-Gg: AY/fxX7vktWNmp9VPwzuDSSGLq8qCsjBD/xEFtGoH+EOvroJu5dNFpS2ZF0QGTXyUQL
	5gYe9ExtoXhh4DiT1wtTMA/XpPMIl0StO8gAyD9aj0A8t0S1G88aXG7cEYARByKNjDxQf0pQ61n
	YSlDXCqor6UDJu1ekdy66rzqq+jUhIJu0G9qLWYA0nUxzsgBNeM1Pfn7adiKjEueK94N3yoBxFj
	bEQ4/Yr5p+ZC/EWhUIQjUYMLDwg+GVULIsjBfAYuXrpS0aFUNFu+8DoG1Oozh9uN9vGHI/2shbC
	qtaOsU6HyCMXjwvcUHi6bfYkBIWunqf3F3zZinVluLgpgRBQrlAwPL37pCKGk5E+kHgi9KkaATz
	jWzZAd8A6SsuKhJlyYz/5L/XmsdQ4REWyTJAD4WGFQDaIi4RGdvhU8cksUGS6A7p7WDyWE2MjXp
	oiuTy82mq4bYDS
X-Google-Smtp-Source: AGHT+IEmHAcWqnpliva3OuZtHZc4HbdIYtIJNUaBfJ0BdwokwtWmkHAr4ksqGBIwXlgYOW6W79PJfg==
X-Received: by 2002:a05:6a00:6087:b0:7e8:4471:8d4 with SMTP id d2e1a72fcca58-7ff66872056mr35885583b3a.53.1767258202305;
        Thu, 01 Jan 2026 01:03:22 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:21 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:50 +0800
Subject: [PATCH v10 14/21] arm64: dts: apple: t7000: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-14-48812c529ffc@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=xASpZevNHcaVzYbv63kfOr+Ypk6TFwui56ogxDHDMcc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgo4ZMseGjapzGmuJSYJ6+DsYX+adysnVIeG
 8wqHU2nL5qJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KAAKCRABygi3psUI
 JJQXD/9S0XPtF0kKMXxI/Q1LjACD3cbRZIY7t5AFolcJGp/jRItTNlBaDdLEbVOMPeEFRwkfZGl
 y/Gcp7mY/nlXElyZHrT1KIq9A1lQCQV8VF77jZIa9dmR7iWIhHdRr9WWzwi2ytX/T6NrdIkXCaf
 5wK9E3IFiaKNVRy2AYIw9dqbHy4DSuf8t8KYgAgnpdxis7MXLLas2ticMEGBg7lM4t9exuez/e5
 SmwiDxEYrhDAeaAkX66as039lAo8P8cCJovbLlbl9ULGIFN4HsyF2I/x/oKKRCgO+ZynQqASVEg
 AXYs/6qVorx1emzksduBpbNOZIcDHf6HhlVJyO6IGpzzs/F2rACsyObHX+Ik3vZx/3m8JvVetYz
 YLYTpgt12HqC3lVj+XUT774nqmD4uaaZ6uMf+e+hr8oasL+GEoGEQurvFGRTSLGCwjFiMT4X66u
 pgZo5c/rAwrji+CTfKCNIat6nwvXSfTI7Nvu5+IgTtsvodPxxKms27+eHFGr0AF0rsmQqgaHFul
 KHvqbOoCCgHYB+8vlmkBkmhHRIHZTLuxcpMHILBivcAs1Hmo5BY+csQwIVjxe3czOQZ/S/Z4Ruw
 H/OAgJskUPMX0VsiGeshmsFY9tTD+sn1qy5A8Ej/EFUxBmoIssfosdl2t1tbREfK0fSg+46FP0T
 iTyEsqwcmghVyLQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 0342455d344474d34f7924a089bf5f5915e68d55..a416cf8204173d4e45eb7baab42302eefd0e55ab 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -282,6 +282,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,typhoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t7000-pmgr.dtsi"

-- 
2.52.0

