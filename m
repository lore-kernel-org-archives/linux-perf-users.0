Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0951E440;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188842; cv=none; b=EGlNqI7pKFYT0P0WUj5UQtysKO3iQFgu+Rf1LE2UJjULPAxboU7awGCO7Y1UHX072LSpW3E2P7uZJHIBqqwelrZxzcfefyf/8pmWBAaH0tyKqvahiyECrqsAq4PrqMeCblaTkT3sfNNkem/EUz0id5QAPH/LLP4xzfO8jWYyDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188842; c=relaxed/simple;
	bh=GQ71Z1QSCZrfvvv8u+z2upeOVqfJB/pfTC3scxu9fxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJYhWyOJr/wVtR7Q+oXlHVizEuyh0bkU076NVTIuc8M3b7yHKY6xrUTeVaktJtThj29JVQ5y6PGIzGhO54uyO3C/I+oG80EhLYGzGnlGgJut2bHNZx8LvSpMI9q6cK0IRxJEELriSGS4MFZ+HbXAwu395O67HuCalJ0G8TM2Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id E92E263F8D;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 2109216229B; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
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
Subject: [RFC v1 13/19] ptwrite uprobes: Support instruction puning
Date: Mon, 31 Aug 2026 08:04:49 -0700
Message-ID: <20260831150651.1134594-14-ak@kernel.org>
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

The previous ptwrite instrumentation only worked on 5 byte+ nops because
it needs to patch in a 5 byte branch. But the instruction may be shorter
and the kernel cannot prove that nobody jumps to the next instruction.

However that is somewhat limiting because it means most code cannot
be probed. This patch implements a simplified variant of the instruction
puning technique from Chamith et.al. "Instruction Punning: Lightweight
instrumentation for x86-64". The basic idea is to only patch in the
one byte opcode for the branch and reuse the existing instruction
bytes in the code as the branch target.

If someone branches to the remaining bytes they are still executed
in the original way because they didn't change.

This requires placing a target trampoline page at the right address. If
the area is not available or points to kernel space it doesn't work.

In general it is somewhat unreliable for non PIE executables because
the target is often negative and ends up in kernel space. However
on modern Linux distributions near all binaries are PIE and high
up in the address space with ample gaps around them, which makes
puning have a high success rate.

For example trying to probe every instruction in a PIE linked
Debian 13 /bin/bash:

bash has around 210k instructions, of which around 10k were directly
patchable 5 byte nops. Running it for 100 times with ASLR 76.4% of
the instructions were always pun probeable, with 23% of the instruction
never being punnable (and the rest sometimes). So punning is not
perfect, but still works most of the time, and is much better than just
nops.

The original paper used various fallback techniques to improve success,
but I found things work well enough anyways with PIE and PIC.

If the probing fails it's possible for the harness to move the probe
around until it finds a better target. Sometimes you're just
lucky on rerun with ASLR. Or alternatively just use a classic
uprobe.

I made sure to give all instruction error cases unique errnos so
that the harness can make informed decisions.

This patch adds the low level machinery for puning. Classify
the instruction, poke the target and map trampolines to the right place.
One difference to the nop probing is that the previous instruction
needs to be copied and fixed up (analogous to classic uprobes)

32bit relative ranches cannot be probed because their target is not
available by definition. For 8bit relative branches there are also cases
where it might need a second trampoline, or APX JMPABS support,
to reach the true target, so these are rejected too for now.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/uprobes.h |  11 +-
 arch/x86/kernel/uprobes.c      | 480 ++++++++++++++++++++++++++++++---
 include/linux/uprobes.h        |   4 +-
 kernel/events/uprobes.c        |  18 +-
 4 files changed, 470 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 2800372b2f5a..ba751af4204b 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -49,14 +49,19 @@ struct uprobe_xol_ops;
 
 /*
  * ptwrite probe state. The stub template (code + data slots) is built
- * once at registration (mm-independent except the final jmp's rel32, patched
- * per-mm at install). Block layout:
- *   [ptwriteq hdr(%rip)] [arg emissions] [jmp probe+5] [u64 slots: header, imms]
+ * once at registration. Only the final jmp's rel32 and the copy's
+ * disp/rel fields are patched per-mm at install. Block layout:
+ *   [ptwriteq hdr(%rip)] [arg emissions] [orig-insn copy]
+ *   [jmp probe+len] [u64 slots: header, imms]
  */
 struct uprobe_ptwrite_arch {
 	u8	stub[UPROBE_PTWRITE_STUB_SIZE];
 	u16	stub_len;	/* code + data + fault table, whole block */
 	u8	jmp_off;	/* offset of the final jmp's rel32 field */
+	u8	copy_off;	/* offset of the out-of-line instruction copy */
+	u8	len;		/* copy length (0 = drop); back-jmp = vaddr+len */
+	u8	disp_off;	/* rip-relative disp32 offset in the copy (0 = none) */
+	s32	disp;		/* original disp32 (delta-patched per-mm) */
 	u8	ndata;		/* number of u64 data slots */
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
 	u16	ft_off;	/* fault table offset within the block (0 if none) */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 20557423690f..806e40f7b0ab 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -958,8 +958,17 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 {
 	struct write_opcode_ctx *ctx = data;
 	uprobe_opcode_t old_opcode[OPT_INSN_SIZE];
+	int len;
 
-	uprobe_copy_from_page(page, ctx->base, old_opcode, OPT_INSN_SIZE);
+	/*
+	 * Byte-state checks need only the first byte. Optimized-state checks
+	 * inspect the complete ten-byte instruction.
+	 */
+	len = ctx->expect == EXPECT_OPTIMIZED ||
+		ctx->expect == EXPECT_SWBP_OPTIMIZED ? OPT_INSN_SIZE : 1;
+	if (PAGE_SIZE - (ctx->base & ~PAGE_MASK) < len)
+		return -1;
+	uprobe_copy_from_page(page, ctx->base, old_opcode, len);
 
 	switch (ctx->expect) {
 	case EXPECT_SWBP:
@@ -1398,6 +1407,11 @@ static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 		       sizeof(((struct uprobe_ptwrite_arch *)0)->stub) - len;
 }
 
+static bool pun_site_is_nop(const u8 *orig, bool allow_nop_run);
+static int pun_classify_insn(struct insn *insn, u8 *disp_off, s32 *disp);
+static int pun_decode_site(struct inode *inode, struct file *file,
+			       loff_t offset, u8 *copy,
+			       u8 *disp_off, s32 *disp, bool allow_nop_run);
 
 #define PTW_NEED(_len) do { \
 		if (!ptwrite_has_room(code, p, (_len))) \
@@ -1407,6 +1421,8 @@ static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 
 
 int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				struct inode *inode, struct file *file,
+				loff_t offset,
 				const struct uprobe_ptwrite_desc *desc)
 {
 	struct uprobe_ptwrite_arch *ptw = &auprobe->ptwrite;
@@ -1416,17 +1432,18 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	struct { u16 start, end, fixup; } __packed mft[UPROBE_PTWRITE_MAX_ARGS];
 	u16 mdisp[UPROBE_PTWRITE_MAX_ARGS];
 	unsigned int data_off, flt_off, ft_off;
-	unsigned int hdr_off = 0;
 	unsigned int imm_idx = 0, n_imm = 0, mem_idx = 0, n_mem = 0;
+	unsigned int hdr_off = 0;
 	bool paced = false;
 	u64 hdr;
-	int i;
+	int i, ret;
 
 	if (!desc || desc->nargs == 0)
 		return -EINVAL;
 	if (desc->nargs > UPROBE_PTWRITE_MAX_ARGS)
 		return -E2BIG;
 	if (desc->flags & ~(UPROBE_PTWRITE_FL_ALLOW_MEM |
+			     UPROBE_PTWRITE_FL_NO_LEAD_PACE |
 			     UPROBE_PTWRITE_FL_ALLOW_NOP_RUN))
 		return -EINVAL;
 
@@ -1546,6 +1563,13 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		}
 	}
 
+	/* the out-of-line original-instruction copy slot (patched per-mm) */
+	PTW_NEED(UPROBE_PTWRITE_COPY_SIZE);
+	if (p - code > U8_MAX)
+		return -E2BIG;
+	ptw->copy_off = p - code;
+	p += UPROBE_PTWRITE_COPY_SIZE;
+
 	/* final jmp back to probe+len; rel32 patched per-mm at install */
 	PTW_NEED(5);
 	*p++ = 0xe9;
@@ -1615,6 +1639,15 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	ptw->ft_off = n_mem ? ft_off : 0;
 	ptw->nft = n_mem;
 	ptw->allow_nop_run = !!(desc->flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN);
+
+	ret = pun_decode_site(inode, file, offset, code + ptw->copy_off,
+				  &ptw->disp_off, &ptw->disp,
+				  ptw->allow_nop_run);
+	if (ret < 0)
+		return ret;
+	ptw->len = ret;
+	memset(code + ptw->copy_off + ptw->len, 0x90,
+	       UPROBE_PTWRITE_COPY_SIZE - ptw->len);
 	return 0;
 }
 #undef PTW_NEED
@@ -1711,15 +1744,10 @@ static unsigned long find_ptwrite_page_area(struct mm_struct *mm,
 }
 
 static struct uprobe_ptwrite_page *
-create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
+create_uprobe_ptwrite_page_at(struct mm_struct *mm, unsigned long area)
 {
 	struct uprobe_ptwrite_page *ptw;
 	struct vm_area_struct *vma;
-	unsigned long area;
-
-	area = find_ptwrite_page_area(mm, vaddr);
-	if (IS_ERR_VALUE(area))
-		return NULL;
 
 	mmap_assert_write_locked(mm);
 
@@ -1744,6 +1772,17 @@ create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
 	}
 	return ptw;
 }
+
+static struct uprobe_ptwrite_page *
+create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
+{
+	unsigned long area = find_ptwrite_page_area(mm, vaddr);
+
+	if (IS_ERR_VALUE(area))
+		return NULL;
+	return create_uprobe_ptwrite_page_at(mm, area);
+}
+
 static struct uprobe_ptwrite_page *
 get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
 			unsigned int len)
@@ -1772,31 +1811,127 @@ get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
 	return ptw;
 }
 
-/* Probe site must be a 5-byte NOP that does not cross a page boundary. */
-static int ptwrite_validate_site(const u8 *orig, unsigned long vaddr)
+/*
+ * A run of short NOPs is accepted only when requested. This validation does
+ * not make the three-phase poke safe for threads that already passed byte 0.
+ */
+static bool pun_site_is_nop(const u8 *orig, bool allow_nop_run)
 {
 	struct insn insn;
 	int ret;
-	int off = 0;
 
-	/*
-	 * The 5 displaced bytes must be NOPs: either one 5-byte NOP
-	 * (nopl 0x0(%rax,%rax,1)) or a run of shorter NOPs summing to
-	 * exactly 5 (gcc -fpatchable-function-entry=5 emits 5 x 0x90 on
-	 * modern toolchains). Any non-NOP byte, or a NOP crossing the
-	 * 5-byte window, is rejected.
-	 */
-	while (off < 5) {
-		ret = insn_decode(&insn, orig + off, 5 - off, INSN_MODE_64);
-		if (ret < 0)
-			return -EINVAL;
-		if (insn.length < 1 || insn.length > 5 - off ||
-		    !insn_is_nop(&insn))
-			return -EINVAL;
-		off += insn.length;
+	ret = insn_decode(&insn, orig, 5, INSN_MODE_64);
+	if (ret < 0)
+		return false;
+	if (insn.length == 5 && insn_is_nop(&insn))
+		return true;
+	if (!allow_nop_run)
+		return false;
+	return orig[0] == 0x90 && orig[1] == 0x90 &&
+		orig[2] == 0x90 && orig[3] == 0x90 && orig[4] == 0x90;
+}
+
+/*
+ * Classify the site's single instruction for out-of-line execution.
+ * Returns the length, or 0 when it cannot run safely out of line.
+ */
+static int pun_classify_insn(struct insn *insn, u8 *disp_off, s32 *disp)
+{
+	u8 op = insn->opcode.bytes[0];
+	switch (op) {
+	case 0xcc:	/* int3 */
+	case 0xcd:	/* int imm8 */
+	case 0xce:	/* into */
+	case 0xcf:	/* iret */
+	case 0xf1:	/* int1 */
+	case 0xea:	/* jmp far */
+	case 0x9a:	/* call far */
+	/* Could be handled with special case code. */
+	case 0xe8:	/* call rel32 */
+	case 0xe0:	/* loopne rel8: cannot run out of line */
+	case 0xe1:	/* loope rel8 */
+	case 0xe2:	/* loop rel8 */
+	case 0xe3:	/* jecxz/jrcxz */
+	/* These two could be handled if the offsets fit */
+	case 0xe9:	/* jmp rel32 */
+	case 0xeb:	/* jmp rel8 */
+	case 0x70 ... 0x7f:	/* jcc rel8 */
+		return -EOPNOTSUPP;
 	}
-	if (off != 5)
+	/* XBEGIN's rel32 abort target is IP-relative, not RIP-relative. */
+	if (op == 0xc7 && insn->modrm.nbytes &&
+	    X86_MODRM_MOD(insn->modrm.value) == 3 &&
+	    X86_MODRM_REG(insn->modrm.value) == 7 &&
+	    X86_MODRM_RM(insn->modrm.value) == 0)
+		return -EOPNOTSUPP;
+	if (op == 0x0f) {
+		switch (insn->opcode.bytes[1]) {
+		case 0x05:	/* syscall */
+		case 0x34:	/* sysenter */
+		case 0x35:	/* sysexit */
+			return -EOPNOTSUPP;
+		}
+		/* jcc rel32: could be handled if offsets fit */
+		if (insn->opcode.bytes[1] >= 0x80 &&
+		    insn->opcode.bytes[1] <= 0x8f)
+			return -EOPNOTSUPP;
+		/* Allow endbranch because this is incompatible with CET anyways */
+	}
+	if (op == 0xff) {
+		u8 reg = X86_MODRM_REG(insn->modrm.value);
+
+		/* call/lcall/jmp-far indirect */
+		if (reg == 2 || reg == 3 || reg == 5)
+			return -EOPNOTSUPP;
+	}
+
+	if (insn_rip_relative(insn)) {
+		*disp_off = insn_offset_displacement(insn);
+		insn_get_displacement(insn);
+		*disp = insn->displacement.value;
+	}
+	return insn->length;
+}
+
+/*
+ * Read the site's instruction bytes from the file and classify them.
+ * The bytes are identical in every mm, so the copy is mm-independent.
+ */
+static int pun_decode_site(struct inode *inode, struct file *file,
+			       loff_t offset, u8 *copy,
+			       u8 *disp_off, s32 *disp, bool allow_nop_run)
+{
+	u8 buf[MAX_UINSN_BYTES];
+	struct insn insn;
+	int ret;
+
+	ret = uprobe_copy_from_file(inode, file, offset, buf,
+				    MAX_UINSN_BYTES);
+	if (ret < 0)
+		return ret;
+	if (ret != MAX_UINSN_BYTES)
+		return -EIO;
+
+	if (pun_site_is_nop(buf, allow_nop_run))
+		return 0;
+
+	/* Check single instruction */
+	if (insn_decode(&insn, buf, MAX_UINSN_BYTES, INSN_MODE_64))
+		return -EINVAL;
+	if (insn.length < 1 || insn.length > MAX_UINSN_BYTES)
 		return -EINVAL;
+
+	/* the original bytes verbatim; classify only validates them */
+	memcpy(copy, buf, insn.length);
+	return pun_classify_insn(&insn, disp_off, disp);
+}
+
+static int ptwrite_validate_site(const u8 *orig, unsigned long vaddr)
+{
+	/*
+	 * Site installation reads and patches five bytes from one user page.
+	 * Do not let those page-relative copies cross into an unpinned page.
+	 */
 	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < 5)
 		return -EINVAL;
 	return 0;
@@ -1866,10 +2001,210 @@ static int ptwrite_text_poke(struct arch_uprobe *auprobe,
 	return err;
 }
 
+/*
+ * Replace an aligned five-byte NOP run with a JMP in one eight-byte store.
+ * The trailing three bytes are read from the existing text. We assume
+ * nobody else is changing it. This is covered by the Intel/AMD "aligned store"
+ * cross modifying guarantee.
+ */
+static int ptwrite_multinop_text_poke(struct arch_uprobe *auprobe,
+				      struct vm_area_struct *vma,
+				      unsigned long vaddr,
+				      unsigned long stub_addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+		.expect = EXPECT_BYTE,
+		.expect_byte = 0x90,
+	};
+	u8 patch[8];
+	s32 rel;
+	int err;
+
+	if (vaddr & 7)
+		return -EINVAL;
+	if (!ptwrite_rel32(vaddr + 5, stub_addr, &rel))
+		return -ERANGE;
+	err = copy_from_vaddr(mm, vaddr, patch, sizeof(patch));
+	if (err)
+		return err;
+	patch[0] = 0xe9;
+	memcpy(&patch[1], &rel, sizeof(rel));
+	err = uprobe_write(auprobe, vma, vaddr, patch, sizeof(patch),
+			   verify_insn, true, false, &ctx);
+	if (!err)
+		smp_text_poke_sync_each_cpu();
+	return err;
+}
+
+static int pun_text_poke(struct arch_uprobe *auprobe,
+				 struct vm_area_struct *vma,
+				 unsigned long vaddr, u8 e9,
+				 struct write_opcode_ctx *ctx)
+{
+	int err;
+
+	err = uprobe_write(auprobe, vma, vaddr, &e9, 1, verify_insn,
+			   true, false, ctx);
+	if (err)
+		return err;
+	smp_text_poke_sync_each_cpu();
+	return 0;
+}
+
+static int pun_install(struct arch_uprobe *auprobe,
+			       struct vm_area_struct *vma, unsigned long vaddr,
+			       const u8 *orig)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct uprobe_ptwrite_page *ptw;
+	struct uprobe_ptwrite_arch *ptw_a = &auprobe->ptwrite;
+	struct uprobes_state *state = &mm->uprobes_state;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+		.expect = EXPECT_BYTE,
+		.expect_byte = orig[0],
+	};
+	unsigned long t, page_base, block_off, stub_addr;
+	s64 site_delta;
+	s32 jump_rel, disp32, orig_rel;
+	u8 site_len;
+	bool found = false;
+	bool nop_fallback = ptwrite_site_is_multinop(orig,
+						     ptw_a->allow_nop_run) &&
+			    (vaddr & 7);
+	u8 *kaddr;
+	int b, ret;
+
+	mmap_assert_write_locked(mm);
+	if (nop_fallback) {
+		hlist_for_each_entry(ptw, &state->head_ptwrite, node) {
+			site_delta = (s64)vaddr - (s64)ptw->vaddr;
+			if (site_delta < INT_MIN || site_delta > INT_MAX)
+				continue;
+			for (b = 0; b < smp_load_acquire(&ptw->nblocks); b++)
+				if (!ptw->index[b].pun &&
+				    ptw->index[b].site_off == (s32)site_delta &&
+				    ptw->index[b].site_len == 5 &&
+				    !memcmp(ptw->index[b].site_insn, orig, 5))
+					break;
+			if (b >= smp_load_acquire(&ptw->nblocks))
+				continue;
+			if (!__in_uprobe_ptwrite(mm, ptw->vaddr))
+				continue;
+			return ptwrite_text_poke(auprobe, vma, vaddr,
+						 ptw->vaddr + ptw->index[b].off);
+		}
+		ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
+		if (!ptw)
+			return -ENOMEM;
+		block_off = ptw->cursor;
+	} else {
+		memcpy(&orig_rel, orig + 1, sizeof(orig_rel));
+		t = (unsigned long)((s64)vaddr + 5 + (s64)orig_rel);
+		if ((s64)vaddr + 5 + (s64)orig_rel < PAGE_SIZE ||
+		    (s64)vaddr + 5 + (s64)orig_rel >= TASK_SIZE_MAX)
+			return -EADDRNOTAVAIL;
+		page_base = t & PAGE_MASK;
+		block_off = t & (PAGE_SIZE - 1);
+		if (block_off + ptw_a->stub_len > PAGE_SIZE)
+			return -ENOSPC;
+
+		/* reuse an existing ptwrite page at the target, else map a new one */
+		hlist_for_each_entry(ptw, &state->head_ptwrite, node) {
+			if (ptw->vaddr == page_base) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			if (vma_lookup(mm, page_base))
+				return -EADDRNOTAVAIL;	/* target page occupied */
+			ptw = create_uprobe_ptwrite_page_at(mm, page_base);
+			if (!ptw)
+				return -ENOMEM;
+			/* Order page initialization before publishing it to fault readers. */
+			smp_wmb();
+			hlist_add_head_rcu(&ptw->node, &state->head_ptwrite);
+		}
+	}
+
+	site_delta = (s64)vaddr - (s64)ptw->vaddr;
+	if (site_delta < INT_MIN || site_delta > INT_MAX)
+		return -ERANGE;
+
+	for (b = 0; b < ptw->nblocks; b++) {
+		if (ptw->index[b].off != block_off || !ptw->index[b].pun)
+			continue;
+		if (ptw->index[b].site_off != (s32)site_delta ||
+		    ptw->index[b].site_len != ptw_a->len ||
+		    memcmp(ptw->index[b].site_insn, ptw_a->orig,
+			   ptw_a->len))
+			return -EADDRNOTAVAIL;
+		return pun_text_poke(auprobe, vma, vaddr, 0xe9, &ctx);
+	}
+	if (block_off < ptw->cursor)
+		return -ENOSPC;
+	if (ptw->nblocks >= ARRAY_SIZE(ptw->index))
+		return -ENOMEM;
+
+	stub_addr = ptw->vaddr + block_off;
+	if (!ptwrite_rel32(stub_addr + ptw_a->jmp_off + 4,
+			   vaddr + (ptw_a->len ? ptw_a->len : 5), &jump_rel))
+		return -ERANGE;
+	if (ptw_a->len && ptw_a->disp_off) {
+		s64 d = (s64)ptw_a->disp + (s64)vaddr -
+			(s64)(stub_addr + ptw_a->copy_off);
+
+		if (d < INT_MIN || d > INT_MAX)
+			return -ERANGE;
+		disp32 = (s32)d;
+	}
+
+	/*
+	 * A NOP fallback needs a synthetic rel32 at the site, so it uses
+	 * the full five-byte poke and restore path rather than punning.
+	 */
+	site_len = nop_fallback ? 5 : ptw_a->len;
+	ptw->index[ptw->nblocks].off = block_off;
+	ptw->index[ptw->nblocks].len = ptw_a->stub_len;
+	ptw->index[ptw->nblocks].ft_off = ptw_a->ft_off;
+	ptw->index[ptw->nblocks].pun = !nop_fallback;
+	ptw->index[ptw->nblocks].orig0 = orig[0];
+	ptw->index[ptw->nblocks].site_len = site_len;
+	ptw->index[ptw->nblocks].site_off = (s32)site_delta;
+	memcpy(ptw->index[ptw->nblocks].site_insn, orig, site_len);
+	smp_store_release(&ptw->nblocks, ptw->nblocks + 1);
+
+	kaddr = kmap_local_page(ptw->page);
+	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);
+	memcpy(kaddr + block_off + ptw_a->jmp_off, &jump_rel, sizeof(jump_rel));
+	if (ptw_a->len && ptw_a->disp_off)
+		memcpy(kaddr + block_off + ptw_a->copy_off + ptw_a->disp_off,
+		       &disp32, sizeof(disp32));
+	kunmap_local(kaddr);
+
+	if (nop_fallback)
+		ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
+	else
+		ret = pun_text_poke(auprobe, vma, vaddr, 0xe9, &ctx);
+	if (ret) {
+		/* Publish rollback before readers observe the reduced block count. */
+		smp_store_release(&ptw->nblocks, ptw->nblocks - 1);
+		return ret;
+	}
+
+	set_bit(ARCH_UPROBE_FLAG_PTWRITE, &auprobe->flags);
+	ptw->cursor = block_off + ptw_a->stub_len;
+	return 0;
+}
+
 int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct uprobes_state *state = &mm->uprobes_state;
 	struct uprobe_ptwrite_page *ptw;
 	struct uprobe_ptwrite_arch *ptw_a = &auprobe->ptwrite;
 	unsigned long block_off, stub_addr;
@@ -1877,6 +2212,7 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	s64 site_delta;
 	s32 rel;
 	int ret;
+	int b;
 
 	if (!is_64bit_mm(mm))
 		return -EOPNOTSUPP;
@@ -1894,7 +2230,29 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	ret = ptwrite_validate_site(orig, vaddr);
 	if (ret)
 		return ret;
+	if (!pun_site_is_nop(orig, ptw_a->allow_nop_run))
+		return pun_install(auprobe, vma, vaddr, orig);
 
+	hlist_for_each_entry(ptw, &state->head_ptwrite, node) {
+		site_delta = (s64)vaddr - (s64)ptw->vaddr;
+		if (site_delta < INT_MIN || site_delta > INT_MAX)
+			continue;
+		/* Acquire the published count before reading block metadata. */
+		for (b = 0; b < smp_load_acquire(&ptw->nblocks); b++)
+			if (!ptw->index[b].pun &&
+			    ptw->index[b].site_off == (s32)site_delta &&
+			    ptw->index[b].site_len == sizeof(orig) &&
+			    !memcmp(ptw->index[b].site_insn, orig, sizeof(orig)))
+				break;
+		/* Recheck the published count with acquire ordering. */
+		if (b >= smp_load_acquire(&ptw->nblocks))
+			continue;
+		if (!__in_uprobe_ptwrite(mm, ptw->vaddr))
+			continue;
+		ret = ptwrite_text_poke(auprobe, vma, vaddr,
+					ptw->vaddr + ptw->index[b].off);
+		goto out;
+	}
 	ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
 	if (!ptw)
 		return -ENOMEM;
@@ -1915,7 +2273,13 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	ptw->index[ptw->nblocks].off = block_off;
 	ptw->index[ptw->nblocks].len = ptw_a->stub_len;
 	ptw->index[ptw->nblocks].ft_off = ptw_a->ft_off;
-	ptw->nblocks++;
+	ptw->index[ptw->nblocks].pun = 0;
+	ptw->index[ptw->nblocks].orig0 = orig[0];
+	ptw->index[ptw->nblocks].site_len = sizeof(orig);
+	ptw->index[ptw->nblocks].site_off = (s32)site_delta;
+	memcpy(ptw->index[ptw->nblocks].site_insn, orig, sizeof(orig));
+	/* Publish initialized metadata before exposing the probe jump. */
+	smp_store_release(&ptw->nblocks, ptw->nblocks + 1);
 
 	kaddr = kmap_local_page(ptw->page);
 	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);
@@ -1937,15 +2301,63 @@ int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct uprobe_ptwrite_arch *ptw_a = &auprobe->ptwrite;
+	struct uprobes_state *state = &mm->uprobes_state;
 	u8 cur[5];
+	int b;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+		.expect = EXPECT_BYTE,
+		.expect_byte = 0xe9,
+	};
 
 	mmap_assert_write_locked(mm);
-	if (copy_from_vaddr(mm, vaddr, cur, sizeof(cur)) ||
-	    !ptwrite_is_installed(mm, vaddr, cur))
-		return;
+	{
+		struct uprobe_ptwrite_page *ptw;
+		struct uprobe_ptwrite_page *fpw = NULL;
+		s32 rel;
+		s64 target;
+		unsigned long page_base, boff;
+		int ret;
+
+		ret = copy_from_vaddr(mm, vaddr, cur, sizeof(cur));
+		if (ret)
+			return ret;
+		if (!ptwrite_is_installed(mm, vaddr, cur))
+			return 0;
+
+		memcpy(&rel, cur + 1, sizeof(rel));
+		target = (s64)vaddr + 5 + (s64)rel;
+		if (target < PAGE_SIZE || target >= TASK_SIZE_MAX)
+			return text_poke_5byte(auprobe, vma, vaddr, ptw_a->orig,
+					0xe9, false, false, false, false, NULL);
+		page_base = (unsigned long)target & PAGE_MASK;
+		boff = (unsigned long)target & (PAGE_SIZE - 1);
+		hlist_for_each_entry(ptw, &state->head_ptwrite, node)
+			if (ptw->vaddr == page_base) {
+				fpw = ptw;
+				break;
+			}
+		if (fpw)
+			/* Acquire the published count before reading pun metadata. */
+			for (b = 0; b < smp_load_acquire(&fpw->nblocks); b++)
+				if (fpw->index[b].off == boff)
+					break;
+		if (fpw && b < smp_load_acquire(&fpw->nblocks) &&
+		    fpw->index[b].pun) {
+			u8 orig0 = fpw->index[b].orig0;
+
+			ret = uprobe_write(auprobe, vma, vaddr, &orig0, 1,
+					   verify_insn, false, false, &ctx);
+			if (ret)
+				return ret;
+			smp_text_poke_sync_each_cpu();
+			return 0;
+		}
+	}
 
-	text_poke_5byte(auprobe, vma, vaddr, auprobe->ptwrite.orig,
-			UPROBE_SWBP_INSN, false, false, false, false, NULL);
+	return text_poke_5byte(auprobe, vma, vaddr, ptw_a->orig, 0xe9,
+			false, false, false, false, NULL);
 }
 
 /*
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b39abd1b057d..917989b018f3 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -250,7 +250,9 @@ extern struct uprobe *uprobe_register_ptwrite(struct inode *inode,
 					      const struct uprobe_ptwrite_desc *desc);
 extern bool arch_uprobe_ptwrite_supported(void);
 extern int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
-				       const struct uprobe_ptwrite_desc *desc);
+					       struct inode *inode, struct file *file,
+					       loff_t offset,
+					       const struct uprobe_ptwrite_desc *desc);
 extern int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 				       struct vm_area_struct *vma,
 				       unsigned long vaddr);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 20fa16ed8519..c273ec2709e1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1515,6 +1515,8 @@ bool __weak arch_uprobe_ptwrite_supported(void)
 }
 
 int __weak arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				       struct inode *inode, struct file *file,
+				       loff_t offset,
 				       const struct uprobe_ptwrite_desc *desc)
 {
 	return -EOPNOTSUPP;
@@ -1595,13 +1597,19 @@ struct uprobe *uprobe_register_ptwrite(struct inode *inode, struct file *file,
 		ret = -EBUSY;
 		goto out;
 	}
-
-	/* Build the mm-independent stub template once, at registration. */
-	ret = arch_uprobe_ptwrite_prepare(&uprobe->arch, desc);
+	/*
+	 * Prepare the immutable PTWRITE stub before exposing the uprobe. The
+	 * copy-instruction flag also keeps the normal XOL preparation path out.
+	 */
+	ret = copy_insn(uprobe, file);
 	if (ret)
 		goto out;
-
-
+	ret = arch_uprobe_ptwrite_prepare(&uprobe->arch, inode, file, offset,
+					  desc);
+	if (ret)
+		goto out;
+	smp_wmb();
+	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 	set_bit(UPROBE_PTWRITE, &uprobe->flags);
 	consumer_add(uprobe, uc);
 	ret = register_for_each_vma(uprobe, uc);
-- 
2.54.0

