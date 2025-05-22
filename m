Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086962D29CA
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956382; cv=none; b=kKkmYBcOic0XpwapAzgPIaT6NUwjKcHKft/ek/mZKQoYH6TmyzYsGY42OreM6VxN6dfjULsVqOM5c7WMQQsCIHky02CqyctkgQ41ImZqvrEkxMl/+Igj5Nzw9dH3beXrHW1XvIcRv2TUg/KpXhdl1QbxTasIGjO+blOC/CfajKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956382; c=relaxed/simple;
	bh=FOp1y09/3SytdmvNsRNI8bjrwNGWBMKFRpE30aP/AEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=on9Am4wznJlqz76/lgNeYugKyrm2gEs+CQWWvlmEGOnzymD47GR9AgFS4McZiqbzVoGC0y584B5LPrRHtt/JMszKKuxLYVhBuQtv/oVKNkBVi63YUK7SbiiPJO/RKWj5n1Io8uOXiKH1nOPvWa3b/YiPI1DQjm9W/r1KUhexs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bA0WeckT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bA0WeckT"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a374f727dbso3727971f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747956378; x=1748561178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l53aiezq63VwGVulH0Yi9XQBVwtNa/T40ZWDbw9c1U8=;
        b=bA0WeckTYVEWROV07KpSEjHgHCe9Eb64CmQKTSE7au1aVTCdlYWjCoYVWYZtDMQaDi
         OawMgvVRGhOgbvVS40NDYKjp4q0JjcmHXnPMWacBV0SKr75pxXPtKafmaWPgc2M6BQcu
         gz6FdUmbYQKUWIrq6aFYxeinnSD5WU0AQaEQT5Rjl6LwfhGwNDDlVV9BQfqSeD+BRda9
         RNpC0EE400ByWQ115BLULyZbXEzpUHWExkf2JKeUJOqgXBOYR9rH4HK+UwcPcAwtl+SG
         C0oYGxvat2jXdHS10CDpvBhDTEcLf+YiW2ikU2KfwNxYDycEFk2ACkD2v6xHbjtKcrMf
         ZtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956378; x=1748561178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l53aiezq63VwGVulH0Yi9XQBVwtNa/T40ZWDbw9c1U8=;
        b=D1sVOo6+eW06drGDqBu7WjvsM2b0z+gEgUGfYABD4V+x2y79t2HnrmvoM7qmOBcXHG
         nObQN7jklTWIvYBFpP6lpN7AgfD6dReqwZVT6bWwc66yeqjUmr6XRqu141j28NV3b8UZ
         DU6rjIRkINEvgHkpkTEaWctr7VUROCUGmz8Yc2VRAMGCkbeo5xk2Hf3cGqizufD49l9C
         75J88ovlrB22O7RWGOZ9wFUKQDcYrfiQUFpG0YZa2/HGQHCAOMFBDwmfrH1h+c5nAgVJ
         K6MPf0QFnZ9m6SPRYJJ08+/ls9WN2J9DXmZheI5uM7TNR4JEmsTh1I2lZww1eXxY1uh4
         sbuA==
X-Gm-Message-State: AOJu0Yz1vlpjV3nMdyllr03CiDRbtHAc7BBRbHoTpaNDObF+MY9ZMG9C
	mi0IWvFZkh0rYLG0fnRWLiG3XuS2uc2yJ6UuPxf+cgc+/cPjXKPaUqIpcdWU6hgB8kw=
X-Gm-Gg: ASbGncsiNTE+/qUDY8mvtlpQXFsZxBAMSwmK3UC+sZdZ/NEVejVs03dAdeRToLGYwoo
	wXOCZ1RfAN3fsD/PGwZkrKTXsIHjbLuXFh3AjNAtAwMuCZVWrhUXiAAHLjrxcgknWjhjGMAHDSO
	AaHwxUMh/9OwVhWXWrdH7T40VJIgQiyV+6tjAcLsizKlLe+clMz/jUuvSdFo9WmYClbjP1Hyxn3
	p8zFR4UjBTDxH5fdD1kfR5LIlhHhKlorQKaN05hJz2kZOhgMP8zKfHz87NFF8h6Mc5CzNQPl+Qz
	LiySS6kWasxA+i8jjDxjpeOWEUY5Mcv8M6ZKyN6BPiPeS8yCIEsoTA==
X-Google-Smtp-Source: AGHT+IHAmL4SGVYuRfQdx4Te1SZB2AHBQgY26GyZwg325ZZdeZGi5gjiCaXcu6MypqA+Dk0jD2u8ww==
X-Received: by 2002:a05:6000:2903:b0:3a3:6f26:5816 with SMTP id ffacd0b85a97d-3a36f265984mr15292194f8f.36.1747956378244;
        Thu, 22 May 2025 16:26:18 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:75ac:6300:c05a:35d:17ae:e731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f04334sm117825395e9.10.2025.05.22.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:26:18 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Fri, 23 May 2025 00:25:08 +0100
Subject: [PATCH v3 2/7] riscv: pmu: Add Control transfer records CSR
 definations.
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-ctr_upstream_v3-v3-2-ad355304ba1c@rivosinc.com>
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, Rajnesh Kanwal <rkanwal@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747956375; l=3834;
 i=rkanwal@rivosinc.com; s=20250522; h=from:subject:message-id;
 bh=FOp1y09/3SytdmvNsRNI8bjrwNGWBMKFRpE30aP/AEg=;
 b=VAKiiJbUQk/CKnHQk537iR4eh6srfGqgxMprrnILqLhhp+3+U+RkJeqfMk302Xmwyi5fnxrYd
 Ogwp9C565GICK4Ub/rWcyt+4/fWPFEieJZE2YOTuQ8gYHwDi31VfK57
X-Developer-Key: i=rkanwal@rivosinc.com; a=ed25519;
 pk=aw8nvncslGKHEmTBTJqvkP/4tj6pijL8fwRRym/GuS8=

Adding CSR defines for RISCV Control Transfer Records extension [0]
along with bit-field macros for each CSR.

[0]: https://github.com/riscv/riscv-control-transfer-records

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 83 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 8b2f5ae1d60efadbec90eab4b1a3637488a9431f..3aef621657603483e1cafd036f126692a731a333 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -331,6 +331,85 @@
 
 #define CSR_SCOUNTOVF		0xda0
 
+/* M-mode Control Transfer Records CSRs */
+#define CSR_MCTRCTL		0x34e
+
+/* S-mode Control Transfer Records CSRs */
+#define CSR_SCTRCTL		0x14e
+#define CSR_SCTRSTATUS		0x14f
+#define CSR_SCTRDEPTH		0x15f
+
+/* VS-mode Control Transfer Records CSRs */
+#define CSR_VSCTRCTL		0x24e
+
+/* xctrtl CSR bits. */
+#define CTRCTL_U_ENABLE		_AC(0x1, UL)
+#define CTRCTL_S_ENABLE		_AC(0x2, UL)
+#define CTRCTL_M_ENABLE		_AC(0x4, UL)
+#define CTRCTL_RASEMU		_AC(0x80, UL)
+#define CTRCTL_STE		_AC(0x100, UL)
+#define CTRCTL_MTE		_AC(0x200, UL)
+#define CTRCTL_BPFRZ		_AC(0x800, UL)
+#define CTRCTL_LCOFIFRZ		_AC(0x1000, UL)
+#define CTRCTL_EXCINH		_AC(0x200000000, UL)
+#define CTRCTL_INTRINH		_AC(0x400000000, UL)
+#define CTRCTL_TRETINH		_AC(0x800000000, UL)
+#define CTRCTL_NTBREN		_AC(0x1000000000, UL)
+#define CTRCTL_TKBRINH		_AC(0x2000000000, UL)
+#define CTRCTL_INDCALL_INH	_AC(0x10000000000, UL)
+#define CTRCTL_DIRCALL_INH	_AC(0x20000000000, UL)
+#define CTRCTL_INDJUMP_INH	_AC(0x40000000000, UL)
+#define CTRCTL_DIRJUMP_INH	_AC(0x80000000000, UL)
+#define CTRCTL_CORSWAP_INH	_AC(0x100000000000, UL)
+#define CTRCTL_RET_INH		_AC(0x200000000000, UL)
+#define CTRCTL_INDOJUMP_INH	_AC(0x400000000000, UL)
+#define CTRCTL_DIROJUMP_INH	_AC(0x800000000000, UL)
+
+/* sctrstatus CSR bits. */
+#define SCTRSTATUS_WRPTR_MASK	0xFF
+#define SCTRSTATUS_FROZEN	_AC(0x80000000, UL)
+
+#ifdef CONFIG_RISCV_M_MODE
+#define CTRCTL_KERNEL_ENABLE	CTRCTL_M_ENABLE
+#else
+#define CTRCTL_KERNEL_ENABLE	CTRCTL_S_ENABLE
+#endif
+
+/* sctrdepth CSR bits. */
+#define SCTRDEPTH_MASK		0x7
+
+#define SCTRDEPTH_MIN		0x0 /* 16 Entries. */
+#define SCTRDEPTH_MAX		0x4 /* 256 Entries. */
+
+/* ctrsource, ctrtarget and ctrdata CSR bits. */
+#define CTRSOURCE_VALID		0x1ULL
+#define CTRTARGET_MISP		0x1ULL
+
+#define CTRDATA_TYPE_MASK	0xF
+#define CTRDATA_CCV		0x8000
+#define CTRDATA_CCM_MASK	0xFFF0000
+#define CTRDATA_CCE_MASK	0xF0000000
+
+#define CTRDATA_TYPE_NONE			0
+#define CTRDATA_TYPE_EXCEPTION			1
+#define CTRDATA_TYPE_INTERRUPT			2
+#define CTRDATA_TYPE_TRAP_RET			3
+#define CTRDATA_TYPE_NONTAKEN_BRANCH		4
+#define CTRDATA_TYPE_TAKEN_BRANCH		5
+#define CTRDATA_TYPE_RESERVED_6			6
+#define CTRDATA_TYPE_RESERVED_7			7
+#define CTRDATA_TYPE_INDIRECT_CALL		8
+#define CTRDATA_TYPE_DIRECT_CALL		9
+#define CTRDATA_TYPE_INDIRECT_JUMP		10
+#define CTRDATA_TYPE_DIRECT_JUMP		11
+#define CTRDATA_TYPE_CO_ROUTINE_SWAP		12
+#define CTRDATA_TYPE_RETURN			13
+#define CTRDATA_TYPE_OTHER_INDIRECT_JUMP	14
+#define CTRDATA_TYPE_OTHER_DIRECT_JUMP		15
+
+#define CTR_ENTRIES_FIRST	0x200
+#define CTR_ENTRIES_LAST	0x2ff
+
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
@@ -523,6 +602,8 @@
 # define CSR_TOPEI	CSR_MTOPEI
 # define CSR_TOPI	CSR_MTOPI
 
+# define CSR_CTRCTL     CSR_MCTRCTL
+
 # define SR_IE		SR_MIE
 # define SR_PIE		SR_MPIE
 # define SR_PP		SR_MPP
@@ -553,6 +634,8 @@
 # define CSR_TOPEI	CSR_STOPEI
 # define CSR_TOPI	CSR_STOPI
 
+# define CSR_CTRCTL     CSR_SCTRCTL
+
 # define SR_IE		SR_SIE
 # define SR_PIE		SR_SPIE
 # define SR_PP		SR_SPP

-- 
2.43.0

