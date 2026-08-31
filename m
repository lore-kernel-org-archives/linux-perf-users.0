Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB64A92C4;
	Mon, 31 Aug 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188831; cv=none; b=hEDPGHgbeNonIkYrYwxOHVJsIQRG6wrCi9SN1cuxg36wPNRvHhinhbt9HQNCFH7/3KR+VpS28jW2k+CLXadjrIRXR4xSM3fQZ0BVF61g1rhQBr7g7V5BpYLZxdZCk3xFax0qE9Px0PIRDXq4/pPQZflVcVeqRBXANvtQMcAfCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188831; c=relaxed/simple;
	bh=KSUnuHYXhwMgVfpDSxQBJeuqZbTldUTIYltNfmUly7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLy/F/o4HWSsUCP1N6ORziThyy0ZtHzGVYTS38az4p02HdT4K99Pv8+sr+AIpDXBTyLMfVm5As7wJMIQUC7siq4gKRuoP03phz8m0JHlA+FrWuZZijchKBmZTY6+bWcVnd7gwWSpnemJJ3rvgoUlMinHlW9APCh4idgsQdZc8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 2F5C65EA51;
	Mon, 31 Aug 2026 17:07:06 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 04DF116225F; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
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
Subject: [RFC v1 04/19] ptwrite uprobes: Add infrastructure for ptwrite uprobes
Date: Mon, 31 Aug 2026 08:04:40 -0700
Message-ID: <20260831150651.1134594-5-ak@kernel.org>
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

uprobes currently always require entering the kernel to log anything.
While that works well, it is rather slow.

Modern Intel CPUs have the ptwrite instruction, which can log data to
the Processor Trace buffer. This patch adds support in uprobes
to patch in ptwrites instead of the normal probes. If a user collects
Processor Trace with perf the logged data will appear in the PT log,
otherwise the instructions will be nops. ptwrite is a 5 byte
instruction, here it can be only patched into 5 byte nops.

The benefit is much faster logging, but it also has a lot of
limitations. There is no filtering, no EBPF, there are restrictions on
what can be logged, and of course it depends on PT being recorded.

The instrumentation is similar to normal uprobes. Add a trampoline
page. Replace the original instruction (5 byte nop) with a jump
to the trampoline. The trampoline does ptwrites and then jumps back.

This is the high level infrastruture without any x86-64 specific
parts (except for one data structure). Add register/unregister, basic data
structures and high level hooks. Add weak stubs to handle the no uprobes
or different architectures case.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 include/linux/uprobes.h |  81 +++++++++++++++++++-
 kernel/events/uprobes.c | 166 +++++++++++++++++++++++++++++++++++++++-
 kernel/fork.c           |   1 +
 mm/mmap.c               |   8 +-
 4 files changed, 251 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index d34dbc0fbbfe..0c422f6d9e7f 100644
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
+#ifdef CONFIG_X86_64
+	struct hlist_head	head_ptwrite;
+	/* Ptwrite pages and metadata use the mm mmap write lock. */
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
+	UPROBE_PTW_FETCH_REG,	/* live GPR */
+	UPROBE_PTW_FETCH_STACKP,/* stack pointer value ($stack) */
+	UPROBE_PTW_FETCH_STACKN,/* [SP + imm] ($stackN, imm pre-scaled) */
+	UPROBE_PTW_FETCH_MEMREG,/* [GPR + imm] (imm = disp32) */
+	UPROBE_PTW_FETCH_IMM,	/* constant */
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
@@ -212,7 +276,7 @@ extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
 extern void uprobe_end_dup_mmap(void);
-extern void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm);
+extern int uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm);
 extern void uprobe_free_utask(struct task_struct *t);
 extern void uprobe_copy_process(struct task_struct *t, u64 flags);
 extern int uprobe_post_sstep_notifier(struct pt_regs *regs);
@@ -236,6 +300,9 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern void arch_uprobe_clear_state(struct mm_struct *mm);
+extern void arch_uprobe_init_state(struct mm_struct *mm);
+extern int arch_uprobe_dup_ptwrite(struct mm_struct *oldmm, struct mm_struct *newmm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 extern unsigned long arch_uprobe_get_xol_area(void);
@@ -254,6 +321,13 @@ uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struc
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
@@ -280,9 +354,10 @@ static inline void uprobe_start_dup_mmap(void)
 static inline void uprobe_end_dup_mmap(void)
 {
 }
-static inline void
-uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
+static inline int uprobe_dup_mmap(struct mm_struct *oldmm,
+				  struct mm_struct *newmm)
 {
+	return 0;
 }
 static inline void uprobe_notify_resume(struct pt_regs *regs)
 {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 941b52c47858..23202df2b51a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -59,6 +59,8 @@ DEFINE_STATIC_SRCU_FAST_UPDOWN(uretprobes_srcu);
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
+#define UPROBE_PTWRITE		1
+
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	refcount_t		ref;
@@ -1163,6 +1165,18 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
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
@@ -1186,6 +1200,9 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	mm_flags_set(MMF_RECALC_UPROBES, mm);
+	if (test_bit(UPROBE_PTWRITE, &uprobe->flags))
+		return arch_uprobe_uninstall_ptwrite(&uprobe->arch, vma, vaddr);
+
 	return set_orig_insn(&uprobe->arch, vma, vaddr);
 }
 
@@ -1424,6 +1441,17 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return uprobe;
 
 	down_write(&uprobe->register_rwsem);
+	/*
+	 * A dying deferred-removal ptwrite uprobe can make reuse temporarily
+	 * busy.
+	*/
+	if (test_bit(UPROBE_PTWRITE, &uprobe->flags)) {
+		ret = -EBUSY;
+		up_write(&uprobe->register_rwsem);
+		put_uprobe(uprobe);
+		return ERR_PTR(ret);
+	}
+
 	consumer_add(uprobe, uc);
 	ret = register_for_each_vma(uprobe, uc);
 	up_write(&uprobe->register_rwsem);
@@ -1443,6 +1471,138 @@ struct uprobe *uprobe_register(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
+/*
+ * Architecture state hooks and ptwrite hooks: weak defaults so the
+ * generic core builds on any architecture.
+ */
+void __weak arch_uprobe_init_state(struct mm_struct *mm)
+{
+}
+
+void __weak arch_uprobe_clear_state(struct mm_struct *mm)
+{
+}
+
+/*
+ * ptwrite arch hooks: weak defaults so the generic core builds on any
+ * architecture.
+ */
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
+int __weak arch_uprobe_dup_ptwrite(struct mm_struct *oldmm, struct mm_struct *newmm)
+{
+	return 0;
+}
+
+int __weak arch_uprobe_ptwrite_fetch(struct uprobe_ptwrite_arg *a,
+					 const struct uprobe_ptwrite_fetch *f)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * uprobe_register_ptwrite - register a PTWRITE uprobe
+ * @inode: the probed file's inode
+ * @file: open file used while populating the instruction page cache
+ * @offset: offset from the start of the file
+ * @uc: consumer (handler is never invoked: no kernel entry at probe hit)
+ * @desc: requested values to emit
+ */
+struct uprobe *uprobe_register_ptwrite(struct inode *inode, struct file *file,
+				       loff_t offset, struct uprobe_consumer *uc,
+				       const struct uprobe_ptwrite_desc *desc)
+{
+	struct uprobe *uprobe;
+	int ret;
+
+	if (!file || (!uc->handler && !uc->ret_handler))
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
+	 * A dying normal uprobe can make reuse temporarily busy; don't overwrite
+	 * it.
+	*/
+	if (!list_empty(&uprobe->consumers)) {
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
@@ -1827,6 +1987,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
+	arch_uprobe_clear_state(mm);
+
 	if (!area)
 		return;
 
@@ -1845,13 +2007,15 @@ void uprobe_end_dup_mmap(void)
 	percpu_up_read(&dup_mmap_sem);
 }
 
-void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
+int uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
 {
 	if (mm_flags_test(MMF_HAS_UPROBES, oldmm)) {
 		mm_flags_set(MMF_HAS_UPROBES, newmm);
 		/* unconditionally, dup_mmap() skips VM_DONTCOPY vmas */
 		mm_flags_set(MMF_RECALC_UPROBES, newmm);
 	}
+
+	return arch_uprobe_dup_ptwrite(oldmm, newmm);
 }
 
 static unsigned long xol_get_slot_nr(struct xol_area *area)
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..7cda19be2877 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1076,6 +1076,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
+	arch_uprobe_init_state(mm);
 #endif
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 4bf26b0f1e6e..e10412160b32 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1716,7 +1716,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	if (mmap_write_lock_killable(oldmm))
 		return -EINTR;
 	flush_cache_dup_mm(oldmm);
-	uprobe_dup_mmap(oldmm, mm);
 	/*
 	 * Not linked in yet - no deadlock potential:
 	 */
@@ -1825,6 +1824,13 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
+	if (!retval) {
+		/*
+		 * The arch state follows the fully populated child maple tree. A
+		 * non-fatal allocation failure can leave a child ptwrite hit faulting.
+		 */
+		retval = uprobe_dup_mmap(oldmm, mm);
+	}
 loop_out:
 	vma_iter_free(&vmi);
 	if (!retval) {
-- 
2.54.0

