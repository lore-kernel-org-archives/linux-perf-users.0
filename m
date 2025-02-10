Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FB2586FE
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216302; cv=none; b=HVGkDK/AA13EK3gpDhJ3Wbp90NOcVcfoSLeh2EO4Khn+KWyMfHeMcTeBI1ZPQ27FLmZF/HnKJounF1BI442iKzNkgYQbr4u2DoCFfU0o/gTOWAw+aS7QP6z/K5eRnWY2bx3Bn4jPK3vhYfAZ2HlfIgz5NWTkg0LGcat+y9oqbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216302; c=relaxed/simple;
	bh=81YcqeJ5l6K3coBhnps2sV67ll19MCM8Tocl525qDoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryPnmTrDtGSUsxiobekjAT+76r4yiARbbidGC5j7aBm4sOEDl70ZWxt57laLDStl/48TS6doB02NMx+J0/QZJiLPrQ71q4JZD+9e1aYcIBX6OPRYE3X3fzSWgFbR40DdtsRvjyDvRZQgDLsPmCMLEbkzrIKWsACiIEB/Xjeuhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmQZ6yYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmQZ6yYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcUwV1yRdQas5qpumSgRDUB0x7445Uy9FJj+N197GyA=;
	b=cmQZ6yYBSUXdXDbl6NbX5AqxMQDU3CgeBVWG4wim0RIrKgLulckyOxTftDcIVvcLLmgAH7
	amSpxAOhjhA3NfV2Ka6Hd8wA5QS9iz7ykfx/w8Df21dMejr4BF25TY//sEkH+UYOcaWgC3
	s0akaaJAgLhykTjndXiTiv/Uf9ptTds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-_pnBtU0DPtOCfhhvAa5bMA-1; Mon, 10 Feb 2025 14:38:18 -0500
X-MC-Unique: _pnBtU0DPtOCfhhvAa5bMA-1
X-Mimecast-MFC-AGG-ID: _pnBtU0DPtOCfhhvAa5bMA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso35470235e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216297; x=1739821097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcUwV1yRdQas5qpumSgRDUB0x7445Uy9FJj+N197GyA=;
        b=t6CnI7bBFIkIzIoopY9BqjKdBxzcasOafEP0E3eWg7qgb+tO9H/zrHViig/MmYEjDk
         TGsMgTYZJTc+3TYEMt/rEkUH2I2d7CQZZiWL31UbgnyeeqefphtDkBvzjd/Zgx1bH1kS
         4Hw7VtXwiQDipCHk50D/n+Azi26lfbafllHeEovCaZnOqUGERY2ub1PfdtnGv1GnyHUB
         kkMxf2p1jDjRaNUDaesSQghVLxB00uPgeSMv1S4iSwqs+TOjUy1JrJU/OQat2EGE+t/8
         nxCg9iS2ne7fKHVE4KZFvh/ySBeDraVcLYHDRwU+UmmWK1l5hkeLvRASjfqlcRHRjJ0l
         XLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsTuvrlpiI/wBodCziJOYurBIr7UTBdph5HIXqtqyRzf5TMQ/yHgSawE4eeWxTpWPSzfInSgdqP2I+D2Ls0cPY@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFtgU5qapj70fuFwj2x9TLfEsC7/NjPxuPNA8pbb8MuDtalLR
	UGLTwHVy8L07zHhrHyKyH0fd7uIvdCc0QRs54FwSY0/1+UPppp786CP28j+Fv6hmmsArIAfZlay
	tSUVWP4VToD+Sw9WXlOAUXuf0bs4FW3E3zSSpL8aDJW2EgkoncJtPjdgxHwXkWf59l/s=
X-Gm-Gg: ASbGncvxoEtKegm+u3p5ruwP2DI8SkX0cTGqVNjnj3mH0nowViYioLRUzcv8vG70SGi
	lJeNHo5z21icBdesiSlfXcOzUUGd0zHw+vZ06nqTsXfeya6C+et9/h49RPB69joZb93HIQ5kD3J
	J8uFfMdLaslhYfoSHjhXJw7XjOUwtWnKqdzSc+FY07bUWWNTjykDc84l9Gij5snmQofbKPtAoFb
	xF5xIXAFvJLei3nCMw2fCYMG1c1HnopOgtk/wo9MpFDatxtml12tg4kpZGSs2DyH+FtJWYvUTu0
	jOSmipVeA3N3mysAp/St9ZVrzs26TtGdz3WUREv9oN0uqyE80u+Xlura68aAnvlEZA==
X-Received: by 2002:a05:600c:34ce:b0:439:3254:4bf1 with SMTP id 5b1f17b1804b1-43932544f7cmr76706285e9.8.1739216296968;
        Mon, 10 Feb 2025 11:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+xVOX7QwrZYtM4UMSRPj8gjU3UfaLjkH/l+EqYjgLGDmsbA/lZxZrURGW8ZjfFBhlKrTOWA==
X-Received: by 2002:a05:600c:34ce:b0:439:3254:4bf1 with SMTP id 5b1f17b1804b1-43932544f7cmr76706055e9.8.1739216296381;
        Mon, 10 Feb 2025 11:38:16 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390d94d802sm195253865e9.12.2025.02.10.11.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:15 -0800 (PST)
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2 03/17] mm/rmap: convert make_device_exclusive_range() to make_device_exclusive()
Date: Mon, 10 Feb 2025 20:37:45 +0100
Message-ID: <20250210193801.781278-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The single "real" user in the tree of make_device_exclusive_range() always
requests making only a single address exclusive. The current implementation
is hard to fix for properly supporting anonymous THP / large folios and
for avoiding messing with rmap walks in weird ways.

So let's always process a single address/page and return folio + page to
minimize page -> folio lookups. This is a preparation for further
changes.

Reject any non-anonymous or hugetlb folios early, directly after GUP.

While at it, extend the documentation of make_device_exclusive() to
clarify some things.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/hmm.rst                    |   2 +-
 Documentation/translations/zh_CN/mm/hmm.rst |   2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c       |   5 +-
 include/linux/mmu_notifier.h                |   2 +-
 include/linux/rmap.h                        |   5 +-
 lib/test_hmm.c                              |  41 +++-----
 mm/rmap.c                                   | 103 ++++++++++++--------
 7 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index f6d53c37a2ca8..7d61b7a8b65b7 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -400,7 +400,7 @@ Exclusive access memory
 Some devices have features such as atomic PTE bits that can be used to implement
 atomic access to system memory. To support atomic operations to a shared virtual
 memory page such a device needs access to that page which is exclusive of any
-userspace access from the CPU. The ``make_device_exclusive_range()`` function
+userspace access from the CPU. The ``make_device_exclusive()`` function
 can be used to make a memory range inaccessible from userspace.
 
 This replaces all mappings for pages in the given range with special swap
diff --git a/Documentation/translations/zh_CN/mm/hmm.rst b/Documentation/translations/zh_CN/mm/hmm.rst
index 0669f947d0bc9..22c210f4e94f3 100644
--- a/Documentation/translations/zh_CN/mm/hmm.rst
+++ b/Documentation/translations/zh_CN/mm/hmm.rst
@@ -326,7 +326,7 @@ devm_memunmap_pages() 和 devm_release_mem_region() 当资源可以绑定到 ``s
 
 一些设备具有诸如原子PTE位的功能，可以用来实现对系统内存的原子访问。为了支持对一
 个共享的虚拟内存页的原子操作，这样的设备需要对该页的访问是排他的，而不是来自CPU
-的任何用户空间访问。  ``make_device_exclusive_range()`` 函数可以用来使一
+的任何用户空间访问。  ``make_device_exclusive()`` 函数可以用来使一
 个内存范围不能从用户空间访问。
 
 这将用特殊的交换条目替换给定范围内的所有页的映射。任何试图访问交换条目的行为都会
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index b4da82ddbb6b2..39e3740980bb7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -609,10 +609,9 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 
 		notifier_seq = mmu_interval_read_begin(&notifier->notifier);
 		mmap_read_lock(mm);
-		ret = make_device_exclusive_range(mm, start, start + PAGE_SIZE,
-					    &page, drm->dev);
+		page = make_device_exclusive(mm, start, drm->dev, &folio);
 		mmap_read_unlock(mm);
-		if (ret <= 0 || !page) {
+		if (IS_ERR(page)) {
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index e2dd57ca368b0..d4e7146618262 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -46,7 +46,7 @@ struct mmu_interval_notifier;
  * @MMU_NOTIFY_EXCLUSIVE: to signal a device driver that the device will no
  * longer have exclusive access to the page. When sent during creation of an
  * exclusive range the owner will be initialised to the value provided by the
- * caller of make_device_exclusive_range(), otherwise the owner will be NULL.
+ * caller of make_device_exclusive(), otherwise the owner will be NULL.
  */
 enum mmu_notifier_event {
 	MMU_NOTIFY_UNMAP = 0,
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 683a04088f3f2..86425d42c1a90 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -663,9 +663,8 @@ int folio_referenced(struct folio *, int is_locked,
 void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
 
-int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, struct page **pages,
-				void *arg);
+struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
+		void *owner, struct folio **foliop);
 
 /* Avoid racy checks */
 #define PVMW_SYNC		(1 << 0)
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e411d7b4..e4afca8d18802 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -780,10 +780,8 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 	unsigned long start, end, addr;
 	unsigned long size = cmd->npages << PAGE_SHIFT;
 	struct mm_struct *mm = dmirror->notifier.mm;
-	struct page *pages[64];
 	struct dmirror_bounce bounce;
-	unsigned long next;
-	int ret;
+	int ret = 0;
 
 	start = cmd->addr;
 	end = start + size;
@@ -795,36 +793,27 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 		return -EINVAL;
 
 	mmap_read_lock(mm);
-	for (addr = start; addr < end; addr = next) {
-		unsigned long mapped = 0;
-		int i;
-
-		next = min(end, addr + (ARRAY_SIZE(pages) << PAGE_SHIFT));
+	for (addr = start; !ret && addr < end; addr += PAGE_SIZE) {
+		struct folio *folio;
+		struct page *page;
 
-		ret = make_device_exclusive_range(mm, addr, next, pages, NULL);
-		/*
-		 * Do dmirror_atomic_map() iff all pages are marked for
-		 * exclusive access to avoid accessing uninitialized
-		 * fields of pages.
-		 */
-		if (ret == (next - addr) >> PAGE_SHIFT)
-			mapped = dmirror_atomic_map(addr, next, pages, dmirror);
-		for (i = 0; i < ret; i++) {
-			if (pages[i]) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
+		page = make_device_exclusive(mm, addr, NULL, &folio);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
+			break;
 		}
 
-		if (addr + (mapped << PAGE_SHIFT) < next) {
-			mmap_read_unlock(mm);
-			mmput(mm);
-			return -EBUSY;
-		}
+		ret = dmirror_atomic_map(addr, addr + PAGE_SIZE, &page, dmirror);
+		ret = ret == 1 ? 0 : -EBUSY;
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	mmap_read_unlock(mm);
 	mmput(mm);
 
+	if (ret)
+		return ret;
+
 	/* Return the migrated data for verification. */
 	ret = dmirror_bounce_init(&bounce, start, size);
 	if (ret)
diff --git a/mm/rmap.c b/mm/rmap.c
index 17fbfa61f7efb..7ccf850565d33 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2495,70 +2495,89 @@ static bool folio_make_device_exclusive(struct folio *folio,
 		.arg = &args,
 	};
 
-	/*
-	 * Restrict to anonymous folios for now to avoid potential writeback
-	 * issues.
-	 */
-	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
-		return false;
-
 	rmap_walk(folio, &rwc);
 
 	return args.valid && !folio_mapcount(folio);
 }
 
 /**
- * make_device_exclusive_range() - Mark a range for exclusive use by a device
+ * make_device_exclusive() - Mark a page for exclusive use by a device
  * @mm: mm_struct of associated target process
- * @start: start of the region to mark for exclusive device access
- * @end: end address of region
- * @pages: returns the pages which were successfully marked for exclusive access
+ * @addr: the virtual address to mark for exclusive device access
  * @owner: passed to MMU_NOTIFY_EXCLUSIVE range notifier to allow filtering
+ * @foliop: folio pointer will be stored here on success.
+ *
+ * This function looks up the page mapped at the given address, grabs a
+ * folio reference, locks the folio and replaces the PTE with special
+ * device-exclusive PFN swap entry, preventing access through the process
+ * page tables. The function will return with the folio locked and referenced.
  *
- * Returns: number of pages found in the range by GUP. A page is marked for
- * exclusive access only if the page pointer is non-NULL.
+ * On fault, the device-exclusive entries are replaced with the original PTE
+ * under folio lock, after calling MMU notifiers.
  *
- * This function finds ptes mapping page(s) to the given address range, locks
- * them and replaces mappings with special swap entries preventing userspace CPU
- * access. On fault these entries are replaced with the original mapping after
- * calling MMU notifiers.
+ * Only anonymous non-hugetlb folios are supported and the VMA must have
+ * write permissions such that we can fault in the anonymous page writable
+ * in order to mark it exclusive. The caller must hold the mmap_lock in read
+ * mode.
  *
  * A driver using this to program access from a device must use a mmu notifier
  * critical section to hold a device specific lock during programming. Once
- * programming is complete it should drop the page lock and reference after
+ * programming is complete it should drop the folio lock and reference after
  * which point CPU access to the page will revoke the exclusive access.
+ *
+ * Notes:
+ *   #. This function always operates on individual PTEs mapping individual
+ *      pages. PMD-sized THPs are first remapped to be mapped by PTEs before
+ *      the conversion happens on a single PTE corresponding to @addr.
+ *   #. While concurrent access through the process page tables is prevented,
+ *      concurrent access through other page references (e.g., earlier GUP
+ *      invocation) is not handled and not supported.
+ *   #. device-exclusive entries are considered "clean" and "old" by core-mm.
+ *      Device drivers must update the folio state when informed by MMU
+ *      notifiers.
+ *
+ * Returns: pointer to mapped page on success, otherwise a negative error.
  */
-int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, struct page **pages,
-				void *owner)
+struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
+		void *owner, struct folio **foliop)
 {
-	long npages = (end - start) >> PAGE_SHIFT;
-	long i;
+	struct folio *folio;
+	struct page *page;
+	long npages;
+
+	mmap_assert_locked(mm);
 
-	npages = get_user_pages_remote(mm, start, npages,
+	/*
+	 * Fault in the page writable and try to lock it; note that if the
+	 * address would already be marked for exclusive use by a device,
+	 * the GUP call would undo that first by triggering a fault.
+	 */
+	npages = get_user_pages_remote(mm, addr, 1,
 				       FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
-				       pages, NULL);
-	if (npages < 0)
-		return npages;
-
-	for (i = 0; i < npages; i++, start += PAGE_SIZE) {
-		struct folio *folio = page_folio(pages[i]);
-		if (PageTail(pages[i]) || !folio_trylock(folio)) {
-			folio_put(folio);
-			pages[i] = NULL;
-			continue;
-		}
+				       &page, NULL);
+	if (npages != 1)
+		return ERR_PTR(npages);
+	folio = page_folio(page);
 
-		if (!folio_make_device_exclusive(folio, mm, start, owner)) {
-			folio_unlock(folio);
-			folio_put(folio);
-			pages[i] = NULL;
-		}
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio)) {
+		folio_put(folio);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (!folio_trylock(folio)) {
+		folio_put(folio);
+		return ERR_PTR(-EBUSY);
 	}
 
-	return npages;
+	if (!folio_make_device_exclusive(folio, mm, addr, owner)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return ERR_PTR(-EBUSY);
+	}
+	*foliop = folio;
+	return page;
 }
-EXPORT_SYMBOL_GPL(make_device_exclusive_range);
+EXPORT_SYMBOL_GPL(make_device_exclusive);
 #endif
 
 void __put_anon_vma(struct anon_vma *anon_vma)
-- 
2.48.1

