Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0382356D9
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497542; cv=none; b=lCy9yuxtke/vfH6CmM6ccabchS9yckjRYwWKsWy+fd2kaahPQ4i6xdXvReby89ISGB+Sb/qUXrgjzRco11m7Jwo599pXpw/u8/iaaJ3DKWtMQGkswzDhgolqD5zZ0QDtTOfBanFk4DtD2kjOILgbDxlRyGBcAfeK/ovFEM8xEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497542; c=relaxed/simple;
	bh=Kym04Oo3V+mA3kzh3DiwjhAMsB/Z5CxmPahrisXhs3M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AZYijGBR4TRwjJ5KTIQY9YHCl0ECMUqgYBw8VNLyLnGCAfrsaxsbTwcIKBtIMruqe0s8Dv8UmoJpLan/3oNQYfuA+tjJY+vwY/hX4ZPQW7O8JFzSk8mhvyv5zSeJr4KEGd7AGkFKw4ORrYcdYYZoVqO0qJFiKuTQG/3p5xfOZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYZ7ZXWQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYZ7ZXWQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43591b55727so790674f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771497539; x=1772102339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8iDLK3qN6o4TbYoP42I01clZFWdxZSpMrTnquDLRYc=;
        b=kYZ7ZXWQIoMnT9c9b4rs5zhyp/sSlNe57WLGPb+vX2TTRzbRy2j8I93XSRwFbB6t8H
         ETF0/Nr/iQEgZpqyFUFbI9hoMLVSn+WzpcumF7zJPqVktvyzhAtBbjp0vEnpHF9X4CNk
         eEhEdX3dFzFJ4eY6OpjtXr03qjxfO8NQtIN+4FgQ0HIYbVdYuiBLsJ7bCCvsLBPpgIw1
         WwRfWlI1Zfxq+oEyFmOcTH4NdnlW7ysYhUi0wJpx23TwnUYT0LtO0fiNwIqhEhNRFjPU
         P2k4m+XOiwwsDASiU+ni4VKUykb9aoh6bnO3dG9Np+PlqMZp7dv6MQxMz+UdwPEElxbF
         LE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497539; x=1772102339;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8iDLK3qN6o4TbYoP42I01clZFWdxZSpMrTnquDLRYc=;
        b=OpNrdAOvYVfIJsO8Ca0w0ElsY3VkHr8Bp1cFd2YY8xHfqQA7v5ITSXugr2hHvc7UWK
         b0rB1wH5EgaECM6xpwlm1Q93ossxJs5a0UsJzGpT9VH9dUwbS7i11+gTqQQoy1K+hRvU
         Aw2UdiPG1xmHmqCLvIQbD1NLht2dnT82XSKpueVGut/4pJFskZ20ziA+Z4ovJnXw9FcZ
         GPZ+qGnwNpZNozhAKnSN+K5kb6Ao87PWDZfhgzrgnxFt4wujMZ4M005nJ+9MMdN/SNt7
         uUB0cQ+P4aWjLvHZOUoHKakwNgf3XOol51nFzcqTaainpb3rQI+3DTVpzm4A7nyau1jm
         kAsA==
X-Forwarded-Encrypted: i=1; AJvYcCX2BQNrZ0eRlLEjUW+1T1Dix9twluSsP35Ad4IaOoMTjDTvtUhxlnEr/cDBb8Hq0gfZBi9pwV7WwY1LFktA7Bs6@vger.kernel.org
X-Gm-Message-State: AOJu0YzWP+YzL60JT1aA3RhFIYI9J7j0CoFq0UoflAlU+SkIPbthb70z
	2Z8X6fZ1OtL89avZE7uKQp8mN8D3X/8rZyZ9vk4Ypu8Hpc0w+IhuxfKAalLXW531J5I=
X-Gm-Gg: AZuq6aLNJl8oBqTjs5WI1zrvelPsytMDHdzzFT15xWFcC/6zku66LRHy8txX9AptPY4
	MHSyZF/Nh62DWC201/ad/RfeNS4lLm09NvvzAtBp2KKfJrG5IhuxZvloiNJW0aKbvfUeOEW4Xfc
	VKbvzzStYDVqE3YttUdvTp1uTmq58I5i0axaYR1HoOrdA3FWUKuvcvUqB8toC1NBx7d97V3e3F/
	4m1kjb6csyp4rE+20R+N3NIJuYde8QtWxA0NXAM04Tg5WXzhTnH7D/F5PJdT0lHu4XOhCyvdm1C
	UHPFpQGbU/6/uWhiIxTnKxMxX+HTwEyOfqMi6rzP8Zt4yJWOYUTYVTBpO6gBA8Q5Ay16fBnyBqc
	/8krBsco4hLzW5F5QHIuHTmH4v48yF4BktmvSxnuXu6W+KnuizlyDpvj7cUTX8LCrdIxmeITFKe
	ioDJxtL42rEYPkKRDUFyjGd9WnklXf
X-Received: by 2002:a5d:5850:0:b0:437:8f37:882 with SMTP id ffacd0b85a97d-4379db93a97mr33803414f8f.33.1771497539359;
        Thu, 19 Feb 2026 02:38:59 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm49110068f8f.13.2026.02.19.02.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:38:58 -0800 (PST)
Message-ID: <ea82e2ab-ddb5-419b-aa70-49b28f18383a@linaro.org>
Date: Thu, 19 Feb 2026 10:38:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf bench: Fix initialization of union
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Leo Yan <leo.yan@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20260219004417.188434-1-namhyung@kernel.org>
 <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
Content-Language: en-US
In-Reply-To: <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/02/2026 10:36 am, James Clark wrote:
> 
> 
> On 19/02/2026 12:44 am, Namhyung Kim wrote:
>> Recent compilers don't initialize all members (or the largest member) in
>> an union.  Instead it seems to set the first member only.  So some perf
>> bench output shows invalid numbers like below on my system with GCC 15.
> 
> I couldn't find V1 of this so I wasn't sure if it was discussed already, 
> but wasn't the plan to fix this with a compiler option:
> 
> https://lore.kernel.org/linux-perf-users/20250319110454.3230687-1- 
> leo.yan@arm.com/
> 
> and
> 
> https://lore.kernel.org/linux-perf-users/20250320105235.3498106-1- 
> leo.yan@arm.com/
> 
> 

Oh I see V1 was only the second patch, that's why I couldn't find it.

>>
>> Before:
>>    $ perf bench mem mmap
>>    # Running 'mem/mmap' benchmark:
>>    # function 'demand' (Demand loaded mmap())
>>    # Copying 1MB bytes ...
>>
>>           0.011127 bytes/sec
>>    # function 'populate' (Eagerly populated mmap())
>>    # Copying 1MB bytes ...
>>
>>           0.011127 bytes/sec
>>
>> After:
>>    $ perf bench mem mmap
>>    # Running 'mem/mmap' benchmark:
>>    # function 'demand' (Demand loaded mmap())
>>    # Copying 1MB bytes ...
>>
>>           2.209417 GB/sec
>>    # function 'populate' (Eagerly populated mmap())
>>    # Copying 1MB bytes ...
>>
>>           7.875504 GB/sec
>>
>> Because the first member of bench_clock is u64 ('cycles'), the default
>> struct timeval wasn't fully initialized.  Let's use memset to reset the
>> whole memory.
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/perf/bench/mem-functions.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem- 
>> functions.c
>> index 2908a3a796c932d0..676c8d18f4c2e259 100644
>> --- a/tools/perf/bench/mem-functions.c
>> +++ b/tools/perf/bench/mem-functions.c
>> @@ -193,9 +193,10 @@ static void __bench_mem_function(struct 
>> bench_mem_info *info, struct bench_param
>>   {
>>       const struct function *r = &info->functions[r_idx];
>>       double result_bps = 0.0;
>> -    union bench_clock rt = { 0 };
>> +    union bench_clock rt;
>>       void *src = NULL, *dst = NULL;
>> +    memset(&rt, 0, sizeof(rt));
>>       printf("# function '%s' (%s)\n", r->name, r->desc);
>>       if (r->fn.init && r->fn.init(info, p, &src, &dst))
> 

