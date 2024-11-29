Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF188156991
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885959; cv=none; b=Lj3HgnbSGUt9Up2eJC/So7W9/gvUUgUPooSTdtSUNwadnnI0efQm6Ru4HknCCUqJIfvysmL4MIAI8EVbBBxbLcJvI8FQg0xlgPisLphBh4Lx6/P+rMmiLKxBPwHXnXMByGIh8ygN0MyZHZKYW7EHp7SPvSuEkjXAF5mSenLfL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885959; c=relaxed/simple;
	bh=jeExHsTopGg3lPs7vDqTygzkFIo/Hh0Ypi4h74FHzCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+AwE2y2oIoSAvlSnc3zjL0sgT+fsC+SITwidnS0spwtjc/ag4/syu0d60DLhqix7Z9/3YnNMo9MoDwaM0YSG4S4HB/cOPAMz6pCrZVr5Sf8EP6GNA3Og39IuaZPYygF+QX8XFlbwHs5JMxGGo8/Yf2F131EW/r8o9r7lqyz15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eayOEJqn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eayOEJqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732885956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/hwYR3GugWMMQOPEFk6JjTcCSdLv4Wb1R0aJ/cKX0Rk=;
	b=eayOEJqnBqdYxYhT5ohT/VgRivzniSg6OqqApAuPLMsy1bsFC7HHYD2+9CH9Ci2StZbzsZ
	Lh7pur1jSE+pBrz76K2My5VUtplYCIixGRqFoIuByKcSces/gA8fYAuwMRnO6fzvxjTHKh
	8JO6jzbZTVgqiUag7CEJJL16XfTxmKg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-dz2t6nVBMF-rC1sdJ5RN9A-1; Fri, 29 Nov 2024 08:12:35 -0500
X-MC-Unique: dz2t6nVBMF-rC1sdJ5RN9A-1
X-Mimecast-MFC-AGG-ID: dz2t6nVBMF-rC1sdJ5RN9A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dfa9b758so248900f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Nov 2024 05:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885954; x=1733490754;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/hwYR3GugWMMQOPEFk6JjTcCSdLv4Wb1R0aJ/cKX0Rk=;
        b=Nbva13E7G7/JRYtY0BFT1vZy8DLGmCGq/A9+tZTXQJ8maSk1UUISuftqRxcCp0yh9H
         6tgqCRHnY8dWBjlNk8li0IcukwYwpUdc1SqEw/8xOzGHLNTfiT88g3KtYZNzTqUeOnhM
         nYpmB+JV+AP0tW9XS+cqNetr6y8eCTCUo7yq3gU/eC/irRmqZ9QzPygX89LEBqdT6AsK
         Scl/yeq9XnWCSqXxCT8X1aPq3SV8nSSqxIAvBFz3Z9rJfULqSdaZnoojS4qY8p39ZIIy
         UdcTR4VqXE5E+A2h3VZyI65Z+Pff98Z/y0piFBsIaX8e8HGmYakMdGguWxxDudInIeIW
         pCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8sTUDm+I0m2OLgQogK8HxQNBy+cWvk68jTYMx5Lt5ButG+/k7cKopoX0ftYzfEvIJwXZSE38IPUKktSAW+OtF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3CWdd8chIJFjp4sOu1MZQHz7pdwc8K4iSYgJIhRB9TxB+zeO
	KZl3Yxfu6WapeQ3Mv7uh4KatBwxaIKDW8OB89p1V52TZlZFvUQxb9yyXIJ/m6FhpFse+CTD49EJ
	lRUxqsgCYaphjySeqO2C/BNDagqiyFral5GSfPap2Az9dGqVCF1txuHHLP43uhpaHgDA=
X-Gm-Gg: ASbGncsEH5IXuADh8iLuMIPtN9xMeVtcj5Bt+S5eYCpfQlxzstgixXHI5iHwwEAOun+
	EVuMgt1KTBwujBVKWphGaSGppuejnvhX6ZRa6fbK5oU/k2Sy5RSvcG7+kEHtQaRU1F1M7UNuDpd
	51vQGelSboetwFp1w78coo5RWrj3EvvtlmrpCsttHHaA5CVeqPXmf3gY+Nj9e2xyIBQ7ocOA4xG
	7Fo/bUkPPQxwO+HYu5PvnpcltMRfhMZZB04sXYHlleq0LuRxrsRx2HntfAgTBjipRziVq2h4Uh1
	cghG8ViJnfks2eggPY12FJl84sy1odXT2sHIKhePXBI4zIK+jvWQT5nqFU3YFfJcQDgV8PG4XzD
	Nsw==
X-Received: by 2002:a05:6000:156c:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-385c6baa5e6mr10230029f8f.0.1732885953631;
        Fri, 29 Nov 2024 05:12:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExEsoo67CVLNXO6FfxW8tgx24WlQQ/AN54SY+SW6f+rWspF1wsgU4wFEKp8G3gjjeOVuSyCw==
X-Received: by 2002:a05:6000:156c:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-385c6baa5e6mr10229012f8f.0.1732885945142;
        Fri, 29 Nov 2024 05:12:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f2c7sm85744075e9.2.2024.11.29.05.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:12:24 -0800 (PST)
Message-ID: <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
Date: Fri, 29 Nov 2024 14:12:23 +0100
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
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 14:02, Lorenzo Stoakes wrote:
> On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
>> On 29.11.24 13:55, Lorenzo Stoakes wrote:
>>> On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
>>>> On 29.11.24 13:26, Peter Zijlstra wrote:
>>>>> On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
>>>>>
>>>>>> Well, I think we simply will want vm_insert_pages_prot() that stops treating
>>>>>> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>>>>>>
>>>>>> We could start that work right now by making some user (iouring,
>>>>>> ring_buffer) set a new page->_type, and checking that in
>>>>>> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
>>>>>> and the mapcount.
>>>>>>
>>>>>> Because then, we can just make all the relevant drivers set the type, refuse
>>>>>> in vm_insert_pages_prot() anything that doesn't have the type set, and
>>>>>> refuse in vm_normal_page() any pages with this memdesc.
>>>>>>
>>>>>> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
>>>>>> these things will stop working, I hope that is not a problem.
>>>>>
>>>>> Well... perf-tool likes to call write() upon these pages in order to
>>>>> write out the data from the mmap() into a file.
>>>
>>> I'm confused about what you mean, write() using the fd should work fine, how
>>> would they interact with the mmap? I mean be making a silly mistake here
>>
>> write() to file from the mmap()'ed address range to *some* file.
>>
> 
> Yeah sorry my brain melted down briefly, for some reason was thinking of read()
> writing into the buffer...
> 
>> This will GUP the pages you inserted.
>>
>> GUP does not work on PFNMAP.
> 
> Well it _does_ if struct page **pages is set to NULL :)

Hm? :)

check_vma_flags() unconditionally refuses VM_PFNMAP.

-- 
Cheers,

David / dhildenb

