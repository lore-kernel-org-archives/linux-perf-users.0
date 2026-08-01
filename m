Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033513839A3
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Aug 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594772; cv=none; b=S7CGzlITcilk77MD9f05jjgbZIQLlQA8YAiT6f9LMTqvHZ1YysgyyFt/23accXb4urHexz13MBOQRBFEeaGXPLtc+5Cen199m9sWiJO4fL4f60nk3dhX6s+nXh3Vfik8FOIvFepbslKaOi7p9PktC87UgO1GjSsbMIVlMmRqk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594772; c=relaxed/simple;
	bh=xA97G47wyRvIgAgtg+lfOCMaER2FjiU1CJVS4+HZnOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs8orbP3oJr0SMoCY2bHSTPYKBBafNI1dyplpjknUyrjBFDHYmYqBa4nR4d5/adeDGEEhqTZ96+ErtVymEpqATdfSoEUKK4b8UqJJsTfgn+Tmq11prRQYnI6GsaU0pbabgGM9jcpIQ4mscnrBS2yZXA3qJg3166UEKRjHrK+Dys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b1MJ2KvV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b1MJ2KvV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785594758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ri60wTe3lRq/wyazLvLAJHMWphJ53DXAVPzpa92v8E=;
	b=b1MJ2KvVydMkbGpiSM2vSJhXzcu6GCUhE0pgi57LctVN7QP7thbs+314VxzqPZ0y2fArlf
	zLY1i65Y6JE/Xt/8+PFW0EPl2ofxtl+fUxbw+hmqUM1Nk0YFt8YDyt37ciBE3FfwWAblHr
	Ops92EnsY7B5tMRb4P3SdCuy3WE/xkA=
From: Usama Arif <usama.arif@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC 02/14] perf/ring_buffer: stop using PG_private as AUX page high-order marker
Date: Sat,  1 Aug 2026 07:32:26 -0700
Message-ID: <20260801143227.1267657-1-usama.arif@linux.dev>
In-Reply-To: <20260731-remove-pg_private-v1-2-142c97ba3562@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 31 Jul 2026 22:13:25 -0400 Zi Yan <ziy@nvidia.com> wrote:

> A high-order AUX page sets PG_private on its first page and stores the
> order in first_page->private. Stop using PG_private and check
> first_page->private for AUX page order only ring buffer and its users.
> 

nit: only "in the" ring buffer?

> It prepares for a future commit that remove PG_private.
> 
> No functional change intended.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/events/intel/bts.c | 3 ---
>  arch/x86/events/intel/pt.c  | 6 ++----
>  kernel/events/ring_buffer.c | 7 +++----
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index cbac54cb3a9ec..5849392cf26d5 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -66,9 +66,6 @@ static struct pmu bts_pmu;
>  
>  static int buf_nr_pages(struct page *page)
>  {
> -	if (!PagePrivate(page))
> -		return 1;
> -


For order 0, 1 << 0 is 1, which is exactly what the !PagePrivate(page) so LGTM.

The commit message probably needs more text but everything else looks good.

Feel free to add

Acked-by: Usama Arif <usama.arif@linux.dev>


>  	return 1 << page_private(page);
>  }
>  
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index b5726b50e77db..29d8b4a3560cd 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -774,8 +774,7 @@ static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
>  	struct page *p;
>  
>  	p = virt_to_page(buf->data_pages[buf->nr_pages]);
> -	if (PagePrivate(p))
> -		order = page_private(p);
> +	order = page_private(p);
>  
>  	if (topa_table_full(topa)) {
>  		topa = topa_alloc(cpu, gfp);
> @@ -1289,8 +1288,7 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
>  	if (!intel_pt_validate_hw_cap(PT_CAP_single_range_output))
>  		goto out;
>  
> -	if (PagePrivate(p))
> -		order = page_private(p);
> +	order = page_private(p);
>  
>  	if (1 << order != nr_pages)
>  		goto out;
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 9fe92161715e0..061b5cb222266 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -630,11 +630,10 @@ static struct page *rb_alloc_aux_page(int node, int order)
>  		/*
>  		 * Communicate the allocation size to the driver:
>  		 * if we managed to secure a high-order allocation,
> -		 * set its first page's private to this order;
> -		 * !PagePrivate(page) means it's just a normal page.
> +		 * set its first page's private to this order, otherwise page's
> +		 * private remains zero.
>  		 */
>  		split_page(page, order);
> -		SetPagePrivate(page);
>  		set_page_private(page, order);
>  	}
>  
> @@ -645,7 +644,7 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
>  {
>  	struct page *page = virt_to_page(rb->aux_pages[idx]);
>  
> -	ClearPagePrivate(page);
> +	set_page_private(page, 0);
>  	__free_page(page);
>  }
>  
> 
> -- 
> 2.53.0
> 
> 
