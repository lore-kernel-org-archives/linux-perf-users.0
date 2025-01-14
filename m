Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E676225A26
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895517; cv=none; b=KOydlYfTS6H9iJC+6l+nxmeBi+ksxeQYJatJUqeCYPWIvIB3pM1q/vys7xUUnWFP6Bf3SGoxIRM2r5xIVEGky0kkOuXN3H8wu3PNoCmXCoEDVSz1hHsRXshUpnPlCCFSXfQzVLDW+vEKFeC99cP+DeSBnbqz3ma2EkhIf89ilSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895517; c=relaxed/simple;
	bh=M17AKGnLSOGsyrsPp58PAylY7BhMnNO/WhD7kYk69x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f21456/rR/SMs0hOr1WlEGVnqAlyHbDTAiP333cH51aGG6kqE/N4Orzzepz9tCNyPSOpWGTu/wtvOU86/izyn3RYW0DdOQ3ryC21tVLcrKqwk0F8s2mkcJ6IZzXFszfbukT4VQvu0G1pk8Xt/Wriv4U46EB9+8xqaCDwB7XPR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w2fdmRb0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w2fdmRb0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21661be2c2dso106851035ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895515; x=1737500315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSUuZKac707LuCWRbpc/uEIITHPwqnfXyOde6qyF0KE=;
        b=w2fdmRb0Lu6O/+NCmizugEoN0b4vuHppXLbHX3zKiMlKvVgfqw4D5ocqt9mPMCxnYw
         Tb1TBRTlG2mZ/96iHmZNJZW/BvAj2DVsC6d2uUzapn1FjGRLeQJrK4AF8ZpNVCmFwjvG
         D9940gLMuewRCPwDUc/R3BR3IhrDpJdkfhWv/xjVdakwkZfKFxdHewYc/WOQf8tYAe7I
         tOWQ1IxNtusPbBC762pn5j2BGAJgAZAECssK5wxjEm02KjBOX1c2+UJeznb5mPAn3vMb
         pZB9UulZxhlZcE/zDzXawsLzGaZN2iF7GUbPxr740tmS9Qk3vRSWLlwqHFqqX/PfUI+V
         yZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895515; x=1737500315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSUuZKac707LuCWRbpc/uEIITHPwqnfXyOde6qyF0KE=;
        b=DQYlxUMbJbGo+OfXUATyZSs7pfQhe3pV8C2PgA0pFXsg/2p0JUP7WC8GjUOoPhsbm3
         DhbNBO/bxd2WnZqdsekwZZvKimgN0SQu0W3iFK+oK6VcrdCqya99VUVbqhNX5iSIlx5e
         LkZWSXfTAqi5rUdo7rJe1A+lr2j+9v37BjF4e9zY3Ul+JuOiJjt+FTA4WtyTpx97Gfo7
         xM0hViAcRN3RY9cByxFFsA8aqzlQu5Je2aze0DfOgYQjBOjEeBjQY5VQTxvEoNpU1bfa
         uSGe5oMvgYCyHHVN0IheE552Q4HuBg+AL557ESKtvT2F1/nS4voo9lubhIE765z/ctHL
         oZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUXUC32S7fX6HH51dCAqudsDT5C15YRnttPcO+mjIhDkZrbK8q7e+7/Mti9/at8C/95AhC5VFAJ+PHuiCkxq9Xv@vger.kernel.org
X-Gm-Message-State: AOJu0YxhsJgGP9FFmLRrM/b6JE4gbGnYf+5CUEmwlXobkSU8bEN4OvDz
	fz3zV0LVa0oeRIBVZW2GS5pqpLzX4oJUaqu2zs2ZdK9GSaqGSKplfLJE4zvRmng=
X-Gm-Gg: ASbGncv3F7MWmlWVdKMwv5ivEvKUEFxZCNVZ5U0Teq+6Ooi7QwMcqg7dKJOp5NiM2l4
	DmzSr7+bGfJkD4vT0fVebmVDPgx6zhj3l7ZD6Xfnqfx0RZz840dPjGXxLL3KwZY7sNOdJ3GJ8xR
	ClEE9spa6QAFsQWrRyMw+TOWBrKI2rIqwnwKRnewQkL3rOaVcVKqbywCWIsvPc5xQoODET8MxgD
	x2NeoF2APDAUu2cDCWVDeGvaAVYBBu5Pbl5YrW2/3H3uI/HAsTi8nCn0dv/gCGWBg7ExQ==
X-Google-Smtp-Source: AGHT+IEVXqMvOPJKvg7ygF7bUQZEZYrWqGn1DZ1M4rQTQIthH3shh5ppL8RzzhsKIbon/t/bsr22sw==
X-Received: by 2002:a17:903:41c3:b0:216:6590:d472 with SMTP id d9443c01a7336-21a83f4e4f8mr388644205ad.21.1736895515542;
        Tue, 14 Jan 2025 14:58:35 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:34 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:35 -0800
Subject: [PATCH v2 10/21] dt-bindings: riscv: add Smcntrpmf ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-10-8ba74cdb851b@rivosinc.com>
References: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
In-Reply-To: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Add the description for Smcntrpmf ISA extension

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index c8685fb1fb42..848354e3048f 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -135,6 +135,13 @@ properties:
 	    directlyi accessible in the supervisor mode. This extension depend
 	    on Sscsrind, Zihpm, Zicntr extensions.
 
+	- const: smcntrpmf
+	  description: |
+	    The standard Smcntrpmf supervisor-level extension for the machine mode
+	    to enable privilege mode filtering for cycle and instret counters.
+	    The Ssccfg extension depends on this as *cfg CSRs are available only
+	    if smcntrpmf is present.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as

-- 
2.34.1

