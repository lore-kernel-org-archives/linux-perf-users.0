Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183622756A;
	Mon,  7 Apr 2025 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001220; cv=none; b=TsDB4AM+qHuegg+pyRWJL5EYnzHp+tIgz1kSqf5JkEF3SvViwN8Mz4JvXae9GnC2R5/HRjQh8j7LvA3mQBlp9mDNHPANWYRDm4dmZFlMXuEj7Ry8M0kqkSQTmhIGLCeRNqmh+9fDB+uziKFiTbCyG2kg9myW+R7zCZspxCvjOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001220; c=relaxed/simple;
	bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZNqg3f+eaKmdksvaJIui7QDMlk4gQB/E9UohRPfH9heFZQheK4aUqKN8qNEpvpewB27L0zE7ZrxrX1aFuacHbr6OVPdwzmGmmO+4zmGAkeCrAQzUuPnQE7lCsHQySB+YXKcvkQvd2VLuYnGXEsVwZJ017SIJvrWBvF/7aw9+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyW8x/MC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyW8x/MC"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af908bb32fdso3165099a12.1;
        Sun, 06 Apr 2025 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001217; x=1744606017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=hyW8x/MC49jibkJ5T+kmfUF1vSfepe1NbYFDb/wkkSCyJpxUKXy/U0Ns2szg5hrjIn
         06m7RhKo4JvBFzUOo5rlu/i7ng38IspjiNp6SuCo2zM4l0VaLn8peH3RIu5gsI9bei2p
         m+YT/Ql3n0/E/z8q1U6NpQHvgvhzribaeEVWvGDjAlQWBWEf5RC1/RfBA16G2vKysTDm
         ko/Hb3OQE1/x00soUVAjKj/wxm4GYssVVumu8Exy6mD+scD3aLy1DIGReoEkKIOS4SgT
         mk0iyBOXxD5vttRJqBk7tg/PXeArgUbCkJA6fdv10sLW5JR1Mw4iuuRwvMzsu/9Tsvn/
         sdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001217; x=1744606017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=cLVi3vYtOBSXE+y9smVx2IH8XiAPj38gSDr6+LL1Rpqtxs0eMP0WsFdqBXNulVLZiz
         ZIaVIBtrUY1cF9/lgymgZly2eLAMIwHdT9ARpzFrXiUBxa/PnKJQ92OvKN7DdvlyER6x
         jEqXG54g0FZVCIfOtyNFY/j9ZMYY1NGyh3GMUiB9kLgWhDGjdL4WF2Iz+wNRrzf1SPIv
         GmNBowOxMixbI68rMja1HI3HCFbBD1WEp5te4SvTW0pZtsmPH7dJcC21nHHC8Gh/JN0H
         QgO/mjiZAyATSc1sSgx8MnE1U4+9ctuy9PJOqQWPugReN8RnTuJ8smZ+4rjWFXIybU5T
         i4Og==
X-Forwarded-Encrypted: i=1; AJvYcCU67FTx39ibB4vyzareB44E2FpX1Av2bb2Ry1uZQgDIN4Eoo1C7D5c9KjM0F6Lw1wyHp0gciJR1kqal@vger.kernel.org, AJvYcCUIxeHHIUMd4jHhJMwez7+HkOT07wLLh5S6W/FCuimxfZgo2B1v+RZHZGAIzSmXy3HL5gaczNaeShXSHIXu3AYKOg==@vger.kernel.org, AJvYcCV5LxM4N2kNWcnBLArkvMIztfKX2jigekWKDf+390L8SjYqpfxP9yvPi9u1pTsQIh4hFMONSgats1+8ssCf@vger.kernel.org
X-Gm-Message-State: AOJu0YxLk1nE3v8jVP0VryBVavf52/wEj8KcEf1bXNHyz+uOe1Rrw4tu
	FC+SdARN9Vtxcy/gb9g1wJ48jYwpqVodBcK6yYB3DJ7EPmT9hLvM
X-Gm-Gg: ASbGncvaDJZ3qxi0LFUcA+iXFnx3dJ0PSi9BhuBmL+tpQkbfAgBY78KQOD9oyoKfl0X
	x3DLsoEH01WnXpL7/wv4Fy5NyIho0cdRcAIa2ELZmv3gfA87BBuQ21tRdIufLXa0AqZFCItoLSK
	dz0B93vGGgzBcf0QlqEnDTWmRYfBNhm0qsDBsOMf6bVC4ume7HBdL5sZU8UOpSW87CIb4fspHvy
	FEMZP4nLwBz2alWUvJgr85wHkwEgyaJeLvF0vigY+JyPMy4Zb5P+iGHhRk4njyedsuCCuH78P/A
	j/7AFDhb+N2azROFT4yguos2r7tXkKM/MWGeFSjR/jAQn5A=
X-Google-Smtp-Source: AGHT+IFp1o6jGnfgrWBgWwZCg12gAuSqGW7BBd8Tj07WjPky9rEWHsz3tgzeJQgC9fscCCvAKkH7og==
X-Received: by 2002:a17:90b:544e:b0:2fa:30e9:2051 with SMTP id 98e67ed59e1d1-3057a5bf0b4mr20505582a91.5.1744001217377;
        Sun, 06 Apr 2025 21:46:57 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:56 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:25 +0800
Subject: [PATCH v6 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-16-ae8c2f225c1f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iHn/Y14SjkGwKn8A7kTk3bx4cArLbVYEHup
 S3DW2jHrfqJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhwAKCRABygi3psUI
 JCMWD/9GZvoif5wFE9u7k5VLtRXa7bx03z/aftHbvMECDAdgV57PlyAlHnJqn2iZ0Vo8etfl3jO
 2UK57oGCoI8AEo6xeducqncsZ+ok8PNklu1uKutNYxcdlvBQOgJnl37DKm7uJ0SqfwnOiq1FNaD
 aCA9cm0EfH4/PnkMNc8UIniEHVG5En7VkQ9dywMsbSMw+03vXp95JCOtgAgpmUchmvXp/1dn8ir
 ZTtGxKmJjZ/ag5+93yFED4w1QaHJJsQttD16NEWPXjlhZ2IkZzU8mhsjoe2hDqDbj2V9tZ77QpF
 EQnNvq5kCMe1bQLWljMIGMwT7mbSc+PaQomyZFNIYE4b3sZiW1C2RJvqOi4y4MAaOcGfDf/o362
 jiSxnhxJmRO9qh+NF7/+YTI09ejh/ruGFHTIKc841iF9dRLgYu/SvQZ/N45sezzp5DeN46VkwKW
 z9VwoWf2mzT9QzDD99HE1SYp9Ym0N9W0Qr5fLd7nhWUPVy3uTsH51CcZoApxpwiFaiuGjWTdKeF
 Sg6snS5A0AtUgEr9R0SzxmM74UR+XryNNGGcbXwQeob3TWDEqbX5H7Cmgli7mJ32N0SqPK/dsGR
 8Cnqe/8ike3/pwrtHIGJ6mhCzYIIz+60ZRVXuHZp8SSX8KElbKRQWwLYj2AKZdCH4CksAC8SMVo
 jcnReLZ7raZBYsg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index c0e9ae45627c8150bc0ddcdc1e6ab65d52fa7219..56ac6e7f3803a16beacc74764262b02c75a96fce 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -167,6 +167,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s800-0-3-pmgr.dtsi"

-- 
2.49.0

