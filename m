Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957B1A9B4C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867044; cv=none; b=TI1XHc3aIB0li44obi40q5psXAPctTNwahcsX2Zkz36MrGZWWIxbdT59IsOHxMwajVp/DaDffBbcwzBHv1DkPC+4kVCWRCq10sbq94VTsEXDeWlBbzVow/RTuOnjTurnkGbqDHZdxvUjgDGETdW6UFpL4Ywe4unPqCyhTtwsJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867044; c=relaxed/simple;
	bh=GUrF2UrU0XGgUzb6wTe5TrC047ereMAOApbFsLOhx2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyCib+bytvhA8okhzP26R/mszsKmkUXEOxRfk0LQE9SlQ2KbfAY8fny2Vc1duAG2u8GMESczxBhmHOUBqCjwvDK3LSUw4cJnMNhxwj2BINGtbpan9QFciWH6eAGz9CsPuI8yGL4Vsphu6SkB6ayONt+HQok0lBhv2LEqkhrC7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOTwhkAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOTwhkAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733867041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tP1MjT4qda+yWrKqxPuVRXu+p9J5U29ZhaYXhXN3XqQ=;
	b=AOTwhkAcri/qfJudHciU3SxB3Jw952eZWbQHEs1vjcDysy31D8a6a9EjlxnFi4QHKZJJq4
	4W4hf3Fgc364SY/Lzquq0q6X/pSygyf5RHYTSBvPQIp+5NgBLfxVHuFmvV5BYDOpjwnuvE
	GUfOP9Ty3MvCUP3JhtBdF2klFXZIrNE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-L6b_xdjJM7idqp_U4MWTFQ-1; Tue, 10 Dec 2024 16:44:00 -0500
X-MC-Unique: L6b_xdjJM7idqp_U4MWTFQ-1
X-Mimecast-MFC-AGG-ID: L6b_xdjJM7idqp_U4MWTFQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-386321c8f4bso2193412f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 13:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733867039; x=1734471839;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tP1MjT4qda+yWrKqxPuVRXu+p9J5U29ZhaYXhXN3XqQ=;
        b=IDpV4i7SDnKhRgqrRiu1T11g3O+x6SNsvFa4H/YC1ZCAZeRSk0Ur3Xd7ylgEvf3iJP
         4xpq+znlcXrhmcNcHEosKJf0qNrzByRyLvX+NaKe/HmyhdnRVdfY3r4d/uccajJGwoW4
         xv4DgT/dpKTb7nTDN+OmTrLkYo+m/YbqWnA+5YhFQdK2cDOFTdUDCBv39Z7+VKsXMuKP
         HZAwB/X3LZL/lO4NcNJU8PyAqake30PpIogj7PUiTyo/Xx3P26njJu4jeLhprviOb9F+
         yRY04c7HhSM1jPZFUdiTInGRh6Fgq45c7jyMKfCHUlh8HQOPNECf9QIZmwgjDs4upkDi
         Ujhg==
X-Forwarded-Encrypted: i=1; AJvYcCWmGEHt1yCGBZZRdhIZxpzAfyU9XAmSXgs0RZIwSomNpXAI7QzxXzUHU6vFYXXeZGIgKLZIRteyIBEvkBUS1ccM@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFNfKtLvMwGKRYLD/kKrWR8TEZwKOOcBH4WR6MwwZgL9fe5Hc
	y/1pUZxwgklIqIfmdP9B6/ZlFZdqq6u5nsaBS91HIJnCvpu4CAJkUYFLUIUoOixuOC0U/IK0XgX
	8AkMl+U/IY34fTNOYELtC3V8ALMp2i1Nuqo52JZMRWlXIykNU5t0Blk+60l9FhgY7LPE=
X-Gm-Gg: ASbGncv7D/40yt8B85IaI91ZAWukIDCtEtdf4qt7vzCsKoCUCRZaxhbzrlT3bviDT9F
	I7iz6SU3p/pTbgXGMOk74ONmVTHYEu2s3khONSua59AJQ2MZMYDFQfVt5+IUkZU205WXPH2CBHj
	ac5xw9e1/lZFtVUm99JFEwQn//gl/+aPZqftNRZ0XjyOdQu6g4sMQvTvI8TciwT3vB6zrBxO2ya
	gpr2Goc4CrRPvLr5+9rzJEV0H02HTFDVl0PpZGQf7MQy7iSABY5TU7ALN1OlYkqUwSXIlk7ffg0
	uzBnyeI=
X-Received: by 2002:a05:6000:178b:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-3864cea04aamr427003f8f.35.1733867038825;
        Tue, 10 Dec 2024 13:43:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBntV1r1V7qqw90fwsLljHpEimdBIKjwkwSqRAQs8sHJ14VdSz0YmnkZwq+Lk4qViVzkpGhA==
X-Received: by 2002:a05:6000:178b:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-3864cea04aamr426978f8f.35.1733867038413;
        Tue, 10 Dec 2024 13:43:58 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61ad.dip0.t-ipconnect.de. [91.12.97.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm12034785e9.4.2024.12.10.13.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 13:43:57 -0800 (PST)
Message-ID: <63ae2ae4-b023-4802-9b34-a2c0d272f6d7@redhat.com>
Date: Tue, 10 Dec 2024 22:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fork: avoid inappropriate uprobe access to invalid mm
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>,
 syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
References: <20241210172412.52995-1-lorenzo.stoakes@oracle.com>
 <3bd43f87-571a-4bc6-b068-69056ec18d85@redhat.com>
 <ec718cd8-afcf-4002-95c5-4cc610a44107@lucifer.local>
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
In-Reply-To: <ec718cd8-afcf-4002-95c5-4cc610a44107@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.12.24 21:59, Lorenzo Stoakes wrote:
> On Tue, Dec 10, 2024 at 08:35:30PM +0100, David Hildenbrand wrote:
>> On 10.12.24 18:24, Lorenzo Stoakes wrote:
>>> If dup_mmap() encounters an issue, currently uprobe is able to access the
>>> relevant mm via the reverse mapping (in build_map_info()), and if we are
>>> very unlucky with a race window, observe invalid XA_ZERO_ENTRY state which
>>> we establish as part of the fork error path.
>>>
>>> This occurs because uprobe_write_opcode() invokes anon_vma_prepare() which
>>> in turn invokes find_mergeable_anon_vma() that uses a VMA iterator,
>>> invoking vma_iter_load() which uses the advanced maple tree API and thus is
>>> able to observe XA_ZERO_ENTRY entries added to dup_mmap() in commit
>>> d24062914837 ("fork: use __mt_dup() to duplicate maple tree in
>>> dup_mmap()").
>>>
>>> This change was made on the assumption that only process tear-down code
>>> would actually observe (and make use of) these values. However this very
>>> unlikely but still possible edge case with uprobes exists and unfortunately
>>> does make these observable.
>>>
>>> The uprobe operation prevents races against the dup_mmap() operation via
>>> the dup_mmap_sem semaphore, which is acquired via uprobe_start_dup_mmap()
>>> and dropped via uprobe_end_dup_mmap(), and held across
>>> register_for_each_vma() prior to invoking build_map_info() which does the
>>> reverse mapping lookup.
>>>
>>> Currently these are acquired and dropped within dup_mmap(), which exposes
>>> the race window prior to error handling in the invoking dup_mm() which
>>> tears down the mm.
>>>
>>> We can avoid all this by just moving the invocation of
>>> uprobe_start_dup_mmap() and uprobe_end_dup_mmap() up a level to dup_mm()
>>> and only release this lock once the dup_mmap() operation succeeds or clean
>>> up is done.
>>
>> What I understand is: we need to perform the uprobe_end_dup_mmap() after the
>> mmput().
> 
> Ack yes.
> 
>>
>> I assume/hope that we cannot see another mmget() before we return here. In
>> that case, this LGTM.
> 
> We are dealing with a tiny time window and brief rmap availability, so it's hard
> to say that's impossible. You also have to have failed to allocate really very
> small amounts of memory, so we are talking lottery odds for this to even happen
> in the first instance :)

Yes, likely the error injection framework is one of the only reliable 
ways to trigger that :)

> 
> I mean the syzkaller report took a year or so to hit it, and had to do
> fault injection to do so.

Ah, there it is: "fault injection" :D

> 
> Also it's not impossible that there are other means of accessing the mm
> contianing XA_ZERO_ENTRY items through other means (I believe Liam was looking
> into this).
> 
> However this patch is intended to at least eliminate the most proximate obvious
> case with as simple a code change as possible.
> 
> Ideally we'd somehow mark the mm as being inaccessible somehow, but MMF_ flags
> are out, and the obvious one to extend to mean this here, MMF_UNSTABLE, may
> interact with oomk logic in some horrid way.
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> So overall this patch is a relatively benign attempt to deal with the most
> obvious issue with no apparent cost, but doesn't really rule out the need
> to do more going forward...

Maybe add a bit of that to the patch description. Like "Fixes the 
reproducer, but likely there is more we'll tackle separately", your call.

Thanks for the details!

-- 
Cheers,

David / dhildenb

