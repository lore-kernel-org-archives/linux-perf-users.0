Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C029CB4A;
	Tue, 29 Apr 2025 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898277; cv=none; b=pTHpHNBQ4cwS9AD29hdvwkK+a+StOBzko4t8T9LpD9jZYF0gR37LAd6BBVYi3r9Ya/hYx2GUebX3b4Z0A/Ji5LHvSBgE8H437e19zx65Jde33XqhBJUsnW/X8+X9RFw+3b0J5iIVEshKjcqUiIi50/brhmaE8lFhZOkjKx0md9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898277; c=relaxed/simple;
	bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5utI9ubCVAHVTtPFIfNKG+bUIcc1TWL8rHabv6zqrEVjh+mXiwkBbQ8gFIOreZAGkfZOVl3h6QqWpsuYCf289IkasUn66WoIdhD9idjqkbTOLHlxLnPuonAGICRs6TH4fHOBbFBe13agTmMc80F0zP/V0i9UdlfU9dS90oJVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnjeSOXe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnjeSOXe"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so5486624a12.3;
        Mon, 28 Apr 2025 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898275; x=1746503075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=BnjeSOXe+jwKUMGu9VeL9rAxdRdkha9WvUCcIi8FCXN9JKQ4oxJTNDvSwnQROzJsyf
         h/Ty39VDYHe1dXfYdlCd9KDlt1m68TobDBkjZiyax+wpn2h+H/nPxMO3BTR+FaTYg7Xw
         2XutVMRC6mBmyF0IxfkkjTlU/WS0tBoQ45hLiSf7Zb2/crTNgaFje6rg0m29/VAzKoeV
         fdM/l9nL7MmznJ8Y1PIDTdw/VRysu6LDC37ddowdSIXRHJRuPUw7dWmJlzrxgVRWm+TZ
         N0tHJ0cmkUSinSu0cJ9MYi/BxBymTNGYFygeprTO62RUAZYpVsOXUdALopEi3n5dxJEA
         dvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898275; x=1746503075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+utL2luHU/M8t1jzjSvkLs9Wawp5wUxO2TP0BW4NMfc=;
        b=ZEnGI67eDxfIBUVeBVr/tgHOlOzvBIaJGql3T7dni68C9xx32Et/rmhV7jgrgX3QU9
         nBDC1K6wxdfn+XNnilRuWggn65uC5x1nJNS228O3/iY5C8WkmnDwNyn22Ic6BIFfYOLw
         QeVGdyFl/RFBHGSA/9wUBUm2tn7K9XosfO58xev7hmZsc1QwDNdnYzMRJJLsScQ0aSwb
         Ivy8guxn9+k19KOBhJ7wqow2lxrYBq3QV+wkGaQNi6hZLxZy1W8uOCI5IUMHzk0Xt3Qq
         uaC5jtBod1b7CTkIphCu4z+P2bvNqU0nNdp50LDKYgqQx9kCsT6qpz1sap+hOcdAvWX3
         Pk4A==
X-Forwarded-Encrypted: i=1; AJvYcCVm1WHqW/UFsv9vOQvWTGse0cXX/IiJ4FjmjSrA87yfP3LA+HsAXvym5sJ65oFtUCpE8/yeMR0SD7N0d6447Yof/g==@vger.kernel.org, AJvYcCVpJaXs0+biMXFvPTkfTf16AVgc8fcAdX0S7xhQZDd1/lHmdjQBSUAVLdjg4G6QiU1+RmaaDqARPDh+7N5K@vger.kernel.org, AJvYcCXtOGFdZutUdP5aOIcGrJMVxi3FpyQdHkStRHboRgBQDUtC+Uf3tNriAVhLoHtk46aqp3u4oliVIofb@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcK7o7t55EtOmcmpfkSWfcrAz32fwywHGer7TRDQR8RVEfSCL
	z6IkDMjGxZ0wod0jAIHgoNolHC80IfaCoIvjl4nVh3HMKscUzCC6
X-Gm-Gg: ASbGncuqroNgFYxbeRkdWORnWtcqjkd5BR67uXAHR2uzF+XadaJKMo1zewZt2q48Epy
	HYbl2kQ+W5kAReX5PLPlLvtxy6/LLqVH66NDOISmtffWS6jsYujbqnnp9QbMYTqkHdrFq3H7s8q
	IRszOY1tJZ1UXuP/IYn7e+va3b4zlggPd1PgAMKRk8jvUviwZwRQOdnWUsPke5O1wOYxKY/R5nZ
	Cb118/2bhYDbohfxN75iPkRCiYS9lVQLJCYcIyFysn7Zfxosk5lJXlUyCdMyDjLQOMyDKHS4TJs
	FTkFt7JVk38olgnD6rc48oeidTQKplqM+Y+bqHW+4cBZEZ/sUP6sKgYH7A==
X-Google-Smtp-Source: AGHT+IHWfMjbVQ7CEMWplQp6hbDhEW0CnashZJmxKBOUPepAX15akTtG/oxgIuKanhYarcPeCqHQeQ==
X-Received: by 2002:a17:90b:4c09:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-30a2155ece6mr3699740a91.18.1745898275246;
        Mon, 28 Apr 2025 20:44:35 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:41 +0800
Subject: [PATCH RESEND v6 17/21] arm64: dts: apple: s8001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-17-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=umS18Mpui1EoUACcGD+WdVdka5VgnqwULsO8fA+OvnQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErl/IRyZyitmYveeenL0GQFh0I4cCrA6w6+0
 9uwRuLZGQaJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5QAKCRABygi3psUI
 JKOPD/94+SO3FKA31NGVpaytKTjTzwMf8DGMAGqxJ3qNQv1fbU25mGiif6KB8zFmOIFvLYaKWGL
 3lHVdyBFk3VRfYjagBokp7A32epeJOpRr3bJVzBAtyIVZqgpLmfpMToHKoHGY++WMKTkqCexJcY
 1AIvtoXobSR0z7CFGe0K0VgakVOwp4KwFMJPtA3m6hveWhGKvUvslHaVSNUZfI8BvmyPZFRGF2B
 fkmqjzN8cyKVkPUbTvKRd7j6hIRFFUtzQ0F2bOvPjMh3k1hguUCEIraz0IrrJY89cYgQI6XzstX
 crkcRrNhOfbzhUx7Bf+JAI4RKtY1+2W6CSEXXwqfEr8gm+WxvaeeqyUHxORn7aXXXcjmZSW8esG
 FxKwhUjw33IrQrZtNqUD96Fh5DL4852ZvjvFJs25Ro5myt7hQOroQfZuIdpZ2chsNQ8pBwdwj5H
 b6eOaanSwrQX3ueBcLwJlIlfjw6zpHm5uxhCWQ1+qgKlTjF3GW9uX6zL6GjR8uWV13ApHCpN+Zm
 Pqf9CZC7srE0xwu7pfhnT9kbhIvEBjnD8rd3elEJ1HUD87JRVph6NcubeYCNYbPvF5XXl7utSGJ
 DICB8VUoC1e5100qCY2XDRjVWVrIOVJiLT8hLwRbmEzMLRjC5yX410cSKjuiRClh7xqZq1yZE3L
 +EU36l+T7kjRA4Q==
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

