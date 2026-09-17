Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB13A7D91;
	Thu, 17 Sep 2026 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686563; cv=none; b=Vkvu1hiSMbv34xeojjFUgvMGde+4LNHPsGfBFUklD2UvQh2IMPs4AKjXYM9w7Q7mv5UrnjgVVYmHYzFpmKg4noh9fhJ0NudIydQGcrggRm6fiSXIMYxI3MGba7y7WCpADpFyjNnNbtTySH1JXvLZZrRgzfoPGz1Rt5Hr5kEA1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686563; c=relaxed/simple;
	bh=iYnh2LPEh03pNY14NAxDdOYOJnwMTvYIUmXMPARl27g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wief/6V8yEMsNSYxfAox/Tg/rARRaYxxP5OsBsPVST1K3f2+glXsmXmpjbwCMhbJGfV2gGYlUjraj0nO5fH/1fq+DEJitIYmEYook58TF+JPy8lhlsEI7DCX4VW8Mh56+P/dR87DWl7pO351etZjNehj7Co8SR8g0WjDcsgRFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 1991F5E8A0;
	Fri, 18 Sep 2026 01:01:52 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 76BCF16225B; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/11] ptwrite uprobes: Add infrastructure for ptwrite uprobes
Date: Thu, 17 Sep 2026 16:00:28 -0700
Message-ID: <20260917230127.924985-2-ak@kernel.org>
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

uprobes currently always require entering the kernel to log anything.
While that works well, it is rather slow.

Modern Intel CPUs have the ptwrite instruction, which can log data to
the Processor Trace buffer. Add support in uprobes for patching PTWRITE
instead of kernel entries. When a user collects Processor Trace with perf
the logged data will appear in the PT log, otherwise the instructions will
be nops.

PTWRITE provides much faster logging, but it is missing various
features that the full featured probes have.

The instrumentation is similar to optimized uprobes. Add a trampoline
page. Replace the original instruction (5 byte nop) with a jump
to the trampoline. The nop restriction will be relaxed in a later patch.
The trampoline does ptwrites and then jumps back.

Build the high-level infrastructure without any x86-64-specific
parts (except for one data structure). Add register/unregister, basic data
structures and high level hooks. Add weak stubs to handle the no uprobes
or different architectures case.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/Kconfig            |   3 +
 include/linux/uprobes.h |  77 +++++++++++++++++++-
 kernel/events/uprobes.c | 151 ++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c           |   1 +
 4 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 45c657772362..2a3f2e6d4882 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -208,6 +208,9 @@ config UPROBES
 	    managed by the kernel and kept transparent to the probed
 	    application. )
 
+config ARCH_HAS_UPROBES_PTWRITE
+	bool
+
 config HAVE_64BIT_ALIGNED_ACCESS
 	def_bool 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d34dbc0fbbfe..6b20d61cf737 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -23,9 +23,11 @@ struct uprobe;
 struct vm_area_struct;
 struct mm_struct;
 struct inode;
+struct file;
 struct notifier_block;
 struct page;
 struct srcu_ctr;
+struct uprobe_ptwrite_desc;
 
 /*
  * Allowed return values from uprobe consumer's handler callback
@@ -187,6 +189,37 @@ struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
+#ifdef CONFIG_ARCH_HAS_UPROBES_PTWRITE
+	/* Ptwrite pages and metadata protected by mm mmap write lock. */
+	struct hlist_head	head_ptwrite;
+#endif
+};
+
+#define UPROBE_PTWRITE_MAX_ARGS	8
+
+/*
+ * Header word: event_id<<48 | nargs<<40 | UPROBE_PTW_HDR_MAGIC (bits 39..0).
+ */
+#define UPROBE_PTW_HDR_MAGIC	0x5054525731UL	/* "PTRW1" */
+
+enum uprobe_ptwrite_src {
+	UPROBE_PTW_SRC_REG,	/* value = live GPR (index in .reg) */
+	UPROBE_PTW_SRC_IMM,	/* value = constant (.val), stored in stub data slot */
+};
+
+struct uprobe_ptwrite_arg {
+	u8	src;		/* enum uprobe_ptwrite_src */
+	u8	reg;		/* x86-64 GPR index (0=rax..15=r15) for SRC_REG */
+	u8	size;		/* declared type size 1/2/4/8 (decoder hint) */
+	u8	reserved;
+	u64	val;		/* SRC_IMM: constant; SRC_REG: unused */
+};
+
+struct uprobe_ptwrite_desc {
+	u16	event_id;	/* identifier carried in the header word */
+	u8	nargs;
+	u8	flags;
+	struct uprobe_ptwrite_arg args[UPROBE_PTWRITE_MAX_ARGS];
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
@@ -205,6 +238,37 @@ extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr,
 			void *data);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
+extern struct uprobe *uprobe_register_ptwrite(struct inode *inode,
+					      struct file *file, loff_t offset,
+					      struct uprobe_consumer *uc,
+					      const struct uprobe_ptwrite_desc *desc);
+extern bool arch_uprobe_ptwrite_supported(void);
+extern int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				       const struct uprobe_ptwrite_desc *desc);
+extern int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
+				       struct vm_area_struct *vma,
+				       unsigned long vaddr);
+extern int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
+					 struct vm_area_struct *vma,
+					 unsigned long vaddr);
+
+enum uprobe_ptwrite_fetch_kind {
+	UPROBE_PTW_FETCH_REG,		/* live GPR */
+	UPROBE_PTW_FETCH_STACKP,	/* stack pointer value ($stack) */
+	UPROBE_PTW_FETCH_STACKN,	/* [SP + imm] ($stackN, imm pre-scaled) */
+	UPROBE_PTW_FETCH_MEMREG,	/* [GPR + imm] (imm = disp32) */
+	UPROBE_PTW_FETCH_IMM,		/* constant */
+};
+
+struct uprobe_ptwrite_fetch {
+	enum uprobe_ptwrite_fetch_kind	kind;
+	unsigned int			reg;	/* pt_regs member offset */
+	u64				imm;	/* IMM value / MEMREG disp / STACKN off */
+};
+
+extern int arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
+				     const struct uprobe_ptwrite_fetch *f);
+
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
 extern void uprobe_unregister_sync(void);
@@ -236,6 +300,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern void arch_uprobe_clear_state(struct mm_struct *mm);
+extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 extern unsigned long arch_uprobe_get_xol_area(void);
@@ -254,6 +320,13 @@ uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struc
 {
 	return ERR_PTR(-ENOSYS);
 }
+static inline struct uprobe *
+uprobe_register_ptwrite(struct inode *inode, struct file *file, loff_t offset,
+			struct uprobe_consumer *uc,
+			const struct uprobe_ptwrite_desc *desc)
+{
+	return ERR_PTR(-ENOSYS);
+}
 static inline int
 uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
 {
@@ -280,8 +353,8 @@ static inline void uprobe_start_dup_mmap(void)
 static inline void uprobe_end_dup_mmap(void)
 {
 }
-static inline void
-uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
+static inline void uprobe_dup_mmap(struct mm_struct *oldmm,
+				   struct mm_struct *newmm)
 {
 }
 static inline void uprobe_notify_resume(struct pt_regs *regs)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 290c23e273e6..30c28625bb5f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -59,6 +59,9 @@ DEFINE_STATIC_SRCU_FAST_UPDOWN(uretprobes_srcu);
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
+/* PTWRITE uprobe */
+#define UPROBE_PTWRITE		1
+
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
@@ -1162,6 +1165,18 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	if (ret)
 		return ret;
 
+	if (test_bit(UPROBE_PTWRITE, &uprobe->flags)) {
+		first_uprobe = !mm_flags_test(MMF_HAS_UPROBES, mm);
+		if (first_uprobe)
+			mm_flags_set(MMF_HAS_UPROBES, mm);
+
+		ret = arch_uprobe_install_ptwrite(&uprobe->arch, vma, vaddr);
+		if (!ret)
+			mm_flags_clear(MMF_RECALC_UPROBES, mm);
+		else if (first_uprobe)
+			mm_flags_clear(MMF_HAS_UPROBES, mm);
+		return ret;
+	}
 	/*
 	 * set MMF_HAS_UPROBES in advance for uprobe_pre_sstep_notifier(),
 	 * the task can hit this breakpoint right after __replace_page().
@@ -1185,6 +1200,9 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	mm_flags_set(MMF_RECALC_UPROBES, mm);
+	if (test_bit(UPROBE_PTWRITE, &uprobe->flags))
+		return arch_uprobe_uninstall_ptwrite(&uprobe->arch, vma, vaddr);
+
 	return set_orig_insn(&uprobe->arch, vma, vaddr);
 }
 
@@ -1423,6 +1441,12 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return uprobe;
 
 	down_write(&uprobe->register_rwsem);
+	if (test_bit(UPROBE_PTWRITE, &uprobe->flags)) {
+		up_write(&uprobe->register_rwsem);
+		put_uprobe(uprobe);
+		return ERR_PTR(-EBUSY);
+	}
+
 	consumer_add(uprobe, uc);
 	ret = register_for_each_vma(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
@@ -1442,6 +1466,131 @@ struct uprobe *uprobe_register(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
+/*
+ * Architecture state and PTWRITE hooks: weak defaults so the generic core
+ * builds on any architecture.
+ */
+void __weak arch_uprobe_init_state(struct mm_struct *mm)
+{
+}
+
+void __weak arch_uprobe_clear_state(struct mm_struct *mm)
+{
+}
+
+bool __weak arch_uprobe_ptwrite_supported(void)
+{
+	return false;
+}
+
+int __weak arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				       const struct uprobe_ptwrite_desc *desc)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
+				       struct vm_area_struct *vma,
+				       unsigned long vaddr)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
+					  struct vm_area_struct *vma,
+					  unsigned long vaddr)
+{
+	return 0;
+}
+
+int __weak arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *arg,
+				     const struct uprobe_ptwrite_fetch *fetch)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * uprobe_register_ptwrite - register a PTWRITE uprobe
+ * @inode: the probed file's inode
+ * @file: open file used while populating the instruction page cache
+ * @offset: offset from the start of the file
+ * @uc: consumer controlling probe lifetime
+ * @desc: requested values to emit
+ */
+struct uprobe *uprobe_register_ptwrite(struct inode *inode, struct file *file,
+				       loff_t offset, struct uprobe_consumer *uc,
+				       const struct uprobe_ptwrite_desc *desc)
+{
+	struct uprobe *uprobe;
+	int ret;
+
+	if (!file || !uc)
+		return ERR_PTR(-EINVAL);
+
+	if (!arch_uprobe_ptwrite_supported())
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!desc || desc->nargs == 0 || desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
+		return ERR_PTR(-EINVAL);
+
+	if (!inode->i_mapping->a_ops->read_folio &&
+	    !shmem_mapping(inode->i_mapping))
+		return ERR_PTR(-EIO);
+
+	/* Racy, just to catch the obvious mistakes */
+	if (offset < 0)
+		return ERR_PTR(-EINVAL);
+	if (offset > i_size_read(inode))
+		return ERR_PTR(-EINVAL);
+	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
+		return ERR_PTR(-EINVAL);
+
+	uprobe = alloc_uprobe(inode, offset, 0);
+	if (IS_ERR(uprobe))
+		return uprobe;
+
+	down_write(&uprobe->register_rwsem);
+
+	/*
+	 * Do not repurpose an existing uprobe. UPROBE_COPY_INSN remains set
+	 * after its last consumer is detached and closes the deferred-removal
+	 * window where the consumer list alone is not a sufficient mode check.
+	 */
+	if (test_bit(UPROBE_COPY_INSN, &uprobe->flags) ||
+	    !list_empty(&uprobe->consumers)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Build the mm-independent stub template once, at registration. */
+	ret = arch_uprobe_ptwrite_prepare(&uprobe->arch, desc);
+	if (ret)
+		goto out;
+
+
+	set_bit(UPROBE_PTWRITE, &uprobe->flags);
+	consumer_add(uprobe, uc);
+	ret = register_for_each_vma(uprobe, uc);
+	up_write(&uprobe->register_rwsem);
+
+	if (ret) {
+		uprobe_unregister_nosync(uprobe, uc);
+		/*
+		 * Registration might have partially succeeded. Clean
+		 * everything up.
+		 */
+		uprobe_unregister_sync();
+		return ERR_PTR(ret);
+	}
+
+	return uprobe;
+out:
+	up_write(&uprobe->register_rwsem);
+	put_uprobe(uprobe);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(uprobe_register_ptwrite);
+
 /**
  * uprobe_apply - add or remove the breakpoints according to @uc->filter
  * @uprobe: uprobe which "owns" the breakpoint
@@ -1826,6 +1975,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
+	arch_uprobe_clear_state(mm);
+
 	if (!area)
 		return;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index a5934a317634..461a7b8b9e1b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1076,6 +1076,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
+	arch_uprobe_init_state(mm);
 #endif
 }
 
-- 
2.54.0

