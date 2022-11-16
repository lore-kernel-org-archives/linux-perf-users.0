Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E1C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 11:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKPLB3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiKPLBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 06:01:01 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11D45EDC
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 02:49:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ft34so42998001ejc.12
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSCwvxDUrivspPm0mWYSEKkrMB19obOv39RUwyA0PH0=;
        b=VJ17UkTNHUXDMc38lOye7y2paGd4FOYHBRYpe2vgelPuC55Z4g5rnX+xNi0NFRGTrN
         mdMUVKijrbkJJfn3y8Tm8vf3pLdF4omxIOM6UM8S6CVz2p3NrVUPvz4FNRN3RF3rQ/lN
         9z9ibLXy5LDPJfO5cF7QIpPDKsW5E+659K7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSCwvxDUrivspPm0mWYSEKkrMB19obOv39RUwyA0PH0=;
        b=c9S3YLyXhBywelpUG0lOfVVYAGD4Bx53ennMkE6Fwrgz8T55+btpatLaZyPB9XVNL+
         9Ys2ItLg5wRWGIaqBnS3ECv29jFCwe2mWScHpXUbPvojYZOieXvvKLNSG2DiWrCLk/8q
         MWpb7jJHpdeD2fOLaBX3Sa5X5KBNerx0q7EXayqD5xtKjv5/xtS1AjBGPye1v9JK9Tw1
         +hwG8zyUm3Tfivnmw8oV4FpeXh5AF2FpmJQJXLr6mmr1aN6tAXFpQ7SMuOR09PW5frrS
         O8AixVMQ+ztut5K6fPTNjDXlfikwSlwv1rhIMwXfz+xaNe8DSg0okbXbXBbf6dax3SgH
         YDJA==
X-Gm-Message-State: ANoB5pmDERAyKSqRubbJfEI7S4HVcmLXJSf5AtFN2v5Hx4dpVLzg109F
        sfaIN3Q0TR3aCqeZHLWl4aSufw==
X-Google-Smtp-Source: AA0mqf6lc5lrEzUlEqYgu67h96R4r19JtBnDlqqKBl9ey0VuIf1EYIOTKVPSxvCTipQmxuaB88n35Q==
X-Received: by 2002:a17:906:970e:b0:7ad:ccae:a30d with SMTP id k14-20020a170906970e00b007adccaea30dmr18079730ejx.704.1668595739329;
        Wed, 16 Nov 2022 02:48:59 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm7352935edr.51.2022.11.16.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:48:58 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:48:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>, linux-media@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Oded Gabbay <ogabbay@kernel.org>,
        linux-mips@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH mm-unstable v1 13/20] media: videobuf-dma-sg: remove
 FOLL_FORCE usage
Message-ID: <Y3TAGAUIo/IR+tAa@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
        linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Oded Gabbay <ogabbay@kernel.org>, linux-mips@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-14-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:52AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I looked at this a while ago when going through some of the follow_pfn
stuff, so

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/media/v4l2-core/videobuf-dma-sg.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
> index f75e5eedeee0..234e9f647c96 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-sg.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
> @@ -151,17 +151,16 @@ static void videobuf_dma_init(struct videobuf_dmabuf *dma)
>  static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
>  			int direction, unsigned long data, unsigned long size)
>  {
> +	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long first, last;
> -	int err, rw = 0;
> -	unsigned int flags = FOLL_FORCE;
> +	int err;
>  
>  	dma->direction = direction;
>  	switch (dma->direction) {
>  	case DMA_FROM_DEVICE:
> -		rw = READ;
> +		gup_flags |= FOLL_WRITE;
>  		break;
>  	case DMA_TO_DEVICE:
> -		rw = WRITE;
>  		break;
>  	default:
>  		BUG();
> @@ -177,14 +176,11 @@ static int videobuf_dma_init_user_locked(struct videobuf_dmabuf *dma,
>  	if (NULL == dma->pages)
>  		return -ENOMEM;
>  
> -	if (rw == READ)
> -		flags |= FOLL_WRITE;
> -
>  	dprintk(1, "init user [0x%lx+0x%lx => %lu pages]\n",
>  		data, size, dma->nr_pages);
>  
> -	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages,
> -			     flags | FOLL_LONGTERM, dma->pages, NULL);
> +	err = pin_user_pages(data & PAGE_MASK, dma->nr_pages, gup_flags,
> +			     dma->pages, NULL);
>  
>  	if (err != dma->nr_pages) {
>  		dma->nr_pages = (err >= 0) ? err : 0;
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
