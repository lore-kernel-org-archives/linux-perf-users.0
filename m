Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BEAEED8;
	Mon,  6 Oct 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740022; cv=none; b=WdrZURPGzbiQAu2XWiNNlLKZ1YC7hIQ+ASDhgq4VvEHifqNa/EkeM9YnIErcqjY0LNlvMNHnsJyWKib+xv3qbR7QOLs/SbgjfEpGqHzZOuwUH7vwVwzisb40kb9SchmaReA7ENJcX7uqEmTtTSJXe28OLeIoRJHZ4rK/1D6pXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740022; c=relaxed/simple;
	bh=K/OS1XUgAUjB+VieGV907j4fwdjmuRLywY+2JXZpc6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riq3Jw4nooJ6RoavixFmAs690dE1IxGSbqo02IihHg+U06v/ImSkOibuJGRCOEbvpcjYAjtGccEsbbuuewPfLtQDrsyi/IzSCrfNiHlN8IrUKdB9bRs/E+aneovSbImwr2uDmyb+SQNq+/Bas17n1uzjx5biovHgFCUJx3rJa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F581515;
	Mon,  6 Oct 2025 01:40:10 -0700 (PDT)
Received: from [10.164.18.47] (unknown [10.164.18.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28CE73F59E;
	Mon,  6 Oct 2025 01:40:16 -0700 (PDT)
Message-ID: <fa89fa8b-f5dd-4e01-a079-9b414efac30d@arm.com>
Date: Mon, 6 Oct 2025 14:10:14 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/events: replace READ_ONCE() with standard page table
 accessors
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
References: <20251006042622.1743675-1-anshuman.khandual@arm.com>
 <20251006082238.GQ3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251006082238.GQ3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/25 1:52 PM, Peter Zijlstra wrote:
> On Mon, Oct 06, 2025 at 05:26:22AM +0100, Anshuman Khandual wrote:
>> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
>> anyways default into READ_ONCE() in cases where platform does not override.
> 
> Note that these accessors are more recent than the code in question.

Sure.
> 
> Furthermore, I can only find two pointless overrides and suggest the
> below.
> 
> This then raises the question of the purpose of these accessors; why
> isn't a plain READ_ONCE() preferred if that is really all it is?

These accessors provide platforms the opportunity to override and have different
implementations other than READ_ONCE() when required.

Currently there is a mix of READ_ONCE() and pxdp_get() accessors across generic
MM and else where. Hence converting the READ_ONCE() on page table pointers into
pxdp_get() helpers thus improving consistency, as well as it offers flexibility
to platforms to override the implementation later when required.

Besides these static inline helper replacements does not add any more cost.

> > [ this skips over the ptep_get() issue, which does seem a little more
> involved -- but also has some definite want of cleanups ]
> 
> ---
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 86378eec7757..c4c23dc4dc77 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -150,8 +150,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  
> -#define pgdp_get(pgpd)		READ_ONCE(*pgdp)
> -
>  #define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
>  #define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
>  
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index bd128696e96d..8184e8c44db6 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -107,7 +107,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define KFENCE_AREA_END		(KFENCE_AREA_START + KFENCE_AREA_SIZE - 1)
>  
>  #define ptep_get(ptep) READ_ONCE(*(ptep))
> -#define pmdp_get(pmdp) READ_ONCE(*(pmdp))
>  
>  #define pte_ERROR(e) \
>  	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 25a7257052ff..bc76db9974e4 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -341,33 +341,25 @@ static inline pte_t ptep_get(pte_t *ptep)
>  }
>  #endif
>  
> -#ifndef pmdp_get
>  static inline pmd_t pmdp_get(pmd_t *pmdp)
>  {
>  	return READ_ONCE(*pmdp);
>  }
> -#endif
>  
> -#ifndef pudp_get
>  static inline pud_t pudp_get(pud_t *pudp)
>  {
>  	return READ_ONCE(*pudp);
>  }
> -#endif
>  
> -#ifndef p4dp_get
>  static inline p4d_t p4dp_get(p4d_t *p4dp)
>  {
>  	return READ_ONCE(*p4dp);
>  }
> -#endif
>  
> -#ifndef pgdp_get
>  static inline pgd_t pgdp_get(pgd_t *pgdp)
>  {
>  	return READ_ONCE(*pgdp);
>  }
> -#endif
>  
>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,

