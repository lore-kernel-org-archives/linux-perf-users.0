Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61D21858D;
	Mon, 11 Aug 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920527; cv=none; b=EnwhT7RrhqOnq8WRCk2zVsFYdbLLCNqTd6FSYC+sTuirdsb3D7OzRAH0Jvzj2oGSRPwewMR/BoeNH1k64m7R12NhyhihQdPts3gqVYrBIwcq2kYa3d5QxUXDZFAkkCgLc23G2qBZgcpXXsmACkJ5UwnPbDiFkQO//g9t4NSp48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920527; c=relaxed/simple;
	bh=5SPeH4B0HCgQ3mPJQ2F9oSAh7NyxBKYYgDF4wIcu5t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4zmTirK/k6Gzvjl0Fn9I5lfAPVtfciojBhj476qMdngkAL3p62XbW0H6VnJszYsvotFuzO02ccxtBVzyjATM3WLpgbtp4T8qN4qeqYe0Ke2I/apHj+qfX8bpKwilgU301DoA+c33sCYhT4nHWMum6ime7e/JY+Vz3iYUZdMMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIOkG54U; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIOkG54U"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bdce2ee10so3404986b3a.2;
        Mon, 11 Aug 2025 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920526; x=1755525326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yEICwzwwwRaLhCcG1cQOxzwurLWc9XkHOs+XEL3udM=;
        b=KIOkG54UOfPQ3T9vX930u0xeoAkmsfYSsbSqa0+mastKak9qEV1bD4nJBFwt1/ekov
         s25xfOvJAr9At7JUtqHaboeQw0b0Bz/Dht3dRVQT9lmMJxpOa0j6jhUzOJdCqh2jJhg9
         INPgM9mU0NaHZiyiNC/6nWCBQmhW5aPMH9IbqE1GBpQuBLuM7XITT2QyjKaYMWj+k2fB
         Mlwd3MDArSmRmesBrfeCFOUfAxkhiRYvh/lw7NmS3aaHcxdZZWcCjhIY/swfA6njLK8l
         L2Il1jey2OxwLIyad/fCDRrvl2gqgl8SzMfKkJ+4gOV/EqA5NF7j5gjor+XFsqXvcTA3
         yDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920526; x=1755525326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yEICwzwwwRaLhCcG1cQOxzwurLWc9XkHOs+XEL3udM=;
        b=wwm8gi4iqZmLEdk7sujAG/gVR0SDhbKqju9g+7KM4p/DObrHC/vSZqHGYd8/rnHyzc
         2YRn8c68JPxgR34oxajFK4RRB99Tn/jiygwJiO75ZonLtpQSqqboAGFdNaavOTWTCfWb
         Rve0OfrxDUM12sdc4ksYq9eH6Yh5S+6co4iZ/PS2PGiIXG7zpy5TxR0R1drTi66o/Qq/
         8LOpd2ZSoEOR8BwtncbtmEbtvw4xs+I70CtBIXlcRkhtMZu+8X6JmlQZcjXO2vCmQLXC
         gMwKRi2ZMLET9BN5MSLPSx127qaldqSoq8kGIGDkiEijmp2kUzrQTLxyJVmHV1c4Iyvg
         dmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVaUhQG5NPBZMpB7XJs29BmgUWeM5gO2sUzHekrD2bKx+BotDDDbbbQjo64i6RMJyT9P+xXEwPAw3vXAm20U0Jg==@vger.kernel.org, AJvYcCVnYc4X7ET7oiuq3zud2QlldpD0dLtuTwH8zIuoyFTVzxrSzmOI+k5OePbv1SiG8FFujxdOTVJlvWxnGBTG@vger.kernel.org, AJvYcCX/tNNoVSDzOP7/4OxdU2xkavI/KQ8k31oUwxjoXrWiCnxhHY2Ijh7O+cdQ3An6N9/89gxUgXxrlRGw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aUDn9+WMDH3XCyVDx53eWKRKUL1JraBlPDP0wdBjZVYNnO4i
	DyiMY3oq2CxupswOJ6GC3eEFrdvQsej02tZPPtM0HLXKsf1b8HGoM52N
X-Gm-Gg: ASbGncuJpj6Tq/wZzJeutjEGF7hjZMXChTfZgfC0FAA0BjvpvOxozwR6y6+C/rEhTke
	AxSP7C+ybMn03Nl+OcmghRVFSoev2KlfyQFw8cxyP+h4WvoFcIETGdy6q7xGriysKl3Lh0xOD2y
	1AU/CygjT7exs7LOaPPZ1FFzkq+egmM6V5AJL0fQ5U7zLfq3Kg27EaE3D6dBoQSPt5pc9bw6OLr
	LnjEspXHm0VykWTFiBxbwneAPKkIu3I1g33cc5uHnWbmmYoX21Ks48CcPU179/nAPWU8t0xnKEL
	IOzXdbOPc+JLCKGcqPGJJVZv2ZyYGwvZEEmt3RXLsmnq6Am46+VtqMT+K9349Hrb6X4EdzBaxKD
	wZVVWaTEzILYCALpNDU+KhUq/IdodZ1LfKGUBxhzMAGbAAMQ=
X-Google-Smtp-Source: AGHT+IHrxdK71Sac1/zqsEValssuJOnISop/ofjKE/WS0pXxDgvF2hjTi3ciKyUhy9KZJyYZ01xtSA==
X-Received: by 2002:a05:6a20:2443:b0:237:89a6:fb00 with SMTP id adf61e73a8af0-240550453eamr22616449637.15.1754920525762;
        Mon, 11 Aug 2025 06:55:25 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:55:25 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:33 +0800
Subject: [PATCH v8 01/21] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-1-c560ebd9ca46@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=5SPeH4B0HCgQ3mPJQ2F9oSAh7NyxBKYYgDF4wIcu5t0=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZAO5K+imeOa8Dg5N4+Q+5ghWt5CcWmhnuwD
 QW3eaYi3JuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QAAKCRABygi3psUI
 JDWKD/9QBGFFlKRW8463W701zQkmmFBupQgVn7DNzI60gxpZrl6zbdgY0GYMCNYZghcz2jbhOUY
 XechMJLG/nhbRUvM3SunUisReUoZ8RyOdd8+hQNLPGt2raNZnuw3AJlC9mse+vpTFAiN7r3bPFk
 cndw31xaSCtRKxcFjtIuD6zrasEzIkn5gHPwhgj/4n8lkbVB4J0YqVCfJooAUcG/Wmx8eSuXV7E
 a8bRkvIiUJ5vzDjGfP78bhbk2rjhPIvzSov4UJeZUo67a2HC2LDDUg0NV9kFVVlFabbjD8Dtb3A
 dBnkNy1+T5faRIhDNnxCr06QSMX56SqE4MHLWXaS2zEwzQnFcBhy/O8oyihWbIqOGEmAiJ0I2a9
 m+jJ7xchh4jFo8We8SiXdc5vZe8QZqWlXoq8/BVnEAZpf5BXEkYQYJXxs2pGBqNUj9Cvu/cJhUc
 QwohgEye2EijPCbmT0TvQ2ouzjnXiQ9zC/O/LmCqtOlSW98buKEBPC2G6NrPlys0PWddBLe2xZB
 k7CHuuIDoWij9kxdtvLDC2wFovfWrlDIoHK8jjgOh77NfB7KMJNdQCvMVPrJoKozyFJZHtXYFLt
 KSDOTS9NxNP4jvcP6sVcaaMKs3rgze7vdbKAeQC0IHAHrsu6RgsIe53F/wfuW0E2CRDzIAREf1Y
 LB0pE1lHU/YtNoA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 295963a3cae799a54560557137dd6b3cf4bd00f9..3726e1b78c42f150cf1dc68a6b3aa3541517c311 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,14 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,cyclone-pmu
           - apple,firestorm-pmu
+          - apple,fusion-pmu
           - apple,icestorm-pmu
+          - apple,monsoon-pmu
+          - apple,mistral-pmu
+          - apple,twister-pmu
+          - apple,typhoon-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.50.1

