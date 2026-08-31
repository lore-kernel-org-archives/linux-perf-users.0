Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC051E43A;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188835; cv=none; b=i/mK9hKUolTCfNaH16MmdTAcmvTupNKu48TQHcgUTwZ1E/bn6T/zUTR+9AC3smh8THJWVRkNHIf6hlhQIy4JxUyNO04kklqh9sw77qJZLuUOrqHtHaJOAGe1TY8wb7kvVkKcoxu1ekN2Av0azavKMbpsMDqWlYjzWbEybCP1Q/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188835; c=relaxed/simple;
	bh=wtMd4vTaRd3xvEzJxItxztexDG2Qk3pG2knMAw/LS5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3oHATmDfzohBRlRyRbbJWM5D8bVGOaYuITchYoPOpteJHaA5yeGhCT6lS5fjZn4/Yu5wb1VfyjI3EboTNT40KD4OppQMvz2tPjzRRRvWcHcCo6BsPbqGlMJRJPG5HTnPamCuVbEz35ZIRk8sdKZ3a5+vIex4TkLtKQBMYvtK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id B884C63F8A;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 17A3416228A; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 10/19] ptwrite uprobes: Minimal memory references and fault handling
Date: Mon, 31 Aug 2026 08:04:46 -0700
Message-ID: <20260831150651.1134594-11-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
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

This requires fault handling using the fault notifier hook added
earlier. When a fault happens inside a probe return to a specially
generated tail that logs zeroes.

It increases the in memory overhead of uprobe_ptwrite_page somewhat
(to roughly a KB). I tried to find alternatives, but they all
complicated the code, and 1KB should be still acceptable.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/uprobes.h               |  14 +
 arch/x86/kernel/uprobes.c                    | 308 +++++++++++++++++--
 include/linux/uprobes.h                      |   4 +-
 samples/uprobe-ptwrite/uprobe_ptwrite_test.c |  41 ++-
 4 files changed, 344 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 5cc870e857a5..efffdc44f00a 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -48,6 +48,8 @@ struct uprobe_ptwrite_arch {
 	u8	jmp_off;	/* offset of the final jmp's rel32 field */
 	u8	ndata;		/* number of u64 data slots */
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
+	u16	ft_off;	/* fault table offset within the block (0 if none) */
+	u8	nft;		/* number of fault entries */
 };
 
 /* Per-mm page holding generated ptwrite stub blocks (mirrors trampolines). */
@@ -56,6 +58,18 @@ struct uprobe_ptwrite_page {
 	struct page		*page;		/* stub blocks written via kmap */
 	unsigned long		vaddr;		/* mapping base */
 	u16			cursor;		/* next free block offset */
+	u16			nblocks;
+	struct {
+		u16 off;	/* block offset in the page */
+		u16 len;	/* generated block length */
+		u16 ft_off;	/* fault table offset within the block */
+		u8  orig0;	/* original site byte 0 (pun restore) */
+		u8  pun;	/* instruction-pun mechanism (single-byte poke) */
+		u8  site_len;	/* original instruction length (pun identity) */
+		s32 site_off;	/* probe site - page base (idempotent reinstall) */
+		u8  site_insn[MAX_UINSN_BYTES];	/* original bytes (pun identity) */
+	} index[PAGE_SIZE / 32];	/* exact: min block = 32 B (nargs >= 1), */
+					/* so <= 128 blocks fit a page */
 };
 
 struct arch_uprobe {
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index df652c56414b..90e702a4a8e9 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -24,6 +24,7 @@
 #include <asm/nops.h>
 #include <asm/cpufeature.h>
 #include <asm/cpuid/api.h>
+#include <asm/traps.h>
 
 /* Post-execution fixups. */
 
@@ -727,6 +728,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 
 void arch_uprobe_init_state(struct mm_struct *mm)
 {
+
 	INIT_HLIST_HEAD(&mm->uprobes_state.head_ptwrite);
 }
 
@@ -923,9 +925,12 @@ asm (
 
 extern u8 uprobe_trampoline_entry[];
 
+static struct notifier_block uprobe_user_fault_nb;
+
 static int __init arch_uprobes_init(void)
 {
 	tramp_mapping_pages[0] = virt_to_page(uprobe_trampoline_entry);
+	register_x86_user_fault_notifier(&uprobe_user_fault_nb);
 	return 0;
 }
 
@@ -1259,6 +1264,20 @@ static int ptwrite_emit_riprel(u8 *p, s32 disp)
 	return 9;
 }
 
+static int ptwrite_emit_riprel32(u8 *p, s32 disp)
+{
+	/*
+	 * ptwritel disp32(%rip) : F3 0F AE 25 <disp32> (8 bytes)
+	 * modrm 0x25 = mod 00, reg 100 (/4, PTWRITE), rm 101 (RIP-relative).
+	 */
+	*p++ = 0xf3;
+	*p++ = 0x0f;
+	*p++ = 0xae;
+	*p++ = 0x25;
+	memcpy(p, &disp, 4);
+	return 8;
+}
+
 bool arch_uprobe_ptwrite_supported(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -1293,7 +1312,11 @@ static const struct {
 	{ offsetof(struct pt_regs, r14), 14 }, { offsetof(struct pt_regs, r15), 15 },
 };
 
-/* Compile the register, stack-pointer, and immediate fetch forms. */
+
+/*
+ * Compile one tracefs fetch arg (arch-neutral form, see
+ * uprobe_ptwrite_fetch) into a ptwrite descriptor entry.
+ */
 int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 			      const struct uprobe_ptwrite_fetch *f)
 {
@@ -1301,21 +1324,30 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 
 	switch (f->kind) {
 	case UPROBE_PTW_FETCH_REG:
+	case UPROBE_PTW_FETCH_MEMREG:
 		for (j = 0; j < ARRAY_SIZE(ptwrite_reg_map); j++)
 			if (ptwrite_reg_map[j].off == f->reg) {
 				idx = ptwrite_reg_map[j].idx;
 				break;
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
@@ -1325,15 +1357,43 @@ int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
 	return 0;
 }
 
+
+/*
+ * Worst-case stub block: header ptwriteq (9) + max args of the largest form
+ * (MEM: 5 opcode + SIB + 4 disp + 2 short jmp + 9 fixup = 21 B) + final jmp
+ * (5) -> code; data: header + fault-word slots (16); fault table
+ * [nft][{start,end,fixup} x nft] (2 + 6*nft). Must fit UPROBE_PTWRITE_STUB_SIZE;
+ * prepare() also enforces it with -E2BIG at runtime.
+ */
+static_assert((((9 + UPROBE_PTWRITE_MAX_ARGS * 21 + 5 + 7) & ~7) +
+	       16 + 2 + 6 * UPROBE_PTWRITE_MAX_ARGS) <= UPROBE_PTWRITE_STUB_SIZE,
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
+
+
 int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 				const struct uprobe_ptwrite_desc *desc)
 {
 	struct uprobe_ptwrite_arch *ptw = &auprobe->ptwrite;
 	u8 *code = ptw->stub, *p = ptw->stub;
 	u16 imm_off[UPROBE_PTWRITE_MAX_ARGS];
-	unsigned int data_off;
+	u8 fixup_len[UPROBE_PTWRITE_MAX_ARGS];
+	struct { u16 start, end, fixup; } __packed mft[UPROBE_PTWRITE_MAX_ARGS];
+	u16 mdisp[UPROBE_PTWRITE_MAX_ARGS];
+	unsigned int data_off, flt_off, ft_off;
 	unsigned int hdr_off = 0;
-	unsigned int imm_idx = 0, n_imm = 0;
+	unsigned int imm_idx = 0, n_imm = 0, mem_idx = 0, n_mem = 0;
 	u64 hdr;
 	int i;
 
@@ -1341,7 +1401,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		return -EINVAL;
 	if (desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
 		return -E2BIG;
-	if (desc->flags)
+	if (desc->flags & ~UPROBE_PTWRITE_FL_ALLOW_MEM)
 		return -EINVAL;
 
 	/* The generic registration path copied these bytes before this hook. */
@@ -1358,24 +1418,89 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 				return -E2BIG;
 			n_imm++;
 			break;
+		case UPROBE_PTW_SRC_MEM:
+			if (!(desc->flags & UPROBE_PTWRITE_FL_ALLOW_MEM))
+				return -EINVAL;
+			if (desc->args[i].reg > 15)
+				return -EINVAL;
+			/*
+			 * u64 args use ptwriteq (8-byte load); u32/s32/x32
+			 * args use ptwritel (4-byte load). Any other size
+			 * would read the wrong width.
+			 */
+			if (desc->args[i].size != 4 &&
+			    desc->args[i].size != 8)
+				return -EINVAL;
+			if (n_mem >= ARRAY_SIZE(mft))
+				return -E2BIG;
+			n_mem++;
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
+			/*
+			 * ptwrite[q|l] disp32(%reg), short jump, and fault
+			 * fixup. The largest form is 21 bytes.
+			 */
+			u8 reg = desc->args[i].reg;
+			bool wide = desc->args[i].size == 8;
+			unsigned int arg_len = (wide ? 9 : 8) +
+				((reg & 7) == 4) + 2 + (wide ? 9 : 8);
+			int start;
+
+			if (mem_idx >= ARRAY_SIZE(mft))
+				return -E2BIG;
+			PTW_NEED(arg_len);
+			start = p - code;
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
+			mft[mem_idx].start = start;
+			mdisp[mem_idx] = p - code;
+			p += 4;
+			mft[mem_idx].end = p - code;
+			*p++ = 0xeb;
+			*p++ = wide ? 9 : 8;
+			mft[mem_idx].fixup = p - code;
+			fixup_len[mem_idx] = wide ?
+				ptwrite_emit_riprel(p, 0) :
+				ptwrite_emit_riprel32(p, 0);
+			p += fixup_len[mem_idx];
+			mem_idx++;
+			break;
+		}
 		}
 	}
 
 	/* final jmp back to probe+5; rel32 patched per-mm at install */
+	PTW_NEED(5);
 	*p++ = 0xe9;
 	if (p - code > U8_MAX)
 		return -E2BIG;
@@ -1383,11 +1508,23 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	p += 4;
 
 	data_off = (p - code + 7) & ~7UL;
-	if (data_off + 8 * (1 + n_imm) > sizeof(ptw->stub))
+	/* data: header + imm slots + one shared fault-word slot (0) */
+	if (data_off + 8 * (1 + n_imm + (n_mem ? 1 : 0)) > sizeof(ptw->stub))
 		return -E2BIG;
+	flt_off = data_off + 8 * (1 + n_imm);
 
-	/* data slots: header, then imm values in emission order */
-	hdr = ((u64)desc->event_id << 48) | ((u64)desc->nargs << 40);
+	/* fault table: [u16 nft][{start,end,fixup} x nft], block-relative */
+	ft_off = (flt_off + 8 * (n_mem ? 1 : 0) + 7) & ~7UL;
+	if (ft_off + 2 + 6 * n_mem > sizeof(ptw->stub))
+		return -E2BIG;
+	if (n_mem) {
+		*(u16 *)(code + ft_off) = n_mem;
+		memcpy(code + ft_off + 2, mft, 6 * n_mem);
+	}
+
+	/* data slots: header, imm values in emission order, fault word */
+	hdr = ((u64)desc->event_id << 48) | ((u64)desc->nargs << 40) |
+	      UPROBE_PTW_HDR_MAGIC;
 	*(u64 *)(code + data_off) = hdr;
 
 	/* patch the header's disp32: hdr slot - end of header insn */
@@ -1403,8 +1540,33 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		imm_idx++;
 	}
 
-	ptw->stub_len = data_off + 8 * (1 + n_imm);
-	ptw->ndata = 1 + n_imm;
+	/* memory arg disp32s (absolute vs the base reg) + fixup disp32s */
+	mem_idx = 0;
+	for (i = 0; i < desc->nargs; i++) {
+		s32 disp;
+
+		if (desc->args[i].src != UPROBE_PTW_SRC_MEM)
+			continue;
+		disp = (s32)desc->args[i].val;
+		*(s32 *)(code + mdisp[mem_idx]) = disp;
+		/*
+		 * fixup's RIP-relative disp: flt slot - end of fixup insn.
+		 * disp32 field starts at flen - 4 in both forms
+		 */
+		*(s32 *)(code + mft[mem_idx].fixup + fixup_len[mem_idx] - 4) =
+			(s32)(flt_off - (mft[mem_idx].fixup +
+					fixup_len[mem_idx]));
+		mem_idx++;
+	}
+
+	/* the shared fault word: failed reads emit 0 */
+	if (n_mem)
+		*(u64 *)(code + flt_off) = 0;
+
+	ptw->stub_len = n_mem ? ft_off + 2 + 6 * n_mem : data_off + 8 * (1 + n_imm);
+	ptw->ndata = 1 + n_imm + (n_mem ? 1 : 0);
+	ptw->ft_off = n_mem ? ft_off : 0;
+	ptw->nft = n_mem;
 	return 0;
 }
 #undef PTW_NEED
@@ -1664,6 +1826,7 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	struct uprobe_ptwrite_arch *ptw_a = &auprobe->ptwrite;
 	unsigned long block_off, stub_addr;
 	u8 *kaddr, orig[5];
+	s64 site_delta;
 	s32 rel;
 	int ret;
 
@@ -1689,13 +1852,22 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 		return -ENOMEM;
 
 	block_off = ptw->cursor;
-	if (block_off > PAGE_SIZE ||
-	    ptw_a->stub_len > PAGE_SIZE - block_off)
+	if (block_off > PAGE_SIZE || ptw_a->stub_len > PAGE_SIZE - block_off)
+		return -ENOMEM;
+	if (ptw->nblocks >= ARRAY_SIZE(ptw->index))
 		return -ENOMEM;
 	stub_addr = ptw->vaddr + block_off;
 	if (!ptwrite_rel32(stub_addr + ptw_a->jmp_off + 4,
 			   vaddr + 5, &rel))
 		return -ERANGE;
+	site_delta = (s64)vaddr - (s64)ptw->vaddr;
+	if (site_delta < INT_MIN || site_delta > INT_MAX)
+		return -ERANGE;
+
+	ptw->index[ptw->nblocks].off = block_off;
+	ptw->index[ptw->nblocks].len = ptw_a->stub_len;
+	ptw->index[ptw->nblocks].ft_off = ptw_a->ft_off;
+	ptw->nblocks++;
 
 	kaddr = kmap_local_page(ptw->page);
 	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);
@@ -1704,9 +1876,13 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	kunmap_local(kaddr);
 
 	ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
-	if (!ret)
-		ptw->cursor = block_off + ptw_a->stub_len;
-	return ret;
+	if (ret)
+		/* Publish rollback before readers use the reduced block count. */
+		smp_store_release(&ptw->nblocks, ptw->nblocks - 1);
+		return ret;
+	}
+	ptw->cursor = block_off + ptw_a->stub_len;
+	return 0;
 }
 
 int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
@@ -1724,6 +1900,98 @@ int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
 			UPROBE_SWBP_INSN, false, false, false, false, NULL);
 }
 
+/*
+ * Ptwrite memory faults are fixed up for fault classes routed through the
+ * user-fault notifier. #AC is intentionally not handled: alignment checking
+ * is normally disabled for user processes and is not a supported ptwrite mode.
+ */
+static bool uprobe_ptwrite_handle_fault(struct pt_regs *regs)
+{
+	struct mm_struct *mm = current->mm;
+	struct uprobes_state *state;
+	struct uprobe_ptwrite_page *ptw;
+	unsigned long ip = instruction_pointer(regs);
+	int b;
+
+	if (!mm)
+		return false;
+	state = &mm->uprobes_state;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(ptw, &state->head_ptwrite, node) {
+		unsigned long boff;
+		u16 nblocks;
+
+		if (ip < ptw->vaddr || ip >= ptw->vaddr + PAGE_SIZE)
+			continue;
+		boff = ip - ptw->vaddr;
+		/* Acquire published metadata before scanning blocks in the fault path. */
+		nblocks = smp_load_acquire(&ptw->nblocks);
+		for (b = 0; b < nblocks; b++) {
+			u16 off = ptw->index[b].off;
+			u16 len = ptw->index[b].len;
+			u16 fto = ptw->index[b].ft_off;
+			u8 *kaddr;
+			u16 nft, i;
+
+			/* no fault table, or IP outside this block: not ours */
+			if (!fto || boff < off || boff >= off + len)
+				continue;
+			if (off >= PAGE_SIZE || len > PAGE_SIZE - off ||
+			    len < sizeof(nft) ||
+			    fto > len - sizeof(nft)) {
+				rcu_read_unlock();
+				return false;
+			}
+			kaddr = kmap_local_page(ptw->page);
+			nft = *(u16 *)(kaddr + off + fto);
+			if (nft > UPROBE_PTWRITE_MAX_ARGS ||
+			    nft > (len - fto - sizeof(nft)) / 6) {
+				kunmap_local(kaddr);
+				rcu_read_unlock();
+				return false;
+			}
+			for (i = 0; i < nft; i++) {
+				u16 *e = (u16 *)(kaddr + off + fto +
+						 sizeof(nft) + i * 6);
+
+				if (e[0] >= e[1] || e[1] > len || e[2] >= len) {
+					kunmap_local(kaddr);
+					rcu_read_unlock();
+					return false;
+				}
+				if (boff >= off + e[0] && boff < off + e[1]) {
+					regs->ip = ptw->vaddr + off + e[2];
+					kunmap_local(kaddr);
+					rcu_read_unlock();
+					return true;
+				}
+			}
+			kunmap_local(kaddr);
+			rcu_read_unlock();
+			return false;
+		}
+	}
+	rcu_read_unlock();
+	return false;
+}
+
+static int uprobe_user_fault_notify(struct notifier_block *self,
+				    unsigned long val, void *data)
+{
+	struct x86_user_fault_args *args = data;
+
+	if (!args || !args->regs)
+		return NOTIFY_DONE;
+
+	if (uprobe_ptwrite_handle_fault(args->regs))
+		return NOTIFY_STOP;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block uprobe_user_fault_nb = {
+	.notifier_call = uprobe_user_fault_notify,
+};
 
 static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned long vaddr)
 {
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index c0d65ea5353e..c0d189bef8bd 100644
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
index c3b9dd6bec16..5eafc26104ad 100644
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
@@ -87,6 +89,43 @@ static int parse_probe_args(void)
 			}
 			a->src = UPROBE_PTW_SRC_IMM;
 			a->val = v;
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
+				pr_err("uprobe_ptwrite_test: bad mem reg '%s'\n", tok);
+				goto err;
+			}
+			if (colon && kstrtoll(colon + 1, 0, &disp)) {
+				pr_err("uprobe_ptwrite_test: bad mem disp '%s'\n",
+				       colon + 1);
+				goto err;
+			}
+			if (szs && (kstrtoul(szs, 10, &size) ||
+				   (size != 4 && size != 8))) {
+				pr_err("uprobe_ptwrite_test: bad mem size '%s'\n",
+				       szs);
+				goto err;
+			}
+			a->src = UPROBE_PTW_SRC_MEM;
+			a->reg = reg;
+			a->val = (u64)(s32)disp;
+			a->size = size;
+			desc.flags |= UPROBE_PTWRITE_FL_ALLOW_MEM;
 		} else {
 			pr_err("uprobe_ptwrite_test: bad arg '%s'\n", tok);
 			goto err;
-- 
2.54.0

