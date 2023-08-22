Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEC0EE4996
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 08:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjHVIBJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjHVIAi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 04:00:38 -0400
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 01:00:36 PDT
Received: from out-60.mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775B219B
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 01:00:36 -0700 (PDT)
Message-ID: <ae429c8e-a5af-f598-d5e0-087e654e45b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692690866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+O4si5w/E2/akKLW5SoU9zs6iDaWmx/D6iWPQnxzVds=;
        b=XYndpGqF8frJwSvaa1p+E3hZ19j/ot0to+7OlDpYIDalXVRVklTSvRGk/FDPExA/vSHkQF
        +Uxye/vKrWGQ6NidKsTTtkOS/V2lUeesjtJkfRBw5jIj2cihm5w8tYQUFzOlBGJ+2xy5RI
        /sSeWLcAiX08EMJH0pR1O7tOsxlZ7Rw=
Date:   Tue, 22 Aug 2023 15:54:17 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 3/4] perf: Use vmalloc_to_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-4-willy@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230821202016.2910321-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

在 2023/8/22 4:20, Matthew Wilcox (Oracle) 写道:
> Eliminate a use of page->mapping by using vmalloc_to_folio() instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h          | 5 +++++
>   kernel/events/ring_buffer.c | 4 ++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 840bae5f23b6..7d84a2843193 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1134,6 +1134,11 @@ int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
>   struct page *vmalloc_to_page(const void *addr);
>   unsigned long vmalloc_to_pfn(const void *addr);
>   
> +static inline struct folio *vmalloc_to_folio(const void *addr)
> +{
> +	return page_folio(vmalloc_to_page(addr));
> +}

Thanks a lot. This function is very wonderful. It is also what I need.

Zhu Yanjun

> +
>   /*
>    * Determine if an address is within the vmalloc range
>    *
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index c73add132618..56939dc3bf33 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -873,9 +873,9 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>   
>   static void perf_mmap_unmark_page(void *addr)
>   {
> -	struct page *page = vmalloc_to_page(addr);
> +	struct folio *folio = vmalloc_to_folio(addr);
>   
> -	page->mapping = NULL;
> +	folio->mapping = NULL;
>   }
>   
>   static void rb_free_work(struct work_struct *work)

