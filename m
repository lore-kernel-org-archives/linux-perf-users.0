Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAB15747D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748406; cv=none; b=koSNPZgjOwH807h5XPeTeqtkUibDWKOs0bMJh7wf9J/ox2P+ECU/Xu8PlUOb+vobI09emQ2ZU64tupewPnye7vNP7rQL9/qWsJRkR7jf1uFUk8z+bRAHZhFVYCT3/cqpcnPKNx+PHbEfjoe6ckMquwOg2sC8bmVzAt8Ah33fbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748406; c=relaxed/simple;
	bh=/GAzCoIpzcinpHppherQZNExMsxjrylvg0JO9ZwT0bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFQ/bUXaRKGfxVjtivtiD8sJslppVqeMDDStcH2qDaQrPCNvprFeXkLHWysbEXa6N9z1z9qtXH1vIHy19csFHAdMc6jU3DhxE2soh0E2ZhHeer02zVb4Qg/9NHckHhQn4Q2hi1ZRV84+WxruhM70wAlOAF5Go9TiXNjYOKHhrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaOpnhxa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaOpnhxa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso40732595e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721748402; x=1722353202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sJgSl3GAq4Vma3aTaXhJBsKRSa5G5hA7HsiKy1dx+4=;
        b=CaOpnhxa4aCILPuBj2/pYWApPy/Qv1bULSvKdi0hGR9fCvYZrGwPUMc9E03fEZwFHo
         jSm5//i2y7PnC6EZGppDSbN5JLnjqW5T4ndSWwqRvHEOIIrohKwvCSksn5W03VewdYr8
         86HZZa7x0anqhNfvyS6RQ73lOlblvZZKQeLX56eaQYCE9UhI9t7prGHcqKyk1ydOZXdz
         jkGJ3k/sXYGFIRFjdly7yiRBIfOrRBjxc8V0fAikcyIaHh4+06v8ARJl5CgJeoqeLpJF
         3O8ZHDK4Kmdb5U0fcuCqgWXRoPY6zqtpFqCLgB1X2jNU9Z0J1OsUNBxzso299fsYKE8x
         Bd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721748402; x=1722353202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sJgSl3GAq4Vma3aTaXhJBsKRSa5G5hA7HsiKy1dx+4=;
        b=HeNRSPCKQf297FtO2bZT34htVB7HShgUcvnvuDP2RCi2762H+bK0JOqfY0m0SdmaWq
         cvuXt2WpG09cJb4GW4IBLA1kAX1eO2F5u6bNYK3e+rL5s9w5atCQcyD8mJc/ha9mhEhU
         a0rUXvRjRwOBDXZhdPhquEkcCex80MTZBgtc9tQCyc85s41CBZijMgsyLTVZqw9J2Fm7
         q2XXnrKBl+cPNLUvlapt+XxNFk3ArsO5MW95QjWhecHBzfbyOA/hfo1YqDiabp8F5k4n
         JIgs0rL+malAIJ9hB9bJhN6Z0TuFVWYS8Go2bK3fSEk5e8Co4xvHep7Cvvqpwp/XcvlZ
         9JpA==
X-Forwarded-Encrypted: i=1; AJvYcCXHX8ObF762p3ezkL9N/BPhQNT7c6+YhMxOFzkOn8hSYGRR/wXhnsNwwShpisHel35YfaA/qL0bN6m5s3DwPGv4LyKb2ABMzdfQF9/0GISpQg==
X-Gm-Message-State: AOJu0YwNfKDddQlJN1e25Ut2vobeUM5bYxznG8HTn0kBnzWc9YVR2e3B
	Tn1IasIzl1dDe2G+WNg0KYay6Y1qAs+wfbgOKnxOez7IoS61NZ9NIIAfoxp4D1A=
X-Google-Smtp-Source: AGHT+IH704aplI1Gj4zi9mJCmtvatJ7BJmFbEsuJXSPD/J001YnpqT8iBJNqXv1HeeLf25Wnb5i4qw==
X-Received: by 2002:a05:6000:156a:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-369dee68c16mr3078106f8f.61.1721748402116;
        Tue, 23 Jul 2024 08:26:42 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b24csm11809518f8f.25.2024.07.23.08.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 08:26:41 -0700 (PDT)
Message-ID: <945e58b5-5012-45a8-933a-c1a192fd006e@linaro.org>
Date: Tue, 23 Jul 2024 16:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
 <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/07/2024 3:57 pm, Ian Rogers wrote:
> On Tue, Jul 23, 2024 at 7:41 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 20/07/2024 8:45 am, Ian Rogers wrote:
>>> Andi Kleen reported a regression where `perf script +F metric` would
>>> crash. With this change the output is:
>>>
>>> ```
>>> $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
>>>
>>>         21.229620 GB/sec
>>>
>>>         15.751008 GB/sec
>>>
>>>         16.009221 GB/sec
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
>>> $ perf --no-pager script -F +metric
>>>               perf 1912464 [000] 814503.473101:       6325       cycles:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>>>               perf 1912464 [000] 814503.473101:   metric:    0.06  insn per cycle
>>>               perf 1912464 [000] 814503.473101:        351 instructions:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>>>               perf 1912464 [000] 814503.473101:   metric:    0.03  insn per cycle
>>> ...
>>> ```
>>
>> For some reason I only get the metric: lines when I record with -a. I
>> noticed this because Andi's test doesn't use -a so it fails.
>>
>> I'm not sure if that's expected or it's related to your disclaimer below?
> 
> It is. When you don't do -a the cpu map just contains -1 and for some
> reason it is busted. The whole indirections to arrays of arrays,
> counts, stats, aggregations, with indices into various other arrays
> and a lack of helpers. The code works for perf stat, but there is a
> lot of complexity that I don't fully grok in that. Here I've tried to
> kind of break down what the code is trying to do in the comments, but
> the old code never did sample_read_group__for_each so was is broken
> with leader sampling? Is the leader sampling pretending the read
> counts are periods and calling process sample multiple times. Andi
> likely knows this code better than me so I was hoping he could fix it
> up. We may want to take the patches anyway in order to not have a
> segv.
> 
> Thanks,
> Ian
> 

Yeah I suppose it's strictly better now without the segfault. Could you 
pull in the test and update it to add -a? At least then that behavior 
will be locked down and we can extend it later without -a.

I also tested Andi's V5 and still got the segfault.

>>>
>>> The change fixes perf script to update counts and thereby aggregate
>>> values which then get consumed by unchanged metric logic in the shadow
>>> stat output. Note, it would be preferential to switch to json metrics.
>>>
>>> Reported-by: Andi Kleen <ak@linux.intel.com>
>>> Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378-1-ak@linux.intel.com/
>>> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")'
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> The code isn't well tested nor does it support non-leader sampling
>>> reading of counts based on periods that seemed to present in the
>>> previous code. Sending out for the sake of discussion. Andi's changes
>>> added a test and that should certainly be added.
>>> ---
>>>    tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
>>>    1 file changed, 93 insertions(+), 21 deletions(-)
>>>
