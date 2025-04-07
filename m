Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B1221F37;
	Mon,  7 Apr 2025 04:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001170; cv=none; b=j6C390igsun7VFDkteCUXsZgRZu3pOKQAfOvOQiIxav9VwPGlbODODhEHLHwvEbmFqsYjGx3J6qSGTymBTNRMdWjmF7as1t8XLXhRuddjX3hGC+jfdVyMDeg/xcUcosdeADvISKSUMLNc8vIWwEGE7k0Hh315fAZgcq4crE6YFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001170; c=relaxed/simple;
	bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gdhYWT488U+D0g4W1mlqRnMQCGKcHUXxJ7PHQ5x4pDfjiqAVp4Ui/aWdd/yHqbQh4pY4dk0ZgULXDslwsI9RmboeIJ8MTSW5ZMzOCGBVM9yUltTwHLHp1Z5xNdlpBWhgX6p3RQzVPayeG7SyAQMPOoRXNV4QUZMbARJPGtiftuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvFcu+eV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvFcu+eV"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so5004144a91.1;
        Sun, 06 Apr 2025 21:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001168; x=1744605968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=DvFcu+eVye1fKsUvTOpU8VT8UegiRF2ZDkgJOR6MUXHK/RVeVP4jfMNA3enCPqNVYg
         2Px6PzHWSZFSkq4R5/DCT42fyWHXVAQWK4fGEKJwL+MsA+uAFMdhh8e0RvfrYW86mrWJ
         3ClF8eVPSVVz5yBUJdcRqQiK6x0JKD+cJr/8s4OYd6H58/d5IG/8rrApJ927hRtu9mOb
         A47XQsYsN15larH1viwSgQAityZUmp4sqe2YpBDJkRbPjLxJiXlfFdI7g7XHtGAmWVxa
         IQh0/h/KQXt87d9IIn7uY8lLt23bZ72d0hkL9gHU/gk2yvW+tCfuSNwLIpECR4Ye99Sg
         WiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001168; x=1744605968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=wEMefcuWQNs2YVakRt5J3/EZ9GgZ6B14b3AQj3H10LEL4i0oVqcgAmXd1f5MmD0Irj
         BoaQclFm7P9U6zpiJ2vkRx3tuwRtMwefU3GvXtF2Fd3Iq2+BYEUawUOFGibHb7mqsxZH
         E2wpr5isOqF+vTNfF9ceMjdgbRNI7hf6iEsQ4zEGlPGL5iAWP0ttExZFh2TjqDCTccKr
         A/QMVyGH0KryouSR0yPj28mgtfZwXAtFyYSJr628q2ZUCZNtnTM3jn2hSwRHXV2UHLsX
         ncR6I3PqLGW/xjKdk47+pGWuzv/a37SZQmCqUQFuflVcuaGRpzRQhrvOWs2+AsXpU2C4
         7u9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5y5GJ0FGTiKsnlvaCtUokCor4jb3Iq6A7rXTGm5W+JpJL2BPkImoPmwO0ziIn8LTf69RCm3IPOsPBHHkO@vger.kernel.org, AJvYcCWkBqF9jb5RfvKUxKncZsFJKWH+tSx6esxImvP1N7zX/SMUY5bblX27/juLaQwB3A9mILa3YXtNVq3b@vger.kernel.org, AJvYcCXJJ9LdSjlfkSzJF6gmNxHGyza8TQdgrTC77gCPOR9jbFXvU4szHreVzm3l01TxaFvJw+RKBsWwQUlLTOynWuDMSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9FYlp2aZRc6bKAWaunx2NcOw8/mBOZFwce0sm7CfFqAmUa+x
	HcnCvkPUOZwVy6Fg8vE04VUwaHVBmKYibjOgTNqgoqn/QG+fvmJS
X-Gm-Gg: ASbGncvs+E1pDGHI0VniVW7zUrY2lfGdP7PZsPNUtIRSQ22yJdDUNSrrGnuoiPFafVq
	ghT2UZQQqGQkunuqFKVhnrNRnxNCd7xuGP4FCXHdGDCB0ZQ+GRODPdtWUtDFjP5m/7gavfxwBQd
	1OD9Rg4den7PLMGNV51kug2EMd/PgwuiJtUHAOIc0btJtH0UwbLyT8OSZCQ7e40ad24Jr0+k1QV
	pJZcSqcEcWrhx9dCr5r312Gy8AA9B4US9M0O/r889smLLNnZBzsXYTengGWHOw+oYfykOF4JxcV
	lLtus2CHJThve1D5trxDlWk74tcfR29mchNACw4/7yj2Rdg=
X-Google-Smtp-Source: AGHT+IF1fu350WMzUZDgPUrlnEXOfKAvpN7C/Nc23rVrH915BK/JSrjVQxpreRgv9N+/+mDCPJ/kfQ==
X-Received: by 2002:a17:90b:498b:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-306a4ec9210mr14199578a91.17.1744001167738;
        Sun, 06 Apr 2025 21:46:07 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:46:07 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:10 +0800
Subject: [PATCH v6 01/21] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-1-ae8c2f225c1f@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iF5N0lEK0tQxrovFdNs6/Non4nh/+bWpI/2
 VKz9Lmslc2JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYhQAKCRABygi3psUI
 JMWXD/433zs8eXtVNbS+hSlKXj716ZiiEDJp1ttmVLgn1jlsjKilu6WTd5KwYcf8fTdw40qBb1r
 6me48cGkpO1Mma+WITNcvK4rF6CgPariDwIUFIp44h2BtVNWcD6++OvABYd5C208fV1vVceHNiJ
 LkOjfa8LFRfbgT7hmNwUJe4ckNgLdIoKS3fTRvOf5UYRrJFbgy43MVq7TMHDMK/y5tf38xd19kB
 uFQjsDoLf1JqIUczkQHRXwM4ICSSckRjlRHM0hWTKydW4mTkmnDiiqv8dOMYGtBADVqN3dOiKSa
 /y7NQeYudBCPFkHqVN8wbE7r49ZqdOhWSFA437faxXIRhNbSvKOLUW6xg4Io6M5WUxtXHwNGuz/
 PhQ0VSSWzfYsZaSc/ZSftBBIN3rR4lQCjcA0G0Gs5VcboSIdVn6mlPXwefQnb/LGqGOAGjCSGcF
 It/pYXIg2pxTRdAF6/djgHKjhszQY2eRwNL/TZyOLtLcRRCViqO7pgO5BUr2kzDmO90AQoCgTCd
 FbfJh9uY80jJ7cX+IYomb/uvd+3yRs7Ipozi3Wubbnp4o3R92epjynsmhZxUnOYhHotd+rq276K
 q23TiP33IPovipu7ho0nA0oSdagoxIhlnsVdtBPDkS+XzQkp52H6L0tOqezmzW6LVxvAU8GubYP
 x0wOe9TS7dlMmvw==
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
2.49.0

