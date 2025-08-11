Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C62E2666;
	Mon, 11 Aug 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920616; cv=none; b=g54qHOdlJlTxqN+sFv/B/HgCXzk1NcRD4Hr4LjRo5MkOHRNRDhdcY62r8QZj4sb0RRLpKHsqzrnOFQmj8ezct+ddGOu1NcO1A8ZLMz8iXyUdxrP+xLPEUzWTFwgQ8ZLRauDo9yuNiZu+Yg16rd90pZa5ayBlctKeUI70Ltniwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920616; c=relaxed/simple;
	bh=eTbqxhjvOODiLhj/5157aFqKwPGN5aKmzyQKBhjppd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsNE/YjMDQldnYYjcGJFTCcvloJmJ0n8IJHspen1E43jI6vT+GVLWJC7X9ZpbBPuqzApx3lTrHfGyaq3kcU1QoSV85wiqWxUxT8n7wao2jy1qYEDOKhnoKTjXO6KGzB+Yb4bCPbAHPC+eCHg6s87Q9eWRk36VD0IA7E1MJ37Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx1mye1J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx1mye1J"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2401248e4aaso50663695ad.0;
        Mon, 11 Aug 2025 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920615; x=1755525415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+iSjFHeRJ5eiDxIcF1+Ur75NA+5IvcpuSZnDo7kguQ=;
        b=dx1mye1Jc+jTNFtDF5759JxB39NiC6VQaVPprJa1DBL2sZ/8ig4rCUSog4XI9dS33e
         MfbVzg7YZZ2rFoTKfdxXl58pVfFYaqu3hbaKFHIAqhyNgymle/l4TX9iyC/YxzYlJxF2
         /FNnW4uXqBrdt7VWdUlV0H+lDh0ZmXvOoUqvietvfD+dgHwiMtW9Og0vfCEeNJqXivh8
         pCdRkCK+UN4K8dvWK/o7gvw3cwNRjl75uwZx0LUEnJ9Iv1i9BtECuiYvQwaYG51vlZwS
         GjeWKzj7M1HmcCKrIZ3iOLOM507kq7BKVsMj1GRMei6kPVH6AD1sOuPgkX/Rx+1zOqGn
         R/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920615; x=1755525415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+iSjFHeRJ5eiDxIcF1+Ur75NA+5IvcpuSZnDo7kguQ=;
        b=uZHXQnO9mFmBl5FOkXibq027ZFVweUfv1plsby1qag0C0D5tJkyh/SwgmoKnX9xu3b
         zM/6YmOogul/GFco8Kfwwv5jnCltNheXmaLC63z0A9o6Fg83X8JGTMgKcd/zY3Bz6h5Z
         hby7GY6HeKt3qSle+bBn/0eUznGMt3nyggtnenY2MC6uBLnLJv80vGvkd8B37/zhWHEo
         8WOqpFqUAURtypUQhevkM8dkcuVTzBHm09jroS9s4Ss7uWxQTHHgi1kLjQu7/NIxk9Zs
         inhEV8hQ00YhTSfJhWb/COrpj4WTxaB+OEixkBS075CPw30fwOEGF4tciYfQuWHfEF6E
         3elA==
X-Forwarded-Encrypted: i=1; AJvYcCU6b9cxXJZb841FHBjLlEqb29iWEnxOEkIY+78/cVsC5oS/+UwKcjZj+fVwWt0Rl3CcU3lMpqrtxBHN@vger.kernel.org, AJvYcCVemZAji1ApFj4RklJfluYWfzZdQym4jNNySJ/j3zhS4FEHzWCnKd7onJuH0rWYmSfikeglbfQgtWXS7HeBgqlBnw==@vger.kernel.org, AJvYcCWDBONNs+VRntV2Nc5QqpL7L6b70sf+mOiiRQntjTNt1eLHqN1PDTRfGlfbdUm/pVr5xY/SY2yyey7AYIoS@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlrhkiVHwSEgvhFYCcsCcPQlKmW+gWtpB6Y7pY4UsAvGgkK9f
	TJRwBi44rJ+T3kTBp+Gh+QS91krXMVt4ymyo/6geRYanRAZHkR9QI+1I
X-Gm-Gg: ASbGncvr7ZwPvmSI+807eZBKcMhpLjYPDhIstUayRNDFauY0PZQ7g+c0CeKOliN/WOu
	Tt4ANt/49A4Jfjxbb+4Dx0io4QnbbOeTxR3UzVPsdgPnRq2OX3UJotI3fqgutFhYKTAf9ut9+mg
	WKPT+ieppnjAdg4z0Da7pxblDLmxj932dgxN6F+CUUyeSNFQmQ0+JXA8H9HtbTLAszR9TpI/U68
	crcGR5xQRFj7n9t2xewJKV3sWDJCkPxmhzSfNIX/prr1sYQYZeCL1WP0qfG0WMdxT5XseO3jQQZ
	qwtA+BfGcGdtzHXb6XhihWRgGA8UQI820ECjxD1+OC0Z+F4vElVownoEdN6E9Bjt6srbwqUAgYN
	o+uiRYWTws78sIGlWZpEoWGunJ2bjWhEA9oFG4UeR0RVTBlc=
X-Google-Smtp-Source: AGHT+IGAEKa4dcvVOWglncYu5qHSdxVoMhR4DaF/6EMtEufkq5ee1uvDM5bHuBpczqPXUeWRNZ73yA==
X-Received: by 2002:a17:902:da8b:b0:242:8a7:6a6c with SMTP id d9443c01a7336-242c2008342mr219863425ad.17.1754920614853;
        Mon, 11 Aug 2025 06:56:54 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:52 +0800
Subject: [PATCH v8 20/21] arm64: dts: apple: t8012: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-20-c560ebd9ca46@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=eTbqxhjvOODiLhj/5157aFqKwPGN5aKmzyQKBhjppd0=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZDTxdZBWMtJk+fLj4SOBpL+aisv9fok/sfs
 4ifj9wkreGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QwAKCRABygi3psUI
 JAsIEACtst6o/4ptTPiwslKdB7Wtd+dm97D03aR+XgqDPmw2bzdXBOOhfx88znmpdLchjjeybkt
 hlPwh/kmHjJCTtMyD1mIZViQ7whhClMBmMYD/+bRjYzNrUH269xN6I4HQU3l4XQ4PpsTR6FMu5I
 AFltvdjs40iG/FKHyZh2xnChCEpb75Y+tJJ+ns9xL0MzL62NTIprA8Zf59LhrHYLcryOJd0tI9e
 sL+4DVQIrP7N4aD7XyHGR6CMvsM5YtgSCGh2G+ZMTeU2KbGzr7+FJuxUa2pvNLadFvYoKGuQgVa
 QSFlkvdYQwYpnEj9Ah81+HbUbVhxcTkfk3+pSvU51v5ThhNm/xnn5153x82jiiqS4KXucgPuxMV
 l5hPGcB0w8j77SWkp2bGPoY9rS57/2JXJ/yvEb5MYhj3bTzVRU79j+bnF1E6TDNk+4xVtAMSTyT
 EKS0o+XQpi76zFf1+oKYxUKC+I8yHjmwj8efB998A58eR5mnOtm+EEK7dWCNZOTeQUsiEDx3NbG
 egtTvL+wHupMMHLrZ3a7+tn0IG/Qo3+WdeXPnW2X0z+9JyrsyB04JwwTAJyaEHxrQiup0ziM2kV
 u5VNmCdaQ54UAIG3byHcoaec9eLFIEB0sl+5GgAftNYd8X7xg5DBd5MYrKDgJMijKkhTbvcZDpj
 9ZuVedWcZJ0+Iqg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index a259e5735d938cfa5b29cee6c754c7a3c0aaae08..fc87ab818d975974dd811cedde27292ec79f2c8b 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -289,6 +289,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8012-pmgr.dtsi"

-- 
2.50.1

