Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760972E2666;
	Mon, 11 Aug 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920621; cv=none; b=KDdzatypnIdMCBABry5sLRbCvZcEOZ/ddkWQCOO3YTW4NOOvV8uxjDH850brgzw2Yn2vf5Tur5H5BBqAy8cGwm5tN7r9hQ79w7wY+yvRFCRvOzoYR79SonxZJfca8Sf15djUprjP89NcGdWEyadyf0zsn27XmEUf08c3NBd0ZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920621; c=relaxed/simple;
	bh=GdMW0EI3NHNWYzWITffq+4XFB8Q0kMqjZtAqZZLmfYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=re4C9jBafDCbGMdJnjdnLug27izPaDlQltg+CvFJWPrEo0V1fxAMtqf0/n+k+0+/k+EQS123WyOEFh8s9R4vc3Hpov6NigH8N5ekmdmF/0A0QwkKWU0GJPnhKbEmkHQ7JKVcizSq4VTrVD49UXE7VxhnjVcM2GmGdBut7aOdeMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG88wIe/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG88wIe/"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so2847752a12.1;
        Mon, 11 Aug 2025 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920619; x=1755525419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvqlPWZhSdmmiWIigJMbDMqEPBNiuGmslU3U6YrJSzM=;
        b=iG88wIe/ojFLwUx0tuDB0Nu67do1Nwmnb3D7qDTPuTQQiXEyPX34YoGJlr5hOKJPD7
         Piya+Hc1EM/qwMZKUzlIoNLDpMTB2jAHHrSvlQ4a560N+wKfKDrYIvpGtBn29dJfU88a
         G2bHmEt0heSUMMi3XNbbjyx2eKt7iqbICq5eISeCExL+rYKuqFc5u7MHkn/RGSAtSkoi
         ZGElptHMLz5XKQd139Q8JTldNvCgkN6fhSdZGW+woTQALZ2QSQq3z0cIjReWiOUlFeCb
         GUnvrTm8goJmIAkxEOduZpPWbF6ug0aAyBRYwDNPpfgmmIMdgSjwVG+sDTpLCOESy33U
         TbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920619; x=1755525419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvqlPWZhSdmmiWIigJMbDMqEPBNiuGmslU3U6YrJSzM=;
        b=v0RuDxasw7ofQYZQZA1D49XgP4dlXYOMdHiJOXWNu+9+cA4wQE2Gzx5EEWVcU1gZkw
         hJSDJdV2sz5wB5g9P25GbkXMkAdxD1PTKj6kqDsSpDyXFrRFHfDUUjxqbtb2Q2uWbLaH
         belL+O/U04bYerHujUAb+hs4sCc4VR+KvxuEXYd6a6HgKENbd7IkV7cosPhPghlA+9rC
         bP+OK9tM/DVSM8RkDCjgiYn5VSJu9yGDHPAxyNUfPW2LpjCo4BYYCPWMYYFvyugM1bR7
         /Z7QEF67Bzq5i8s9vaxWrV6Va/V3sjScrVi9QHGUXk1DkxgXGaBG3ktb5mQtZ7cI//vo
         7Gxw==
X-Forwarded-Encrypted: i=1; AJvYcCVIZH111gffNvW61TjTcwl4SKKJkQ6Z1s+QtG6XwoBnZ10T1ClWhMtepJocJrV5DX1lii6kYygNqbdL@vger.kernel.org, AJvYcCWY7QyEg2OVuD2Y6Bm5w/Qp71TrBA/56UJwj1qCF2lM51VCEwJYJflsCkQth8b9d99IaqzPRG9am3uHe77P@vger.kernel.org, AJvYcCXkcD4w4BPAbUTqmnqjG84oHimdvfQKgYI+EasfhhLSmIGrp8rVofZONB8qmNkI2U6mve7YVZ1VskRHStDUpQ6/Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlN4p1JXaEcPgvox2TQZika/NnuTgjCDgOTl7AtgEzfBDwTxm
	OKWNI4wX46pg8VanzKSXF4bX6nsQYrxQcVjz7+GebSmH3nXW9Q4V7MM8
X-Gm-Gg: ASbGncveFqxEDKItTnZr4scBcGamMX0uI670cezsOTxEW72k12xej8ViGxm6OId2eI0
	OM4M91RZbFkAVMDbrbR7qfak9oJb1r33U5YL7rvwMqgetuI0LDEQhX2Dh082vyMxY+y6HJgesph
	vYqxVTzRwJahTbFmX2SsXgZ4hBzYjSW9nVVx+/NK014n3vOtv/zQnXpf1y6bVa1n2e7UKdVAeaW
	Z9MXni+T9gsAECCvL9E0wfAGJuBkrw7Hw8YrMGdiC/AZFRUkmLEuxKyUsUKDJBEe9aM/fs6VCnr
	zaL/WV3Al1qy5J8DoUnSGVlPpFGdkbe77PJZryYRK386amNKXuB7WIwGelRLQ69df3F7vAiEhpB
	KL+kbHsW30+M6BponkaHDWLZmEDWMl8Wd+ezoET8ZULb1Fwo=
X-Google-Smtp-Source: AGHT+IEsZJ5knQTrKEOjLGhLHALuJ8dOClagIoc9Tqof/fNLEY7nfP5yw4HDIQc+QGY8+JZrhHKDsg==
X-Received: by 2002:a17:903:2310:b0:234:d431:ec6e with SMTP id d9443c01a7336-242c1ffcf60mr188601795ad.3.1754920619514;
        Mon, 11 Aug 2025 06:56:59 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm23585496a12.56.2025.08.11.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:56:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:54:53 +0800
Subject: [PATCH v8 21/21] arm64: dts: apple: t8015: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-apple-cpmu-v8-21-c560ebd9ca46@gmail.com>
References: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
In-Reply-To: <20250811-apple-cpmu-v8-0-c560ebd9ca46@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=GdMW0EI3NHNWYzWITffq+4XFB8Q0kMqjZtAqZZLmfYU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfZDmmr/1Q/2JTNVlaKiZKNOFPyBC3d7E7Vt6
 4mnI2+zy56JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn2QwAKCRABygi3psUI
 JExGD/9OkeFtQH+ZC/vyytS7PXJmuvmPxNfmDu6U0St+yQce7QtoCz0Hjo1q0rGhX8jmGit9Ex7
 k/pTldefDseg+/A2BusnYnfNnFSpFaT/6aNUDHDnw+D8ytRf4k3bJyk5SLD6Gzii7R/YSIJQbvM
 j0BUzrfkvSeCgteMUVB9q2sNXDYXYzcy26IXVvyOY6q23GAY+icge4aBGxqUTDjommhs5gvfGLS
 XseKSzF3wZXjqz6MMb1JWsQr6RzHmjVdR1uBW1uHTcfzzri5B+xUKDoPNpx9hmsy6hqj1YcdYHQ
 yK9yJmFoJ8odHHfAzc+yU/Z7jCnbbEVIVuP0+MtY4DusP9+KQXE8oAL9sTxbmDXl36gjmv4KPY7
 uWnPaWvwzRfgqrrAjVWW0xY44DX+zxb25vKFOKpC58aW35SQiHYjm0JP3PxKIy1dZjSSgDg89FO
 JQTq102JSsRBkubQFd4Yw5IGJgHCA2yekAg4KvF8CkZ9Tqk7RcW3ITD7OvCe+EexBMwZYy2ZXzi
 ulxk6MthAl7ZyFWr/E36TdCz9OZWnscCs6REORxOt+b2/9VrGRdpvCv2RdIrpCS20X34UvXHS6E
 U8ePNjBW7+mq/IQibeih0n98a1rsymlgDjH4K1HAXS/W/7MpdPZoVNbG2Th1AoBC+5CLsWJqYYX
 kImyKMr0LMMykrw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..9bf5157f0e504b7394ef5354411d3d37e8d5760a 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -284,6 +284,18 @@ aic: interrupt-controller@232100000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu_e0 &cpu_e1 &cpu_e2 &cpu_e3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu_p0 &cpu_p1>;
+				};
+			};
 		};
 
 		pmgr: power-management@232000000 {
@@ -412,6 +424,18 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu-e {
+		compatible = "apple,mistral-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,monsoon-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 #include "t8015-pmgr.dtsi"

-- 
2.50.1

