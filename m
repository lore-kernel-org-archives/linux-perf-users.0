Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937119C566
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886673; cv=none; b=ODA3Ju+Re0m6b2ARSIZcaiOhzn2F79UlVLb4vubGbywUbtaIMCJyeM3g2crjNnwTN/VZAlDA+FHAf/5+4p1hConZqKnjfdxK9WWYRbETbey0wrXOwFadULyfkFq81mq6QCv0dE2SZ+42j6Qm6M7vFJ8D6UNMkzm8dziJATe3klY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886673; c=relaxed/simple;
	bh=Lh3wm/Y49FW/5Br6sAAGCXa8r7vzGq2aHfYVLCjVaqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsDfLjh0qSalSNSFMtVeI8eLKrgYNrpwgLfR8Vst2wVBYSyG5CDn1zs/B6BBrKMWD4LTGa2553Gob8rgTaKPKDu/QGT5BkN+zGzgFMJpdUQY4VbzLirbA9DhI57M21pubxOqDpUdlAgN3FP9ks/LDfclq39455qJVzxUkJlcbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ecmx/PLi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ecmx/PLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732886670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nU/jhm6YJGAWyK6WiBgAqwh22b8bPeKCDvr+ExJWlOQ=;
	b=Ecmx/PLilYe0qbsQZ9JFpfv81jx3yIq4CamFELgtMj8IT08jMrG6k63VpB4OJ2YOuMf7tU
	L3r2qlfPJqqRhyUdH6CgTaTkl83p+Z6CzpZqlq2HrfwL22iIGDIePXDnc+mPA52Glqa9cU
	exY7X/TRdJxddpPr80XnUEJ3Nt2ogOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-aFzmlUg2MnevmXQwhlxwEg-1; Fri, 29 Nov 2024 08:24:29 -0500
X-MC-Unique: aFzmlUg2MnevmXQwhlxwEg-1
X-Mimecast-MFC-AGG-ID: aFzmlUg2MnevmXQwhlxwEg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d123aa38so818694f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 05:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886668; x=1733491468;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nU/jhm6YJGAWyK6WiBgAqwh22b8bPeKCDvr+ExJWlOQ=;
        b=QlMYBRNP7/R0bz+GMgqwE6PkTj5/QR/bTTjfefUsI873xrk9Qrll49IIYOgNxAtqEe
         5lI0z2WBOxwjFL/64OcLPDBsZEKkkRhkaDd+gSuTtL8yk7Fz0PCNZjX+9I+9BLybScmL
         kK2m1U2lM8LlUScBTWsBdnzA/1W4Zlok569ahRorngwhDAecJPBUwolFjH+Z1ERG3Gwo
         ai2bUIvr1ztY9ShLWBrVqf+RHkIBb57fDYvybkbuHRAYaV/A70/e5VSyehoQasWwH2oX
         QU+2gdc+/5MUgh7s8vPqnAJJ4s6OBI6oIQUVjWnCfE1xnUtt8fI3m7tsldXTod+9m76o
         Q/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBYWnE72Rj/lUAuKPc0nYgBwWgT9PVc4xM+fQ1cQc5Wrax4AAJc2wIryr7yy/M/eS8V7+BEpRQ/5aY5+0y0TDG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7MtQWyikN9I2P0r5a3FZXwq4TQUhOlMeA7cVCk32Vq0kfGHg
	AT2ydlnLl9totGqsXG+5Skxd4twQZGHu1qVkvUgWOfJ0cgEqLxtbbyctBynbDKRCkNYYhhYEpZ8
	ENhxhSESiJekjGmLCi9E6EnE4Hw+2mDPNjD63rNtRprDstwzAqp72dbv9l/MJzxy+z6Q=
X-Gm-Gg: ASbGncvXz9vs1RSzpq0xZMBfNNVFR/zH66tyy3wxj27hH2BWSaCrt/80DtwBE0+6m3J
	8uBDLo96fGtx/gbv0puuRH/BjHca/GGTjjGScNZ22GLqVPirn1wXIAHWqKEOULfTrI019/4Fy6J
	ok51iCLM+K96ncOaqKDGhlYXyvTqfHR0CHHAR1IDNPVb6sDgAjwDKnFcKW+fvYIi46f5umq43Wn
	smZZ/kpVi56c4916DT/sg+l1FcE7MnSEcFjLGw894PjcusKWx2v5WXeywvaA7gJ1b/28eNXloXH
	h+oaEyJHH2bZS4BePTFZaPKi1KWrGCeYS3yv5b9yYzn9TmBNZbH807fOp9Lu1eN2GXKuT6A6o8M
	ZrA==
X-Received: by 2002:a05:6000:4009:b0:37d:4ef1:1820 with SMTP id ffacd0b85a97d-385c6edb1c4mr9170067f8f.40.1732886668045;
        Fri, 29 Nov 2024 05:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLKDmL48MsT1X5+ui/hTCh0Qw8COAwExjjwUMjnOm7abKhFVTHpkYAEIWAlS1RhZN754RaxA==
X-Received: by 2002:a05:6000:4009:b0:37d:4ef1:1820 with SMTP id ffacd0b85a97d-385c6edb1c4mr9170033f8f.40.1732886667610;
        Fri, 29 Nov 2024 05:24:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e17574ebsm129495f8f.30.2024.11.29.05.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:24:26 -0800 (PST)
Message-ID: <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
Date: Fri, 29 Nov 2024 14:24:24 +0100
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
References: <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 14:19, Lorenzo Stoakes wrote:
> On Fri, Nov 29, 2024 at 02:12:23PM +0100, David Hildenbrand wrote:
>> On 29.11.24 14:02, Lorenzo Stoakes wrote:
>>> On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
>>>> On 29.11.24 13:55, Lorenzo Stoakes wrote:
>>>>> On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
>>>>>> On 29.11.24 13:26, Peter Zijlstra wrote:
>>>>>>> On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
>>>>>>>
>>>>>>>> Well, I think we simply will want vm_insert_pages_prot() that stops treating
>>>>>>>> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>>>>>>>>
>>>>>>>> We could start that work right now by making some user (iouring,
>>>>>>>> ring_buffer) set a new page->_type, and checking that in
>>>>>>>> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
>>>>>>>> and the mapcount.
>>>>>>>>
>>>>>>>> Because then, we can just make all the relevant drivers set the type, refuse
>>>>>>>> in vm_insert_pages_prot() anything that doesn't have the type set, and
>>>>>>>> refuse in vm_normal_page() any pages with this memdesc.
>>>>>>>>
>>>>>>>> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
>>>>>>>> these things will stop working, I hope that is not a problem.
>>>>>>>
>>>>>>> Well... perf-tool likes to call write() upon these pages in order to
>>>>>>> write out the data from the mmap() into a file.
>>>>>
>>>>> I'm confused about what you mean, write() using the fd should work fine, how
>>>>> would they interact with the mmap? I mean be making a silly mistake here
>>>>
>>>> write() to file from the mmap()'ed address range to *some* file.
>>>>
>>>
>>> Yeah sorry my brain melted down briefly, for some reason was thinking of read()
>>> writing into the buffer...
>>>
>>>> This will GUP the pages you inserted.
>>>>
>>>> GUP does not work on PFNMAP.
>>>
>>> Well it _does_ if struct page **pages is set to NULL :)
>>
>> Hm? :)
>>
>> check_vma_flags() unconditionally refuses VM_PFNMAP.
> 
> Ha, funny with my name all over git blame there... ok yup missed this, the
> vm_normal_page() == NULL stuff must but for mixed map (and those other weird
> cases I think you can get0...
> 
> Well good. Where is write() invoking GUP? I'm kind of surprised it's not just
> using uaccess?
> 
> One thing to note is I did run all the perf tests with no issues whatsoever. You
> would _think_ this would have come up...
> 
> I'm editing some test code to explicitly write() from the buffer anyway to see.
> 
> If we can't do pfnmap, and we definitely can't do mixedmap (because it's
> basically entirely equivalent in every way to just faulting in the pages as
> before and requires the same hacks) then I will have to go back to the drawing
> board or somehow change the faulting code.
> 
> This really sucks.
> 
> I'm not quite sure I even understand why we don't allow GUP used _just for
> pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
> whatever mapped it will maintain the lifetime.
> 
> What a mess...

Because VM_PFNMAP is dangerous as hell. To get a feeling for that (and also why I
raised my refcounting comment earlier) just read recent:

commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Sep 11 17:11:23 2024 -0700

     mm: avoid leaving partial pfn mappings around in error case
     
     As Jann points out, PFN mappings are special, because unlike normal
     memory mappings, there is no lifetime information associated with the
     mapping - it is just a raw mapping of PFNs with no reference counting of
     a 'struct page'.


GUP relies on the refcount. In a PFNMAP you don't have any way to make sure the
driver won't go down, free the page, to have it used by someone else while IO is still
happening to that page.

-- 
Cheers,

David / dhildenb

