Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2926658B;
	Fri, 14 Feb 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543434; cv=none; b=jZ1Hk0KnBig5iV4McewjGxUrqVXupGHTV4cNY2lgh6Cs1bSJCaJEe8EaY+aPxAuHIuJiO/p6vfFo+gjniygLIiwytoZyVAZxRelQ7PYkhQRVQ+pFoTa7ci4qqcWyOf9jX0qvkPvp+QGM/FsIYalCsfHKV3agI9oiYmvsbk8elGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543434; c=relaxed/simple;
	bh=IvblILNfK65nRmNXFfVq27lzQtZVkqPdlXpIO65Xo5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KG6HuEwsPYgmrjkJLiq+KDYdAF84tmxE374sdJELanqA7WgeF+R3NSKebgSlwPvJsx5nTQK7jpTBOLQ0G9PgTi2dSxg0m4Q1KWWJaDU6pvxJPPWX/TD84IvJ569+iDd7PmZINJCy9RblS1rvn7SiI4Fkunvpid8pVf+rDuLCNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfriy/Nc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfriy/Nc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ecbdb4c2so24581915ad.3;
        Fri, 14 Feb 2025 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543432; x=1740148232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vprohxk3JreCnU/aMQ3Cwcsm8vUQGIhxwt5YLfMxZE=;
        b=jfriy/Nc2AlePV/NU/Umy3tKfRNAMtjbPY+JyrwCV8jTf7qoAeRV/wm1Pt8OmTWXTs
         FZIf2zseTji36jZ+31nKXYHQl3kOBSunWYBjMM8Sd2WZ+uxsTPVAio23eLv4C6x40PRR
         o4mxNKUheoPqTPh908JxKEbr4aKBPApkN+qTykaAb66Itmf/UKZcvBYKH+Srxv1I6L4+
         spfRVxhNNzzu1I4x73wSCzxbCuwm4LaSiCZdv/etSl4/A5l68NwdjpO+I1ECoaHylkML
         yp7DXGd1iAOW7wnP7uywe7KjakvmuCNV6VGqewn82CNscj1EPHiWk006aM5Qy3ZcKRtx
         j2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543432; x=1740148232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vprohxk3JreCnU/aMQ3Cwcsm8vUQGIhxwt5YLfMxZE=;
        b=a3RjdobqzGhS3JaJzhUzPD4K/jkhxFrS6qXtTZGaT/MI7sgLbmRCvr4lR3ETV056iO
         RfpwOE3q2ZFLsnXDXeHebXckk4aguM52crYtO+zKaxv7z5QzgfNuY4PgEBMB7bQ2/FcW
         vkdsyzSuvKz9jDIIhzV4sRR+xygcG480rwh1DinQ6GkGiEVwO+jchRdPLQBi8icrjKun
         UKae0Vqet5ukQmK25rFu+17+FWqFxBcIB1TKLVDfpf4JE11S5RAxKQIV1jLVJV3hM02t
         4vGIARKQPAFTs2yZ008iDIsu3Y+dcUMVBJgPd4i2tqPAt46Ln1FG+6CzrhyDjs8eV6Dm
         lBOw==
X-Forwarded-Encrypted: i=1; AJvYcCURXRL+xkiszWeUrxlTC9bhl2MJ6/7xUmltGAw8qaqVlfmeH7EbpSldybaCRXtbVSZ6SUoKQA/rBq6ai+fAD4ptkQ==@vger.kernel.org, AJvYcCWQnrQvAAPtfqheWniYFEyQZ3a2A1LNV5/f6tQN1PqrM4V72mKxw8AAM+n2/YKQYUH4jMcbw42+aaIIzOVZ@vger.kernel.org, AJvYcCXh4I348RuUxYEQo8K3IqYTjZfMHJJmR3iELMLhuWC34In+QV/GXYzy9a36h5eFAU+0kzmCrKGcyNvn@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPE4031jJ6I7dDYsISe5J1hTX/3e/Yu35w/51e/ndyMxUSxUb
	E1zHjG9mghotnj/r0wrkR5a7eNYeNdLnixnFgYytN4eJGLGnjTy7
X-Gm-Gg: ASbGncvJUE3r5+qic3dbjUg9C46WCoN1hTi+vS7lKulxZ9JkXb4KsjwTa7sFKyUm/aK
	61dv/wagZ2vKeK0qdJzO8ge5UWQdqOGb0TPQbOSNZRHBTOO0T3tiiBKx9jRbbVaRfQwcaWHuXvF
	v5CpyXoCl0+kn4Ce/LwgYzbYqb3oF4L08NXtDAxB6MaHFe94EtMLKHk7rZDyIkc2YAMKObwDsZa
	voBFaV2l1kkztaCJLrSfktDX9gQNVAExPcTJSSusQoRLhJLrfOTWZaXlnba4EWR60V+TSjGvE4M
	AnKLU8g1v6+VjtsyTw==
X-Google-Smtp-Source: AGHT+IEu2Hb5pPBgql0J5zrtyu/OArrfmnQCdrNZAsm5tiDRfDCnaHp3/5nPXiG8C9X00s8G8YzcCg==
X-Received: by 2002:a17:902:f68b:b0:21f:1096:7d5 with SMTP id d9443c01a7336-220bbb209camr182567835ad.17.1739543431767;
        Fri, 14 Feb 2025 06:30:31 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:31 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 14 Feb 2025 22:28:27 +0800
Subject: [PATCH v4 01/11] dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU
 PMU compatibles
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-apple-cpmu-v4-1-ffca0e45147e@gmail.com>
References: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
In-Reply-To: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=IvblILNfK65nRmNXFfVq27lzQtZVkqPdlXpIO65Xo5E=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1N/3AiQ60M/18EKguryDnvFSc8EpDOxgVFQn
 WnGb5RK8MaJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TfwAKCRABygi3psUI
 JN7YD/4zOhnKwP/8gjH/iYxy8EzNHBKW4M0lhDY1BbC3KPoAx+9ZuPGLOH70VB7T6F7r8IawTxc
 HCns5b69zzvzgRD80Kzn+qDqbm9EmaD1acIdmdF4s+jdKSWu/ldoW0yBhtfajoqg9tsk+vVUfXU
 2Pg8j9go5VIaACP+7mt9S4PQzambMtsJ9/hA6heFk93g68xUXBlxEbMb5c9SaVz/+7zahh8usyB
 7bwp/2wJvgYLN4uiHdBpxZRYjG0T3G6nV9l1B6gdlSCmnhqQ5uqinPmdPNWsx4jD1UIY6U6eNsL
 xmHkfQa9Ad/DQ3G6qk299EQTPTMMIlGp6LYS8MJ667rwBN5/1gTU/lPniRqO/XHPIbtRoWguK21
 /CLbTPqbUCyiTkFU5o8m5imLiaGTzDJJ23pnvvI+nnrcdKBKb372bOf0miqwtIOeNptuq5RcJF7
 smY9NiKRS7lVHDY0bnYq5kL+0fAzhXnT8h4QkWYqzmAEOY7JamxjYLxnuPzBG9HryytxUJkvYbi
 Vl4mpqp0PUpjD/kIWJsJdtlnqN0ez1YmHYYdqgDdw0jV7bvFG/Yl0y8/6tjRdgFM8HApJzQHPj2
 fiRZ+EBgLkMjCMfv6UqJURbbW0M+PW4eEIaD7cD735Zqk8UZ8DUoEzYZcjWqOMQ0biFiqNu7CIM
 apcGbdemuPN4+JQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index a148ff54f2b8a92fa3fcfa78c1bcc525dba1c6dd..d2e7f19cf6a2d7d2348d163d37c2787c7a36bbd4 100644
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
2.48.1

