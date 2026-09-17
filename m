Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81F4A9D43;
	Thu, 17 Sep 2026 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686564; cv=none; b=EjcM4QweBm96ZK5poC+HsIPecnCUwPX6LnmbYjdEd4kwgGrP0AgCdVX0KeM2zfmgtemLdxtwjCIx6JnH+ALrEwMAWNG1B8IQDu/cQehAH3dTKXVMpyv8MZ0bgoEYRf+fWWw1/OU2XB16kAP+QIzrwCzqGSX+Ltoz1OaubYYxVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686564; c=relaxed/simple;
	bh=Shvxzx/POpO+RUjWvd3w51d65noLBa8fzkpEzBxMEI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfe1F+c2q6DM9dsOg6ZyZByYRheDctXhgM2badtV0PzXDR+/F94QtmFwkFL1lYtkh3RNboz/g0b7AtocOwg1DYVHXJilEdN9elAZDUQ8OcG6n9GvAYSa5Lb3PPoWFPCRan1OYzfpUvve8Rbcx4yetxM2MwJR3GB6IixcWsP0xZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 11E725E89E;
	Fri, 18 Sep 2026 01:01:52 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 7BB3016229D; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/11] ptwrite uprobes: Add minimal low level support for x86
Date: Thu, 17 Sep 2026 16:00:29 -0700
Message-ID: <20260917230127.924985-3-ak@kernel.org>
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

Add more data structures and the x86 machinery to generate the PTWRITE
instructions for a ptwrite uprobe. The probe executes PTWRITEs and then
jumps back to the original code. In this variant only patching
5 byte nops is supported.

The instructions are pre-generated to templates and then patched when
setting up the final user page.

The patching code uses 3 phase patching similar to int3_update.

The ptwrite stub emits a header with a magic value and the number of
arguments, and then the actual probed values.

There is no separate config option for ptwrite uprobes, it is just tied
to the main uprobes config.

Some limitations in the current implementation:
- The probed 5 byte area cannot cross a page.
- The allocated stubs in the user program are only freed on exit.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/mmu_context.h |  17 +-
 arch/x86/include/asm/uprobes.h     |  26 ++
 arch/x86/kernel/uprobes.c          | 654 +++++++++++++++++++++++++++++
 4 files changed, 697 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..7fda5edb0c06 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -102,6 +102,7 @@ config X86
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
+	select ARCH_HAS_UPROBES_PTWRITE		if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index ef5b507de34e..5a5b7e2a4f5d 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -215,12 +215,27 @@ static inline void arch_dup_pkeys(struct mm_struct *oldmm,
 #endif
 }
 
+/* Put here to avoid asm/uprobes.h's dependencies */
+extern int uprobe_ptwrite_dup_mmap(struct mm_struct *oldmm,
+				   struct mm_struct *newmm);
+
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
+	int ret;
+
 	arch_dup_pkeys(oldmm, mm);
 	paravirt_enter_mmap(mm);
 	dup_lam(oldmm, mm);
-	return ldt_dup_context(oldmm, mm);
+
+	ret = ldt_dup_context(oldmm, mm);
+	if (ret)
+		return ret;
+#ifdef CONFIG_UPROBES
+	ret = uprobe_ptwrite_dup_mmap(oldmm, mm);
+	if (ret)
+		return ret;
+#endif
+	return 0;
 }
 
 static inline void arch_exit_mmap(struct mm_struct *mm)
diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 362210c79998..20d086a945c5 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -11,6 +11,7 @@
  */
 
 #include <linux/notifier.h>
+#include <linux/rcupdate.h>
 
 typedef u8 uprobe_opcode_t;
 
@@ -23,10 +24,34 @@ typedef u8 uprobe_opcode_t;
 enum {
 	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
 	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  = 1,
+	ARCH_UPROBE_FLAG_PTWRITE        = 2,
 };
 
 struct uprobe_xol_ops;
 
+/*
+ * ptwrite probe state. The stub template (code + data slots) is built
+ * once at registration (mm-independent except the final jmp's rel32, patched
+ * per-mm at install). Block layout:
+ *   [ptwriteq hdr(%rip)] [arg emissions] [jmp probe+5] [u64 slots: header, imms]
+ */
+struct uprobe_ptwrite_arch {
+	u8	stub[256];
+	u8	stub_len;	/* code + data, whole block */
+	u8	jmp_off;	/* offset of the final jmp's rel32 field */
+	u8	ndata;		/* number of u64 data slots */
+	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
+};
+
+/* Per-mm page holding generated ptwrite stub blocks, like tramp_mapping. */
+struct uprobe_ptwrite_page {
+	struct hlist_node	node;
+	struct rcu_head		rcu;
+	struct page		*page;		/* stub blocks written via kmap */
+	unsigned long		vaddr;		/* mapping base */
+	u16			cursor;		/* next free block offset */
+};
+
 struct arch_uprobe {
 	union {
 		u8			insn[MAX_UINSN_BYTES];
@@ -51,6 +76,7 @@ struct arch_uprobe {
 		}			push;
 	};
 
+	struct uprobe_ptwrite_arch	ptwrite;
 	unsigned long flags;
 };
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 65a2de82ecd2..7fcdc4bf5197 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -15,11 +15,15 @@
 #include <linux/syscalls.h>
 
 #include <linux/kdebug.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/mmu_context.h>
 #include <asm/nops.h>
+#include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 
 /* Post-execution fixups. */
 
@@ -719,6 +723,134 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 				&tramp_mapping);
 }
 
+void arch_uprobe_init_state(struct mm_struct *mm)
+{
+	INIT_HLIST_HEAD(&mm->uprobes_state.head_ptwrite);
+}
+
+static void free_uprobe_ptwrite_page_rcu(struct rcu_head *rcu)
+{
+	struct uprobe_ptwrite_page *ptw =
+		container_of(rcu, struct uprobe_ptwrite_page, rcu);
+
+	__free_page(ptw->page);
+	kfree(ptw);
+}
+
+void arch_uprobe_clear_state(struct mm_struct *mm)
+{
+	struct uprobes_state *state = &mm->uprobes_state;
+	struct uprobe_ptwrite_page *ptw;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(ptw, n, &state->head_ptwrite, node) {
+		hlist_del_rcu(&ptw->node);
+		call_rcu(&ptw->rcu, free_uprobe_ptwrite_page_rcu);
+	}
+}
+
+static vm_fault_t ptwrite_fault(const struct vm_special_mapping *sm,
+				struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct uprobes_state *state = &vma->vm_mm->uprobes_state;
+	struct uprobe_ptwrite_page *ptw;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(ptw, &state->head_ptwrite, node) {
+		if (ptw->vaddr == vma->vm_start) {
+			vmf->page = ptw->page;
+			get_page(vmf->page);
+			rcu_read_unlock();
+			return 0;
+		}
+	}
+	rcu_read_unlock();
+	return VM_FAULT_SIGBUS;
+}
+
+static int ptwrite_mremap(const struct vm_special_mapping *sm,
+			  struct vm_area_struct *new_vma)
+{
+	return -EPERM;
+}
+
+static const struct vm_special_mapping ptwrite_mapping = {
+	.name	= "[uprobes-ptwrite]",
+	.fault	= ptwrite_fault,
+	.mremap	= ptwrite_mremap,
+};
+
+static bool __in_uprobe_ptwrite(struct mm_struct *mm, unsigned long ip)
+{
+	struct vm_area_struct *vma = vma_lookup(mm, ip);
+
+	return vma && vma_is_special_mapping(vma, &ptwrite_mapping);
+}
+
+static struct vm_area_struct *
+install_uprobe_ptwrite_vma(struct mm_struct *mm, unsigned long addr)
+{
+	return _install_special_mapping(mm, addr, PAGE_SIZE,
+			VM_READ | VM_EXEC | VM_MAYEXEC | VM_MAYREAD |
+			VM_IO | VM_DONTCOPY, &ptwrite_mapping);
+}
+
+int uprobe_ptwrite_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
+{
+	struct uprobes_state *old_state = &oldmm->uprobes_state;
+	struct uprobes_state *new_state = &newmm->uprobes_state;
+	struct uprobe_ptwrite_page *ptw, *new;
+	struct vm_area_struct *vma;
+	struct hlist_node *n;
+
+	mmap_assert_write_locked(oldmm);
+	mmap_assert_write_locked(newmm);
+	hlist_for_each_entry(ptw, &old_state->head_ptwrite, node) {
+		void *src, *dst;
+
+		/*
+		 * Not using __GFP_ACCOUNT here because it triggered
+		 * a deadlock.
+		 */
+		new = kzalloc_obj(*new, GFP_KERNEL);
+		if (!new)
+			goto fail;
+		new->page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!new->page) {
+			kfree(new);
+			goto fail;
+		}
+
+		src = kmap_local_page(ptw->page);
+		dst = kmap_local_page(new->page);
+		memcpy(dst, src, PAGE_SIZE);
+		kunmap_local(dst);
+		kunmap_local(src);
+		new->vaddr = ptw->vaddr;
+		new->cursor = ptw->cursor;
+
+		vma = install_uprobe_ptwrite_vma(newmm, new->vaddr);
+		if (IS_ERR(vma)) {
+			__free_page(new->page);
+			kfree(new);
+			goto fail;
+		}
+
+		/* Publish the copied page fields before readers can find it. */
+		smp_wmb();
+		hlist_add_head_rcu(&new->node, &new_state->head_ptwrite);
+	}
+
+	return 0;
+
+fail:
+	hlist_for_each_entry_safe(new, n, &new_state->head_ptwrite, node) {
+		WARN_ON_ONCE(do_munmap(newmm, new->vaddr, PAGE_SIZE, NULL));
+	}
+	arch_uprobe_clear_state(newmm);
+	return -ENOMEM;
+}
+
 static bool __in_uprobe_trampoline(struct mm_struct *mm, unsigned long ip)
 {
 	struct vm_area_struct *vma = vma_lookup(mm, ip);
@@ -869,11 +1001,13 @@ enum {
 	EXPECT_SWBP,
 	EXPECT_OPTIMIZED,
 	EXPECT_SWBP_OPTIMIZED,
+	EXPECT_BYTE,
 };
 
 struct write_opcode_ctx {
 	unsigned long base;
 	int expect;
+	u8 expect_byte;
 };
 
 /*
@@ -901,6 +1035,10 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 		if (is_swbp_opt_insns(&old_opcode[0]))
 			return 1;
 		break;
+	case EXPECT_BYTE:
+		if (old_opcode[0] == ctx->expect_byte)
+			return 1;
+		break;
 	}
 
 	return -1;
@@ -1064,6 +1202,53 @@ static int int3_update_unoptimize(struct arch_uprobe *auprobe, struct vm_area_st
 	return 0;
 }
 
+/*
+ * Modify a five-byte instruction by using INT3 breakpoints on SMP.
+ * The caller supplies the byte expected before the update and controls
+ * whether the anonymous page and reference counter are updated on the
+ * final write.
+ */
+static int text_poke_5byte(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+				   unsigned long vaddr, u8 *new5, u8 expect_byte,
+				   bool skip_int3, bool is_register, bool final_is_register,
+				   bool do_update_ref_ctr, bool *first_phase_done)
+{
+	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+		.expect = EXPECT_BYTE,
+		.expect_byte = expect_byte,
+	};
+	int err;
+
+	if (!skip_int3) {
+		err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
+				   is_register, false, &ctx);
+		if (err)
+			return err;
+	}
+	if (first_phase_done)
+		*first_phase_done = true;
+
+	smp_text_poke_sync_each_cpu();
+
+	ctx.expect = EXPECT_SWBP;
+	err = uprobe_write(auprobe, vma, vaddr + 1, new5 + 1, 4, verify_insn,
+			   is_register, false, &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+
+	err = uprobe_write(auprobe, vma, vaddr, new5, 1, verify_insn,
+			   final_is_register, do_update_ref_ctr, &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+	return 0;
+}
+
 static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			 unsigned long vaddr, unsigned long tramp)
 {
@@ -1102,6 +1287,475 @@ static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst,
 	return 0;
 }
 
+/*
+ * ptwrite uprobes: trap-free user-mode instrumentation.
+ *
+ * Block layout (mm-independent template, built at registration):
+ *   ptwriteq hdr(%rip)      ; header: event_id<<48 | nargs<<40 | magic
+ *   ptwriteq %reg / imm(%rip)   ; one per arg
+ *   jmp probe+5             ; rel32 patched per-mm at install
+ *   [u64 slots: header, imm values]
+ */
+
+static int ptwrite_emit_reg(u8 *p, u8 reg)
+{
+	/* ptwriteq %reg : F3 REX.W[.B] 0F AE /4, modrm = 11 100 rrr */
+	*p++ = 0xf3;
+	*p++ = (reg & 8) ? 0x49 : 0x48;	/* REX.W, +REX.B for r8-r15 */
+	*p++ = 0x0f;
+	*p++ = 0xae;
+	*p++ = 0xe0 | (reg & 7);
+	return 5;
+}
+
+static int ptwrite_emit_riprel(u8 *p, s32 disp)
+{
+	/*
+	 * ptwriteq disp32(%rip) : F3 48 0F AE 25 <disp32> (9 bytes)
+	 * modrm 0x25 = mod 00, reg 100 (/4, PTWRITE), rm 101 (RIP-relative).
+	 */
+	*p++ = 0xf3;
+	*p++ = 0x48;
+	*p++ = 0x0f;
+	*p++ = 0xae;
+	*p++ = 0x25;
+	memcpy(p, &disp, 4);
+	return 9;
+}
+
+bool arch_uprobe_ptwrite_supported(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!boot_cpu_has(X86_FEATURE_INTEL_PT))
+		return false;
+	if (boot_cpu_data.cpuid_level < 0x14)
+		return false;
+
+	/* CPUID.(EAX=14H, ECX=0):EBX[4] = PTWRITE */
+	cpuid_count(0x14, 0, &eax, &ebx, &ecx, &edx);
+	return !!(ebx & BIT(4));
+}
+
+/*
+ * x86-64 pt_regs member offset -> GPR index (0=rax..15=r15), matching
+ * the uprobe_ptwrite_arg.reg convention used by the stub generator.
+ * The offsets are what the generic trace-probe register parser
+ * (regs_query_register_offset) puts into FETCH_OP_REG.params.
+ */
+static const struct {
+	unsigned int off;
+	u8 idx;
+} ptwrite_reg_map[] = {
+	{ .off = offsetof(struct pt_regs, ax), .idx = 0 },
+	{ .off = offsetof(struct pt_regs, cx), .idx = 1 },
+	{ .off = offsetof(struct pt_regs, dx), .idx = 2 },
+	{ .off = offsetof(struct pt_regs, bx), .idx = 3 },
+	{ .off = offsetof(struct pt_regs, sp), .idx = 4 },
+	{ .off = offsetof(struct pt_regs, bp), .idx = 5 },
+	{ .off = offsetof(struct pt_regs, si), .idx = 6 },
+	{ .off = offsetof(struct pt_regs, di), .idx = 7 },
+	{ .off = offsetof(struct pt_regs, r8), .idx = 8 },
+	{ .off = offsetof(struct pt_regs, r9), .idx = 9 },
+	{ .off = offsetof(struct pt_regs, r10), .idx = 10 },
+	{ .off = offsetof(struct pt_regs, r11), .idx = 11 },
+	{ .off = offsetof(struct pt_regs, r12), .idx = 12 },
+	{ .off = offsetof(struct pt_regs, r13), .idx = 13 },
+	{ .off = offsetof(struct pt_regs, r14), .idx = 14 },
+	{ .off = offsetof(struct pt_regs, r15), .idx = 15 },
+};
+
+/* Compile the register, stack-pointer, and immediate fetch forms. */
+int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
+			      const struct uprobe_ptwrite_fetch *f)
+{
+	int i, idx = -1;
+
+	switch (f->kind) {
+	case UPROBE_PTW_FETCH_REG:
+		for (i = 0; i < ARRAY_SIZE(ptwrite_reg_map); i++) {
+			if (ptwrite_reg_map[i].off == f->reg) {
+				idx = ptwrite_reg_map[i].idx;
+				break;
+			}
+		}
+		if (idx < 0)
+			return -EINVAL;
+		a->src = UPROBE_PTW_SRC_REG;
+		a->reg = idx;
+		break;
+	case UPROBE_PTW_FETCH_STACKP:
+		a->src = UPROBE_PTW_SRC_REG;
+		a->reg = 4; /* rsp */
+		break;
+	case UPROBE_PTW_FETCH_IMM:
+		a->src = UPROBE_PTW_SRC_IMM;
+		a->val = f->imm;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				const struct uprobe_ptwrite_desc *desc)
+{
+	struct uprobe_ptwrite_arch *ptw = &auprobe->ptwrite;
+	u8 *code = ptw->stub, *p = ptw->stub;
+	u16 imm_off[UPROBE_PTWRITE_MAX_ARGS];
+	unsigned int data_off;
+	unsigned int hdr_off = 0;
+	unsigned int imm_idx = 0, n_imm = 0;
+	u64 hdr;
+	int i;
+
+	if (!desc || desc->nargs == 0)
+		return -EINVAL;
+	if (desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
+		return -E2BIG;
+	if (desc->flags)
+		return -EINVAL;
+
+	/* The generic registration path copied these bytes before this hook. */
+	memcpy(ptw->orig, auprobe->insn, sizeof(ptw->orig));
+
+	for (i = 0; i < desc->nargs; i++) {
+		switch (desc->args[i].src) {
+		case UPROBE_PTW_SRC_REG:
+			if (desc->args[i].reg > 15)
+				return -EINVAL;
+			break;
+		case UPROBE_PTW_SRC_IMM:
+			if (n_imm >= ARRAY_SIZE(imm_off))
+				return -E2BIG;
+			n_imm++;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* header word emission (disp32 patched below) */
+	p += ptwrite_emit_riprel(p, 0);
+
+	for (i = 0; i < desc->nargs; i++) {
+		if (desc->args[i].src == UPROBE_PTW_SRC_REG) {
+			p += ptwrite_emit_reg(p, desc->args[i].reg);
+		} else {
+			imm_off[imm_idx++] = p - code;
+			p += ptwrite_emit_riprel(p, 0);
+		}
+	}
+
+	/* final jmp back to probe+5; rel32 patched per-mm at install */
+	*p++ = 0xe9;
+	if (p - code > U8_MAX)
+		return -E2BIG;
+	ptw->jmp_off = p - code;
+	p += 4;
+
+	data_off = (p - code + 7) & ~7UL;
+	if (data_off + 8 * (1 + n_imm) > sizeof(ptw->stub))
+		return -E2BIG;
+
+	/* data slots: header, then imm values in emission order */
+	hdr = ((u64)desc->event_id << 48) | ((u64)desc->nargs << 40);
+	*(u64 *)(code + data_off) = hdr;
+
+	/* patch the header's disp32: hdr slot - end of header insn */
+	*(s32 *)(code + hdr_off + 5) = (s32)(data_off - (hdr_off + 9));
+
+	imm_idx = 0;
+	for (i = 0; i < desc->nargs; i++) {
+		if (desc->args[i].src != UPROBE_PTW_SRC_IMM)
+			continue;
+		*(s32 *)(code + imm_off[imm_idx] + 5) =
+			(s32)((data_off + 8 * (1 + imm_idx)) - (imm_off[imm_idx] + 9));
+		*(u64 *)(code + data_off + 8 * (1 + imm_idx)) = desc->args[i].val;
+		imm_idx++;
+	}
+
+	ptw->stub_len = data_off + 8 * (1 + n_imm);
+	ptw->ndata = 1 + n_imm;
+	return 0;
+}
+#undef PTW_NEED
+
+/*
+ * Find a free PAGE_SIZE area in @mm within +/-2GB of the probe (so the jmp
+ * rel32 at the probe can reach the stub). Caller holds mmap_write_lock(mm).
+ * Returns an address or a negative errno encoded as unsigned long.
+ */
+static unsigned long find_ptwrite_page_area(struct mm_struct *mm,
+					    unsigned long vaddr)
+{
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma;
+	unsigned long low, high, prev, call_end;
+	const unsigned long call_range = (unsigned long)INT_MAX + 1;
+
+	mmap_assert_write_locked(mm);
+	if (check_add_overflow(vaddr, 5UL, &call_end))
+		return -ENOMEM;
+	if (call_end < call_range)
+		low = PAGE_SIZE;
+	else
+		low = call_end - call_range;
+	if (low < PAGE_SIZE)
+		low = PAGE_SIZE;
+	if (low > ULONG_MAX - (PAGE_SIZE - 1))
+		return -ENOMEM;
+	low = PAGE_ALIGN(low);
+
+	if (check_add_overflow(call_end, (unsigned long)INT_MAX, &high))
+		high = ULONG_MAX;
+	high = min(high, TASK_SIZE_MAX);
+	if (low >= high)
+		return -ENOMEM;
+
+	prev = low;
+	for_each_vma(vmi, vma) {
+		if (vma->vm_start >= high)
+			break;
+		if (vma->vm_end <= prev)
+			continue;
+		if (vma->vm_start > prev && vma->vm_start - prev >= PAGE_SIZE)
+			return prev;
+		if (vma->vm_end > prev) {
+			if (vma->vm_end > ULONG_MAX - (PAGE_SIZE - 1))
+				return -ENOMEM;
+			prev = PAGE_ALIGN(vma->vm_end);
+			if (prev >= high)
+				return -ENOMEM;
+		}
+	}
+	if (prev < high && high - prev >= PAGE_SIZE)
+		return prev;
+	return -ENOMEM;
+}
+
+static struct uprobe_ptwrite_page *
+create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
+{
+	struct uprobe_ptwrite_page *ptw;
+	struct vm_area_struct *vma;
+	unsigned long area;
+
+	area = find_ptwrite_page_area(mm, vaddr);
+	if (IS_ERR_VALUE(area))
+		return NULL;
+
+	mmap_assert_write_locked(mm);
+
+	ptw = kzalloc_obj(*ptw, GFP_KERNEL);
+	if (!ptw)
+		return NULL;
+
+	ptw->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
+	if (!ptw->page) {
+		kfree(ptw);
+		return NULL;
+	}
+	ptw->vaddr = area;
+
+	vma = install_uprobe_ptwrite_vma(mm, area);
+	if (IS_ERR(vma)) {
+		__free_page(ptw->page);
+		kfree(ptw);
+		return NULL;
+	}
+	return ptw;
+}
+static struct uprobe_ptwrite_page *
+get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
+			unsigned int len)
+{
+	struct uprobes_state *state = &mm->uprobes_state;
+	struct uprobe_ptwrite_page *ptw;
+	mmap_assert_write_locked(mm);
+
+	/* a block larger than a page can never be placed */
+	if (len > PAGE_SIZE)
+		return NULL;
+
+	/* Both helpers use the signed 32-bit range of the generated jump. */
+	hlist_for_each_entry(ptw, &state->head_ptwrite, node)
+		if (is_reachable_by_call(ptw->vaddr + ptw->cursor, vaddr) &&
+		    ptw->cursor + len <= PAGE_SIZE)
+			return ptw;
+
+	/* no reachable page with room: allocate a fresh one (cursor 0) */
+	ptw = create_uprobe_ptwrite_page(mm, vaddr);
+	if (!ptw)
+		return NULL;
+	/* Order page initialization before publishing the page on the RCU list. */
+	smp_wmb();
+
+	hlist_add_head_rcu(&ptw->node, &state->head_ptwrite);
+	return ptw;
+}
+
+/* Probe site must be a 5-byte NOP that does not cross a page boundary. */
+static int ptwrite_validate_site(const u8 *orig, unsigned long vaddr)
+{
+	struct insn insn;
+	int ret;
+	int off = 0;
+
+	/*
+	 * The 5 displaced bytes must be NOPs: either one 5-byte NOP
+	 * (nopl 0x0(%rax,%rax,1)) or a run of shorter NOPs summing to
+	 * exactly 5 (gcc -fpatchable-function-entry=5 emits 5 x 0x90 on
+	 * modern toolchains). Any non-NOP byte, or a NOP crossing the
+	 * 5-byte window, is rejected.
+	 */
+	while (off < 5) {
+		ret = insn_decode(&insn, orig + off, 5 - off, INSN_MODE_64);
+		if (ret < 0)
+			return -EINVAL;
+		if (insn.length < 1 || insn.length > 5 - off ||
+		    !insn_is_nop(&insn))
+			return -EINVAL;
+		off += insn.length;
+	}
+	if (off != 5)
+		return -EINVAL;
+	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < 5)
+		return -EINVAL;
+	return 0;
+}
+
+static bool ptwrite_rel32(unsigned long from, unsigned long to, s32 *rel)
+{
+	s64 delta = (s64)to - (s64)from;
+
+	if (delta < INT_MIN || delta > INT_MAX)
+		return false;
+	*rel = (s32)delta;
+	return true;
+}
+
+static bool ptwrite_is_installed(struct mm_struct *mm, unsigned long vaddr,
+				 const u8 *insn5)
+{
+	struct __packed __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} *jmp = (struct __arch_relative_insn *)insn5;
+	s64 target;
+
+	if (jmp->op != 0xe9)
+		return false;
+	target = (s64)vaddr + 5 + (s64)jmp->raddr;
+	if (target < PAGE_SIZE || target >= TASK_SIZE_MAX)
+		return false;
+	return __in_uprobe_ptwrite(mm, (unsigned long)target);
+}
+
+/*
+ * Install a JMP rel32 at the probe site using the 3-phase SMP-safe poke.
+ * On failure, restores the original instruction so the site is never
+ * left half-poked.
+ */
+static int ptwrite_text_poke(struct arch_uprobe *auprobe,
+			     struct vm_area_struct *vma, unsigned long vaddr,
+			     unsigned long stub_addr)
+{
+	u8 jmp5[5] = { 0xe9, 0, 0, 0, 0 };
+	bool first_phase_done;
+	s32 rel;
+	int err;
+
+	if (!ptwrite_rel32(vaddr + 5, stub_addr, &rel))
+		return -ERANGE;
+	memcpy(jmp5 + 1, &rel, 4);
+
+	err = text_poke_5byte(auprobe, vma, vaddr, jmp5,
+			      auprobe->ptwrite.orig[0], false, true, true,
+			      false, &first_phase_done);
+	if (err && first_phase_done) {
+		int restore_err;
+
+		/* Restore only after INT3 was successfully installed. */
+		restore_err = text_poke_5byte(auprobe, vma, vaddr,
+				auprobe->ptwrite.orig, UPROBE_SWBP_INSN,
+				true, true, true, false, NULL);
+		if (restore_err)
+			return restore_err;
+	}
+	return err;
+}
+
+int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
+		struct vm_area_struct *vma, unsigned long vaddr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct uprobe_ptwrite_page *ptw;
+	struct uprobe_ptwrite_arch *ptw_a = &auprobe->ptwrite;
+	unsigned long block_off, stub_addr;
+	u8 *kaddr, orig[5];
+	s32 rel;
+	int ret;
+
+	if (!is_64bit_mm(mm))
+		return -EOPNOTSUPP;
+	/* A three-phase poke and this single-page read both require one page. */
+	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < 5)
+		return -EINVAL;
+	mmap_assert_write_locked(mm);
+
+	ret = copy_from_vaddr(mm, vaddr, orig, sizeof(orig));
+	if (ret)
+		return ret;
+	if (ptwrite_is_installed(mm, vaddr, orig))
+		return 0;
+
+	ret = ptwrite_validate_site(orig, vaddr);
+	if (ret)
+		return ret;
+
+	ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
+	if (!ptw)
+		return -ENOMEM;
+
+	block_off = ptw->cursor;
+	if (block_off > PAGE_SIZE ||
+	    ptw_a->stub_len > PAGE_SIZE - block_off)
+		return -ENOMEM;
+	stub_addr = ptw->vaddr + block_off;
+	if (!ptwrite_rel32(stub_addr + ptw_a->jmp_off + 4,
+			   vaddr + 5, &rel))
+		return -ERANGE;
+
+	kaddr = kmap_local_page(ptw->page);
+	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);
+	/* ptwrite_mapping rejects mremap, so this per-mm rel32 remains valid. */
+	memcpy(kaddr + block_off + ptw_a->jmp_off, &rel, sizeof(rel));
+	kunmap_local(kaddr);
+
+	ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
+	if (!ret)
+		ptw->cursor = block_off + ptw_a->stub_len;
+	return ret;
+}
+
+int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
+		struct vm_area_struct *vma, unsigned long vaddr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	u8 cur[5];
+
+	mmap_assert_write_locked(mm);
+	if (copy_from_vaddr(mm, vaddr, cur, sizeof(cur)) ||
+	    !ptwrite_is_installed(mm, vaddr, cur))
+		return 0;
+
+	return text_poke_5byte(auprobe, vma, vaddr, auprobe->ptwrite.orig,
+			UPROBE_SWBP_INSN, false, false, false, false, NULL);
+}
+
+
 static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned long vaddr)
 {
 	struct __packed __arch_relative_insn {
-- 
2.54.0

