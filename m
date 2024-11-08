Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267921CF82
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109602; cv=none; b=BwVKKVyDIHtcvu3kkvvtDWg9tlKvOmWd1vnsspme9IOXJ9OVZZhWykdDcm04DhVFp/4kMxrerZ42wDqZi8q3fwmEg3Gwdvaw7YiFMA2oXAAXMJLkQZZwfIZ2uZVMiZVQwNoJml0uH7tCe9IYg+op/CElqGohMvY1LQXtIE+xdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109602; c=relaxed/simple;
	bh=DvtQSh02lo5Mqu2qHNyFd3vKH9qVgnQoc+CVstoBu90=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LGGDvX3HAgSNAn3Ce1UbvOkBYehpjdirAke8K6UMWjgqL043pebvjdIgOACbKXhzJzYKG2ltbUlrcvb0wLaBHty3SVhZIYvqu2JWOLIIdWYJ553GUb0eipAH9E2U9jNvgVkJI/RFH4/Ulbau5uTZjibKjB6qu3vq26XDFUzu79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQsjGbkF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQsjGbkF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea863ecfe9so55459077b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109600; x=1731714400; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0ToQ23Vppji1Mg1bHWhJCZZXvwmxBw9hPYnixwWKMI=;
        b=jQsjGbkFcch+9QAJAt9i64BO8tV0AzGxsMYTMg6rg1DrsE+hXduuKMBdnllpAVgc8L
         x0j+lHmHmo+yN9807Ecxc5Q0gOzBwjLsLOUi6mEHF2V+sGWyey4Np/9ajrXboIxOElFR
         JHJiFzykzJypTS/WeBXAiPmnV0d858x7nmP9JCEAYpTXwC7TdPqyY0HqS3FHsnrqtSKl
         Dqb1zK2LocZuPFQMROsTDumU7471cw78NPtbhIF7hlg2/CttLDvP+NFR+82iqrLtY3hX
         G2dMlHhBaiCP2vbdQu9PiNuIwHxOvmP4YhuzEjmnpkZjMJnMr3Ekaa9qaScJkFzSlhqO
         o0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109600; x=1731714400;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0ToQ23Vppji1Mg1bHWhJCZZXvwmxBw9hPYnixwWKMI=;
        b=Dvap9uhtXL+c/ir95mgk1GRf41x2Tuxb/d19xpydDlS8hgC8cUWQpJd59ijD/1MMKD
         Aahit8Z+r9UwUK4D3n2q83LA6PadLlnsWKG/nhNdKEru77POoNPBX8deabT6xUonjODN
         LpBQzDzI2jLCqk0rLQWONd8ULWXcmqN/5sy38xUu1oc+hx7n17ddHJaMP/xRMl1DCQ2Q
         oNZzT1dg2JKnCwlcgPbZQVN+qYSWnJ5PWV1myEt3GYXraTvIw4kEphBadcuNm+bay1Bg
         q38RFM/MfuEx956hPXusoYQeT39iKdsyQD13S2A45ZZEqqifVgfIZkD7OAowr/q3yvuX
         Qi8w==
X-Forwarded-Encrypted: i=1; AJvYcCWMIP30jNreOvU9fDFaW1dlIQW548lsMvavAFjxmdt1HZ2XkbErQhY0StCBv7Exz1N/y0sYwQiZ2YTxZK9SvafA@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIEKzYzj9sYqMFvhn2j6KBVT4DnMt9YfDiDkwpD2DKDBtZhcl
	WwUatK7KCKlb+Y3Jw70xCPJm2vEkHgIaZuJiesyG7tHU6I5egsz5YQ2CRNDJYPdedXQl8wx+5QP
	V4QVpgw==
X-Google-Smtp-Source: AGHT+IEJnGD6fjMTvQRjkDpnDqY+9zvc1Y++kQcYFLcdsCZAdV7NT1mihfX2Kbcd4SGfD8gBTDktP9GrSlRZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:acd:0:b0:e30:d561:dad4 with SMTP id
 3f1490d57ef6-e337f8417bemr9668276.2.1731109599715; Fri, 08 Nov 2024 15:46:39
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:58 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 13/20] perf dwarf-regs: Move powerpc dwarf-regs out of arch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Move arch/powerpc/util/dwarf-regs.c to util/dwarf-regs-powerpc.c and
compile in unconditionally. get_arch_regstr is redundant when EM_NONE
is treated as EM_HOST so remove and update dwarf-regs.c conditions.
Make get_powerpc_regs unconditionally available whwn libdw is.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/Build        |   1 -
 tools/perf/arch/powerpc/util/dwarf-regs.c | 141 ----------------------
 tools/perf/util/Build                     |   1 +
 tools/perf/util/dwarf-regs-powerpc.c      |  61 ++++++++++
 tools/perf/util/dwarf-regs.c              |   6 +-
 tools/perf/util/include/dwarf-regs.h      |   9 +-
 6 files changed, 70 insertions(+), 149 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
 create mode 100644 tools/perf/util/dwarf-regs-powerpc.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 3d979480a188..ed82715080f9 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -7,7 +7,6 @@ perf-util-y += sym-handling.o
 perf-util-y += evsel.o
 perf-util-y += event.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
deleted file mode 100644
index 23846c59a522..000000000000
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ /dev/null
@@ -1,141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 Ian Munsie, IBM Corporation.
- */
-
-#include <stddef.h>
-#include <errno.h>
-#include <string.h>
-#include <dwarf-regs.h>
-#include <linux/kernel.h>
-#include <linux/stringify.h>
-
-struct regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-#define REG_DWARFNUM_NAME(r, num)					\
-	{.name = __stringify(%)__stringify(r), .dwarfnum = num}
-#define GPR_DWARFNUM_NAME(num)						\
-	{.name = __stringify(%gpr##num), .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-
-/*
- * Reference:
- * http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
- */
-static const struct regs_dwarfnum regdwarfnum_table[] = {
-	GPR_DWARFNUM_NAME(0),
-	GPR_DWARFNUM_NAME(1),
-	GPR_DWARFNUM_NAME(2),
-	GPR_DWARFNUM_NAME(3),
-	GPR_DWARFNUM_NAME(4),
-	GPR_DWARFNUM_NAME(5),
-	GPR_DWARFNUM_NAME(6),
-	GPR_DWARFNUM_NAME(7),
-	GPR_DWARFNUM_NAME(8),
-	GPR_DWARFNUM_NAME(9),
-	GPR_DWARFNUM_NAME(10),
-	GPR_DWARFNUM_NAME(11),
-	GPR_DWARFNUM_NAME(12),
-	GPR_DWARFNUM_NAME(13),
-	GPR_DWARFNUM_NAME(14),
-	GPR_DWARFNUM_NAME(15),
-	GPR_DWARFNUM_NAME(16),
-	GPR_DWARFNUM_NAME(17),
-	GPR_DWARFNUM_NAME(18),
-	GPR_DWARFNUM_NAME(19),
-	GPR_DWARFNUM_NAME(20),
-	GPR_DWARFNUM_NAME(21),
-	GPR_DWARFNUM_NAME(22),
-	GPR_DWARFNUM_NAME(23),
-	GPR_DWARFNUM_NAME(24),
-	GPR_DWARFNUM_NAME(25),
-	GPR_DWARFNUM_NAME(26),
-	GPR_DWARFNUM_NAME(27),
-	GPR_DWARFNUM_NAME(28),
-	GPR_DWARFNUM_NAME(29),
-	GPR_DWARFNUM_NAME(30),
-	GPR_DWARFNUM_NAME(31),
-	REG_DWARFNUM_NAME(msr,   66),
-	REG_DWARFNUM_NAME(ctr,   109),
-	REG_DWARFNUM_NAME(link,  108),
-	REG_DWARFNUM_NAME(xer,   101),
-	REG_DWARFNUM_NAME(dar,   119),
-	REG_DWARFNUM_NAME(dsisr, 118),
-	REG_DWARFNUM_END,
-};
-
-/**
- * get_arch_regstr() - lookup register name from it's DWARF register number
- * @n:	the DWARF register number
- *
- * get_arch_regstr() returns the name of the register in struct
- * regdwarfnum_table from it's DWARF register number. If the register is not
- * found in the table, this returns NULL;
- */
-const char *get_arch_regstr(unsigned int n)
-{
-	const struct regs_dwarfnum *roff;
-
-	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
-		if (roff->dwarfnum == n)
-			return roff->name;
-	return NULL;
-}
-
-#define PPC_OP(op)	(((op) >> 26) & 0x3F)
-#define PPC_RA(a)	(((a) >> 16) & 0x1f)
-#define PPC_RT(t)	(((t) >> 21) & 0x1f)
-#define PPC_RB(b)	(((b) >> 11) & 0x1f)
-#define PPC_D(D)	((D) & 0xfffe)
-#define PPC_DS(DS)	((DS) & 0xfffc)
-#define OP_LD	58
-#define OP_STD	62
-
-static int get_source_reg(u32 raw_insn)
-{
-	return PPC_RA(raw_insn);
-}
-
-static int get_target_reg(u32 raw_insn)
-{
-	return PPC_RT(raw_insn);
-}
-
-static int get_offset_opcode(u32 raw_insn)
-{
-	int opcode = PPC_OP(raw_insn);
-
-	/* DS- form */
-	if ((opcode == OP_LD) || (opcode == OP_STD))
-		return PPC_DS(raw_insn);
-	else
-		return PPC_D(raw_insn);
-}
-
-/*
- * Fills the required fields for op_loc depending on if it
- * is a source or target.
- * D form: ins RT,D(RA) -> src_reg1 = RA, offset = D, dst_reg1 = RT
- * DS form: ins RT,DS(RA) -> src_reg1 = RA, offset = DS, dst_reg1 = RT
- * X form: ins RT,RA,RB -> src_reg1 = RA, src_reg2 = RB, dst_reg1 = RT
- */
-void get_powerpc_regs(u32 raw_insn, int is_source,
-		struct annotated_op_loc *op_loc)
-{
-	if (is_source)
-		op_loc->reg1 = get_source_reg(raw_insn);
-	else
-		op_loc->reg1 = get_target_reg(raw_insn);
-
-	if (op_loc->multi_regs)
-		op_loc->reg2 = PPC_RB(raw_insn);
-
-	/* TODO: Implement offset handling for X Form */
-	if ((op_loc->mem_ref) && (PPC_OP(raw_insn) != 31))
-		op_loc->offset = get_offset_opcode(raw_insn);
-}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 99ae4e2802b8..eeab8684ddcc 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -204,6 +204,7 @@ perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
diff --git a/tools/perf/util/dwarf-regs-powerpc.c b/tools/perf/util/dwarf-regs-powerpc.c
new file mode 100644
index 000000000000..caf77a234c78
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-powerpc.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Mapping of DWARF debug register numbers into register names.
+ *
+ * Copyright (C) 2010 Ian Munsie, IBM Corporation.
+ */
+
+#include <dwarf-regs.h>
+
+#define PPC_OP(op)	(((op) >> 26) & 0x3F)
+#define PPC_RA(a)	(((a) >> 16) & 0x1f)
+#define PPC_RT(t)	(((t) >> 21) & 0x1f)
+#define PPC_RB(b)	(((b) >> 11) & 0x1f)
+#define PPC_D(D)	((D) & 0xfffe)
+#define PPC_DS(DS)	((DS) & 0xfffc)
+#define OP_LD	58
+#define OP_STD	62
+
+static int get_source_reg(u32 raw_insn)
+{
+	return PPC_RA(raw_insn);
+}
+
+static int get_target_reg(u32 raw_insn)
+{
+	return PPC_RT(raw_insn);
+}
+
+static int get_offset_opcode(u32 raw_insn)
+{
+	int opcode = PPC_OP(raw_insn);
+
+	/* DS- form */
+	if ((opcode == OP_LD) || (opcode == OP_STD))
+		return PPC_DS(raw_insn);
+	else
+		return PPC_D(raw_insn);
+}
+
+/*
+ * Fills the required fields for op_loc depending on if it
+ * is a source or target.
+ * D form: ins RT,D(RA) -> src_reg1 = RA, offset = D, dst_reg1 = RT
+ * DS form: ins RT,DS(RA) -> src_reg1 = RA, offset = DS, dst_reg1 = RT
+ * X form: ins RT,RA,RB -> src_reg1 = RA, src_reg2 = RB, dst_reg1 = RT
+ */
+void get_powerpc_regs(u32 raw_insn, int is_source,
+		struct annotated_op_loc *op_loc)
+{
+	if (is_source)
+		op_loc->reg1 = get_source_reg(raw_insn);
+	else
+		op_loc->reg1 = get_target_reg(raw_insn);
+
+	if (op_loc->multi_regs)
+		op_loc->reg2 = PPC_RB(raw_insn);
+
+	/* TODO: Implement offset handling for X Form */
+	if ((op_loc->mem_ref) && (PPC_OP(raw_insn) != 31))
+		op_loc->offset = get_offset_opcode(raw_insn);
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index d536964df43c..3d98c2bf6035 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,7 +32,8 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS
+    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
+    || EM_HOST == EM_PPC64
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -40,7 +41,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #endif
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS
+    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
+    && EM_HOST != EM_PPC64
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 55f21d8082a2..e47c4697da36 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -90,7 +90,8 @@
 
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
-    && !defined(__loongarch__) && !defined(__mips__)
+    && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
+    && !defined(__powerpc64__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
@@ -117,6 +118,8 @@ int get_arch_regnum(const char *name);
  */
 int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags);
 
+void get_powerpc_regs(u32 raw_insn, int is_source, struct annotated_op_loc *op_loc);
+
 #else /* HAVE_LIBDW_SUPPORT */
 
 static inline int get_dwarf_regnum(const char *name __maybe_unused,
@@ -125,16 +128,12 @@ static inline int get_dwarf_regnum(const char *name __maybe_unused,
 {
 	return -1;
 }
-#endif
 
-#if !defined(__powerpc__) || !defined(HAVE_LIBDW_SUPPORT)
 static inline void get_powerpc_regs(u32 raw_insn __maybe_unused, int is_source __maybe_unused,
 		struct annotated_op_loc *op_loc __maybe_unused)
 {
 	return;
 }
-#else
-void get_powerpc_regs(u32 raw_insn, int is_source, struct annotated_op_loc *op_loc);
 #endif
 
 #endif
-- 
2.47.0.277.g8800431eea-goog

