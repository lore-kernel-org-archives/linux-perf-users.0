Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A725CC74;
	Sat, 10 May 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889957; cv=none; b=Sk7bRx/hlt1SqA8zS2ewhKImxAbY+dgA6dqLU74qN8DJcVWmr6Hwp6DMTZRaMujg6T1uuw9sP1gp4nhoEjqu5k9r6J67EaTNOW8Up6pWiexAGazjGi7JRov9ootAP17u4l4NdnWKUagrxGu4J9xb5CkNFugPyZyjjfQ2/EBArUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889957; c=relaxed/simple;
	bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VujQOGwrweQLsqkonCZ0olEaRuqEbUHvEedM93LL9u8r+UjuOHfnK6SorfImZCXu6ynK8SMpVQuzGPlzFjV31YK7c9Dv/yyBwv3sSc8mZRU/V4aFDSHioQZV1FKm7ndFqTwz7PR5wehQDWgPmpyIWlHBJm/ODLse6mmswclNjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgKK+kub; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgKK+kub"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-740b3a18e26so2469841b3a.2;
        Sat, 10 May 2025 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889955; x=1747494755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=GgKK+kubVtg5iE0Qu0CJaHdFPM7CfIV8v166itiW7XDOjnmeXuIsMCCGHHiywbzUbj
         kmvGOjLn1MYpvjig4Cij1zb/XD0cptHJEQUmWmh1fNNlPc8knrjyYm1LTF03MlrcSezt
         nLuCn9z8UWCgCuP4uY7YdGP5GHxmb19ySrXj1Y96g0EbC7ObFjMTAMZ/mxqlaNzVa7bD
         Olu4YnbhYAfm20YV1D3hzaA/lwcHTghOm/bJ8TaMJ0l22Phf/odEnR5TZr7FMciy+WEG
         gwQCT+P+EZKA+Xbomef2BEdd5m97viK4wLlmwM1HQJGp6sLRhfYstnym8U1TS0vrW16t
         a4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889955; x=1747494755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=sHHB3iuDRXAvcxrm5tv0lb544PLVuGWYqeBJPW9+ba8LYWYE5KcrEhD9I2uAWYeVCV
         B16ld4OircY0a0j+0uS81Bf5iDb6sGMZQhvSMPN3OO/WEc7m2rpiXRUinIvxj3TQ+Ln7
         3u0tXicSiKEkz2rc4QF7TlGjLOSUlOkGV2Y+gN9JYW/FeeOJyRbSkjaNxW2MvSaiUvV+
         NENguLIAqIr/IpVEVv0zvszhe+LMw4JuL+4C9WoP+X2kJI/7lq1lkSBSv9MYH5In8UDS
         EwxGk9MTtHwIynrSHajMfCi7h2Wp1P6JfCWfN409hZdWM/MF8kG+ZU0s+qtptQahz3m5
         CpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIfNsbVQCBpHbICPPRM5G8De/FlwMMx5ST5Zmy6CWm4RoNCqiNGcVovv7BASHJpuDFN15qFWAl2GlJB/vf@vger.kernel.org, AJvYcCUj0mkBugsTHZejC1my8vTLtdrnoF+5IOV76Mzk9p2k+zuh8xjNfX67M/3Ivc5g5DGOVnVnQ1svnsLdpwzlzkTM0g==@vger.kernel.org, AJvYcCXgbZs3IV+HDm2z8XnDFYSNAai5VjdVI+WDeQOZyuXk4ujH2wVtXbfzG6dAVIU4dN25cVRqewO+vJbM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwzu21VtA3i09hBL3eMhdHTIMZBdOpz7WsHHFfcHN9w3L6jl6e
	u/PZjXXudOS8Zp9Mj4J1qmYa5X7HUl0EVucZsFyteMMCp01pdImt
X-Gm-Gg: ASbGncsBLne7BGvJCtajZLw6NjF03XJvlWI7lwr7umcEIwTEKgcIzTu5iw+qbbcOAOp
	vIFe10dnkOZ1ENEjdFXjn/C171bu98LXq6+Zder6j8IUbFwNRR43kM4/cUIfES365cC0LPqfyxL
	1Xxqc4P6Hif52DyoUrPp6yvAah9Pf+dGNfd+aHVfaUm5s9IL2fhLflaMfV1lSH40QpWyCJI3Qlh
	5jYIZhjo8Zw8M7L8IdsgRREGxyFFnKwqmQ+VLhi4Df8gkW1bJEIw08RFD0zXbLqE+knGg5mj8aj
	cHFS5QeyQY8v5FqSuqVce8w/JAccMARyg5Nhu/kVkx1MFAbShY3BIg==
X-Google-Smtp-Source: AGHT+IFtT46gV79vplSRnTNjRcV6VyD0gjugvAu28DSlS5zdUyZuWrk5PiENyazvHXLpdDQYOK/V2w==
X-Received: by 2002:a05:6a00:802:b0:736:4110:5579 with SMTP id d2e1a72fcca58-7423bc02f2cmr9779057b3a.2.1746889955645;
        Sat, 10 May 2025 08:12:35 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:11:01 +0800
Subject: [PATCH v7 20/21] arm64: dts: apple: t8012: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-20-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2ycJM0T+aDWIJbJWermJ+AjpVyqLgXvTkY+T
 fMhQWkGt7WJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9snAAKCRABygi3psUI
 JLiMD/45EuS0n/6yTHNsSOa6lVCy/KV6z2Zk4JNxPI37jcvxmnSjlKGwTx7Hrg+1Vg6dzj+YAWq
 1cKhgtT+3dA9YU5NQinJIFf1S/KtAM7uIygOfyT1DaztAxcHNrjlPl32Qsjpz68fUnCWEXRtSb6
 Xb+hX5d77aj5RtYYS5nLzEz/XTmD3Lwm7KpEUrDnSTYtODpTW37DvwZGj47MIkJT1VPM0F2R5kj
 Mh2eLLpScv+GCSU8ONXP7qwbM5/0V1Y2cYHe6gxM21Yhr4cnM00p8VMqjWBDL+cv76tWAD9iFjh
 DiU9NXXHf4vm/ctnYJtOZFuiLTPPkj5qDuFLv0nhwmxGDODZMdnj4fc11E3xjhiNgbH1Thr+QNt
 6qACz4PEEqYYzYX6CynTRmvCsUi2vg/+3DZgXX6q6GMz/zaKqDFNcSpxj8hrp21eF87LuRv8GVt
 /vCqLCT07xCO7GQ1PkC2Buvp0vpIEeLcAz6ohIDaFZhfG5zWBh0xf89GQdHn7OyODh8wIFLsVlc
 Qud81zVKqlZhHuBgJGiE7yG4N19+IF/4ILaQsW76If4YzekV25qOi+QdEDu977V9i8VViPKExdq
 hSU1bXY5WhjXdK7qAq56cVx1sHioZXEa2JeYdEmcQPgbTyi94Ncx+tDGCkzDH0WRf4EzgtTnobv
 2e7IwMvoblab9WA==
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

