Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB4146581
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503986; cv=none; b=EzblDogMdbj4uQttCf4xihueN8MOuUmPuoDLqEA7QQrzivuStBcz7qiyy+KNekbqgd6x+TQnbaVE+R1ABOAZzTfxuOu7n4xEN9OvE2d8KJkqLSX3nmfXRTn4nTgjcZGwaWkvY3SvfaCdapjZ9vN13uVpuihRxswK0QtEdNZIjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503986; c=relaxed/simple;
	bh=c5cfExdcFg0Hh81w+M1DIVoQ+9gGtp4qJ5aFJKdMzdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rREX2BYqfufz++aUlIDEiHxWfg90T/qgeY6amhLTtc/+HeGQox/agyrqcj7x6FhdVo1qNnAhKTdMMuZOQTCU051w1qfIOi3DawoN2M2fz1NCaeZR9ASqf6gQ7pQsFbUu/68QGLq+I0SFX4Zc6ZT2MHScMPgogxcaVlRlQgPBT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMT7EjHR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMT7EjHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717503983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnFa3KkR11uKBOePM8iHmpy6uffAuJd7k5r6Ny89vc8=;
	b=UMT7EjHRpzz29nWO6s/265fI+EXDjT+K3KguC3TOdsa+VkkD088oklgha9JfJzwd1+ZwBN
	iwgxz762uZGegun0Ijr4wadpx5eRjuHLiW6WOmi/UMomtpgZKWUL2e7UMjKP7ATDlD1QRP
	hDAi44O2MJJlyOifsIhVEsYyN5im740=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-TgKOtLjzPtirdHQq3B4p2Q-1; Tue,
 04 Jun 2024 08:26:20 -0400
X-MC-Unique: TgKOtLjzPtirdHQq3B4p2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE98D1895DE9;
	Tue,  4 Jun 2024 12:26:17 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DBE11955D89;
	Tue,  4 Jun 2024 12:26:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Russell King <linux@armlinux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH RFC 3/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Tue,  4 Jun 2024 14:25:48 +0200
Message-ID: <20240604122548.359952-4-david@redhat.com>
In-Reply-To: <20240604122548.359952-1-david@redhat.com>
References: <20240604122548.359952-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

uprobe_write_opcode() does some pretty low-level things that really, it
shouldn't be doing: for example, manually breaking COW by allocating
anonymous folios and replacing mapped pages.

Further, it does seem to do some shaky things: for example, writing to
possible COW-shared anonymous pages or zapping anonymous pages that might
be pinned. We're also not taking care of uffd, uffd-wp, softdirty ...
although rather corner cases here. Let's just get it right like ordinary
ptrace writes would.

Let's rewrite the code, leaving COW-breaking to core-MM, triggered by
FOLL_FORCE|FOLL_WRITE (note that the code was already using FOLL_FORCE).

We'll use GUP to lookup/faultin the page and break COW if required. Then,
we'll walk the page tables using walk_page_range_vma(), to perform our page
modification atomically by temporarily unmap+flushing the PTE that maps an
anonymous page.

Unfortunately, we still have to implement the zapping logic manually,
because we only want to zap in specific circumstances (e.g., page
content identical).

Note that we can handle large folios just fine. walk_page_range_vma() will
call split_huge_pmd() for us. We can drop the WARN and stop using
FOLL_SPLIT_PMD. If split_huge_pmd() decides to zap a PMD-mapped file THP,
there is nothing to do when unregistering. Document that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 342 +++++++++++++++++++++++-----------------
 1 file changed, 194 insertions(+), 148 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f2b1fef7f1d62..a22f2e9fd6456 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/pagewalk.h>
 
 #include <linux/uprobes.h>
 
@@ -137,80 +138,6 @@ static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
 	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
 }
 
-/**
- * __replace_page - replace page in vma by new page.
- * based on replace_page in mm/ksm.c
- *
- * @vma:      vma that holds the pte pointing to page
- * @addr:     address the old @page is mapped at
- * @old_page: the page we are replacing by new_page
- * @new_page: the modified page we replace page by
- *
- * If @new_page is NULL, only unmap @old_page.
- *
- * Returns 0 on success, negative error code otherwise.
- */
-static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
-				struct page *old_page, struct page *new_page)
-{
-	struct folio *old_folio = page_folio(old_page);
-	struct folio *new_folio;
-	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
-	int err;
-	struct mmu_notifier_range range;
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
-				addr + PAGE_SIZE);
-
-	if (new_page) {
-		new_folio = page_folio(new_page);
-		err = mem_cgroup_charge(new_folio, vma->vm_mm, GFP_KERNEL);
-		if (err)
-			return err;
-	}
-
-	/* For folio_free_swap() below */
-	folio_lock(old_folio);
-
-	mmu_notifier_invalidate_range_start(&range);
-	err = -EAGAIN;
-	if (!page_vma_mapped_walk(&pvmw))
-		goto unlock;
-	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
-
-	if (new_page) {
-		folio_get(new_folio);
-		folio_add_new_anon_rmap(new_folio, vma, addr);
-		folio_add_lru_vma(new_folio, vma);
-	} else
-		/* no new page, just dec_mm_counter for old_page */
-		dec_mm_counter(mm, MM_ANONPAGES);
-
-	if (!folio_test_anon(old_folio)) {
-		dec_mm_counter(mm, mm_counter_file(old_folio));
-		inc_mm_counter(mm, MM_ANONPAGES);
-	}
-
-	flush_cache_page(vma, addr, pte_pfn(ptep_get(pvmw.pte)));
-	ptep_clear_flush(vma, addr, pvmw.pte);
-	if (new_page)
-		set_pte_at(mm, addr, pvmw.pte,
-			   mk_pte(new_page, vma->vm_page_prot));
-
-	folio_remove_rmap_pte(old_folio, old_page, vma);
-	if (!folio_mapped(old_folio))
-		folio_free_swap(old_folio);
-	page_vma_mapped_walk_done(&pvmw);
-	folio_put(old_folio);
-
-	err = 0;
- unlock:
-	mmu_notifier_invalidate_range_end(&range);
-	folio_unlock(old_folio);
-	return err;
-}
-
 /**
  * is_swbp_insn - check if instruction is breakpoint instruction.
  * @insn: instruction to be checked.
@@ -438,6 +365,120 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 	return ret;
 }
 
+static bool orig_page_is_identical(struct vm_area_struct *vma,
+		unsigned long vaddr, struct page *page, bool *large)
+{
+	const pgoff_t index = vaddr_to_offset(vma, vaddr) >> PAGE_SHIFT;
+	struct page *orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
+					       index);
+	struct folio *orig_folio;
+	bool identical;
+
+	if (!orig_page)
+		return false;
+	orig_folio = page_folio(orig_page);
+
+	*large = folio_test_large(orig_folio);
+	identical = folio_test_uptodate(orig_folio) &&
+		    pages_identical(page, orig_page);
+	folio_put(orig_folio);
+	return identical;
+}
+
+#define UWO_NO_PGTABLE		0
+#define UWO_RETRY		1
+#define UWO_RETRY_WRITE_FAULT	2
+#define UWO_DONE		3
+#define UWO_DONE_COLLAPSE	4
+
+struct uwo_data {
+	unsigned long opcode_vaddr;
+	uprobe_opcode_t opcode;
+};
+
+static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct uwo_data *data = walk->private;
+	const bool is_register = !!is_swbp_insn(&data->opcode);
+	pte_t pte = ptep_get(ptep);
+	struct folio *folio = NULL;
+	struct page *page;
+	bool large;
+
+	if (!pte_present(pte))
+		return UWO_RETRY;
+	page = vm_normal_page(walk->vma, vaddr, pte);
+	if (page)
+		folio = page_folio(page);
+
+	/*
+	 * If we don't find an anonymous folio when unregistering, we're done.
+	 */
+	if (!folio || !folio_test_anon(folio))
+		return is_register ? UWO_RETRY_WRITE_FAULT : UWO_DONE;
+
+	/*
+	 * See can_follow_write_pte(): we'd actually prefer a writable PTE here,
+	 * but when unregistering we might no longer have VM_WRITE ...
+	 */
+	if (!pte_write(pte)) {
+		if (!PageAnonExclusive(page))
+			return UWO_RETRY_WRITE_FAULT;
+		if (unlikely(userfaultfd_pte_wp(walk->vma, pte)))
+			return UWO_RETRY_WRITE_FAULT;
+		/* SOFTDIRTY is handled via pte_mkdirty() below. */
+	}
+
+	/* Unmap + flush the TLB, such that we can write atomically .*/
+	flush_cache_page(walk->vma, vaddr, pte_pfn(pte));
+	pte = ptep_clear_flush(walk->vma, vaddr, ptep);
+	copy_to_page(page, data->opcode_vaddr, &data->opcode,
+		     UPROBE_SWBP_INSN_SIZE);
+
+	/*
+	 * When unregistering, we may only zap a PTE if uffd is disabled and
+	 * there are no unexpected folio references ...
+	 */
+	if (is_register || userfaultfd_missing(walk->vma) ||
+	    (folio_ref_count(folio) != folio_mapcount(folio) +
+	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
+		goto remap;
+
+	/*
+	 * ... and the mapped page is identical to the original page that
+	 * would get faulted in on next access.
+	 */
+	if (!orig_page_is_identical(walk->vma, vaddr, page, &large))
+		goto remap;
+
+	/* Zap it and try to reclaim swap space. */
+	dec_mm_counter(walk->mm, MM_ANONPAGES);
+	folio_remove_rmap_pte(folio, page, walk->vma);
+	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
+	     folio_trylock(folio)) {
+		folio_free_swap(folio);
+		folio_unlock(folio);
+	}
+	folio_put(folio);
+
+	return large ? UWO_DONE_COLLAPSE : UWO_DONE;
+remap:
+	/*
+	 * Make sure that our copy_to_page() changes become visible before the
+	 * set_pte_at() write.
+	 */
+	smp_wmb();
+	/* We modified the page. Make sure to mark the PTE dirty. */
+	set_pte_at(walk->mm, vaddr, ptep, pte_mkdirty(pte));
+	return UWO_DONE;
+}
+
+static const struct mm_walk_ops write_opcode_ops = {
+	.pte_entry		= __write_opcode_pte,
+	.walk_lock		= PGWALK_WRLOCK,
+};
+
 /*
  * NOTE:
  * Expect the breakpoint instruction to be the smallest size instruction for
@@ -450,111 +491,116 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * uprobe_write_opcode - write the opcode at a given virtual address.
  * @auprobe: arch specific probepoint information.
  * @vma: the probed virtual memory area.
- * @vaddr: the virtual address to store the opcode.
- * @opcode: opcode to be written at @vaddr.
+ * @opcode_vaddr: the virtual address to store the opcode.
+ * @opcode: opcode to be written at @opcode_vaddr.
  *
  * Called with mm->mmap_lock held for write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		unsigned long vaddr, uprobe_opcode_t opcode)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct uprobe *uprobe;
-	struct page *old_page, *new_page;
-	int ret, is_register, ref_ctr_updated = 0;
-	bool orig_page_huge = false;
+		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+{
+	struct uprobe *uprobe = container_of(auprobe, struct uprobe, arch);
+	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
+	const bool is_register = !!is_swbp_insn(&opcode);
+	struct uwo_data data = {
+		.opcode = opcode,
+		.opcode_vaddr = opcode_vaddr,
+	};
 	unsigned int gup_flags = FOLL_FORCE;
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	int ret, ref_ctr_updated = 0;
+	struct page *page;
 
-	is_register = is_swbp_insn(&opcode);
-	uprobe = container_of(auprobe, struct uprobe, arch);
+	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
+		return -EINVAL;
 
-retry:
+	/*
+	 * When registering, we have to break COW to get an exclusive anonymous
+	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
+	 * fault if required. When unregistering, we might be lucky and the
+	 * anon page is already gone. So defer write faults until really
+	 * required.
+	 */
 	if (is_register)
-		gup_flags |= FOLL_SPLIT_PMD;
-	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &old_page, NULL);
+		gup_flags |= FOLL_WRITE;
+
+retry:
+	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &page, NULL);
 	if (ret != 1)
-		return ret;
+		goto out;
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	ret = verify_opcode(page, opcode_vaddr, &opcode);
+	put_page(page);
 	if (ret <= 0)
-		goto put_old;
-
-	if (WARN(!is_register && PageCompound(old_page),
-		 "uprobe unregister should never work on compound page\n")) {
-		ret = -EINVAL;
-		goto put_old;
-	}
+		goto out;
 
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
 		if (ret)
-			goto put_old;
-
+			goto out;
 		ref_ctr_updated = 1;
 	}
 
-	ret = 0;
-	if (!is_register && !PageAnon(old_page))
-		goto put_old;
-
-	ret = anon_vma_prepare(vma);
-	if (ret)
-		goto put_old;
-
-	ret = -ENOMEM;
-	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vaddr);
-	if (!new_page)
-		goto put_old;
-
-	__SetPageUptodate(new_page);
-	copy_highpage(new_page, old_page);
-	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
-
 	if (!is_register) {
-		struct page *orig_page;
-		pgoff_t index;
-
-		VM_BUG_ON_PAGE(!PageAnon(old_page), old_page);
-
-		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
-		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
-					  index);
-
-		if (orig_page) {
-			if (PageUptodate(orig_page) &&
-			    pages_identical(new_page, orig_page)) {
-				/* let go new_page */
-				put_page(new_page);
-				new_page = NULL;
-
-				if (PageCompound(orig_page))
-					orig_page_huge = true;
-			}
-			put_page(orig_page);
-		}
+		/*
+		 * In the common case, we'll be able to zap the page when
+		 * unregistering. So trigger MMU notifiers now, as we won't
+		 * be able to do it under PTL.
+		 */
+		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+					vaddr, vaddr + PAGE_SIZE);
+		mmu_notifier_invalidate_range_start(&range);
 	}
 
-	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
-	if (new_page)
-		put_page(new_page);
-put_old:
-	put_page(old_page);
+	/*
+	 * Perform another page table walk and perform the actual page
+	 * modification.
+	 */
+	ret = walk_page_range_vma(vma, vaddr, vaddr + PAGE_SIZE,
+				  &write_opcode_ops, &data);
 
-	if (unlikely(ret == -EAGAIN))
-		goto retry;
+	if (!is_register)
+		mmu_notifier_invalidate_range_end(&range);
 
+	switch (ret) {
+	case UWO_NO_PGTABLE: /* walk_page_range_vma() returned 0. */
+		/*
+		 * walk_page_range_vma() did not find anything. If there
+		 * would have been a PMD-mapped file THP, it could have
+		 * simply been zapped; in that (unlikely) case, there is
+		 * nothing to when unregistering.
+		 *
+		 * If we had a PMD-mapped anonymous folio,
+		 * walk_page_range_vma() would have PTE-mapped it for us
+		 * and walked it.
+		 */
+		if (is_register)
+			goto retry;
+		break;
+	case UWO_RETRY_WRITE_FAULT:
+		gup_flags |= FOLL_WRITE;
+		fallthrough;
+	case UWO_RETRY:
+		goto retry;
+	case UWO_DONE_COLLAPSE:
+	case UWO_DONE:
+		break;
+	default:
+		VM_WARN_ON_ONCE(1);
+	}
+out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret && is_register && ref_ctr_updated)
+	if (ret < 0 && is_register && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, -1);
 
 	/* try collapse pmd for compound page */
-	if (!ret && orig_page_huge)
+	if (ret == UWO_DONE_COLLAPSE)
 		collapse_pte_mapped_thp(mm, vaddr, false);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 /**
-- 
2.45.1

