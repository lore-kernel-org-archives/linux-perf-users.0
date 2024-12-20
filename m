Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF159221D90
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731604; cv=none; b=pmgsbolIOpmEnmruZxFIRxQ2gYUnv1qCF5tu/rewDI+jNQLPTk3Seg6P5WLC/oKJ3d8WFjAy6mbdxR6XOs2BXmGz3csPYor5e12UKfyTroM1JYgSuTQ2DfaW3vaihm2Js9AjtVYs3NbKhZDkBvfOXpxWc2g5hcfFYZrbYopG5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731604; c=relaxed/simple;
	bh=uoxDvw3Z1OG0xpjbsCGN1W720+UyXC2YfjF+PyJMKRg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FnHrsMgHEPQbtLadvWgiKTz67D8Y19ACIvwOhjToEyj/f52gPmOGCkzcd2wVvH6ILO+PUVGzjo87G53E0lhVSCGfU0InJxtQmWYrppozEBYNFzszlvmsHIeZ/+8ph/yEdKsEkFif2ccbYiu+TxJr2XurHIOsj0Yr2i0PKi1VuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0BojHDT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0BojHDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734731600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tzaHhuxKCpnmNHsFinwHJZ/KXJiGt/Icy1kgSSIGmvs=;
	b=P0BojHDTKaNXC+dB8BUhwll8D/ruqXj8VSst+HlidEzws98IGp4JDnU/EIu0crvQ56SuIc
	bfE/nMy4HxI+TBNgPWocsc5WnHoHBa56FXJ9Xs/HBIud2YD4cWx7TElxrNYHfOKxfDeaGG
	2oOCILsmFCjztyjeJPIMRoYJ49Y8E40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-OtrxoPJ8O5ifwH2gzZNkdQ-1; Fri, 20 Dec 2024 16:53:19 -0500
X-MC-Unique: OtrxoPJ8O5ifwH2gzZNkdQ-1
X-Mimecast-MFC-AGG-ID: OtrxoPJ8O5ifwH2gzZNkdQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso17847795e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 13:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734731598; x=1735336398;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tzaHhuxKCpnmNHsFinwHJZ/KXJiGt/Icy1kgSSIGmvs=;
        b=LCVeShS8bU3Zq0bhvioxip8kDAm80v3kWg0yRxBXhzz9qO6E/VKmzdaxp332jAspwT
         tK9LWj5fLg2lB4AzvF8dS758GujFca+0Oc6OaX8KRTO6JQiAQv93KjcaGW48vkZAK4JC
         Su/Fdlf8gIYzETbHz8b7mkFaBQ/I0clj0CaTvn4j6irpXCbrF8CYMTTY5BehucTugU7T
         3SePdP51vIJ/nEYTf90Q1rj6MRI6+6d8sx1SkPaZk7HR2svED5JOs60eBZSmR4NKZLav
         Vk+B7KTnRja38oqWAZ5YpcyTij253J/iTUYOzgUuc4wWySlUK4jFT310ODg/7gqg0ivm
         ohVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7j//+RB0FrtRTp1LaXfr9ASP+Zfpj1oOJRWT7ICyDYX+M6vdOBrG1IW6XTw2XP1jODmjlH4zZbmNlFFdEVyOb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/IccSB6ulMFlify5+WQzHpqgW+tdHWDfHfN55ZnF42V3t+tM
	6+yKI7QNP5d7rB2YubduTw2aO8CcNkz7MiGt4D1bj7wyEZy617SzWaBGaDafrBY9pMi5kMdhOmX
	bjmrFXofaX2QBckbwb5Fn2nZlo4zgFqOyHrydyIO7aHq+eoUdFUufd1X5uruvSGVVdmM=
X-Gm-Gg: ASbGncuTQMz33HnllvEqBlmPEfwm4j1cWhi2XVog+RtgzKd49KJksKo52gQ0Avhy7oi
	6ezNpOrmY8X1pAzN+mKBVA8lcLM5k1LA/nSIdx5czERYFNQo9b47t750C697tvjQgSpVGcljEox
	HxfqYVe3fqrxPgyPj37M/AqoWuwc94yErWBgu0MOICAycu18DfVvTAOOjBGe2wskgzqdzkzDUJL
	ajrjtdhui3rGWt4SGmghPj89VfeilIvQfoa+w9ykbhDmztaEUcxgjnlUGKgQhWm6QsnQlGbPo2s
	hy5TRmzTI0QVso5+wO0TkV7gkKYXwZzvVg9eC80GxE99lnwjrc+gvmzsRq1SxpRb79MqB3A4Evz
	uUCm0ivLC
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-43671247b46mr18766855e9.4.1734731598289;
        Fri, 20 Dec 2024 13:53:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3rnv7Ika86NARxVsSo6Jyhm1kPL572OzGaGwSE4AgHQdFlnReiSeXXtpYxqy8HWFihfGrBw==
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-43671247b46mr18766675e9.4.1734731597906;
        Fri, 20 Dec 2024 13:53:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84705esm4992924f8f.44.2024.12.20.13.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 13:53:16 -0800 (PST)
Message-ID: <e489e48d-f9ef-453d-9b88-91368b9534d7@redhat.com>
Date: Fri, 20 Dec 2024 22:53:14 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
From: David Hildenbrand <david@redhat.com>
To: "Chen, Zide" <zide.chen@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ebaa9d2e-c5f3-4a93-9def-caadae92acc6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.24 22:29, David Hildenbrand wrote:
> On 20.12.24 20:36, Chen, Zide wrote:
>>
>>
>> On 12/20/2024 1:56 AM, David Hildenbrand wrote:
>>> On 20.12.24 10:31, Lorenzo Stoakes wrote:
>>>> On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
>>>>
>>>>> With this patch, it seems perf tool has some problems in capturing the
>>>>> kernel data with Intel PT.
>>>>>
>>>>> Running the following commands, the size of perf.data is very small, and
>>>>> perf script can't find any valid records.
>>>>>
>>>>> perf record -e intel_pt//u -- /bin/ls
>>>>> perf script --insn-trace
>>>>>
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> I'm on leave (and should really go back to relaxing :>), returning on 2nd
>>>> Jan so can't really dig into this.
>>>>
>>>> But I tried it on my intel box and it 'works on my machine' with and
>>>> without patch with commands provided, so I'm not sure this is actually a
>>>> product of this change (which shouldn't impact this).
>>>
>>> Zide Chen, can you try with and without this patch to see if it
>>> introduces the issue?
>>
>> Yes, I re-did the test on a SPR server, and the result is same. Without
>> the patch, it went well; But with it, "perf script --insn-trace" doesn't
>> show valid records.
>>
>> This time I tested it on the clean 6.13-rc1 tag, base commit
>> 40384c840ea1944d7c5a392e8975ed088ecf0b37
>>
>> Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:
>>
>> Error:
>> The - data has no samples!
> 
> I just tested it on 6.13-rc1  vs. 6.13-rc1  with this patch.
> 
> Indeed, there is quite difference. Below are the main parts that changed, only.
> 
> We seem to be recording data, but maybe what we record gets corrupted somehow?

Huge parts of the new file are full of 0s. Either we are mapping the 
wrong pages, or reading from the pages (via PFNMAP) does not work as 
expected.

-- 
Cheers,

David / dhildenb

