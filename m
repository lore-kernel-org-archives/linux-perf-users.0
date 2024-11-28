Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D51B4F1C
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801046; cv=none; b=XgjEvtDx6SV8cdcR8fpNFoVy1ArDBLj05Qb0NG6oKyn9Ak37jU5gci+DYsFvKYhHZJRxMFYpX1oy92XgSfn0HH/0z3x1SGYFokEo4fWPEfiliwP7E31htq/SI9RN174f7hZuQU6U02wXL1wdPjy8Z1mEGnAy9hunDL4QklUeao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801046; c=relaxed/simple;
	bh=CbxdvCP5a3QHudxkVW8mvBm1KjY5nLfxNMSlnwbzgI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouJ8mxXJSs1VCgDs+6Bqeq/T06A4TgBoLluFlS/r8ZHBdgr18mdsgGrEAXgXoK1VRTxPDGpKf39FcaazHNIsomDSf+Vm2C8I6ZAJwS1tjT0xVs/EJ1UEka9Ntpfg4bJ+B+D/xlLuY4rcmMHqSd6U8wB9MLHNXcHafjPK/zUWxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgIGcj5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgIGcj5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732801043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o04VFkr20/CH9z+kvj5lbsSa3s1hEKBLK1i56NNGrfg=;
	b=JgIGcj5o5O7gtEGXfsybVxYrIBDkAuFMH81RsqJk80rZ12w517w4/HEJmQ8uAtHojYkR9K
	ocealrJpkV8KdC//cFcaeDaFilM7Yk9JXhVS4qHJZN2/PCqcK1mUwVJ3yNipfa+z0RCuGM
	RQrh0CmVzZKkD3JS1NArGe2JJsHmpak=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-IspnjqENM3mfdAHwzTZPFQ-1; Thu, 28 Nov 2024 08:37:22 -0500
X-MC-Unique: IspnjqENM3mfdAHwzTZPFQ-1
X-Mimecast-MFC-AGG-ID: IspnjqENM3mfdAHwzTZPFQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53ddfdbeeffso567916e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 05:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801041; x=1733405841;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o04VFkr20/CH9z+kvj5lbsSa3s1hEKBLK1i56NNGrfg=;
        b=Vz66tRgSkidT7ASobl0Se+f3kb9Sfork/61JW8JPkHu4bjwteotTPKQ2VfykBU56Aq
         Fs86d2eEc07E625mLaCE9eecLOIa8Jx7kOajPAajv7aHIgiKwypJC15QXnYUa+vSzQ3B
         bkKzszKDBYtGRKq9eeZq4PBO4siXXlaOvF7Kuw7/dnftEGKDd3btBMWsfxqwDAS363s6
         ojeBd+/UXyyIR5sQszSzSbq8fQFG+z8cvdPH1Xg/KOS5m0m9dfLyd4L2NP2U66MxdzYJ
         1wK1Ixn0QRGPBecfJsKxxMPimvubQ31n8XZb4NfUy5AR0btyl486y6woc4KX7yFM/ba6
         rAfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqLJjVfDyCoH1X1Ik3DdSfdqj0+VcoAY/E67wSZGv7oKrRFPJLDr9IMS5r2ajsiLki4qQiLDnhQUWyC9fNC3fZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhEoB5lhtbGvAWp3Yf0TGe0gpiAuqAyjq+eijo8yKGrqPz/gF
	SwNlpEZwkEBK7OImOaUTrJFjxL0wW/E5zcefT/57uGL42TJ1bpRQ8uBmsAVUdKQsWZRqKc8R76+
	U9f15CULKIcs3gCh7NiKER9D8ZDeBVmqPbHw/tzOcU8aQKXcRpDew30W+8piCuPXAUN4=
X-Gm-Gg: ASbGncvzXtWzBsTQPW4Ai6pFLuBroZTI3z9vc+drnOQDF6ll9Z6olWSGfvdoidU2NFg
	anWx8oHcbFj1AQBsXIBBKhBTOYqmIdBiw3VDSGkvHn5EZRBXY9UmDma68DspdTV6/IDjFeLV5zP
	yI3CbQvs+10EI2bU+uuGVO9ON7jNVKbyHSAFZfWV9Wy/Lhu6suryFG0qhWw8YLLBeaU1NyJV4jX
	7ku+XLA5d6r0hO3SxQQxMf8NQTRzdnanPQewjLQLf3+ppLudWE+DDBxZzR4AfQSBztDu/jhIcFI
	6WNxWkp304V4+3FvA4Bb8QWNv1ERbOOGJWggTNHMNWOWsssURzSnJ3KPzGxGqtfelsE3GkeSN28
	=
X-Received: by 2002:a05:6512:3d19:b0:53d:de1b:f961 with SMTP id 2adb3069b0e04-53df00aa17dmr4595477e87.7.1732801040629;
        Thu, 28 Nov 2024 05:37:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlVggOKgnUUDhJhvbO+cgemu4YlM8B4APCzkh/YH3AlJBrHvwswzIp1g0/+LBPdEjMLJA7vg==
X-Received: by 2002:a05:6512:3d19:b0:53d:de1b:f961 with SMTP id 2adb3069b0e04-53df00aa17dmr4595444e87.7.1732801040098;
        Thu, 28 Nov 2024 05:37:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bd06sm22776105e9.3.2024.11.28.05.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 05:37:18 -0800 (PST)
Message-ID: <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
Date: Thu, 28 Nov 2024 14:37:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 14:20, Lorenzo Stoakes wrote:
> On Thu, Nov 28, 2024 at 02:08:27PM +0100, David Hildenbrand wrote:
>> On 28.11.24 12:37, Lorenzo Stoakes wrote:
>>> We are current refactoring struct page to make it smaller, removing
>>> unneeded fields that correctly belong to struct folio.
>>>
>>> Two of those fields are page->index and page->mapping. Perf is currently
>>> making use of both of these, so this patch removes this usage as it turns
>>> out it is unnecessary.
>>>
>>> Perf establishes its own internally controlled memory-mapped pages using
>>> vm_ops hooks. The first page in the mapping is the read/write user control
>>> page, and the rest of the mapping consists of read-only pages.
>>>
>>> The VMA is backed by kernel memory either from the buddy allocator or
>>> vmalloc depending on configuration. It is intended to be mapped read/write,
>>> but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
>>> that it should be mapped read-only.
>>>
>>> When a write fault occurs, the provided page_mkwrite() hook,
>>> perf_mmap_fault() (doing double duty handing faults as well) uses the
>>> vmf->pgoff field to determine if this is the first page, allowing for the
>>> desired read/write first page, read-only rest mapping.
>>>
>>> For this to work the implementation has to carefully work around faulting
>>> logic. When a page is write-faulted, the fault() hook is called first, then
>>> its page_mkwrite() hook is called (to allow for dirty tracking in file
>>> systems).
>>>
>>> On fault we set the folio's mapping in perf_mmap_fault(), this is because
>>> when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
>>> as an indicator that the fault should be retried.
>>>
>>> We also set the folio's index so, given the folio is being treated as faux
>>> user memory, it correctly references its offset within the VMA.
>>>
>>> This explains why the mapping and index fields are used - but it's not
>>> necessary.
>>>
>>> We preallocate pages when perf_mmap() is called for the first time via
>>> rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
>>> needed if the mapping requires it.
>>>
>>> This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
>>> and so we can instead simply map all the memory right away here - there's
>>> no point in handling (read) page faults when we don't demand page nor need
>>> to be notified about them (perf does not).
>>>
>>> This patch therefore changes this logic to map everything when the mmap()
>>> hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
>>> to provide the required read/write vs. read-only behaviour, which does not
>>> require the previously implemented workarounds.
>>>
>>> It makes sense semantically to establish a PFN map too - we are managing
>>> the pages internally and so it is appropriate to mark this as a special
>>> mapping.
>>
>> It's rather sad seeing more PFNMAP users where PFNMAP is not really required
>> (-> this is struct page backed).
>>
>> Especially having to perform several independent remap_pfn_range() calls
>> rather looks like yet another workaround ...
>>
>> Would we be able to achieve something comparable with vm_insert_pages(), to
>> just map them in advance?
> 
> Well, that's the thing, we can't use VM_MIXEDMAP as vm_insert_pages() and
> friends all refer vma->vm_page_prot which is not yet _correctly_ established at
> the point of the f_op->mmap() hook being invoked :)

So all you want is a vm_insert_pages() variant where we can pass in the 
vm_page_prot?

Or a way detect internally that it is not setup yet and fallback to 
vm_get_page_prot(vma->vm_flags & ~VM_SHARED)?

Or a way to just remove write permissions?

> 
> We set the field in __mmap_new_vma(), _but_ importantly, we defer the
> writenotify check to __mmap_complete() (set in vma_set_page_prot()) - so if we
> were to try to map using VM_MIXEDMAP in the f_op->mmap() hook, we'd get
> read/write mappings, which is emphatically not what we want - we want them
> read-only mapped, and for vm_ops->pfn_mkwrite() to be called so we can make the
> first page read/write and the rest read-only.
> 
> It's this requirement that means this is really the only way to do this as far
> as I can tell.
> 
> It is appropriate and correct that this is either a VM_PFNMAP or VM_MIXEDMAP
> mapping, as the pages reference kernel-allocated memory and are managed by perf,
> not put on any LRU, etc.
> 
> It sucks to have to loop like this and it feels like a workaround, which makes
> me wonder if we need a new interface to better allow this stuff on mmap...
> 
> In any case I think this is the most sensible solution currently available that
> avoids the pre-existing situation of pretending the pages are folios but
> somewhat abusing the interface to allow page_mkwrite() to work correctly by
> setting page->index, mapping.

Yes, that page->index stuff is nasty.

> 
> The alternative to this would be to folio-fy, but these are emphatically _not_
> folios, that is userland memory managed as userland memory, it's a mapping onto
> kernel memory exposed to userspace.

Yes, we should even move away from folios completely in the future for 
vm_insert_page().

> 
> It feels like probably VM_MIXEDMAP is a better way of doing it, but you'd need
> to expose an interface that doesn't assume the VMA is already fully set
> up... but I think one for a future series perhaps.

If the solution to your problem is as easy as making vm_insert_pages() 
pass something else than vma->vm_page_prot to insert_pages(), then I 
think we should go for that. Like ... vm_insert_pages_prot().

Observe how we already have vmf_insert_pfn() vs. vmf_insert_pfn_prot(). 
But yes, in an ideal world we'd avoid having temporarily messed up 
vma->vm_page_prot. So we'd then document clearly how 
vm_insert_pages_prot() may be used.

-- 
Cheers,

David / dhildenb

