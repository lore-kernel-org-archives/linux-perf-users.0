Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED6285061
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258217; cv=none; b=tLwkIRAHHzznKY9FdUalh89z9W6vN88uurpW81DSbunrN+nz8hMxLN+lNTYQcj1SGQK/51bCnrAuOFFEe7IubqymfSN2MSLa5L/ayXs86KNTcsmWm051HLDgw6FK1GQbPkekJK7uT7/Mpt8B6cTIxhLK8LipdgmJeJ6vJZzbd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258217; c=relaxed/simple;
	bh=+Y0a0WIcF+OvRh+wENdR2K0SnXmQmB8D5lWAyKi2wlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUDKJSESS9JbnXDy6WOWfNZ9qRcnBuzgMreno7FFBFaNH78dTOiZmlAaoS0Wxehsv+tIWJsvlxZIIUtk4ugCtdsAnFTkQ6AG8zrDAvG5wq4IXBxyv92p9W+vu8LzwacJxh5yHhBWZ20y8FLVBrAVe8GPaxqm02fkFtx3SijWBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/m995QV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/m995QV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-803474aaa8bso4201775b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258216; x=1767863016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ2g7x+wr2VIeqIG6aJACDKejjD/eomNYXl10MONUeA=;
        b=U/m995QVRC8K+UQq4xTuQ6WyVKDs2Qyr+qIIw5eXHbdFdN8E3JyR8opG89uJkNBi0Y
         qyF1YXQRHeNi61GYZCMRHWIt0VhrWdON6a27IimbhKJ/nUy7iNG3GdLBM3913YlwTALw
         T9WkKvRVOejl23gHP6Yh4AEFRn2/LG5G8MO9ue/B9/p7blU93bK/RQOCAw84NMJrDsQN
         63h9L2TEjyeHLVmUI6domNVGNBuV2Cwf4y64CFqjG+brj9Y3V2Z2DVVfkrlMgfi6Tx7i
         aWLW7TAf4xxtigy1zJzmu9ulySNl0xhvCHa2Qd/i5M5M6yFGJyCmzLo6iO9WnueeLGYi
         1myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258216; x=1767863016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JJ2g7x+wr2VIeqIG6aJACDKejjD/eomNYXl10MONUeA=;
        b=BMoRBJZu0fK2C2+o0EkBAHQ0pY/nD2SV0FOdaCTy/SAUAMtJsZwoZGo0LvM7ZSlXSj
         urOirDpvU5yvAMRpcdh2N6o6RQhYj93MhFXxtkRAgCGFFXKMUBnZT46gguoF5pmgNK1g
         8QkCKLwUcsRSznBD8hCAOWD1j9QSXlgFXW6LsgXFX0IXa2cQNoeYgMqguPRRbGLteLy/
         sPz49WuO8SggFxoRAd1eyUVePVxloPTkQ6HfhqNGnYJz6j51u2kdMPEBVyO70tmel8dR
         jpKcRJR4tbnkd343WuEDjxGep1M4R0tiCCeHJ83UcZ5Kagx0pDcKC9ge/Y1m5m9kHFJQ
         GZKw==
X-Forwarded-Encrypted: i=1; AJvYcCWs8+8fd50NLtigMyCxg3Jjk4WR6bEhq/ydkt9tXXSL7EXCYeSf08svowJuSvELgYF+5Kyt2BWOe02LpX32h6i2@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrOmP5TGinYJmXraRkxl0H9frelslBgKcTfDwEW/4T2ZXVaTz
	VMZkDMU21jrcv0vm9OuGJMC9l8B5MGdVXib80K1fn+jZxZOa6ILiV8vT
X-Gm-Gg: AY/fxX7frn8krL5/s3Ohs7fK5Vs4ZNQS0LS9Sese/Jp4s1A1KyIXruHft87NCTOF0gC
	Ns4BeiUBj4I9e2hBVYIeqxMkCUb0zB1rXNPxVQMh38trC6CBBArnA0iuqSvaSfsA3NYxijH2HKv
	ZJN3jRA/6ZZYDHnrphvg8jdNqiFUMHEdN1YN+FMlJg9HttimCnIQNJq74yFfvXwLntFnRLOkDxs
	Z7KilKZfp3YLpH41TDNo8YVqDWNol9QUW17nv3TFI/0622B/xVX/Sl749TpqViEtCJxuCMUrxld
	nvHBe1h6gv5DEyaNTkIQPmltBv9SHo1ocOvMQcx8OBmKKypWfuGML1oT0wTDB0h6N4DLK8rCeO+
	1gN+Ei86ASpODQOM8v9HQoPp3bz+kjtjVT711bjLiAkG1f54fkKTMNKkFkswo08Twmc/XgNOc9K
	c+XkgySwW0EiJW
X-Google-Smtp-Source: AGHT+IF5nymNXrscYDT3dfZdh6GZrjRO0nfuwmLLAofLcZomgir0Fi2suutrLyvR1ZQFse7dGezE3A==
X-Received: by 2002:a05:6a00:8e02:b0:7dd:8f68:a812 with SMTP id d2e1a72fcca58-7ff5284dc0cmr32900240b3a.6.1767258215759;
        Thu, 01 Jan 2026 01:03:35 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:35 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:54 +0800
Subject: [PATCH v10 18/21] arm64: dts: apple: t8010: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-18-48812c529ffc@gmail.com>
References: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
In-Reply-To: <20260101-apple-cpmu-v10-0-48812c529ffc@gmail.com>
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
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgpIAo0xFMf0/lApSkkk6hUOoy204imPMcjy
 aXS1LJup1WJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KQAKCRABygi3psUI
 JDK1D/wOEdgWStw9HVNv4Na47OndjFfy4bu/mK4iGWWoIefk/T2VvbgoQA9qKBH1Bz0/5hn97ez
 lZAcd12ujwX3IusRLbxduIvwDMJhxrxY/odfYYDZaD2hSWxVQ/15w2CIV3gYHMXc1uQF43qxIOn
 h0fPSd60uZ3TIueTTbk3nG/BVUhkDstWOFr1azPiXt/9KEWsKeH4DYS2gBbcvuW9RRhu11FFK2m
 DGo6B7z+kKVIy/LpVLq7IEppxVp6t5DnTqBasHuPPMcJhZ2e4UUlbVPEzpdMjIle9zW2omJdMnv
 Wp+OPa1976ZvNhUSdyMJUJZzvBa9GYkcIWIBHdVZ/aMDAYhpyZucYyl12UyLjuuexsrsl+5IwN1
 23TVJfsTXzm0FOUfXMPVoCLIXSlvJU7Yqq1GV6hT+06JWFRE0AQkW648yTNFixp2CNYDvtT0sxc
 swkJaMlrjCQUZUYIxV+5zqAaQyuNPGAEEEoDPPv2EoHsQ3KZKHZCItuzNvjiC5WHUaxH9cklUcd
 qio3aGsjyKHPn4P31pgrd1Mk5yltKydQ1AyUGVPxIagPvcMuKauERp4M+ABwIXNzgUeA1pjaOh+
 hY0tCYa41usCDXiyVUvCKJOKfKwCOCnknbbFb6huqvxWYvQXTnDhJK1BFeNTEqVzApWPKQezKhd
 cl6H9+JAo43VIdQ==
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

