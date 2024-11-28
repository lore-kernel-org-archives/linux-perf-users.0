Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A113B7BC
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799314; cv=none; b=cpFejNaLk5E2rKAbFiNgpbU2nFALJ9wHMrIn2t8XXuHvRwjksxSP6iNQu1fNt/g0zYvSHbivUktDCrcRJasKoCuJOM8RznX4VrL+ehAMWglSDoAKYBWmAZTH/kuGiH08cKHoYNR24CEaMR9Q9AyvKWLx+g1P+Pst03AXzWcapnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799314; c=relaxed/simple;
	bh=rnj6Sd9X9TxLIyhUGfzslyLH2XT3+uXRMDmSY7rfinE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJuOeFT81c1V68cmx2AvFoVXcj3ElVzJeyzpyNGNmw5eR3mg/8UmfnVVhPZIcN9Ss2TkpoAoVXPZw0/cBNkFcNTRLxweS7POrdYqSM6p97M6oxpYHGlsrFf/Rq8deyYzt9j3fLbsuuieEWdyx7o+Twca9vzZhpq4rJ039npGu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASdgX+4D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASdgX+4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732799311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6WVLrMW4PgfFUurlgLPd9Tg1Y80e1mcQMpUaoH4fb9Y=;
	b=ASdgX+4DRPeHf953Yv+qrVLgS7bA1LMAMMJDlV42qkOlYeCXJVLzGwgML0wPFdJ342XR/g
	Te5X/5wGM+jFurWAG7+tTMjEsubG8iELlpZjcsVInsfLb1uxNlS2s6BK4uDRm+NYM6byuY
	lOFM1jHZoX25fT2U7/zRZSxxbgIAcKk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-jwyntw2xPdKDi0e3B1l2mQ-1; Thu, 28 Nov 2024 08:08:30 -0500
X-MC-Unique: jwyntw2xPdKDi0e3B1l2mQ-1
X-Mimecast-MFC-AGG-ID: jwyntw2xPdKDi0e3B1l2mQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso7532675e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799309; x=1733404109;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WVLrMW4PgfFUurlgLPd9Tg1Y80e1mcQMpUaoH4fb9Y=;
        b=QIvEcqK283YJ+HCm+StkNGs1tO57/DRckg6bua/ieGS6jTiFa/9xrnMS6jSGuvWwuM
         CHy120WUY0P3fnQ55LY+HaLQcIZmDV3BS2bfsbfgjRu/UQHCEjWKtBUhqv/NubNz/7zJ
         LbNEpFyC3gjiFegN/CaloxwpJ9+qa9WQHbiApA8fVTzywhgtn3J9QnwC4LkiJ2F5gdLc
         23uawi2NQ/S0SKt1ksi96imfNyvO8++P+apxoJnjq3s743RZg2vmgBzIx8rSHLxIm/Yg
         1HNwkmOwgFtaRfNMnmJsIKmTrnVNiEylkkCkmpHphAR0d73mGWg9tnk8x6vOQkCCzl+e
         Uy4A==
X-Forwarded-Encrypted: i=1; AJvYcCV3ljOZrcSW768jbRNk8W9GXCPrp15OM0i0/pTWGK2ha7ys41icwNyRAUgTBLe4RL+SSHwBdlRkpmZGeUU/PF+I@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2pHXIgJ4nE6/ksNRSrVXMtVN/kbtFXk3N7kkk9J5CRtlUg/f
	l5V3LbI/x8rG+F4hSwWcGN+uWDBygwu4+I1ikW3afqnVxuJHVJX2ENUrRU/2C6Pzgv2NGx9EGOZ
	M+KRp1pMbJqMLfCWehuhX8F0ZzmaNGnL6wDxtHOqCtp/Gr9H1xopWZ2WmhGqI7vYFh5I=
X-Gm-Gg: ASbGncuklGP1KI5Vy7hpTeQgSN5Z8tMg3CwHMM1eY1NZrhYcqBH0MYtt8a42Vxk2sl6
	zeo16q6XkM7mSHTqyKj7k8lHpfPt9kSjV1nL16lNKckXElDvsQqv0VxCTe14nY2uElBA+i84IbS
	RN3ntMB11yYTOj6/jdYxHB8oIY4zynbrfKsp98V041pdrZEctHbE4HN6J/DlRvkRm8qUA+5s85O
	WdrGfTqardmhAqh1rWIvF2gon0vND13hcQh6QUJuRAePrByOWqpF9uKnXVKYtidj22b62XpFRSh
	SOMKdoj+6a6vS8dimwunvTPwKzegb3C/Y2cLqO8xHYY4yFGckgVgoM4AZeg+LadPrMOe44lNUDY
	=
X-Received: by 2002:a05:600c:4686:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434a9dc3030mr74568565e9.8.1732799309618;
        Thu, 28 Nov 2024 05:08:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYU2FIWFdBgjrp3Pqs3E01oigMpUF7ykjhtFFQMA7mQkYi/Kd3ajnsobPltJT21a/3mX9/Aw==
X-Received: by 2002:a05:600c:4686:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434a9dc3030mr74568165e9.8.1732799309201;
        Thu, 28 Nov 2024 05:08:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm54103115e9.9.2024.11.28.05.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 05:08:28 -0800 (PST)
Message-ID: <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
Date: Thu, 28 Nov 2024 14:08:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 12:37, Lorenzo Stoakes wrote:
> We are current refactoring struct page to make it smaller, removing
> unneeded fields that correctly belong to struct folio.
> 
> Two of those fields are page->index and page->mapping. Perf is currently
> making use of both of these, so this patch removes this usage as it turns
> out it is unnecessary.
> 
> Perf establishes its own internally controlled memory-mapped pages using
> vm_ops hooks. The first page in the mapping is the read/write user control
> page, and the rest of the mapping consists of read-only pages.
> 
> The VMA is backed by kernel memory either from the buddy allocator or
> vmalloc depending on configuration. It is intended to be mapped read/write,
> but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
> that it should be mapped read-only.
> 
> When a write fault occurs, the provided page_mkwrite() hook,
> perf_mmap_fault() (doing double duty handing faults as well) uses the
> vmf->pgoff field to determine if this is the first page, allowing for the
> desired read/write first page, read-only rest mapping.
> 
> For this to work the implementation has to carefully work around faulting
> logic. When a page is write-faulted, the fault() hook is called first, then
> its page_mkwrite() hook is called (to allow for dirty tracking in file
> systems).
> 
> On fault we set the folio's mapping in perf_mmap_fault(), this is because
> when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
> as an indicator that the fault should be retried.
> 
> We also set the folio's index so, given the folio is being treated as faux
> user memory, it correctly references its offset within the VMA.
> 
> This explains why the mapping and index fields are used - but it's not
> necessary.
> 
> We preallocate pages when perf_mmap() is called for the first time via
> rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
> needed if the mapping requires it.
> 
> This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
> and so we can instead simply map all the memory right away here - there's
> no point in handling (read) page faults when we don't demand page nor need
> to be notified about them (perf does not).
> 
> This patch therefore changes this logic to map everything when the mmap()
> hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
> to provide the required read/write vs. read-only behaviour, which does not
> require the previously implemented workarounds.
> 
> It makes sense semantically to establish a PFN map too - we are managing
> the pages internally and so it is appropriate to mark this as a special
> mapping.

It's rather sad seeing more PFNMAP users where PFNMAP is not really 
required (-> this is struct page backed).

Especially having to perform several independent remap_pfn_range() calls 
rather looks like yet another workaround ...

Would we be able to achieve something comparable with vm_insert_pages(), 
to just map them in advance?

-- 
Cheers,

David / dhildenb

