Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89E22BAD8
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069032; cv=none; b=EBsMsuHbOM//KdaxPbXBF0qujoUmud/7UnshPCrBVj/IfIVLUtW2jrrOF3y8C7JuTdJ4hiRQlB+qc3rgwvHgNVZQi7Afz4TNz3xL8EidIdBylC+1KDP/WE45VjsItzwTf30jU7/VWG9X7kwJvWXB9G38lDsz/7FLGAvwP8RxlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069032; c=relaxed/simple;
	bh=SQQaty6fCkVnUgpY4sT8w9n0kpRWVXbvtIPxo6ahfMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8UzV6o0H8Wkvg3MMbfiUroGiuApLlxpdtPnneUeY0NkVV8b9VQm+jzAnoUh3Dtum+zAKtAamOJJfcV2uSxZSsQ4z4Z5jnZynRaydsvIhIn6/nhDEPeZoLORNK3100pXsA3KNc65Q51rNsXhwY456L664wT0ngBAnYsbO0O5Uns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=labC1pHT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="labC1pHT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385eed29d17so849243f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737069029; x=1737673829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iExoXWcsgpz1yiXKVDiuJsm//UYZR8b0hyvjPLZ7n2M=;
        b=labC1pHTyGwvS9WWHqSAG/DnlL7A2jALM54CCuoyFWbUSSlM5a7CQPKXLfoK8dGaoI
         1fTDtjvZ+d3nApRF2YxQ0jAPJPjmSdU67XcDTvJP3Efy+MN/TYrajQzDRRidYL7iHmuK
         kgOFMfp1liWGSblrjmDfjOZRbBybWYLltfdD112nvki7n3+d+FA7Y0DWvYD+nzZRYnmL
         2badOp/IX0PNLzgcJ5i24EItV8eiMCwoUb9Mmpr3nSj9ylLMsh0rCWsUbpimGYAM8WZd
         Y9E6JefCuDFJqfnWLQYDW4lWt75SH4T5jeLxuy+Hi4nsSYwtYsBpptAdk8mqWAtp+5/s
         Mjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069029; x=1737673829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iExoXWcsgpz1yiXKVDiuJsm//UYZR8b0hyvjPLZ7n2M=;
        b=RtbtLsR13BIy9GVGRVduGChvN8/t3h3ws8shTHyGffL2S0AJKSwTIYO29nQ4cORkTS
         lS0m0yT0wZDwiAFmQlxGDu1kAcSkt2L9xFpO2C4SWwl4ANfYnBmwehxvuyPJSbBM5AdW
         5R9wDmhPoTpRNtUlpHZWSjOmwAGXWNZ8YkrJoL+sva74eA9wdfGJJovtyApBbS8fpB13
         rUTU8rVosoUAc74DuRP8waIFEIrIahWXLRcv9FgnKNOmUcRnuyLwX9CtyjUxqi4VZ+IL
         71NuUhHMVFinfDynweojestI/I6mptZXJplh+MngvHT6YAIwI+M8Ai9zKbpzMrawqR2f
         GR2g==
X-Gm-Message-State: AOJu0Yy4bdugi1fRMbWXyn3JRcK2UzoICcxShEg8WCwBSKo/RIPxrk8w
	lr2tHTFD5VC8K9yMVhxsFMUBJqFeU8xX+jDl+KYZWHw3Ik8qeiiPR8UIvga7k6w=
X-Gm-Gg: ASbGncs16CvPJvzBazl5YJDH4kVtgD+Vbi7eU/tqNrscLJl80JfG/WKVm9zoCVY6yaV
	N09/wdUozrQByPYE+85LT5IRWgS+yI8F3XF7o1eglaZaau5KqtptDDrd1dppllECUlOfk6IxWbd
	DIYfEGMevUbjvK4v0WfjCDwhuVY/Ke9X3SWCCuHf24XRajB3zwAqyIOYnjW+88PCYgYIaomOW4Y
	ft27ggGciCWXIXkbr0PwfhzVn05sN76+Jm2McZ9IB7jmR53JKoCg4bG6ewk46vlFsibYVLWmF2G
	MV4QzR8sQHARcVyn
X-Google-Smtp-Source: AGHT+IEE85RzZXgjKSxtatDeczrhYN+ZJtEmiy39XawqUlljd+N8P1eGO6eoSvUUxpVRipcUDt0wBw==
X-Received: by 2002:a5d:6d06:0:b0:38a:418e:1177 with SMTP id ffacd0b85a97d-38bf565531dmr377720f8f.11.1737069029362;
        Thu, 16 Jan 2025 15:10:29 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([2a02:c7c:75ac:6300:b3f2:3a24:1767:7db0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b337sm974991f8f.59.2025.01.16.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:10:29 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	vincent.chen@sifive.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v2 2/7] riscv: pmu: Add Control transfer records CSR definations.
Date: Thu, 16 Jan 2025 23:09:50 +0000
Message-Id: <20250116230955.867152-3-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116230955.867152-1-rkanwal@rivosinc.com>
References: <20250116230955.867152-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding CSR defines for RISCV Control Transfer Records extension [0]
along with bit-field macros for each CSR.

[0]: https://github.com/riscv/riscv-control-transfer-records

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index a06d5fec6e6d..465a5e338ccb 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -325,6 +325,85 @@
 
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
@@ -508,6 +587,8 @@
 # define CSR_TOPEI	CSR_MTOPEI
 # define CSR_TOPI	CSR_MTOPI
 
+# define CSR_CTRCTL     CSR_MCTRCTL
+
 # define SR_IE		SR_MIE
 # define SR_PIE		SR_MPIE
 # define SR_PP		SR_MPP
@@ -538,6 +619,8 @@
 # define CSR_TOPEI	CSR_STOPEI
 # define CSR_TOPI	CSR_STOPI
 
+# define CSR_CTRCTL     CSR_SCTRCTL
+
 # define SR_IE		SR_SIE
 # define SR_PIE		SR_SPIE
 # define SR_PP		SR_SPP
-- 
2.34.1

