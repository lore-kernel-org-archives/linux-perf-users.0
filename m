Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537A286D4D;
	Mon, 16 Jun 2025 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037606; cv=none; b=QRsyysMtEmqReYPiYfQ5YkV7B78bDxSb4CG0GKxfeRzbRyTqlch7zu0pxwsCgaAWMGgPBZxEPBPr+yU8ybMyeITABT5QZUAe0ptm3ofuE4eFB0M8dq5KXYSiUKu70SCPkxFGd81guguHQAZfdAXMDFkRg0u5x6tCrbDr9AmRH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037606; c=relaxed/simple;
	bh=ZHoXysjC3tKjwBhupXya9t0tvevKJFeLclU2Q2P4acg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uuxi57DgibEzsKJtjMXHXn/Dhz0BZrAwjWgPt7xj4xrlhsrhgaExgF5Q/cR0vU4QT8jqDBHbxsGbncl1cU/n7ljrHtBiiYBhe/bdcckcKZN8IWnCKTxHrI+J4OOjZlepBdGRjgzrGY+wAWqy0E++DZdtcr4pYdsSoS5LRzrnNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Edz4Zy2y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edz4Zy2y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350fc2591dso35520875ad.1;
        Sun, 15 Jun 2025 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037603; x=1750642403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgYxG+vTxBAlApfr9OfPBfVTpSGem7njEO/S/STMqlg=;
        b=Edz4Zy2yEYL21vk1ZbO6Jcs4wPg9w7iC0mv81RL3Cw7iwRjt/54kdt6YM2WD7yaOFy
         dQpH9xoAglBfJTfbHT8NgcbjuG/SWa6yN4y2O/Qgcso1gVsoCXwx5HYDgduQZ8abamAj
         Ori9EGSWZQf2ELLjm3l7jjcRcJxN0+7UcDiGPZUqnegE0IgHqL3borqnsTAR/SmdoftW
         LrVi6IghcGgsf2jl9KVZYHhpCsSjqFjLRhX03xZ6WD8e9HNw9ljxVjEUWABzcpOlO9x3
         guIhZrHYvSRVqGbUvZmEJI/ao7GKFfJjDF/HErATEauUsmUk9ZrtccCvYvkMvAt9TwNC
         T3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037603; x=1750642403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgYxG+vTxBAlApfr9OfPBfVTpSGem7njEO/S/STMqlg=;
        b=MQMZDtuZA/YZRJoWKhOE49nL2WX4XoI0KLOQaTDla9VjD8ddkkfan2Emdzs+hgK3If
         capTVlr9nluT0Z9YB+g24wCkyCj+Arh9OT0eCMo/iGwhhGJxJoCTZAa5rqrhHKW8jYU8
         RAm7s0hCrfmlzbgt05grHAFbQVk6Vo77Ncwa8Xef2z0b6Xphbsq6fotufqQfaEPKr/i0
         2z+3yp21xvxtdEKYXrJPp83CUqAUEz4wmW9fJnV3BuGIYSo0QNp93+ILvP+cNyi/zmIT
         /4uZ6tXTR+9m+0EG/ayq4jhVa21WiT/Z8cpWhW6aKqzj/r98VZQ479mSKf8y0j62GSAA
         BGqw==
X-Forwarded-Encrypted: i=1; AJvYcCUW/28eOu+s/yi4T083H2WSe2llbX61HwpdJXIR31Lmx2MkDe6uqz2Yw9xrcK8+iEJp9N2+mTL29Bf9@vger.kernel.org, AJvYcCWP8CHmItJ7KThpugL4Lh7rQnAyeWTkP/vfXOX5jXWqlwTyAYmCtCbEIjqU9xOgb4ngOROBlz7TdtwNPvF6tvvfnA==@vger.kernel.org, AJvYcCXp7rWekdjtssc2AtMsCwKgZ4dSSG+JHRXYQhbPI34FGjrknn+2vcxX4Gex9cOymTGy3Ba2rHP1HwaVkWok@vger.kernel.org
X-Gm-Message-State: AOJu0YxioWVvSpJxokcMhjk9dPURPcqAr5hTqgTyVeKWXukmkON2fqUm
	ZloO9M52uCAsQnkGzlTf/Pbns+B+c3RrZinRimbU+4Y/aKT6gq/njKAtCOQUbA==
X-Gm-Gg: ASbGncvlrYd+wv0tdDtCcKaNWjpgGuSbx9mNnfsD6E00ivMKw4LdoeXTmKsOs7+N3sr
	HcElv+ylfDBcOxDLbMJT1KTPJBiKz5tWfJzUYsUOzgqAmg/RA3AJSp0eFLPFdF89y9CtSAbsrjN
	F9Y9eSYTBCJTl3juuU22Suc1HBvPj9hy7BpSwPiTr6PjyPz8Kr7NAz7owhRGtm0N6oi8RyZJsCH
	14SwR+4tl3r/YYQTAPAJk6HX4NwT1NrLTi+e4hLCQAONYdFOw24vPzWfzoLSTru5VexcIT7pB/I
	UZfdBAnjyucIXyIwZliQ0RP2AlHt9duU6txuuua0HNnsGrdM0InNru2RLSlJCE1oH+6SUWNl1uU
	CpS4=
X-Google-Smtp-Source: AGHT+IGUNE394ORxjIh9GhaDQ4I3KqTxb9FUPwuTUfcms2kv5CaO57PXeF2Ec3A96Ssb2JDXBhtDnA==
X-Received: by 2002:a17:902:ec8b:b0:215:b1e3:c051 with SMTP id d9443c01a7336-2366ae0ddedmr101009925ad.11.1750037603347;
        Sun, 15 Jun 2025 18:33:23 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:23 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:10 +0800
Subject: [PATCH RESEND v7 21/21] arm64: dts: apple: t8015: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-21-df2778a44d5c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=ZHoXysjC3tKjwBhupXya9t0tvevKJFeLclU2Q2P4acg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QaSXqCudX2xRA+ssME3ry+rfSTxP+sC1MrC
 ixnxG3HfLWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GgAKCRABygi3psUI
 JADEEAC3bkcdx2hB1A0jAuE+jQT0MTVLry1QJzypyt7uDz/cbauH5T0Flh6NufBZjPuPF/Sv2Mb
 rD4RMil6Ax3YXWBc1aL+j8zwQdq8wRFn1XvphQyCVzPcG7GEckhipulqj7Okfn9ORpTNI9VZNY/
 geWfae2fnK0yc5UUtGz50C6/QAysifrAjrAefbV9XGSW6b7sYyXXlISwB6nqfCt8A/c5y9Kpk6Y
 BXEgeqiP1Sb4UYQXBBIxj2ycsYYbRr7pWWsmqVrk9CGOEmYKZ79qQG4uYjzZNI2/GPFkMTzaeSF
 GWbX51uX2Y8WGyzuqHJrUGRMHx0cvSK/YUUuNW1RppphZPWHTYGOEDFfw1gPod3NPjMueLg739Y
 6rXnPWEEXwdfMluXd/qpa/ZS5pDnDnMNnjqZep2Ya3LNOyvnhBCBqIoL4mOF1NAQiAhtTrOvVtf
 Z1TgtrYc8zZoa+1NgT21fugtO25LVSxXRbtPBP3E6hGz2BhG1AtqgpFfAsm/ZapQhomR+vxAkcx
 mhk50zGnK45EUy5twAajaN1i9FyMw91eWP/zsdue2J9ILg4FYTZ90km9mi5Ln7268c0vR2fThMU
 L5ayeXeJbFaFMHgMkyBWIdNe5fJDPc8e12T+KwnErz7hevAZknTP+1m2G0FYXTVn5z4M0RmiaB0
 BbO6+1HlUNipYpg==
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

