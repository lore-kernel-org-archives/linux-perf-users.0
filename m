Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5344BD361;
	Thu, 17 Sep 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686130; cv=none; b=e76k2xd0Vy74hjV0UyjaIiavj/xTtba5W2gid6ujWimhz/K5NmI7NkbEsLLzaAd5qPyt5SgNHBWUDWzI6zCfTdvfmKPLNh2ziQ0VIdJQeyfrib3kWgkPlxFRiUqMb27MtiCMx/fwkdN0C0PGDZsL2BZdradXRmrelEDYCBAxNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686130; c=relaxed/simple;
	bh=GJFnYjN3U6Y4NP9Q3OfvNn3/RlNZO3XiJBWG0DCO0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzk6iY6IIBd0JEuSeEiBvOuJqJ4dVY1YS4N7xdWAy818ORm96euKS1pQuPxcpAROW8UqPdkzfZcNSNukJumu/gQLrC6DGr7U/lKiJSDI8bz7p9Z6oybx1L87pelur/xfkEiZuz6efk0LlT8lmgRZz3NWHP65CHIMpMmeWryYpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 0E34C5E8A9;
	Fri, 18 Sep 2026 01:01:55 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 90FF01622C2; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/11] ptwrite uprobes: Use atomic patching for multinop sites
Date: Thu, 17 Sep 2026 16:00:36 -0700
Message-ID: <20260917230127.924985-10-ak@kernel.org>
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

The earlier multinop patching is not quite safe because the cross
modified CPU could be already executing on a later nop when the
cross patching occurs. The Intel SDM allows cross modification
by larger stores as long as they are aligned. AMD has a similar
guarantee.

Support GCC function-entry patch sites is the main motivation for
multinop, and these sites are always aligned.

So enforce 8 bytes alignment of the multinop and use a safe RMW 8 byte store
to overwrite the 5 byte sequence. This assumes that the code is not
changing in parallel, but if that happens cross modification safety
is probably the smallest of the issues.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/kernel/uprobes.c | 183 +++++++++++++++++++++++---------------
 kernel/events/uprobes.c   |  15 +++-
 2 files changed, 123 insertions(+), 75 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index af9b36a219d3..114905bb69a8 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -17,6 +17,7 @@
 #include <linux/kdebug.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
@@ -828,6 +829,8 @@ int uprobe_ptwrite_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
 		kunmap_local(src);
 		new->vaddr = ptw->vaddr;
 		new->cursor = ptw->cursor;
+		new->nblocks = ptw->nblocks;
+		memcpy(new->index, ptw->index, sizeof(new->index));
 
 		vma = install_uprobe_ptwrite_vma(newmm, new->vaddr);
 		if (IS_ERR(vma)) {
@@ -1448,7 +1451,7 @@ static_assert((((9 + UPROBE_PTWRITE_SERIALIZE_LFENCES *
 			  UPROBE_PTWRITE_MAX_ARGS *
 				  (10 + UPROBE_PTWRITE_SERIALIZE_LFENCES *
 				   UPROBE_PTWRITE_LFENCE_SIZE) +
-			  5 + 7) & ~7) +
+			  UPROBE_PTWRITE_COPY_SIZE + 5 + 7) & ~7) +
 		       8 * (1 + UPROBE_PTWRITE_MAX_ARGS)) <=
 		      UPROBE_PTWRITE_STUB_SIZE,
 		      "worst-case ptwrite stub block exceeds UPROBE_PTWRITE_STUB_SIZE");
@@ -1460,6 +1463,7 @@ static bool ptwrite_has_room(const u8 *base, const u8 *p, size_t len)
 }
 
 static bool pun_site_is_nop(const u8 *orig, bool allow_nop_run);
+static bool ptwrite_site_is_multinop(const u8 *orig, bool allow_nop_run);
 static int pun_classify_insn(struct insn *insn, u8 *disp_off, s32 *disp);
 static int pun_decode_site(struct inode *inode, struct file *file,
 			       loff_t offset, u8 *copy,
@@ -1494,7 +1498,18 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 		return -EINVAL;
 
 	/* The generic registration path copied these bytes before this hook. */
+	ptw->allow_nop_run =
+		desc->flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN;
 	memcpy(ptw->orig, auprobe->insn, sizeof(ptw->orig));
+	/*
+	 * File mappings preserve page offsets, so an unaligned file offset
+	 * cannot become an aligned runtime address. Reject it before the probe
+	 * is exposed; install-time failures for a future mapping are otherwise
+	 * not observable through the tracefs enable operation.
+	 */
+	if (ptwrite_site_is_multinop(ptw->orig, ptw->allow_nop_run) &&
+	    !IS_ALIGNED(offset, sizeof(u64)))
+		return -EINVAL;
 
 	for (i = 0; i < desc->nargs; i++) {
 		switch (desc->args[i].src) {
@@ -1618,7 +1633,7 @@ int arch_uprobe_ptwrite_prepare(struct arch_uprobe *auprobe,
 
 	ptw->stub_len = data_off + 8 * (1 + n_imm);
 	ptw->ndata = 1 + n_imm;
-	ptw->allow_nop_run = desc->flags & UPROBE_PTWRITE_FL_ALLOW_NOP_RUN;
+
 
 	ret = pun_decode_site(inode, file, offset, code + ptw->copy_off,
 				  &ptw->disp_off, &ptw->disp,
@@ -1753,8 +1768,9 @@ get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
 }
 
 /*
- * A run of short NOPs is accepted only when requested. This validation does
- * not make the three-phase poke safe for threads that already passed byte 0.
+ * A run of short NOPs is accepted only when requested. It is patched with
+ * an aligned eight-byte read-modify-write, preserving the following bytes;
+ * code is not expected to change concurrently.
  */
 static bool ptwrite_is_nop_run(const u8 *orig)
 {
@@ -1940,6 +1956,42 @@ static int ptwrite_text_poke(struct arch_uprobe *auprobe,
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
+	u8 patch[sizeof(u64)];
+	s32 rel;
+	int err;
+
+	if (!IS_ALIGNED(vaddr, sizeof(u64)))
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
 static int pun_text_poke(struct arch_uprobe *auprobe,
 				 struct vm_area_struct *vma,
 				 unsigned long vaddr, u8 e9,
@@ -1971,65 +2023,40 @@ static int pun_install(struct arch_uprobe *auprobe,
 	unsigned long t, page_base, block_off, stub_addr;
 	s64 site_delta, target;
 	s32 jump_rel, disp32, orig_rel;
-	u8 site_len;
 	bool found = false;
-	bool nop_fallback = ptwrite_site_is_multinop(orig,
-						     ptw_a->allow_nop_run) &&
-			    (vaddr & 7);
 	u8 *kaddr;
 	int b, ret;
 
 	mmap_assert_write_locked(mm);
-	if (nop_fallback) {
-		hlist_for_each_entry(ptw, &state->head_ptwrite, node) {
-			site_delta = (s64)vaddr - (s64)ptw->vaddr;
-			if (site_delta < INT_MIN || site_delta > INT_MAX)
-				continue;
-			for (b = 0; b < smp_load_acquire(&ptw->nblocks); b++)
-				if (!ptw->index[b].pun &&
-				    ptw->index[b].site_off == (s32)site_delta &&
-				    ptw->index[b].site_len == 5 &&
-				    !memcmp(ptw->index[b].site_insn, orig, 5))
-					break;
-			if (b >= smp_load_acquire(&ptw->nblocks))
-				continue;
-			if (!__in_uprobe_ptwrite(mm, ptw->vaddr))
-				continue;
-			return ptwrite_text_poke(auprobe, vma, vaddr,
-						 ptw->vaddr + ptw->index[b].off);
+	memcpy(&orig_rel, orig + 1, sizeof(orig_rel));
+	target = (s64)vaddr + 5 + (s64)orig_rel;
+	if (target < PAGE_SIZE || target >= TASK_SIZE_MAX)
+		return -EADDRNOTAVAIL;
+	t = (unsigned long)target;
+	page_base = t & PAGE_MASK;
+	ret = security_mmap_addr(page_base);
+	if (ret)
+		return ret;
+	block_off = t & (PAGE_SIZE - 1);
+	if (block_off + ptw_a->stub_len > PAGE_SIZE)
+		return -ENOSPC;
+
+	/* Reuse an existing ptwrite page at the target, else map a new one. */
+	hlist_for_each_entry(ptw, &state->head_ptwrite, node) {
+		if (ptw->vaddr == page_base) {
+			found = true;
+			break;
 		}
-		ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
+	}
+	if (!found) {
+		if (vma_lookup(mm, page_base))
+			return -EADDRNOTAVAIL;
+		ptw = create_uprobe_ptwrite_page_at(mm, page_base);
 		if (!ptw)
 			return -ENOMEM;
-		block_off = ptw->cursor;
-	} else {
-		memcpy(&orig_rel, orig + 1, sizeof(orig_rel));
-		target = (s64)vaddr + 5 + (s64)orig_rel;
-		if (target < PAGE_SIZE || target >= TASK_SIZE_MAX)
-			return -EADDRNOTAVAIL;
-		t = (unsigned long)target;
-		page_base = t & PAGE_MASK;
-		block_off = t & (PAGE_SIZE - 1);
-		if (block_off + ptw_a->stub_len > PAGE_SIZE)
-			return -ENOSPC;
-
-		/* reuse an existing ptwrite page at the target, else map a new one */
-		hlist_for_each_entry(ptw, &state->head_ptwrite, node) {
-			if (ptw->vaddr == page_base) {
-				found = true;
-				break;
-			}
-		}
-		if (!found) {
-			if (vma_lookup(mm, page_base))
-				return -EADDRNOTAVAIL;	/* target page occupied */
-			ptw = create_uprobe_ptwrite_page_at(mm, page_base);
-			if (!ptw)
-				return -ENOMEM;
-			/* Order page initialization before publishing it to fault readers. */
-			smp_wmb();
-			hlist_add_head_rcu(&ptw->node, &state->head_ptwrite);
-		}
+		/* Publish initialized page fields before fault readers find it. */
+		smp_wmb();
+		hlist_add_head_rcu(&ptw->node, &state->head_ptwrite);
 	}
 
 	site_delta = (s64)vaddr - (s64)ptw->vaddr;
@@ -2068,19 +2095,13 @@ static int pun_install(struct arch_uprobe *auprobe,
 		disp32 = (s32)d;
 	}
 
-	/*
-	 * A NOP fallback needs a synthetic rel32 at the site, so it uses
-	 * the full five-byte poke and restore path rather than punning.
-	 */
-	site_len = nop_fallback ? 5 : ptw_a->len;
 	ptw->index[ptw->nblocks].off = block_off;
 	ptw->index[ptw->nblocks].len = ptw_a->stub_len;
-	ptw->index[ptw->nblocks].pun = !nop_fallback;
+	ptw->index[ptw->nblocks].pun = 1;
 	ptw->index[ptw->nblocks].orig0 = orig[0];
-	ptw->index[ptw->nblocks].site_len = site_len;
+	ptw->index[ptw->nblocks].site_len = ptw_a->len;
 	ptw->index[ptw->nblocks].site_off = (s32)site_delta;
-	memcpy(ptw->index[ptw->nblocks].site_insn, ptw_a->orig, site_len);
-	smp_store_release(&ptw->nblocks, ptw->nblocks + 1);
+	memcpy(ptw->index[ptw->nblocks].site_insn, ptw_a->orig, ptw_a->len);
 
 	kaddr = kmap_local_page(ptw->page);
 	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);
@@ -2089,11 +2110,10 @@ static int pun_install(struct arch_uprobe *auprobe,
 		memcpy(kaddr + block_off + ptw_a->copy_off + ptw_a->disp_off,
 		       &disp32, sizeof(disp32));
 	kunmap_local(kaddr);
+	/* Publish initialized metadata before exposing the probe jump. */
+	smp_store_release(&ptw->nblocks, ptw->nblocks + 1);
 
-	if (nop_fallback)
-		ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
-	else
-		ret = pun_text_poke(auprobe, vma, vaddr, 0xe9, &ctx);
+	ret = pun_text_poke(auprobe, vma, vaddr, 0xe9, &ctx);
 	if (ret) {
 		/* Publish rollback before readers observe the reduced block count. */
 		smp_store_release(&ptw->nblocks, ptw->nblocks - 1);
@@ -2129,6 +2149,9 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	ret = copy_from_vaddr(mm, vaddr, orig, sizeof(orig));
 	if (ret)
 		return ret;
+	if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run) &&
+	    !IS_ALIGNED(vaddr, sizeof(u64)))
+		return -EINVAL;
 	if (ptwrite_is_installed(mm, vaddr, orig))
 		return 0;
 
@@ -2151,8 +2174,13 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 			continue;
 		if (!__in_uprobe_ptwrite(mm, ptw->vaddr))
 			continue;
-		return ptwrite_text_poke(auprobe, vma, vaddr,
-					ptw->vaddr + ptw->index[b].off);
+		if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run))
+			ret = ptwrite_multinop_text_poke(auprobe, vma, vaddr,
+							ptw->vaddr + ptw->index[b].off);
+		else
+			ret = ptwrite_text_poke(auprobe, vma, vaddr,
+						ptw->vaddr + ptw->index[b].off);
+		return ret;
 	}
 	ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
 	if (!ptw)
@@ -2186,10 +2214,17 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	memcpy(kaddr + block_off + ptw_a->jmp_off, &rel, sizeof(rel));
 	kunmap_local(kaddr);
 
-	ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
-	if (!ret)
-		ptw->cursor = block_off + ptw_a->stub_len;
-	return ret;
+	if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run))
+		ret = ptwrite_multinop_text_poke(auprobe, vma, vaddr, stub_addr);
+	else
+		ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
+	if (ret) {
+		/* Publish rollback before readers use the reduced block count. */
+		smp_store_release(&ptw->nblocks, ptw->nblocks - 1);
+		return ret;
+	}
+	ptw->cursor = block_off + ptw_a->stub_len;
+	return 0;
 }
 
 int arch_uprobe_uninstall_ptwrite(struct arch_uprobe *auprobe,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 78bc847d73cc..18c5df46a509 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -192,7 +192,20 @@ void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, in
 static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
 	void *kaddr = kmap_local_page(page);
-	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
+	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+
+	/*
+	 * Atomic eight-byte stores are required for safe cross-modification of
+	 * live user text; other writes use the ordinary byte-copy path.
+	 */
+	if (len == sizeof(u64) && IS_ALIGNED(vaddr, sizeof(u64))) {
+		u64 value;
+
+		memcpy(&value, src, sizeof(value));
+		WRITE_ONCE(*(u64 *)dst, value);
+	} else {
+		memcpy(dst, src, len);
+	}
 	kunmap_local(kaddr);
 }
 
-- 
2.54.0

