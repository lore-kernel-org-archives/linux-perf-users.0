Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708A235076;
	Sat, 10 May 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746889894; cv=none; b=f8qN7qW3Ke1gzYz+ZcsWLhxJj2tYdAy4RqIiYNhg42b3PocHNgKT/KZS7dKaercu6ncpEQWfkjNgjmysSRxpoRMEbtiK4MVGh5JiYltjxgPhppk35gzQ2SzDN/mq84JEzw8R+gx86h+Ff3M5KFglGqReYk7x2DOpZ+HVwGdfQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746889894; c=relaxed/simple;
	bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvRS9cv64Htmd9eHEwv3ihBNx86G6OQllTFUjapyIbodhGM0OsjzixLt1m/ZasywNg8CP2GK0Tm8fYdiKy973mIjh0y8hNOGy2eIxZ0DVbauS8SW6wS/mozoqQd2bLq08Nm8H60pDB4f0Xo003aQVumwzDPe3HULTn6B+mZ7X9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK7Nzyiw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK7Nzyiw"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so2503280a12.0;
        Sat, 10 May 2025 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746889892; x=1747494692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=eK7NzyiwV+u8dihcjSVN3NNDIHh2Mc61okPBFP+/eBYpR85QNiMGftclgg8oojpxuG
         C+hQAgw4HBUcrvfBtVtBDXUmT1W16pfg4Nzuacbt4whWs306z819sJBT+P1KeEgdxl7N
         BIUcok9iztV5iSHdmO3M09nvhIKdLU2VEEUkmhCsdRhjbW6DAzb/D0wln6nSRfdQJvE8
         htNyDGkBi27SxQ5i5EKD2DsjHKJcturPwg18NOpd4OkFmwsZ0cqOJxI54QeAcpwWH/ZU
         rqN6KacTlfWQzXoPeOh6fNxEOr3gstoh56Pgosvlfja+xplpNhiIoAc3CpCiV/cxKzRj
         yADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746889892; x=1747494692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WhR61nr7Ljl2PHcEGBKT0kq+BKIGjpo8813I6tRUqE=;
        b=A0zvlWW5MIs0+O4/mWeMznTMZJTWjXdJlHy9CXw7PNz+vdcE4A28VpNajcfgvw6eOX
         3oeNyKH9vWjt4rhjq2HzFnTfmU9WYqi2VsDAQ+WbbhLEQkXVpg9J7nKP1DBuxw5Olj3K
         VS5MiLIa+0+MVhrCklrOVXjzzvnn3ozQUW2DbUbnaerWgJG4yOeZ4vpBny8IwG4pocFS
         KJIe4HcagIzEJmOpGLHQrmoL/QnaqYCoW29OigwfQDBCDPIUzEHLXhi/NY49xa+AvTYw
         E8YqBOwG4qNFmcHxqMMvMH/KHJJCNcIeVK408YG9xIa/c/yqHt/QXq863TJHzc6svVYB
         Jb7A==
X-Forwarded-Encrypted: i=1; AJvYcCU+dRxfXzMm1e03oIAl0p0tMGuHFppCYTNtn/VAIiKMvhy7Y8bXhN8ejwLfgxoKyox/ByyZmf1JraYSry+Ts+flGg==@vger.kernel.org, AJvYcCUWQ5va1OlWYsAcmFKsgCUNz7Hq5KDy+lWr5X7/mcdIASkzScKOQi8IYfPI2eUkKYuGiFuucQz6o/aitteL@vger.kernel.org, AJvYcCW3uRNF3+n1I8CjMJD24H1tTkO7sDeHuYzc/r+FA8Y3hUuHJLiD613LW57DUcGloqKW/BowB+cS09hr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TQXmEXooLFqkF0++YuquBLc72uGzVKI46BbAqR2uxMR77v3b
	FV0I2Nl5XHdyu4CAN6lXdaNMP2YIi+7fS/BOX7cNar+PBYfMr8QY
X-Gm-Gg: ASbGncuNmA6BLPir+KMIKr/NYrlEfrESAT5sXHt7TCZLIQPWZ+gtmkGb3htHczf9IDS
	f3K/9w0ab8J2i2Kt0bjeJCDAvtnoKNAnqAwhpZUZfvhsMO2OiXycpii2nCUjA/A9gpELZXXchWr
	PGcVFVCRl6AslF746DCpKg3wy7CC4wK5P85Uk2e+oOwDInSMwkukhJx/mbLZ2V2opXkkcPq1H2k
	vbDIs6ZNYuDyLTgxvH3v7moDAG3UyOCu53Vk8lezdC9cCvqKbhefturegZv/lyOTdwaRCsiFxLk
	412kCX0zysyLRiHgbeQvFt6dQ7lrFpkeOpnxudPEsZ6K6d9bATv/2A==
X-Google-Smtp-Source: AGHT+IHrMovLoBYB06/EjKWeBypsMBRxgshoSisDFkycvgWn5VOYB/k1ZbKV4M3dF8qrnRM0Y/GUUA==
X-Received: by 2002:a17:90b:4a4e:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-30c3d2e355emr11285339a91.19.1746889892151;
        Sat, 10 May 2025 08:11:32 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2350ddca3asm2990493a12.58.2025.05.10.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:11:31 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 10 May 2025 23:10:42 +0800
Subject: [PATCH v7 01/21] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-apple-cpmu-v7-1-bd505cb6c520@gmail.com>
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
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=nvc6B3SNJrX+OFSnYkWwiXKVem6neRj112hzdXP5HLQ=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoH2yaA4PzDuDwaa2SwrJCn+pSUhc3vXjTbIK3Y
 ZBYp0Kpu5SJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaB9smgAKCRABygi3psUI
 JJ83EACDDpTag1arv9So+EYN0Rqul10K5q2wzppnkN9JShqvDgPNebEuzwTqkYBwJwUKqiiCFv/
 v6ZsMDt0JXkMPIz3TDaWWApJE0rlXL9sHugoO3WiBMUHPn7U20KF/lwMM7oRYWjfqq88d4SSv/b
 4Z5bhlvE0TpiMvgLPVzbTmkezwgGT2/EB6306pmzdfkpSVXLVyInZgiINknE0nxXnPsEQwxk6TN
 eA2xq2C6W/YFCt6PofdGY28mcf+pUUbFinY49rLOSXQTc2eAPje8PG3tRZ72Sbs9IwM4eQK4yyq
 /aQwSogTYmOPOUiVgsemR1FH1y9951qZibKgs7m54V67S/eXMHJLuaTtTrcd35XFP7MWyrdl34A
 oUXwrHfmreo95V916qgUtBWRe/915JXyytXaQ9cuKXNaY+7F2UQVToTPz5LL1p21FGOeLYIKk/a
 0gcL0+9xkFUGiEn00PtdhXbOzO2ycYS1p2r0cqupvSek89hFdeK4q8IdYITMxiEG8RhMuChews1
 aATU2TY+2GUASVgp0h04fK+WYB6tn89hdEh9B8MMVY0Ah/cg4/GwMbhvPGkOVruMZlQP95OzkUh
 SAFw78LVBhKHYN+udFOYM31qWvFYN8OJj258XdUugMlHNufB2zKN4vXrzjmwksWcDyJ9T12FWG2
 k07olloAlwHGTjQ==
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

