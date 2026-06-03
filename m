Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C83DEFF6
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502467; cv=none; b=ev0L2q4phWqhU2DdUaRx1IHsqbybmNQIvhedO8/C0FIUtvNqJHjDTczSx8TIthzi5UqjfbPTlkdRY/e1S55LwXwJhc+nfBarUA2tXx6kwEDLsNlvxbmkQYOyjdlxSqRntxHo4rnAnivdY5sBaqR+9FQ45KEcyV6kOn7YrueavAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502467; c=relaxed/simple;
	bh=pQQwDZC2/IQqd6kh9fxl4SaPTFvh6wkfm8PxFI9p/bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqAxhTPCYUybs8WOU9W7a6I050Os37P1LY/gOYCPvGF//77ebQnSj2ucQZ5JD2BNgocfT/C2WQa8RG8XtZ/NXPPpP1hhoU3IKeTvnwPKU1xszpF5IeMu56G6ZxgevXl4fa0WHsWZDzM1+VJCKD4oa7PFtShWvJE1nygphuQpf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onoEwvma; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onoEwvma"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68b482888c3so1345604a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780502465; x=1781107265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYMOxXQEP3+1sbvX2qlt0z2iruVG6MdGHtsqLO+rEWo=;
        b=onoEwvmafC3fqMZFsGZrjri79fAUmjyHrE7fjSxm3x5onnEGQJCuYnkK5qkmP3tppJ
         3fsQtvpF/QkO6S8NO44jKtYwysawNZByeW+JC/WS9Bbymu4EXAgyVQnk2E301sLWWbxz
         SW4qVdTPID498eIkAbbZYvLTHSBTtB3NS7nD358irmTPaX8AbFDKfwzv6tWIafp5I1zE
         rU3IO7ksxhxNpc/J6hDjmzvN5yia1k4VRIgu6JbuKYkPN05QdsqGW6th5XnmAsBWTo7B
         azZWk6oiw7VkuBPwMyMnP7qITrzj27oFV7XozJ3ZmaVcEWbLCwhWN2H5THlhHefIK0zh
         eXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502465; x=1781107265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYMOxXQEP3+1sbvX2qlt0z2iruVG6MdGHtsqLO+rEWo=;
        b=BBbMFcbVOi5kdJyqoL4Q4xNO2Hgq+Rb4FHkZTH9jM/Ojmgnx2MyW6NeCu5RyjvSsRx
         K+iydTmfS/bGl9QqreYE8oubMOvoVbOBQhtzkzqBmm9WwL2Iemewi/mjUEPAyWS/Pqs9
         pmmWeHqLcWaRBAlB5faCs+9rHxHSWv21hG/RD1QMbssyRVTb4ZYIyf8GqHV4lNe6dH1n
         PYXoGejsFWc35pZTV6b5YVjNdT9TuJ9j92rrUDsXuBs108mMshkXyF/0r0ovbOIX6y06
         gmVl/OH720/bxmm17AmQlluNAjXaKYMbRf/oIhfhjA+DVFjIveNmCfqrrXb1tsUUImki
         rBfA==
X-Forwarded-Encrypted: i=1; AFNElJ/iYWzD1k0JELnlB3QiKZyFjA92zmus6y47MXWA/q4ixKzr6yHLzaVoLOZldMUP0JTuhp2kFKbs/uU6kHkQExPE@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT2wc7T5RAgkrSyeWAD9NE98+WilROJ1WOIprSy4wQspetGS+
	B9zcKzvnkNFqZdHKLdM11VZl0nejpvPkzQXhchREB9mU8r2bs7UCMtA+ra3SJedGVDA=
X-Gm-Gg: Acq92OF4s/YQ6jVIdd7Kjfn26e27MeBsGkBHEi1w4kpbLY8jxo4oh3jFfdzahzq3Am2
	LJxuebeseQf+KX28dhyE8qxK2/o+0MbJi8FLQhtzb8DUTS13XAXLno0Hh90Y1iVpVGBjceY8oAu
	HDedix1yESQPaI/fK/keWfbbZJD5cKBnb+9duMiXlZylXhhFtHicsJeL20h1OUEqjDoLJqrg4Uw
	z1Ta2h6cujRLnirlaQVK5lFs85cr6PFduFrpUWkTdZL/wZflwHV6qcaUfvE/ZspuHwEOmoVj37r
	9p6Zui3AJ0xqEY37lSTuS3hYUf/Qu3vK1HW4L3RizCLF4tTDAECmanrhHjf3EcoapY0M+Ykb9zj
	4c9iYDxjNb+QzqjN0piCsowMPq9ugTbrqaa0/CiCnjOFlKVJTw8jE8Kx5lvHsvg2uOBTvV+aZGo
	qFhaybzzf4zTNsL1zq8xKln351WXEJUcYCzXTchJM=
X-Received: by 2002:a17:907:180d:b0:bd5:1605:e1c3 with SMTP id a640c23a62f3a-bf1d159be66mr2503066b.1.1780502464474;
        Wed, 03 Jun 2026 09:01:04 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05228a16csm180101066b.28.2026.06.03.09.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 09:01:03 -0700 (PDT)
Message-ID: <2f1db2b3-93e8-4c32-b207-304e3a43ce77@linaro.org>
Date: Wed, 3 Jun 2026 17:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] perf test cs-etm: Replace unroll loop thread
 with deterministic decode test
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-6-85b5ce6f55c6@linaro.org>
 <20260603140803.GV101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603140803.GV101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 3:08 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:48PM +0100, James Clark wrote:
> 
> [...]
> 
>> +# Remove open brace lines as they may not be hit depending on the compiler
>> +sed -i \
>> +  -e '/deterministic.c:8$/d' \
>> +  -e '/deterministic.c:15$/d' \
>> +  -e '/deterministic.c:23$/d' \
>> +  "$tmpdir/script"
> 
> Is this related to the function definition?
> 
> I can see the brace lines with change below. It might be more reliable
> if adding unused function argument, which can give chance for hit
> function entry.
> 
>    static int function1(void)
>    {
>        ...
> 
>        return 0;
>    }
> 
> Thanks,
> Leo

Originally I included the brace lines in the test and it was working 
even without function arguments, but Sashiko mentioned that they may not 
always be hit.

I think its point was that there is no hard rule about debug symbols for 
open braces and the behavior might change from one version of the 
compiler to the next, or whether there is a function prologue or 
inlining or not etc.

I don't think it's important to the test at all though? So to err on the 
side of caution it makes sense to not test for them. Unless there's a 
reason you think testing for open braces is important? Surely just 
testing for actual lines of code appearing in a certain order is enough.

