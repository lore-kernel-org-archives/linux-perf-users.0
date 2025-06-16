Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E71D5CE8;
	Mon, 16 Jun 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037539; cv=none; b=skFRu1PUJ4vC/m86Bv9Hqtg9SzzPx5Ams/eWrdV5/0dX6A4h4EmOCitQ7YA2VTXcCYbYqpmyD4cIf3DkaMzxL23ybeP7QXruw/evaoqlgKJJA7jdj3mQPUxMGBJW4MLKEtRyhEdHKqJA4nuSAx4qDIRjQ/H46WLbkrSCk+rHl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037539; c=relaxed/simple;
	bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eb87VVR6ozmtnZJuP5P3SMjENqslbOkVwB6VTDJVT9rKY9yjyDzVmaDHbrT/A5giZBcQz5y/syxJl9UrnrKetOluWxwV0Viz/rcxfSiExmrB4N66TmvFeOYjnyL4rwEOCBy/xNq3xM8I4vtZEICALLS9PX1QsGyuhwpFG8lELtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPMaD+O5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPMaD+O5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-879d2e419b9so3845505a12.2;
        Sun, 15 Jun 2025 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037537; x=1750642337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=SPMaD+O5H+rxCz1pdqGhe3PP04ASLioUMgEOsrDD+ycyCOxWluuNkc2+2CtsoKvVbn
         9Iy2fbJsT4BS8K2PWP9F2B1xRKPH8ev7UOUIR+ElSs6dx7uZvDIo+tCjFnXie5dLdLws
         E1tVkKzs8SVrLZ6ul/gnxwuSWmK1yhVtHJaMjmRkY3b8x5wrj3NLgPjehGb6TpF1L9Id
         HiIznxwNVDl3fHkMaYtv3BsKlenrczSgtLMXed6CHMbCCYOaIstnHuuJ8slP6RwAXcdZ
         gBjpJOEdVcigeFtt348iiRqTSc1deVEpflp6AKCgMGj4+zt63HC6QHliuC2LYCjTjon2
         y31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037537; x=1750642337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=bDyeDtAUoHtnFKhR/CM8cQut7K0xukNJjUtefUIrSJcjPCVENS7TvGrDtEshY8/ID7
         GW3calEMlUlR3Jfnf+bhA/rMxJB0ioxfX335yj2Iu9GefYONiOV3zxk1rCnkBaQYHWkh
         xuE5K9z6qMIeI3S8m/HCZKUg/auiC5v3Y0KyKg2gIsjDsnI4wlfGKietPa0pMnS/+eek
         DDBCYy6rRh0LMfJzQGt6DtLIOrD/FvJj2cPUQEmwqyekVigRLezK53XY5EIcTo6c/lg1
         ccZok50NmMTrR95I3oTs66wjMdTOAVsl3R7ivwoUoRIRjFenJOXzl6C+Ng94nKl+In8p
         2KPA==
X-Forwarded-Encrypted: i=1; AJvYcCVGKe+MTtaY3lKWJj3opanSpTt86/gg3u1mx9dMxKY+uggEX2RvinMd2pJi253a4CaZMwOz0bizTYXqzE5dXxf92g==@vger.kernel.org, AJvYcCWbCjHd78StuAGV4EDKYR83V6od5xxyyy4PW+HkONc/5c4AapUCP72lsrxy1Wbxkf5TEId/MT4+VZjzuC6A@vger.kernel.org, AJvYcCXBphJdpTqFTZ7MGSHJsVJyaoJ/DYkPkJOfsiFGNBFg903cnn+y5GLE1caFMqWnOZmwMKSk3tMiiDjb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Bjn8tCczIcpBy3keDn9BWb7PR8OMiMoXFS5XULW+WjusXNzH
	zOUwLSFjcKYiGADGTJj8DNEquuXOai40Nd6cqYqFMzTrnLtkriKb9T/ec+KtKQ==
X-Gm-Gg: ASbGncv2BRaQ9AcDSXZlbkcljhgHAsiJ+dL6hb57vNhmMqYmxqgm+J7WDX/WHxNAjLt
	oH4PF6A4EGpPPnMD4B1msIUp5mNDTlwkruOrvrZACp2Gccxu1kaofTpll4DILk9pICyUIkaCRiy
	AiDlibwB4f4K3ZCyvD/BmIgxT16w9a54cXYJxqLS9ZRlIhPLyU5snGj/kvH2mCqQJeAois3p1I0
	y+8X6WHnoRyzaNNTPWSwmq4Tk43me0xg8SoA62Meu1aEFHjxs6WcVqX9q+GkuInhBl0n/Vh/w8/
	pxyoeuOq/W9FY9xD3MZbmegE/gkwszpjenrAnuF3xof1uHYId52pzm4FPUL38NeMfwTt5N5YdNB
	h8K8=
X-Google-Smtp-Source: AGHT+IHnMNfnqXTp6Aj/xELzIdpeSj8LKeXBoMYdtG8441pLPUzGR7YY1kIXXs+VLtmWy5GJJl3aUw==
X-Received: by 2002:a17:90b:4cc3:b0:310:8d4a:a246 with SMTP id 98e67ed59e1d1-313f1be1b4emr10012442a91.1.1750037537105;
        Sun, 15 Jun 2025 18:32:17 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:32:16 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:31:50 +0800
Subject: [PATCH RESEND v7 01/21] dt-bindings: arm: pmu: Add Apple A7-A11
 SoC CPU PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-1-df2778a44d5c@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QWWYtTwzjULiP8DN/cykkj8vIJnCQuzptdA
 wB0U7qCg2eJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90FgAKCRABygi3psUI
 JKGMD/wNuXF+G2au4+kmN+zz5CA9eusCR5mJrXaUgqBwXLIAhdK1VbIPFbzNq8aIhWZNaIR2LJ1
 Cs7ZBp621+xZcQR28XuzEaKw7Ox0dGiPCJXzly8Wf2MJa8HJ3jqM6Ire1VHY9t2OZy9ABQm+v7Q
 4k7lFtb08JD0zVxirPai4hCRMGNYw/xwqLaT8TOJGHty1h8Ey8pilXqZC4A4ZXT2MFSNZYETAqS
 8y78dzOqZft8374UVUNYIo1goOda1I5qhMzQREEeAb1C3IcQTGc8qJ+ZL8VJZQ4L/rGXp0Y3Q0a
 v75LTeZwMSLRfQk+vQUZ22ZTGzplind+KoZPBLKx2G4qen8Sh0uOa5hz92Lie7jGxWMROhS5IpS
 kCiHsWa+OT76WPKMPNxau0di3gCWcASaLC7fp8V6m6kM+9nP3ijUs3CoKLELyWtiXMDZZR9VmpZ
 NNOY86Rg71RRzf6xAVzRoz1iPNu8zckEUitVsqcn1OemQrqV8NSXWtSj+h79agd4VEcBWUS5wpc
 m5hfFlJX08GpGy+06Gg6xiPFWEb0VRakWOfOKI+Oh6B1SfjKLxUCisRT5RwLuHbflcW6j6deRoz
 QguGWcRE0QqHpMhNsHo8wBbibJ/bWe+HT3vxq6nrl3LTIjeTc9d5PZmHNzV4bxy7YLuVMGGjV1w
 s2EAD/cmCvA5xeA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 295963a3cae799a54560557137dd6b3cf4bd00f9..3726e1b78c42f150cf1dc68a6b3aa3541517c311 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,14 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,cyclone-pmu
           - apple,firestorm-pmu
+          - apple,fusion-pmu
           - apple,icestorm-pmu
+          - apple,monsoon-pmu
+          - apple,mistral-pmu
+          - apple,twister-pmu
+          - apple,typhoon-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.49.0

