Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316A392C2C
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536997; cv=none; b=Cj1hdKW4kdiT0cgkUxlSpjoi3q6R1le6orKVDH0UildT4/j+drfrlG5xfMn6VzlgAgs5Ix0iXAJjXL0082n66yetzKodny1SUZvb+I6EZ4/rQMIcbZOBYglmaDkS2c9+dD0T+r5Dnux7FANgGyKlRUrLMb0C+kc3n1eji5aHwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536997; c=relaxed/simple;
	bh=cB08DrKfnhr8nUV/zbaASjyuSsJDvjbc5ojn6q9zItY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TgBzhw/zan9RiPdCbOtQh0fTFeVvcX/psicsIQlskbNHIpZFXwUWVR0WeGr4RKNbwkwX68Jpxnnb5aTLW2Gfgii4kNjL3r/+wPfbsPIw9p/JeApVfIwhPU/SRtJKagfU/WWqeqwz/oL77OBMhWiSiyWt1RwI7PiAsyr55AkpiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6YHPOSy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6YHPOSy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso2509640f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791536994; x=1792141794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hjjt+5c5DdZVts//sptIbu9PvjR5EqO62EChRfFRIRI=;
        b=C6YHPOSyTGsAN+QZmJic8d4U2rZYggLIiLge4NbkjydX7/kV2kHvkp32j2W3EBvT0r
         nbVYRtDmbZpDCCsO0cnAIJTGiBWpP5LxxoEGChwoLah/Mvrb8l5qDNB434yI4vguAq3X
         YVAxhvJs0w85EgLNyXLKGwweRDi9qNfNfBb+1Tdbm96VyHG8a1GR8Bf8SMaBUv5r9Tai
         2tautA4Tq7Zzds4+I1hAQonL0sAgDodlJhAcwFBYFHAiMMBv1HDitG+HUBDwtxnhlkR5
         gRR7zd5eoRj8LPWm/6kBls4qsxB0D/BZrDnoj5L2XhApeg3f88BALrnpd/TLuDDOA11F
         wGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791536994; x=1792141794;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjjt+5c5DdZVts//sptIbu9PvjR5EqO62EChRfFRIRI=;
        b=ol5qccqxyxN41wbp4M1xsyzhv5oaKLM+gp8lpyc2yD9QJKnZN+U5nF17B/ns+7qIBq
         I/OjebijSrnLDYQlEmhGr6SaTBKPeGvuNXqv/MadMULLHTLo8SfViDCI/i5VfzJruyAY
         4kqWZbShQcgpC6YlWWcIZP7xa7RLLYgJr0/n48FStQ4cc7tIMDnSxUfP4HyaCc+lvR2m
         OONW1xj1MxmugRoG/o6q82NAzd81yuTn8VGA5Fxo9WzHwdUeqgD0ELsI1wvpFZidZVzJ
         MvSV0wZ/KLUwkzBFP1RlnqIMotuN6xMwEsvdfsUHCDnb/HL515vJD6tzkbiCqnWbmWAh
         i1Fw==
X-Forwarded-Encrypted: i=1; AKwUvBzyJwSnHSK7umFvkBuX2mZ8jFDJgoywNUGrVz10Bry1dbT1q8wveClcB0c3fyK/FZvJ8XCjxS33Tx5Bi/Vp0vv9@vger.kernel.org
X-Gm-Message-State: AFq9FYInarSJmZG+UG9A5hOUPJ8sUOKXkx3DR6yVXQaJiYXDkBvkJ32o
	VBnazBKyICKIP3RO+XwY9URdE0KaUC7k2yOdAPfPyHcqGDc8S+te+KXWnCPprgbStd0=
X-Gm-Gg: AYBFou0wHBRLY0WpSHjZiNcWRp14YmGf5uGcK6PONTSi1opm0OCQo+jn9zrqZLrISYi
	zjKaG3rGQyxSGkSN9do/duRaOO5B5HaKOkPqnwcmUm628bwarPlvnjaGCpFySWnTPda1UDqk1aV
	7iKcPSYd5bzLXhbFVYwueCw3g7iL6Vqu9YR/123q88vpv/dvClgNwZ2064Nh5oW+emQRtiJ7hvC
	+D6V4EA6Gs/mYO35hrg9NPZPtT/CkIP0pKGiTb8FgUcc29eiiPgxQgn52FcTsxHyZwy4SU8V4Tw
	4rVC3DQLuJPAgOLPHG2/2FKUlHpaINwRF+R6NDb67iOfAZTiYqlAMwd/zQSQluQEnVvAbc0mcC6
	9hiNxcPNS+ELKK2hI3zmRemAd/KQF+KLIZNaboU09hW2O15HbVaoA375tPqTgB7Z60Z8Fq3U2F0
	DNrX+VlbeUKK3T6U6/L+Vx5XajDliXX/Q+wvgh9O064F/zqft2gCqV0IyTtWJw0t2xhpOtDQCj7
	Wo=
X-Received: by 2002:a5d:5cc2:0:b0:488:8212:5d73 with SMTP id ffacd0b85a97d-48dbacda836mr2080643f8f.31.1791536993946;
        Fri, 09 Oct 2026 02:09:53 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e2d8fsm2938651f8f.19.2026.10.09.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 02:09:53 -0700 (PDT)
Message-ID: <b174823d-2e5e-422d-a958-ee11c5bfc1a9@linaro.org>
Date: Fri, 9 Oct 2026 10:09:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2 07/14] perf arm-spe: Use generic snapshot search
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-7-00c4fd0701b4@linaro.org>
 <20260827161619.GN8904@e132581.arm.com>
Content-Language: en-US
In-Reply-To: <20260827161619.GN8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/08/2026 17:16, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:49:05AM +0100, James Clark wrote:
> 
> [...]
> 
>> SPE also had a special fixup case for head pointers greater than the
>> buffer length, which is not needed because the SPE driver always wraps
>> them, and __auxtrace_mmap__read() handles that anyway. It also didn't
>> have the special case for old > head for when the wrap heuristic fails
>> but the pointers showed a wrap had happened.
> 
> Here mentioned the "special fixup case" is:
> 
>    if (head >= buffer_size)
>        return true
> 
> If the hardware pointer is exactly the end of buffer, it is a strong
> indication for wrapping. So it might be worth adding an explicit
> "head == buffer_size" check in the common code.
> 
> That said, if always checking the final 512 bytes, this case is very
> likely to be detected anyway, so I am not concerned about dropping the
> check.
> 

I can't visualise why head == buffer_size indicates wrapping any more 
than head equaling any other index in the buffer. The heuristic seems to 
be impossible to make perfect, so I'm inclined to leave it as is.

Couldn't you also say "head > buffer - 512" indicates a wrap? But that 
could also just be the first time around with no wrap if there is no 
data after that point. Same way that head == buffer_size could also not 
be a wrap on the first iteration. But then you end up saving the whole 
buffer anyway when *old is still 0 or any of it isn't padding, so it 
doesn't make a difference.

Really we should move to the duplicate detection algorithm like IntelPT, 
or update the driver to use a monotonic head if we think it won't break 
anything. It's so much more usable.

>> The other feature lost is that this search only looked from head to the
>> end of the buffer, rather than always at the last 512 bytes. This was
>> flawed because once head is close to the end, it's likely it could
>> contain zero padding from actual SPE data and a wrap would be missed.
> 
>> It's better to err on the side of caution and mark as a wrap, rather
>> than trying to optimize by limiting the search from head onwards.
> 
> Wouldn't this be a trade-off between missing a wrap and reporting a
> false positive wrap?

Yep, and false positives are basically harmless with this algorithm. It 
doesn't do anything do remove duplicate data, so you might as well mark 
it as wrapped as early as possible and save it all anyway.

> 
> Ignoring head makes the search overlap valid trace data when head is
> close to the end of the buffer but has not wrapped yet
> (e.g. mm->len - head < 512). That data can then be mistaken as evidence
> of a wrap.
> 
> For a false positive wrap, [head..mm->len] contains zero data. This
> should be fine, as zero data are treated as PAD packets and discarded
> during decoding.
> 
> I'd suggest adding this info into the commit log, in case later we need
> to understand these weird cases. With that:

The summaries are pretty good, will add to the commit message.

> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

