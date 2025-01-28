Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCED165F1E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040405; cv=none; b=TMOm1dnrmqmyqM8gGKlDmdBwIZz8B0NU2LEapdajwYPHI+1wNEYXaPmCKMAALrdo3SmDYswW0KW3hKgi3thCQLvBvGM07ivVs/nF5uFX20QL32cNRT62rSI6wXxukOVLClMRFgUU6FMjT1+Wb4E4brN97+xlhMoQL9o3afVmJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040405; c=relaxed/simple;
	bh=j6KZ4QS2aupIU/Q0ybhUflnKa/It+i/xJb5UAE1ecGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLEtIgTVQr/Ui6tw9sda53azjv20hkz7aChvo/sJTDq8zmPu2IIY8BAlXqvi0mXoeVbeXYi1Q8SXztCpzVsiDAuHreLjQcnWLR6N1U+KBBU9elKq8E18KA+E5yIwJ6wPq9gJqIexX/6suiOiPQhbwBJoSKXe4BDWIJhLEC6ic1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gQ/tU2RW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gQ/tU2RW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso6941823a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040402; x=1738645202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ysqLj76yIXMmN0DuXp9ro2na+awhMKH5VmavOAjzvw=;
        b=gQ/tU2RWxSAoCOOua4wrmuWyEN8D5cIxZorgtVAv7XNomdaq+N+RtX0SQPKekNTlcf
         A+rRROa43P6G7i3I5BGKc/Dv6tfJGtU6smseApdTjIXzEiZsf0pftsxfOhjpai8iE0zC
         A+lzE6JskrYxqEAOKo3Bx6aPaA0dlbwkbLdb7zwrOD43MEq//hvLbEhwwhEdPYRX/Bcu
         MwYY2jWe53PKFvOd9RuGtiXj8ODXqj5a/E6795d6Jw7mgjniZY+msO1ma0th/+DvzswY
         76re6bwnADW1koAqABhguEoR7kwcwR1/FFvwXZ4j9laUlzTbbKqQ4HdltDb30IJJ76S0
         zdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040402; x=1738645202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ysqLj76yIXMmN0DuXp9ro2na+awhMKH5VmavOAjzvw=;
        b=wBOi3UapUCW9XZ3p1fFWLGXZuvo7ArWFedlwHSOVpQH5/cRuAGYaVJ8nUNAtbvbhnz
         mRjxx8vdostS6KYF+vihTMWNH66jQD0fO1qq7TZwQWOvuThg5HskHvRCf7Bz2v5qgdQz
         Rh2/s1IBee/Imw1EVgUaJJOlxeiREA4zZi0RIyeTEBDC9XOcAFqgz1f28pEvx3H7Lgzy
         i7xrwxPChOQzhoYzLZcIOw4KCOryM8YD1SytSToa2G/1+Yv0ejoNxrEtDpNyvCYNbave
         41ctBVyOsMSgY2edvIZSVMCCWEjVPXeifUhXVn2uJD5yv8cB/ZBQq6TS2B8qmgp/BBaq
         zm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/ANFWJdfx3m+1K5w2+DM/M2k8il0Nie2kxOR4Hj7gQk4eD7Lm/6h+Jg7iOLiyCxHr5wwOLeMrPrSM4QCYqcJv@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJP7jrp/Y9r2dPcdloRlUlw5oBkPUrYCUMk64mYHC+jeCGORD
	ooHLgmj9nwTGdTuTTfV22ORhpg62QVdGyZHGoZqw5vXP1DJO5rOiA+6XoAybokE=
X-Gm-Gg: ASbGncsMFz3N7JI55FPx23HKGulyivWQ+T46xXXATaCEhaa6m7MEwCdfMgQQqKFwotN
	2fx3TCuaPgtjFiVonZIb+Ve2V8OcJwW2vLA2g7Eb8xuvU8JKCxPY0fvbheZSDOGmr/vby4/5zlx
	LmranG2z1FCbfDVpniCT9xx93Rml32V9/dr9RLWXggWffk750Ec7nZmQqud2lNpYvqjrnnZLn03
	+h3Zb16GIwwytd2RYrMVihH5Nd7La82lABi16fTGpWh1416ktU890PdRxEDu6WjeP87RCPyt4Il
	xNDX9IOJ1sRyRD4XnQsZ+bAFrLcc
X-Google-Smtp-Source: AGHT+IFdfSM4LoL408uYEIffufa8tyqHYMXtXIXqsBrutmD1adLWVCNfMy18lpD4qkSPUrqnOkGRNw==
X-Received: by 2002:a17:90b:270d:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-2f782ca5d86mr58401904a91.21.1738040402292;
        Mon, 27 Jan 2025 21:00:02 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:02 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:49 -0800
Subject: [PATCH v3 08/21] dt-bindings: riscv: add Counter delegation ISA
 extensions description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-8-64894d7e16d5@rivosinc.com>
References: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
In-Reply-To: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
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
 Documentation/devicetree/bindings/riscv/extensions.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index f47d829545db..1706a77729db 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,14 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smcdeleg
+          description: |
+            The standard Smcdeleg supervisor-level extension for the machine mode
+            to delegate the hpmcounters to supvervisor mode so that they are
+            directlyi accessible in the supervisor mode as ratified in the
+            20240213 version of the privileged ISA specification. This extension
+            depends on Sscsrind, Zihpm, Zicntr extensions.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as
@@ -169,6 +177,14 @@ properties:
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

-- 
2.34.1

