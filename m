Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E819C569
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882386; cv=none; b=LpnPvuzndcHCLhKNkXPofOxOtuXDl1GUuD/WgIHjTx4nYyBQyccXZd6nuohssWL1Rn6zDWKlI35GmyEBkpy2km6HglsOKGCQz4pf1UB5t6LS1RbWQw30D+P7+tW9566brGXcIXxXx0ShtuI/3hbvgNiblw0cc/mQlqkvCe+j3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882386; c=relaxed/simple;
	bh=gjVPU9MmSkktEpTzOzFCfC2aJAumehiLpU5KC/Lr1sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujDgy+RerQ8sv0JONa9eLtPg1r0OwjuoJjxka9nFwbW6IrIxAbSjAPo9n6LJmo5pnQyBEmxlnk8KCXIbu4ZnaYYcKIPj8S8oxzSI1lzte5ggLENLCd9gykQ/7tpLNPRntyiADj3J+y4fNrtOdBa95Hwstkmxa0AJc5INbzhyKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOmtwDMR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOmtwDMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732882383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9dCwHB55kEGMY51zkm3mI/OoeuT8MnmZOigkcUSwHn4=;
	b=HOmtwDMRBudP4vDn8aT6HQ+n7H6EQbC7U3WWIwRilm+CH+HnXzfwsHjF8sGG0z1oppK7oB
	ZXEQJBFeWRaVHimjuZQKNObQuXXl2SQcZQtlcrVtIA2ZBgoQNaIvrof9rkqg9klXTnhaxI
	8gxllxLWLPSk97I73pkImFOXYeX4YCs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-RaFg1UgHNZ6bAK2VOASEcw-1; Fri, 29 Nov 2024 07:13:02 -0500
X-MC-Unique: RaFg1UgHNZ6bAK2VOASEcw-1
X-Mimecast-MFC-AGG-ID: RaFg1UgHNZ6bAK2VOASEcw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d4fa8e19so711886f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 04:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732882381; x=1733487181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9dCwHB55kEGMY51zkm3mI/OoeuT8MnmZOigkcUSwHn4=;
        b=vUv3D9KM+ZY1yb2FW0KMSE3mwfZqIJYFVVfC+5+kxANVXPNhJpiOS0hs9O6mHf2LKM
         m59tE3sFL/Ermya20wtDmwqGHWCCJi1iyBAX0A78N1hoYQ730fEymY46TN1P0n1qgwib
         WlGqc5xd3I/gEhHeNY8szNGCa9NWnORBCyhmUv6Urz5n6Sh/UyJEAK0+C8Z193OzOdCZ
         cQ8y9+JHn+RhCjy8CprdIRGaMb6qzBxVnFY9ZIxazpiJuyuJojuAevgH7eb+kQUpT+Zg
         g1yhAPp0B2WfvZV55T4ry+iuKUWEV13lVgVU/e7ODVQjbVOUS63tLUozZVoxO/BvRKpJ
         Zgvw==
X-Forwarded-Encrypted: i=1; AJvYcCWPCCLLbWdXNNnSkCeQyhebw/VQWr4H9WZbvs9aObH3rD1L+EvXsjiOtuq2aGb+YUfaZLalHzfyti8iissR89pm@vger.kernel.org
X-Gm-Message-State: AOJu0YzobrbkXrfiBS+soL6Nu2SEfPnMBPapICnpuHh2lBMuAf7cBXW3
	JyjlRsxnmIjjUpYRFQJnrlt+1/YPoqpPc9umRj6T0UqjZ4+zbAf074N56IoqlsAvZR3EqOgsGua
	pAcdjEXXI1JReUZGRxof3DBrIvblnsIqlXl5NRktg00+C6VruEu/IXIT6Nn4Z782kQ7k=
X-Gm-Gg: ASbGnct/hHjfq8T6hlHtK9avLQQEWT4/gmZCo6wU83m/C8C1Gp6wsW+QDIU6GD2aLhY
	nvJmyoOvuXQPoA8G1hu3qTCJFFZB97KuMhl8Y5cMBu/KOFG71Zc637W9xbA3gug+Q3r+NZyBiQs
	f+bSu4ZN/JZmtLnEjMeTfmrNJrxdXw4B3jf9MaVquvh8xzUUch9qca26mqIKhppDhWqjVWmGkyb
	lrIF249/mNBc3cwyJ9AYq4w6k6Jvmq+DTzCzyGPvAGvO3QXRb5zznj3guR+R6pbiPP2gPRlCUHL
	Sh0OyPPGyfmLQ1wfWGwgrMMUQZ+IXXBTRBfKuShO+wddxV9xVF+52aUGcND6z9YAWPanOk5AiRO
	PIw==
X-Received: by 2002:a5d:64ac:0:b0:382:4421:811a with SMTP id ffacd0b85a97d-385c6ef3978mr9554017f8f.49.1732882380639;
        Fri, 29 Nov 2024 04:13:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqm8ytnWuv05ZY06Ef0Fh9n4A7hRpCvVYueyB/Ni5Gj7Yi4MQqn0a4BAGfNg0zZYNRqa5RJA==
X-Received: by 2002:a5d:64ac:0:b0:382:4421:811a with SMTP id ffacd0b85a97d-385c6ef3978mr9553975f8f.49.1732882380153;
        Fri, 29 Nov 2024 04:13:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a7aesm4290556f8f.59.2024.11.29.04.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 04:12:59 -0800 (PST)
Message-ID: <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
Date: Fri, 29 Nov 2024 13:12:57 +0100
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
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 15:23, Lorenzo Stoakes wrote:
> On Thu, Nov 28, 2024 at 02:37:17PM +0100, David Hildenbrand wrote:
>> On 28.11.24 14:20, Lorenzo Stoakes wrote:
>>> On Thu, Nov 28, 2024 at 02:08:27PM +0100, David Hildenbrand wrote:
>>>> On 28.11.24 12:37, Lorenzo Stoakes wrote:
> [snip]
>>>>> It makes sense semantically to establish a PFN map too - we are managing
>>>>> the pages internally and so it is appropriate to mark this as a special
>>>>> mapping.
>>>>
>>>> It's rather sad seeing more PFNMAP users where PFNMAP is not really required
>>>> (-> this is struct page backed).
>>>>
>>>> Especially having to perform several independent remap_pfn_range() calls
>>>> rather looks like yet another workaround ...
>>>>
>>>> Would we be able to achieve something comparable with vm_insert_pages(), to
>>>> just map them in advance?
>>>
>>> Well, that's the thing, we can't use VM_MIXEDMAP as vm_insert_pages() and
>>> friends all refer vma->vm_page_prot which is not yet _correctly_ established at
>>> the point of the f_op->mmap() hook being invoked :)
>>
>> So all you want is a vm_insert_pages() variant where we can pass in the
>> vm_page_prot?
> 
> Hmm, looking into the code I don't think VM_MIXEDMAP is correct after all.
> 
> We don't want these pages touched at all, we manage them ourselves, and
> VM_MIXEDMAP, unless mapping memory mapped I/O pages, will treat them as such.
> 
> For instance, vm_insert_page() -> insert_page() -> insert_page_into_pte_locked()
> acts as if this is a folio, manipulating the ref count and invoking
> folio_add_file_rmap_pte() - which we emphatically do not want.

Right, but that should be independent of what you want to achieve in 
this series, or am I wrong?

vm_insert_page()/vm_insert_pages() is our mechanism to install kernel 
allocations into the page tables. (note "kernel allocations", not 
"kernel memory", which might or might not have "struct pages")

There is the bigger question how we could convert all users to either 
(a) not refcount + mapcount (and we discussed a separate memdesc type 
for that) (b) still refcount (similarly, likely separate memdesc).

But that will be a problem to be solved by all similar drives.

Slapping in a remap_pfn_range() + VM_PFNMAP in now in the absence of 
having solved the bigger problem there sounds quite suboptimal to me. 
remap_pfn_range() saw sufficient abuse already, and the way we hacked in 
VM_PAT handling in there really makes it something we don't want to 
reuse as is when trying to come up with a clean way to map kernel 
allocations. I strongly assume that some of the remap_pfn_range() users 
we currently have do actually deal with kernel allocations as well, and 
likely they should all get converted to something better once we have it.


So, isn't this something to just solve independently of what you are 
actually trying to achieve in this series (page->index and page->mapping)?

[...]


>>>
>>> We set the field in __mmap_new_vma(), _but_ importantly, we defer the
>>> writenotify check to __mmap_complete() (set in vma_set_page_prot()) - so if we
>>> were to try to map using VM_MIXEDMAP in the f_op->mmap() hook, we'd get
>>> read/write mappings, which is emphatically not what we want - we want them
>>> read-only mapped, and for vm_ops->pfn_mkwrite() to be called so we can make the
>>> first page read/write and the rest read-only.
>>>
>>> It's this requirement that means this is really the only way to do this as far
>>> as I can tell.
>>>
>>> It is appropriate and correct that this is either a VM_PFNMAP or VM_MIXEDMAP
>>> mapping, as the pages reference kernel-allocated memory and are managed by perf,
>>> not put on any LRU, etc.
>>>
>>> It sucks to have to loop like this and it feels like a workaround, which makes
>>> me wonder if we need a new interface to better allow this stuff on mmap...
>>>
>>> In any case I think this is the most sensible solution currently available that
>>> avoids the pre-existing situation of pretending the pages are folios but
>>> somewhat abusing the interface to allow page_mkwrite() to work correctly by
>>> setting page->index, mapping.
>>
>> Yes, that page->index stuff is nasty.
> 
> It's the ->mapping that is more of the issue I think, as that _has_ to be set in
> the original version, I can't actually see why index _must_ be set, there should
> be no case in which rmap is used on the page, so possibly was a mistake, but
> both fields are going from struct page so both must be eliminated :)

:) Yes.

>>> The alternative to this would be to folio-fy, but these are emphatically _not_
>>> folios, that is userland memory managed as userland memory, it's a mapping onto
>>> kernel memory exposed to userspace.
>>
>> Yes, we should even move away from folios completely in the future for
>> vm_insert_page().
> 
> Well, isn't VM_MIXEDMAP intended specifically so you can mix normal user pages
> that live in the LRU and have an rmap etc. etc. with PFN mappings to I/O mapped
> memory? :) so then that's folios + raw PFN's.

VM_MIXEDMAP was abused over the years for all kinds of stuff. I consider 
this rather a current "side effect" of using vm_insert_pages() than 
something we'll need in the long term (below).

> 
>>
>>>
>>> It feels like probably VM_MIXEDMAP is a better way of doing it, but you'd need
>>> to expose an interface that doesn't assume the VMA is already fully set
>>> up... but I think one for a future series perhaps.
>>
>> If the solution to your problem is as easy as making vm_insert_pages() pass
>> something else than vma->vm_page_prot to insert_pages(), then I think we
>> should go for that. Like ... vm_insert_pages_prot().
> 
> Sadly no for reasons above.

Is the reason "refcount+mapcount"? Then it might be a problem better 
tackled separately as raised above. Sorry if I missed another point.

> 
>>
>> Observe how we already have vmf_insert_pfn() vs. vmf_insert_pfn_prot(). But
>> yes, in an ideal world we'd avoid having temporarily messed up
>> vma->vm_page_prot. So we'd then document clearly how vm_insert_pages_prot()
>> may be used.
> 
> I think the thing with the delay in setting vma->vm_page_prot properly that is
> we have a chicken and egg scenario (oh so often the case in mmap_region()
> logic...) in that the mmap hook might change some of these flags which changes
> what that function will do...

Yes, that's ugly.

> 
> I was discussing with Liam recently how perhaps we should see how feasible it is
> to do away with this hook and replace it with something where drivers specify
> which VMA flags they want to set _ahead of time_, since this really is the only
> thing they should be changing other than vma->vm_private_data.

Yes.

> 
> Then we could possibly have a hook _only_ for assigning vma->vm_private_data to
> allow for any driver-specific init logic and doing mappings, and hey presto we
> have made things vastly saner. Could perhaps pass a const struct vm_area_struct
> * to make this clear...
> 
> But I may be missing some weird corner cases (hey probably am) or being too
> optimistic :>)

It's certainly one area we should be cleaning up ...

> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> I wonder if we need a new interface then for 'pages which we don't want touched
> but do have a struct page' that is more expressed by the interface than
> remap_pfn_range() expresses.
> 
> I mean from the comment around vm_normal_page():
> 
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
>   * case, NULL is returned here. "Normal" mappings do have a struct page.
> 
> ...
> 
>   * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
>   * special mapping (even if there are underlying and valid "struct pages").
>   * COWed pages of a VM_PFNMAP are always normal.
> 
> So there's precedence for us just putting pages we allocate/manage ourselves in
> a VM_PFNMAP.
> 
> So I guess this interface would be something like:
> 
> 	int remap_kernel_pages(struct vm_area_struct *vma, unsigned long addr,
> 			       struct page **pages, unsigned long size,
> 			       pgprot_t prot);
> 


Well, I think we simply will want vm_insert_pages_prot() that stops 
treating these things like folios :) . *likely*  we'd want a distinct 
memdesc/type.

We could start that work right now by making some user (iouring, 
ring_buffer) set a new page->_type, and checking that in 
vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the 
refcount and the mapcount.

Because then, we can just make all the relevant drivers set the type, 
refuse in vm_insert_pages_prot() anything that doesn't have the type 
set, and refuse in vm_normal_page() any pages with this memdesc.

Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of 
these things will stop working, I hope that is not a problem.


There is one question is still had for a long time: maybe we *do* want 
to refcount these kernel allocations. When refcounting them, it's 
impossible that we might free them in our driver without having some 
reference lurking somewhere in some page table of a process. I would 
hope that this is being take care of differently. (e.g., VMA lifetime)


But again, I'd hope this is something we can sort out independent of 
this series.

-- 
Cheers,

David / dhildenb

