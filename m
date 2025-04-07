Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B1229B00;
	Mon,  7 Apr 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001232; cv=none; b=t8eE5k4sLnpPO7BH42yZUp3Edpsx4e0FK6JqMtgZ8NSr7vS0mCO1ZUf5pShPCBFmBnTx8A8+gVebToywnyDFpxiGb6Vkrk7Du3V+dlBiRSdUOTfvZo6XOPQ0cmmaCBwwaQyD2lnIadn7sCRG/c00VAdlmCEqkcFRKZeOenhSuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001232; c=relaxed/simple;
	bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOmId5lvystlQoogWBu5YZfqcGIiSX9eB/G6ZEsCmW+jFUklDnXGDVptcpZU338S3YC4VbmI/yp5PSO6X4KgrLrMQ38bT62pFEoIVAQzfmKCKnMQjONgN3zW8QhU8m2C6XaM9tXiOvjf9D/KcT//jxnbNKa/Y1cNsIJJooD5w/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BovtRh/p; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BovtRh/p"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30384072398so2931843a91.0;
        Sun, 06 Apr 2025 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001230; x=1744606030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=BovtRh/pR0oP4Wonl9W+IMZezyB2+j54kTDiUa92VWqETqyl2VsBAzVWUBq435HYJu
         tWRN3jBPsytFVhp5ZJi6TByLnZGXkTo68wONRfuZNxQScsf2AB4NONug+nvUkuzzy9Nw
         DJ7nBuPPae0dIpT95C2Dkh0GRUBSOKX4nSb2ZhZ6SOS0ITWlDq3qSxc1yUJximKU9L/I
         y5QVwfbEC1cWsVo3vqjir1Mj6zzmTzXfw0gSaEhxNm2CwO/zvyvxqpZzyGohjf7FNsuo
         fqRCip98swTql8ZYGI8LqHnDeqRGqv4BJ9yqJEhHpGRA58CpgCRavBgqkAtj/KX0iGM0
         eXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001230; x=1744606030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=Z/pvHS2/ToGSNBGRa0/0mjKulW6jQWc74MNwz8vxEgOBSipHo1TK2lHnw0V7SZM/gr
         qUYp2ENC6+vfYUJp6IdnAMHYFtZtTLzGLwroePHprUUT2j+aPtWw/Z49YDQA5AyPL0zF
         N5HqFKB3a/rKtbAuGLBkmRLgU7udGsFZPcH0kFliF1P0O1iU8ivFbam9fXOU84UcMmLo
         v3sIdcUQ9ocXMKczpJ/flpk912h7YMdgne/vOKOBFs336QEV1RLfFDC908EUBVCNFzlF
         GMZ2uyXugjhhliTdGf8c6fexB5ISocchxjaqU5dRQpeE7jVQoKfBduVVlVFFa4nEIZJ3
         JkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFuld2VMDxoQZWp57xNf90OENiDI/zpkpc9r7wGNH35LvHFTzXMN1SUGecsMu5Q/Dos/HtEdYlzvar@vger.kernel.org, AJvYcCWqmoB2kI9omajifX2lpAFQx66IDmrn+GaHUBU8dqJ+RehbQ62Sw8mWoFFtceSYDPryEOK0ZANK4f9JgJYGsGF5Sw==@vger.kernel.org, AJvYcCXP53tRH5HBkjVzrtMeRsfGp1mTHUrS739qvXbvAAvlklITXiU1AKH75BDfNuxuuvTl7E6U36Pdjf+PHmWe@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYZyfUyJVuUasKj2t30oRYq3sw6/1yigXglHpTRkrNqSWBunS
	9iejBS1Qj2L6wn2pHWzt4d+eeKYvOk9+SxzEvOPLdhjZhOhlhtzw
X-Gm-Gg: ASbGncujqCc61E20tdVr6rdNYP9TmRqXtaKkZTw43KvBiXhcNY6wm5JSyVR1o5uJGz9
	5cc0xaHB2MmsVD6kH68epSUxSkEh/rVCqRTjoFzSqNt4lIlPydJ2BCIZHDiERw64geJfxRtBRpM
	6w52gEIry7HBM0/8XCB+ViSNaG4ix74L84ZJcpGph/tmFAZYNTw8rR73U/CvlM6/4rymLL4LV+i
	Y7m9H4hIAi2D3gpbaibLh4FaSzzlryTYV7NdZZTDS8CEkyDHnpndZpNcWp5x8ayMnCNgLCLWmLW
	xfNZfRvmmEYE5nJii+uIls/gV9pVtkn7/v7SivUYvbowiR4=
X-Google-Smtp-Source: AGHT+IGqaSKJPQ3webd18v8phTfeS2RdyW8CSQ2+EERcN82F3onx63VuOVR+lqwdMYbgi6lgA/f3Dg==
X-Received: by 2002:a17:90b:4d0b:b0:2ff:6bd0:ff26 with SMTP id 98e67ed59e1d1-306af7b7889mr8138089a91.34.1744001230570;
        Sun, 06 Apr 2025 21:47:10 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:47:10 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:29 +0800
Subject: [PATCH v6 20/21] arm64: dts: apple: t8012: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-20-ae8c2f225c1f@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iI4yDZKAdu9wJhoMkGQMGWnvtViIIDchS6e
 YAYt2NUBtmJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYiAAKCRABygi3psUI
 JO3sEACc/heHWtuO02KNJ/05gdbCQFzrtSUeukVZSXbGO/W10Awaqv//7OOc70tBsW+S2sNMAh8
 JiV9R2J4VxHb/tUxCR/R9hfB60Iwz3atVzCHQqodUN9V3GseI1bu4MA3peFaw0zARzV0379/E/h
 GriUm024aqKYDcGmkbVPfJuY9lJQdSVlDkbpqVzwTi3l1N6x8f7JC7+r3bKKhdB3RO3TgKbYZER
 mSp5T6MN2kE40wxdj7y5bCEvar9cFI1Vrvebs19VR7wq5XHdGrzupDX6m9URm/zrrL8hzsJF/JD
 hyIo6tHq0OlhzsediNtFiDLJs5CXXF3/nVviFQAPywTv4BkHp+/F5P3GGhGylt8rgMvA6DbLhzB
 k2RsElsbCAUatMk+GcOpEk1JUQDkvJRjzr0ccipvON+GXDNiWnxlAaTQAL+kALXolG2O/STN+18
 cEm4dsBwJbNVi+dL88KkzoTQWlduxCrniu9GgKwzzeEfH6EvTTbdrPvSXTS/YoVAPHs0Sa0O4Pa
 NCBSnVwMXTg5xowCFEZ2dFahIM3ZzToiHMlk77gxYiv7xCaRPA7Oj6sGVtpTtIej9t3umPBdjEt
 NWHgc6pCumXxTjXuf2DtNMKYU5PdqKWGbetVl9xRpC1IK5H9iR6kZmm3nREfJrd0zmrG3dI22HC
 IDojzQ1B3jNzRJg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index 42df2f51ad7be4c4533e76d18e49a9a747b6b7a8..d79ed754c68dd89fc8c52887e6dcbbce04fe126b 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -276,6 +276,14 @@ timer {
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
2.49.0

