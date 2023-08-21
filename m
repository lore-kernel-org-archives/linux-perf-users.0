Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1091EE49A0
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 20:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjHUUU0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjHUUU0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BBE9
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tYGfFyUq7t7eG2DfnJgfGPfrNOUqXETtillKZ2Ic8a4=; b=Z2QgGOEX+YU88go4CxiBk1uRs2
        aBGSbahWb4XB33exhSqsocsfpuLMOSih/d1J+oYJPR4M7YnasVgFl4BNQxJZ+JP3WXqkD4nezXWyn
        ceiFlMzm9x7eRYETe01vkUIGJHoop4hUOAM7xrLUa34dPoUSs6anrg1lmyuqJAmwfFJhTWpUB1zSJ
        AuQjc5pru+oOvKhkaJ2jNHETW1I9Z0T1/cSuPQAhLxEyAxax34fGoaiqIzkJM5WSqTF+DfqxYX7Yk
        l/xIoGs8v1hwFhRuO7znM7MScBvTbAeK3zOOnEdEWye3an37pIQ/tU4wx5t0S8iesyMcE9fpzm289
        j+GPvXYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBNq-00CD6w-Sa; Mon, 21 Aug 2023 20:20:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
Subject: [RFC PATCH 2/4] mm: Add vmalloc_user_node()
Date:   Mon, 21 Aug 2023 21:20:14 +0100
Message-Id: <20230821202016.2910321-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821202016.2910321-1-willy@infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Allow memory to be allocated on a specified node.  Use it in the
perf ring-buffer code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/vmalloc.h     | 17 ++++++++++++++++-
 kernel/events/ring_buffer.c |  2 +-
 mm/vmalloc.c                |  9 +++++----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..030bfe1a60ab 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/llist.h>
+#include <linux/numa.h>
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
@@ -139,7 +140,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 
 extern void *vmalloc(unsigned long size) __alloc_size(1);
 extern void *vzalloc(unsigned long size) __alloc_size(1);
-extern void *vmalloc_user(unsigned long size) __alloc_size(1);
+extern void *vmalloc_user_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_32(unsigned long size) __alloc_size(1);
@@ -158,6 +159,20 @@ extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
 extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
 
+/**
+ * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
+ * @size: allocation size
+ *
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline void *vmalloc_user(size_t size)
+{
+	return vmalloc_user_node(size, NUMA_NO_NODE);
+}
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index cc90d5299005..c73add132618 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -918,7 +918,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 
 	INIT_WORK(&rb->work, rb_free_work);
 
-	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
+	all_buf = vmalloc_user_node((nr_pages + 1) * PAGE_SIZE, node);
 	if (!all_buf)
 		goto fail_all_buf;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 228a4a5312f2..3616bfe4348f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3461,22 +3461,23 @@ void *vzalloc(unsigned long size)
 EXPORT_SYMBOL(vzalloc);
 
 /**
- * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
+ * vmalloc_user_node - allocate zeroed virtually contiguous memory for userspace
  * @size: allocation size
+ * @node: NUMA node
  *
  * The resulting memory area is zeroed so it can be mapped to userspace
  * without leaking data.
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_user(unsigned long size)
+void *vmalloc_user_node(unsigned long size, int node)
 {
 	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
-				    VM_USERMAP, NUMA_NO_NODE,
+				    VM_USERMAP, node,
 				    __builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc_user);
+EXPORT_SYMBOL(vmalloc_user_node);
 
 /**
  * vmalloc_node - allocate memory on a specific node
-- 
2.40.1

