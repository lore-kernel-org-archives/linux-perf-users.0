Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F615EE49AE
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjHUUU2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjHUUU1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D52101
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZjTkkOXXXSSKh7AkJZazpX1s5qsUP26GHpbaGZUnTo8=; b=RhSHMGYjzeabO+TPC6Vk0fsGAP
        ESwQD+kA9n05mFH4V7x5E1E/PK7+hX6AVEwb0xfW5mvuGVGJgTKBnfxSxTrNj9bcH6p//Sh8Ak0uq
        rPvFNvCQYo+40HrjKlG+G2jBE3tczpJuiIIO9bhjugOITLwOZalFgpX/o5/DZfdiMbMgRwny1WOEN
        TVHwPs+hl9Ud0NYAy6FhPagROuHL0gCeWZ/nij+EVwy9Nu6WS1aGddneN0uBfZEpYcAEwIxdTi+Sc
        3SSVYmvOzhYL04ZJaaKKd5yd719t3TJ4WW2WFT7uVRi/f6Ycmzg3N8KIwx/VWQCKMFfHizqP5zsRC
        kUFKWb8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBNr-00CD6y-Av; Mon, 21 Aug 2023 20:20:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
Subject: [RFC PATCH 3/4] perf: Use vmalloc_to_folio()
Date:   Mon, 21 Aug 2023 21:20:15 +0100
Message-Id: <20230821202016.2910321-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821202016.2910321-1-willy@infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Eliminate a use of page->mapping by using vmalloc_to_folio() instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h          | 5 +++++
 kernel/events/ring_buffer.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 840bae5f23b6..7d84a2843193 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1134,6 +1134,11 @@ int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
 struct page *vmalloc_to_page(const void *addr);
 unsigned long vmalloc_to_pfn(const void *addr);
 
+static inline struct folio *vmalloc_to_folio(const void *addr)
+{
+	return page_folio(vmalloc_to_page(addr));
+}
+
 /*
  * Determine if an address is within the vmalloc range
  *
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index c73add132618..56939dc3bf33 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -873,9 +873,9 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 
 static void perf_mmap_unmark_page(void *addr)
 {
-	struct page *page = vmalloc_to_page(addr);
+	struct folio *folio = vmalloc_to_folio(addr);
 
-	page->mapping = NULL;
+	folio->mapping = NULL;
 }
 
 static void rb_free_work(struct work_struct *work)
-- 
2.40.1

