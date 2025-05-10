Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2F25A2DD;
	Sat, 10 May 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889942; cv=none; b=BwByz7LHV4IPzCq4EThJO0bwzI6DHma8jD6klKhSUe2ui5f25h2UmPZrRKs2X7VgIQHi6gZRxS8MxovwMqKkYjrSMv4IKnlLsYZSmW6j3t3MjPioRlS8gnV1dpWOaPKDN0NwJiz15aIuE+nTC5Hk4K+IrTJlmvUH4ZLAL7iluLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889942; c=relaxed/simple;
	bh=/9xxkCL20iFcrQUCvIdlPD0ncxR9ZewCh+wmud58YcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrkR1n5/WL1IEhiCCwT5Uj4NsaCO/GY7ImE2HYPP1bOHHcJrBKTaVcvvztz8qzRV1uNIpjLgeUc03aVHF3Z8VULD9Vtr9SUTaUKcCKkfHm51gvNUameVPRjBpVr5OwuzktWIUMDaRC+n34KjFtHU6hfe/EPtSZhldpjBVSEo/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoQ8gCsS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoQ8gCsS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-741b3e37a1eso2399243b3a.1;
        Sat, 10 May 2025 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889939; x=1747494739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t22CBONJmB65GQP7nsD4ofUIJ4+sf0vAxHh7+1UHNU4=;
        b=PoQ8gCsSAhlos0tDttladkm4qHpCK6BHTSdmnuWPiPxNr0j0XsUj41QfvRJD2/qWp2
         lRqpl+ygjlce0NyTAPPVj6Unoig2LAnirh+Xza83T7SH7Zq9UROqEuf3an+kwimEwqv8
         6CRqLieR65ZC3Zf0QJqx/fX1fq3kpJuUPkAmAH0btRLfExS45jiuYFVILSEHkhFBpOJp
         MFtMq55hEMfDt0HabyWvx2hscXhSSyTD+NR+xUd9e0WbcZx0lFTLKaDdcuAA4Q4oVcyd
         W08us4uA4gd6MjQmLFy0jwPsEqIudNeieyDuvQNICyuVvxZsb0wzi/bVApIGXM5NDoHo
         BeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889939; x=1747494739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t22CBONJmB65GQP7nsD4ofUIJ4+sf0vAxHh7+1UHNU4=;
        b=PVbDjVgwbRlofKU83lf8TjB9I9MFtXVM6uD4QxXUldrohNWMg/ZJdd99lQJDNB3JLO
         jH/aou8qsTEntIQ3JonfdlPdCe7D0tP4kp3bpaXfYzbtUawM8N9bIHGP+/LwLODCEOwX
         sOcQHRAtfBOtKj37U6PdiAXHZXJkv3J0xvZvD5sNSzEA5Tqtv2qs4zWbSwVmUUmLBtdy
         uB91GDOFA30wEUAK7MMEvs4jDiwcfEw9boPOYZQtYIKtUKM4vl3eaQgbdvqiK2xQo6PB
         FyT40O+c0u4PeSceH6Q5umXMdJjcZ43OYvHFYEL0RD2gwHc9/aliamfJ5Okn3IFZR1Uj
         xIhg==
X-Forwarded-Encrypted: i=1; AJvYcCVmjruMbIWMQsFuwSsH9J81IIY3zffxodEydiNLM7i2/ClqzwDRMarOaQqq9t6wfF1JGY1NEgBwZVpR@vger.kernel.org, AJvYcCXTRC9DCz5uQkQn3EOJbfklgXQMiHhoAKN9v1b++W1199Asti0qyCep4/bayxp6qSMpDghfceRzCLctWsTSpH/Ntg==@vger.kernel.org, AJvYcCXUjbSmyO3KbhTZjUnyC8B/ODJa+BbY+3QImRPdIFgduAT9DDbXMIpymynRqbOlCzgK5Wf2ERWKqPOxKPDH@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHp8GiSfPbLFXHsx5ATFI8+b5c2ViolBNMy7vevOk8UNys6Wk
	F/1RY9kiVrH3jCh7lwwf69Vv8xY/DVYknFQq5YXC+uAZlFetn+ZB
X-Gm-Gg: ASbGnctVQnHIpkx5+zST+HYsBJBJ4CcHRBB62ikfbemmX2TXSxWE0oW+4AzLuzrZief
	APRKU1NkPWul+JSnl53On2kcnMTjizZdOzf+sGmyjEuTH+on9dDjx8yc5QgUI3jBm3OYxqLwSr5
	352Lts66YAtjvFFbdFdypg252eiWw+Yd3s49wZQtsvHrE3GNtBmChW6splgUZaR4gOyPFYvax1s
	Yx9i9fAI9bYkTSLU8x6IBjBfcxVMhqGvUbh6s5cy3+ZLrKqh+9qsrMPcq6VnzecxWvuoTxhLFia
	SklL0/gFBfrP7VbgNQQNTDQOuQWM/f1rwLJ51jbBdKzr/z3xVg739g==
X-Google-Smtp-Source: AGHT+IHmycZ/aubcuUmT3KlKs6D0FqxvUeGQpzaAoaHzC0PGrVNsskD6TOGx5X64B6MlTwp5SLMGBQ==
X-Received: by 2002:a05:6a21:107:b0:1fd:ecfa:b6d7 with SMTP id adf61e73a8af0-215abd07500mr10502554637.28.1746889939055;
        Sat, 10 May 2025 08:12:19 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:18 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:56 +0800
Subject: [PATCH v7 15/21] arm64: dts: apple: t7001: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-15-bd505cb6c520@gmail.com>
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=/9xxkCL20iFcrQUCvIdlPD0ncxR9ZewCh+wmud58YcU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2ycPedKl6IfEwy0+uwFnPe6Ku1PChdZ5B6x+
 HcY9/bBpiyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9snAAKCRABygi3psUI
 JKVmD/wIKSyDQM2B87kji0YzCYd1SgIlFwMTLc8VuSi4g6ICeDvigM3F066a6T2XA53sYqLjatM
 CKzmaHqPIrbnnXSEkjL5mGjYTYtES5SRx6k9PQBDK5c/KbJ4l5Xpeh+d6Btgee7PEXYz+E4AjyB
 c5dmTZFhuQEes/57lC5ewrpqZCyccxQ1vZr9pM0jejMfICydp+8Xl9repdUKoCZzY6jK0ab6L4Q
 aVT4ap6D8cz5oDqbDPA2UUdKm83tD/VrsqmCNZKhfvrUn5WPRKBJA/6JYQYiByEQ05EG/gbZ133
 R3g5mJ1oKEL4R64bWbDbtb5z5G19wn+UeiwHalLkwZglCDre69SyoU/IjAcEVFCNh742N8eaLz0
 mKwPvLO9eqc8Ic1GJ1Y1zezdKHzVFRpHG+YxS4ROi9USkGfy/l7ZevN7NbvHbZSRC1NVPbfZ9PB
 dg1Tdhfv02EkcgS14voAyJJXAXtA1XG1/8ze70I1zeQXW0bv8cBhyR6hF8CbZ/sDndcISZ9wI0t
 /vYRyPH8mlbqzs4FWiSt9GQDncE4194KAzifAkw136mNd/4qdXsLU0jQ8VWVNjlYugG4T4Fy2lK
 5z0i6/udd0on2ngFSqRiAJuHb+qhGK+Ua9RroG45AzA1OD6XgCYOm3QvsPJpKL+ujwwvvx1AjtI
 BFTF/KLxIuHy/sw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7001.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7001.dtsi b/arch/arm64/boot/dts/apple/t7001.dtsi
index 8e2c67e19c4167fc6639458ce79588e153336603..fca0a100dfd7b29086735d36fec0db51144da456 100644
--- a/arch/arm64/boot/dts/apple/t7001.dtsi
+++ b/arch/arm64/boot/dts/apple/t7001.dtsi
@@ -183,6 +183,15 @@ timer {
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
2.49.0

