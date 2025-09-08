Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD930102F;
	Mon,  8 Sep 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325715; cv=none; b=gXVvbfZ0IymxVQFOVxKo3fUpcVMlfcbHHSqyWghOn+cO3qJAcJB1YxuM1fBCp9bX6IFcNFx1oyoXW+OufmFxhUQoN1277sAZON6XrlQzvTqwWboqHCRHntHpiHTrH1uWZUeR41J3cbnmgFcZNQWdVS3X6uiddbc80gMHpa2TkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325715; c=relaxed/simple;
	bh=lnaE9Aql0p+zaBjSHyK2yyUlKYAm5n38nVhdpv7cd64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fc71SFcDfvzSPvDWNQujk+x1Gs5XCSHA7/pzLpG65EFRdGLeXg0XIDYE9lcAtajVMY4eaZlRHHC4Q1fKVGIAauAC+cwB/dXPUdvgsGeHYOE/emkEsGNp3Id9YLFfyHEHsRW7Z6TQfP+FY68sqPYLy4PkQGIrWtlRvhc7wr0FKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9s8yhss; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9s8yhss"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77264a94031so2892095b3a.2;
        Mon, 08 Sep 2025 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325713; x=1757930513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdXx5WHPadAVmQPefLqhuYKaW1K4eJN9K2RwteEElB0=;
        b=V9s8yhssDoy38iuJ5mV8g8OW9vr96CjXxNH8DNRacdfwkL7KNoM4kQKH+P5wLd0bCE
         1npsDVIcmVxZiWa3TWX7QOdwGIy2b8MVa+Dx4T5/cvyMcD2b/+u43RlpaPQ0aewLYav4
         YUsUf11lolpg+YmVl3kNE42pGag29Tgb15Jz3cuzQ61hQZATbmTDl2rT4AlzPakTpWEG
         XWB+vsJlX4fxYymGkjAOkgBITaMBuf88/FItOwDPpISAsLEUsOf43uja86q3VAxdppwk
         QTSDJ2wu+kudMwK5RGDA3GmdKLP0d0ej4bZBuZvO+HpyWfKgqbjqnYK0FXEiOk2aAvQJ
         DaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325713; x=1757930513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdXx5WHPadAVmQPefLqhuYKaW1K4eJN9K2RwteEElB0=;
        b=oeNvSHHdzVh55utPs3IenCTgWVHJQKN5nT1Ld9JewDZuyAWVFtOChA6Sri88fdUcWX
         pxHs/jlw9IAM3yi6dGNmFBlaB3J/eIl+AHg5/uugAJJb0oM41JZNZSZPIW1SpXWEt5xF
         qi+ddK5BJ96myXV923bLsYneW6tsnEq5V4JkSMUP9638Gmk5xwUtQ0xwRkCpwXjFRCQu
         NDYf7LNsvk7hq2jB0HuwSP3RRk6WZG9h4dSnzuhB7aegmbl3X3fH9MPuCJB1RWrdIt+8
         ATaM4t2gZw9/1nShBAIdshhi5GlfTgmTcRzYyTMNwD6FD/+e6YNs/i/nlm2vR6zFMY7U
         /AVw==
X-Forwarded-Encrypted: i=1; AJvYcCVl1ApS/emBjobteyTVEqnxWwXyPXhz0Z+k2/HRYSn3UHqFwSeOpb4afbwq23UTn4Jly1v6Gq05QoSV@vger.kernel.org, AJvYcCVubNxKUUZEnOSWVkYr8WDnJhoMza4slUeXvE8/AeHHs9n1Nx2as0kqcbdTzFtamSFyXRwiY0QdNBCGgmIE@vger.kernel.org, AJvYcCWxi/EyfM0AWbTvHywPiLpa3eYQAqnaiHo1f2ZcnrRxdchxMBQtXHSqRLBqIA9GMC72Qf/ehmEfMH+uXqd59TWiDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaqT4UrW1fHBQNq9VJhOW9Obtcw86AjGiLe6e9SLIFCAQQ+JQ
	scoiFuFcD75A08BXEMTciuRxqvOG/usIg/58MiDt4UrOvAA7dbIpP/db
X-Gm-Gg: ASbGnctAuPxdp2kbkm/HCX1C9XqeKyOTc1ORAWiBt+zirePYBOvZ33DHnEw5GN2fpzb
	oEBscjmkUsC+XODW9JYFesxrqSn9bzy/ib3dMJmJFEzSJigphGdlyh582NFqzmvWHxgThYh+HRt
	HAYplI+1S4McW6w/ty6MdZBH47J5/ZMRE9Z2g+tbQrutlfZZF2jdS/23qtwxOA0DTA0w6DJrqdJ
	eSTn5bJYUf221TaD+y9FOsK/NHYKA40XKmvEi2HbYWGVKgOI0ADXAKMUYhf1wbYxHr+JWEIatNc
	RrpCuJrKp/eavZd1oi+LaGpEtWULEOx8o7mg09AFu1r+5wHWs59sFJv7jwboT8E+Egbff2Nc3g5
	q/LEdbLfufR0R8r8ep1UhlRzIJFU=
X-Google-Smtp-Source: AGHT+IHVeB2ldGD9lByaVExSPq65coU5HN8zsO2WyV76Pj52Ray2lGVUsmxjkuZZ9lkMLPVGsDPzQw==
X-Received: by 2002:a17:902:d501:b0:24e:3cf2:2457 with SMTP id d9443c01a7336-2516e69aee6mr120267185ad.24.1757325713382;
        Mon, 08 Sep 2025 03:01:53 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:52 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:39 +0800
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
Message-Id: <20250908-apple-cpmu-v8-15-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=lnaE9Aql0p+zaBjSHyK2yyUlKYAm5n38nVhdpv7cd64=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlEaG4dqRUS59rdWuvyoslW/xZbeU7W5FMYc
 Dv0BEFms4iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRAAKCRABygi3psUI
 JG0WD/9LyMWx8U1EOfmaE1lMDGBv7OlkEKBgXAeGH0Y7oEuZJ1WCg276LK7MnLHTDx/B2PDzN6H
 Ui9mfg4uWgxb59NgvOupSiys1A/UpzaMZscIuweCw8NS/WwmX2vWankY56oPTRjUVxwaOW1bpby
 JBc+sslES3rlwzGOMxgbYWcShTQbGUTzfmo9r7wkvjvs1PK5vOIVgxzUMgw5TWK7on/MlooIkPA
 iuqEClLbdR7QQZ03wugZkXy0toHbKbwpUptvPTlCNRXk5YCATYtrNILgn5gWiEQ330eesscqEJ4
 mfkrYiPDqLn55d/TwShHBIUlwFpABFNHVuV58AS8uCiA0xV4fI3F9ST7nYCiFrrCcJX16I7+R9k
 qZZMbLlB3QYj/IhOrlnRLqmHPKGOaQAJlMUu9u5Fz72u7rmhZFRQCB5I7vaNzbWePXIB80qDwp4
 1dl20lRd+8VaF0oaf36IC5jNAdXVHeV6MJ4hL2He7cfRCMumxvpUzh273994aREZTPpGDHhVm7i
 VMKu3nCh6X1980fuZws8XwHpiZTCZHN/leOfWCOd6dCGx3xDnbTsTxmYjZlIGVBWxrYZaPgW1Ij
 fTD1pOsYviZFC65kZQSVzWi8W/Kes9/o0o4vOURRwhxRDdoU5oLYNnFWeEXw026GFqSNbShpPIh
 D0yR9laSIwEnzjA==
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

