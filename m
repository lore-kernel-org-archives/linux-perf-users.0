Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46502777E1;
	Tue, 29 Apr 2025 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898268; cv=none; b=g5ka6jK0jKsRLjB4/8yAB8hkt4Rv5Wh6wgehB0qv/q1KlHeE/LjVivJn+ik9rm+DGoPiyIoGqS6/cHJLlPVIJJHDKe7pTen1+XcMQEKQohMa1IuB6WNZaErQ7yyfU97112Ypg4EUX58YbXmXn8I25DRcA9n9BXELw6cgzJ8jras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898268; c=relaxed/simple;
	bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTb86xL7pdYAVI+8SL5W05NECfJ65svCackUpwYA/IIrHrlbunjP3dkHU6VtUC3JNeCBvwnN0uJgfY37t8hL4Rcay6/AyEZamAmoIwyvpeKZkZelJT7UmvTJd3eF8rOhmwDOIbJEhdMIioN8kAwLAZLrZVHh2SDw+gOOyhtUmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MESnflvk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MESnflvk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af50f56b862so3776936a12.1;
        Mon, 28 Apr 2025 20:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898265; x=1746503065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=MESnflvkLptyHWFTBDvlv8Hu4lCk84nS1vLseLeHOd7sJR9QgVRDtxUqbxj4tIFgL6
         82f2zSM//pHuhEPIF4XlxwBz5VgbJOkGW7Yw0b7SMz5wRwGU/IlsPU75WuBv65F/FilJ
         9gWnJwMcvFH7x8ogBmvOwS8y8et2Ppfhqyjw+/x2E5hSH2/fpnn80ojzOeP8QCziEDeS
         2rvoc+OZx/cKBo4D7rizBSy68Gv4HAKuRK3OmTovmyQ25A2CCRbkch4etUSEgqj90ifU
         xNKVCMKH/5uvCw4fDW5iuA5zzlyGaHWFRu+1RNWD67XyVOZomKc6QVIcPtBc4n92+S31
         kXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898265; x=1746503065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=GpyRtqgPWXfKQIOiQDaUreUIVX4QdDMs6XQKfGiP6HybbCT8zORp+fTg6R4y7vgDYa
         55ckYX0Rod0TeaAS2tkMN66ez30yR2QNUTEY/C17omYHYamhvFynbPosEJDNyOdam2u3
         N58+BTEHzEm72SGnBl/TTy8SqpuzirKGfSIBnpTEta8Bk/nVmLmcRBDp1KM4tjeN1YJI
         8srZrTIaANNnq2C00fwsbjaDbkCL8t4otbEs0Kut4yPuF3h3GmhbhPtUwcLk01O8XxyZ
         UpTt53QJxqfMSNqJZs4dIxnuo7G66WCKlVHFTQRNAaE+QCELuVdD9RP9DmfxKtj7vTep
         OS9w==
X-Forwarded-Encrypted: i=1; AJvYcCUxDL4PYWfMKqnUcWM0PxU4ZFiQPpH4B+WfqpJeBxM5wcF9hdc+CyeSLVUjS//+hKUsTLAdv1/wr8uZkNlSg/wZxA==@vger.kernel.org, AJvYcCX5qJQb8Gck2o3Exiv+MDFEz8EFZ9gQM+oA7cMJkNKz27ZPb8kQSiEltK2yILKjdTab61jREi8RSj3g2uKC@vger.kernel.org, AJvYcCXsLLrMgMAdKRIrIHFdhnzLvAZ6an1WgLf1g+y9luXTII/JDYF/5OxgQv75rKQOJnn14tvQ0Vg4tSRl@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmjN82ylfWwVBs1ZEslnMdVnWzEKRhcpn++FKmPox0puEuoe1
	QqCQZm3+RGCqDw+5kvp7BTh8g4fqe+BYBeoQmBNx6xf+zuiGx2RMLRwNNg==
X-Gm-Gg: ASbGncucoXdtOgcqdLhiMitEyh4ofG5PGNnwrHN6SCYcKVMC6CkbUwCBo9PRb3wDjB8
	nL9atVS4zcojxYJLzpsRgoZr9zrW7yTsnkXfUoEt8P7gzicsrYPcT/s/0P1fR+oVXKfMK1K3Ghz
	ogq6ovZDFleaFM5hq4XwMStQwr+c/MjAIkE/rl33+G9KK+rs767eSD4p4stBYSt3+XGA0ZwhHhy
	SS3k7Zhh+YX9BhlIF+KizqLOndxDawv74g1n7mL53rgVC2KWbwAY5CvLB/7HhdNGDWpzAL6AL6y
	0+Cg1xuUN0UqXtnrlwXtLu4FswX+pymZAmOkeL8zCsRLkyycg0mkmuIwt20MM+CKoZsS
X-Google-Smtp-Source: AGHT+IFbQ5J8X9Uyjbt/tcsLIdvZTDaLR52CKOBn0GWmEL6qPYTK21ZRYjI9b02uRhJl5cb8jl39eg==
X-Received: by 2002:a17:90b:274d:b0:2ff:7ad4:77b1 with SMTP id 98e67ed59e1d1-30a012fd061mr15573483a91.2.1745898265248;
        Mon, 28 Apr 2025 20:44:25 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:24 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:38 +0800
Subject: [PATCH RESEND v6 14/21] arm64: dts: apple: t7000: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-14-ed21815f0c3f@gmail.com>
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
 h=from:subject:message-id; bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErliqShfLZtY6dCUCyfNgW7SwP+NXzdz/aBZ
 TZq7Ys0jLKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5QAKCRABygi3psUI
 JGhoD/0TNnuFZXjYLsyHlGSzH83pD51e/IIHTZF0h8zEZ6szGklAvPJ/SqCVelB9r/NiTpsxQz4
 Kntqe9FfHouFNxSbFtWnm6qQI+Ijp511HmdPDPPu0oKTtZKIh31XJ7iN0erIk/1O0XllijQBKJG
 ugs8UZsVqljduxJVWv7BtzEwD4oEeDJ1Emhy43mjZyngLY8LV4OkwbRUZxjSdz/iKi/yfA//Z0T
 rbrBnSIIdaUAaeVO2quUUc41ZRh+i5UMm/wUZj1CcRIprUskcPZ1cEgHgYRNEbUDUDD5VFdWJxW
 vyZcXWIW/Xibory1sDpxDgrjRzKHXLeawo1z7RnAsaEBfKZOsEwzwNt+0rQycpaniYlXJblC66U
 5XSyKhz/kuJ5PVTS2Bom37a+sLtd3x6LkjgP8dMdOT+ODWM73jWBFBFsmKUPOhMIOptOcVz4kpm
 sspCkZK+hAqTAtwuTIY9atL4H3785uGpjWxCWnd3/+GijKUf0acqdLCPe3ldJmbnCJhVvBMxZXc
 p4Cr7RmXgHTpj/AgVo72JM8NJnqyQEkPoJnSD+CwjIoiODUTDx7xsJLtFIenR0j56AZctExRHqL
 uk4dHGr4KLHVausx5xrQUdzyh7JcM3h0buPMA66jEmiO1iO359ZwnP+EGIjWHeWxeEnxpeG0uIm
 5gl71i8Q7tDCybA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A8 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 85a34dc7bc01088167d33d7b7e1cdb78161c46d8..f1415f50cb150ce1d33999c817243c3dc9184199 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -193,6 +193,14 @@ timer {
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
2.49.0

