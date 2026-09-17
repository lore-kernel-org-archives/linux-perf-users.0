Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE14B1CF4;
	Thu, 17 Sep 2026 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686130; cv=none; b=gtAfecxYw5bJMffI9+ZFSkLrACUHdJVAEskcLWFXT0PJ2OwGJbE1ngyEw+1hgpr1pwBlokq1a3p19tMhkuodWFZ4n+HIc9C9dLaMYQwn7LEJTVV2388VJXEl/W18aWppEBjYteShbssNMr/s8QMGVBMBJUqIunfAuAkzTh7CMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686130; c=relaxed/simple;
	bh=n2a56p4xCES2GtOtiBgZob9wkswgmh0kOEd6CPlWRWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfzxJUnxs2CD2psFuX3SaBxWfDoMG03rgkS3Tx+SCTv5Hyqm67CerhgTNE1i7XeZ+pxij/hpLS5XCghXiN1YvI3IN1YB7W/zZbH1BDDQ39Imz6XTC3qgjQRNN3PkvvDVzbA5zje5oTKNBHNa9CGHFUuaJC20USyaWCyMGlQidfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 273EC5E8AA;
	Fri, 18 Sep 2026 01:01:55 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 8E9DF1622C0; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/11] ptwrite uprobes: Support instruction punning
Date: Thu, 17 Sep 2026 16:00:35 -0700
Message-ID: <20260917230127.924985-9-ak@kernel.org>
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

The previous ptwrite instrumentation only worked on 5 byte+ nops because
it needs to patch in a 5 byte branch.

However that is somewhat limiting because it means most code cannot
be probed. Use a simplified variant of the instruction
punning technique from Chamith et al. "Instruction Punning: Lightweight
instrumentation for x86-64". Patch only the one-byte branch opcode and
reuse the existing 4 following bytes in the code as the branch target.

If someone branches to the remaining bytes they are still executed
in the original way because they didn't change.

This requires placing a target trampoline page at the right address. If
the area is not available or points to kernel space it doesn't work.

In general it is somewhat unreliable for non PIE executables because
the target is often negative and ends up in kernel space. However
on modern Linux distributions near all binaries are PIE and high
up in the address space with ample gaps around them, which makes
punning much more successful.

Testing every instruction in a PIE-linked Debian 13 /bin/bash:

- bash has around 210k instructions
- of which around 10k are directly patchable 5 byte nops
- running bash for 100 times with ASLR 76.4% of the instructions
  are always pun probeable
- with 23% of the instruction never being punnable
- the rest sometimes depending on ASLR luck.

So punning is not perfect, but it works most of the time for these
kind of binaries, and is much better than just nops.

If the probing fails it's possible for the harness to move the probe
around until it finds a better target. Sometimes you're just
lucky on rerun with ASLR. Or alternatively just use a classic
uprobe.

Return unique errnos for all instruction error cases so the harness
can make informed decisions.

Add the low-level machinery for punning. Classify
the instruction, poke the target and map trampolines to the right place.
Various special cases are not supported to simplify the code.

One difference to the nop probing is that the previous instruction
needs to be copied and fixed up (analogous to classic uprobes)

The punning technique could be also used with optimized
uprobes, but this patch only applies it to ptwrite probes.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/include/asm/uprobes.h |  24 +-
 arch/x86/kernel/uprobes.c      | 460 ++++++++++++++++++++++++++++++---
 include/linux/uprobes.h        |   4 +-
 kernel/events/uprobes.c        |  18 +-
 4 files changed, 461 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index c46b3fe09025..53d88e37a771 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -39,6 +39,8 @@ struct uprobe_xol_ops;
  */
 #define UPROBE_PTWRITE_STUB_SIZE	384
 
+/* the out-of-line original-instruction copy slot (x86 max insn length) */
+#define UPROBE_PTWRITE_COPY_SIZE	MAX_UINSN_BYTES
 
 /*
  * Word pacing: insert this many LFENCEs between emitted ptwrite words and
@@ -50,14 +52,19 @@ struct uprobe_xol_ops;
 
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
 	u16	stub_len;	/* code + data, whole block */
 	u8	jmp_off;	/* offset of the final jmp's rel32 field */
+	u8	copy_off;	/* offset of the out-of-line instruction copy */
+	u8	len;		/* copy length (0 = drop); back-jmp = vaddr+len */
+	u8	disp_off;	/* rip-relative disp32 offset in the copy (0 = none) */
+	s32	disp;		/* original disp32 (delta-patched per-mm) */
 	u8	ndata;		/* number of u64 data slots */
 	u8	orig[MAX_UINSN_BYTES];	/* pristine file bytes, before generic analysis */
 	u16	ft_off;		/* fault table offset within the block (0 if none) */
@@ -72,6 +79,17 @@ struct uprobe_ptwrite_page {
 	struct page		*page;		/* stub blocks written via kmap */
 	unsigned long		vaddr;		/* mapping base */
 	u16			cursor;		/* next free block offset */
+	u16			nblocks;
+	struct {
+		u16 off;	/* block offset in the page */
+		u16 len;	/* generated block length */
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
index f915dda8bcb4..af9b36a219d3 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1019,8 +1019,17 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
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
@@ -1450,12 +1459,19 @@ static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 		       sizeof(((struct uprobe_ptwrite_arch *)0)->stub) - len;
 }
 
+static bool pun_site_is_nop(const u8 *orig, bool allow_nop_run);
+static int pun_classify_insn(struct insn *insn, u8 *disp_off, s32 *disp);
+static int pun_decode_site(struct inode *inode, struct file *file,
+			       loff_t offset, u8 *copy,
+			       u8 *disp_off, s32 *disp, bool allow_nop_run);
 #define PTW_NEED(_len) do { \
 		if (!ptwrite_has_room(code, p, (_len))) \
 			return -E2BIG; \
 	} while (0)
 
 int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				struct inode *inode, struct file *file,
+				loff_t offset,
 				const struct uprobe_ptwrite_desc *desc)
 {
 	struct uprobe_ptwrite_arch *ptw = &auprobe->ptwrite;
@@ -1466,7 +1482,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	unsigned int imm_idx = 0, n_imm = 0;
 	bool paced = false;
 	u64 hdr;
-	int i;
+	int i, ret;
 
 	if (!desc || desc->nargs == 0)
 		return -EINVAL;
@@ -1563,6 +1579,13 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
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
@@ -1596,6 +1619,15 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 	ptw->stub_len = data_off + 8 * (1 + n_imm);
 	ptw->ndata = 1 + n_imm;
 	ptw->allow_nop_run = desc->flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN;
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
@@ -1654,15 +1686,10 @@ static unsigned long find_ptwrite_page_area(struct mm_struct *mm,
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
 
@@ -1685,6 +1712,17 @@ create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
 	}
 	return ptw;
 }
+
+static struct uprobe_ptwrite_page *
+create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
+{
+	unsigned long area = find_ptwrite_page_area(mm, vaddr);
+
+	if (IS_ERR_VALUE(area) || security_mmap_addr(area))
+		return NULL;
+	return create_uprobe_ptwrite_page_at(mm, area);
+}
+
 static struct uprobe_ptwrite_page *
 get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
 			unsigned int len)
@@ -1714,34 +1752,131 @@ get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
 	return ptw;
 }
 
-/* Probe site must be a 5-byte NOP that does not cross a page boundary. */
-static int ptwrite_validate_site(const u8 *orig, unsigned long vaddr)
+/*
+ * A run of short NOPs is accepted only when requested. This validation does
+ * not make the three-phase poke safe for threads that already passed byte 0.
+ */
+static bool ptwrite_is_nop_run(const u8 *orig)
+{
+	return !memchr_inv(orig, 0x90, 5);
+}
+
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
+	return ptwrite_is_nop_run(orig);
+}
+
+/* Identify the explicitly opted-in run of five one-byte NOPs. */
+static bool ptwrite_site_is_multinop(const u8 *orig, bool allow_nop_run)
+{
+	return allow_nop_run && ptwrite_is_nop_run(orig);
+}
+
+/*
+ * Classify the site's single instruction for out-of-line execution.
+ * Returns the length, or a negative errno when it cannot run safely out of
+ * line.
+ */
+static int pun_classify_insn(struct insn *insn, u8 *disp_off, s32 *disp)
+{
+	u8 op = insn->opcode.bytes[0];
+
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
+	}
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
 	}
-	if (off != 5)
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
+	u8 buf[MAX_UINSN_BYTES] = {};
+	struct insn insn;
+	int ret;
+
+	ret = uprobe_copy_from_file(inode, file, offset, buf,
+				    MAX_UINSN_BYTES);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EIO;
+
+	if (pun_site_is_nop(buf, allow_nop_run))
+		return 0;
+
+	/* Check single instruction */
+	if (insn_decode(&insn, buf, MAX_UINSN_BYTES, INSN_MODE_64))
 		return -EINVAL;
-	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < 5)
+	if (insn.length < 1 || insn.length > MAX_UINSN_BYTES)
 		return -EINVAL;
-	return 0;
+
+	/* the original bytes verbatim; classify only validates them */
+	memcpy(copy, buf, insn.length);
+	return pun_classify_insn(&insn, disp_off, disp);
 }
 
 static bool ptwrite_rel32(unsigned long from, unsigned long to, s32 *rel)
@@ -1805,16 +1940,184 @@ static int ptwrite_text_poke(struct arch_uprobe *auprobe,
 	return err;
 }
 
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
+	s64 site_delta, target;
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
+		target = (s64)vaddr + 5 + (s64)orig_rel;
+		if (target < PAGE_SIZE || target >= TASK_SIZE_MAX)
+			return -EADDRNOTAVAIL;
+		t = (unsigned long)target;
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
+		u16 old_off = ptw->index[b].off;
+		u16 old_len = ptw->index[b].len;
+
+		if (block_off + ptw_a->stub_len <= old_off ||
+		    old_off + old_len <= block_off)
+			continue;
+		if (old_off == block_off && ptw->index[b].pun &&
+		    old_len == ptw_a->stub_len &&
+		    ptw->index[b].site_off == (s32)site_delta &&
+		    ptw->index[b].site_len == ptw_a->len &&
+		    !memcmp(ptw->index[b].site_insn, ptw_a->orig,
+			    ptw_a->len))
+			return pun_text_poke(auprobe, vma, vaddr, 0xe9, &ctx);
+		return -EADDRNOTAVAIL;
+	}
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
+	ptw->index[ptw->nblocks].pun = !nop_fallback;
+	ptw->index[ptw->nblocks].orig0 = orig[0];
+	ptw->index[ptw->nblocks].site_len = site_len;
+	ptw->index[ptw->nblocks].site_off = (s32)site_delta;
+	memcpy(ptw->index[ptw->nblocks].site_insn, ptw_a->orig, site_len);
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
+	if (block_off + ptw_a->stub_len > ptw->cursor)
+		ptw->cursor = block_off + ptw_a->stub_len;
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
 	u8 *kaddr, orig[5];
+	s64 site_delta;
 	s32 rel;
 	int ret;
+	int b;
 
 	if (!is_64bit_mm(mm))
 		return -EOPNOTSUPP;
@@ -1829,10 +2132,28 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	if (ptwrite_is_installed(mm, vaddr, orig))
 		return 0;
 
-	ret = ptwrite_validate_site(orig, vaddr);
-	if (ret)
-		return ret;
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
+		return ptwrite_text_poke(auprobe, vma, vaddr,
+					ptw->vaddr + ptw->index[b].off);
+	}
 	ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
 	if (!ptw)
 		return -ENOMEM;
@@ -1845,6 +2166,19 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	if (!ptwrite_rel32(stub_addr + ptw_a->jmp_off + 4,
 			   vaddr + 5, &rel))
 		return -ERANGE;
+	site_delta = (s64)vaddr - (s64)ptw->vaddr;
+	if (site_delta < INT_MIN || site_delta > INT_MAX)
+		return -ERANGE;
+
+	ptw->index[ptw->nblocks].off = block_off;
+	ptw->index[ptw->nblocks].len = ptw_a->stub_len;
+	ptw->index[ptw->nblocks].pun = 0;
+	ptw->index[ptw->nblocks].orig0 = orig[0];
+	ptw->index[ptw->nblocks].site_len = sizeof(orig);
+	ptw->index[ptw->nblocks].site_off = (s32)site_delta;
+	memcpy(ptw->index[ptw->nblocks].site_insn, orig, sizeof(orig));
+	/* Publish initialized metadata before exposing the probe jump. */
+	smp_store_release(&ptw->nblocks, ptw->nblocks + 1);
 
 	kaddr = kmap_local_page(ptw->page);
 	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);
@@ -1862,15 +2196,69 @@ int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct uprobe_ptwrite_arch *ptw_a = &auprobe->ptwrite;
+	struct uprobes_state *state = &mm->uprobes_state;
 	u8 cur[5];
+	struct uprobe_ptwrite_page *ptw, *found_page = NULL;
+	s32 rel;
+	s64 target, site_delta;
+	unsigned long page_base, boff;
+	int b, ret;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+		.expect = EXPECT_BYTE,
+		.expect_byte = 0xe9,
+	};
 
 	mmap_assert_write_locked(mm);
-	if (copy_from_vaddr(mm, vaddr, cur, sizeof(cur)) ||
-	    !ptwrite_is_installed(mm, vaddr, cur))
+
+	ret = copy_from_vaddr(mm, vaddr, cur, sizeof(cur));
+	if (ret)
+		return ret;
+	if (!ptwrite_is_installed(mm, vaddr, cur))
 		return 0;
 
-	return text_poke_5byte(auprobe, vma, vaddr, auprobe->ptwrite.orig,
-			UPROBE_SWBP_INSN, false, false, false, false, NULL);
+	memcpy(&rel, cur + 1, sizeof(rel));
+	target = (s64)vaddr + 5 + (s64)rel;
+	if (target < PAGE_SIZE || target >= TASK_SIZE_MAX)
+		return text_poke_5byte(auprobe, vma, vaddr, ptw_a->orig,
+				0xe9, false, false, false, false, NULL);
+	page_base = (unsigned long)target & PAGE_MASK;
+	boff = (unsigned long)target & (PAGE_SIZE - 1);
+	hlist_for_each_entry(ptw, &state->head_ptwrite, node)
+		if (ptw->vaddr == page_base) {
+			found_page = ptw;
+			break;
+		}
+	if (!found_page)
+		return 0;
+	/* Acquire the published count before reading block metadata. */
+	for (b = 0; b < smp_load_acquire(&found_page->nblocks); b++)
+		if (found_page->index[b].off == boff)
+			break;
+	if (b >= smp_load_acquire(&found_page->nblocks))
+		return 0;
+	site_delta = (s64)vaddr - (s64)found_page->vaddr;
+	if (site_delta < INT_MIN || site_delta > INT_MAX)
+		return 0;
+	if (found_page->index[b].site_off != (s32)site_delta ||
+	    found_page->index[b].site_len !=
+	    (found_page->index[b].pun ? ptw_a->len : sizeof(cur)) ||
+	    memcmp(found_page->index[b].site_insn, ptw_a->orig,
+		   found_page->index[b].site_len))
+		return 0;
+	if (found_page->index[b].pun) {
+		u8 orig0 = found_page->index[b].orig0;
+
+		ret = uprobe_write(auprobe, vma, vaddr, &orig0, 1,
+				   verify_insn, false, false, &ctx);
+		if (ret)
+			return ret;
+		smp_text_poke_sync_each_cpu();
+		return 0;
+	}
+	return text_poke_5byte(auprobe, vma, vaddr, ptw_a->orig,
+			0xe9, false, false, false, false, NULL);
 }
 
 static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned long vaddr)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 5f16799c9fb9..85779cff3414 100644
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
index 894196f3089f..78bc847d73cc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1509,6 +1509,8 @@ bool __weak arch_uprobe_ptwrite_supported(void)
 }
 
 int __weak arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
+				       struct inode *inode, struct file *file,
+				       loff_t offset,
 				       const struct uprobe_ptwrite_desc *desc)
 {
 	return -EOPNOTSUPP;
@@ -1586,13 +1588,19 @@ struct uprobe *uprobe_register_ptwrite(struct inode *inode, struct file *file,
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

