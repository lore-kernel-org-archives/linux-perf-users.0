Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BD283FD3;
	Mon, 16 Jun 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037582; cv=none; b=i0LFxgFVCYIIwhcsCwudhodQKqk0w2OLqwOnABSBO8IPvZ1FMBC4x9kGomOtosBAjtv00jn2CE+O43T9GoXmDnLvtlgVmCue9F6w7+gbeSRsh0Kdd22K6w2zEt5d+7anX3Tu2s3tteLENU2wRC1lxPs6OewbZ9xlJGsEgL5CNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037582; c=relaxed/simple;
	bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1Mk03pZlNdAqaJWK17RRT34nBhP0P5FUEiNc7+iDZyhdBromlkWBw0+maX1m5nmtaglNiXpsE0K6YwWGeyy8psab5DlduY8zZ23ztN6xBQHWeF3LVPGXnV5Qu4ZeoCeC21Qv7a7gtQb+FbhRREc+Yzs6ZZfECJwN5pDF5OmFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3BllZao; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3BllZao"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234f17910d8so35786645ad.3;
        Sun, 15 Jun 2025 18:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037580; x=1750642380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=m3BllZaoPmHLiO6AnMNddMnwX3LO8vK9QTAIVcELwaPFksCj3TF5qMLaSURSXYlz7W
         OPdm4qEItrXDSbKIFUJukxWJh/h9wMlQ193niKG4724A37eS4qIvhiu38m33LhJpf+kP
         ykJPXHN4oGmR80RCZiS+du2yQS0PEAbE1lu5O/8fYAqfnaJM2ZMSnSFsvwiAh3OySSG8
         wE6WSS/V6zFh3R0VajfNWJ6D9BpkH8b7qThug9I0JZQtiEqY03AKcQVuL2yAEIu15yc7
         hNk8jNpeZiUWlxjJbDciHcDmlkMvY4qt9C2wLkHCdO9JSlSPdMWVGPpSeKNcgsHUiYH2
         TlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037580; x=1750642380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bV39ciPbYxAqyF9bw5GexYzHMHyeT7cFiiGjkDg4x0=;
        b=KT08LsrsoIOVlWNfQdIbZw9rCgy/2TS3s5ONxq9iF0ldirubS9aHuddo3NeX+J74hf
         BNR2HsxjV3zV0vluSioGETpgTPUmB61hhtJqVZ+bLgJ/+KTA1OqXU07202dhiQzN/lTy
         sPRexZsLw4K05zlq4HTI5S4ZlhHmGrh6Te/70OpF9DIkPT3cfVTH1I2tWhTXZvHj+7c1
         awn6S+4M9WYGTeGKPoNn3/v+v0Z/TFrHw+6oQ0Ui4KZXyYsfU2MnwkPzv8AqUCJkLoYZ
         juGk3wiyYtBft8JTIwWbt7k8Ue2GoTqQ04Ob6m5ORhVr9s6tNSDL9gO0pDVtes7Fdy4z
         +3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1MqiK2rjq1emLre++RISP/6c/qyCQ4OSHxrpACQi2+f00jZzwQm1ihpgjQJDwE45/EhdCSM2dSPJ0c0P1@vger.kernel.org, AJvYcCViyGwu4DJfsOxaWOXd9tXWCkLLBe5y+ujuGLsq1GMGFeQEjIPNtB4UBJYagZu0KcTw7qghvcaT6zoLqRgBSg/VMQ==@vger.kernel.org, AJvYcCWYxiiL3aF6krtk/U4BPv1MileZT+FcvkLnJfllN3CQxPtPbnRTO7eyHlDvSArConJcwzEq/czJsDgR@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7QAhwttIs5b6K/aM57KD9gK9wVLZx4g2SjYagpS3Z6u+Mf/w
	1POybkHvbF9B9XM6IWCjL/6aEOWGkxa9ZQWQOVVYZM3cVnqsT2RJuZi9oBkDVg==
X-Gm-Gg: ASbGncuFgeFI9W5p/OBisANguFDyIWg25ezLXOXWMqbAgqbZmnsHelS1gWQ7w07fiXX
	e/Rk3SDE47cdNfa1XkJT2Ls+P/C5HYBQeRtULKGm89cLloGQoZDfOYiIAIgS+/hohchUE5d23jh
	tcYdNo31TCZp0dzv+uh4AzlX19JSt8uCOxyvm9pwMO8gFjlHVULQB5Qr16wHX8wB+G28pYUDllb
	tG4ForNfp41+thm8gYUpRH6KIhZXrx27N5vs+AVuaooWkf8ZSQDggyriz3N1u9iH4aozLhYLlWP
	cFFumQNmS/gkIl9EuT2fzb9Zc8udTJXGVh/ME9OBSsJVLYdt9kO+ht/9v2aZC4jHD6lzwdVaKlO
	lZRI=
X-Google-Smtp-Source: AGHT+IGgk+UDqjGBXQ/jAlFUVtNuJ28xq8CqF7zuw/GIVK0covhXtNdMSPcYwH3H5HMFOq3rIKm2Dw==
X-Received: by 2002:a17:903:ac8:b0:234:909b:3da9 with SMTP id d9443c01a7336-2366b14d30cmr105655215ad.27.1750037580157;
        Sun, 15 Jun 2025 18:33:00 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:03 +0800
Subject: [PATCH RESEND v7 14/21] arm64: dts: apple: t7000: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-14-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=gOE3a46CDNX3yVDAoVpyrWK4j8QsbYn+HXz/rfkRHIk=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QZEW1fC8sK/zRP5v9tHDE78di18+WRlDWek
 8rJMpr5rlqJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GQAKCRABygi3psUI
 JOBxD/42w9CY3rh2s/hF+0SwApMmvqGWI9Zb94hNeuEMx30t1pV0FOug7/1+RcLNSNw6faVlCY6
 PmZu4VjpZSq7S1wJytSvk+X8/WwjvkEeUIQD20i1XFH++kNKH5Hz7o8jiIw2Hy98JO2Bm1GF8pO
 7OAu1fmNopUdue7TTnNyAT/psmj4YRgF6U+g9f3muDHqaVi4QQhkcqElY2h6/nBBt2LP1kwa/pN
 Q8YMH9Szg6a9drSDq0GuVKAHLNBk2olT3LBVuuE8nJ9JURZYIm03Ql7fBTGdq2DSvFu0Yxs9gkt
 E+2TeS+yoVaKI6Nwicdz++kTytPjWyyYnnp+jq+p/szMSaJJkIjO4MmYBAY5wRCAjswDFEv5NXu
 gHC9B7VHEqwWdKv6M1ZG5i0sYq02PFaQtuFU5pWLGsumM96/HMDXjTW9K0CMPcCQEEXIjV8L9tp
 sP8QCN6NxIeW6ugXkbBvzNbQ1yE+m2QL1aS8KlKN3hZbonCkSQclAtEHD6UpIFDI7m0quUOLdDe
 tdFG0GzOgcShiymHZdgxnbdgZiSv1eU++hR4kXnEix7dr5NDhN64vvF5xCfh+PqnW6HkZ4/h+Ce
 Wkj9YEzlaGHAeaw3+CbpFfAYjO8bkZm5LbSkuxzFcUfTuXV+M4t58UEZLtaD+6yUPfF2f3Q+HJU
 yejpG1ouBFAW4IQ==
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

