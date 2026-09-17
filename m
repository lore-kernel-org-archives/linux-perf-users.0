Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217E4AEBD8;
	Thu, 17 Sep 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686133; cv=none; b=W5J8Zz4js60JcFJFOPbx6FVAERjdcIfDGyR3Xm1l9bV4KjNWX1jqE1S4F5/6Dsu2K/p4OaNjLsZZgPjDxlZn+6cKVi4i7VENGLoiw9Syo56tooSuWaK8daZGIpOkGVQeAC8zBa/umJpwiF7rAxz0U6W1uOMjFbGK6xmBvtJVzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686133; c=relaxed/simple;
	bh=rt6W9pb0Fome6XWolAV4olseXx6hk4vrwAWSFUR4MWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLEgZHiouEV80azCLRXF1DBafC+RIS/WkUXjWzK6F0uZKe3YVtIVZwcVYRpPh5wZ388CYlSkyngi+IpY6TXZyitSDy+FVe1kX8+5gywSohzJU1lqFd0qq8Y6RtXVXm2sSq2nWdpCfK3kkhFlnqBNuQwI/qwXONfLswULJNB9CXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id E6E0F5E8A7;
	Fri, 18 Sep 2026 01:01:54 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 8809E1622BA; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC PATCH v2 06/11] ptwrite uprobes: Add basic memory references
Date: Thu, 17 Sep 2026 16:00:33 -0700
Message-ID: <20260917230127.924985-7-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917230127.924985-1-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for memory references. Currently this is only
simple cases, no indirect memory references or strings,
that would require saving/restoring registers. Only 8 and 4 byte
memory references are supported.

This doesn't have any fault handling yet, so a bad reference
in the probe could result in crashing the application.

It increases the kernel memory overhead of each probe to roughly
1 KB.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 Documentation/trace/uprobetracer.rst         |  7 ++
 arch/x86/include/asm/uprobes.h               |  2 +-
 arch/x86/kernel/uprobes.c                    | 90 +++++++++++++++++---
 include/linux/uprobes.h                      |  4 +-
 samples/uprobe-ptwrite/uprobe_ptwrite_test.c | 40 ++++++++-
 5 files changed, 128 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 56d951d1fa5b..5d891a96c4fe 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -94,6 +94,13 @@ Requirements and restrictions:
 - The probe site must be a 5-byte NOP or a punnable instruction (see
   ptwrite-uprobes.rst). For five ``0x90`` bytes from GCC's
   ``-fpatchable-function-entry=5``, append ``%multinop`` to the offset.
+- FETCHARGS: register names (``%di``, ``%r8``, ...), ``$stack`` (the
+  stack pointer value), immediates (``\IMM``), and memory sources:
+  ``$stackN`` (the Nth stack slot, ``[%rsp + 8N]``) and ``+off(FETCHARG)``
+  dereferences (for example, ``+8(%di)`` = ``[%rdi + 8]``). ``u64`` sources
+  use ``ptwriteq``; ``u32``/``s32``/``x32`` sources use ``ptwritel`` and read
+  four bytes. Strings, bitfields, and indirect dereferences are not supported.
+- Memory accesses can fault.
 - The event does not produce ring-buffer records. It provides a type registry
   (``events/GRP/EVENT/format``) and the wire ``event_id``
   (``events/GRP/EVENT/id``) for an external decoder. Filters and perf
diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index b51907c1d465..e5a668ba5ad6 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -45,7 +45,7 @@ struct uprobe_xol_ops;
  */
 struct uprobe_ptwrite_arch {
 	u8	stub[UPROBE_PTWRITE_STUB_SIZE];
-	u16	stub_len;	/* code + data + fault table, whole block */
+	u16	stub_len;	/* code + data, whole block */
 	u8	jmp_off;	/* offset of the final jmp's rel32 field */
 	u8	ndata;		/* number of u64 data slots */
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 7fcdc4bf5197..0029b66cd64e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1365,7 +1365,10 @@ static const struct {
 	{ .off = offsetof(struct pt_regs, r15), .idx = 15 },
 };
 
-/* Compile the register, stack-pointer, and immediate fetch forms. */
+/*
+ * Compile one tracefs fetch arg (arch-neutral form, see
+ * uprobe_ptwrite_fetch) into a ptwrite descriptor entry.
+ */
 int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 			      const struct uprobe_ptwrite_fetch *f)
 {
@@ -1373,6 +1376,7 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 
 	switch (f->kind) {
 	case UPROBE_PTW_FETCH_REG:
+	case UPROBE_PTW_FETCH_MEMREG:
 		for (i = 0; i < ARRAY_SIZE(ptwrite_reg_map); i++) {
 			if (ptwrite_reg_map[i].off == f->reg) {
 				idx = ptwrite_reg_map[i].idx;
@@ -1380,15 +1384,23 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 			}
 		}
 		if (idx < 0)
-			return -EINVAL;
-		a->src = UPROBE_PTW_SRC_REG;
+			return -EINVAL;	/* not an x86-64 GPR */
+		a->src = f->kind == UPROBE_PTW_FETCH_REG ?
+			 UPROBE_PTW_SRC_REG : UPROBE_PTW_SRC_MEM;
 		a->reg = idx;
+		if (f->kind == UPROBE_PTW_FETCH_MEMREG)
+			a->val = (u64)(s32)f->imm;
 		break;
-	case UPROBE_PTW_FETCH_STACKP:
+	case UPROBE_PTW_FETCH_STACKP:	/* $stack: SP value, never faults */
 		a->src = UPROBE_PTW_SRC_REG;
 		a->reg = 4; /* rsp */
 		break;
-	case UPROBE_PTW_FETCH_IMM:
+	case UPROBE_PTW_FETCH_STACKN:	/* [rsp + imm] */
+		a->src = UPROBE_PTW_SRC_MEM;
+		a->reg = 4;	/* rsp */
+		a->val = f->imm;
+		break;
+	case UPROBE_PTW_FETCH_IMM:	/* \IMM */
 		a->src = UPROBE_PTW_SRC_IMM;
 		a->val = f->imm;
 		break;
@@ -1398,6 +1410,26 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 	return 0;
 }
 
+/*
+ * Worst-case stub block: header ptwriteq (9) + max memory args (10 bytes
+ * each, including a SIB byte) + final jmp (5), rounded up; data adds one
+ * header slot and one slot per immediate. Keep the bound below the stub size.
+ */
+static_assert((((9 + UPROBE_PTWRITE_MAX_ARGS * 10 + 5 + 7) & ~7) +
+	       8 * (1 + UPROBE_PTWRITE_MAX_ARGS)) <= UPROBE_PTWRITE_STUB_SIZE,
+	       "worst-case ptwrite stub block exceeds UPROBE_PTWRITE_STUB_SIZE");
+
+static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
+{
+	return p >= base && (size_t)(p - base) <=
+		       sizeof(((struct uprobe_ptwrite_arch *)0)->stub) - len;
+}
+
+#define PTW_NEED(_len) do { \
+		if (!ptwrite_has_room(code, p, (_len))) \
+			return -E2BIG; \
+	} while (0)
+
 int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 				const struct uprobe_ptwrite_desc *desc)
 {
@@ -1414,7 +1446,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		return -EINVAL;
 	if (desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
 		return -E2BIG;
-	if (desc->flags)
+	if (desc->flags & ~UPROBE_PTWRITE_FL_ALLOW_MEM)
 		return -EINVAL;
 
 	/* The generic registration path copied these bytes before this hook. */
@@ -1431,24 +1463,62 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 				return -E2BIG;
 			n_imm++;
 			break;
+		case UPROBE_PTW_SRC_MEM:
+			if (!(desc->flags & UPROBE_PTWRITE_FL_ALLOW_MEM))
+				return -EINVAL;
+			if (desc->args[i].reg > 15)
+				return -EINVAL;
+			if (desc->args[i].size != 4 &&
+			    desc->args[i].size != 8)
+				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
 	/* header word emission (disp32 patched below) */
+	PTW_NEED(9);
 	p += ptwrite_emit_riprel(p, 0);
 
 	for (i = 0; i < desc->nargs; i++) {
-		if (desc->args[i].src == UPROBE_PTW_SRC_REG) {
+		switch (desc->args[i].src) {
+		case UPROBE_PTW_SRC_REG:
+			PTW_NEED(5);
 			p += ptwrite_emit_reg(p, desc->args[i].reg);
-		} else {
+			break;
+		case UPROBE_PTW_SRC_IMM:
+			if (imm_idx >= ARRAY_SIZE(imm_off))
+				return -E2BIG;
+			PTW_NEED(9);
 			imm_off[imm_idx++] = p - code;
 			p += ptwrite_emit_riprel(p, 0);
+			break;
+		case UPROBE_PTW_SRC_MEM: {
+			u8 reg = desc->args[i].reg;
+			bool wide = desc->args[i].size == 8;
+			unsigned int arg_len = (wide ? 9 : 8) +
+				((reg & 7) == 4) + (!wide && (reg & 8));
+
+			PTW_NEED(arg_len);
+			*p++ = 0xf3;
+			if (wide)
+				*p++ = (reg & 8) ? 0x49 : 0x48; /* REX.W */
+			else if (reg & 8)
+				*p++ = 0x41; /* REX.B only (32-bit operand) */
+			*p++ = 0x0f;
+			*p++ = 0xae;
+			*p++ = 0xa0 | (reg & 7); /* mod 10, reg /4, rm reg */
+			if ((reg & 7) == 4) /* SIB escape: base rsp/esp/r12 */
+				*p++ = 0x24;
+			p += 4;
+			break;
+		}
 		}
 	}
 
 	/* final jmp back to probe+5; rel32 patched per-mm at install */
+	PTW_NEED(5);
 	*p++ = 0xe9;
 	if (p - code > U8_MAX)
 		return -E2BIG;
@@ -1460,7 +1530,8 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		return -E2BIG;
 
 	/* data slots: header, then imm values in emission order */
-	hdr = ((u64)desc->event_id << 48) | ((u64)desc->nargs << 40);
+	hdr = ((u64)desc->event_id << 48) | ((u64)desc->nargs << 40) |
+	      UPROBE_PTW_HDR_MAGIC;
 	*(u64 *)(code + data_off) = hdr;
 
 	/* patch the header's disp32: hdr slot - end of header insn */
@@ -1755,7 +1826,6 @@ int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
 			UPROBE_SWBP_INSN, false, false, false, false, NULL);
 }
 
-
 static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned long vaddr)
 {
 	struct __packed __arch_relative_insn {
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 6fa70f3f648c..f6ffb0637991 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -213,10 +213,10 @@ enum uprobe_ptwrite_src {
 
 struct uprobe_ptwrite_arg {
 	u8	src;		/* enum uprobe_ptwrite_src */
-	u8	reg;		/* x86-64 GPR index (0=rax..15=r15) for SRC_REG */
+	u8	reg;		/* x86-64 GPR index (0=rax..15=r15) for SRC_REG/SRC_MEM */
 	u8	size;		/* declared type size 1/2/4/8 (decoder hint) */
 	u8	reserved;
-	u64	val;		/* SRC_IMM: constant; SRC_REG: unused */
+	u64	val;		/* SRC_IMM: constant, SRC_MEM: disp32 (low 32 bits) */
 };
 
 struct uprobe_ptwrite_desc {
diff --git a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
index 94d01bf18faa..55e23ff27dd5 100644
--- a/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
+++ b/samples/uprobe-ptwrite/uprobe_ptwrite_test.c
@@ -11,9 +11,11 @@
  * Usage (module params):
  *   path=/path/to/prog   file to probe
  *   offset=0xADDR        file offset of the probe site
- *   args="r0,r1,i0x42"             comma-separated;
+ *   args="r0,r1,i0x42,m3,m2:0x8,m4:0x10:4"   comma-separated;
  *                        r<N> = x86-64 GPR index 0..15,
  *                        i<hex> = immediate constant,
+ *                        m<N>[:<disp>][:<size>] = memory arg [reg + disp32],
+ *                        size 4 (u32 load) or 8 (u64 load, default)
  *   event_id=0x1234      identifier carried in the PTW header word
  */
 #include <linux/module.h>
@@ -81,7 +83,41 @@ static int parse_probe_args(void)
 			}
 			a->src = UPROBE_PTW_SRC_IMM;
 			a->val = v;
-
+		} else if (tok[0] == 'm') {
+			/*
+			 * m<R>[:<disp>][:<size>]: memory arg [reg + disp32],
+			 * size 4 (u32 load) or 8 (u64 load, default)
+			 */
+			char *colon = strchr(tok, ':');
+			char *szs = NULL;
+			unsigned long reg;
+			long long disp = 0;
+			unsigned long size = 8;
+
+			if (colon) {
+				*colon = '\0';
+				szs = strchr(colon + 1, ':');
+				if (szs)
+					*szs++ = '\0';
+			}
+			if (kstrtoul(tok + 1, 10, &reg) || reg > 15) {
+				pr_err("bad mem reg '%s'\n", tok);
+				goto err;
+			}
+			if (colon && kstrtoll(colon + 1, 0, &disp)) {
+				pr_err("bad mem disp '%s'\n", colon + 1);
+				goto err;
+			}
+			if (szs && (kstrtoul(szs, 10, &size) ||
+				    (size != 4 && size != 8))) {
+				pr_err("bad mem size '%s'\n", szs);
+				goto err;
+			}
+			a->src = UPROBE_PTW_SRC_MEM;
+			a->reg = reg;
+			a->val = (u64)(s32)disp;
+			a->size = size;
+			desc.flags |= UPROBE_PTWRITE_FL_ALLOW_MEM;
 		} else {
 			pr_err("bad arg '%s'\n", tok);
 			goto err;
-- 
2.54.0

