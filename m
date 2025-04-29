Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802629DB82;
	Tue, 29 Apr 2025 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898280; cv=none; b=svB1PUBma7rhSUlsuFkCSl1k09jC0KBNIe8woIOvJsBOrUsCrRLuyGHF4wWZYtL1LYF4WPRtZ8T4TVUxEf1Xs4+vpMEX95JwE+ttlTp0gpGQCy6jsZ5EzaXqjl1c6Irr7mHRDgXi1cBlXJLz9WlQXV3D9VNPr3WocssKjQ62tpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898280; c=relaxed/simple;
	bh=kZviMfYtRCR7gR5VoFkDRwcKeTgAqfWp35C3egDQLf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfyG9rRh3YqDIphnubTy4A8mzh0+cJAZKEczd4Dwm+8Dcsi/L0CwMNroyoydRoQFU0hR9CiFXo5nu0R84nMZ1w4bG6t/taet4nnmYdNfMz01misUNm2YbBPRyTnUIhVd2GACJ2DNUEJE4/pOEV+QAy/Xa755aykvn8ZUhuY9L4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csu2SAn0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csu2SAn0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301c4850194so4517168a91.2;
        Mon, 28 Apr 2025 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898278; x=1746503078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65yvptSdo6oSSwoGRF8EUfcgAwuQwDq5kFTQAdR/3Jo=;
        b=csu2SAn00P98l+MPhXlhdcTGNxyLaquyWRjYMyqK7PLHzufHf/6ngxpWWoOAHtc7yz
         ToZcpl1yjtbK2ea+gcr1ICxoC9vqVnQcYzuvFDajCdn7VjpIYI3m+5sh0M8T0HkwdBCa
         hiaMydZgI6LosMDjS+UQgBkKSTIbn+PHCT5ZwEIkTf0qataU2vFAEjAA08LYk3SM0Jle
         UcLPAIFMTSwl5kbsyiYpHZYD9jcogWKE9ff38HbJFTh0Q3u/RaDXZaNJMTeCZ4v5RUp9
         RDnefoA38IGx86MRXAhiemA3yRIB8JtzO9vD1LJOgEWx5qt4O41yKmAYJ6QcCUJ4aie3
         JRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898278; x=1746503078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65yvptSdo6oSSwoGRF8EUfcgAwuQwDq5kFTQAdR/3Jo=;
        b=mKeBzuYuhZeTnZMWQDjIdc4sW7FTJEcIq7RwGrJWbUY3vCiUf09CMy9QA+ZAa2nqLB
         bW1k4ZDf/SG7z9hVx1m6wmDk/SJuAo71eEV0r9Jhcp3qRgvgWjh9uAjyXolUDYFV8KxO
         AWK+DWbEqEmYcjcWNH+SGzC/EQco25TGMT32Lj3EBxTq19nIQvRZ5BptJ7IN8Kl6XrAD
         tBwi9bUJN1WltIBDi2yhwuU4t/tk/xMm/hbDeCZJhoAUGONPi2f5cEAHQU609qRE1qxU
         DipA1YIvGQm9rgZzwdawIStpTQzmQTY9dcD1Eet4PDleN2De4uEBfk+6+TzFKqp53k0i
         B6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCsNquGF29wmR7d9jOV57xflNlKioXy0POI2DenHGHITkv/s/3Fw3nl2rZQtzqY8toHCkwIyhkqc2x5VZXW+FCtw==@vger.kernel.org, AJvYcCWPtUcyRpetoD/ROtBNUlZA4EWIkTd/d4L/Yhy2VHOI89JfQY5u2imtYhaa0UVEHE08gzust1lYtiaT@vger.kernel.org, AJvYcCXZ0Gf9042uQcg/wzAoB5Mk9JPeCafl8EkSTO9kzozZck/DYCpKIZl+oK06rFNHQ9NVpO6ND7GewXom6GRI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjj7DIqwRJGeoz2+Wm/HwUdIDXK+Pv+Q0AApVKvBlyog15Zxsb
	n+61eNfAaoAMA2I3IyKxQEvseOGZq72OR5GL9V6vN0F4kjg3HnnK
X-Gm-Gg: ASbGncvWP4VhUFG9EKxZgPrOsXcaUjITnhpxzCvUHzzTRgS8wvtS0Iv9tWbAhURtvuQ
	Yp4W4sPl5u5mXg1ItknoWu81fG30CuJXT4lPn362bquBgvsYM8vNJBn9ak9HNGEQq6xJMgbK1hN
	Hl2dAQ/8GPyD4o8UhvMOfwTivraDsGPOBIXwdEgfbB0f5Di2xLBr0BkwpCWZv/UEe+wDqzGL2Ix
	PXGt1iZjy4oORkGY49y88Luq42HiSlCGpdyL/Vn1vHyczb3effw3UvHy99si1AUvwJFdPFaZUgK
	D/iA5BLuaBdkc4hyflwkAi9e0LS/wWMAIjQgWB75e6TBbwSuOuhrJ3qpxQ==
X-Google-Smtp-Source: AGHT+IHxm8rT1uzIKYd3ADrbL4R5NMyjZOGRKMbNAB1/GXp9S82eG0nLY3UcJaZeQW35JAd4gGlOqA==
X-Received: by 2002:a17:90b:554d:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-30a0132ba1emr16578615a91.20.1745898278562;
        Mon, 28 Apr 2025 20:44:38 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:38 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:42 +0800
Subject: [PATCH RESEND v6 18/21] arm64: dts: apple: t8010: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-18-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=kZviMfYtRCR7gR5VoFkDRwcKeTgAqfWp35C3egDQLf8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErlqBnZpfNvEc5aUCBu7KHe5SloQqmhqGvfE
 tbd8L938H6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5QAKCRABygi3psUI
 JN9jD/wIdllTQLa6ubvW3FYhSvEAW8tilwFBI+z1bwHry9E42ry4qJ46YOeEx/l5swDjNm/hIQD
 0U9VCXRHRMVc/7OUpM2QjGef7+PJJfW8AH/tIk1UVsXshS2w4bjhX0nCsHFuGCcABnnPmpSnyhB
 8Pt8e9wtlMBm067X899femotFvjQAXUdywixEZYnSPfwUDZXRmayFOcsXyRsAuXhoY9SAv37x/a
 M8fh39JtKEG9kJ+sUjbCMClMGpnbVpd0fs5wRuNahh50wGIxacXpfLnwchguFO1cwTOyq/3Rnnb
 avfDG1XNveZOTty65LDO3+bdErUSJhR10if94vy2kOxhMMHYApBl0Snl1IBXFZKiBKzjrLcmyc2
 6ShcYQl6V8l/JLa6flHDYJKnosKVRTg8blKDjcInVRpKc+4DO7M9t6IZUaFSLIEI1MJWvdtEQAA
 TkmzFUN5oy/wtfZgY6fGqLg3NJ1QkhY92DYahM3Pcc+EagP0kklU8jQL9SNBspIfjWiPKwhb+xM
 bLAL8h/zgJZp8F5tC2DuHY2Zsy1bPsMR61wwsfBqIQMRomNKL2uc6EXCje7pCbcG0NFHzjA/XGE
 PlRM+kh+WShS9fcLMugbZQX9WOFN2mHNWRc+O3R/XfeHDsseT8U9PneTBJTTdJaax9yJ5PuG8Yx
 mxmYwJEk3r8LfjQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A10 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index 17e294bd7c44c7961cc3ba0ec5f4178840d5b9c6..cbffc84480379cb476d5caaecce91f746e862354 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -243,6 +243,14 @@ timer {
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
2.49.0

