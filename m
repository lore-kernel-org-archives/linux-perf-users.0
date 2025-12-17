Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA834E75E
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988736; cv=none; b=L+2Fwwu3j8nALgG3+anLZACufH8MYCTuCvLbDHrNqfbdcmXgWcTndLYvPAVycONoDNbdB5EGCwjOSZxoXG5jR8d/hYaj1v63Tao0SGj7o2grljOAO4f/LDiML/mcEE6sis0KTN2RQlDyJWmOcHW78MxB0kM2l0Yzb43JLJVeRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988736; c=relaxed/simple;
	bh=PzJR4btrOIgWAbbA9/PgDRkfL56Q2zFHfShoVsaxiHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omhALoyhOuAx+AcOM0PSyFyxuk6R8m0IoOpv8W0+Vj9dQgOC72MaTC7EiDWoT6OVXMAQFv+UhcML0fscUsKvBuEWsbkoMXIy+cffMZgCrmGoiwJp74zqYXgDl5s4l1BGh4sXxqOQPyqh6Ud+0y+ShXAObfkUserQt7sblHciszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToqtRQib; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToqtRQib"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a1360e1392so20302775ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988733; x=1766593533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XIbviOhDk9tWhSGjjMU+OiN82Iat2rqIxD675mZ2oo=;
        b=ToqtRQibqMmA9O1DdB655aJT9j+NOr/M4pkiCWbl6z47U7Drzm55HotSVw4jyzAyEj
         oG1gPp2Am1R0q0HHh4w90GXdTBnc285SxIe6aytCzJkpDvTr9/QRVxVrYr2WkxRuoIb+
         VzdJgDnMl+5LiRnm5kNtdnRYjZKMHJgy+N9cmAtQitr088OZSPtYodxB9ssfmThRUBlA
         1YI0dbEyLJ+niV8QUe4/aRsBZ4X6h9zPZ7ZmC0d53Or/AnSd3TjvLogZjrCr+FSyxeGy
         WO1cBrx4ulkwp70IvZOA4gevVqIy3IJbDc6DJp/u+J+UQOx4LkDiZG1HPr7OR3SkgGtA
         rItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988733; x=1766593533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XIbviOhDk9tWhSGjjMU+OiN82Iat2rqIxD675mZ2oo=;
        b=MIppCyydyAgfXIy1LRet7bPOaqTq9dghRC9iCWo3G9atpBCT+HF5l4VyqZhroAUF2B
         fAIEnvkQiWslUsgVJ5sZ6kenNRiqD+HBIt/F6TsPwylEh8yK3DjhlW/VwdAxBKQr0whv
         nUIGD6JMmTbOebLabk2EBFrmmQGFU2dEqXOlCllSeCGyNoSaLzlnSUlVKBGhdQQHch85
         NcNzNUFOU2W7A3JKAE2iZlaxkOi+efxPcrkqC7qCltALLYRR9TWp6al8JdOO0AWXJHuh
         IxadaeVn6C1hKjdcAb44ElqwBM8Tz9lHUm1w7oeABz8KCCJR4jrGUqEQMMgslDPojsKb
         F2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr13kS6GnHRZ7tsmewG+Nk2Fy8VkpAKqK2ZCDTOq/1lInAGaJhdAbedLI+h+Gucb6SNfC6r/J0RjEx5JlzzpGR@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpLexYj19HrTITblbhnAtuBvst0Bs75xc8AVD0AdWVG1OGdK/
	C4XO0ElCUro4RLk+s0Jh22NEgk6Gr1PH5QXcYrSbEMHSxHI+q3Qz+Els
X-Gm-Gg: AY/fxX4rhJFszVJEksDRQS1oiFXUtX5eADihL23Elp56hJsYcu3VKbYaAPPfmLszVEg
	zQQav0jiZqGllNXLBgOTkJGFXXQJHmxnq+2UukkFDEz5XeJ9wF1nLxS9yoDAX4bD/i/gg/hyPJb
	laQ3nmxRfGmapbXZ3WbHbtotl7+SoLdhZEW+RnTssa85vpBukrHZcpgRJFbDz6r+UfZlG6niCgT
	0AvFJXwlf/p4T7WKRWXlqfjEME5Xl1gOqi+cK38VyR+t0meRFEjIVjfdZcc6woCvqysDqPT/8Us
	ZE08ia2QU6jA/cWFHYRALI/D289vJhuV5DAf2ejyJP59J+gHYH/uhW47OzWyA3i0RTEZD1pG8gB
	we3YsDFQFx+hlE03v+hKh1k5xRMCOBwBa4EYZ7mlbxOUFpsbzpmaCmRV8ZeIzfNQ2IQjs0T8MkH
	JtE4tNTlZlLE4rqeBYDlDYPjU=
X-Google-Smtp-Source: AGHT+IFWcAl2eDJLxZCIcaifcs1mNO/2r3sxH7mEEr1iZiQh6yjVgtkLQjrhGVLNZjs2M6eo4amITw==
X-Received: by 2002:a17:902:db08:b0:2a0:f0e5:9468 with SMTP id d9443c01a7336-2a0f0e597c9mr105953605ad.32.1765988733320;
        Wed, 17 Dec 2025 08:25:33 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a0b0687c62sm122980415ad.88.2025.12.17.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:25:32 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 18 Dec 2025 00:23:30 +0800
Subject: [PATCH v9 17/21] arm64: dts: apple: s8001: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-apple-cpmu-v9-17-4deadbe65d03@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=PzJR4btrOIgWAbbA9/PgDRkfL56Q2zFHfShoVsaxiHQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBpQtlC18frqHrWhi62ycOZTQzFYElAtT3Uwm0CD
 IaXXMI0j++JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaULZQgAKCRABygi3psUI
 JNATEACn01v27AmuZVEofWUCxDzFsb920+rtnSrQ8l32muph5xC9coNw8T6bCYcDAwiPtDlfs6m
 /4SQvgpQoMAXxUd4HrCz3m8UKruDmVLOed4fFRje/PU18xUyzwWlweBTZDVbZzf5wKvLwTiBFqn
 2epA+tLbEi2kpSoyc59zMYv89FfoAN4EIEeULAePwCeTMxDT+0JCcfcPl+b6CSrzaZgf64SnyAA
 lhHBUIF6tHU9ruCWPqwk5Nrb9SHN1NgxdOC63Vla+HsFYc+GMqawJgvCP5AUiZju6sQfPIdvngD
 4aMSddwWxID9hSD0kwWH7F7RkDD9N1EwJBJR7x7YI4/X1lAgf1REiES5b8A3kB3j8QB/J0cFrFM
 agu/2DGetmXyT5qPZyR9FLV3pOUUZszvmy5Ch4bvWd/aktds4UGJt7HPnyrkJgzGFlMhkfMThjp
 B1+MNLbRG4enS1qpNxIrKN7rWbNnatkHgxbOAFO+RJCyW5ek5w29o5/r442NTNSK/MgK1JB5dxN
 lmQ7qHiJZMjf2DS87FHgvVeNI1KzeJsx19AB/h7vPN92sveEQ0KdQH0Jtx+pOOlhK2yjpP010SP
 bN8kt4pyhSbTGbulgl1ffdEvUgA9OSKgeCdUPI0Qt9oKuzgeDSqtRkg8eCP90fjUX6E/zNiHXcg
 djIbLrDiSNYJvfQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index b5b00dca6ffa4caa1d504860693da001a8ced80e..83c5c479c87fc1ae1bb7c6889aed9a71fb55d29c 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -298,6 +298,14 @@ timer {
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
2.52.0

