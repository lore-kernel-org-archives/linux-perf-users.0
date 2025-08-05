Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AF29B206
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Aug 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422816; cv=none; b=SlUEaNMSJhwxghf93a6mB+abjWHwpNtIF4NaidwPjFv2x1H61QkBsEMuC9T+13PIJUcxsZMb5LMwAjb2vqokL+cL80oCJvliYzZAazhO27Gt7VOdHZOMaxjVXxAzzoMaaL+8P58s2vrX00urN3fevI4ARAf63F6re3uSax4jiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422816; c=relaxed/simple;
	bh=pH8wkOotqE0cBRSa0KbFERwDeYY+i5YxpVrEk0g2r9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS0sqdVbszaT6QOIMwBEZyiniBQs56BuFfzhuyQLq/s83nuwtQEL8hNP6UKqnrKOPidB4MGxS7fmX6yfrGphxBVdnWwcS6SrpgcXrra1wLYZeordu+E2s45XLwahQ2nL1XOJeHqYWFfKWzIDRNZ4prT3A488ohp3cexYIhoOujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Ydz0xc1k; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Ydz0xc1k"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d45f5fde50so523729685a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Aug 2025 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422813; x=1755027613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy5rnGanwjtyLCbaD47CPjt7MxkuRZTNweHSGmibXvc=;
        b=Ydz0xc1kVfwyk/Z1z9QVrki0bvBb5DgxXoTDaHCYynsiWLWNvxPmTUWpc5qPGGyFvL
         Fkp61IGRhiVMOXo/bmiUJhou6fskdA+m+HYqjMrVJVkOcw+dUXrsmaCboCnzMHOUCsrT
         j6tf4TnCWyjzvqMhK8AWk6hBwyz4xeEF9QuInHuOW08WkylCX2D14PE5Yrww0OvvPgwK
         4pcr4WvOZEMD328I7o+0vc3wuhybCa5gLmdfD7O39GhWCx5HmAwvTtZcrj7R+wPLiCHg
         75eB3UKUoBWGCAxOhmix3X9WBJf+jd9vBoHsQlJs2p4I8TWO6Mc+32sq9d5RFeA3A1HD
         ytig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422813; x=1755027613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy5rnGanwjtyLCbaD47CPjt7MxkuRZTNweHSGmibXvc=;
        b=T387D+G1GfexPQWwU7nzIWhytqtQIT1lXFgF7vw9cBE4aYhxBo8k2SVjS57hVNdU4e
         bqsfOPQep8uDqukCLanFO4GW+Gy4bRr0lf4hb7Px51Zc/aYey1/UF2bUi0S10aeuPaPw
         noZTdCYXPMmykWKf9SUWGOca/2Cf7I9B5XCF3z1cSU4ASH8RnaXe0r+hV/X7ySaLFE5F
         pk/Zx8INq1yKY0Ib1TVnhGILG/7KjoE0bXHRObGRdprIMvTlE1VW2ln8OoSNceg+Vssc
         ug9+3rrsOq4cL7nA9lSm88CtAc63B3VUubjAZKcqT6r+W6rNcHFnEZKfluvIjAguPU1L
         kVTw==
X-Forwarded-Encrypted: i=1; AJvYcCUntjMRYHDZpHKLiDaqdQGkBJnE1S/d8ghVI+/CgvSBIgoxbs/sL1h6+FMfOsTi8GnY01HnEUpk1SIq9fmoM8zT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Lx8yXr70V2KVnMNK6ZQZjQz7/jLWPwlKnyECj2DvITxR0XjV
	IXX/p6Kf2Yv0yydXTQzO6v4ElSPVg8jHrMk9pr0vSL3h2RRuRaPygywVevEZjzzYWVw=
X-Gm-Gg: ASbGncvYhYm+asmE+7plNQ+qa6WaGcfSJsM8ktwxNd8smd6QpCZDyMOHqXyHhb3T3VC
	WPBvd3lmTa3tpCbPvpQb+0ceyla0kWffzyZq2yz5mfSWpuF6uPjNGWS8G7eMF9LhtrW8WTffLMS
	YBcax2x3gGZF1XrlA8MFp/jQ2J6TqSsWeoy4vfBSSQGbO9E7LYkzxE73oKVuguZ+wZSI9PlS8LF
	pI3Rtkl0RZ7f2U1LNvtQRP3Lpr+FCjL+nSRBjjJgo5sX1OMwkWIneuJdXpBcsGuRf39Dr70uLZs
	EE0DTEBbxGgenE5fn/KwtnZZkliJK4QdrHjtaKaH8Vdiz9XBGJxUQTFF7WFFJtwskZCbRmjxnu9
	eLXiqYqtotKBljxtJPbBIm+vyDqXvgf/KpjPiNBJsmioQ4oEw9ZiCXBrM95yqQnpeBpB9UWn2Sz
	qY7zUKEg==
X-Google-Smtp-Source: AGHT+IG6XA8VhHC/9Z5t7TyajoGN/5DDGuOO01JZMGKppPhvnVQsp/F8STKyDdgm3AlZG+FdD4n6KA==
X-Received: by 2002:a05:620a:1707:b0:7e8:15b2:3f20 with SMTP id af79cd13be357-7e815b24106mr5235285a.1.1754422813351;
        Tue, 05 Aug 2025 12:40:13 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:13 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley  <conor.dooley@microchip.com>,
	Deepak Gupta  <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 7/8] riscv: ptrace: Add hw breakpoint regset
Date: Tue,  5 Aug 2025 12:39:54 -0700
Message-ID: <20250805193955.798277-8-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805193955.798277-1-jesse@rivosinc.com>
References: <20250805193955.798277-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to setup hw breakpoints using REGSET use the
__riscv_hwdebug_state structure to configure breakpoints.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
RFC -> V1:
 - New commit
---
 arch/riscv/kernel/ptrace.c     | 59 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h       |  2 ++
 tools/include/uapi/linux/elf.h |  1 +
 3 files changed, 62 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index e097e6a61910..fbd0097ec168 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -33,6 +33,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_SUPM
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	REGSET_HW_BREAK
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -280,7 +283,53 @@ static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
 		return -EFAULT;
 
 	return ptrace_hbp_set(child, idx, &state);
+}
 
+static int hw_break_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	struct __riscv_hwdebug_state state;
+	int ret, idx, offset, limit;
+
+	idx = offset = 0;
+	limit = regset->n * regset->size;
+	while (count && offset < limit) {
+		if (count < sizeof(state))
+			return -EINVAL;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &state,
+					 offset, offset + sizeof(state));
+		if (ret)
+			return ret;
+		ret = ptrace_hbp_set(target, idx, &state);
+		if (ret)
+			return ret;
+		offset += sizeof(state);
+		idx++;
+	}
+
+	return 0;
+}
+
+static int hw_break_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	int ret, idx = 0;
+	struct __riscv_hwdebug_state state;
+
+	while (to.left) {
+		ret = ptrace_hbp_get(target, idx, &state);
+		if (ret)
+			return ret;
+
+		membuf_write(&to, &state, sizeof(state));
+		idx++;
+	}
+
+	return 0;
 }
 #endif
 
@@ -324,6 +373,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = tagged_addr_ctrl_set,
 	},
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	[REGSET_HW_BREAK] = {
+		.core_note_type = NT_RISCV_HW_BREAK,
+		.n = sizeof(struct __riscv_hwdebug_state) / sizeof(unsigned long),
+		.size = sizeof(unsigned long),
+		.align = sizeof(unsigned long),
+		.regset_get = hw_break_get,
+		.set = hw_break_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 819ded2d39de..7a32073e0d68 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -545,6 +545,8 @@ typedef struct elf64_shdr {
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NN_RISCV_TAGGED_ADDR_CTRL "LINUX"
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NN_RISCV_HW_BREAK	"LINUX"
+#define NT_RISCV_HW_BREAK	0x903	/* RISC-V hardware breakpoint registers */
 #define NN_LOONGARCH_CPUCFG	"LINUX"
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NN_LOONGARCH_CSR	"LINUX"
diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
index 5834b83d7f9a..b5f35df1de7a 100644
--- a/tools/include/uapi/linux/elf.h
+++ b/tools/include/uapi/linux/elf.h
@@ -460,6 +460,7 @@ typedef struct elf64_shdr {
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NT_RISCV_HW_BREAK	0x903	/* RISC-V hardware breakpoint registers */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.43.0

