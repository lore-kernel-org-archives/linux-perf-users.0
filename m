Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52425A2D4;
	Sat, 10 May 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889939; cv=none; b=IAMYsOXbEaPcTxsQUftMLlKGVv+5pBsJQP3pk/exzGMHPO8Oi5hZT3M49OxESKVR0Okxb895x/MIwgX7mn/6NTWQaFZwX76crEHV7mQIa1f84D+sY1joWqfI0fsC8fgJnmjbejlP1G6mZfs3ceF7aXqvv12RiEHRBxcdcWr2JME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889939; c=relaxed/simple;
	bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gezB/FpiPlsyIZbCRqAWHDj0ExnhbBX/CxmgTbIc7A5ejhA7Dl3cSYXOas0c5Ijk2ZzqoTmX8iwPHqyoD+K79WGeRmH/VuqB2uYEBwM7tIPJDePRpc1vZb6Gm/uEhOcpJBC5p4Ka+EoRB2QgKwG7mx07lWdmL27Oxa2tBjE5bxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dngQ84a0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dngQ84a0"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739525d4e12so2923444b3a.3;
        Sat, 10 May 2025 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889936; x=1747494736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=dngQ84a0YYlTxMMYCducOnhvlJaPOSLS1XfpwiAvIS1lR50K6BqY+kpUQXy61Apt9C
         AuEnPunKuHy5WCRaQPvA2wzXxeT+TcruHaJihg2rmnWxOTFojSoTelMz+otdDRZ9GivV
         /QN4rGQz2eBqoegrhwAiLDceWSMfDu00AwmKp6W2zpWsjCf11ymDdq6vGKJbrq2Xa2PM
         tA6oQ8NK3P2uM0XEfzHe58QIs4S9Ysnj+5O5Vc0QQyWMjNa/k+i2VGP+iMAZTY2UFfR6
         snc9AJD7qU2AaQP2B0S1Q+PTjPmmK+5dQ5yOIwCMsaTIoC7lKFfDaojagn7BEmYN+naJ
         qbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889936; x=1747494736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=t3DByDATwEZHI8SVTpia3b5qE7Xb7jsOjiqAJavedRtng6hSWuYJPJuC17/VUEKV91
         dsAfX3I/ywmT6mpqDcFlBJEYbV2mQbYvJKfAT+QXv/gd9lJH86K4Eq3NIyCwZLvLUIRx
         AlBsf5UybBaafaYBH/ahtLi8k7McSIN4gPFyikvJlvUuNZJr8D7RN/VlY4SvMLAfFCpK
         g4Rw1qhISdd1eMFz+i6OAoFanJlt3vlD3gFszdEPwowLhlCvdIaj0ATdS6rxzEipkyMr
         7l7EAIgD8jmIZJAc0NOooK/IZ9ZbxzJ5tI/TqqEZ7ZmDuuDIxkQfIdTQ+h73S8W7i5JD
         vARA==
X-Forwarded-Encrypted: i=1; AJvYcCV6d4fagIuUYWS4SLxK5acdz0SU8J1ttvgp//6jSaGtWZbwFyHcutC9KWJz1/V4XpT+ZalNdx6uf0s5IlPF5JMqrw==@vger.kernel.org, AJvYcCWpUePpSixjz+Ny7VbaRyBY5PgL58fcGZNk4dCkzzczTpKEi1UwCiJT+r41TBsnxm4WoYWrChUPlNgr@vger.kernel.org, AJvYcCXz1SW6uWVp6xUs/phHidEq3pVf9JYmIvzbztzeBk9i4cvNG68NNl4D4NeKG/MKK/akhBNmauuEf2HiH74H@vger.kernel.org
X-Gm-Message-State: AOJu0YybT3CSvgm/knhqs8MU6AbFqA0fUz4TgT/7ngDrMkhu27aP8R3b
	bOy834af20wNZLaPMJI/Y5WRP2rSN/7SAoluuFruYepjB3ok1zbb
X-Gm-Gg: ASbGnct5e6zKU93wUcORWEyk/ulrm3rwrePOMHHyk3MNJYZsxt3o9yzAOanBE9IeigF
	HrePmkLG+CzzQtN6jTJKbcQS/wEWStApie9HAoxBE0G47wNm3hdOmI1aaLrx2vQr3wJ9EpTEhSj
	GCrjDByOA+K8rOd72UvOXEN519bM12YzYFRvWI4uA7LD/qdHBe163G1r6iuAnfMiHv9oXXjrXzF
	FzVSkYoiLTl9PFHoUm5lmY7wTLHEWoxXBS+Ftxq8IfSMJsWzWqCQuok4ucqeGpJ8+689c72nX2I
	5amiG6I4Eob1p5xWIvevjRRIwcj+nwoHcahcUWKX7Gl7pgpbc6dHNg==
X-Google-Smtp-Source: AGHT+IEFX2DqwxdNjmLY0TBMvhcn8rxV1W/2cg8dtnsnJo8cCkPubmci8tpWb2EV8Dq18hbWVPX+Mw==
X-Received: by 2002:a05:6a21:920b:b0:20d:5076:dd78 with SMTP id adf61e73a8af0-215abc78934mr10836620637.42.1746889935720;
        Sat, 10 May 2025 08:12:15 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:55 +0800
Subject: [PATCH v7 14/21] arm64: dts: apple: t7000: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-14-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2ycOS1PSJO7bDASE4Z1GCvIbNEZdRdYcGnw/
 xFXUL+wJ7iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9snAAKCRABygi3psUI
 JBSiD/4qe75dvVc4Aw8hNudfAwPjI1bmZ+dtl7+6KmhbrsxG8HVCuIUUtaTMrO18hBl2MzqRwlN
 Gsvc3t1A+/SVN6MqPXkBKdjW98xgBKaqvqydSFkDUuPoNWgVqbEzTBfYb/ZI27Z5YTkeTTiXJFS
 qikXFLANYPM1Cl3AurtLMxb++72gZVWawt0pLkAqhBZuQM+atr45CSntSH/1cidDRpVzAXCvqDd
 xboQrsmwXB4HxAe5JQhbR6qI+hGEncTrnzhKO/V9k4FEjLD9yJjd6yqszbPb5mpGjD0aiDSTdcx
 3ZsDRiLysIsLD1i+fVqDXSVuhLmAa0EPd+5Gb3DQQJT6lSpr5hhugPOFKbcUg92AU56GFxHZIJe
 Uf/l28LPkd7syoZxn2QJnMghBzBh2eC+93e0Qvp2LFL+KtLIuWE+GxeHLXXO/xFH0W2Lj/rKki+
 MiukYYBKsWSrcCvz8BFCNWaIUeMo3L6q1q8MjFvHt+tLtNtoIoK7Qgxv5fuTilqx9QG+aqaThw4
 ayW9KfspL09CYGa8Oe8HSMB3uoVfcz2hSdarxmHY4rUSYzDVyCRZCGPLy3aTF2tHAY6JFZgzMmn
 vKdD0Ub5doPjb1OTb4GXAh8/SUbdcDNOts6cF7fEPyUxDirlBHi6ICD4t4KyeYeHeeGzFakNz0Y
 GF+VOsk8tfi/sKA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 85a34dc7bc01088167d33d7b7e1cdb78161c46d8..f1415f50cb150ce1d33999c817243c3dc9184199 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -193,6 +193,14 @@ timer {
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
2.49.0

