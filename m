Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69237227BAA;
	Mon,  7 Apr 2025 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001222; cv=none; b=tBuGm2l7NJHqxuCq7WWtaXKME14LuBs2aMnEnASWbUx0lbrMcAEfx8sscce+7XXN/jWz5xRpd7EGJFTxYp06fCrMkf1+NYIF9xg56wK3fVG7khqM7blCYydF2O2PfIhPUa/iiaPQJsFs+VzW09ZQQSPCnlpx+NwDBDH8/WMLjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001222; c=relaxed/simple;
	bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qrk+Z+xrMWkDMpJiAOX/Y/uNTSvw4xEgMddHFgdY4D94ijmgYfEUf3PjbS1efp96xvMK3llTjPjqoiyRVWDBv0oSzr9WvL0fvNeQZdfm7Z9C+suau79CjkbdDsDCpbh7jiSqxuCioOHhS3HjU8d1YMbrWa3EegwUnn3s7UaUFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isJ+imRA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isJ+imRA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso3187308a91.0;
        Sun, 06 Apr 2025 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001221; x=1744606021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=isJ+imRAidMOCC2CqHQ8vVpMsIGe8b3xmh1lt6NO2co406pmfIfUakwRdNMiqtSQfN
         wNy5sOLOrQadVt2HCx+ZC554bR2NqQD6xl55Mlmure4njYmHNdRqR9mW8SdNXLL0FPMm
         x0CaQqzRlh59KTJpzkdh709avnpVkWrWACxexUNB9e5KEXiw2AKolZoJCfBLmUX0KRG/
         y9jlBp9wuUnSo9N35bjKNtfim1AvRNEzYyN/He457EFhcHtioRdK+VnIl/oLnPT4JCee
         Iu+fQESxYTyn2/x6Xcc/MqdvQRt33zq7xFrqiO92cqR4SABqHb7jnjh9k+rDcVqQKW1g
         /wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001221; x=1744606021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=b5eRE6kTZNAWkRhcqGU4T0ueiz24w95yiD5Hghcg1o+E0FDm5hrCfhsdLYAAq+r8iy
         8/AmW5A8HxaiRHm1/RQrxDb+eW5aqlW41l1ZpE9LBty/a2WN6gBXAmT8oBN9lqOL3jCT
         2JExV6oVpclDvYl716YY0rvU1RE8gdOiqqfvx9Wg0QlniJNFl0zScqj912dfCue/T1s+
         +YZZ1woP3f6ckNKvtlUwVy6tN0wd/4PM2PPk0dZ1FIH2vaDpXyzXoZday0H69ah9Wv7b
         cSV1GFRNrxRkj7I0IVIU8j3m8+fjKEcNqKlT1eoGi/xpdBJGDg9lZRcza5UV9+gF5Fmr
         m5wA==
X-Forwarded-Encrypted: i=1; AJvYcCVMEpjeDQdC3AAmWqnaiS6ZmNQ6erdkayjxmmVv84NBPJrAw1ym8b7WElTmFjzknFiZPVfIBh6J1L1y@vger.kernel.org, AJvYcCW6VBaXmm4apXvnUxRcuRVIfOBtOb/CS7nZu29m4soZOCK/Sa5V0C2coGPVkU7bwbxfRbfgH8cukwoq1s3/p5+v9Q==@vger.kernel.org, AJvYcCWQnEz4URnmrtWCtrCb8/UJNsOMwyTDW1RMtAV6Xtdg+vO7kgKXRI018vaKXMmAOToG2immGyuOdBdliYJP@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvEV+ISNk7qlFddRQ8+6y4pYqG1FGjhSX8mBhtPyz8gzIQLJk
	IK+D/HGw0C0vZx3DSeJizmJ3ryQIkTbr59FWoZri3lIBnIiUEOYc
X-Gm-Gg: ASbGncs8pc9RKuheI89BhYEEOdaqytxeYUMSd22By7mvMtCutJcHVLbhanPjOQ40Mmd
	IxpTHScylBXZw4bOG3vvigfBjsy7vU2pBPK+T/I/JXNdDZ/j2oo69oEWynn14rCMRWyIfPdR2eH
	o4YDbJp+9vkLxj0jN4R+6xgsoFhcnLmX4lpyv/cO2EpTM2jkBoM+mfbYAGmBzPSKl3iiUumJUSa
	oFQqyuZvQe+s9VYMJo1AxGB+DOY/oJVuD/HodO9ai8jqn40nKhqM9qtFBEdtJo6ckAVqlVSNkLY
	/RbbteqkepUlzoUhnkmNU53xm9If6osUcFCRZ5lh1+ma+mY=
X-Google-Smtp-Source: AGHT+IF6VKTVoaa2v7ROypT3rc33cr4X74TarWm5WZaI/cJLc+61XLoqRW6SGcjhOzMHytKH8/7lPg==
X-Received: by 2002:a17:90a:fc4d:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-306a612a138mr15716200a91.9.1744001220725;
        Sun, 06 Apr 2025 21:47:00 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:47:00 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:26 +0800
Subject: [PATCH v6 17/21] arm64: dts: apple: s8001: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-17-ae8c2f225c1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iIqdXyLmDtBvsESjN7HS2mBfSWCzi936p7V
 fm0906jqguJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYiAAKCRABygi3psUI
 JO4FD/9tOpeq8/h2OPsPrKBHo/X0tvi7bpPuEBKJm8FiP6qNhpcV00eoB04+3MvO4h5Jc1j80iS
 4J8r8owDxAdaurNMGOEPAuqW4QQlNf9ohTJLVCWlhqxmCTDqfEFWO/laqWUe4gaXsTR0Xe5/zBH
 T3skkVKBOMvyujzaCXiESZyYAO+Myg7UcLgizWstY5E114QwW8WmOP0ASvkmVJvj+SfF2Ms/QoP
 mRQCoWoD9DznWery8KoU66fDtlZisCtN93RZfsUFOknoXTkjlOzMEu+hdlc64s5OEt3P994g4tL
 sHSft2GGuuLYTb9LtaPmxKaXaoKF9bTdBdeweJwXt8L7fcUltOBUPluwF16yEJjmbDEctKB6cPe
 zOi8Q59y2z+tOYXbkSj0CUoN7PQXReakggUmmyk/95GwRqUmDNs5UkBnZRugIswRfcxV7YcvC2n
 hl9D1OkpKBtoeV5wGt+LgNYOy2pBbBPO2AFarPxYIH5SGOgD650hAS52FkDdVEmXHOlfv6Wf79t
 epTjMl8qohJhPbPts0iX8J5tNJZ+i6S/UZBsIiT9B0+TJdGl8JpduIGlnjb7lCQTnUfeacEM3ax
 t4bZKn55++Qs2SowQB88diB19ByR3RLNJ3PJCRhft1jY1pOWME02FAZcfTRzgbZ93qpLD/UDqA9
 7VwDTC6CBdvKzyw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index d56d49c048bbf55e5f2edf40f6fd1fcff6342a9f..33760c60a9189df5491256f81db7f413cada27a7 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -209,6 +209,14 @@ timer {
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
2.49.0

