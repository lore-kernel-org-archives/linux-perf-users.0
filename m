Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917023002DA;
	Mon,  8 Sep 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325711; cv=none; b=oJO9WCCDx9q0BFCoHS8SiGy3T7wwUtNV3f/V2daXUCrC7m9y7Upf9k3HIlW3NPG9Q2JknfNKevh6u/ZL3DNergwXzcStyB8ahqgOmBbh00NDc+8updsNhGBT1oc67LwHwxv5yblJCnQAmvPrE3jgrg17YxwgqBUTTlzXlSUlY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325711; c=relaxed/simple;
	bh=1JKajXUwqRhul1ka4zSxgmuIZmZnF5dN2V8kqpA2Ejs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7ufg8Mm/jVLbokVF7iUenx+8rze8ftAMX17oo9dbeV5gRNHIVsYjxjLWzAXuxO0fnAFk+EdrHgK2fnShbnYzLLN+ueZHh4kliEueBn+LNmjicDvQ4Eb8STJmnP1qOrGedvfwGmW4rpwR/wmD7ZxtwpDOyrXpeMBlghLUA0ZxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRLs+S3R; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRLs+S3R"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24456ce0b96so44011045ad.0;
        Mon, 08 Sep 2025 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325709; x=1757930509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyHd36Q32D6LVFmjxrrSCjpcR8v8mTvafzGLYpLOI3I=;
        b=HRLs+S3RRXbBs4H8rK59vR7LVW0CjpodVV76EnN05yfUMxrY921bq5PK6tZGvbqG4H
         ex6dh6AsuTf0d7YEppuopswFpunOB+2XotSHQDA+oCKpAIRtv+cai2/qvM3qavR3LfS2
         Hz6+ADMXdu+uB7iy8MWrz2Ja2lWVAK3njJZUvvfTxP1wmfVpzcSZ+cRRb15ybSGPQ2dE
         ixTmwNd0jxRgAx9eBUzAR0ETyW328lNweFLH1BaSmlRpk0Zi+RMqA4TIc8modRchwXBL
         3RArMpl41+y5ESvq5psKzrWO3Y/QtXcSdDPbzYKDTOQO1BNqFDl8oEIOMfv2aoLGq4Ty
         MsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325709; x=1757930509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyHd36Q32D6LVFmjxrrSCjpcR8v8mTvafzGLYpLOI3I=;
        b=HM5glxWoKTBPedSn8ot8yyPPE9oRDxnGOIaDLanePtcUmphoH6a7ybBrYAXkdUWcjP
         1Rw4lKEdjTBvAiQ9ts2AclR8ENIrC+wAQzLulCTC+3Y8H1JV/GR+jrQWrLa7sWQVTnFu
         teYtrjjjpnDEKy4kAu5f1nwFB2lBju9QTX15AXzt4AOvS0+Y+k0nhPt6QZ/cvirD9EMG
         4wzyoAYlDn/lwvwCsG359CNLPC8O8HI/cvGgzr5XFp5IfJF94e80ZDdxen2haqlSMtp2
         mSckYXP3bNJdWbmeqXFbs6QimrS05rvjawNnKzNGaiBrwdashlMbFjm7ZEhSBUFSoboi
         pd8A==
X-Forwarded-Encrypted: i=1; AJvYcCV+DUfBt5Vs8o1bQ5a1RvNzF72hzTl9ULqnzkIf8XrDh7QuIEsd+kITE5K81mkS0e2hyxXAhqgTs3YFe7vYY6Sr5w==@vger.kernel.org, AJvYcCWSk/Ml6va85p1vBLa8ucsA3mlxt/J2KfvRToJioeyIeZUyDrelaAJRcJUIPZxtLlZUqxAny0ixDiII@vger.kernel.org, AJvYcCXpm0WV8e+Kz+Kl4ntl4WHrQPGkQI1dAoybf1s8H5jfXAwzWhdROntcfH5UjtvnZM8/pfuKCLuLnhPi8F0l@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZt34cUzdEtT3lZPpoHdUhoIegMusKRLplYeIcvhfJA4EwOid
	x8w4SmC7ZBTCoJSkKF4lh6K22icLTjB0ReZn21Be/FhXxSjwbLS99YW4
X-Gm-Gg: ASbGncsNI75RSEQ+hxC70X5ajunq5xB+HXUed3OCbU4ifE02YSIUqNU6uploYSRrTwY
	iMWO8IX4anyU7mlrS4FNbn1L3lM6Sygi8l8Kj8GbznkfI5aNADhHN1xrzPxd/yEYMVLbR09lYal
	SRQGZLc8HpPPLfcGdOfhrOHT3wq2KBPTqAlinfjf7KWPxVBPQIaOJnAucbNOT3rF3xmNtijUlEm
	z3E4fdB0ln03W2ak08VtpYSvmsX4vtn5+lHIGiZ1kcwBxOR1h7YDjNu4B0WX0uro/0VAZK3nozR
	KFklmKjfvh/Y/tNmm9uk1jF663aKpi1GsGoaulbXgxCOUeU3cJzM2jnz9eAw7QVXBRcrqZG+q6l
	Fw18z9lfBFmorHnxY6CRl1fX5Mvr4AjJp3Wqqew==
X-Google-Smtp-Source: AGHT+IHVU3ALye4sph0Wu+Tnv2WEHOcB5qvS7mM3i56TPwTLcEJRcMe6hHtK6mhihmKypJeKyqYQrw==
X-Received: by 2002:a17:902:ce89:b0:24c:af27:b71 with SMTP id d9443c01a7336-24cef93a60bmr134956285ad.20.1757325708812;
        Mon, 08 Sep 2025 03:01:48 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:48 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:38 +0800
Subject: [PATCH RESEND v8 14/21] arm64: dts: apple: t7000: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-14-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=1JKajXUwqRhul1ka4zSxgmuIZmZnF5dN2V8kqpA2Ejs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlEwbV0Ai/6KcBnAAiK7K8h/Hekwrf8ii3JD
 vUIXaW0sDKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRAAKCRABygi3psUI
 JOnOEAC19Bj2cTcDw/YbvyrR2Y1VbvNwSkj4qxaAx7xK/5DBRHYeRBprDK+1I0jZhVFQEVAcQp3
 /ASswENjcVv/tgFKU/1PM6aQQafuVRTDRKa3Rbtips1arm3MA+hlj7pmVMkbN+THB2vxPnJtun5
 mQtGm2BEqf+TLJvbm+G/n0jkfTbCsrAu1/N1QXNt1stLCkCPZ0WlUQcLGkPGdhYJQlccxH5CWuo
 YLQohlunR/Lb0fKzwYVWSRHqPqKJWsSjchP3wUg2uHLnrKuLQMQOkJqOBCWnCVzmJYOpdNIw5sx
 gLl/Ja54mmF1N3cWrRkqeyWD8tjY145npqfbvHPpeWzcQpTh9dzWMFcsBcyAr1VSd8jGl9nHntV
 KAbvPrvqeJUOZAp9XU7cih0V5uq17aqZ77tdnFpm/bxgbNCkdIbqa1z5phh/YgJtB4eDhiZgMxE
 suBo2jWn7tKLb+h7bQxAkcTCQ4gKtDj86TwCNDr6ANv87FtVUdLXFQmaf5VxLWQ0grbwxDNRQkC
 KIxxWW/Gc/sm3jJc+d4fuZ9gQbBw82htBQhIObSGCPj7jSwQ8k2nwMORywqrLOQ4fW4CeQd+UqL
 Sw5XyebirPlIIK9P8nr+nPZxMqf8Gqi3zHxbhko6sZ+XiQsIDkpUOSv1QGT/Fa39tjcnsRqJBOL
 /4nn0Jfb64M6Zng==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 52edc8d776a936ca5ba58537d4d68e153023f536..98c41473a84098bd70df86c2728a8080b05b41f4 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -206,6 +206,14 @@ timer {
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
2.51.0

