Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4418DF73
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208028; cv=none; b=ePzSe741liPxS8zPqxoL/xgfpEKpAiotD3xt+5896xmDeE+1zbZzSedCrDNVVCjnxughD7ouShXA7niMpNgp3niCHQbzKl8oI8QnBNFQ9y8kvxkyf2TONmj0+cTYRK3OodbK7TdMOIRpjWHVsAXi5Zqv9r8jEsU4yazYc0gI1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208028; c=relaxed/simple;
	bh=SEymZq2c8yzGiUuhr88MmZaFWv8Hs1TapCjDAUpBm3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMvJV+jl/20iJF2O/07u+AWgwp+e1J7L/SZFxOoq5G/tIo37bmSLv2p+upjznvQWiNNT9KMHjy7LnorYodUNpcLx+bxZzz9RjVAWm7wn6G2FPAvFlT+Awu8vsHThYM97PUkri51mLJhABmd+tqpW9GbpQSJSwqzz6vsTPrFRZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvhQVR/J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvhQVR/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741208026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JcyydLVKVQXWYYx+0XQnTj1NtApoU7gF9P0L7UfC6ok=;
	b=XvhQVR/JO3iXRwsaey6aBEq6pDEsNgmU0KQ1ht/N3M76agCimu1zChEbXTpjer1lHOzEXa
	Rh+BRcSRsOEec7OYCCU09VUo7GT++TB7sb6Oh6bxJjuIVILulvB53795UORPulKX2WhFcW
	aFVoOLA5JGQBQkUlSQCJSV9yjbVtBYY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-VsMaSS-1PCyJBVndJrfcPA-1; Wed, 05 Mar 2025 15:53:24 -0500
X-MC-Unique: VsMaSS-1PCyJBVndJrfcPA-1
X-Mimecast-MFC-AGG-ID: VsMaSS-1PCyJBVndJrfcPA_1741208004
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912aab7a36so10100f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 12:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208003; x=1741812803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JcyydLVKVQXWYYx+0XQnTj1NtApoU7gF9P0L7UfC6ok=;
        b=JFFs9TkYKRuOI77HRO22jLGFw7P0XmKtFwWTReKobMk1w4773bpUXxRMfyGsrAaYHs
         8D/mA+kOj9n9UnjZUaD/z6jCdnyk3iRHK8B+P9zx028RRvyZzqOvwY9y0kdXWQnrP0sa
         tqJroqMCFZsNTnVyh09HRsKkIiBvqZUj8T/UgJILg21/lT6dZVFO2BUOIzB8YCuWsS4Z
         5wslqaeBiiFd6IdxrZ2PA1BBGZVg0T6bejcIgyYhnqY25i27Qmrn9CVcNPwZzuNJmEGb
         SIMoG3cAipLTiky+DDk/5eYpaV+8H34bdI+dFcRho7PP0tH+/yc11PxsMwVB7F/OO0Bq
         Wplg==
X-Forwarded-Encrypted: i=1; AJvYcCVUngxM5dtZnhl382S8BgZ/43GG69rfJsRSR+9PIGHctKNId/92l2lKmk4dPjp4lydH1EKv4B89uSXvOhaVKlH8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4cvnmcTvTnVzCnoGpVApPYt0ebuRQzyToD6clOHhIvXqmsJip
	VXEaKTJT7iGdIxzOnScWWj2u1ECPD1XMgRA0CKvmbEJzqCD+8wUexPTqDL11DPGN+aLHIfgGy4K
	GOOcTXLQT9aCgChMOMU0tlgC4yHndqaJHAzuGzJJEjPNAAx8R5wHmCRA1Ugl15g1p2c8=
X-Gm-Gg: ASbGnct4TAw6HRhckMK/UCqTIuY+7oulIJwirXVDHpn4tyRFlvr4tcQA9OgVme9JASS
	5tb7lQtgow8wedqct3D/KgVQ7H3Or5TuE+2l5WWugU0+cv1Z/HiZJqH9BLwl/rAC9nN6OTan6r3
	crj8Rou3T9oA/yT1z1AAtYoIQFeRzLIf8HEWHVRNpFozsjq4cpmT2Cs10jYf7tB4d05CKVySFIs
	6v5y6mpqoEhArvcmE8UrhdH18Y3m+6g3GwPqkLtFSkmiuMSlsPEHCwSkZCYHn/b1ydxUgDZEr2R
	jUT9c3v8Zc0mliELcEuwXJh8gFvkhIu2H7Vuh35NGv0goAXMX0XzWP2LZN2TAYhy7Tcyizmgo/V
	f4zQLdSc0F3POhQVeefSa+hAClRvQLGnA7/xVoPkj+4g=
X-Received: by 2002:a5d:64e2:0:b0:38d:de45:bf98 with SMTP id ffacd0b85a97d-3911f726560mr4098318f8f.8.1741208003664;
        Wed, 05 Mar 2025 12:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfukgVDlhzT+kgCOXAaihcOAsjJMWHKbsPU3wieu5zGSUxuy02J4K/cvTgo7N/nkjN8+amrw==
X-Received: by 2002:a5d:64e2:0:b0:38d:de45:bf98 with SMTP id ffacd0b85a97d-3911f726560mr4098299f8f.8.1741208003197;
        Wed, 05 Mar 2025 12:53:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844892sm22239947f8f.64.2025.03.05.12.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 12:53:22 -0800 (PST)
Message-ID: <e34433c3-6e7c-490e-a334-92800db0d190@redhat.com>
Date: Wed, 5 Mar 2025 21:53:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 0/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250305152055.GB28112@redhat.com>
 <CAEf4BzbyFy0eQHLac3zR8GiGDOUqYoTGAWDbFaeou903OGOTpg@mail.gmail.com>
 <62f93f79-a8d4-44a5-b276-3ac5af4ab25c@redhat.com>
 <CAEf4BzZcc6D3u5ATQmpkBt=8EhNuG7Xaibywx=hXcXTp346uFA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAEf4BzZcc6D3u5ATQmpkBt=8EhNuG7Xaibywx=hXcXTp346uFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.03.25 20:58, Andrii Nakryiko wrote:
> On Wed, Mar 5, 2025 at 11:47 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.03.25 20:43, Andrii Nakryiko wrote:
>>> On Wed, Mar 5, 2025 at 7:22 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>>>
>>>> On 03/04, David Hildenbrand wrote:
>>>>>
>>>>> Currently, uprobe_write_opcode() implements COW-breaking manually, which is
>>>>> really far from ideal.
>>>>
>>>> To say at least ;)
>>>>
>>>> David, thanks for doing this. I'll try to read 3/3 tomorrow, but I don't
>>>> think I can really help. Let me repeat, this code was written many years
>>>> ago, I forgot everything, and today my understanding of mm/ is very poor.
>>>> But I'll try anyway.
>>>>
>>>>> Are there any uprobe tests / benchmarks that are worth running?
>>>>
>>>> All I know about uprobe tests is that bpf people run a lot of tests which
>>>> use uprobes.
>>>>
>>>> Andrii, Jiri, what you advise?
>>>>
>>>
>>> We do have a bunch of tests within BPF selftests:
>>>
>>> cd tools/testing/selftest/bpf && make -j$(nproc) && sudo ./test_progs -t uprobe
>>
>> I stumbled over them, but was so far not successful in building them in
>> my test VM (did not try too hard, though). Will try harder now that I
>> know that it actually tests uprobe properly :)
> 
> If you have decently recent Clang and pahole, then just make sure you
> have kernel built before you build selftests. So above instructions
> are more like:
> 
> 1. cd <linux-repo>
> 2. cat tools/testing/selftests/bpf/{config, config.<your_arch>} >> .config

^ that did the trick

> 3. make -j$(nproc) # build kernel with that adjusted config
> 4. cd tools/testing/selftests/bpf
> 5. make -j$(nproc) # build BPF selftests
> 6. sudo ./test_progs -t uprobe # run selftests with "uprobe" in their name

#444     uprobe:OK
#445     uprobe_autoattach:OK
#446/1   uprobe_multi_test/skel_api:OK
#446/2   uprobe_multi_test/attach_api_pattern:OK
#446/3   uprobe_multi_test/attach_api_syms:OK
#446/4   uprobe_multi_test/link_api:OK
#446/5   uprobe_multi_test/bench_uprobe:OK
#446/6   uprobe_multi_test/bench_usdt:OK
#446/7   uprobe_multi_test/attach_api_fails:OK
#446/8   uprobe_multi_test/attach_uprobe_fails:OK
#446/9   uprobe_multi_test/consumers:OK
#446/10  uprobe_multi_test/filter_fork:OK
#446/11  uprobe_multi_test/filter_clone_vm:OK
#446/12  uprobe_multi_test/session:OK
#446/13  uprobe_multi_test/session_single:OK
#446/14  uprobe_multi_test/session_cookie:OK
#446/15  uprobe_multi_test/session_cookie_recursive:OK
#446/16  uprobe_multi_test/uprobe_sesison_return_0:OK
#446/17  uprobe_multi_test/uprobe_sesison_return_1:OK
#446/18  uprobe_multi_test/uprobe_sesison_return_2:OK
#446     uprobe_multi_test:OK
#447/1   uprobe_syscall/uretprobe_regs_equal:OK
#447/2   uprobe_syscall/uretprobe_regs_change:OK
#447/3   uprobe_syscall/uretprobe_syscall_call:OK
#447/4   uprobe_syscall/uretprobe_shadow_stack:SKIP
#447     uprobe_syscall:OK (SKIP: 1/4)
Summary: 4/21 PASSED, 1 SKIPPED, 0 FAILED


Looks promising, thanks!

-- 
Cheers,

David / dhildenb

