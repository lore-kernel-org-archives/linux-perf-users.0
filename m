Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BFE350D57
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988739; cv=none; b=jWNqcg3LP19sPBYnwzjI44eoaObsghAL6jSJc2ZnkrOCbw7ETJbDjn5N0RdEP7FA3MMGDoz/l7NQz8r47Sgm6gs8jLw/SubK843rk25rL0bIpEx12JkytjbvryeUNo07RAI4VXU1zDsk6+ImzsVOaK/TZiZKloJIiOVhPO5/9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988739; c=relaxed/simple;
	bh=+Y0a0WIcF+OvRh+wENdR2K0SnXmQmB8D5lWAyKi2wlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tlr5nT2tkK2bWvkPsL1X4E3jJvtHzbMZnMwEiKG0MLgHHdFiXHYIEI6+W96w35ghagoekKFJSZt4lq64QPANX2RCfeipDme1ojJ/Z6zUlKmAic/NuZTCDmqgZKyK/PT3oiohrrAtSBcXBhKyW0/yMhyjQ20rRFu/mbu6hrZ7ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISMG2lk7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISMG2lk7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1360e1392so20303695ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988737; x=1766593537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ2g7x+wr2VIeqIG6aJACDKejjD/eomNYXl10MONUeA=;
        b=ISMG2lk7idbPYbmN2jAsii5dl+YFu5p1sYKqDDxjOJ5ZXOU01Cfm62VdFpmiVLiKYH
         WnPuubB+Cun0ruvknY9eU88DvJG3mIgUzC3Gb8cbmLVrm69ySQRtGL98L7Dnjqd5n4sm
         pcZLaiODckgPmatlitjYbGmuocBl/jQ9Gu096KKZBjZFm/5dOLCPUmd6Ag4uWxi9xyGH
         f6r7K/vBn2/pMj5arHagY867PkQT2iodqjjIHLrnpqI1kFpk+PMgKx/JO8F0EzRrKkQy
         iyJ8HWTWA9yN/3niX+hwq4CzUj/kTSBQpv1QFhXu5Y8s4KblwZzz2YvVU2ZWQKMVApQo
         TL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988737; x=1766593537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JJ2g7x+wr2VIeqIG6aJACDKejjD/eomNYXl10MONUeA=;
        b=ITfM9mYILDJSekGFZi3FxyNVxyPnzJ0e2hsNkn2zzbUR9DQnmLm6u744ANCSke7g6X
         UdsnGw3TE/jj0q+95u2GxTkPJzVZEAdJ1F88jhvFFUcKzriQCvBpaKx+csnR670sW4a5
         fQSqHBhxNYmSN7MP1AyjtraoLPsw8uBETNiJf1tvcFgzlCniTCUdD5mvvUTS1Xxy0QV0
         jKW8/djm/UaMCS9HUE/Ge2OQx01K+NPu4isVDCJX8OtSlnO89Vu3U60MRR1/GNYxllH+
         slwfpqnwQ74oksrR9mF/MH5Dq48qaQEu9neEJeLweb0xjJO3JeDeVQRrlrbisbUacvEQ
         naoA==
X-Forwarded-Encrypted: i=1; AJvYcCVLBxOrpb5mkIECoPruj/0EUtNGrkRllJGkpuYhkUh7/nUwkuMLiVNcU6heTndZ+jc/bfD0l9pGkQPuE0X0NyHR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdljl/IsHXtL0nREZIOggTQ46TnGMOmTP4XXFAGIA7XlS/I0Le
	8tldHy+ICrUUEU5WiChYvgO+V3Q3MEwBQh5BJavfFdpCtAQRsjSN8aiO
X-Gm-Gg: AY/fxX5XuntSsCe8cfhTeEnnAT7RlLqlPj+9W0X66WFbC/fTeQvogwHolSWtGW7rOd1
	+mzrQuyBRoNdRuDdD2HBSlKKC5IXVALeqLAhbQ4FdSEGHYGVg5VtufC7/wYH7wJPovaWvHs0E0p
	X2UW6Mg5PpIpVBuz8vVrSbz73fwnINHgpwhKe99taKg49p18HpH+++PtJ4YBjgz/Yo2Dt0Ycqcl
	13Z6SmCWUlYvPzl+yEIpG6+SGxVFf3H0e2ICV0aV9v+fvkMI3nIKS25iXpDovCbrv5qOzhletZA
	+HMko6000KrjVZWS7j/NalJiTsIk89VnnX5QiNxyyxoeRkw+0He17AH78SHIVYGuCM+kCeVA8Js
	s2+EmavrpNPqO413wuR0GhDvb4zBlfMadvEfxVU+g7vD21MnbOlMMhLmoXzkvCeF4Dt6Ub8xLCW
	gjEfq334Oi5R7EQ5JDcoA3TRE=
X-Google-Smtp-Source: AGHT+IFkx8/ULLaclRWeXQnp3FknE4nFeL1wYOatsRa4nxVopZsYO4Ep0g1d9Nf6orRKrMY5yv7hDA==
X-Received: by 2002:a17:902:ef44:b0:2a0:a9f8:48f7 with SMTP id d9443c01a7336-2a0a9f849f9mr145464645ad.55.1765988736603;
        Wed, 17 Dec 2025 08:25:36 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:36 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:31 +0800
Subject: [PATCH v9 18/21] arm64: dts: apple: t8010: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-18-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=+Y0a0WIcF+OvRh+wENdR2K0SnXmQmB8D5lWAyKi2wlE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlC/iLREqKTBWyiQSUcAXdch2o0njKG9Al08
 TcC+2X5MZWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQgAKCRABygi3psUI
 JD0eD/4pVaQ23XX6B+Fz65fzVa5a1N7gDangt8BRGmtK4RbXJQcwK12ed/KSO6i6t7r6RkeZH5G
 b3V3+h15nme7HrfFyIbxJ+TklHl4e2rZA28BBmLoVn6dOFV/x3ZtPYuwHVdWNSp2/7DhZzH1Q37
 6BTuOSseNtCcLPe8n/KEvx5CFEr5gREp+EQY4NUDqtceqA/zFJg/jHS4jNQBfu0se39Pn4Jxcx/
 QzXxUucO0/dVcYGKQ79a6BpnThLu6Fy4hwh1wfT8y0N1XgV1bSw6QeFDkvYuXmWGbwOutGhAm/X
 /Wb765ZpIaT/vgi69kbmCXgqur0RsDyAR7uy5L6+4knysMmxnosG8ZuXpCwzdESChCoXncYfGxD
 p1cyWUPC20AQftH6PJwuWyS8ph1DIs91Q4pvllAVhpmYq8NPMUxJy62vOy6GTRHb4yxAfHvGLoe
 4SWngvxXBl70SPMghL99HRz6vDi7jXn6SY4e31zSKlV2sHEk1tUzXO4LjzyLuhj+3Jc74qx5Sik
 e7791dK35Hiz/iCy2gD/eMqNwUUIioKkZQe02O4n4ccQNxK74tRwvxuUdf5b3Mz0sI4hSuusTXu
 +VvyfdhXT3MVurzPfyigziyJNrpjAK+nMzdaNMgdJwGrekEMjGwD7J6cGpf3UCYzwX4MxKkv95z
 ahy8p7F0lBtPoGA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A10 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index 522b3896aa87eb290dc831cbbf2cc8e593844097..3cf1eef5cc261fa1dc699e8b5c9991e2215a6010 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -332,6 +332,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8010-pmgr.dtsi"

-- 
2.52.0

