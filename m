Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EF226CF5
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557047; cv=none; b=lgz3KLAkJ2XkpTxJwBr3M1gE8+sIyVk69jxd39pLHrVbCLUkvYQytRu5nOg/KZcUhopOLqkdx8sSbShEQpDrLlBx3iE0umWHTZ2llhn3b1QsSRgq7RDpi6Gpf6MTyeFGTSq1hGclnePgRaFkZxcJw5I9RxzLwqu4lUqYbB/TVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557047; c=relaxed/simple;
	bh=+8Vl4PNSwXiJI+gdFhFYs/aXgmf6RY6AKWNZGyV48ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTTZe6RJCVqDmDHsAI0n62P1bVIuvZ3N7mRWLQliZp8ELbtRwdc+8Bvs+2xbFfvam67sBTD/Wg4UR2tu0qY/whCOjIeYU8JDYQQc+3ztPNpb8JvBN44qVI7ILzkGtyRdCXD8h1agRxgXZP/bsFStQRYryTlWJEEAnjot5+MJzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBH+OwSa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBH+OwSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJdKl7eMVXp/E0C5Su96l6r1ubOFuz+HPNb8MwX5DOc=;
	b=ZBH+OwSaQzuKxraGePuS8zTWqTXMkY5ijI23GOSyldDj8UtjlYzwXC+RSYPj8MU7B9yiuW
	4Mvb6XJgWBqJfMwI50gi9A2n2Gzr7J7GEkeAOkB74Bh9JZyt3hUjPdwXRc/73g2BMs47lk
	iWCLLvT7WUrpOuWdA/11xNptKW1tXpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-GXMrBYyqNoKb4r0_IGVk_A-1; Fri, 21 Mar 2025 07:37:23 -0400
X-MC-Unique: GXMrBYyqNoKb4r0_IGVk_A-1
X-Mimecast-MFC-AGG-ID: GXMrBYyqNoKb4r0_IGVk_A_1742557042
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3978ef9a284so734183f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 04:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557042; x=1743161842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJdKl7eMVXp/E0C5Su96l6r1ubOFuz+HPNb8MwX5DOc=;
        b=ZW2NlKbFP9+rYA1WKic91xlZjuwSzZCJF3ZzhYkzZr+mfsPJrA3YIoH+uu6EhZAQhc
         /y+FilC6Fp4UPbzlZRJ6fqiQKZiZr4dr3mkLo6OZNFCHi482N9bIRussotJQIynpZiJh
         7A3BGAQMPR/lGnDjzFQ9bNkf1uAVVusSv3qHfHKA0NgfviBSXFv1nwQXCUR3qppnCs7z
         Medt2hLXGane440WWAzP6bWznCqprOF1DKUkkN5ZBGQ02n6AoB+ikp4KI+NhWaeCLVa3
         +cLFhcKU0SJDAgfDDAWVhdLK4D4YgiBmtw5eZpqSoFpV2LJLJYU7egp7up+WkqIykn5j
         rWxw==
X-Forwarded-Encrypted: i=1; AJvYcCWAD/SwZiN8TKfvDMB9ecEV0wxxH9lGdqgr6iE3AoMtLk2oF46UKB3DePcE95M1PYXA93oSKKc9HSwVamwUr+vs@vger.kernel.org
X-Gm-Message-State: AOJu0YzipO3Ug43jhCpKjf9s2D+tuUJcPkTdocjUSuJz8Zzc8e3SPG02
	xgCnyFLss1wB9Ce1CNhOsMXiAxrglzI3VAg0S/BYgklo2CeMK/uN9q5cFjwNYnHdJaH3dsMa5fl
	BGM8+0mQH6fTdJp7d5gEjSCPsI4XWoSE7FOl1QvfEdakaMcKaFiTztOicbznDcwUHLu0=
X-Gm-Gg: ASbGnctd5SJnJ1b1+bLnRPjsv/0jxiXnollonUEp7KKd6+64+hYO/cEiw9JsfI4GJoa
	S2T0n1h2SClKOLvVnG4j2ymlU45BOhuY/oNfQ1g8SILY9mxETVHmyuqPyEGk1H5i2C2uCD9e5w6
	ITBkg0tn8ZRDb0nxqxK8K9fSfBBUWjsO7GuyhPtaTQlHmj2Q/MBm+YtVshonfTkgmAUmwkmoRTE
	3CwBDldTTTqI/MckW46bTrGSJN2U6ks8Zy184hEWp8moakeNb/PskdM1C9QUAMoTHSShSZxTXsz
	p2ek09KrUpVBOy5nmdLe6AQVloq5sUD7poTpQq9N19NDLIcd6M7f0Cj1USgtquAjr9kjUOGCoQS
	I
X-Received: by 2002:a5d:6d08:0:b0:391:3261:ff48 with SMTP id ffacd0b85a97d-3997f92d06dmr3398978f8f.35.1742557041653;
        Fri, 21 Mar 2025 04:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8Axp06fh0N+BXwj2bhaZ4JLVC+fk8FODg2R4HEdpHhstbeEn/gKETuIO/dmFqvvCgQmToHQ==
X-Received: by 2002:a5d:6d08:0:b0:391:3261:ff48 with SMTP id ffacd0b85a97d-3997f92d06dmr3398923f8f.35.1742557041089;
        Fri, 21 Mar 2025 04:37:21 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f99561dsm2182430f8f.12.2025.03.21.04.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:37:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v3 3/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Fri, 21 Mar 2025 12:37:13 +0100
Message-ID: <20250321113713.204682-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321113713.204682-1-david@redhat.com>
References: <20250321113713.204682-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
we'll walk the page tables using a folio_walk to perform our page
modification atomically by temporarily unmap the PTE + flushing the TLB.

Likely, we could avoid the temporary unmap in case we can just
atomically write the instruction, but that will be a separate project.

Unfortunately, we still have to implement the zapping logic manually,
because we only want to zap in specific circumstances (e.g., page
content identical).

Note that we can now handle large folios (compound pages) and the shared
zeropage just fine, so drop these checks.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 312 ++++++++++++++++++++--------------------
 1 file changed, 158 insertions(+), 154 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ac17c16f65d63..f098e8a4f24ee 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -29,6 +29,7 @@
 #include <linux/workqueue.h>
 #include <linux/srcu.h>
 #include <linux/oom.h>          /* check_stable_address_space */
+#include <linux/pagewalk.h>
 
 #include <linux/uprobes.h>
 
@@ -151,91 +152,6 @@ static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
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
-	pte_t pte;
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
-	pte = ptep_get(pvmw.pte);
-
-	/*
-	 * Handle PFN swap PTES, such as device-exclusive ones, that actually
-	 * map pages: simply trigger GUP again to fix it up.
-	 */
-	if (unlikely(!pte_present(pte))) {
-		page_vma_mapped_walk_done(&pvmw);
-		goto unlock;
-	}
-
-	if (new_page) {
-		folio_get(new_folio);
-		folio_add_new_anon_rmap(new_folio, vma, addr, RMAP_EXCLUSIVE);
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
-	flush_cache_page(vma, addr, pte_pfn(pte));
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
@@ -463,6 +379,95 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 	return ret;
 }
 
+static bool orig_page_is_identical(struct vm_area_struct *vma,
+		unsigned long vaddr, struct page *page, bool *pmd_mappable)
+{
+	const pgoff_t index = vaddr_to_offset(vma, vaddr) >> PAGE_SHIFT;
+	struct folio *orig_folio = filemap_get_folio(vma->vm_file->f_mapping,
+						    index);
+	struct page *orig_page;
+	bool identical;
+
+	if (IS_ERR(orig_folio))
+		return false;
+	orig_page = folio_file_page(orig_folio, index);
+
+	*pmd_mappable = folio_test_pmd_mappable(orig_folio);
+	identical = folio_test_uptodate(orig_folio) &&
+		    pages_identical(page, orig_page);
+	folio_put(orig_folio);
+	return identical;
+}
+
+static int __uprobe_write_opcode(struct vm_area_struct *vma,
+		struct folio_walk *fw, struct folio *folio,
+		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+{
+	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
+	const bool is_register = !!is_swbp_insn(&opcode);
+	bool pmd_mappable;
+
+	/* For now, we'll only handle PTE-mapped folios. */
+	if (fw->level != FW_LEVEL_PTE)
+		return -EFAULT;
+
+	/*
+	 * See can_follow_write_pte(): we'd actually prefer a writable PTE here,
+	 * but the VMA might not be writable.
+	 */
+	if (!pte_write(fw->pte)) {
+		if (!PageAnonExclusive(fw->page))
+			return -EFAULT;
+		if (unlikely(userfaultfd_pte_wp(vma, fw->pte)))
+			return -EFAULT;
+		/* SOFTDIRTY is handled via pte_mkdirty() below. */
+	}
+
+	/*
+	 * We'll temporarily unmap the page and flush the TLB, such that we can
+	 * modify the page atomically.
+	 */
+	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
+	fw->pte = ptep_clear_flush(vma, vaddr, fw->ptep);
+	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+
+	/*
+	 * When unregistering, we may only zap a PTE if uffd is disabled and
+	 * there are no unexpected folio references ...
+	 */
+	if (is_register || userfaultfd_missing(vma) ||
+	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
+	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
+		goto remap;
+
+	/*
+	 * ... and the mapped page is identical to the original page that
+	 * would get faulted in on next access.
+	 */
+	if (!orig_page_is_identical(vma, vaddr, fw->page, &pmd_mappable))
+		goto remap;
+
+	dec_mm_counter(vma->vm_mm, MM_ANONPAGES);
+	folio_remove_rmap_pte(folio, fw->page, vma);
+	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
+	     folio_trylock(folio)) {
+		folio_free_swap(folio);
+		folio_unlock(folio);
+	}
+	folio_put(folio);
+
+	return pmd_mappable;
+remap:
+	/*
+	 * Make sure that our copy_to_page() changes become visible before the
+	 * set_pte_at() write.
+	 */
+	smp_wmb();
+	/* We modified the page. Make sure to mark the PTE dirty. */
+	set_pte_at(vma->vm_mm, vaddr, fw->ptep, pte_mkdirty(fw->pte));
+	return 0;
+}
+
 /*
  * NOTE:
  * Expect the breakpoint instruction to be the smallest size instruction for
@@ -475,116 +480,115 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * uprobe_write_opcode - write the opcode at a given virtual address.
  * @auprobe: arch specific probepoint information.
  * @vma: the probed virtual memory area.
- * @vaddr: the virtual address to store the opcode.
- * @opcode: opcode to be written at @vaddr.
+ * @opcode_vaddr: the virtual address to store the opcode.
+ * @opcode: opcode to be written at @opcode_vaddr.
  *
  * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		unsigned long vaddr, uprobe_opcode_t opcode)
+		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
+	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
 	struct uprobe *uprobe;
-	struct page *old_page, *new_page;
 	int ret, is_register, ref_ctr_updated = 0;
-	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
+	struct mmu_notifier_range range;
+	struct folio_walk fw;
+	struct folio *folio;
+	struct page *page;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
-retry:
+	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
+		return -EINVAL;
+
+	/*
+	 * When registering, we have to break COW to get an exclusive anonymous
+	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
+	 * fault if required. When unregistering, we might be lucky and the
+	 * anon page is already gone. So defer write faults until really
+	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
+	 * cannot deal with PMDs yet.
+	 */
 	if (is_register)
-		gup_flags |= FOLL_SPLIT_PMD;
-	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &old_page, NULL);
-	if (ret != 1)
-		return ret;
+		gup_flags |= FOLL_WRITE | FOLL_SPLIT_PMD;
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+retry:
+	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &page, NULL);
 	if (ret <= 0)
-		goto put_old;
-
-	if (is_zero_page(old_page)) {
-		ret = -EINVAL;
-		goto put_old;
-	}
+		goto out;
+	folio = page_folio(page);
 
-	if (WARN(!is_register && PageCompound(old_page),
-		 "uprobe unregister should never work on compound page\n")) {
-		ret = -EINVAL;
-		goto put_old;
+	ret = verify_opcode(page, opcode_vaddr, &opcode);
+	if (ret <= 0) {
+		folio_put(folio);
+		goto out;
 	}
 
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
-		if (ret)
-			goto put_old;
+		if (ret) {
+			folio_put(folio);
+			goto out;
+		}
 
 		ref_ctr_updated = 1;
 	}
 
 	ret = 0;
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
+	if (unlikely(!folio_test_anon(folio))) {
+		VM_WARN_ON_ONCE(is_register);
+		folio_put(folio);
+		goto out;
+	}
 
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
+	}
+
+	ret = -EAGAIN;
+	/* Walk the page tables again, to perform the actual update. */
+	if (folio_walk_start(&fw, vma, vaddr, 0)) {
+		if (fw.page == page)
+			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr, opcode);
+		folio_walk_end(&fw, vma);
 	}
 
-	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
-	if (new_page)
-		put_page(new_page);
-put_old:
-	put_page(old_page);
+	if (!is_register)
+		mmu_notifier_invalidate_range_end(&range);
 
-	if (unlikely(ret == -EAGAIN))
+	folio_put(folio);
+	switch (ret) {
+	case -EFAULT:
+		gup_flags |= FOLL_WRITE | FOLL_SPLIT_PMD;
+		fallthrough;
+	case -EAGAIN:
 		goto retry;
+	default:
+		break;
+	}
 
+out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret && is_register && ref_ctr_updated)
+	if (ret < 0 && is_register && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, -1);
 
 	/* try collapse pmd for compound page */
-	if (!ret && orig_page_huge)
+	if (ret > 0)
 		collapse_pte_mapped_thp(mm, vaddr, false);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 /**
-- 
2.48.1

