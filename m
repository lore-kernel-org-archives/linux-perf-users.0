Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D222E3E6
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826614; cv=none; b=shPW5bZNnXMrY2xrDmCXICZ62DhbOb3xKWLkkaMD50601u7E6+YF++/DrWtfFNrKsJQRlMLjETYdoAlDJLjnXc3CprI91zjuOUZGQOs42auDq/qv0CYFeyY03Y8AlARbc6uIGICklN1TdA+RyPpbo0teRCy+ADR0ZqHd3t5k1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826614; c=relaxed/simple;
	bh=SZGcyybVo7K7BymyY7cT9hBPC2J7AQxoReUyWoh5bqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjzrfk3w6rTS9Vw470ERvLgJgVUnBVUQQr35q+FArCJXF91dImgPJUaz+441CPqbUe4ndkvmv0i3uFASks7BTmf38hWSOTdj15MboFPtZSWR8cCFvNUL1E3A05nWXaD/m12O0/peQZiK01jpxtROqwV6ip79Jb+Ivv4Xdw1Emlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sfuo5oMe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sfuo5oMe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f20666e72so12263685ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826612; x=1739431412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxHoYiVqgOBhm1wpVoVRMHPjl115bpEgggXMBP5Q3iA=;
        b=sfuo5oMe2mPuc6Qh0aH6nbYrt0D83ceFgFw1rJllq1fTqZ1AOctcDNf6i9QmBPANPE
         1fS9WQQ3PzNtZsyj8FhNfMdZHzFC5pemZhlm81BE22ha5y0+Y3As1uIK6sfQtumnV2q9
         Xi/c3TFuaEEXOmQKtwmh5ejHrfAyuWutNvEXC/yhCejxFfuW4NqG4C5Xcrg0uYyIB8/W
         oGB0e8u5A57HXyWkUFyDU1OxYo8ceTdyCIA0cZmK5eGlDwSM/1stNO44BVbYQW+gCyzt
         h+YQgpTnT/xl0H9xJHh7O0KLELYYRLiy7Tinotm/HvrBQxCAqsUNP9jVWtSv7liibayY
         zQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826612; x=1739431412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxHoYiVqgOBhm1wpVoVRMHPjl115bpEgggXMBP5Q3iA=;
        b=ph7125/zwyHkkzRZ8Sx1G0Zz22ao6C26rl03Zb0501AjFJZOEt7C64PK7QHB839sOG
         1NMi8JlX2NwF3rg16l+4zqes23e7ygKGFrLpuCs2L/jJpDvBX89q+qxxMFpnZt70YlaK
         RE7GJwxyNuU4AbjqoCAsNe/111M3spc/aD2d8oo9rLd5Zje5rNNzjCIysDzEhuvQaIzF
         FHlxLtfs6rL4AnwOhFBgk4Uzd9rXXu1x/WAoGwkv189VjZy+xA4ko1uCsbXyoOgkVCcj
         XoDC8dq68sdFdgM6mGYPLUya2RZv70o9nj90Za5Dh50n8mXFtuyrEUPJacvfk7AuognW
         dITA==
X-Forwarded-Encrypted: i=1; AJvYcCVYdUDBm0BEasX00zkgDaM768u+tlMkqfrQSMCqyLHvclNYlgUY6biXqC4oee225VwNze5bW5RbeqsVBetexoRk@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnUrazVgVtrA3j5FVUKWJC+s7n8QFmDtv3uozARywbwhW9Lyk
	jY2OAb4U/NBNoBb9grnNDp34pm4r2F+eduz1qa53bWL+Zr6wdhf9Xf/FXoAk3tY=
X-Gm-Gg: ASbGncvg7lfOR14v+VAHhCwEwy1VI5tlIIlZH4N4PdXqxHBx7aT7PVKE+55wDKhGdXQ
	MTlEsXzCBmWVP1QUzDWeO1fmaf/fe4rv3puO8Ves7BctH2C4olI1tYLaF49PZlRCul654Bpa7G2
	Z8NLbOwxEvp3KmL63JnjLAb+j9z7G4nme0ehl+GqYo7e/RaMEPNMlXLdToZKEkSHRAZwGMbGX6n
	JgjFNRZQMFSJbMfPv+cF9Pp23uOLISs53Pp2wlixq305ocH6B3lwpjHdrqigDWIc2tT5mx9NDCf
	2UmKFE3ON8+1qdjOAIT/kVzEorfo
X-Google-Smtp-Source: AGHT+IHdxb765FF/tuEHMIXniBEbzBGChueSqoBlXVwelYSzs5G+a6kTSb+Hcc24wmC4wtSYLVHKkg==
X-Received: by 2002:a17:902:f64b:b0:216:7c33:8994 with SMTP id d9443c01a7336-21f17f32366mr113621535ad.53.1738826611778;
        Wed, 05 Feb 2025 23:23:31 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:31 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:15 -0800
Subject: [PATCH v4 10/21] dt-bindings: riscv: add Counter delegation ISA
 extensions description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-10-835cfa88e3b1@rivosinc.com>
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
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
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Add description for the Smcdeleg/Ssccfg extension.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index be9ebe927a64..b20dc75457d2 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,13 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smcdeleg
+          description: |
+            The standard Smcdeleg supervisor-level extension for the machine mode
+            to delegate the hpmcounters to supvervisor mode so that they are
+            directlyi accessible in the supervisor mode as ratified in the
+            20240213 version of the privileged ISA specification.
+
         - const: smcsrind
           description: |
             The standard Smcsrind supervisor-level extension extends the
@@ -175,6 +182,14 @@ properties:
             behavioural changes to interrupts as frozen at commit ccbddab
             ("Merge pull request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: ssccfg
+          description: |
+            The standard Ssccfg supervisor-level extension for configuring
+            the delegated hpmcounters to be accessible directly in supervisor
+            mode as ratified in the 20240213 version of the privileged ISA
+            specification. This extension depends on Sscsrind, Smcdeleg, Zihpm,
+            Zicntr extensions.
+
         - const: sscofpmf
           description: |
             The standard Sscofpmf supervisor-level extension for count overflow
@@ -685,6 +700,36 @@ properties:
         then:
           contains:
             const: zca
+      # Smcdeleg depends on Sscsrind, Zihpm, Zicntr
+      - If:
+          contains:
+            const: smcdeleg
+        then:
+          allOf:
+            - contains:
+                const: sscsrind
+            - contains:
+                const: zihpm
+            - contains:
+                const: zicntr
+      # Ssccfg depends on Smcdeleg, Sscsrind, Zihpm, Zicntr, Sscofpmf, Smcntrpmf
+      - If:
+          contains:
+            const: ssccfg
+        then:
+          allOf:
+            - contains:
+                const: smcdeleg
+            - contains:
+                const: sscsrind
+            - contains:
+                const: sscofpmf
+            - contains:
+                const: smcntrpmf
+            - contains:
+                const: zihpm
+            - contains:
+                const: zicntr
 
 allOf:
   # Zcf extension does not exist on rv64

-- 
2.43.0

