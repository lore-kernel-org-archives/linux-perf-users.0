Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D62C83F11
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Aug 2023 07:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjH0HWu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjH0HWc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 03:22:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2A1A6
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 00:22:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-400e8ca7e38so19321765e9.3
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693120947; x=1693725747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8xzhEQ3CLjRNHEHg0mtBbUNtrK+zL8cif/MOLW3IS4=;
        b=YVi4N8Xs/E5aBn4t276/eQ5fzPCNwWi5YR/GbAdCMZs/BNOBDH+W3s6bI7P1u8zsYV
         W1zUGgmnQc4FKoaxhcEmsofnPWjUHoeN04PiX1z78MPf7fKbvzIRc2y5NxUskxfqI6xv
         WHCv9ZGpJ2Yft2wCFiVJ2aaHibgFPpk/5KGA3rMMRrdQU50bBAfCSSyU63tUVYjGcw4y
         l5IPn8yuHFHnpTzyr4BTsefXRnJLKSc1wh47SqrnBnhZiF+0GmmwqAD5MQkvFK7KbMO3
         cQYKWbmYCMs36g56/xXObQV/41U3eik/TBdWA6mgTbu5KJ5wPdjU7lEw7KCucwHkZF6/
         XdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120947; x=1693725747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8xzhEQ3CLjRNHEHg0mtBbUNtrK+zL8cif/MOLW3IS4=;
        b=ZGnfEEaRMGj9d58BZKKKw9xcM5uUpIj8k5pc5ctOHBsYSw0qXUjuWB3A1Fy+TaqLzQ
         GZr4FyeQ5kfBmQ3Uw570cYzAHEzq8otmFjRTCDWZ+nr5UFbWGX4WPoS9kYlb7Qr2+lKL
         AKNuWN+FQd8gurFwWX3En+cY5O7tDA42IVPcCE29m8hT+FDkNqJm4s0aa+0ckwaWI5s2
         ohjSwzrVLGjeXbtY4aPW0u6mP4pW903lUXSRQo/rJR7oTTmvTv3M/gMqs7qsunpnGJgu
         AfsG3BpXxZ2qSmxqhfv1NkUuzh8I9UG8VMgCGuzAXUawZ1MTeU94/WkN23AO0ppj0jIT
         petQ==
X-Gm-Message-State: AOJu0YxGkWu8326fO5f+kNHC695rHs7hv+qySIw6ANsqlvugNOeQfaoF
        Oitom2De2VX6UESFz7KYTB+cRZSNlQ8=
X-Google-Smtp-Source: AGHT+IGTJbdipN2x5xwsQ9dXCwW4NazzlCoMjJnzTDTOeN3NYrclaHxaRm1+F0Dt0aYG3q/C4Ka8mQ==
X-Received: by 2002:a05:600c:258:b0:3fe:16f4:d865 with SMTP id 24-20020a05600c025800b003fe16f4d865mr16246287wmj.23.1693120947174;
        Sun, 27 Aug 2023 00:22:27 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe29dc0ff2sm7118483wmc.21.2023.08.27.00.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:22:26 -0700 (PDT)
Date:   Sun, 27 Aug 2023 08:22:25 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        urezki@gmail.com, hch@infradead.org
Subject: Re: [RFC PATCH 3/4] perf: Use vmalloc_to_folio()
Message-ID: <f6082b94-afe0-4e59-b9e9-3c5091780797@lucifer.local>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202016.2910321-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 09:20:15PM +0100, Matthew Wilcox (Oracle) wrote:
> Eliminate a use of page->mapping by using vmalloc_to_folio() instead.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h          | 5 +++++
>  kernel/events/ring_buffer.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 840bae5f23b6..7d84a2843193 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1134,6 +1134,11 @@ int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
>  struct page *vmalloc_to_page(const void *addr);
>  unsigned long vmalloc_to_pfn(const void *addr);
>
> +static inline struct folio *vmalloc_to_folio(const void *addr)
> +{
> +	return page_folio(vmalloc_to_page(addr));
> +}
> +

Total nit, and quite possibly unnecessary, but it might be nice to have a
comment pointing out that vmalloc_to_page can and will return tail pages hence
the need for page_folio() and thus _compound_head().

This makes me wonder about a typedef or wrapper type which explicitly indicates
that a function is _intentionally_ returning something that might be a head or a
tail page. But perhaps once foliofication is complete, this is what struct page
or its memdesc replacement will become?

>  /*
>   * Determine if an address is within the vmalloc range
>   *
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index c73add132618..56939dc3bf33 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -873,9 +873,9 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>
>  static void perf_mmap_unmark_page(void *addr)
>  {
> -	struct page *page = vmalloc_to_page(addr);
> +	struct folio *folio = vmalloc_to_folio(addr);
>
> -	page->mapping = NULL;
> +	folio->mapping = NULL;
>  }
>
>  static void rb_free_work(struct work_struct *work)
> --
> 2.40.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
