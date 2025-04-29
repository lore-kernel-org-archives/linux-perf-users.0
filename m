Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EF270567;
	Tue, 29 Apr 2025 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898223; cv=none; b=QK3T2FxZPwR/QUu1L0ornlUuOGsm6DpLYJ2nMCTgXIqFOkc8h+LL0RaoonCcLCpwNRDrejQr6tNZgfF9b9Dx0cFbbr5qyLoiYa5Dja56j1BkriTtyFxeDWyWhun11L3dlOjfHsdjWQ4AEnKhM83eKi8exTVtBjCeiQXXuQ0Ok4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898223; c=relaxed/simple;
	bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9xVBlf8ydrGLHsCcj4g59LrmZrIYBl36wR30u3MDgzDxjqUM0clwt/J9aOlcIUfG54xcZFTqhcYMLzIXOCsm8jWiKXlargiUObbJxqIibSVqz6K9nhAGb6Hx/fW2HQp//MposNt51q7dFz9xk7KfU1F6S3MVJOS/omKn9pFY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ancu8piM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ancu8piM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3081f72c271so5182943a91.0;
        Mon, 28 Apr 2025 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898221; x=1746503021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=Ancu8piM3oOduov58P+w3T8/ff4PmJft7GYFqQYhZAETQf+sqv3krIGwPgf55iGLu6
         x6eOrxeVdO2xXgK9wrZS2YOZ5grlHAuhmwRAQl+ZAJ/3CVs1rkLFbm9+AIY3qg5NLnvq
         iWtQ2kbLQNGi036S4veb0cbNK8XOxrv4DEvUQx2Bc01jXZoZgItgnmcA+aQwNkpNcrI9
         +AnpZzJ+BJMKtRK+e/tzvzcrpfo95OlV4bxCWeeVydDQPyTx37tk57OdYwwisDXuzMjp
         uuJbBbZTeqE9wivxIOAV6QFLHIuOdWMe1N7Mw7UzcjOLEJwdxGQhzAxTYUd0i3U4F+yN
         Dpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898221; x=1746503021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=p+oTa22XO6JoZUIuznZJVc4UuK/C2Anpxi033SKehLNaT2nQd1lsltYZ9I/qXwH7mY
         vk3mJT7Qx8JCfhM64EtdIminSbtA7XXlRPDXzxxFOX01+gtS2vGj0wjgw1uEpUh7GfgC
         NNVTr/8XhEQ+nPL7YFPmKqwDUWt9/vPzEDaiowysWZb6q/LWhyWLQEdGtVg+lY5XEgbU
         pOwWj2G1haxmlIB7gMYpitrj4D0NbcHDCADmCPUyaZHLP1U+IPC/08xJeoAzbWqbCdTu
         af+BtQYfYA+2x9y0xcEH31AWBf2tXBdhkqBDL5fUuVKU47Phk9Pp4kvZIx2t8TH2TouE
         y5AA==
X-Forwarded-Encrypted: i=1; AJvYcCUG86306ndDgFZxAGlilAfXdY1wJSHTUbzyEmOf6OJK7AwwoIrYoSbMHYcm/ogJXbrqhdWOvbZ317fC@vger.kernel.org, AJvYcCVSxwBB6+9Ky8nIW2v/J0h93MO97whh2dAD7C0ciOMWsQTyTHlW6G0lH4+dAn99GHtuJzNwCzVx9b0v91mNzLOmvg==@vger.kernel.org, AJvYcCWAX4H1EHJK3xWvpuffVjAeeGZBmZLIaXVWXkf9FJTVKeEwupb+qHioEZ9yhtUz6ctUPf3Ntng8XkIIMNR0@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmtpE40jfevI2I63N6xSxP6yuDRMiDcaUhXApvHxPdQoE623R
	z+5R+2jHN0PuIKcpy2G5RPmCTPTJgoy562GoRc39NFJbUD7DzMR7
X-Gm-Gg: ASbGncvpXwle/DxnTvLpO4S0yT4Ik593NmbAQdLFc5BnNQafBr6BqweZDNCsRjbGc0X
	kLD4VKL4inXn85VB5q5kOgsMnRf5eZ6QOdszNDPADQ8z2ZVMnOmT7yJDQRpcj/gs7AMJKTN/F/+
	VXUvXKJzQlPaSWAFdduaZ6NrSCy5HAyS06u1FLmNUjiIRsE1AzMvBBkzWFXIZRARkMgWMNTG7VL
	GDodhEGdMzHUFnu9WPIfcebLKyuGuUMtJrxY/q5/ywnvfh7cDsJ3NpAbCevd2bL0vKNrYLMswhM
	HAIfZoe4C1DF4kieGYUwNc8aBrR0YChmPBRpGUyRaurjbvpvIBT+rv9zUw==
X-Google-Smtp-Source: AGHT+IHxJGmiZrM+UP4fV1uraj7Ls/Dnl+1bFIYjcIjwPE9ECbSPIYWETr8srWkn7rAXa0xGoiF0UQ==
X-Received: by 2002:a17:90b:2dd2:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-30a013bcc03mr14960690a91.29.1745898221389;
        Mon, 28 Apr 2025 20:43:41 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:43:41 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:25 +0800
Subject: [PATCH RESEND v6 01/21] dt-bindings: arm: pmu: Add Apple A7-A11
 SoC CPU PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-1-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErjd3c1yTBwKCGhxeXkedW/lfSOfnH23+dzW
 l2135x2zHGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK4wAKCRABygi3psUI
 JLgGEACdUJeDNRMtqm3nhxyhEQAtsOix+3CT7D/67Vr7UWwXPJP2Oh+1DwSLzbn/zFkT9cugxIm
 GnSmZ4m2NYOn2WoAUS8F7cwsdDNGku8hnOj9A7YESw3yavZ6LVysiB63Iv4cSXfSxG3nB2YAq6K
 AgKxNOrluLF+fR+2zdUEkbhiV6pyZKtNCyQZPhUeRmDQXbEiBXgJ2UKA/N4pZc7c3YMbky2BSej
 +0eDrhVaQKHqmz5s+9Uh//vS8JStXzwFfiWjuD+mNFrdlf8ZKy9dZYvKJccDRO4/JIm6VLxIdtL
 t0CdhX8lL3BLVxOJ104+qC2OlUGI2K0XruyV67ivUtr915c4YfnTxYa1dY6DcpzGGGLQn3RZSxJ
 1rL09HBeggJZWWKpANaz2AHyoLthHE86+KhruR1m3MMu5+EkEgh6+rSXO6dbMnGpPVvLbFqhAQO
 //uuyVAsRC2uHgRUzt8rS0tXfx61BZDj1yK3UF7AjiVBDYZIpsPbhdD8/xO+Dn6Jj5AYISVg1y6
 yUz4EbfU4tjfQGuc40RCBXX91X8TLxf3h+pY7p9qU5NQjuNSX0IS9+JCAQPJgJdQpEkOhHFH7vg
 Kxcqt8aLrBEv1oph/C+FeG1tPYwGHeEkseunNKO83OpZRsuw6iO0sfFheenVmHndUjkp+juqRFG
 kSxUqdmoqhoaJkA==
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

