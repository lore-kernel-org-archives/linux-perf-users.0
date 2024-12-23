Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE01BB6B8
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734988371; cv=none; b=tIqycNF21H8xbLAyWqHYbtxlP41TxNiiNf4bTfI7JMNtCUCoq+NpG9avVSSQBOHJ4Lzscm81uFa1OyvuRZCKB27caceJ2MUWxDjasuF52qxKHu7nFce/hwpo+shCGdaleTnozeSovoIV+mQPBk4pr6bwicuEkCFAC0YH5eLZEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734988371; c=relaxed/simple;
	bh=3FBe+74ZYrbMc0g3gI3D9fIdZxiaLiTQWBRK/AVf8F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xhv3M5v9Tre6jxAB07YxSEhxHsSL9VUA/5HGP+QBZXh3EYttqVB2gy6S5sokgZfHJT165oWKqvxN7KRo09TpzNvWiJ56NzMBU/3+m9hB3E2XPYar0IIBiLyCSV0zBTqGT6TVfohjSyaLnAU5DDGXiInRLbCT6RRm26qoGEXBgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVZUtFVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVZUtFVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734988368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qV4g1N2gf0daZJQR0ABPMd160qh+3HZVnupXaQK9pGo=;
	b=aVZUtFVOrJxA4gC5dyPIKUgof7L0WC2mTSDygue0kH5pXEXTk7ArWdh7teFjPo1NOely9x
	rQBzfwTC5u05yxz2ObPu0TftX9MHSvl3c0kFltArpFfTDIR3q4uAegLgQOZPVRQcuUbsh0
	zFrwPQNHespNOVbycY7vq/O9znlk3Us=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-XFKLJ_mzOkmsTFpBe46GXQ-1; Mon, 23 Dec 2024 16:12:46 -0500
X-MC-Unique: XFKLJ_mzOkmsTFpBe46GXQ-1
X-Mimecast-MFC-AGG-ID: XFKLJ_mzOkmsTFpBe46GXQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so2158651f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2024 13:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734988365; x=1735593165;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qV4g1N2gf0daZJQR0ABPMd160qh+3HZVnupXaQK9pGo=;
        b=oAqKHU4akBLVvaobyqP0hM837b+YKYb8kVgH46D+p0noJ0Ws7xM7dIyRYxZMTGRleN
         kCdthGIk5TBDNT4Hs6HYdwy3Wz8urd79zTICBpYE2N8R0dM/0dX6lQl5gTe+0zdIOAqL
         t7ihhVJq3tY80qHg1ECIDONBlPeIXmlcwGRTHCKp92/jfTH98iJJ1Lo9ub5g87v1LTql
         IEhqC0DSnHc9uHBL8qAku0CgvEF1hycC+8T2tg8KlxLnuxGYGnfEskHyXl966F+dpOlA
         FTcAF8F8TzW7xiGadB0IxxjcPQvSlK6i23oSYNv+jD4++GwXSHr6rVHP/wBqD5FT7rNi
         n3qw==
X-Forwarded-Encrypted: i=1; AJvYcCXFuXdYSa4Lg8akurKvzrNuLoSZZ7d5gO1SPJFrpKB8mPWDybmnUesOiEen/BwhVyg/n6jCe/8L2rf/0syHvl4E@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdLT5w4Ink2z5Alm09IA/1PEpnlLlleaODDz5fX29tLzMVEd2
	TCc4IgEvpm5KQsqhQa/mwcybOnrLbsn/qL1X05TdYVAGKG8hrbp1LSO9jlYEHXhzeJC9QFihuRm
	RkHOJO9Am+pe8ePDWhu95QmK7t/ltbmS/wkpPyg7Lg3vTVulA3RKxDZAFbFxGSFuQHBQ=
X-Gm-Gg: ASbGncvwJ7DSxcI/9/Sqfqz7DAhk3KiwY24lN6k+L84uKvTGCZKcRwpW8lGA89Hv+yX
	TZilDK5eY0bRCjxqJfMpqwg3lUSFWs26fxK6Nd7Sm3G5ws545DtKaTiGk6hE26baPbZb5+nyAMh
	i/IgbgjS9hWkgY+v/oEFHvAHrRWSfg6FfXUyAeAU5Jp/lakOSGTS0avszmXkkBrNEbUfR9T0/oZ
	InvCi1eEL6CTJ3XvrFPzvygb0DcWMhwDjnn+P2U0jE8wQEMpcFqfDa7KIBFgXUWUJEuecazW/fA
	zjREbXb2M2DzCDv1GmTzmijizTG+GAz4nZMHTu4cSWTRNLH9SXzmsdd/pWi576B2fMShd//3irq
	oRPpSDyV3
X-Received: by 2002:a05:6000:2202:b0:385:e90a:b7de with SMTP id ffacd0b85a97d-38a229ec5a5mr12856593f8f.5.1734988365269;
        Mon, 23 Dec 2024 13:12:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+/QHtx6mWa9o3JeVN7Ppn1qmmS6hUpnJonWPcYL7fOb2Pclz5/Qru/ji9uOQleuruwNbj6g==
X-Received: by 2002:a05:6000:2202:b0:385:e90a:b7de with SMTP id ffacd0b85a97d-38a229ec5a5mr12856585f8f.5.1734988364827;
        Mon, 23 Dec 2024 13:12:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:5a00:7b5b:9007:4395:ac65? (p200300cbc7215a007b5b90074395ac65.dip0.t-ipconnect.de. [2003:cb:c721:5a00:7b5b:9007:4395:ac65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a636asm12616261f8f.88.2024.12.23.13.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 13:12:44 -0800 (PST)
Message-ID: <2cb3d067-fe92-4bdf-ae79-b24810a4bc2e@redhat.com>
Date: Mon, 23 Dec 2024 22:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "Chen, Zide" <zide.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Yi Lai <yi1.lai@linux.intel.com>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
 <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
 <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
 <ebaa9d2e-c5f3-4a93-9def-caadae92acc6@redhat.com>
 <e489e48d-f9ef-453d-9b88-91368b9534d7@redhat.com>
 <f4299bff-3448-4095-b573-243f1fca834c@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f4299bff-3448-4095-b573-243f1fca834c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.12.24 12:10, Lorenzo Stoakes wrote:
> Peter - could you drop this patch for now until I have a chance to take a
> look at this issue on my return on 2nd Jan?
> 
> On Fri, Dec 20, 2024 at 10:53:14PM +0100, David Hildenbrand wrote:
>> On 20.12.24 22:29, David Hildenbrand wrote:
>>> On 20.12.24 20:36, Chen, Zide wrote:
>>>>
>>>>
>>>> On 12/20/2024 1:56 AM, David Hildenbrand wrote:
>>>>> On 20.12.24 10:31, Lorenzo Stoakes wrote:
>>>>>> On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
>>>>>>
>>>>>>> With this patch, it seems perf tool has some problems in capturing the
>>>>>>> kernel data with Intel PT.
>>>>>>>
>>>>>>> Running the following commands, the size of perf.data is very small, and
>>>>>>> perf script can't find any valid records.
>>>>>>>
>>>>>>> perf record -e intel_pt//u -- /bin/ls
>>>>>>> perf script --insn-trace
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I'm on leave (and should really go back to relaxing :>), returning on 2nd
>>>>>> Jan so can't really dig into this.
>>>>>>
>>>>>> But I tried it on my intel box and it 'works on my machine' with and
>>>>>> without patch with commands provided, so I'm not sure this is actually a
>>>>>> product of this change (which shouldn't impact this).
>>>>>
>>>>> Zide Chen, can you try with and without this patch to see if it
>>>>> introduces the issue?
>>>>
>>>> Yes, I re-did the test on a SPR server, and the result is same. Without
>>>> the patch, it went well; But with it, "perf script --insn-trace" doesn't
>>>> show valid records.
>>>>
>>>> This time I tested it on the clean 6.13-rc1 tag, base commit
>>>> 40384c840ea1944d7c5a392e8975ed088ecf0b37
>>>>
>>>> Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:
>>>>
>>>> Error:
>>>> The - data has no samples!
>>>
>>> I just tested it on 6.13-rc1  vs. 6.13-rc1  with this patch.
>>>
>>> Indeed, there is quite difference. Below are the main parts that changed, only.
>>>
>>> We seem to be recording data, but maybe what we record gets corrupted somehow?
>>
>> Huge parts of the new file are full of 0s. Either we are mapping the wrong
>> pages, or reading from the pages (via PFNMAP) does not work as expected.
>>
> 
> Thanks David, and apologies Zide, appears there is an issue here clearly.
> 
> Could you try this with sudo operations? I was doing this locally and I
> wonder if there is now a permissioning error?

I ran it under root.

> 
> I'd be surprised if pfn map would cause an issue here as it should just
> directly map the kernel memory, however if the PT code assumes there will
> be faults there could be an issue. I did take a brief look at this last
> week and it seems the PT stuff relies on the aux functionality, so that
> could also be a source of problems here.

I started a bit at that code, no clue yet what's happening.

I was wondering if we end up mapping the wrong pages, meaning: the pages 
at mmap time end up being different to the pages later at fault time. 
The code is a bit confusing, but I thought we cannot change the 
effective event/pages while we have an active mmap. Maybe there is some 
corner case ...

Nothing else really jumped at me ... moving the mapping og pages after 
the event_mapped() callback also didn't change anything.

> 
> I am on leave at the moment returning on 2nd Jan, I will look at this as a
> priority when I return, as you can see above I've asked Peter to drop this
> for now.

Enjoy your time off an Happy Holidays!

-- 
Cheers,

David / dhildenb

