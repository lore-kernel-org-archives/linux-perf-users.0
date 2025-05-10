Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521B24678C;
	Sat, 10 May 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889944; cv=none; b=uHesYeuJcnVaV0aK2cJZlR6DnnyfdqmhLycOXpHc5ZL6/poBswW5+irK/p9O8/khFgWQjeBNdww9HjfbguRGbYeMH9OzughWHKYLAAcbh/+8ISiFkvFLjpaMo+JF4Dbbh1ujYCgFOhKUkpLkVAQ6xSHGrndI6FEMV5qJiUvNdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889944; c=relaxed/simple;
	bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkmUeKU4EoMo5PwIOvzW2Z/HRTIrHtUYh6+L7yx/Sv3kr7HibaorK8WcXXc65EjROTq5dk/xouG5gDkNrZBPTr9nVcWyW8gQvoOaWL2M5yfRsLTKMrnzIW+uRO2yg5SZKwlpbJ6CMCQNcbieBCSOPAfbJ/4rSjIQOEvOr16qXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGOrqpcF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGOrqpcF"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3130627b3a.2;
        Sat, 10 May 2025 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889942; x=1747494742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=KGOrqpcFWZIT4LAjYmETFgdVoCbeDWb7ZXZdPvfLf2aItFKKDje2wwnkC6nX6d6Jnp
         gm5v7yB8ZlIUIPlaA84vV4YJVh8QZQU6tXd46QhltLVntzVjIKzwtI03nlJem6NzjD3/
         MxuegdOc4aIArgOyIe2slhj04nlHDDhV1u3VAJgKE3cy+ouFmsSwp8cT46azr6SigBk8
         dWqv1me7E9VgPgQUwGUeDKSeGnGMcVEJN1GD2rtu7yTRGhp/j6VGy/bymTkKr3uIXnHz
         R08WC5Rr3sufoRbNWDh7pCpd8LyZ9uHGZIh4ZN2e+Ul/lgXKJo1tUj6Jk4KQFNxOL+Gj
         gSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889942; x=1747494742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=SRiNYijUF0MulkoGwXKLzc4WkQIuV1jHhora2ZJLlFBFnbJZLlDMO/lwd0b1zWHCbB
         WkXKWj2Bd2Zcby0SEh14rJdRxB0TdiZrk7hjWYqBKCGt0bYJqj3plQ0UCU/++8TJU4Dp
         K1NU6cVEFr1DNqVX4Oyzde+LZBmsopz4AnK36VmuEJZ/DU0NKxtanuPgfBQwFmntdoHU
         SB6x/7f9KyM7yW56N7szGHinN5fSNHZVxMFOIZfDG0+7yF0qKefqv+akgTlMwm/38PEF
         wabMKyPXOBE0ytmKuSQDATb/KC/Iebij+bNN4RCwU725kIvRx5LpJ1oJzjO5eZMGw0+o
         Uh9g==
X-Forwarded-Encrypted: i=1; AJvYcCUemEqnnlF8/1nNYGxPOUkQ/cvp3TWE1SvKrCkOlYVkO9CO+k7r31EXH3WDwNL9w8Ck6W7/KyJjbmN2zruj@vger.kernel.org, AJvYcCW0JjgbN0bt0Sue8K1Z+pxbjtCA1gwbEvsDkTiosrXmclTOj1C+TBRLK4957ORE4Uia+RyrFOmQs8LalwfA5Bk2cg==@vger.kernel.org, AJvYcCW2px3kz7c75iDaiJ4TNuALQrF6f1xu/B0iwqM2uEF2u+rm0DbZfZty905cJMpI4O+n2eFf0ACbFSWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsme7+vkQV1dU6DEFEq05kadlRkYUBB1spT2W2u9fLij4YuNQa
	MQTIczYz+JRVnpoo2p2qtm3QTlCRN2NcEiShVnFKvZEA41DH7nr8
X-Gm-Gg: ASbGncteshIvS0u+HMYaM+1zCYEgTk1AuXqCyOJi5AvOas2G3uW4wb1VxQtid8TqoB8
	x8GOs5FiDwmtf+FvUq4pqbQ1hSjc/uJiA6D6/7A2xWbF3EtUYYUbLrktqWQjI9HtZHE9iY24BX+
	jM3ywXYDtse7DDEW5URL+DAHbqKAqfVbI8uB/9nu3ATZjKIpxSYdhkBUY9dllil3N2VKfnSXXQ0
	6m+45JU6mZ2oPyX4wXzIg7ZUrSxYwUHPDgea/V9ZjAtA3bE/IW78BwDcXJTCJmQnQP93MrqkJLK
	2l1IX6y/AkZ754N8/sEXENqqOLQEUnaNWHZUpSJzCfLnFMi0/YlHkQ==
X-Google-Smtp-Source: AGHT+IGjCiaq7DPW0ss5kSC8m5rXz2rGLoebcSRmwEAm2E1zJtcjgOYnNTLJIp2QwACkdCzP3uIZDA==
X-Received: by 2002:a05:6a21:999c:b0:1f5:8a03:ea22 with SMTP id adf61e73a8af0-215abc2a292mr10479573637.33.1746889942388;
        Sat, 10 May 2025 08:12:22 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:22 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:57 +0800
Subject: [PATCH v7 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-16-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yczRzniLnke3xszhfsW+XGkbCWQ5y3Qb5cp
 1duw4wxyu2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9snAAKCRABygi3psUI
 JMKZD/sHdqY7/eb2hXZJM9x0AcT6jctbVMU0POC1oe8iZFkkQNQhUTEs3yCishcMCmvQkqDCgK0
 8LbcyIOxnE2TnWL4QoayLcdi3KLGaoLZe8x4ahuZk45u0jnpnAeR7tb4PgTdbSwUM/7MJmx6XqT
 tbkU8bNsd4UoBDpuGVQ7E7f4JQULOxWYlk307fNflieW+4D1Zc0kr7Azw4ZNUXzFSSkxuKBN41R
 oKyLfYtyatf1edIp6kiM8SCNlNhZUPXtSsn0kVEhcKIZYJw5U7yqZqACMzQr6cYZZa98U5CDkmx
 hupO0pVY6XJo18lOwf50WcrM1pZpBT94JY/2cPdRf85LLbJg/mUxgESCs62YIoY6U9Q42V7flLP
 VqhwpRiqKapsynvnaOaL1DY0ATTVtUG4C+rSjVsjEJNlrWGRnLAEjj4nwJ0kkREME/PEju5P/CT
 EDSig8hTX4lfUfvxE/h+G7K8opgOTh2bEsUY6RDmA9HZZVSS+4+ltAHHWMdVLA5TW4hrF5R2k6U
 Prra/uwS7fNjXHqaatz4be924qUmfPnHbvfs5hNPLSX/CCZhf4MNTseeF9fpeiCg2yJx25ed4lz
 lLLY2mxQLwTsqMK4/athAgSarEOX78leckjcmOE62hBphzRtb6QkfEg2TC4T9CwWWAlc1m2C26F
 TSymqJmw7zJBK1Q==
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

