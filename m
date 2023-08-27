Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BEEC83F11
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Aug 2023 07:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjH0HeC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 03:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjH0Hdq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 03:33:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F65F1
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 00:33:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401b0d97850so21813875e9.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693121622; x=1693726422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXqSDQRdpFVxSMWPIbkM/UGoWPvgZsuAolwIKyKIbCc=;
        b=jrn4u52wWLXhjFndbFcrhD0rRuHMtXN84kHStHP4IjJL8zlRDHBArSDCM0wapaIyY/
         n2USwSXR0b+khTfWxa+OUScoXEQp+VmRtXmrElnrHR6p4BvsAnGNFHHkQG2La06hOH0D
         O5yqrcHdeFOQhHeznA2S05P561KWK67QBPntWF44cFM69LKwaVTS0zeBNgKdlLK7bqoB
         EsgFs/ljqpzRYVlpzq6hF36/Ot+p4LSesa+T4PKqVhkzhN/2EdhaiPXXmwu0bl69tyS+
         53IrCvnsk42Mnz7SLkQo8aC0JUCzuao901XXhmIU2vKdHbCmaUsrUZ4Fnf9RTPB/PTsf
         Xrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693121622; x=1693726422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXqSDQRdpFVxSMWPIbkM/UGoWPvgZsuAolwIKyKIbCc=;
        b=WrdeuSMMuBvKfNPK1/6CSzlZsBQvtRwzS8l9y3S1aYmgqKWSosPzQoUgFTj6yKkH8v
         v/sVLbZe6yjz8W1cn2Eym07GXZgPdNc5hl5W5VoFagESBAAM6RBtmA1N75Ah52SKrpDW
         QiYDdayyyGzdKmFJTUoHS599gRjG0XXfFV4pREkgGXU4hFlE87zZfv/b1lET55f3wTIo
         vBMWewXHzrhVafxSCSfwp3r2yahlbU6g0xiMEqxv5jA1UwSx0PtqO+uZ6Fx4kFP0UhM8
         cBL6/1Kfl7yzq9xHIeABS1kn3NU6PhCZn/uPjZvxlWbQKLhBLLgAZCds+qKCLwlCqN1q
         6/tg==
X-Gm-Message-State: AOJu0YwK9EUCthUloSpQKHBBvstn/fgFKjtuS1sD7wCUVtTUhcHBTc0k
        0YWJqq7aEC6XEILUs2Y2QYM=
X-Google-Smtp-Source: AGHT+IG4iz2vp8SM8pBcVMkjpCxO51FlSyAFpz+4LhBPxhctWSt6/4ueEpGsgLpmVdzlXfz70jfC4A==
X-Received: by 2002:a1c:771a:0:b0:401:bdd7:499d with SMTP id t26-20020a1c771a000000b00401bdd7499dmr2942999wmi.25.1693121621811;
        Sun, 27 Aug 2023 00:33:41 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c205000b003fbdbd0a7desm7144882wmg.27.2023.08.27.00.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:33:40 -0700 (PDT)
Date:   Sun, 27 Aug 2023 08:33:39 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [RFC PATCH 1/4] perf: Convert perf_mmap_(alloc,free)_page to
 folios
Message-ID: <78cc53f6-3828-4802-afc5-abb71dc59627@lucifer.local>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202016.2910321-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 09:20:13PM +0100, Matthew Wilcox (Oracle) wrote:
> Use the folio API to alloc & free memory.  Also pass in the node ID
> instead of the CPU ID since we already did that calculation in the
> caller.  And call numa_mem_id() instead of leaving the node ID as
> -1 and having the MM call numa_mem_id() each time.

It's a bit of a nit or perhaps an aside, but with this change if you passed
-1 to the newly invoked __folio_alloc_node() you will also trigger a
VM_BUG_ON() :)

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  kernel/events/ring_buffer.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index fb1e180b5f0a..cc90d5299005 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -770,7 +770,7 @@ void rb_free_aux(struct perf_buffer *rb)
>  #ifndef CONFIG_PERF_USE_VMALLOC
>
>  /*
> - * Back perf_mmap() with regular GFP_KERNEL-0 pages.
> + * Back perf_mmap() with regular GFP_KERNEL pages.
>   */
>
>  static struct page *
> @@ -785,25 +785,23 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>  	return virt_to_page(rb->data_pages[pgoff - 1]);
>  }
>
> -static void *perf_mmap_alloc_page(int cpu)
> +static void *perf_mmap_alloc_page(int node)

Nitty point but since we're dealing with folios here maybe rename to
perf_mmap_alloc_folio()?

>  {
> -	struct page *page;
> -	int node;
> +	struct folio *folio;
>
> -	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> -	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
> -	if (!page)
> +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, 0, node);
> +	if (!folio)
>  		return NULL;
>
> -	return page_address(page);
> +	return folio_address(folio);
>  }
>
>  static void perf_mmap_free_page(void *addr)

Same comment re: rename -> perf_mmap_free_folio()

>  {
> -	struct page *page = virt_to_page(addr);
> +	struct folio *folio = virt_to_folio(addr);
>
> -	page->mapping = NULL;
> -	__free_page(page);
> +	folio->mapping = NULL;
> +	folio_put(folio);
>  }
>
>  struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> @@ -818,17 +816,17 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
>  		goto fail;
>
> -	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> +	node = (cpu == -1) ? numa_mem_id() : cpu_to_node(cpu);

This is a good change in general, it's pretty yucky that this code just assumes
-1 == NUMA_NO_NODE and that all invoked functions would handle this correctly.

>  	rb = kzalloc_node(size, GFP_KERNEL, node);
>  	if (!rb)
>  		goto fail;
>
> -	rb->user_page = perf_mmap_alloc_page(cpu);
> +	rb->user_page = perf_mmap_alloc_page(node);
>  	if (!rb->user_page)
>  		goto fail_user_page;
>
>  	for (i = 0; i < nr_pages; i++) {
> -		rb->data_pages[i] = perf_mmap_alloc_page(cpu);
> +		rb->data_pages[i] = perf_mmap_alloc_page(node);
>  		if (!rb->data_pages[i])
>  			goto fail_data_pages;
>  	}
> --
> 2.40.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
