Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4F355024
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988750; cv=none; b=NW2p+fpjhyyo+8p/fHkQ6Rl0l6hC3Q9j58ERIvu1XmiSpFvEyOVWP+SBz6vqyawCk+wfzSa9niZ3JamawP4OYdXnMMIJjDMn1eY1LPQeljm+TN/iJuf4FRzTRwLGGcD/Y2E+p1lgWsepVFVRNJIhwOYvO2zqSADSpyFv1DTG/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988750; c=relaxed/simple;
	bh=trWVfDATm/MwjZ2+dtjuGYhC7m5DG/4DEiwR1Jy0uIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLJd6MoWcKcIWeGUL2lrsxK45BsVii43vE6axr9+0ye0Wzo5k1xPVvhQ4mlruNrPZapcjbOvkZ9Cdhk9kui+bBQLlf9OM++EZhPsB4ff9KOnQaJJW14naVPqJcXtZ/FfwBxSDhqfYXqI2LYxt0UjWpU1EM8sFdWI4zxfRtddi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnkWn/XZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnkWn/XZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a137692691so25997565ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988746; x=1766593546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tdOFnD1zwwXEjmETrN68s5mUpHoY1S7934/U4qRcoA=;
        b=UnkWn/XZKH7cYlAQo7wqthOg5lsmkQ/9ppfEy+5bDPB9oikc4eMIRGT/O8MaddWv73
         KGk9tRsAn68WY2ZRi2xSCNVIHds/CCuku4y3nS77Ez6UBdvxJ17piwJNQcLJvAGL9jMt
         vsvg5WEt+cNNp33NDC5ammEpdWrALjnM09CbJxiuRvOp9gY9fEg4u4z8ISPomVei8JuI
         0UKeYB2OpQbIX5foQxKsXrkhBIBzfai8YV7VCc81NM/zkyl0sUPH8c+c1hZ8rJh6+LRv
         5wbs2nNw7dEs7O+xo1QYCec4epXmhtIVQEVuCLxQ6cq0FYMfpSOXAOs38R9IY412wVFd
         SqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988746; x=1766593546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tdOFnD1zwwXEjmETrN68s5mUpHoY1S7934/U4qRcoA=;
        b=d+b6nTLYxnjeB+Zw70GpFh+ORhVvEV3gfR2keVX59xNd0LYgXAgb933oZgTzLqdROz
         u3vwjzr4xkpbjXScdXdbIiQuTefkbzLodgtZM/HFAQM6bA7Mg4qf1RV2qJ17Zqy4G4Gh
         J1WjwCLGv18eJB43p6ubtzQ9K1fMOdi+113/NcssryTcAwGdoRPeV508ROmJiOFcqTrU
         ny7G325K6MazOIwlG13nDNqjmJU1aUxRG40+Rh4Tx1RU90a6WNNIX30aJwm0/LEM8RZ8
         U/Xo0RwdU4c5kpWLprNjNLhVBt+nrt5+iTri8+ttXhjVlBJdrFTPNcJKxz/MTyhC5J3N
         hsrg==
X-Forwarded-Encrypted: i=1; AJvYcCUcneucBCz2Y/GufcvN9GIs7iRNbo/fdt3FEBDlg4yzzQ+Gj+Bp2ZxM3kt6i/8BJ34ID8W+W1w2BQZqrptxUTVj@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxA7oxkLeW5A+UNg+9/gUPKa+uL/r0KAzryh6AZC1SjDfZbR4
	ILQBY1dKTeJ8STJ1/dqRvyYJBrAHy7Mrvai6NAGSh2NgEm3Q19yqMrG9
X-Gm-Gg: AY/fxX4W9Dcrbbpl2Ml5Cy7wvrJI/tqhX1vUUFYDupt7OO0phyzGz3ZdB2PAdAZcGPP
	CZX4+Hj/hLb3WPe4M7Vq6F8xp5KXxCREsDRobRMl56OYtm9o457aSwTIH0Iz61X3k/8g6nPMe9U
	4fUfosxkHkQuv6To9hvToROTaZU45UQv4GGlssXxlVCW6JXmpRpiXqR/V5ILxSdWeoVp5VTxy7w
	7IyjjqY+3iG42PFvqZOLQe4HFuSkimmURNI3zNiLtidyPU01uOC3OxbEQi4aRBO/k1WAukOE8l0
	ahZkdu0EzYk9KnU0Pd8iuLU9+/JDj4sjZtMz1m3OGvwKMk62aoUz0pZVynH9iUjU7/mODLv3lKI
	RHzb9fV7rrUBYnhngM5tUizjN7/BWogeddMz88wqqu2MaHcUha6MvDDQiNJbNmcpRDNb0AnDB8D
	lA+onmha6lNfQj
X-Google-Smtp-Source: AGHT+IFBX13bhHK6lVyBJcGkQoq1Msyy8h0DAZFFCMfV5WBxQlT2ggVro0V5kiEjXJT6j3aN8My8FA==
X-Received: by 2002:a17:902:e548:b0:2a1:243:94a5 with SMTP id d9443c01a7336-2a1024396f5mr116797365ad.47.1765988746077;
        Wed, 17 Dec 2025 08:25:46 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:45 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:34 +0800
Subject: [PATCH v9 21/21] arm64: dts: apple: t8015: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-21-4deadbe65d03@gmail.com>
References: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
In-Reply-To: <20251218-apple-cpmu-v9-0-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=trWVfDATm/MwjZ2+dtjuGYhC7m5DG/4DEiwR1Jy0uIU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlDl3Gr08qJF2sX03JXifmuERFH4Oin2bn6V
 wXHH3PV7m+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQwAKCRABygi3psUI
 JNloEACKdtSR87e3pm0WecNFLB74uVTymD0eUkSwWkpCvJcS2bmrw6+uuPU5wdZQPIG+9akuhu8
 CSJdjD8jVGg8Fjx8u0Q2t38B9sCeW2heVblCjUOE9+tzx67P5DEBDaJPZxslQKpHGKRQcK7lx/b
 ETG3jDDCvTM8KV1iOT800Uxa1rRgm0hR0sP4tXTH/2Bxm6Xz/VWrDL13LcClv+e3eFOaOMZo7gy
 3wUoc4T1OypNKPayCDGbNzIcq9yeS94JpKxttdQefstDpXfzg5BFIE1kxXH5MZBu+axOLGVMyxR
 sMI8t4WLX27fYULPcY0/D0BiBKEranqFuWPcJMwOjpPNKBOc30qC9wdCrOME+gBLvHHPSek4SLJ
 lSPFwkKl7DNXVh92w84z3ehNHnzkl8rnJE0R2pMefLtxD0kThbHsSXuv1vKZW1WLvQZMhixc9+K
 xE4yQjIqVRkSD9/w+qLHbwuBNPD7gofTW4tzprVc3PwCLTbNEhBvAPdj6zPNJ/8UfXLn/bNmMaU
 ntJUB4NrWZjhG07Dxa0dGV2DnZVQjJNwYOqreNF64kxBrQWYEWnWs2oUB51xhyE0mHnh7BIp3I2
 cB/NB0PYZo/Y4WRfOLfYzXTHxkSOq8q0bsk4vnHJaGNFOmgN/QxF4N+iGs7LqUu0VE6lqPMMuUn
 A72HON61PR2Kjzg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 586d3cf1f3751d9ee23262e55fd692bfee86c13f..0c1ebab56d6b36ed5362a042ecb6cecef7c97f64 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -341,6 +341,18 @@ aic: interrupt-controller@232100000 {
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
@@ -530,6 +542,18 @@ timer {
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
2.52.0

