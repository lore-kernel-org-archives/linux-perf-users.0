Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55EE304BCB
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406344; cv=none; b=aH24DCoznVdtv0hMHlEndkNmScy1YYmQGq6vTnNhBdDhC9IoDvC5AavUMtaPcjAWv+DqPVU/KhRnUZt5q0O0j1lHD7I7EdwphGzCBV0D5xBI3WlBMRt4TK1XvGHJ3TrlzJJLNelKCYiyzJwYcDG1D10aK3PI+K3oZdDhEyIgdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406344; c=relaxed/simple;
	bh=Bpa7tzCa3uzSDLpCG93U6QWNvQHkx1XYe9po4G+xqRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/HaTRMzCiavKoyF9In8sNkgGvUpTLsWw1RRg0SokMK4J0xaH4V7Q0b43/Hnbv/JM+rs2r8zBYrheVpev+HYnshbW2Ht8aBLa1GUy2Rtg+YONh8fWrzFnqqbDP5RQ5jHCuoaOug0n4EMUY9d0Q26VKn6X/j9DSypKQ7In33Z17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lM4Qt8x4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM4Qt8x4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305882so6238f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406341; x=1769011141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMsLC4oXhwGy0P6KOpq9XSVOc6j5iFEz/aKGZr4fbqw=;
        b=lM4Qt8x4eRGNzXp1zvkkYi6QFKS4yYKrga7/l8y7Whk7tEpbh4nKoO7d2vgiGRsZbc
         mkqs69arOanqMrVT7io1eUkQsbWFuFy+zwDEgJD5XxPbNvOiNT7tunoLlYbHZn67U56i
         m7zeuinMJvmdqURWhiDoKnbigr157qmxq2Vslgf8IZaEiYgMnCJqlxX6NFW9sTWkDldb
         8NlGFVkvFhrgXFiqlc/6fNVS6sAU6cRv+RVfsnNapBc4Gu+VUuCuAXkkhpS4G7vPpNIA
         0zQsvqjsRuqJQPV8ybKb32VX649qXjxeLtmyrt5fpqYn+b0Rbn5Gic9uH0j1SgoKJuXX
         X/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406341; x=1769011141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMsLC4oXhwGy0P6KOpq9XSVOc6j5iFEz/aKGZr4fbqw=;
        b=m3DS9YaM2JqAxxhWNv9aNwD8tI7eC0HO1+uaxsd3QppchHlFfTM8ZgC5fkfsQEx8o5
         fAA+AjTwF5Z8yQYsUJ97/g3R0oL5IWmoRXD+pRtFJdveEWgo0UEURJzjbUI+yxzCen/a
         Zzry3sJg+1m+d/pU7K79MGrLEdCyrkLk1TjJVy4Wc3ddpzf+Rx7sybxslCMwUsN5FXko
         RetRM2uxN+aX/jv7N9UCpzhSjImAiRfAnAF5kc/ctapKcRAPs5GQ7DPGrjb2zW3VOpNe
         6ofXyw/IfgtYagVcD8ldsNTIUsqRR4SonqI38Cw2WVxrm9tJydZDfNH+EPIaudX2nI7v
         gsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6cAFKC94bXLzHTDbMT3PspfoDM8YcoWADigRbHiKmRTKkJUBbsxgZKln/uZrLrGIEGgSnzRlRM1QHWuDNeuoG@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJP4nUJqR9CGkY0GE7T5DlLM0bamEfTRQYSRgRCD5cFUbLHm4
	DDrq0VZtIg9V0bPuQMTwMjvh4FzSqkBwC+eorU8HTKuJ5SZktasWYyYZdq5TkFfwWOc=
X-Gm-Gg: AY/fxX4WfFeacPF7d+LE+mPHmdZx00y4ZmIyCjD6hwaUe0sV1QzXzB0Z4d3iu4NxOlr
	L5TOljkvQDWFEwH3/+qpZJAYIOIxwrranZobi0M9e0c8RTahU30ipJbkGzyaPNoTqqzvNPA3tbL
	OgxkqoEX6timU+MBn+I40/29gZBNAF7ENUk4LPd+tHoY1CEF8ZVYzW85652aa1yBA/zIQ6P2uFy
	9e4RBkgEla/npvCvhPhJU6ffnd8oKXmdH7yw10oXIJXB5xQUVj1DZk7F0gPdsaIK3iH+m7zdgqP
	ediwVzEMAG4aXTfPLSJCR0AHuchyf0mI6ymB7gbuJUQ+zl9UNoZsEFB+mordLzT0ygKXOVnVdE5
	0JiGxe7GWo/6v8ScZC3x6MfIh0hUtSc5/6f4JEAdIBKlagpAT0jaTFPCVa1idPAMvcpoVOdR3l3
	0eZgyP10cib4671kxL
X-Received: by 2002:a5d:650f:0:b0:431:864:d48d with SMTP id ffacd0b85a97d-4342d59bf42mr2978448f8f.5.1768406341148;
        Wed, 14 Jan 2026 07:59:01 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a65bsm66061f8f.7.2026.01.14.07.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:59:00 -0800 (PST)
Message-ID: <6a31e9e4-653a-4a8d-af91-4325b37535c7@linaro.org>
Date: Wed, 14 Jan 2026 15:58:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] perf evsel: Refactor
 evsel__set_config_if_unset() arguments
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
 <20251222-james-perf-config-bits-v4-2-0608438186fc@linaro.org>
 <aWbDg0kmo-isxkz2@x1> <4eda1bd6-ec36-4d0b-85de-ef0bd190e5e7@linaro.org>
 <aWe6igmKMq25GJP9@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aWe6igmKMq25GJP9@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/01/2026 3:47 pm, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 14, 2026 at 12:14:43PM +0000, James Clark wrote:
>> On 13/01/2026 10:13 pm, Arnaldo Carvalho de Melo wrote:
>>> On Mon, Dec 22, 2025 at 03:14:27PM +0000, James Clark wrote:
>>>> Make the evsel argument first to match the other evsel__* functions
>>>> and remove the redundant pmu argument, which can be accessed via evsel.
> 
>>> I haven't checked if this is the exactly where this takes place but
>>> should be in this series, 32-bit build is broken:
> 
>>>      3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>>> WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>>>       21.72 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
>>>        1378 |         perf_pmu__format_pack(&bits, val, vp, /*zero=*/true);
>>>             |                               ^~~~~
>>>             |                               |
>>>             |                               u64 * {aka long long unsigned int *}
>>>       In file included from util/evsel.h:14,
>>>                        from util/evsel.c:38:
>>>       util/pmu.h:282:43: note: expected ‘long unsigned int *’ but argument is of type ‘u64 *’ {aka ‘long long unsigned int *’}
>>>         282 | void perf_pmu__format_pack(unsigned long *format, __u64 value, __u64 *v,
>>>             |                            ~~~~~~~~~~~~~~~^~~~~~
>   
>>> What I have is in perf-tools-next/tmp.perf-tools-next BTW, I'll try and
>>> fix this tomorrow if you don't do it first. :-)
>   
>> Taking a look, but I'm wondering if this is already not working properly.
>> There are existing "unsigned long"s in pmu.c that operate on the config bits
>> which is what I copied.
>   
>> On this target an unsigned long is 32bits but struct
>> perf_event_attr->configs are __u64. So it looks like it might leave the top
>> bits unset sometimes.
>   
>> I'll look at a fix for that which should fix the compilation error at the
>> same time.
>   
>> Another question is, do we actually care about this platform?
> 
> It failed for other 32-bit platforms too, so the question is if we care
> about 32-bit at all.
> 
> - Arnaldo

I suppose the answer is we still do then.

I sent another version. A couple of patches were changed a bit where I 
used more bitfields instead of converting to u64s which was probably the 
right thing to do regardless of the build issue.

