Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CA1DF73B
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040401; cv=none; b=itDQXUUksvJBOFGrGtGeZKRUa32cvi2cZ71ioPIGvaKZKFKvSMev42dts4rObo374QHcF5WK8Dunl+owPoOMYqnevINs4p9R8PELGLKNnQqarWpNqc/v+f3uNzmQW9lyTVIFmRIzSbKbdSiTuU1cxAC1eNg7uxj2V68xKEzrWT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040401; c=relaxed/simple;
	bh=h5wOko5/ga8cV219RAU/eWL2w/vmxvwUPsYu9zhL7hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyyo/BPYcuM+oQ9tttyHVOTKnSzyPR4bc1GP9tIsM/94ja7eoF+MiPa4XcD1kcThneZdQY6Qjoghke6wfpP1qypI8upjD5SvPcVr2+lAAoQRMHxWZjb5NNiiwn0Cc3C4Keqy9XY2vLoMcQRnGO9qeJ+n/t2o+IrFOTQNtEyo6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ANmD/XCF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ANmD/XCF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso6874761a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 20:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040399; x=1738645199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaBtUmcc8yUuB4kb43/yPbo3SeenY+DY+wt99rutmtE=;
        b=ANmD/XCFnxZIciEMcbjQPVgpjqyOUPOldnaCS+gG8hLn0oK4EbroXHL4Nos4iQVwIY
         J62cEQpvWMxk2WybQup0fCEv7Hm1qNxAAbmNwWhW7Kp4ERtSk6yKIukZENsO8wFjrxyK
         a3c0jnW9Sf7i6XnGhm9hMWHUSn6J20q8mGzGDqC/djd8F3bemeVKGLsi0XmtIt5u6ZnO
         MM1UGuQMkDy+SzuaWFpRDgdztMAVY/UroIoBeGDD2ShvaqaQXfB5gFnOhSBJLtCVcIba
         MbRL7j1KW/HKsbYfKTh1yhsMJObduR09+TDMJblx1z0jgNkUSPFkqix3izRoTFGOXDOP
         EaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040399; x=1738645199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaBtUmcc8yUuB4kb43/yPbo3SeenY+DY+wt99rutmtE=;
        b=CGp3/tesB2KDhMZhfam2UADi+MUNE6NVrxH1XsHjx/GYfx9GerV0udFtI8qlACa94Q
         n/OGHDa5qKILe7Pv47oFL4qc65n4+3ByS3uSK5TmgW42BQWQ3m/Hok7ITAExBRrolHlw
         YL/tADne7ZoYuBiQVtu1jzrYK62z/Jv6bx/rw4Ttt2RcoGqeP16YP7O18FzlrMrFINt9
         +pM99Qp/ACGHy9fucR17X/ts9LV7PFB2bAS5hX9yP7tC/iam1MIrBjigfiWQjT0HOQ52
         8ThKCoFy7lJcpmvzkYY4egSI0WXN+xHHKSlTC2zjPIPUnv3NYVz4+lWKHY9pKc1v23lw
         nxPA==
X-Forwarded-Encrypted: i=1; AJvYcCXK6le7htiYZ4IYItX+Dwy7DH9+11RZJ7ya78sMLHLQy1MDnl53eYzOOw99Mwb7G2KuAQXuEEai0QnpL9QQSFMN@vger.kernel.org
X-Gm-Message-State: AOJu0YzNf7k0HFch8LP3z3Av1wBkmVis02KI2otHkzNcL8sO81tMWKjo
	aAhnODYTuV2u8NR7h84tyA9LNTd07JuynCKKOGPK4SUMly3tAUlI58GnldK2rrs=
X-Gm-Gg: ASbGncs1wsc96vL+t3Klr7LGKNtFRs1FLt2Vz13DKu0jxmfVeB7mKMFVnWIQBoWtlyg
	fMnHaQ7xwswcyC38CoRCUcFlNItZ9EtA7jUrGeTkjV+g5ibYyWLUCwRGwOMecqeFJgZVNonaBcV
	JeWphpmJ4joNUzu7K4Q8gIKX+I/qcP7cOcUCAbJ1yY2rttv+9as0LoiddWLhcyH/cJJaRuCWTNO
	V2hwPpw7ZJUhCsQ6hHsb5mE1Y85oSDlmVmnp30wkCyMBDz6/3mSPQ8iEbNOWog4A93hDXbAiKPH
	/Xac+5WEgwRKdhx+dVGVUo5WwgkX
X-Google-Smtp-Source: AGHT+IGvdsN2QjvjEdbxBM8fo2c3ojaIC5oAQTKaWVxAx/Vzcck7YYYeeDIBW3vl6CdvOvXnZUnWVw==
X-Received: by 2002:a17:90b:3a05:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2f782cb68fbmr68628638a91.16.1738040399051;
        Mon, 27 Jan 2025 20:59:59 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.20.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 20:59:58 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:47 -0800
Subject: [PATCH v3 06/21] RISC-V: Add Sscfg extension CSR definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-6-64894d7e16d5@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>, Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the scountinhibit CSR definition and S-mode accessible hpmevent
bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
counters directly from S-mode without invoking SBI calls to M-mode. It is
also used to figure out the counters delegated to S-mode by the M-mode as
well.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2ad2d492e6b4..42b7f4f7ec0f 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -224,6 +224,31 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg */
+#ifdef CONFIG_64BIT
+#define HPMEVENT_OF			(_UL(1) << 63)
+#define HPMEVENT_MINH			(_UL(1) << 62)
+#define HPMEVENT_SINH			(_UL(1) << 61)
+#define HPMEVENT_UINH			(_UL(1) << 60)
+#define HPMEVENT_VSINH			(_UL(1) << 59)
+#define HPMEVENT_VUINH			(_UL(1) << 58)
+#else
+#define HPMEVENTH_OF			(_ULL(1) << 31)
+#define HPMEVENTH_MINH			(_ULL(1) << 30)
+#define HPMEVENTH_SINH			(_ULL(1) << 29)
+#define HPMEVENTH_UINH			(_ULL(1) << 28)
+#define HPMEVENTH_VSINH			(_ULL(1) << 27)
+#define HPMEVENTH_VUINH			(_ULL(1) << 26)
+
+#define HPMEVENT_OF			(HPMEVENTH_OF << 32)
+#define HPMEVENT_MINH			(HPMEVENTH_MINH << 32)
+#define HPMEVENT_SINH			(HPMEVENTH_SINH << 32)
+#define HPMEVENT_UINH			(HPMEVENTH_UINH << 32)
+#define HPMEVENT_VSINH			(HPMEVENTH_VSINH << 32)
+#define HPMEVENT_VUINH			(HPMEVENTH_VUINH << 32)
+#endif
+
+#define SISELECT_SSCCFG_BASE		0x40
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM
@@ -305,6 +330,7 @@
 #define CSR_SCOUNTEREN		0x106
 #define CSR_SENVCFG		0x10a
 #define CSR_SSTATEEN0		0x10c
+#define CSR_SCOUNTINHIBIT	0x120
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142

-- 
2.34.1

