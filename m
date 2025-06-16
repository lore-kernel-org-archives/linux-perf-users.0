Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E828541B;
	Mon, 16 Jun 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037593; cv=none; b=LtJIU6T0D3iviUHYSDuIcSQU55Z8P5rg2kQ4Epb027j03WakPRV1DlZ4TYnj+v29Igqujmhs6rnD0KxbkU1h5bHvbJ2VTVYJ9lnXtVWYAcUQbraWXRZgoHrdfC11cDyZHIIGQoeaSh6jwNPR2sjaUikaLKWvq+ApM+ogSkTrLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037593; c=relaxed/simple;
	bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8uf3k5zE57hI8wRsmYKeFjITf6VuhuBXHyxhT8TVhJ32zdMeU9abuRCvjXjqXo7AZrRXw+rxNzZTUSxRxpv05z7L/JkeArD+gYYpPgKaEjxSOeCqwgfOwOJcCJOPS3/5GDpUiKFpVmKzKJW9AaB8gpUp5SuAWdr6fdnArpuyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UszBVuhm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UszBVuhm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23649faf69fso36937735ad.0;
        Sun, 15 Jun 2025 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037590; x=1750642390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=UszBVuhmv7+gBI2y7I3ss3oYSQJb5EbzFvuT8tdlGWppXxsylRRj762k2nqCUnZJvc
         AyisnWYlmrX6O03L4arzEW//d0rLAUPw10YSdKIrajCkP2JzCqUzBJhVd4v7VbaX2lkl
         NH6jqzf1yuwfF5lAmoCyRsM73m9KwW1GUSPnnV+2A21d+FrEIp4IbDMPZ1eaN3r6h+sF
         zLEAierro+hMylY6hW5//1u2XuVklI/8Vguf+lenHWUHlfbsrozSiQjE9A+RJsqQ+WEH
         ODJoAbn0qnZ822kDSrzLEFEmmWh8ioFBnyNoqlDrZ6Sde3NyFOHqkwAtvUnPBjnZtBNL
         cE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037590; x=1750642390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=pfb0FliE4JmHeNTxMYvCIrtUc23TS0nBOApQ9GvbgNWVCkMJJ2RfA/nf2hRxTL8eTW
         WY2aB44dzVT5EDU4JPhKoS3h8QenNqICzJQ1tvqg9upAWQgNw/jwhqWafcL/PQLRYS5O
         z2bel4MUQ8hb7nVu2mcujapllRpVwtwCM55voanOmW1oTWAgoStCQELFPwhfPXYrU+PD
         5Y0t7HdZazVqx+ZcdSm1sOUnn1C4c8zPGQTnMCPd5fAlKzU5HU6b3/IKsoHI47zOGK4U
         5lqlyDFYYRwRTJV5VvEbA8tfP64i7e0Sy908XXAJyxXk/e7qSwYfpE5DTtUCa0tf5L3U
         B/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEbqGWDVHiVf6lrdFxeZB5QBTDacF3FJ6Jw5vITpTybzBfGoqGUrzxClKnziI9wtSHHRxeaAcNl/uT@vger.kernel.org, AJvYcCUjzJwV3lTaF6sbFijAYdNnnZOEThpvgTofGWSzbS54AsgGTnwSZCcOCEnJNzAPqEq9mUAN3KXmQClm1JVi@vger.kernel.org, AJvYcCXiG/9lDI9btCf175S0Sf69XnJXNI5jyE+/bK0quZ3NJZHEQgxQSMHWGy1OTG4AKqeCgFYjW+uuRJkaoWvkdJdwfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxDpdSyK1v8hxqFkPtX8fZuzM5nmKyeWiXimegwe/oCz9eHSz
	dFIUQ7fmtUicrCb/KmRlYUwM8bPJQ15tUzdW35qgH2NZzoQ9WJYDbsJLJ+cCQw==
X-Gm-Gg: ASbGncsVyjl6u7nlroJ+4AOQkSNEPKWCFCHkfQymyn5Gndupes6Zx529jo2mtiJh2QT
	f8h8EfA6d/TDCjvWRfkWe2bIVPMMvhoE0ZkAvsCoLqb1TxdFiunwT1ExK7Tik8o4q0fF2ifK9Xd
	k5NGIp0SDyQbuMFzMCQ6z6VKGqz6bUTPJl+lhvnpfSFaD+iAN41UZtlV7SF+3UDgtW6e5r0EXEc
	+F9USb819jQgygujNKtP3R9/oePuD5z/Ea0RmK4aNANeZfmcb4xW8PAGt99CrzThQDAlfrtdfqS
	nGnAbNz0mRGjsPrIGshkJggEbu1k4V39Nwxg5z9OlJM9N783lwqLnFwyWpq29RZQVaRc9s6LK12
	nZ92DHxT/18pOKw==
X-Google-Smtp-Source: AGHT+IE3CoHqmpfLy1DzF8kDoAHeOUuTULE+bjRl7YCy9LgCR6uXCb2k/LnCPpIUZv7XDGB11/5vmw==
X-Received: by 2002:a17:902:ccc2:b0:235:eb71:a37b with SMTP id d9443c01a7336-2366b17c413mr110186025ad.46.1750037590096;
        Sun, 15 Jun 2025 18:33:10 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:09 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:06 +0800
Subject: [PATCH RESEND v7 17/21] arm64: dts: apple: s8001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-17-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QZQhUOZouPvn3IHsPwwoR4uGTf/Nhz2lJMe
 hJ2wzVTKkKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GQAKCRABygi3psUI
 JIdMEAC3ItExFqP6qy4Q2p90/jpYVFMlGe8vDrr7GdPt6sPfMPUziMg+wWWX+44QTRWBUdKLbrq
 SyNFEuUG2P/Ll5Au4+7I/kArzdCAx65VfuN6Pkm2yxndRGLtnxpQT4yBPoaTfzv0OIGIXj4f5Ab
 JcAAeb5+N1yMPskCCid+MjxAAUDVAkXAbA+yg1DmdqSHrcgafPoRjJMqn0Kc3ozCePU/lIG0w3Z
 MxqIQprBMRxoupCzexUTRypr81q1MyTKF5LuwgdvYPHTanABq1kWujlGu/34Ik4U1S5rg+y9cOe
 YH2GHSOkAQ5ZJRDfmBtbudkgl/Vw2iuKUhi8xPeAzUQQxGAal3pJFfPa4QAxPp1yZfX109KfO/Q
 Nfzv0pFTl3ATI80a1MmoXX/6eCAXCNBJH4fI3f2XQBLH9SYKw3LK9nePx8mBzIo+SOURZHVUtZN
 7oBQL7qZCS0dGEftVMDWjcm1GhA34O7ELjktmBbI7dkwyA3TfyL0KL1E6UhquqotEuh5xvYRePX
 8bmW7nPsYlg6NhKJuydIOAHMHiApGsN0UVVgLXPwbih9561APtM+blVDQDWUE8Fcf8gkT6v4sMn
 vLtoQ3DSxRsNgMau1tpASWTTHkS4HmEKvJ8CpSthb0Vx8oljvCpTrKadzHD2bSPQIr0xHerThJm
 LuwvvRayA9EYP3A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index d56d49c048bbf55e5f2edf40f6fd1fcff6342a9f..33760c60a9189df5491256f81db7f413cada27a7 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -209,6 +209,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s8001-pmgr.dtsi"

-- 
2.49.0

