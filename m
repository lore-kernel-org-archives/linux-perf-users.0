Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864381F03C9
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563040; cv=none; b=OXKa46N7Jjv7XVvKfNLk5y+wiY5tYSlj/gBKV0gtMN708bh2bAszlSDvk0sg4Qx4eB02xfIylisJjX0E7QTwUjgx5C19RFVYpSHVQEbpkltPzgHCLUOpc85VYbZLgjgdDDHsjxILRHgCE8UMRVxSm5kodF2UghnwnQVaZixAw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563040; c=relaxed/simple;
	bh=lazFEoNVF0J8q0AJwAtXuwAMQUaLicT/WeFfRT2SoaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuyW/r8R+UMPDBUNFCkA1h5CR8lXaBjh/gUWZ+ypZsnmEasrl7Ku21yiuFc4T7DjSuH2dvxlkkYuoCn+R81nIKQ3rnTf5VtEvv1ZZemUw0ZOrkuZbKn5o+PqaH/gVU4dJaFhseJNPpjC81Tf9QtfdJH7adhZGG3QF9LoSYUjLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3S2Cpri; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3S2Cpri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742563037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dq3Hj8gPeDCA8YR5G45cntVoKw1hN2KoBbCsLCkkwSo=;
	b=F3S2CpriR1xdy2NFYAJS/80OK7+YibUTyBnAAdQINFzmvaZJyq0fpbqauOL8YWGPxhtkjR
	XBLuPzW6zEzTGqkbQ7g0fjb6wZH1H+ajW/e9XAd+RnYrCBQ6PWKFkdmEknYEFdFdS9PX4t
	oIf3mLZUUWd94EDQY8ZsEXLmKLHzlUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-S6u61_LMPpeiNqXVymLwAQ-1; Fri, 21 Mar 2025 09:17:16 -0400
X-MC-Unique: S6u61_LMPpeiNqXVymLwAQ-1
X-Mimecast-MFC-AGG-ID: S6u61_LMPpeiNqXVymLwAQ_1742563035
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so6336385e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 06:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742563035; x=1743167835;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dq3Hj8gPeDCA8YR5G45cntVoKw1hN2KoBbCsLCkkwSo=;
        b=jWoOsXUXWvu70gkhADgjzYgkrys2I3mssF7XvfJ1WPjV9AOJpXQiozqxEcvRpeD0E9
         afGtcq2TrpzKXF2XshpWNAhoVvEh23jUo7RDxBzogF05FhRook6wnai7X0cKmoLKK4ea
         yu3QcbVZXsiJroen0qYDGDc3bjPj/NENMDNepaYfQxmhipCKjQbHsYLMM/DZojxDlkFj
         jEW5bnxmtXavqmlAidN13Sh7z48WEG/ux35orFYa0zpMJgHuSW7AYzxDcEC22dzUvtW0
         GwRH+yNeTwxh1x8W6JRKu0j3Gkt8NV/lf9Ib46uAiMvz/9kFNlVmzkjTD0irUgW0uwW0
         VGXg==
X-Forwarded-Encrypted: i=1; AJvYcCV995l7gSp5bPEz/igB8KSK090gN+luKjJTekH5x0e+HMLJQg52aonzakQx2F+YRV3EEJxCZM2hQaVSj24Qn/yc@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfEyqNMa/4EpHlj4x+2CewunCIRuOXaXHTnTr927M6QB2gdck
	XzNt6GbXrKgU+22H+3Yz02WANHY4cR8ni92mTPkAh4XwE3hpuLltQpXlJ3/l2mcJOxpVHdefgNx
	5FRXC5/WQ6ckr9bTsOmt9WT205yoveI6JUfM7WL375XnOe5xqxdbwuQwwuDkAyAwu+u0=
X-Gm-Gg: ASbGncvP4m1ejFiYoxiUVMZvsM2+lZBpltCRE0NWqOD4RPbgolG21MeXNJuZVkN+Vbe
	bBGVgyyh/jsEWjKAnBsAjrrnx6F6tN436wEWqHRyCPmNTaouQqxTo/8sFTxeNrEGMAh3tNwnLNA
	wwEEIfa9UytEAhG24wqVbkuWWFnt7LlbSqFYCEKx4h84NGlEnQOb0Yu8LNpnSIBulozAovznc4z
	vxNseSU0QnCHHHcgEWoViWv0/j1uMUgWvDu3VT+/uzbFi58VAm98kUoUU0Z/AGjsGn1h5N0B/ee
	IujjBR80RSAlBs/ocUvz6D5PP9he3FlmptacL7N6UHvs2Gfu4mH6RPnpQMpndwumrAWAIPlHQ4z
	h+cKVCapN0pl3TRUkpJwabkl47ZHi09eQRDvoPxHtDmA=
X-Received: by 2002:a05:600c:1e0d:b0:43c:f689:88ce with SMTP id 5b1f17b1804b1-43d50a1d1b4mr32164215e9.20.1742563034970;
        Fri, 21 Mar 2025 06:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Zz8OTC0SBn9u7TvheCk2N+jYIOaRrdB9xOl+x7aeYutuqY8BRuH9FouxASHDSollfi9sWw==
X-Received: by 2002:a05:600c:1e0d:b0:43c:f689:88ce with SMTP id 5b1f17b1804b1-43d50a1d1b4mr32163515e9.20.1742563034538;
        Fri, 21 Mar 2025 06:17:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47196sm77012285e9.16.2025.03.21.06.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 06:17:14 -0700 (PDT)
Message-ID: <69256f08-1d1c-45ac-945a-495ef4ffc558@redhat.com>
Date: Fri, 21 Mar 2025 14:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250321113713.204682-1-david@redhat.com>
 <20250321113713.204682-4-david@redhat.com> <Z91j_UwNhi2DQB3N@krava>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z91j_UwNhi2DQB3N@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 14:05, Jiri Olsa wrote:
> On Fri, Mar 21, 2025 at 12:37:13PM +0100, David Hildenbrand wrote:
> 
> SNIP
> 
>> +static int __uprobe_write_opcode(struct vm_area_struct *vma,
>> +		struct folio_walk *fw, struct folio *folio,
>> +		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
>> +{
>> +	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
>> +	const bool is_register = !!is_swbp_insn(&opcode);
>> +	bool pmd_mappable;
>> +
>> +	/* For now, we'll only handle PTE-mapped folios. */
>> +	if (fw->level != FW_LEVEL_PTE)
>> +		return -EFAULT;
>> +
>> +	/*
>> +	 * See can_follow_write_pte(): we'd actually prefer a writable PTE here,
>> +	 * but the VMA might not be writable.
>> +	 */
>> +	if (!pte_write(fw->pte)) {
>> +		if (!PageAnonExclusive(fw->page))
>> +			return -EFAULT;
>> +		if (unlikely(userfaultfd_pte_wp(vma, fw->pte)))
>> +			return -EFAULT;
>> +		/* SOFTDIRTY is handled via pte_mkdirty() below. */
>> +	}
>> +
>> +	/*
>> +	 * We'll temporarily unmap the page and flush the TLB, such that we can
>> +	 * modify the page atomically.
>> +	 */
>> +	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
>> +	fw->pte = ptep_clear_flush(vma, vaddr, fw->ptep);
>> +	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>> +
>> +	/*
>> +	 * When unregistering, we may only zap a PTE if uffd is disabled and
>> +	 * there are no unexpected folio references ...
>> +	 */
>> +	if (is_register || userfaultfd_missing(vma) ||
>> +	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
>> +	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
>> +		goto remap;
>> +
>> +	/*
>> +	 * ... and the mapped page is identical to the original page that
>> +	 * would get faulted in on next access.
>> +	 */
>> +	if (!orig_page_is_identical(vma, vaddr, fw->page, &pmd_mappable))
>> +		goto remap;
>> +
>> +	dec_mm_counter(vma->vm_mm, MM_ANONPAGES);
>> +	folio_remove_rmap_pte(folio, fw->page, vma);
>> +	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
>> +	     folio_trylock(folio)) {
>> +		folio_free_swap(folio);
>> +		folio_unlock(folio);
>> +	}
>> +	folio_put(folio);
> 
> hi,
> it's probably ok and I'm missing something, but why do we call folio_put
> in here, I'd think it's done by folio_put call in uprobe_write_opcode

Hi!

We're zapping a page table mapping mapping (folio_remove_rmap_pte()), so 
we have to drop that reference.

That's the folio_put(old_folio) in the old __replace_page().

Thanks!

-- 
Cheers,

David / dhildenb

