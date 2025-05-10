Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274725C711;
	Sat, 10 May 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889954; cv=none; b=Zer7/5LT6/uMq/V0+0Qa/a56JjbbFDEvGUZs+0UuzGCeWg319KmW2CJZeP1omttvNlDEUpEsm81XWwpgJtawA+lwD9psT/yKOKJNuoa4ezBj8FrR6gHFIg0SzLkR7HjJew6JDp/vcPmbzEzoaCjexSA4yEJwpSp44gz18w/tc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889954; c=relaxed/simple;
	bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6RbphIkEm7TRaXTVJZ8ezItQQFPgoHq+RqLVU/YUjdP3fTUTirtqEKi99qUqNhGYVlVrNZoe1vVZOPhR8h62YtZFkNcGyovHE9zWYbN0Xg+XHroKRKujZpJrLcRptpsJQcKmE+pIUtlk9IV5+09RJ8bbQCVkB36qq/wub0uxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2WaYfqO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2WaYfqO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-741b3e37a1eso2399301b3a.1;
        Sat, 10 May 2025 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889952; x=1747494752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=h2WaYfqOFahqiqnNt2fjD8d994mYQS9Gkf8ZBky6Ft4FNqt832N34pwJiUoU/cKuyj
         F8Fa7dVAjW2t+zM8j1RA2vW9Jx9qqm2XYE2CywpxIU3WXxNJkAJlEy+M+s2MIZuk6BP+
         60Cz86Cau3tQ+kdcN7KVRb/b1IJ1wuCzW3YnTizmcXJ5OaUZhlI+Ivrw3dsJLyrH9yeJ
         vM7KRyGg4nqJFge9M89NUJ+oPRPGEKnSxrZpf+51Qx/5BW2Xx4zce7tKKnWcjS8Xp7cB
         JvjKCJ9FKn5JAomtpxNoEQSyDX8jHdY71dyJ7WQ1nfEgZ2pDKXFt5H8YK6te6rf+uRlx
         Cm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889952; x=1747494752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCporfr4EIL+gH/R4FLi79/b+qKEezH7ywKQB3RTf4A=;
        b=hMt74LW52FHo6ECn/FluT3WB5EE/DR5kisyVSQxuMRi3rxu7lZVODqjioqf/yQxRW5
         pyGwFSRLiXPqgrnvr6M15TIiOmiMCV6b43/5q9Gj8H3uPj1jxcIypGSa9V+RpciVBNeh
         vBXVJ/MNevOUxDQ6IS4pbjDIDx1Lirn4gvsZ4jwbIXwG4APdz8VwQTvIMhPequIOaPc7
         LKHdn24XmCV/5NUsdL/Ho9xco8BU/K1Y1C6S5KGnmlmIWTseHwwolSbysEF1QLxjI90b
         FHl1/z0oZNNtBIpD73T+Ah/MLPcoghEnK9g38DYtQnsJM4GekXz5lmvFvxNUD66vnLWb
         OZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUlQkeh3lc93J/09s2QlPyImOaS4X9VtM9LKMy20U2cSh+150XoBe35pVr8WSTm1PADbeQA+d7o1Md7nhZa@vger.kernel.org, AJvYcCXg5At1ROcBoybpuXZS2UR+BfuozgjVpoTisxzVMgV75O6HgACxZ+3DuZvY/JKTIf+E9RDGkTLqNo3GsonCmG8ijg==@vger.kernel.org, AJvYcCXmPixizfiw7ZI/HLL0/ZJQCOJ9vdlQbSGcdHs26s8aZ4k7DrYItn/t6RSbA9x5H1g6MBkYj8j3JQ0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/uPrDoG38D7JFM8XM5jxYgR2nopTt/Vnl+GcuZcs1dq7ArSm
	UTG3xWZF9OP1WCpE+g6cf8aG0rXonanEXZveqniA1JbtO88ihObABdAgiA==
X-Gm-Gg: ASbGncspq1kVDlwFY5mPgdy2MSBCCnFcBcnB+plR3LSxTCSqMsjFB2PR/0VBSsY5Cb0
	kvd4GZG7/uWWIh/oGP7W0wVE78Dkq/LCIVWXPtsg2PCotxTYPlqy5gENYNEIJn3rGlBRDd+oPBR
	px1NWieAvyq+Goljh6GSapp1l9WKJ8hTwHdfbADrV2+Z1Cteg7dzXSM4gUQnKf1mEmJDN52kgbe
	KN4PrpmSX+bB0GtLMTeqj6Q0pV7YpRGpBSB7VOzkgckY8vLjRWydofBOiRAw3CkpAljshdKSWJF
	orsylrZdaZor7b9G7CoclztFHgV612JaFeB/OJsm6GEiJL4pZCL4Qw==
X-Google-Smtp-Source: AGHT+IEMFhh+q+cJHPupM8+Z7cVVNi9EWGiLspkGttGc0HUI16zP77d/SoHDXw1/U1p5cJlCY2G+4A==
X-Received: by 2002:a05:6a20:9f43:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-215abd22329mr10897841637.31.1746889952306;
        Sat, 10 May 2025 08:12:32 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:31 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:11:00 +0800
Subject: [PATCH v7 19/21] arm64: dts: apple: t8011: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-19-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZNIQgw4HnW0u/JgkpB+HMZ3DOfGGfZVMtPocokF3spo=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGgfbJyjeBZn2zZv9hz7wHCcGAs9PvoObq3TMDO8MNjzkgG2+
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJoH2ycAAoJEAHKCLemxQgkszAQAJF3
 v5zffv7gXhNtsc6WJ8tUdwVX3TGkTdLQDgyh8tX3ZN7c1t2OBUMFu0Q8CsuaQA8KbRRGWk3rH/+
 pEU7U4qPvi3Mpe51F6c4RUqrFK74mknjMGH0PA9pHXi845AzNa557Q+E9mrIR5Bxe0At32R/o5H
 cEXGq6n8yUS3VV+S24Aqovu488Qe+M9IrjbyqG2B4X5dOvwbUpfHE39mQdv8NSnKmL8AF58N/gf
 vChkPFsFsmAL70gYkcmdrNFPiUhmXyVVyQtcx1aA/FaPo1FwNDG4mX1LAc+okj0adNG/gHH8ITH
 RRGZPIkl9nqHq4Bvda7bT0omcDiaZlOvjWb14bKbQEcHrc4CfMuqHs6FaEhRRcPbGBrLN0P9HVi
 uScyYRlK/emBxSg5UhQLxSqqoW5CH3eC/SLDLvdutTLBWaseyUczdqbm3KwCCG3o6+EbvbxzMbj
 /OSpSYrGNW/0w/GFWSUeZYSw7rEXQ/mgFVKDUvyYr/v1IZVjI5nWkNpEbqu8Bd1ZvThNatdmQgK
 TqYBy5ywI0/hk76w3cMUmxJ6Ow4DqrCqdYr8z32uapfeZ/o2eXidBPP0OGWLk9nb8NUaDsNUypu
 HoPKdfQoPYa6Lv9J6rkdo7wzUtDu0/ylWoxTZdpk58zxmgWn31G6kxNmqNjN7T/zMgL9MTXHD/H
 ohKGe
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodse for Apple A10X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 5b280c896b760dc8b759bf38dae79060e34dfc19..7fb3ab738f67583d9a19a542bf36ab2806268d55 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -237,6 +237,15 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1 &cpu2>;
+	};
 };
 
 #include "t8011-pmgr.dtsi"

-- 
2.49.0

