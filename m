Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE31EE49AF
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 20:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHUUU1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjHUUU1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B49123
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ftMoTpPKDvJHF3KGIoW6evnR7Kcy68rm/mSseTTxyDE=; b=UeWDfgiVvfANwzOmWZAyMTV5dO
        PtODFzfq5fwt4KNX841Xw565F2ny38hCVRGqSFXTetiJvlP4NauQmuhso+HMwmUJ/5l0ACV4cP40O
        vbfJ6MWPWeP5oQ004FdUXRizGoZ8RNh8d1Uk+y+/qEJ4JTqmDRRqz/+nrlGttzhIAV0Sf/mjtGMVn
        +LXUpHEU+FeFspMvpWqu9dpAtPqli3bfXKZCVMi5MXgoh9DQ8FHwWGNlcaX3bNtpzDJW9cCTdpphr
        mmKeRz3hSoROk6kcxQM+bMmhsT/ke8RGpBF4DgJKJuuMn/kWpCvaSK6c0jbIC025wcVOXzXwf8NmC
        HPEzDciw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBNq-00CD6u-DU; Mon, 21 Aug 2023 20:20:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
Subject: [RFC PATCH 1/4] perf: Convert perf_mmap_(alloc,free)_page to folios
Date:   Mon, 21 Aug 2023 21:20:13 +0100
Message-Id: <20230821202016.2910321-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821202016.2910321-1-willy@infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the folio API to alloc & free memory.  Also pass in the node ID
instead of the CPU ID since we already did that calculation in the
caller.  And call numa_mem_id() instead of leaving the node ID as
-1 and having the MM call numa_mem_id() each time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/events/ring_buffer.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index fb1e180b5f0a..cc90d5299005 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -770,7 +770,7 @@ void rb_free_aux(struct perf_buffer *rb)
 #ifndef CONFIG_PERF_USE_VMALLOC
 
 /*
- * Back perf_mmap() with regular GFP_KERNEL-0 pages.
+ * Back perf_mmap() with regular GFP_KERNEL pages.
  */
 
 static struct page *
@@ -785,25 +785,23 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 	return virt_to_page(rb->data_pages[pgoff - 1]);
 }
 
-static void *perf_mmap_alloc_page(int cpu)
+static void *perf_mmap_alloc_page(int node)
 {
-	struct page *page;
-	int node;
+	struct folio *folio;
 
-	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
-	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
-	if (!page)
+	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, 0, node);
+	if (!folio)
 		return NULL;
 
-	return page_address(page);
+	return folio_address(folio);
 }
 
 static void perf_mmap_free_page(void *addr)
 {
-	struct page *page = virt_to_page(addr);
+	struct folio *folio = virt_to_folio(addr);
 
-	page->mapping = NULL;
-	__free_page(page);
+	folio->mapping = NULL;
+	folio_put(folio);
 }
 
 struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
@@ -818,17 +816,17 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
-	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
+	node = (cpu == -1) ? numa_mem_id() : cpu_to_node(cpu);
 	rb = kzalloc_node(size, GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
-	rb->user_page = perf_mmap_alloc_page(cpu);
+	rb->user_page = perf_mmap_alloc_page(node);
 	if (!rb->user_page)
 		goto fail_user_page;
 
 	for (i = 0; i < nr_pages; i++) {
-		rb->data_pages[i] = perf_mmap_alloc_page(cpu);
+		rb->data_pages[i] = perf_mmap_alloc_page(node);
 		if (!rb->data_pages[i])
 			goto fail_data_pages;
 	}
-- 
2.40.1

