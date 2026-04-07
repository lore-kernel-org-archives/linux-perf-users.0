Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4131A9FBA;
	Tue,  7 Apr 2026 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532537; cv=none; b=kvrH6DCbvXBKWZK56ab0vkDygpFgYXkb3MSFSq3wPs5jpwYPLz3/k1fCDCTqAvSkPTpm3DEbkvmLS4dVqkw1EgLD/dhHxsWe2Ym6TcwOUc1KwOu2r1namvBMUzpZ4PAHhdMNh38BxoeAQUVxwxCaMfOkaPKt0Rpz0UqXFFQtkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532537; c=relaxed/simple;
	bh=rGxJ/GFPxD1fTxFc6L3HZVbz/GVhPSIOf5Qf+kTZAcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDt02j99n39pW8kW5NaZGWNa8cFZqQ9otTpiy7okbS10RKeNJH0rhi67EWDNeiCw2+Z1mUIhZJ50Zzl3ZTyde4DSnBndGWcHPLiyiOy5WrHZD6mcQtzAasEU3MnW38016maEXpQ/mvzK59zcRfWjDXe/Opuwa5eP1h5w/pvb6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J8sN6vHT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J8sN6vHT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DCE22ECB;
	Mon,  6 Apr 2026 20:28:47 -0700 (PDT)
Received: from [10.164.18.83] (unknown [10.164.18.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03EC03F7D8;
	Mon,  6 Apr 2026 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775532533; bh=rGxJ/GFPxD1fTxFc6L3HZVbz/GVhPSIOf5Qf+kTZAcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J8sN6vHT6wwFlL7w+ibtbyy+RquT3UJgu31Rqk6lPgGMfOEtwfVy0CDOl0+tf2hL+
	 P+5722EfEjo8+QgJZlfBEyhlP2lqjI1tiMA8hoLKpVioc1QG7k/fkkQDQpBfWRMEwE
	 TiXiGNaYeB1yOH41Pu6Vrltn9LQFfwVlfj8zKXSQ=
Message-ID: <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
Date: Tue, 7 Apr 2026 08:58:46 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260227062744.2215491-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/02/26 11:57 AM, Anshuman Khandual wrote:
> Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
> standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
> accessors default to READ_ONCE() on platforms that don't override them. So
> there is no functional change on such platforms.
> 
> However arm64 platform is being extended to support 128 bit page tables via
> a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
> provide required single copy atomic access for 128 bit page table entries.
> Although pxdp_get() accessors can later be overridden on arm64 platform to
> extend required single copy atomicity support on 128 bit entries.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies both on v7.0-rc1 and mm-unstable.
> 
> Part of the D128 series but independent. Hence could be considered on its own.
> 
> https://lore.kernel.org/all/20260224051153.3150613-5-anshuman.khandual@arm.com/
> 
> Collected Peter's tag from an off list conversation.

Gentle ping. 

Still don't see this patch in latest next-20260406. Hence just
wondering which tree and branch this patch is being picked up ?

Thank you

- Anshuman
  
> 
>  kernel/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ac70d68217b6..4ee151cd2c6d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8422,7 +8422,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  	pte_t *ptep, pte;
>  
>  	pgdp = pgd_offset(mm, addr);
> -	pgd = READ_ONCE(*pgdp);
> +	pgd = pgdp_get(pgdp);
>  	if (pgd_none(pgd))
>  		return 0;
>  
> @@ -8430,7 +8430,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  		return pgd_leaf_size(pgd);
>  
>  	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
> -	p4d = READ_ONCE(*p4dp);
> +	p4d = p4dp_get(p4dp);
>  	if (!p4d_present(p4d))
>  		return 0;
>  
> @@ -8438,7 +8438,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  		return p4d_leaf_size(p4d);
>  
>  	pudp = pud_offset_lockless(p4dp, p4d, addr);
> -	pud = READ_ONCE(*pudp);
> +	pud = pudp_get(pudp);
>  	if (!pud_present(pud))
>  		return 0;
>  

