Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753011F8F09;
	Fri, 21 Mar 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562308; cv=none; b=IKoHkRBZJNi519gTQ+AaLc9sbYsh8MK0J+C6tkx+F1ggNntH/kcnKt93DRXTrEZx/CmJgJSK2spE+UvYGO2kjCbgjyoleeMmEmXT4gBOsVYsxAhdMM5YBYbv8vWIkY7WsBVvrKRLMb+uR/G6Ig4NcZCqnIbj8/7sD36+oHQOV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562308; c=relaxed/simple;
	bh=Ad8Z2X/LZnTedt/yKE44XPTb+y+tNRXWHNLxEN0RzfY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKw5veO+fQP8VpBGASpTmgXg1nyndCIeRuObIgVkRLaVJSz2rjC6Mu7//55WT54Wt2UGYsFNkDQPAXdRQeK/6uDSnoIHg2T0LPnJRSCTaieo4rsdFIfTLSbtrdMgO98m6pF3x+uQ1+87rVLxea5NrdEfmcp1JV5vzoLregdph4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqNUb4uF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqNUb4uF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so17638075e9.3;
        Fri, 21 Mar 2025 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742562305; x=1743167105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4+8N541CkNOWDvfZ0cddMC7Om8lmOSt/AsWehOXc8g=;
        b=WqNUb4uF+WPs1oIFNXAHKoauncSsYNWDq8rrU0Kd08G+UIxNKtZtgkiJ+Pqr6xDXLG
         A41Sz66kv5t2xz62GC6ERAdNhYGYcd/KyV/1JJZcLEes6P178T18/jKwf72oor7QCMeJ
         gCWxy+xIi2edLL7gN2I5J29fTOEdmbsZWeulGM5yn5XZ2cWuyHu1TrR/NA6LNLpbh13Y
         DX5bQFZOdsepxdCApVnLBOIiXtBLwt7qn++tMgV5rvDk+8fzbPgVejRXPmrBQNfV2AUU
         U5G57BfSacDC/QJiTIFy0paKHY5kRjFBYxi8kP1NIo9MRbIQbYek/r6aU5kdlEN+jxCR
         uZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562305; x=1743167105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4+8N541CkNOWDvfZ0cddMC7Om8lmOSt/AsWehOXc8g=;
        b=FWpD9d/sz2dL5nR0RbmZqQtkEKtDrGKU8lDph+ohaJD2qWSzLe1GcyBZk3eQfeU5nY
         jEzLksr/SXIgKn29LGIcKD9xgzwFniAgrEHMcQWPEaQXMi9ykmSM+PgbtFDMsb6rnEQZ
         ZgJ3PtR8VJnA9ocRVJoAS3tqEj8R4RfMra/jsOhpJ3CrgJipH5pHW55tL718QtD11hf2
         9injeTlNsUbkpm+kp/FhxUsRDicPZV89fSoPPykgXCzk8HGHwku8A/v67yc2T4GXfnwv
         wFsXep0vB/fowjCHTeEEfofVBjYG7rYLc+Jdhs1Uyic+yHhxnoxSCDIHkpts1pESBm22
         QqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/6D0cdC0YC6fCz69rapsXUeUq+pqmg+KKOHnNbtUv9dAe5OTI8A5KxdKng/Bk/jaJapfNn1gEY5H+UUacjjJu@vger.kernel.org, AJvYcCX4zmVUuN4DO853N8lpIDz7sMtJDL16OxjnEThjsAV7wcbulF35f1aT+XPTY1QuoU0qqw8ITOrfhNGpZup8AxoGYthv@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0Mlwuq6CRwyyFjWMYh6yL3XhfDwa0O+3e+DSQEGMXQ3KBhn6
	GHikxy3Rjf0SSSavMe4wAwAAY5IOFw5M5N66AP7a4DLI3Mi/csTUl9SWY6KiNfw=
X-Gm-Gg: ASbGncuQUGAVwPnCl2h+R6dN8HL95j7RQ19MSO0X3s9AXLZNDvXMg3pP+fbJS1wxCXz
	lbblC3Zfl9cfAQQrqO4PhleVyF6cI+SkK7AtZxJpprEWjLxUDvIdNtDfOkjAjeEDYcBpYhwkrq8
	sfVXIgT0vpGMkuHi6cWq62kvd3doYKwBtihA1wIZljoJS3KlKJMKoV2PDYQq3RDCyORjA7MO+yr
	b0s471jq956hgcJVJdzhEkVkxklkW6BN6sUuxIBOWweXxK3SkxSDdI3OlsMxwLDPjQyrFjIVZxt
	6n0E5oBCV814b+yURj+vCQEZk/9eBM4=
X-Google-Smtp-Source: AGHT+IH86jMzbekNz39ZrDpdZDYAPnbN5nw03VrRG8082LHcSjfAUIiFBGdlOw/SLKZprEqeMfYmYA==
X-Received: by 2002:a05:600c:4512:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-43d50a3781amr21917025e9.21.1742562304146;
        Fri, 21 Mar 2025 06:05:04 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd27980sm26731495e9.21.2025.03.21.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:05:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Mar 2025 14:05:01 +0100
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v3 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
Message-ID: <Z91j_UwNhi2DQB3N@krava>
References: <20250321113713.204682-1-david@redhat.com>
 <20250321113713.204682-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321113713.204682-4-david@redhat.com>

On Fri, Mar 21, 2025 at 12:37:13PM +0100, David Hildenbrand wrote:

SNIP

> +static int __uprobe_write_opcode(struct vm_area_struct *vma,
> +		struct folio_walk *fw, struct folio *folio,
> +		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
> +{
> +	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
> +	const bool is_register = !!is_swbp_insn(&opcode);
> +	bool pmd_mappable;
> +
> +	/* For now, we'll only handle PTE-mapped folios. */
> +	if (fw->level != FW_LEVEL_PTE)
> +		return -EFAULT;
> +
> +	/*
> +	 * See can_follow_write_pte(): we'd actually prefer a writable PTE here,
> +	 * but the VMA might not be writable.
> +	 */
> +	if (!pte_write(fw->pte)) {
> +		if (!PageAnonExclusive(fw->page))
> +			return -EFAULT;
> +		if (unlikely(userfaultfd_pte_wp(vma, fw->pte)))
> +			return -EFAULT;
> +		/* SOFTDIRTY is handled via pte_mkdirty() below. */
> +	}
> +
> +	/*
> +	 * We'll temporarily unmap the page and flush the TLB, such that we can
> +	 * modify the page atomically.
> +	 */
> +	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
> +	fw->pte = ptep_clear_flush(vma, vaddr, fw->ptep);
> +	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> +
> +	/*
> +	 * When unregistering, we may only zap a PTE if uffd is disabled and
> +	 * there are no unexpected folio references ...
> +	 */
> +	if (is_register || userfaultfd_missing(vma) ||
> +	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
> +	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
> +		goto remap;
> +
> +	/*
> +	 * ... and the mapped page is identical to the original page that
> +	 * would get faulted in on next access.
> +	 */
> +	if (!orig_page_is_identical(vma, vaddr, fw->page, &pmd_mappable))
> +		goto remap;
> +
> +	dec_mm_counter(vma->vm_mm, MM_ANONPAGES);
> +	folio_remove_rmap_pte(folio, fw->page, vma);
> +	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
> +	     folio_trylock(folio)) {
> +		folio_free_swap(folio);
> +		folio_unlock(folio);
> +	}
> +	folio_put(folio);

hi,
it's probably ok and I'm missing something, but why do we call folio_put
in here, I'd think it's done by folio_put call in uprobe_write_opcode

thanks,
jirka


> +
> +	return pmd_mappable;
> +remap:
> +	/*
> +	 * Make sure that our copy_to_page() changes become visible before the
> +	 * set_pte_at() write.
> +	 */
> +	smp_wmb();
> +	/* We modified the page. Make sure to mark the PTE dirty. */
> +	set_pte_at(vma->vm_mm, vaddr, fw->ptep, pte_mkdirty(fw->pte));
> +	return 0;
> +}
> +
>  /*
>   * NOTE:
>   * Expect the breakpoint instruction to be the smallest size instruction for
> @@ -475,116 +480,115 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>   * uprobe_write_opcode - write the opcode at a given virtual address.
>   * @auprobe: arch specific probepoint information.
>   * @vma: the probed virtual memory area.
> - * @vaddr: the virtual address to store the opcode.
> - * @opcode: opcode to be written at @vaddr.
> + * @opcode_vaddr: the virtual address to store the opcode.
> + * @opcode: opcode to be written at @opcode_vaddr.
>   *
>   * Called with mm->mmap_lock held for read or write.
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> -		unsigned long vaddr, uprobe_opcode_t opcode)
> +		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
>  {
> +	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct uprobe *uprobe;
> -	struct page *old_page, *new_page;
>  	int ret, is_register, ref_ctr_updated = 0;
> -	bool orig_page_huge = false;
>  	unsigned int gup_flags = FOLL_FORCE;
> +	struct mmu_notifier_range range;
> +	struct folio_walk fw;
> +	struct folio *folio;
> +	struct page *page;
>  
>  	is_register = is_swbp_insn(&opcode);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
>  
> -retry:
> +	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
> +		return -EINVAL;
> +
> +	/*
> +	 * When registering, we have to break COW to get an exclusive anonymous
> +	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
> +	 * fault if required. When unregistering, we might be lucky and the
> +	 * anon page is already gone. So defer write faults until really
> +	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
> +	 * cannot deal with PMDs yet.
> +	 */
>  	if (is_register)
> -		gup_flags |= FOLL_SPLIT_PMD;
> -	/* Read the page with vaddr into memory */
> -	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &old_page, NULL);
> -	if (ret != 1)
> -		return ret;
> +		gup_flags |= FOLL_WRITE | FOLL_SPLIT_PMD;
>  
> -	ret = verify_opcode(old_page, vaddr, &opcode);
> +retry:
> +	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &page, NULL);
>  	if (ret <= 0)
> -		goto put_old;
> -
> -	if (is_zero_page(old_page)) {
> -		ret = -EINVAL;
> -		goto put_old;
> -	}
> +		goto out;
> +	folio = page_folio(page);
>  
> -	if (WARN(!is_register && PageCompound(old_page),
> -		 "uprobe unregister should never work on compound page\n")) {
> -		ret = -EINVAL;
> -		goto put_old;
> +	ret = verify_opcode(page, opcode_vaddr, &opcode);
> +	if (ret <= 0) {
> +		folio_put(folio);
> +		goto out;
>  	}
>  
>  	/* We are going to replace instruction, update ref_ctr. */
>  	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
>  		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
> -		if (ret)
> -			goto put_old;
> +		if (ret) {
> +			folio_put(folio);
> +			goto out;
> +		}
>  
>  		ref_ctr_updated = 1;
>  	}
>  
>  	ret = 0;
> -	if (!is_register && !PageAnon(old_page))
> -		goto put_old;
> -
> -	ret = anon_vma_prepare(vma);
> -	if (ret)
> -		goto put_old;
> -
> -	ret = -ENOMEM;
> -	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vaddr);
> -	if (!new_page)
> -		goto put_old;
> -
> -	__SetPageUptodate(new_page);
> -	copy_highpage(new_page, old_page);
> -	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> +	if (unlikely(!folio_test_anon(folio))) {
> +		VM_WARN_ON_ONCE(is_register);
> +		folio_put(folio);
> +		goto out;
> +	}
>  
>  	if (!is_register) {
> -		struct page *orig_page;
> -		pgoff_t index;
> -
> -		VM_BUG_ON_PAGE(!PageAnon(old_page), old_page);
> -
> -		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
> -		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
> -					  index);
> -
> -		if (orig_page) {
> -			if (PageUptodate(orig_page) &&
> -			    pages_identical(new_page, orig_page)) {
> -				/* let go new_page */
> -				put_page(new_page);
> -				new_page = NULL;
> -
> -				if (PageCompound(orig_page))
> -					orig_page_huge = true;
> -			}
> -			put_page(orig_page);
> -		}
> +		/*
> +		 * In the common case, we'll be able to zap the page when
> +		 * unregistering. So trigger MMU notifiers now, as we won't
> +		 * be able to do it under PTL.
> +		 */
> +		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> +					vaddr, vaddr + PAGE_SIZE);
> +		mmu_notifier_invalidate_range_start(&range);
> +	}
> +
> +	ret = -EAGAIN;
> +	/* Walk the page tables again, to perform the actual update. */
> +	if (folio_walk_start(&fw, vma, vaddr, 0)) {
> +		if (fw.page == page)
> +			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr, opcode);
> +		folio_walk_end(&fw, vma);
>  	}
>  
> -	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
> -	if (new_page)
> -		put_page(new_page);
> -put_old:
> -	put_page(old_page);
> +	if (!is_register)
> +		mmu_notifier_invalidate_range_end(&range);
>  
> -	if (unlikely(ret == -EAGAIN))
> +	folio_put(folio);
> +	switch (ret) {
> +	case -EFAULT:
> +		gup_flags |= FOLL_WRITE | FOLL_SPLIT_PMD;
> +		fallthrough;
> +	case -EAGAIN:
>  		goto retry;
> +	default:
> +		break;
> +	}
>  
> +out:
>  	/* Revert back reference counter if instruction update failed. */
> -	if (ret && is_register && ref_ctr_updated)
> +	if (ret < 0 && is_register && ref_ctr_updated)
>  		update_ref_ctr(uprobe, mm, -1);
>  
>  	/* try collapse pmd for compound page */
> -	if (!ret && orig_page_huge)
> +	if (ret > 0)
>  		collapse_pte_mapped_thp(mm, vaddr, false);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  /**
> -- 
> 2.48.1
> 
