Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122924E019;
	Sat, 10 May 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889961; cv=none; b=V/YySCLCNR9Rzd17a3b9MTRSvss1yqG9Zy97dlmcxR1ZnLayxdW2sRbBW7JICKoyhQMwDj9onw2ccO3rNy+Og44pQXg+drbvavzLo7fJun+nWoCYe0S3N71wUjdq+d6ZgYAve7Pis9eB3vIhlelTQDfjTmm0kXTauF633gp/b3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889961; c=relaxed/simple;
	bh=ZHoXysjC3tKjwBhupXya9t0tvevKJFeLclU2Q2P4acg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/eyY0LrB4nldVqGQJMltPe3lakoGTB0k8NxWlnH5XpQ8KjqnOmPtxnhdev+78MiEsPs3AhyluVgOaqHsfqa/R6UiZlgLgnoGAoBfT5KlTRlPEzsNbf2d3ZOQYrymXkFBk1hlZUPNQyIOcHaA1qvz65PwZXHMeDS33Vbq597SlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb0e8h2I; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb0e8h2I"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af51596da56so2540605a12.0;
        Sat, 10 May 2025 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889959; x=1747494759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgYxG+vTxBAlApfr9OfPBfVTpSGem7njEO/S/STMqlg=;
        b=fb0e8h2Irc+MV79f5aM0zUBpBdXxtnwugzIbNoiIhk0UViecQcuHAzWTeJFOlHBB1n
         iVzrLHEO7cWdzatgC0ftR3cAdbTKLVI8YwR245HIkOex7SJiSu0hQEkesyD7u6wxozty
         AzV6h+grnhWyYVo2wtBvtoLdTyCGqVsK+oSZ6YVrGmCnfwOPZl7Eke7zKobYs6wWC8mC
         OeVFbsVvTaK3wIMC0TT0IMgvKEHjGHsCqdvd90/Nbij1iu0rQ71/tJ6v8iEyCSYCXvY9
         ZjYOw+MBWNIrY6IC5StIKxtr3iwsopKR0vUh/td6oKTwoLbD3G4617Redgr0mUPUaTwm
         DS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889959; x=1747494759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgYxG+vTxBAlApfr9OfPBfVTpSGem7njEO/S/STMqlg=;
        b=ag6vlDJJqCMxiYdZlItFPwpw5xkaQl3kA3p9xEH+sPh+VCVw+pMlzRnBTG86SLEWjH
         JOP7bF6fbeHMnFmdx6yb252cNlBKfeaZ7By/0jSUCgKPgrxdLZ60xAfuD8QiQhhBmvxB
         hzlXr1aE8JvinbIKD9oRdx8NfJS+q8wLvOR8tusdsXkl9ZOKYIlNn8Wo9wa9WWI/XBDV
         V5bVgW6isvp/Ucy8udOcpgVriEg5xuhRXfqG2Kw5Sf0pqerQOHprjy8y1XVlr1yS5m7o
         j4XktMb641Eh4l6PFa1z305oWoxl69uKPgx/MqzJIKAGgYqGA8oT/yyiz/iQbwpvdrgU
         9yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHvJQ1H47ZDNOry/3Iv9SEbB+Hq4dGVug7G0ASOi5jP5CZx+NHLMlpr5jL/dDZkeIiZGDF5muwVGWyx1dzUnbd6Q==@vger.kernel.org, AJvYcCXF4kPH9XkEXVwOYHmJem0wt8y9aCPzQir+GM6ig3dzM8NKz37Qq5rNQXA/TQdHmwC8HyS6wBHAizLenWE5@vger.kernel.org, AJvYcCXl+tL1EY8dUi3ibElF/lFMjiNkYd/MqodcP5odi3Ual1rZUy9ZD1KS66GHpMHeo1TZo1MyreL5JaXM@vger.kernel.org
X-Gm-Message-State: AOJu0YxuA9Fnj9aYiEKIbRiCPE5d63aZRKxDLfZLlQHbuYFxXBSZaiQX
	MLRU9gOFGbLbGmcqAb9b5azwCFZK3nfhj32e7kDPzqXvu42JaEXj
X-Gm-Gg: ASbGncv+96r73o9twBQnf0fTjqQ2cIqBi9eCWGwY2o5WKMh6FEOqQYtMtN0JHMO933S
	sdk7tau21seG/YMdVW5EMlNOfRJyDt7M8Qy76u9jyf4duM+PiEhViWLz93mW40g8BpaxYjxRYqP
	ieUMiw+AFjXyDQwlN8n9piVRZqUVAfr6XvPKNYehrfco5UdyF21ASaAoPKb8//qB8e51EdaXgTs
	6QYlIDJkBNLaKsMiukmLrBvliKm+XcEAzfdjxQ6hSlPkV+jjRaAdPbZzVmGLGVbJC7x4twDxKu+
	MH576AkOwVCaVLS9bXUczNeAdaPABL25Nm7L9FrovRy1fEC+Zm77Xw==
X-Google-Smtp-Source: AGHT+IGsbdop8plBHpcmpnMxKCFGsNL9XJ5fPzAac6FXRl20VRiIJR/5u5O/hLTD0QEvnuaKLrsa8A==
X-Received: by 2002:a17:902:e84d:b0:22e:8183:1fae with SMTP id d9443c01a7336-22fc8e94b54mr114728855ad.41.1746889958989;
        Sat, 10 May 2025 08:12:38 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:12:38 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:11:02 +0800
Subject: [PATCH v7 21/21] arm64: dts: apple: t8015: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-21-bd505cb6c520@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZHoXysjC3tKjwBhupXya9t0tvevKJFeLclU2Q2P4acg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yduqtId3KunRw3JTc76ysraowG5U1aETUds
 MsXaefV0bOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9snQAKCRABygi3psUI
 JJ7ZD/9u11yUrcdGe9PhCwIpTccxOS51IX1XGrdagHrb1ZM3v+9lN4qeWlTrMOxBuROK4/nXWIH
 RIsz9GiQ+g/CCHfwPIS3FcjN72VgWIpwIAPfqgecQJDdWPcRYdm1bIkTv97/dmNwE/MFpyJP+tc
 yxR8s+nThG7coTj3wBo9tgft7eZRKJbkkB80TcacuCnzhHWZ2V6XqmFCAA5/PKI7Acl+tknBlSJ
 XXnBQ6y47hDMuxvGCWzy5izaStC5gqTSMjiaDA9d6QOzDHyc8pyXi3eOChsoUzoWSQ37ckcXzoa
 75qmgBw0CS5HwT5WhOaw8dl3Z1uTs/DUBCY973H+Vrm0BhUmv5knuoluH9fmoQUQUSM6cQ6DmpM
 O8BRUbOWVhMrdwRhOWIsrWq3IPoVbot1g9szKn9x/qHwpxbhjy4ToxS1SV8ajaS2OPDtpo0V8V3
 zeMsXe+9UaInXhwydyy1yCkB7WHmq7S85EYmA/yx6PmvtoY7Wz/57ZtBxvFp9kNv1/bIP3VaOeC
 y8gZj8hoCqGXM5uwv/cq+p0KgdNOpgACTlcRmJj2Wu0/51H6Kf+fxdDUln7UPeDggFz/YRbIHpy
 ZOYFxLYFvsPA7vqClpoRIXE3Ai/qiNuimeDeTod5UqNeHn1ZinnfgapBR/fspmBf93n4k1L9T52
 0d3mNZ7vF8d9zGw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 4d54afcecd50b50ed1fd386ccfc46c373e190e6b..e838b65ea63eef9c198032ee87e63dae282141dc 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -252,6 +252,18 @@ aic: interrupt-controller@232100000 {
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
@@ -380,6 +392,18 @@ timer {
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
2.49.0

