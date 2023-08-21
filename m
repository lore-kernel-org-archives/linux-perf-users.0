Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838FEE49A8
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 20:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHUUU0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjHUUU0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D235101
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bqsHWtg0sTY6IqpOvfeSnvnFR6wJrIohLDKSxFgMNTg=; b=FvNZJNN8SUL6GfqaGvvyHGSebj
        B04lwo0uLo0HB4Ovf2BY9W7vSiLLv57FTFUd+gAEMLFpaVoYhXnv7Hu1CMd3sLB8RPorQidikfaaK
        8AnrKAuFUCPgeUksT8EE8mOYLTghJrEl/lttVNSi5egYqWX6HD8zN+d+zaAEaHJUSZ81Xqo4V52Dx
        CJrv0mZXC8cbG+o0QMH4iDlmGhLhmk/U3V1VlVgBlJIdZ/Wyza2LRheOeA4zDDnZ/RdQbQKSBs/vo
        hacE20AMuNgi0XQhOO2aLi0N9IJXUjbKX8QsFSzQnLJng3iIdgpjCI8hYK2Au07dIkdvcKYe3fDwn
        za+Hsikg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBNr-00CD73-Q2; Mon, 21 Aug 2023 20:20:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
Subject: [RFC PATCH 4/4] perf: Use folios for the aux ringbuffer & pagefault path
Date:   Mon, 21 Aug 2023 21:20:16 +0100
Message-Id: <20230821202016.2910321-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821202016.2910321-1-willy@infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Instead of allocating a non-compound page and splitting it, allocate
a folio and make its refcount the count of the number of pages in it.
That way, when we free each page in the folio, we'll only actually free
it when the last page in the folio is freed.  Keeping the memory intact
is better for the MM system than allocating it and splitting it.

Now, instead of setting each page->mapping, we only set folio->mapping
which is better for our cacheline usage, as well as helping towards the
goal of eliminating page->mapping.  We remove the setting of page->index;
I do not believe this is needed.  And we return with the folio locked,
which the fault handler should have been doing all along.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/events/core.c        | 13 +++++++---
 kernel/events/ring_buffer.c | 51 ++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..59d4f7c48c8c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -29,6 +29,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hardirq.h>
 #include <linux/hugetlb.h>
+#include <linux/pagemap.h>
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -6083,6 +6084,7 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 {
 	struct perf_event *event = vmf->vma->vm_file->private_data;
 	struct perf_buffer *rb;
+	struct folio *folio;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	if (vmf->flags & FAULT_FLAG_MKWRITE) {
@@ -6102,12 +6104,15 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
 	if (!vmf->page)
 		goto unlock;
+	folio = page_folio(vmf->page);
 
-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
+	folio_get(folio);
+	rcu_read_unlock();
+	folio_lock(folio);
+	if (!folio->mapping)
+		folio->mapping = vmf->vma->vm_file->f_mapping;
 
-	ret = 0;
+	return VM_FAULT_LOCKED;
 unlock:
 	rcu_read_unlock();
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 56939dc3bf33..0a026e5ff4f5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -606,39 +606,28 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
 
 #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
 
-static struct page *rb_alloc_aux_page(int node, int order)
+static struct folio *rb_alloc_aux_folio(int node, int order)
 {
-	struct page *page;
+	struct folio *folio;
 
 	if (order > MAX_ORDER)
 		order = MAX_ORDER;
 
 	do {
-		page = alloc_pages_node(node, PERF_AUX_GFP, order);
-	} while (!page && order--);
-
-	if (page && order) {
-		/*
-		 * Communicate the allocation size to the driver:
-		 * if we managed to secure a high-order allocation,
-		 * set its first page's private to this order;
-		 * !PagePrivate(page) means it's just a normal page.
-		 */
-		split_page(page, order);
-		SetPagePrivate(page);
-		set_page_private(page, order);
-	}
+		folio = __folio_alloc_node(PERF_AUX_GFP, order, node);
+	} while (!folio && order--);
 
-	return page;
+	if (order)
+		folio_ref_add(folio, (1 << order) - 1);
+	return folio;
 }
 
 static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 {
-	struct page *page = virt_to_page(rb->aux_pages[idx]);
+	struct folio *folio = virt_to_folio(rb->aux_pages[idx]);
 
-	ClearPagePrivate(page);
-	page->mapping = NULL;
-	__free_page(page);
+	folio->mapping = NULL;
+	folio_put(folio);
 }
 
 static void __rb_free_aux(struct perf_buffer *rb)
@@ -672,7 +661,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		 pgoff_t pgoff, int nr_pages, long watermark, int flags)
 {
 	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
-	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
+	int node = (event->cpu == -1) ? numa_mem_id() : cpu_to_node(event->cpu);
 	int ret = -ENOMEM, max_order;
 
 	if (!has_aux(event))
@@ -707,17 +696,21 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	rb->free_aux = event->pmu->free_aux;
 	for (rb->aux_nr_pages = 0; rb->aux_nr_pages < nr_pages;) {
-		struct page *page;
-		int last, order;
+		struct folio *folio;
+		unsigned int i, nr, order;
+		void *addr;
 
 		order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
-		page = rb_alloc_aux_page(node, order);
-		if (!page)
+		folio = rb_alloc_aux_folio(node, order);
+		if (!folio)
 			goto out;
+		addr = folio_address(folio);
+		nr = folio_nr_pages(folio);
 
-		for (last = rb->aux_nr_pages + (1 << page_private(page));
-		     last > rb->aux_nr_pages; rb->aux_nr_pages++)
-			rb->aux_pages[rb->aux_nr_pages] = page_address(page++);
+		for (i = 0; i < nr; i++) {
+			rb->aux_pages[rb->aux_nr_pages++] = addr;
+			addr += PAGE_SIZE;
+		}
 	}
 
 	/*
-- 
2.40.1

