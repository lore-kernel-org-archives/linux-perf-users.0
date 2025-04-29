Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2E270550;
	Tue, 29 Apr 2025 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898274; cv=none; b=XrXvDXj8t714pu606Gr+2fkCr7OTgQqs7sn7Q5qCKVZIU+H2yIqs1EHd4lvOcXbzmRrszRw0gbfQWqcMfao283vfzWn48WbhTnN1xYXPuUIud6R1eFEOSLHx2WigJ0651TSOaLIpbUaPJtFHm+P0X7YvB//+mQgBGsorvGaK4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898274; c=relaxed/simple;
	bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRHg381HfQEtCG7OHfRnfcSAlOJ7GThDCYCy2qbSb1fkE4WhA0IeXz/bjiPhwTE+IUUz+NdeTwNr6sPPWVCpeqISl8lXbvEp7/bS2oOXMwldSb5GnFf867o2m5Fc+IUcFRCRMnm3OE15d9Qf32te6SxWE2lp4BKvKEia6O5QYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anR/F7ly; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anR/F7ly"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240b4de12bso82445875ad.2;
        Mon, 28 Apr 2025 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898272; x=1746503072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=anR/F7lynR7JHGT5UTDSAWPRm/CsWUeBzXIAmjw8xVQxecgbXxsHfcLQXoYEtIwmuh
         HSfEh0cfRII01N0mMTb8+Ljm2lMiMh5uPkatI3P1NFcFlw2lpjVvcdwvnkREfQGVepJ2
         /TONZ55cyLfEZ/0G+Dm/VE2yDxaX3j8sA+zZkzb4IGxxmBvfzk0Ph7XW1ouTdMdQc5Aa
         7wmO1scOsicrQJMzfPGJ1muTsehSzm92ua9RRIpjUEGVs0EKk+bwYNzUbls7L3fo/hnG
         TsCvLF5vGeMVT6k4MkA1StV2FUXtbR7peU5DSBwXa2FFSc4nuUJCFONoRZlSzH8PT4s4
         nJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898272; x=1746503072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QbHFcfneBNmb+XSCJr8gKBnaCoOSbgUaXguXGZhZ7I=;
        b=BLS22Ev8YPBYh0lXRig4UPRmKhkgwgAmwUyD3hy3YIq9V04nHaQsQwcvISQoSo4eLl
         IKe0v4fRAsunShwnLwHG8SQYPbf2ErGdCCYm3/ucqqLiviYSzhP6G5Bc5yqk19kHr14M
         aZKn41s7urJP2PaiSElQWi/VuLsJGDjPpbfgoORwk83LC6qJc186a91Kk9oIXDEyNvW3
         CfR/cX+VvwHRXZm0ZhtdeoHLBLGIZWIsVxtLtP2P/o3Nk6VzoBXL0p+yne6pTfKsbgvp
         6p/0IlY2mHdxPC4OEP02i2dkTGbRrJsAzKnjz17huo16vQe/5hSmbLkPSoa30i9iXdEK
         +o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+a5ZlI6LOnNB6aWgYkkU9vsD923QjHkTy0NlY0+8KKvCRvWeUN5+KE337vq7pJxlPxSiw0bNGj2lws51IH1gpqw==@vger.kernel.org, AJvYcCURcoofYgvmD1GM4iLwlot3z2swU+8ElsAbWYWDSz4ORpJzy3VGOQ50y/VIjfkOo8n6LsGIlSEumrPc@vger.kernel.org, AJvYcCXjoi58JisPmlqVNIFn5/j270HcL/C9Cb3NOs3jzxB0FurHFdBe4UB3Xaws44dmCFQwDfIrK48/MiK2SXAP@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXCW3m5paUdHCzbKU1wX8jiRVJvlnOFFHr4zXlMUOxXs3ebzo
	wur0Cw3zbQJfl1/zhOAbCoOe3Udxl9Y/DFyAavSaEFXUpT5VoI+T
X-Gm-Gg: ASbGncuNDkFGVLT6txsugpTVUoBlNdCiOiPMLnoPwX5pf9JydZJuAGjwOttk1o0Xr+y
	PNADbeI/Ma6CKC4e/7VyQTFuB6FvottWi85XVVMUdQn1+zM8bJD2NIStrOayLJ56WJg8p2Eu/VO
	ue25W5Ygr8bP6YtD752SWp+GapWA5Lg/YSRhw6gbj0bfASni6Qp+HsqCX2YhpOCveJxbvKOuMcr
	4ivcfOA6wCHz+PwXGCvP0wbPvu3UIjKUqiRDI8xSrY7OdNQFxS65rEfHohJhX3Scdv56eh7oAiI
	64kcsaqdH6pqpedfiMJt8mlKgNERhdeT984Vx6lQRVakRnk/wtYzS9D5gw==
X-Google-Smtp-Source: AGHT+IGccqGZ3Xia9Ch8eVE4eB5PhOyKHbvEUCPfUez9ylO+fo9l2C2+BFOaam1hQjLiZd/TEJp4xw==
X-Received: by 2002:a17:902:ec8e:b0:224:1001:677c with SMTP id d9443c01a7336-22dc69f8997mr153751925ad.9.1745898271905;
        Mon, 28 Apr 2025 20:44:31 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:31 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:40 +0800
Subject: [PATCH RESEND v6 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-16-ed21815f0c3f@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=duxT7MNXJw4vPLeIH5239k3CmgZWAQGQK2kW07pl76w=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErl5A1ECOtTNng0tLnKXDnvyb07KxJIcMC+5
 SNjbIZmLoGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5QAKCRABygi3psUI
 JHMXD/wJ6027IA1eE+iO9JomMzvUWoHwbUr0+PEnx4lRmEjmaW1Cy/p3GmMkYOUOt3Gcwwu644A
 iNFNEx5jt1OcJmtvU2r6dYE1oLH6JNXzNhVYQ/SJ1KMOakb9dQVKLWxIr/Syd1CuC73eekq6BRp
 VpfU5lr5PHujOxFpXOWHzW8jFShJ47f8Kg9ciBdXAJpI9wSpPDYHkpJwLn8W3TxL91+PKm0x+8p
 vx2C9ZstLrvj6vVpCvxgyCmReBs8Ka6OPrdjSWGiUqb9PJUUWcBKImifiIHMeCqJ3tOIj86nIna
 z26bosC1lp3M1qNqPWMlalzRh3AmVmukfJc0q9DEo5jClErJtsgAgqDn8oEB66/bFGh3XZLf13W
 XaI45hBeIziEk0fxxNCJ1zbNekMrbaM/FLxZx3IxEg1W1MKq26Ff6CwQZ5DXxz3Bghj4x+eCeaZ
 RYTzDjq2Xg4jJ1bTDu1gy4dBfBENStVrKQ9vkA3S3QxhcE3hg07lIz6l7HYyLweU0586d6h9btO
 kRNHxM+bxtOB6uDX6fUEppO2faEgybt87tVfjbOVB1Ioou5Ai707ssBB9+VFQLWFDI1sXzT3GUh
 487zF6FZlcwJPioCb+vP/Ahj9r3VnIewLB0VEgRzvIBrUeDyJKQum4/tIiML9A46Fo2rUEiKzxu
 g1NClcHh8mdaObw==
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

