Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA112E11B0;
	Mon, 11 Aug 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920603; cv=none; b=pCu2xLKRfWd8C41QyvDR8vG8DQuEXUt87Kge6aDxZSWkgcAkafFMvHjyVv5XzVuXno5UsXK5L2Em4ntludZVnWn3/lBU5wFRIl7wopL7MvRIylEJfQI3EhrOaYwJ9JOmtZ/XCTNhszuD+vQrUENkUfdRAXj7pZNAPYKu71Uxowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920603; c=relaxed/simple;
	bh=YgjiNgCKjs/DNwvy+UP2u58jMtjv8ObMOrXgHvX0nBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAW8YwYH+QOvszxMQN69x3rngfO2T6hF3DV705SqkGSIsdW7LtHDCi9iREUnQ5Y5g2kflrXefbUQzdAfXT/OXvVN3y89ti9bk8nkJCFgPJHtx+NbbYHybFHyQbj7qaXMEmk7SWa4Lnfk4YRtoo6CB1rTlh4zNP+VTjvqEGcmZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAyTwobH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAyTwobH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso3908274b3a.3;
        Mon, 11 Aug 2025 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920601; x=1755525401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gawbbaq1cv3blqa0/+0uXm4lYK8e4F+yAa+5XRwJxFc=;
        b=FAyTwobH4JyddzqB7OBa34hTRkMOpqWDq8d+pyV2mBGbYN3YZtMxeu2B2PJyzhLgdQ
         wKb/t58Vu8X+pKsd6cyMq3A500tmRP9VYDsphT6n0o2oEbOwvgIPh4DXLWywwUTP2JIA
         1/YMtu0TWCcmKEwk6CDJHwdzt3FqvueKOWwyB86Zdjy85z4Ng+H5iCXUrwhM4gFFb/31
         I5NbI7i9bjwWO90cZGTIyxBHfIUHJPs9XdFflaHaR6+zyVh8QRyH9NHLwcrKr7WvWASr
         k5DkcYOmFZZh5+hd6iji2WVkSSV4dKLlbPQG4pLBfHRZQvdGHBsQaTgNFLszSWXhyMCC
         F8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920601; x=1755525401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gawbbaq1cv3blqa0/+0uXm4lYK8e4F+yAa+5XRwJxFc=;
        b=eOyQ5IdvtdDIegUlZLc/mb/1d6NatGiXaLbi0iO/DbUEpgoXC494egWv42rE5iZzsl
         wZB0w+54uB/DAlYGKv7BmU6CqgdR3CQ6PPO9KkPrQ4+EhFpeQKE1+zPF3BjkjLozZ+CK
         PMmgBbww3IH+N9jCDNWDJcmQXXXtgc/xHblEmhVmnLaLlpkYgg9FZxZN9cCjwvypIGjo
         Cl0kDf27cKQLlkI33u4R34Y/gShpl3/91dpH3i3MLCXgCGMvEZY5memqygNnDfygHZ9k
         vf9Ye5irN7xb8TDFUMKLZK1tZJoOoYDivExt/LOWcdHf5gLVejGlevTingRCiBEh+kSt
         besg==
X-Forwarded-Encrypted: i=1; AJvYcCUB4EX5LU7qBoh75BO939ZJ3TzU69rxALCVxkGQaRsx7Ycz1VeAJMIry4VqBWHMk6DLV/Or+PudYVLh@vger.kernel.org, AJvYcCW5UeH9q+XhPc/ponqwv3Uc7hMj7yfywjKFy4uSr64QP+eOz5s3jbR1+IHyAOhs9N5qqUM8Ih8F03tJ3Mm/iwtEMw==@vger.kernel.org, AJvYcCXM2vEtlSBnA5RpIzQQnECzHFxDF9IZWOQ28fG62RA9tIqSZ80WYjZTpeI1T0ERXW6F9GK2mNV5oGN8ypwZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6EDdD9NXnuOpluuTiIdFRaGMdbsyrGmJUcwIK7hh0eSEBjp4
	K39o4MVRGGNhozdQMy9a6CiohLkVWZw4yL2e9bUmhAg39c+SwNZPLXiI
X-Gm-Gg: ASbGnctGVjAPKJPI6hDGBmaLN5qRvStwHTfibjtXhrmOmlTT6e0laeFQfZJxD3ssGNY
	+tTnlDgnaBkm8TmDL8mRb0uW624AGPgZPYtbLPW7pwWAgZqOYhlmI66kToO1SGZfJ1F4fs/Hkmg
	fG5htMqBTyq1e1KTq2iePf07rPQ9PA5i+hqOZyyh67306QOuLuBGbSa8iiInCVotdHR+tUCFIOw
	Y5VRGqXwRuuhWT9W7DggYasIYqWNedIsoGiNGwFtceyy1yLD9L5+uQdjIyLJdIDqTMgH40SurIW
	U0RfJB33jCejhJ05tDAho+IOv51f4KcvdumjrXo18JOLDbohy/JCGUGLsKctJ1ZxbjKtTIN0Std
	tqzeQJ93DGvDvjj7FZwWV3cSg06BmLWaUSITquSG/cwsJNTINm25XsBUGag==
X-Google-Smtp-Source: AGHT+IH71WLPBpcxqK6NsHSxFwYjB3csw8AeRr5tJLBkY9NMtUFUY4SScFUChnqL7Q1DXY7ZMZtZXA==
X-Received: by 2002:a05:6a20:6a0c:b0:23d:e202:1abd with SMTP id adf61e73a8af0-240551c2f84mr20231912637.34.1754920600698;
        Mon, 11 Aug 2025 06:56:40 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:49 +0800
Subject: [PATCH v8 17/21] arm64: dts: apple: s8001: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-17-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
 h=from:subject:message-id; bh=YgjiNgCKjs/DNwvy+UP2u58jMtjv8ObMOrXgHvX0nBo=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZDGjdP3nLNuLMmtNtY4KF8rbKUlqQRn7uah
 mWWRWk247KJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QwAKCRABygi3psUI
 JPvvEACaGJTqM3D81PYdorlbmquincQl3+rGkRN6249kEQQ/01LRXsYF+LdRGWlbDaIdCZUOW6j
 wgdVy7NERRJFznDF7WMuNSzXNpdm3ZmuE4yCOYiFXj8itnPZnNMdkOp+HMqag5vZmrkS2Uuc5Lg
 JDt5ITfLVaHXKUH0wsLAOCad0IL9z2TAElvw/eic/SXPHXScg0qVnIySzg+01Ae87scR/xNkty1
 C2HkZLMCIEtCcPE2xPgChQVvutiYeH2M6j7BHnKMQAHka+P98Sw0vZPsfb8uqupg1O+ssNc5Sbf
 /sR/zVsbpfBKmdaUKs2UlhUmgq9aXS7+t1Kv1P83DDVgC0Scgekdopb9KSf4ISJJMD/vAO4s2H3
 4n/A4Isdj/9SkBHvbLVURyPO+IpYQW8JGavxzUj4UKi0+oN2f9MFHhojN8YWfs80Zu6NZVjGRzv
 Cg+CROdzA62zhmiXDD1nAEaF15dJZRDFDbbcZt4JSMVx0ATTENqgIzwGBDWNpsGwS5EPQMCjBzg
 E8inRRuPSnWyYQECWJGSguoeVzFvQzhgwOvrNZ4ta1xxguac5s0vM0gJROqY5E8LsC4h4/iL2MP
 l0NjbWuirRTThHbxfeZ9xj4KuNQrkF6C//hQI0xFWkrjldsTAyDINANiyxleCZP62sJya23+s44
 MD24C9318a+OcrQ==
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
2.50.1

