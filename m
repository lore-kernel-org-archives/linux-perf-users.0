Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38B2F60AD;
	Mon,  8 Sep 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325720; cv=none; b=IFUkrqliLiaOyadxf7mdxI8sxumwY+vjV5gVHEW0la3HLv+a4IejrHKsblVANA/sMjQiRTEc1T0kARfzwEtxMd9fqOcFJ0Zf/dvS33q4aDfoZcsSF9CMVwTI/wI4tXrOccoOeC87AUSFyHlBlae1bCRLQkTzJ+4SRHaTQElDPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325720; c=relaxed/simple;
	bh=KUmhbvVhE7a9qQQiOxTeh6fcRXxeiaIPFMb6Ibxmxag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/M+kxSHcyfu4g2lbrX17HZUD+HVqv2URtKE9ACa/v/CH0coNVynl0xgZ8u+vMljtc4aMC3tMeObzD4Wpzyl/uDx6+dG7F7FrpYwP03QMxCe1Olxco7IUkcnnVr0TWHclSgc7uyU7+kETNNBlpB6gkvorM+C0uBX5erCxoiKAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJZAXzEk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJZAXzEk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b21006804so43480685ad.3;
        Mon, 08 Sep 2025 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325718; x=1757930518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKXUCmU9jFowxknRpXATBfrh5U5iaqmYG7UiFDMEOEw=;
        b=LJZAXzEkIAGNsICXft5bQUzQLoW9uiBkiLlEacdNNqkwrOAPSdpQkJuM4X6e1srYL/
         58qgPp6UPuoVW1QQuPaXuVsxT1iy8mK3ImWCFGyeTe4Q4GELeAHkAyhSgOiRZln3M0iU
         y90fI49sfMGTvTww2jl9iDhWJgI1rF4laEXbeE8SHMrowihXjsOQ2+Z4R7lIQcGr7u7p
         q0xZfnjQ7CAaky+OR8Rpn7E47n0rTd1hLyx6qOLtd+UeXU4xXfTUbBLEXL+KRrNsTo5T
         nSA2H6DwH8/84Y4DquDZ4aFOuA6ZSAIqDgn/2RLJ3D2yIXNeSVFj1z9EDa1YwD6rfU9F
         4Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325718; x=1757930518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKXUCmU9jFowxknRpXATBfrh5U5iaqmYG7UiFDMEOEw=;
        b=bTQSBC0rUfvbDeA/wrRW3g8gcm08crNxjWdTj74ut/qnHixt3aXW1Suz6c5yS9iOGN
         TL88+4kL4Hs2ntlm9hErdrEvGPInyZOzz0nTdQQgCPpkNq2cqvLcHGYPeDIl3u6jDEKF
         mD46B+fF1GMke80LO7YqoE5/lBL2idBsHqejCVAIIelHpuA1TrZ7HlG4LxeJ1Z+bhZig
         GbZx6XI/LJeUKkMknVx1/HD3KwzGEHvHp6PWVOTDDFvdsbhxKhM4rMmNtE6+as5hUYZi
         QYrAEA2oFS7vC2f/iMea/WPpAimdx0MbriRh92xqossGPMOSKjovh0wCg+KhSu3bRP0Q
         OuNA==
X-Forwarded-Encrypted: i=1; AJvYcCVWWulhTpegcHpBGJUfzX7FdigFPyIq2pAY5p+xxNZhcatXSgCrThDt4Upqk24SA7IKit1Wy5ubGS+B@vger.kernel.org, AJvYcCW2WSASfTslrnNC9tqyUO33EdnpKZnv5cjDDsV1y/wyugZgbBnDIRgvxHZMfzl+4KqAl2R7TLvm7xHit3t0@vger.kernel.org, AJvYcCXpISbA7UF/Eqi4/74sc3i+KQHdMCIPb0oQ2w6R18DoOiR/URQ9a9UzWhyoFllvxITmMoW4Bq3/PHB5JYkSU6OjXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnPb7y+v7vJD/G02LUCrSssB0A9MNdf56Pl6IXiwLpAAK5yiV
	+dlmyd493m58ARLuRN3KO31TgTs/z8MN5M8a5Vvmc01aLMNPguriab2i
X-Gm-Gg: ASbGnctumPwmX9cQW7Hxy81O5edl067IObEdAcBKHWE/D60BVJs0bdAMXxOzAaz8Z+w
	KkIJcGCQWhIPa/96unNQJ3Pb536h/MYU96U63nLd1VVSUcvm3xDlvF9soFzZ2xONv0ElIJ7jib7
	Z8kylY7W2vzt37SkveQbwj4l+ehJ6rv6SMEyCYEsKeRCPfUwTTJIS8oYaM4ZK5aaRjmDFXLKXrr
	1Gf9iYMdmDYYVUH4bVPM1tf1drn82pL/szo9ZyYF3rN6Rk7u4zrVR/pCUNEwiCRCBGxzY2bj37J
	yn0svRORbORkavElqIeqvYSTVNGw8TXWPXgrsop2SH/dmWe/qffKTl8jSNScoK9s2FWUm5fAB9C
	u9zCux9k8lTdDEn+X1MK05S2iYB5YHzGcPqDcew==
X-Google-Smtp-Source: AGHT+IEm2+gAoGZa0cwwAA0rX20QtV+5UuqaUU6OUNEfKaf4rVPNAoZSA3dqhcwbE9x5WjVSv6TpXA==
X-Received: by 2002:a17:903:2a8e:b0:244:6a96:6912 with SMTP id d9443c01a7336-251701a644cmr93794865ad.20.1757325717942;
        Mon, 08 Sep 2025 03:01:57 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:01:57 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:40 +0800
Subject: [PATCH RESEND v8 16/21] arm64: dts: apple: s800-0-3: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-16-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=KUmhbvVhE7a9qQQiOxTeh6fcRXxeiaIPFMb6Ibxmxag=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlEC/KtUs5Hq0AV/39vKlCFghpi48YewdkJ6
 gXzM4aJxfGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRAAKCRABygi3psUI
 JMKaEACmwYGs3rD8OMLjnTxxlkBn7vmh9k5AUksNc30NWUwChqVZ7NxW1ETKBoRn2MDPZntSVZG
 j0Dz2kXqhCTBd/E+9WVvyXc/fiattQEENQs7w+p/Z8OaY7iaUtP/3BcK0FgrqndtaPHh1pEFYKL
 EWEd0EWPLLApygXTuouliEthc/QiDUCSZ/xzT8w5lYWTaO0snntMglcPEr2oYLBskg92OfkGT9U
 piHI2YiFc1FIbbkb20ajSus589Dce4xbTeujD8COJ9RNOUo0tqJ9GW8HY/IjjvFQWGillETAnAn
 Ctdovt8ZeVV9Gh+ofL/XZm4rkN9e11zNHqtZdmk8o7kiAmQXoNRVFlsLmg9OPhfJyOKjnH05r0D
 nvQVMeN7oxBVCgD+8moOWVzaHFWZKzTbbO4t91ILeWMAaBWim8mTLVkfjBziSP3toGH01PwARya
 3Fnq0lj+jZ3ARWTwJejMV9eQBJPMK9Tg0Wj63WiyOZyt7MuZD3J4DuNzc/Lu49pmn5HwdqIql11
 q7BYDQWDwh+yG+J0f/hwpblU40AzNT3kPezF10Oi4gUXadmzS853w7ic1Ht52JCSzDEaLSiOQ8D
 r1KrcLXmAgFbVMk301HYHnr7mJT4ua1cWxfCjQ5h8y68yru2FWF4y7TV2zazaXmqUhvDmBnNG01
 tY/GmJKgRZKwDTw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index 09db4ed64054aefe5b8f8298553d87fe5514e81a..bdb66f7e0de43a6a751af37c9ceabba44ef907d6 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -180,6 +180,14 @@ timer {
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
2.51.0

