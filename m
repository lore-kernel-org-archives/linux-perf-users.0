Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40B2512D9
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204080; cv=none; b=jDv3fOO9M524DFD2nhVNtUXs7JBJhHYTuSUBkQdEbMnWMoXQz4p9/lDVEq8S+de9lbMyVZ2Tql1c34FBhIQgpPheoGSiNbpg+C3+DbhTzIz3Kpqz2SjrrZw4AsDcbiZ2Wc156zAEJmd2xhRH2xDy6TrMH4+QQS+MFZBjOAm4OYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204080; c=relaxed/simple;
	bh=ed8V+8VoqbYkOfA9sgscCYNEqRJYIs3LL9AnbgoNAO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb5oKE26iijHb7r0nDT6Feyn9iKJ625cwQlYd7RFWOWfpW/+GWEZotq89+1Qc5SCJrnfqFmeKidUcFpnUhDoII/vw6DzQZOehtkP4g5TF1dc0uexGUuBIXSyBbONwz/Y21a8nrj3a+ywhN5FAkFxwII0GCIQzckrwbGmbK1EVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWpAMt79; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWpAMt79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741204077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eGWydqnoXIhCLQqdot4fyHdmsRNksb4I77lqc7a9rY0=;
	b=aWpAMt79QwcI9lJ0/9umS0vWKp/aZEm84/ZnYXg0PYyE3wf2HxhCHXtzjihjcQNLZIh623
	iORu8MbPkQe2EPnMj2g/Ey4EhzLa9M1c9VVqOXxd6tCbN5bmTq0LXM/th0ycKbS39s8HIX
	tlgK+0aRkIuDAu5eAZGWFN/cIL96D5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-ZViBj3udNIe5aA-8HYEuzQ-1; Wed, 05 Mar 2025 14:47:56 -0500
X-MC-Unique: ZViBj3udNIe5aA-8HYEuzQ-1
X-Mimecast-MFC-AGG-ID: ZViBj3udNIe5aA-8HYEuzQ_1741204075
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so12601855e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 11:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204075; x=1741808875;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eGWydqnoXIhCLQqdot4fyHdmsRNksb4I77lqc7a9rY0=;
        b=TA6DAcZXTQXzix9QGwbWByfci11nPjK/7C/C2jMQ1g2vc2V+eklbemNbNIp0pMalUE
         njjpzdti2/nVP9ycDH8RDL+neuI0iN/Y9AMrVkdbqpMJZpMyx9BY0B0308mhxfGddfWO
         hIi7k8A7UTieHEl9LY7Km6m+8HrUWzcEGXObwPPYPdPkH8uAu36jEpx/XPxok1kZzLkY
         cF3Nf9vpPE+J9W01ESYrbsUQile+ggH9mgg2g8hrHg23vf6GIUH/NPxJ/wWkhdhD05tC
         E64xv0qAU/9JPogoiMluQBt/eF9TVgGbhDpAVmooe0qHUjkNqgSJgvVY1mPZwlDaejc9
         kAug==
X-Forwarded-Encrypted: i=1; AJvYcCUz4OrQ3H/xZJK0ItmjqZxS8dATpkkFQv+z5J/QBKw1AfKvzccGLz3v9g7DyCVr7eTkRXhyixqg0vO5KQoHZYGa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjlb1gs3gQFMHN56rku7crg7xN86IIZu/6pFUjx3JEXAi+PbK0
	v/HNYf5eJ6jQvqWpBgibo5puipGxb0DEhnJ3ArWuj2Row1dH4AIqO8V34NIYsUpZ1zJewSDJilj
	sg03qaxa8JCiatG4c3HyPnb3tlm0RMfOzaI/ACV2pUZYwd53vY9KkC4+Y1QT9mXSNiWg=
X-Gm-Gg: ASbGnctvVhiEZjC09aZamSEhtoo2De/knm2IJ9qEpp3uRGjehbNy1ZXlUJljHrpbPUt
	GEpA0H0Cst9BUB6f86mjhoMIbH1suz6V8+qFrUErrKVmPmxWSuRiEMK0b2q8WGhp8+ZSeGymKyi
	JaEQ5c9G3urx4Cf2H9y1Zav+krBTmKPXPvWk0DVjUbzAavaZqFVXXUaa6HzwXQPOtWtJlMnoq5U
	4DT0Cyg64cYuj2d2tcIzIHk0yL6+n684IUOVQVlF2J63sFR2NOUW5wZjp/Y2LHT3H0cAKvrKGb3
	XXQlNr+G8RBKZffuL3yQ+chLzdcbbMayBnWz2NTEohij0IMimnpc+Y/FIRxhf/CZo1kMIayahsl
	JUvyOCc0TX2W3EbNmQrcHMJqBuiC/bf6PG67SP1cVrqQ=
X-Received: by 2002:a7b:ca48:0:b0:43b:d6ec:3d57 with SMTP id 5b1f17b1804b1-43bd6ec3de3mr31096895e9.15.1741204075051;
        Wed, 05 Mar 2025 11:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0XZGZCIlmOlRS0LbFcH+/JVJl+ID+X2yGng1e5xV1yy07EP7WWTcYimXXucuhZJRVuD//ew==
X-Received: by 2002:a7b:ca48:0:b0:43b:d6ec:3d57 with SMTP id 5b1f17b1804b1-43bd6ec3de3mr31096645e9.15.1741204074608;
        Wed, 05 Mar 2025 11:47:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426d34csm27332645e9.5.2025.03.05.11.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:47:54 -0800 (PST)
Message-ID: <62f93f79-a8d4-44a5-b276-3ac5af4ab25c@redhat.com>
Date: Wed, 5 Mar 2025 20:47:51 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 0/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAEf4BzbyFy0eQHLac3zR8GiGDOUqYoTGAWDbFaeou903OGOTpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.03.25 20:43, Andrii Nakryiko wrote:
> On Wed, Mar 5, 2025 at 7:22 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> On 03/04, David Hildenbrand wrote:
>>>
>>> Currently, uprobe_write_opcode() implements COW-breaking manually, which is
>>> really far from ideal.
>>
>> To say at least ;)
>>
>> David, thanks for doing this. I'll try to read 3/3 tomorrow, but I don't
>> think I can really help. Let me repeat, this code was written many years
>> ago, I forgot everything, and today my understanding of mm/ is very poor.
>> But I'll try anyway.
>>
>>> Are there any uprobe tests / benchmarks that are worth running?
>>
>> All I know about uprobe tests is that bpf people run a lot of tests which
>> use uprobes.
>>
>> Andrii, Jiri, what you advise?
>>
> 
> We do have a bunch of tests within BPF selftests:
> 
> cd tools/testing/selftest/bpf && make -j$(nproc) && sudo ./test_progs -t uprobe

I stumbled over them, but was so far not successful in building them in 
my test VM (did not try too hard, though). Will try harder now that I 
know that it actually tests uprobe properly :)

> 
> I also built an uprobe-stress tool to validate uprobe optimizations I
> was doing, this one is the most stand-alone thing to use for testing,
> please consider checking that. You can find it at [0], and see also
> [1] and [2] where  I was helping Peter to build it from sources, so
> that might be useful for you as well, if you run into problems with
> building. Running something like `sudo ./uprobe-stress -a10 -t5 -m5
> -f3` would hammer on this quite a bit.

Thanks, I'll play with that as well.

> 
> I'm just about to leave on a short vacation, so won't have time to go
> over patches, but I plan to look at them when I'm back next week.
> 
>    [0] https://github.com/libbpf/libbpf-bootstrap/tree/uprobe-stress
>    [1] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com/
>    [2] https://lore.kernel.org/linux-trace-kernel/CAEf4BzZqKCR-EQz6LTi-YvFY4RnYb_NnQXtwgZCv6aUo7gjkHg@mail.gmail.com
> 
>> Oleg.
>>
> 


-- 
Cheers,

David / dhildenb

