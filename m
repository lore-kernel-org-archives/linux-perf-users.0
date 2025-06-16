Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79235283FFC;
	Mon, 16 Jun 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037585; cv=none; b=ZlzuIE9rXFPpTL3NLbi4UQiI3nThpp48Pmb6b3yuG9oTE1fLw4GLRuNolhqLLNM/XOJRomCBtcHt+l5a+8HV7xoBAIHCrU8QEyfa00unOj6MCJDV4uoXijSLsaqthCBR2S/6z4TbEAs3c3K0AgKBcx7pMN6bQugGW2TMsPb/5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037585; c=relaxed/simple;
	bh=/9xxkCL20iFcrQUCvIdlPD0ncxR9ZewCh+wmud58YcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOFw5WqniG3bbSez7lhPSgJ9hBWsvuReH8coQaZu5iZ+mDYapMaBTlh3rlhOuV4RubtSAm5IzQ9wWrW7nRH4usDkFZPdqNwTy0TXw63LQt+HEA93EB9QxTuAJIn0szgkvd/xX/GGvA83U12jTRwQGNQ81JKZTBgr3S1imNGxccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9JyCQMx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9JyCQMx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234fcadde3eso49214985ad.0;
        Sun, 15 Jun 2025 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037583; x=1750642383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t22CBONJmB65GQP7nsD4ofUIJ4+sf0vAxHh7+1UHNU4=;
        b=M9JyCQMxY+rPvZw1+wgzxnSlw836TrD/Us3B9ZCe9dtV//ySciNT4cDaJCLY0Zp0CM
         08a6V+ZdPZCuGZozllphDpd03i3rQEPx4k/NlMa3sfKBvUBtgKGxjM2vDr013sJ2DwMh
         1jloarQcz/115vxCVbDjIJwiXfNRUFsNJ/DWFs0CLefY0ZdM3eg6hIIaH7kEhJBvUXyO
         9CrT92fLXbvW1OuajMf0VN2Eopq6va7bgTjcu8dPD55ghcjnCBxW87DqymqoXViuOKVC
         9fk2w3qNqR7i8GnVKUOcQDWNQ6qlQL0JM8FAnOnxF2l8jASiRsHtbAUW3wNWSLsTgJHo
         Mu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037583; x=1750642383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t22CBONJmB65GQP7nsD4ofUIJ4+sf0vAxHh7+1UHNU4=;
        b=Vk4TJrQKNpu/gyCSDaj+yix3oRFa9doADwgXMzpQUg8LOo/CLyvqr1ZmtAoPA3VRQN
         1ejwxcDyooi/bQBFcfnTC+uV+oieCLiDy/lsBQWAsQ7rg06TpxICW7SfjIfTCub+rVG0
         XfwClWNkvGI6caNtoISZ+E8s8HaER+FWlf4duqLJuJjBEznNs4oJaEFqMDIjAQODjg73
         /J35shOsJgtU7xxL5MiWH68t+H84AtngrH6DgrT/L6up1PWONM1plPYpmAKHLNjxJrhl
         v/+y6osvSife3C7JHFMhnHh6tT2EWD4ssnWE9/K3VKyUk09tIusm/1Qazxy5FPQihJ1k
         HXOg==
X-Forwarded-Encrypted: i=1; AJvYcCUT8POVHQTQmUR/I4OLKU3ZNP0K8dmWx5D+4btVyX6nIkXH0Vw5GYeksTU9+3cv59Tfx1eUfh1XAxgb@vger.kernel.org, AJvYcCV94jvTAXTYsHOiJLgQHeSMjjuxyYwhFyk2nRAXNnKBnzY6BsCvANKiz+nMWR06igMIRj/S69yiwPIiUMo8x/l9uQ==@vger.kernel.org, AJvYcCXVwyhvYQVVF06Iyn3ouBbtu5nqnpYMvxlz3NFc5OGemQ33wBoz8RoFNtuLZeUshRLjfIHwEJkHPf3IagnC@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMTgVsawTaEvd03nvTSPC6lCVi8KIK88UL3nvyh+m/6HuplzL
	2aNTdAQT84kIthl5Eq1Cy2xn6GH1FkJ/0jP9xyf0gorO+gAMhdBAmL9hUXZ4pA==
X-Gm-Gg: ASbGncu7568rT0XLAVS85xC+sUAUsxlSzCjiuEh4JrrK1co4hVgkUSzeI5Mr9+fdmaW
	Nz1UlKpdU2BgRUUK20qsnWgzSZpVHI8s5HLEb9rovp834R8UYGj36d24ztwUexJ4nSlaRsRc7mZ
	vO/kFzT6xOuYfohw0tbnO3tVOa0rcHAZYoSonA4J7Hkh5POnB0RvL/y6miGcnrCCVZ9lWE9czcg
	QdJiJz6Vh1KH/70A1RK5QFXg9TpwTrf2Por7kdIk4gD/pF4fovyTpFs26SaSjKhBtetVEt3kdaD
	QouGsOeYtf16uVrQltrosjSGu9kbrzvEc+/oK7Zh57BTRM9HLHqutHfCBcItN4Z4LsBUQ6z6KV9
	Y8W0=
X-Google-Smtp-Source: AGHT+IHy5nCDE1jMX7dMgjCgj5ZwKnKsJR/VWO4k4I2j18iZ2axryYBEpSYK4EN4u1t6tFlZ5HxWEQ==
X-Received: by 2002:a17:902:d4d0:b0:234:db06:ac0 with SMTP id d9443c01a7336-2366b3c3cdfmr109470005ad.45.1750037583466;
        Sun, 15 Jun 2025 18:33:03 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:03 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:04 +0800
Subject: [PATCH RESEND v7 15/21] arm64: dts: apple: t7001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-15-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
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
 h=from:subject:message-id; bh=/9xxkCL20iFcrQUCvIdlPD0ncxR9ZewCh+wmud58YcU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QZpSWBg9FmOWqt9e7BiOBFKGpVIwwMNXVdK
 GuwMCEHNzWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GQAKCRABygi3psUI
 JLsGD/9JnFPs1MyeLJm+POWVDjv5F+a9vNpJm+yuO6KNRP3rMfGemcqezgPw6r82s9a9QAcmcUS
 e9y9eIc3jEPXvPnb2XwasUfsWUc9La8BY0JBh6GW/GqxNZq74k7cUmx0GNAPnYMJguKJ9MaM/uS
 mYdSEQQwx0zF08zdCF+TIhcCCNV44HRmJcQho1WGks4mDBTT2pEWHuL9brJMwc7AOz5Y4YZD6P2
 1gdjivU/DRiq0T0xRviM8dN/PZkIaVlv3L4YtV2BNAFNySn5wik/fqc+3rFnK2DdXk+7vtcOAnS
 5t0PhyZG+KQ4h/sZx0iwVGrboOo6zYDaEZIIdMAxvwCXu4Qu24YjG2Qs7kJdv4KlT5/3UUkKNAK
 Ur0BRsQFuoRo1JQrifvrBR96VYsHOEy7If8PnROIJc0IwW19rLa401EuLK5g95gDipM01PHb9hI
 T8vZVxw2I6dx4Vwpm0FQ+voSuuoQFPXBppxWn8bl7I5nL8goEG/ZaNuihoBClKlBm2J3ZX6M87C
 SUdxvoHcw2TwtmhQWD+JG18vepSqXUFzm3qVprjqsrToYX5PjV3utlEUDnde29w831RCSbQ3gea
 uEBEYrke286hIdZ7BREvxU7ByuQq0lDsn0zWnBbVecYLqaeXRx9nJpaxdS9puvs+OqbbuosOwEg
 q9i+h135Fi5iKiw==
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

