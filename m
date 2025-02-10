Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC024C690
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216330; cv=none; b=DkPR6/p9RHGHEitOdoyQGFogd8LyVNofzHsAaZklkrOZMhBlSibu27nsQTojpokpnW5M0wvRErnuoNcHb5iT2iyWuAZGEh91OH7l9e/y3IYvklYkUPT8kegSvTH7fpDgsqCAzBk3b0Zson5wVlOXv9sUV8JFAvsw9H5C/KUB3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216330; c=relaxed/simple;
	bh=wTEfnlnRBIWds4A4VWjgD0zaJLq1iJwNdx86V2VqPGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3O/cxWfGQcVLPVP53OJdUmYE9vBExo7x+H5VHaZVpR2rqkF/y9g9ZSR8IeWd/PNBBvkqxFIlTOun49MvnZLoun8fHG1MsXyG7UUYRM6Gtm3jejvZkZDeC0ga1zWz7zaJw8T/gw6+4PKzhETArFLSfe30eb+mi8FBEeMresJ8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdu5zyAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdu5zyAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvU1uLGkpTPZRA0QaV3EggyJAUMnys9Fj6An1hzKeYY=;
	b=gdu5zyAcZ60TdH9uF/EklFsXF7D3FOjO93CX6LunM95f4Q7FwyXBlvpzryMM54S1M+L3NE
	7uC1o/6M9GufIF9nEGGahJFXK3KiE4DkVjqFecVAHNS2RHZo0Z1du+wEw9q7Mvi5/AZ5pc
	M0Q8gpm13pMpZE+H6vPltaFlhXuQGBE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-004anHdTN6-DL9FG4oFt_w-1; Mon, 10 Feb 2025 14:38:44 -0500
X-MC-Unique: 004anHdTN6-DL9FG4oFt_w-1
X-Mimecast-MFC-AGG-ID: 004anHdTN6-DL9FG4oFt_w
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4392fc6bceaso13134915e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 11:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216322; x=1739821122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvU1uLGkpTPZRA0QaV3EggyJAUMnys9Fj6An1hzKeYY=;
        b=jIuVuyPI9jMHn0BqU+HvFchc7B2Z5IqMKXO+S8+fYicga9p4EiFCJ9VkgSORKsa0Cn
         tbIvnBybyjCpJlEN05b4rqSjYNw+YfEb0Wvi1peI+i7NWb+HeS4g9HrX4Ds/FWZXF7aQ
         TOyrj6hVt98mmQKfZOx9RS7tfQcOo1ii2zZstY2bCUmbbqtTnP53VLd7QbpbwYo0MNKW
         KTcCG04S65K//bxOGlst8VQGcibWcOqEYGN/oCPcj/B+JJzwE4TdsU/Vq2YIJhe15aPl
         HKtxPBTow6Nk/4NwPeE9QMBCw+Xnj3UZtNPfYJb6MGXz/qMFrlO3elEiC7kinXAC3e6A
         KLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyaCXBImGYEQkYHjXpRgVPjmSMu8fzvQd+ICWrUF4Q5TV5uYsU/yneTWfkpUAyWTbfg9dbf3WRWZaLJM/tIsHO@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJxZAd8rphTQKBCu7uJ5afq7fQeA2ZGbiVsvVYPlFdZP1xb4l
	CX11hn8r975CcSIhfnIE5fO3oLdGSFiF0UuVBcIci5DwTDfc/Y2+2JAeF3tQJxz+WyYq8CG6gXF
	M7zO3inbsv3fQDpeowdbjmxFayTXYYRg6xe8613zk3JFbqbiPrWdJseUQl/7bRRysZR0=
X-Gm-Gg: ASbGnctL5w6JTefQFF0AUAnRZUStXkmKOM44PMPHNLg8rU3xFH+c52dwIsXs4ZBgISu
	F+RAKOCf7KpQf4F8wYrZoxDjAg5ypMhtiIF8ZoYguFRwLsuLlzXwIU23c0NjkOKgVSISUOpzRRk
	FPaL97VWm0j2RElRgY7DnxzqEr4XPprAMp4w/QvzGIen6GjfwMPky2oVxqOPl3yrTdObruRrP37
	cl2JvQFk8JNYUNtvUjQJR8NcOBcJ+o2QHjelQBIwTae531rJrTxQERMpmP7oBBO+BoDZ9E/sRNv
	tewF12l/zEgXv7MHl1SymUeUZtDnKzs3nuSKxqS0RFkXNvY8SWJcyKkUHeM8Ttd0fQ==
X-Received: by 2002:a05:600c:1e0e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-439249889a8mr117196265e9.8.1739216322491;
        Mon, 10 Feb 2025 11:38:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjSKW3zWL6vzVGiNBIPirrt7XpGCC7ElTlo8fIz4HKSkBODD3ovt81FL+SvLTQ6DCkqg1UrQ==
X-Received: by 2002:a05:600c:1e0e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-439249889a8mr117195855e9.8.1739216321998;
        Mon, 10 Feb 2025 11:38:41 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38ddaf333c5sm5084761f8f.36.2025.02.10.11.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:40 -0800 (PST)
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
Subject: [PATCH v2 10/17] mm/rmap: handle device-exclusive entries correctly in try_to_unmap_one()
Date: Mon, 10 Feb 2025 20:37:52 +0100
Message-ID: <20250210193801.781278-11-david@redhat.com>
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

try_to_unmap_one() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not
applicable on that path, as we expect ZONE_DEVICE pages so far only in
migration code when it comes to the RMAP.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Further note that try_to_unmap() calls MMU notifiers and holds the
folio lock, so any device-exclusive users should be properly prepared
for a device-exclusive PTE to "vanish".

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1129ed132af94..47142a656ae51 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1648,9 +1648,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	bool anon_exclusive, ret = true;
 	pte_t pteval;
 	struct page *subpage;
-	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
@@ -1722,7 +1722,18 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
+		/*
+		 * Handle PFN swap PTEs, such as device-exclusive ones, that
+		 * actually map pages.
+		 */
+		pteval = ptep_get(pvmw.pte);
+		if (likely(pte_present(pteval))) {
+			pfn = pte_pfn(pteval);
+		} else {
+			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+		}
+
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
@@ -1778,7 +1789,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				hugetlb_vma_unlock_write(vma);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
-		} else {
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else if (likely(pte_present(pteval))) {
 			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
 			if (should_defer_flush(mm, flags)) {
@@ -1796,6 +1809,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
+			if (pte_dirty(pteval))
+				folio_mark_dirty(folio);
+		} else {
+			pte_clear(mm, address, pvmw.pte);
 		}
 
 		/*
@@ -1805,10 +1822,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
 
-		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
-			folio_mark_dirty(folio);
-
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
@@ -1822,8 +1835,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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
@@ -1902,6 +1915,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_abort;
 			}
+
+			/*
+			 * arch_unmap_one() is expected to be a NOP on
+			 * architectures where we could have PFN swap PTEs,
+			 * so we'll not check/care.
+			 */
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -1926,10 +1945,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			swp_pte = swp_entry_to_pte(entry);
 			if (anon_exclusive)
 				swp_pte = pte_swp_mkexclusive(swp_pte);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			if (likely(pte_present(pteval))) {
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			} else {
+				if (pte_swp_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_swp_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+			}
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 		} else {
 			/*
-- 
2.48.1

