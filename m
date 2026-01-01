Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51032BD035
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258229; cv=none; b=OZqo4TsSRokwNj1/7J8utjHxrLB3QgIfsHOO8kXcOiE2sE5w09y/twIX2bK7XrnR8FPy2koyMzXeDC/QDkrn9BLqdBR5bXlwi2bsRMO4Vp3d8kxeWyQ27QngbnlGk5z+2JPrj5kEaG4PHJryj5DVpVW6V5w81FdY4JsSjTMXsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258229; c=relaxed/simple;
	bh=trWVfDATm/MwjZ2+dtjuGYhC7m5DG/4DEiwR1Jy0uIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnemhFafqeOB//HjTM2NxWxolEGTqSXg6SSKyIxvbDFHtwkydtK2mzU/MSENh7yrMME8tvhu2GpRnXlxM/U3XoUE4mp8Aipy7mBYCGys0YZuUBAnofs35B/LLqIw0g0cZ8vjXviQ9pR6/+KESc76F/T7fp+mzMLMQ37lNf4OXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCw9p/Bl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCw9p/Bl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso15256102b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767258227; x=1767863027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tdOFnD1zwwXEjmETrN68s5mUpHoY1S7934/U4qRcoA=;
        b=BCw9p/Bl03ryIMzjgJtxF3kXGb7L4t3I7Jy/tj8SMtIVhXevn4gFwU65ADp/OhRu69
         S3vxky+VZMO8MCSBmXRHrap1dCAsrUvQXoor5TB2aBAHdc3UpFx8n0DapAaY4jZHkkwS
         Zf072HJR/PGnmz2zHVjiQEeTJuG1V+A+8uRSccF1E1Y0den7XHvYCZPwmR73M1H87hdJ
         Ova4H3DuCE6gAHKKqQ58l3bzx+ryw0vXr9/sQtyP5eOpN8hjELAHlkL7lFBpoS+Eup0y
         GamgGMfh9oDMrk4WasBe1jbgm+iZtlUB3wsKnZXhacpV6P0ZZBvw40SlfcdlCJaTm4Lx
         QlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258227; x=1767863027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tdOFnD1zwwXEjmETrN68s5mUpHoY1S7934/U4qRcoA=;
        b=UpUYNvOz7T6I98CCFNH+43/ZTPCD0nUdjh6TAEnYhkvPGITE+qMCatIiGyGBsVf+z+
         KebJOmpyqXQIk633Avt2GInhz8qWHtIjIeMasFk5dix91zqXYFZkvq26A38C+r+t+uEi
         /mmbF8UDx0aYCSV76X5hNmBRjt2zSpuZ3uYUkMZhzaHqHg3NjbIKCi7ozHQiMyZEGzVv
         +L0+4upI5wksuAJqf8udKuIebHLOZIqklPVOKSjPxIuWKr1qohEhudAv7JIj4uXynRGy
         +7tLdsusFtvDpuoPLpdjxKJm6Crf0MtMBF87GXwGllRQ4t0AeShD4pq7xEKxzaoi1hE4
         c3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc57J2xYB3yADnKyXRd5qUO6Lq1q/0N5nw6edTJmwWt9k1ZhD9GEw6otd82cDzDHU0NL1Gq39Q0vpeQ4wNOWay@vger.kernel.org
X-Gm-Message-State: AOJu0YyFglF8a7FJ4uuvhFYm5bi0VqJ1fImJ25mwywKMazI5EGUI+/jq
	ntZ3xe44QYhQVh3ALagRSOJpM8pRH2A2wYxMRp59jpdJwxprLKdOWWUV
X-Gm-Gg: AY/fxX4hpMuoquUPaYGdEf56pBVQKjtPS9UCWyzz9Fpt5qVSADucW0x32JkHpWbh6zr
	lpsbtONgz2Yl7TbwSDsuF1fRQsUwV2PTFHzhmt+1geF8JyojXhzzxJcei0wt2QSCRnWliLpk7Yw
	TeuL29gJphEtqwqMLOm48b7n9i0F2UmYh0oI1djhEUWNrP/f4QZBX3Vok4U0UAJOX73UFevUKm5
	Xun9chD8RJaERqloF8zLY5t9wnXIYFqFL5zSYkZ7/gSet1ANXy3jpbTu1sYCiodh03yiDF9ZMBu
	Cuj9y07bKN0Iu4VRTM1nESBjqhGnXtJWIMTMdU6lTh/PyWKKStpdesNOrQHvUmB5+djVBQQB9A0
	KCNSh5wJ9jo/JkgeqLx9g/pCSWKcSDVYTQNy5M+lwu/zf8tWakzeY05FEXE5LQPfz8Wf8aBws5/
	Okq7Ugnc17sfjb
X-Google-Smtp-Source: AGHT+IHO9HLDqLnxGqMh+mxYDWViv1/O3WqdN3+qFILp62mk/kOweAuJA1AZ8e4wVoEHoRWOZ+prQQ==
X-Received: by 2002:a05:6a00:90a2:b0:7e8:4433:8fa2 with SMTP id d2e1a72fcca58-7ff6607bcddmr39960635b3a.42.1767258227104;
        Thu, 01 Jan 2026 01:03:47 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm37182957b3a.39.2026.01.01.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:03:46 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 01 Jan 2026 17:01:57 +0800
Subject: [PATCH v10 21/21] arm64: dts: apple: t8015: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-apple-cpmu-v10-21-48812c529ffc@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=trWVfDATm/MwjZ2+dtjuGYhC7m5DG/4DEiwR1Jy0uIU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpVjgpSfeNnDDFSIT2Vc+1Lesv6jNsQYcFQYur4
 OGMFS8dLn+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaVY4KQAKCRABygi3psUI
 JKgdD/48Oa+AjeAoAVsrpKQTk4o35ek0CzqaxUwDuPnoOwbkEgFd9Gv9cAbMM2eks5VybrHunJz
 e5NYXyt9bxOKT51Lq+Xkyro8ixG0EQrPItJKj8ckf/yA6Jitm7fikoHiQXc3PkUC/MuJkNcEV+6
 blmxnWxOsdxt2pbkxVBVk1ywud8xwITHXftKf/OZ+gUCWOaHgWXUEdZ++zxDCGn6G7BB2FNPBSj
 3RMWYElEv3m00UtjLwOVegeF+9LQYasHUjckXbFLoDBXqSmwvyBSHP1MurONsa28XQry5VlBHku
 LSF50dJsLChEaxClORGyiVsFvBMlI/WRnnym0EyqYwAHLZ2KLfqLvqsJndKpbF7RXdfbTuC/r5G
 1v8Xz9KfWik/7JJ4vmnSMoAVJ8EwE5XkckvZYUPt3k2hC0FUS+YOro/8fPOs6kev4KJv2XpZXJI
 cE0NhDyB0MfSclFPKZBzb5frmfVGA0+PIUwXEZjHsirGsdOhbLBDQq+ZIxuUiqfUsP1X5bs1Ohh
 evZE9VP8zemVg8jruE9jT8nqu3Ve2kw5+w3T4X+spL84wVi5lGnMmxefqyfyXFSNJxhvwM1nBf9
 bXvbE7sVJts4ECdTCJlZg3epyUkjmC8R7apIijQZJb7EQj9R3wCtCysNsWW3UgUOqmeE3BDJ6i9
 YG47wDhWWBmbfUQ==
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

