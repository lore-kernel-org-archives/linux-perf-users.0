Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDB747F;
	Sun,  5 May 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714922712; cv=none; b=OTeJfZh0cOErxXg6HYDQM/MIHM7Ji90iehkkYYP22s5B2TK3uxeUymDmthOezdJgCdeAwsgUuesWj9ciTrAGaxaoxHax7WDbUCPtm8Om8atU5MfVRcPrmepnLi29YELV8Uekw81HJjRpDjdDQ660scbdajT/fMzsIXOpNpT7bsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714922712; c=relaxed/simple;
	bh=h1GSfJkP+XpAGve4Yrrj47DZ5Mm63WGc/WQWxHSpP8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBx4vtJC1PxYm+0x3mXIjLEy3Viz2+BTmiHaPBGhSuq6L4FtFBfs6p15qMeBsTkVf8D2Sj/woYuCT9OwQ7xcaIAUenOXXlQ3SfDNfAH2Lg9JJzoKfKltgCizdX96Epodq4mYEXQJGmEzAoRsXnaKktJoyb/sJ+J4wVetzvUsZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IDnxK9HK; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IDnxK9HK"
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 3djUsCqAriGtU3djUsiM9f; Sun, 05 May 2024 17:25:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714922700;
	bh=yMjNEPDv2xsuVDvmwEGk6roF3RPmf7R4LsU+11Mt7Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IDnxK9HKNXMrDCOiRXDrSdpkHKN1iGS7Yjn0Iz67xruJmVxfgXOaVghYwqxKPMETU
	 Siszc0hH6MeY5bF6Z0mA8WyDCJgjQS7MfFtKc7g2JXkWLLEqGT0o1SclcrR2iZ4uqs
	 HZDEupsiXqRYxY7pAZ2RUlROj+h1Y+LLXki/znkIBP9Z1zMVRJG9TJaGpwkdJ8UPcv
	 jkBDiBqjiyqTS14QKVZ0MDo0SbGRnd/mgFlrVh7IS+opLPoBZvfBxZSbL3SBdMo01k
	 Tx0hmXjl45QcY6Q2h7pJ/1Tv5qHpClln2vJtchNajqwmHFQV99VMQ+ZtMKbIvTaV5k
	 TmFLp+kBFQviA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 05 May 2024 17:25:00 +0200
X-ME-IP: 86.243.17.157
Message-ID: <51a49bae-bd91-428e-b476-f862711453a0@wanadoo.fr>
Date: Sun, 5 May 2024 17:24:55 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
To: Erick Archer <erick.archer@outlook.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/05/2024 à 16:15, Erick Archer a écrit :
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "rb" variable is a pointer to "struct perf_buffer" and this
> structure ends in a flexible array:
> 
> struct perf_buffer {
> 	[...]
> 	void	*data_pages[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc_node() functions.
> 
> In the "rb_alloc" function defined in the else branch of the macro
> 
>   #ifndef CONFIG_PERF_USE_VMALLOC
> 
> the count in the struct_size helper is the literal "1" since only one
> pointer to void is allocated. Also, remove the "size" variable as it
> is no longer needed.
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the logic needs a little refactoring to ensure that the "nr_pages"
> member is initialized before the first access to the flex array.
> 
> In one case, it is only necessary to move the assignment before the
> array-writing loop while in the other case the assignment needs to be
> added.
> 
> This way, the code is more safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v2:
> - Annotate "struct perf_buffer" with __counted_by() attribute (Kees Cook).
> - Refactor the logic to gain __counted_by() coverage (Kees Cook).
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com/
> 
> Hi Peter,
> 
> I know that you detest the struct_size() helper, however, as Kees
> explained in v1, this change improves the robustness of the code.
> Also, we will gain __counted_by() coverage.
> 
> I hope this patch can be applied this time.
> 
> Regards,
> Erick
> ---
>   kernel/events/internal.h    |  2 +-
>   kernel/events/ring_buffer.c | 14 ++++----------
>   2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 5150d5f84c03..dc8d39b01adb 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -55,7 +55,7 @@ struct perf_buffer {
>   	void				*aux_priv;
>   
>   	struct perf_event_mmap_page	*user_page;
> -	void				*data_pages[];
> +	void				*data_pages[] __counted_by(nr_pages);
>   };
>   
>   extern void rb_free(struct perf_buffer *rb);
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4013408ce012..080537eff69f 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>   	unsigned long size;

Hi,

Should size be size_t?

>   	int i, node;
>   
> -	size = sizeof(struct perf_buffer);
> -	size += nr_pages * sizeof(void *);
> -
> +	size = struct_size(rb, data_pages, nr_pages);
>   	if (order_base_2(size) > PAGE_SHIFT+MAX_PAGE_ORDER)
>   		goto fail;
>   
> @@ -833,6 +831,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>   	if (!rb)
>   		goto fail;
>   
> +	rb->nr_pages = nr_pages;
>   	rb->user_page = perf_mmap_alloc_page(cpu);
>   	if (!rb->user_page)
>   		goto fail_user_page;
> @@ -843,8 +842,6 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>   			goto fail_data_pages;
>   	}
>   
> -	rb->nr_pages = nr_pages;
> -
>   	ring_buffer_init(rb, watermark, flags);
>   
>   	return rb;
> @@ -916,18 +913,15 @@ void rb_free(struct perf_buffer *rb)
>   struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>   {
>   	struct perf_buffer *rb;
> -	unsigned long size;
>   	void *all_buf;
>   	int node;
>   
> -	size = sizeof(struct perf_buffer);
> -	size += sizeof(void *);
> -
>   	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> -	rb = kzalloc_node(size, GFP_KERNEL, node);
> +	rb = kzalloc_node(struct_size(rb, data_pages, 1), GFP_KERNEL, node);
>   	if (!rb)
>   		goto fail;
>   
> +	rb->nr_pages = nr_pages;

I don't think this is correct.

There is already a logic in place about it a few lines below:

	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
	if (!all_buf)
		goto fail_all_buf;

	rb->user_page = all_buf;
	rb->data_pages[0] = all_buf + PAGE_SIZE;
	if (nr_pages) {					<--- here
		rb->nr_pages = 1;			<---
		rb->page_order = ilog2(nr_pages);
	}

I think that what is needed is to move this block just 2 lines above, 
(before rb->data_pages[0] = ...)


I'm also wondering what should be done if nr_pages = 0.


CJ

>   	INIT_WORK(&rb->work, rb_free_work);
>   
>   	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);

