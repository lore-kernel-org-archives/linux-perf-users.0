Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23E2586C6
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216332; cv=none; b=ow7sZUpFpE89FyTonP96C7etQQDlNVLgO4/VoVngYttDrEemqNp54PJO38zBAz7hCa0q2wBPtBYCO6bnZsfqSxjfisV15d97wZ6DUju0+pSJ+dqupHL/E36ysaC7Qkbdoc/8bl5LDMjrhCTlJm7I6zgv3RQfniLOYLXsGqfJfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216332; c=relaxed/simple;
	bh=up872fM6yJvkziP+4dI1MrGG1wgvrmLWB2nPuwT2cw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwktutnnEUqCD+VFbdl5lXXk/3TNt3A0AyOvBnovQ/o9jdVGszlWTaZoOMFub9vmA5nSzANS7hq7BuvlBOIlpYlZlc/fGd/cz/1RBIy9ooXpzEsct4pY+dmVB1nXMJyXfX6lZr+ngIWMwiHvrtSCe5VRD47YuyGT9nyYewIlvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDk34OqP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDk34OqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxHe6mgzr5LViG+7+kvBnycnKkPt1kZTw9hZ/c9dl+o=;
	b=PDk34OqPTQ+NgLSmn73KKVs9RzI4zqK1o+/mIMQOWUyYtEVAuZh2BWVAlk9sGk+cGyb9tC
	JEfzr4L1rfp9BhIR4r0Bn9Ng6dhYGLwlxrcHQCOJT3WRMU4bW836bVBnKYXydOS/A4LV4D
	x2ZRvIuFltMCDQXeQuul9lfEMHmuMCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-7EzeC26YOIqM8Yqrg96d2A-1; Mon, 10 Feb 2025 14:38:47 -0500
X-MC-Unique: 7EzeC26YOIqM8Yqrg96d2A-1
X-Mimecast-MFC-AGG-ID: 7EzeC26YOIqM8Yqrg96d2A
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393e873962so8860245e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216326; x=1739821126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxHe6mgzr5LViG+7+kvBnycnKkPt1kZTw9hZ/c9dl+o=;
        b=eSNs8tM7IsnqoPrCJADpI+GYTdbhAW8BBG3xrNXZJ8/XOlUFOi32xi+BiLSIrwLazm
         jpmaMt5jwkmNIaBpCGa8zPehMag4PvMEQ18TUHM82BB1MRifh9MpQGUHiy/qGjwc7Ezn
         6Z269dE4ByyfqHir8f6H6OFvNSvTp26H27LLAKtC/h11779qITaQDmMql0yqiEYx4q6d
         +Rvd0kikPKgUOc4Q6vHuauv7MPe9j+YwlaDtGnLmstHTmPrFjggwR5XV1IejyTNHYk2s
         s5CykUjwJ3480vPln8x8rBloEvU0J/k0RoC6CwVvv8iCUZVyK5CXr8bBaQ93EVSF1PCX
         9egg==
X-Forwarded-Encrypted: i=1; AJvYcCUEoYKvif8441TiWOM6Hay0kpFyaotIkx1F8osEE4u8YlevslhpO9vHpeuDQgFfa+7VDJU0MiRudZqPuNyxkNTV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nRekf9G+TnWzub/sXd1MdANVS8C4KZkJIWDv0ytmj/X3FzE+
	V6qKaHGrpWkVu6kbtlmT3ODmPZVMkfNKNWtNkpMK1KLDLWUN1mSCOzL8k/ROe/oQQgEDiDibrOl
	85KJ99OiiHrgtF0j05F5PVrVZjzMy3RSx3D/ahE7M8KtZDEFZQrwUNCOlQQ1diN0lx3A=
X-Gm-Gg: ASbGnct5Uc+i6l51QEvU7iuPwp0hKhmxPOeeL4vdUuIB8UiLblFw1zci1X5AwQVxZ4H
	gnNrMFwYmqDhdUOHK0yyLaVFAFSeh1l1P69LjHnUpTXBD7uZfKYYqm29ydJVVMgCBKyxjGDTuzA
	5hlP5uT2mP8ibc4EVJ43C4tm7TG6waO06eMA6hHyoN7UeQZWdIX01JSqUrrvSUiswJsFLOpFGiL
	vdu4BA2rSkymD4jAEL8OFKmHWpGNuBtOOhDp1ERH5QqBOZjLfWNGxK0tXoXlzJ8tsjBUDV2CgRI
	yisBMr9RWQobx88qrw1GndcCuuOtkuhx+yIrwOEFMaPYBHNVmGgPfUTOxZzGca5KSQ==
X-Received: by 2002:a05:6000:2a6:b0:38d:dc4d:3473 with SMTP id ffacd0b85a97d-38ddc4d34b0mr6018852f8f.51.1739216326350;
        Mon, 10 Feb 2025 11:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI9wcsziW5nBYTCF/f9iYx8hWmPInDi/J4NMO1Qty0GFsip5PSFKOaGK1UrWp2GzbjhG1/jA==
X-Received: by 2002:a05:6000:2a6:b0:38d:dc4d:3473 with SMTP id ffacd0b85a97d-38ddc4d34b0mr6018834f8f.51.1739216325915;
        Mon, 10 Feb 2025 11:38:45 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dd295200asm7894656f8f.44.2025.02.10.11.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:44 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 11/17] mm/rmap: handle device-exclusive entries correctly in try_to_migrate_one()
Date: Mon, 10 Feb 2025 20:37:53 +0100
Message-ID: <20250210193801.781278-12-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

try_to_migrate_one() is not prepared for that, so teach it about these
PFN swap PTEs. We already handle device-private entries by specializing
on the folio, so we can reshuffle that code to make it work on the
PFN swap PTEs instead.

Get rid of the folio_is_device_private() handling. Note that we never
currently expect device-private folios with HWPoison flag set at that
point, so add a warning in case that ever changes and we can figure out
what the right thing to do is.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Further note that try_to_migrate() calls MMU notifiers and holds the
folio lock, so any device-exclusive users should be properly prepared
for a device-exclusive PTE to "vanish".

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 124 ++++++++++++++++++++++--------------------------------
 1 file changed, 51 insertions(+), 73 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 47142a656ae51..7c471c3ea64c4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2039,9 +2039,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	bool anon_exclusive, writable, ret = true;
 	pte_t pteval;
 	struct page *subpage;
-	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
@@ -2108,24 +2108,19 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
-
-		if (folio_is_zone_device(folio)) {
-			/*
-			 * Our PTE is a non-present device exclusive entry and
-			 * calculating the subpage as for the common case would
-			 * result in an invalid pointer.
-			 *
-			 * Since only PAGE_SIZE pages can currently be
-			 * migrated, just set it to page. This will need to be
-			 * changed when hugepage migrations to device private
-			 * memory are supported.
-			 */
-			VM_BUG_ON_FOLIO(folio_nr_pages(folio) > 1, folio);
-			subpage = &folio->page;
+		/*
+		 * Handle PFN swap PTEs, such as device-exclusive ones, that
+		 * actually map pages.
+		 */
+		pteval = ptep_get(pvmw.pte);
+		if (likely(pte_present(pteval))) {
+			pfn = pte_pfn(pteval);
 		} else {
-			subpage = folio_page(folio, pfn - folio_pfn(folio));
+			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
+
+		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
@@ -2181,7 +2176,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			}
 			/* Nuke the hugetlb page table entry */
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
-		} else {
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+			writable = pte_write(pteval);
+		} else if (likely(pte_present(pteval))) {
 			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
 			if (should_defer_flush(mm, flags)) {
@@ -2199,54 +2197,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+			writable = pte_write(pteval);
+		} else {
+			pte_clear(mm, address, pvmw.pte);
+			writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
 		}
 
-		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
-			folio_mark_dirty(folio);
+		VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
+				!anon_exclusive, folio);
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (folio_is_device_private(folio)) {
-			unsigned long pfn = folio_pfn(folio);
-			swp_entry_t entry;
-			pte_t swp_pte;
-
-			if (anon_exclusive)
-				WARN_ON_ONCE(folio_try_share_anon_rmap_pte(folio,
-									   subpage));
+		if (PageHWPoison(subpage)) {
+			VM_WARN_ON_FOLIO(folio_is_device_private(folio), folio);
 
-			/*
-			 * Store the pfn of the page in a special migration
-			 * pte. do_swap_page() will wait until the migration
-			 * pte is removed and then restart fault handling.
-			 */
-			entry = pte_to_swp_entry(pteval);
-			if (is_writable_device_private_entry(entry))
-				entry = make_writable_migration_entry(pfn);
-			else if (anon_exclusive)
-				entry = make_readable_exclusive_migration_entry(pfn);
-			else
-				entry = make_readable_migration_entry(pfn);
-			swp_pte = swp_entry_to_pte(entry);
-
-			/*
-			 * pteval maps a zone device page and is therefore
-			 * a swap pte.
-			 */
-			if (pte_swp_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_swp_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
-			trace_set_migration_pte(pvmw.address, pte_val(swp_pte),
-						folio_order(folio));
-			/*
-			 * No need to invalidate here it will synchronize on
-			 * against the special swap migration pte.
-			 */
-		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
@@ -2256,8 +2223,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				dec_mm_counter(mm, mm_counter(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
-
-		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
+		} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
+			   !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
@@ -2273,6 +2240,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			swp_entry_t entry;
 			pte_t swp_pte;
 
+			/*
+			 * arch_unmap_one() is expected to be a NOP on
+			 * architectures where we could have PFN swap PTEs,
+			 * so we'll not check/care.
+			 */
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				if (folio_test_hugetlb(folio))
 					set_huge_pte_at(mm, address, pvmw.pte,
@@ -2283,8 +2255,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
-			VM_BUG_ON_PAGE(pte_write(pteval) && folio_test_anon(folio) &&
-				       !anon_exclusive, subpage);
 
 			/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
 			if (folio_test_hugetlb(folio)) {
@@ -2309,7 +2279,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * pte. do_swap_page() will wait until the migration
 			 * pte is removed and then restart fault handling.
 			 */
-			if (pte_write(pteval))
+			if (writable)
 				entry = make_writable_migration_entry(
 							page_to_pfn(subpage));
 			else if (anon_exclusive)
@@ -2318,15 +2288,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			else
 				entry = make_readable_migration_entry(
 							page_to_pfn(subpage));
-			if (pte_young(pteval))
-				entry = make_migration_entry_young(entry);
-			if (pte_dirty(pteval))
-				entry = make_migration_entry_dirty(entry);
-			swp_pte = swp_entry_to_pte(entry);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			if (likely(pte_present(pteval))) {
+				if (pte_young(pteval))
+					entry = make_migration_entry_young(entry);
+				if (pte_dirty(pteval))
+					entry = make_migration_entry_dirty(entry);
+				swp_pte = swp_entry_to_pte(entry);
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			} else {
+				swp_pte = swp_entry_to_pte(entry);
+				if (pte_swp_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_swp_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			}
 			if (folio_test_hugetlb(folio))
 				set_huge_pte_at(mm, address, pvmw.pte, swp_pte,
 						hsz);
-- 
2.48.1

