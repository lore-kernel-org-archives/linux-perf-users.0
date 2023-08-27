Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C9EC83F01
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Aug 2023 08:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjH0IBc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjH0IBT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 04:01:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2DE12E
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 01:01:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so21621615e9.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693123266; x=1693728066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czA0szAFhC2F1/m40SXjRmw3SdqXWgDEYhXx4X7fi80=;
        b=D1ZukG5doBm0tEbqFoysL7nBViSCAdEUxO+cIWjcEIYXyM3dUS20DBNmKp2zhGan0H
         /4MqfFLyg9rk+odRq/Zt85FtIDfjjfrgyroqc0FdycAQKFnExcRpV4DF6p3VpLGD3dWt
         wGY5QsZa/HI2ojQZ8HY1gTNC0P61W+7SCXzqsETd5z4ZuoLYd0RxVmBard4dc+6xh/2M
         steMJ19yYBVSVAl/ZHxuXCdImcSaR28TVMbWGPE8+v4tBY9u4xvKJBtRiPTWPnlQtZTl
         /3OU4nCKzCyyiSw9O6+G3MBiLLBMkd7ayrjcxevowc2sm6b+kZXz0l2SQib95smUaJ5X
         FSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693123266; x=1693728066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czA0szAFhC2F1/m40SXjRmw3SdqXWgDEYhXx4X7fi80=;
        b=AktVaHqKoo35/GZFGCQXsv3A7Z1/CjgwsGFPlCOefMAV6vsxMZGTnI4h5TiLSLhBmh
         HdIA/3als+Te4UG8xb0xvBFUC/DVERcyHKTnGbHEx2EX3UhKitLXvhCDdJbiayuJZAOt
         rdmZF0BCS9MMuK6uZ5NrPxzumh6Lts0m5hakHbAZ+j+qCDg7Tf2q4p/scuaNcs0CYVT/
         52kCGKsqQCI6SXwJE2t5uZ6MuU08ecFRAGCKJyO9DHQgrF2SeQHO4k3L5RrCXcuk1rhl
         BxcRrjS4G7fI7IhmtWa0rsY5onUmfzLb67ZhAfSHe4uqtxdIVEBz8GAoMDJJSMnZiuJK
         YhNA==
X-Gm-Message-State: AOJu0YzfM13d3RvQARmmasCgv2ILGJeW2ePAEUhnQJP9HX30hv5TWay3
        MrfJXssGfjQtCj4TE0nn7/k=
X-Google-Smtp-Source: AGHT+IHUrnfPfvDPgWLusou+HxQwmMB7kdj/hkSDPAj6cJyp9Gpya2d88mGBqYwK9rbJz5A62noiNw==
X-Received: by 2002:a05:600c:2102:b0:3fc:dd9:91fd with SMTP id u2-20020a05600c210200b003fc0dd991fdmr16295938wml.40.1693123265990;
        Sun, 27 Aug 2023 01:01:05 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t16-20020a7bc3d0000000b00401c9228bf7sm640258wmj.18.2023.08.27.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 01:01:04 -0700 (PDT)
Date:   Sun, 27 Aug 2023 09:01:04 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [RFC PATCH 4/4] perf: Use folios for the aux ringbuffer &
 pagefault path
Message-ID: <5231893a-e5a5-4544-a6d2-2c98cbebca09@lucifer.local>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202016.2910321-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 09:20:16PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of allocating a non-compound page and splitting it, allocate
> a folio and make its refcount the count of the number of pages in it.
> That way, when we free each page in the folio, we'll only actually free
> it when the last page in the folio is freed.  Keeping the memory intact
> is better for the MM system than allocating it and splitting it.
>
> Now, instead of setting each page->mapping, we only set folio->mapping
> which is better for our cacheline usage, as well as helping towards the
> goal of eliminating page->mapping.  We remove the setting of page->index;
> I do not believe this is needed.  And we return with the folio locked,
> which the fault handler should have been doing all along.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  kernel/events/core.c        | 13 +++++++---
>  kernel/events/ring_buffer.c | 51 ++++++++++++++++---------------------
>  2 files changed, 31 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..59d4f7c48c8c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/hardirq.h>
>  #include <linux/hugetlb.h>
> +#include <linux/pagemap.h>
>  #include <linux/rculist.h>
>  #include <linux/uaccess.h>
>  #include <linux/syscalls.h>
> @@ -6083,6 +6084,7 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  {
>  	struct perf_event *event = vmf->vma->vm_file->private_data;
>  	struct perf_buffer *rb;
> +	struct folio *folio;
>  	vm_fault_t ret = VM_FAULT_SIGBUS;

Since we're explicitly returning VM_FAULT_LOCKED on success, perhaps worth
simply renaming the unlock label to error and returning VM_FAULT_SIGBUS there?

The FAULT_FLAG_MKWRITE branch can simply return vmf->pgoff == 0 ? 0 :
VM_FAULT_SIGBUS;

>
>  	if (vmf->flags & FAULT_FLAG_MKWRITE) {
> @@ -6102,12 +6104,15 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
>  	if (!vmf->page)
>  		goto unlock;
> +	folio = page_folio(vmf->page);
>
> -	get_page(vmf->page);
> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> -	vmf->page->index   = vmf->pgoff;
> +	folio_get(folio);
> +	rcu_read_unlock();
> +	folio_lock(folio);
> +	if (!folio->mapping)
> +		folio->mapping = vmf->vma->vm_file->f_mapping;
>
> -	ret = 0;
> +	return VM_FAULT_LOCKED;
>  unlock:
>  	rcu_read_unlock();
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 56939dc3bf33..0a026e5ff4f5 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -606,39 +606,28 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
>
>  #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
>
> -static struct page *rb_alloc_aux_page(int node, int order)
> +static struct folio *rb_alloc_aux_folio(int node, int order)
>  {
> -	struct page *page;
> +	struct folio *folio;
>
>  	if (order > MAX_ORDER)
>  		order = MAX_ORDER;
>
>  	do {
> -		page = alloc_pages_node(node, PERF_AUX_GFP, order);
> -	} while (!page && order--);
> -
> -	if (page && order) {
> -		/*
> -		 * Communicate the allocation size to the driver:
> -		 * if we managed to secure a high-order allocation,
> -		 * set its first page's private to this order;
> -		 * !PagePrivate(page) means it's just a normal page.
> -		 */
> -		split_page(page, order);
> -		SetPagePrivate(page);
> -		set_page_private(page, order);

I'm guessing this was used in conjunction with the page_private() logic
that existed below and can simply be discarded now?

> -	}
> +		folio = __folio_alloc_node(PERF_AUX_GFP, order, node);
> +	} while (!folio && order--);
>
> -	return page;
> +	if (order)
> +		folio_ref_add(folio, (1 << order) - 1);

Can't order go to -1 if we continue to fail to allocate a folio?

> +	return folio;
>  }
>
>  static void rb_free_aux_page(struct perf_buffer *rb, int idx)
>  {
> -	struct page *page = virt_to_page(rb->aux_pages[idx]);
> +	struct folio *folio = virt_to_folio(rb->aux_pages[idx]);
>
> -	ClearPagePrivate(page);
> -	page->mapping = NULL;
> -	__free_page(page);
> +	folio->mapping = NULL;
> +	folio_put(folio);
>  }
>
>  static void __rb_free_aux(struct perf_buffer *rb)
> @@ -672,7 +661,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  		 pgoff_t pgoff, int nr_pages, long watermark, int flags)
>  {
>  	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
> -	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
> +	int node = (event->cpu == -1) ? numa_mem_id() : cpu_to_node(event->cpu);
>  	int ret = -ENOMEM, max_order;
>
>  	if (!has_aux(event))
> @@ -707,17 +696,21 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>
>  	rb->free_aux = event->pmu->free_aux;
>  	for (rb->aux_nr_pages = 0; rb->aux_nr_pages < nr_pages;) {
> -		struct page *page;
> -		int last, order;
> +		struct folio *folio;
> +		unsigned int i, nr, order;
> +		void *addr;
>
>  		order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
> -		page = rb_alloc_aux_page(node, order);
> -		if (!page)
> +		folio = rb_alloc_aux_folio(node, order);
> +		if (!folio)
>  			goto out;
> +		addr = folio_address(folio);
> +		nr = folio_nr_pages(folio);

I was going to raise the unspeakably annoying nit about this function returning
a long, but then that made me wonder why, given folio->_folio_nr_pages is an
unsigned int folio_nr_pages() returns a long in the first instance?

>
> -		for (last = rb->aux_nr_pages + (1 << page_private(page));
> -		     last > rb->aux_nr_pages; rb->aux_nr_pages++)
> -			rb->aux_pages[rb->aux_nr_pages] = page_address(page++);
> +		for (i = 0; i < nr; i++) {
> +			rb->aux_pages[rb->aux_nr_pages++] = addr;
> +			addr += PAGE_SIZE;
> +		}
>  	}
>
>  	/*
> --
> 2.40.1
>
