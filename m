Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6AEE49A0
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 20:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjHUUUb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjHUUUa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDD11C
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/Guyl86RjRFKgVcvJ+J4vVv/rAafEsDNvMt8mUITwhs=; b=rgdV2c35jokG8Kq8cBzPW6Badf
        IPpSevMrDXHyezbLEhmgoPqUcCrAGcVqKPvJjqVtjAaLmsZUvZqUwuguW9K4DGpDXcoJKtY9drWa6
        Z4Z+SQP1Dj22lnJXivbTGYnhkb+AZJKIokbFdHdH3Q2t1KBQiaFofXJVuNeELP7vvXepp3NVUg/mJ
        SQTjbrLOZ3X+NoP1DnIZ5fK5f2Fxd2Kx6YMnS5IuYkVCbhlwW3rooXuW6qZj8n063ePXedXLZT0Kj
        5w9iHZRH12gqkG+MooSHrwofO3XXJlPfLUgHs0kcpFy5YUtXtrbSwK/NlRQxl7w+28dlIbR5MuRx3
        W0AjylSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBNq-00CD6s-3K; Mon, 21 Aug 2023 20:20:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
Subject: [RFC PATCH 0/4] Convert perf ringbuffer to folios
Date:   Mon, 21 Aug 2023 21:20:12 +0100
Message-Id: <20230821202016.2910321-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The motivation here is to remove uses of page->mapping as part of the
quest to shrink struct page.  I'm unsure about some of this as the perf
ringbuffers present some new challenges that we haven't faced before.

Perf has three different ways of allocating memory for the ring buffer.
There's an individual pages way, a vmalloc way and a physically contiguous
way (for the aux buffers).  The fault handler can map all three.

The fault handler can map the _first_ page read-write, but all subsequent
pages are mapped read-only.  That makes calling vm_insert_page() not
feasible; that would allow all pages to be mapped read-write (yes?)
So the fault handler sets vmf->page and returns, in order to let
finish_fault() set it up.

I'm not really sure why page/folio->mapping needs to be set by the
fault handler.  What goes wrong if we leave it as NULL?  Likewise, do
we really need to set ->index?  I've taken that out for now, but maybe
that'll make something fail (perhaps an rmap walk?  Do we really need to
do rmap walks on device driver mappings?)

I don't like drivers playing these games with pages/folios.  I think we
need better support for these kinds of things.  Probably in the form of
helpers, given how unusual some of perf's requirements are.

More broadly, we don't have a detailed plan for how vmalloc memory gets
handled in a memdesc world.  For the vast majority of vmalloc allocations,
the pages allocated need no descriptor; they're only accessed through
the virtual address by the CPU.  This is a case where we need to mmap
the vmalloc memory.  There are also cases where we need to do I/O to
vmalloc memory; we need to understand what fields from struct page are
really needed for each of these two requirements.

Matthew Wilcox (Oracle) (4):
  perf: Convert perf_mmap_(alloc,free)_page to folios
  mm: Add vmalloc_user_node()
  perf: Use vmalloc_to_folio()
  perf: Use folios for the aux ringbuffer & pagefault path

 include/linux/mm.h          |  5 +++
 include/linux/vmalloc.h     | 17 +++++++-
 kernel/events/core.c        | 13 ++++--
 kernel/events/ring_buffer.c | 83 +++++++++++++++++--------------------
 mm/vmalloc.c                |  9 ++--
 5 files changed, 72 insertions(+), 55 deletions(-)

-- 
2.40.1

