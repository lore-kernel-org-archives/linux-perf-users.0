Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A0127E2A
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414987; cv=none; b=caMpAfxcihID46CR/qF0vqxLcQI2bYOFaIdDdEZ+dCGvy9L3r6uEBJ5hcl8h1NbElJ61tif2viViXQ+9qzXZYJOtzEqV0RRRHkplzLL3jsUTb9Dh46ls323g3lNpYzu8aJK+zJHEp5uX/4m+5lk46u84NahSNjdZdxPzAMZ41us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414987; c=relaxed/simple;
	bh=elCn1xDYIWV/yQGs+Ku+pblyY+MO1I2njlCPaJ/lBlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTnzLuXoolaMOMuphG0OSdnWZYKDv5RMczRAksyS7Vgx1gudow/TMQC812+0/sKtatIO2CMfTHwYjKbnDraRqglXV/Vh79Vlo7pJy2z3R7bdpwKaxyVJePyG430u1fLgpDKoJRFYdI1J/mIjpoleHGxvEaFYfdT5amQTk9Sfiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RLQaNY0T; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RLQaNY0T"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso4324605b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414985; x=1715019785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWcILGwRFtnD9QNVIhxXnveoA5tb5jtwzo4UtHN4I1M=;
        b=RLQaNY0TDyXF3atqhrbQ8rv55o9tI3o3v9odzjAJUvk8FAKvD1IwMjsKxAXAQ77pwa
         VMQBbxkUMfwrCZz799fWG91Fb5cBvgrmg9UjemJlAVZ+69S8444VFKs3l9OfVkwbp/ZB
         pdutqM73XdscKUMj5lDXt0tc7tvThDb+9s+hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414985; x=1715019785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWcILGwRFtnD9QNVIhxXnveoA5tb5jtwzo4UtHN4I1M=;
        b=QDCyBaIitVD/F3IFYTw7Ev/OzMN2gNsMoBsu3X/TwEzQYDYuxg82Qo+98JtO8q/kH6
         wRv1JMDvBNkYDz682MPko4Z/BSYtpIG9K5Bg/na15sg+ACVanY6R37JDH5009VibwOip
         ufIWL+RUMDVfBiJEF3cHWJCF5cZ45VC7MNUoaQTtz8Ss1TCORtF6gNwKinLG7CP8lyFG
         Fm/eNnji2kKAJbyBR8h8GLpBtAIiljaLNiseMlL38b8hzX9c8w97QlFboUxoths+4I+T
         Ki1pv4pLGiQ8T6bX28TPFUH0cCbH5XMSh46uTzmRLeifCjWZR2ge2aCD9zeqRMkaFTQC
         Tv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyJXgCesqMXVVlSItvAkbVvNqa8KYziI+2khDSd2eTFzNIjdgz8oNVD9QD2TYdEHm5cG8zxanHSMYbX3kmY7pn0YHYSz+xJEj3BvWqVwfbfQ==
X-Gm-Message-State: AOJu0YwVF250IY8DOGVjMfH+aCN2fBcXaNBu5LQCxZu2vgTzqhUpM3MQ
	BzvnTLP4CpNdtrPpQlc7cm/csIR0grxh+EqYY/tLy9zCy6h+248+MN2naWNiBQ==
X-Google-Smtp-Source: AGHT+IFz0eTj9zdDKI5T7BR0RE+lI1T8J94+vxaU7th74r2GtVz0bYGeFjBtUDFL9A5MjbnDcRYdSw==
X-Received: by 2002:a05:6a20:d494:b0:1a7:2e17:efd3 with SMTP id im20-20020a056a20d49400b001a72e17efd3mr17942155pzb.5.1714414985305;
        Mon, 29 Apr 2024 11:23:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020aa79847000000b006f0c0b6eee8sm17843241pfq.185.2024.04.29.11.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:23:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:23:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <202404291119.43630D7@keescook>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "rb" variable is a pointer to "struct perf_buffer" and this
> structure ends in a flexible array:
> 
> struct perf_buffer {
> 	[...]
        int                             nr_pages;       /* nr of data pages  */
	...
> 	void	*data_pages[];
> };

This should gain __counted_by(nr_pages) with a little refactoring.

> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc_node() functions.
> 
> In the "rb_alloc" function defined in the else branch of the macro
> 
>  #ifndef CONFIG_PERF_USE_VMALLOC
> 
> the count in the struct_size helper is the literal "1" since only one
> pointer to void is allocated. Also, remove the "size" variable as it
> is no longer needed.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> The Coccinelle script used to detect this code pattern is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1)
> ...
> i0 += sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Regards,
> Erick
> ---
>  kernel/events/ring_buffer.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4013408ce012..e68b02a56382 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  	unsigned long size;
>  	int i, node;
>  
> -	size = sizeof(struct perf_buffer);
> -	size += nr_pages * sizeof(void *);
> -
> +	size = struct_size(rb, data_pages, nr_pages);
>  	if (order_base_2(size) > PAGE_SHIFT+MAX_PAGE_ORDER)
>  		goto fail;

This looks good. Continuing...

        node = (cpu == -1) ? cpu : cpu_to_node(cpu);
        rb = kzalloc_node(size, GFP_KERNEL, node);
        if (!rb)
                goto fail;

then move this line up from below the array-writing loop:

        rb->nr_pages = nr_pages;


>  
> @@ -916,15 +914,11 @@ void rb_free(struct perf_buffer *rb)
>  struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  {
>  	struct perf_buffer *rb;
> -	unsigned long size;
>  	void *all_buf;
>  	int node;
>  
> -	size = sizeof(struct perf_buffer);
> -	size += sizeof(void *);
> -
>  	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> -	rb = kzalloc_node(size, GFP_KERNEL, node);
> +	rb = kzalloc_node(struct_size(rb, data_pages, 1), GFP_KERNEL, node);
>  	if (!rb)
>  		goto fail;

Same move here:

        rb->nr_pages = nr_pages;

Otherwise, yes, looks good!

-Kees

-- 
Kees Cook
