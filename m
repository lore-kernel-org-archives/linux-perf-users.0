Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E671607AC;
	Mon,  8 Sep 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325706; cv=none; b=uBUFTCLIKq7oGlMB/AaC0bcRyGYEfFYcyfLdTi2UTHSmKaFbEbEbhTPO8EHkFbJWT2hz39JR9fd/D6KA4R7djsyhUC6tc/SIM1nxXD9K8tyjOXwjdPnX1SvX1/oK1K/E9/hTT9iD2/x5xa28J+ZQw9WGTaswmMzdWuPLTkCb09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325706; c=relaxed/simple;
	bh=XiGGX/gYUODKcUIpICueRO0ZWhSBnplWOTrgw4sJMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQGsQvCIBkphznY+XSU1arYf0WB1d3ssaGhmySFQNThIV5Y5mMBORdalLti7tsHmBgN4fcUYSfcDQJxGCNlRvNVRHS2RvjT964KuK88yG982pU1z6iZLmqwuwp/6GXBgVYlJLWb6HJzLjEAA9UGVNiOl/z6cZCSLNALwfGgZO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKiC0T/Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKiC0T/Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445805aa2eso40703795ad.1;
        Mon, 08 Sep 2025 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325704; x=1757930504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsMRt6a+0MtEqKde4YWuihoSzMbsHghVTF7OAbgmvz8=;
        b=IKiC0T/QNgPyxdwl3BI9RQymqTFA9eYULnF2bp/ckVX6s2sE0FlnB0yN7i5bwmFkuz
         6sk4TTJ4O250yyRY6Qv8O4AnFDaCwi7tmyza1uYmjjTZZPjUj7LzZQxOdt6oZALHRZcd
         09rVA+J72cYYmRHabUq2e45Upb2NljYxzeGm4bWVVP/7LQPMhQV90trgyrmDif9+DCld
         2WHhOVxI0goHYsT19ymd1+rktu4alMcCXOoE3NrGMn312KbssILYgy3mEvF+0i3+ltst
         71bTF837O8OcoKJTJzAlC4jQsVhEZhg1UaECAN44XNkZ9ZaeiNYppeqafAmm1pXMpts2
         nvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325704; x=1757930504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsMRt6a+0MtEqKde4YWuihoSzMbsHghVTF7OAbgmvz8=;
        b=AjeErbCCPUeFzGHzskntzTF/CQASRAiI0rNcpraA+c3Z/ZJ7UAEbJABKwLMAbLnqRN
         TNeOz15bEIGTJ4CKtGEK9X1ZPbOUMHkKWaV21pl/LkfFt+IY8c+CJXda74eqPXXgsDwy
         2zMJxNBGZ9r5eNksH6eQ7v1uyEWUmrMvI0kt/KJaj5R3hR1Xopa14jHdcHOe8aZf49sc
         9JuYzK/PshaP7vKNVtl0D8CsXDBji+fEmDnbAsXo2c5KPyz4Js0/DyQzg8NI6TnPTr1L
         +4oIlikEcxampDg6CSW3rcTDgREEKWlClRMHsV2WjrxIbcW3oAyacIlST72BsTrsiCG+
         iFFw==
X-Forwarded-Encrypted: i=1; AJvYcCUPLtmlXOCmxpexX2SR8PNQwnzDwQWP0mChZNJR+kh3Wa2IwXjJyaPSY4ONyncIjG2EoMUQjetO7x5u@vger.kernel.org, AJvYcCUrApqRG7yPrxYZw+0kWGVqWX/tU/oYIjqJ1SOtrDR8OOLH0Tq6/jA6c4L/8AdVGexp7dO6Sz6GNa0Ae8K/golumA==@vger.kernel.org, AJvYcCXPskWncg9SmZk7fv/1L4DUAhskkeQAh5ccylUuS6p8OQzsD8PeYW5gEg7U0HppiUsVItuu92cgKadYCtj9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywum/2xOnEBj+k5j4345heigPwSdRMHMy8fy0boop11O7PS2OEJ
	awcx1XxAs8YCJ7pnbDYg8dkyVrEcLyFISJHqH1jxwbsekNcnD2ARXAvp
X-Gm-Gg: ASbGncuP8B/9X6Ie9/pArDIeBE9GvSGSBPX4e4d9a74k6GD9qTcyBzDWgZjScCAKwcS
	JONIc1RIgRbUm4HD+aUhRuK+6jfoay0hb5VzuLvgwKTUe/xaSemIJKeWSk23Jj41DhucbDZE6kv
	MPtFjdXkuzWpgcKDDieNc3kFmpleHX5D+OnqNzJo5WvE0MMXv/wM2w2VdOTP8P1UDGoezdwQuoo
	y2yC/lthkr/lDurjzAFCD8p86xS+TGtD3vhEfBD+ZYC3FB5eIryW5oDUw6egeiI7NPGZWAEi325
	iCGCk5vMDr+mQBq072688pEQySMauh5VchdgpVvf2kWykxiiJzE0sHQm1pDl7W5Q+x6SiSII8Pl
	WCNJDOfkqsikygGXuzokyJR1O8tavClI4yWvc/Q==
X-Google-Smtp-Source: AGHT+IGWrFFeN5OuYsc2+jqffuPG2Hr5NStgaizfvWwDUNYrjOwOl9gETEIxQibCu9QxuhZoPFAr1w==
X-Received: by 2002:a17:902:ccd2:b0:249:f73:bb9a with SMTP id d9443c01a7336-251759a7cebmr75603215ad.51.1757325704077;
        Mon, 08 Sep 2025 03:01:44 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:43 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:37 +0800
Subject: [PATCH RESEND v8 13/21] arm64: dts: apple: s5l8960x: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-13-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=XiGGX/gYUODKcUIpICueRO0ZWhSBnplWOTrgw4sJMTI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlEOIKfaiGjiWT5qhlwzLyEPVCQY/VJwPgay
 fLx6J5fMyWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRAAKCRABygi3psUI
 JCK7D/47hGQ7EEbYb3RiVEfPUWL5oGTUJJuyrEfYATok2diZbfaO8vsmGKTDnEmqtKb8gqU+2n7
 Lp6zjhh9oEjKyRrzDCkkkklAINjLnHxx7H26yAlasJddrqlaH7kCy8plaLF2XJ6M6QSaN8QTqOn
 lzyI1mnllthTYxE/9HN9qXHReNQDyfU2DBTuI2W8eGaOZ55tqbCkrqUJ9eDRzcDs/teI6Mog8tF
 uFUki4yo1nji2ZfM5tYEPEWsq/cwKfp2HLbHO9HGORcl++fa0ulK1l2lFsCHGXMhFpsItUoATlz
 /yel0bcv+HY7DXJ6S8fG1IHJPp+x6HSki6RiwuyHZDON21iabzcb1AuMF2jeYGPASvBBDSxyFW4
 J2KgywRdiPunrkLovWNtePU5yquVzgqW1TaTA+B/mtDJYmbgGfucHP5QF6DsJJVXOgMS+ZqbEPr
 zaF01qsBjk/QutseSkV90pKuIUOGYFJ0zFwPF1tXd30QXJ/+4ZJhq46HfG4/+1POdsdX1VAMhz5
 aiOFVzqmdR3Q2StZuFBqPGJN7fVpDeEZ3UFlyBzKkXEOS1edsss5HO+qklSxis7yDADLnr5A6Bf
 YQ93e8rBpV7P/nz4rlR9VEV04XXOdzT20JF9LIYVYiMdOlZbu/iTrBqGWOP9TwzY0MCU8j12Sz5
 dOTPL8I5jJybKiQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 5b5175d6978c45052ded495fc0d18ee3a8fbfdcb..1a3a90f7b9ded42e371ef0b41057fd3081579615 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -151,6 +151,14 @@ timer {
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
2.51.0

