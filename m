Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EF45F73
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 20:19:48 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CB619E
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 13:19:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40531812168so27832095e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Sep 2023 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695413985; x=1696018785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=koDz7uR4JuD5CtafYggyuJ5hDx6OJdYJKuUjsBOIOJw=;
        b=mis/QC8uCwhPdOMwk35Wn6dSlHJsv3PycAqv2H2GD9PLVovKqX4ATyMErdbekVfO7+
         dHrcbN+wKLrP7uB/U9psWKyeX5BLLYN0crqP1sxWUwjPCx1qbAJW0l4SoplkvZdbhdL8
         245+YrW2WxTnHdqrg0YNYN7t5T4EZueoGRwIMnbB+Rrrj6BDlLCctNvVBLR0R3Psdxco
         B0KOB+2NrVkRFjc7ZWFzErh0+6i72zGUoEc14ao8R722pk+Lyq91gYN2Nsy3jVKo2nJy
         WZRIrsARrJWgpZkFJaG8UcRVMS3dcI0a11GZruP8JRmLPiC3++00ZS7V6TS3i/QK+4X/
         8qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695413985; x=1696018785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koDz7uR4JuD5CtafYggyuJ5hDx6OJdYJKuUjsBOIOJw=;
        b=Z5GY7NC7upQjFb3l48g6DlUhzmK7IZq2CEBKcQb0PoZjTwhGDlogZlERBvvNzz07YY
         T5aH+z2MwQ95BEH/8PQuRoHXMudqCw02lo/w+2M1OPswVGK7SqFmTNRXYT3XVgj0G1Yl
         UR8QtLhTKZdBeiVoA/LswFBdxFZHf5OvXBX1/uMPqlmeLFtx6pxoCeWPR6d17T4OpDYy
         KgZzFP/OOGkbRzUMMoQYkgaYol+WI8OCYxpgWYKfb0f/kj8gh/kxSzT6cJW28GWF6a+6
         NMWP/4/eizGmyF5jpeLt7bK/iMGZjU6mp8jqcec9DT0eVy6bT5alXHwp6sauMkQ5AsoC
         WLug==
X-Gm-Message-State: AOJu0YxKmdmjAoIrypnxvqBA5c5YhByPv58ZiE26YBB9MPeyvuyueljW
	DEcnZxq6RQEyi8ODfmZnM0U=
X-Google-Smtp-Source: AGHT+IHF2VxgMhTbLhU8jECNFsONsbRaa3casHYCM1ms7rtOSYqYmRW0rTVLX/PPVIoZjZiCUeQnfw==
X-Received: by 2002:a7b:c3cc:0:b0:400:419c:bbde with SMTP id t12-20020a7bc3cc000000b00400419cbbdemr320765wmj.18.1695413985146;
        Fri, 22 Sep 2023 13:19:45 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c320500b003fc0505be19sm259460wmp.37.2023.09.22.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 13:19:44 -0700 (PDT)
Date: Fri, 22 Sep 2023 21:19:43 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
	urezki@gmail.com, hch@infradead.org
Subject: Re: [RFC PATCH 1/4] perf: Convert perf_mmap_(alloc,free)_page to
 folios
Message-ID: <0d8c508d-91c5-435e-9880-7eedebce2219@lucifer.local>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-2-willy@infradead.org>
 <78cc53f6-3828-4802-afc5-abb71dc59627@lucifer.local>
 <20230913133105.GF22758@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913133105.GF22758@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 13, 2023 at 03:31:05PM +0200, Peter Zijlstra wrote:
> On Sun, Aug 27, 2023 at 08:33:39AM +0100, Lorenzo Stoakes wrote:
>
> > > @@ -785,25 +785,23 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
> > >  	return virt_to_page(rb->data_pages[pgoff - 1]);
> > >  }
> > >
> > > -static void *perf_mmap_alloc_page(int cpu)
> > > +static void *perf_mmap_alloc_page(int node)
> >
> > Nitty point but since we're dealing with folios here maybe rename to
> > perf_mmap_alloc_folio()?
>
> Since it's an explicit order-0 allocation, does that really make sense?
>

True, it does ultimately yield a single page and doesn't reference its
metadata so it's not the end of the world to keep it as-is (it was very
nitty after all!)

> > >  {
> > > -	struct page *page;
> > > -	int node;
> > > +	struct folio *folio;
> > >
> > > -	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> > > -	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
> > > -	if (!page)
> > > +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, 0, node);
> > > +	if (!folio)
> > >  		return NULL;
> > >
> > > -	return page_address(page);
> > > +	return folio_address(folio);
> > >  }
>
