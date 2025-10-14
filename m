Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13D30276A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454323; cv=none; b=BG56aibH4FVgwIzn6mydmSKysHLBZBFifPbowy1g32FVPNI/J413BqTBJt6/AlynSfjt9W5wXL/zO0VQTAplFEHQ2+O3Pl4LGVnnT4q237TnR/7SpvFqwFTUzZu/rRuHqCc4F97f1Con1I51JOSqtH4NTyYSr1MUNAHpFxgWeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454323; c=relaxed/simple;
	bh=q41LAG04mQN+h/yjsDMGUnk4+iW5c6zrOTH+jcEbjrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWLZHVOPD+FtED+faroevNOZMQr+3flxDLiDzAty5uN19nYqWKg2zFOXqFj/VnG0M/CtI+i+YXxJPHtIIznusksnITErX3Y4wAGCBrFFJzv8T5hccQVCHN/wgpPP1OAU1OvImIRY4NxlzL0GEt5zcRktt66uafFv91KmYw/cJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsP1gdb2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsP1gdb2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4903130a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454319; x=1761059119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1i7iqUxmgg/DXwXQpNr1KmCqr3Rj4mhCflPyxgc9Us=;
        b=IsP1gdb2wTXS79BtDxR/L7vOm02xs47qA36vLtxaqrB3oPX5Wnb8XDb/sa2lEk4hbN
         /lAaBOrJdKWU//gSmTHFiMwjUcaYXo7RVdNI9tI77urF9jHHEs18cfgpKjaUxQehP2x3
         QwIV3RczK+Y5/bJ45KVpKscxh94Rh9jnBSIsIkPuglM1CeabYTcK1/dY/AzebGvRnCX6
         TJ66ftDR7WYNMmLlnaiOxgIraXGmwltdhmgGMdFj1wXpmHbNd09lj52ADes1dBSSSY1s
         ODpFIJJRc7GmdGdfJgTOwnBX2g+RWLmIUHjbJb8goTVx/9Ql4kGmAbs03UYA5JPqntOT
         SDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454320; x=1761059120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1i7iqUxmgg/DXwXQpNr1KmCqr3Rj4mhCflPyxgc9Us=;
        b=j/4LkyN7ae0ScIcAcdtglZZWCLSlCFZ7+w0FJ778KGL0ydE+aLOLsxRym1pcomTKzy
         s10EYyhSjSXtgnlju8jbbZSk4s1F/Idqr3iy/lLhsg8O6ASDCwLuyx6i6qMaGslJF2CX
         uV5+dFMtoS8Z+onEF2CfQwtIBtRdGJLOELRjMBzCXVKbrWrzCdO+QYCyZC0DB1yo+nXO
         7cqg1ACIcHKP/w3CpkorO+argbE1YvKxsfZrwIRETpeeJ3VRHBgbeRxVZu3EVXyTCvVu
         hFz7JitJppgiVDEFwWIofjDz6W7xlSGb7jqeCyyfZ9LnRd377GNtSqiCrUPlzIHVKsBI
         GtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVKXejvtKaVmkR2TFDLWq2FpOYjG6Pj0WJBo57Ri2umWirGQbv5BsttkiRkLvV1bUmQ23eG8YkGkDZpVDgUZGQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LOFKfmqXO5gX+7kLeOBWd8knygdv9ke2XbAUgR10/z7ZmHqY
	/FTmnLtFtodRvqEY8vh+JS1tWlEYSC1/fbUiIV0tuc55JUxWVu9QG4Wv
X-Gm-Gg: ASbGnctr9aGyYwNReijPhbVdvx61FDzMB/RBAKX0MufvflXFSJqww3SVWeWFZWFQ8gK
	C54i+WlMf1FxUp83hm6twTbq4l6XbcGBO0BLtQG7tYNAy4sUjRJ+rVt/AKcO8H8kBUpuDj0qV92
	sB0K3GoYQ8NyU4SA0Np60l/KrRIzOEKzk4p7+qpyuIYI4hoIGgrIhi3XZM2znA/gWgNDdRrZ41J
	zOTbha6Iwh2Tx7k93JpwqiIMRiy5H75keMEwDIqrEON8r98nVbDAOLVqJAjGZHdEaDByu5VpFYC
	A1IDigfstuZPzI7YzdGc4dqlDOhpm6CZnb0uWpS7eYzThHj9u0YyRqrvD4Z4gekJvfH39SmOCHL
	Hvq4UGkF3prbqXS8600thy4gDCk2c6oC8jh9TOYCWANzWqr++ySITrg==
X-Google-Smtp-Source: AGHT+IGxU1aUYANixpQW6+RfJwrDQsy0lpaNBp+StZI5SmcT71Y9IkZbC/eBjms/hpV0Ia1TiVCOIQ==
X-Received: by 2002:a17:90b:1c81:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-33b513be2c9mr33511721a91.35.1760454319490;
        Tue, 14 Oct 2025 08:05:19 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:50 +0800
Subject: [PATCH RESEND v8 17/21] arm64: dts: apple: s8001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-17-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=q41LAG04mQN+h/yjsDMGUnk4+iW5c6zrOTH+jcEbjrs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZuq26ljD+z+Y6MIqkOiTRV6L4Hn+JOROQ9G
 KHaTtZDhTiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JAyjD/wPsIPDTqdU23/DJv1noYw4bjYDPRNP+6mTAR6BfTFdSrVMb87GTXJiFVLJA/BdtCdKYUE
 G7yhhrNCrXaschGxzuQ8ryViFpkYgEEZvKlUWMpqBfhaoK0OO66J+qne8ZNvAShnVwoXXLZauBx
 rajcv0TGz6krDyTimriCyB4cbKzvB4Q7pgyz0MdtaH0JTRWxODkrZh//gPjVdYy4TNPmnlSGsEf
 WVYVHhLdKOQZAXRDXqRwIJWugYgYKodtn7P+0aEYAUBv8sTQ8MqprSnglNZBfnNHhxp2hTE5id2
 PeuQQ+nV2v05y5J3A20srKU1MBsNZzXCq3zKuSUzlPQADPsNJXSdLOmfBF7qhDKJjaDRMpu7VMc
 cHZJnplzhOz4tRc3u39wPE4Uby3q8ks/mDy4s1HzaGwkFt0IQeXIdWe/pwuK3s0gnEtFkkGZboI
 ZPRpXp3D27UByUNRylPxQ6mcnqFIKExaekyf+oL30EpcEruYJif8e0jpYzxWVg5kg4je0eMs/Ms
 EcMDV2RTzujgVfyFjFZkL8uFEEdwNaLEFB7semPfrdcEUKE71Un8A+qjevZfDxfV3Xpw/XVQL9S
 IJRRkb1FohBVPqW0Hz0odA6o7Owk8RluXHygcYYAr3Wnxq3Z7dlrHRP/vBjweGnxtwBWToOGDm9
 R0So6USZLiD2QLQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index fee3507658948a9b4db6a185665fdff9f5acc446..ee2702fc807b678023915f72b5276cc5a31e1222 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -222,6 +222,14 @@ timer {
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
2.51.0

