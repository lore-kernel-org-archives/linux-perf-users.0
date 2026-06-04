Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD940B6F4
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579896; cv=none; b=l3y3OekBcwyd9laqxWeAoce5Kyb8HMZaqSRNx4hj1Rze/SRe2WECuiR/87g0cgGIZgocbCw9S3uQdvHMavp8cGOBRvgXIWqD53aD4kglgZLSSQjWt4e0RnTytJnxSg8DITo8it8f7/5PY91M6PU7XYXLJ+ysO++G0o/dBSJw3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579896; c=relaxed/simple;
	bh=kOyFFVsgLyRTHjGzNqbc0mRHi+Lm0TcVUi4DJKuIv1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmV++11vBwMuaSwPS9FH5ZE2DOuI5vacF/mDC0OYMv6tEwgKRB5EzL6ZbwHB0QIeP9Ji8pigX4Q3blnTKplBt1/Zyc2hpl2M9a6VjLygG++gYCnEnq7zfGBWKxP5awPqcOBvCVOgdFGFuvm6iwJI5uboGxRT2cqrYzRCy76fRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ip8l7wLg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip8l7wLg"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec441e4018so81069766b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780579892; x=1781184692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RpaPlWKAO3dChkQSzu5tZ6cbmxeZTl6U2Q5KqvJNao=;
        b=Ip8l7wLgkCA3A9EDzSVotx7iS2KQ1G/2pV791Ppjql5rpgIXBlteJ+/qA+lBV+G30K
         0tajJcGR0AEcuUqAnK5T3N5WI5ym4onmv15miUIghGjFm06YZXzC2ZjSs7N/M/CZ8d57
         1rhjeCAX5GusOP3RSjVwhTrG27D5liR8lJkSX//W5vUQH3u9GupGG13pBtnBqxmkDjHN
         CbyJvboweU39uJH6bLuh3kDhtTkOOGy5Ra0eQ+BB/qoxOQy1tClTgnQMgrOuGZ8OsK2y
         f0u+lEqP3xt84GumOUR/hP6HpVrEakSfqCm00UjEU2FFeLNmm2IUfZRyNpM2FDekCwej
         rRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579892; x=1781184692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RpaPlWKAO3dChkQSzu5tZ6cbmxeZTl6U2Q5KqvJNao=;
        b=NtD9yhhjkt/qbZEIJxwc6Zq5bp9TSqBfLKGZosbZkdew8Gwdi4tlxucCIpQ6BqSlPp
         Nd+rR6QLtJJYhdvVAoax2OTtEqfWUsDCSSkqSRIviDcXCmkTaplUXiHZwEuavWNznZ1C
         pehdkHk8qBIJWyZJWb5tlaCNRWiMhAJGt8ZTh37us3pTiXprWvB4q3RkXS93SWQ6jvE7
         u4+7js+lGU0JG7/IEcgSc7aX2V9nlqjPShlhEqJFN0xzDjT+EwU/kzPLl9t7kL51hmXc
         eQabArwTSDWUqKC2oHT4GWsgvzxczUksXxrBNV2Maqxo69Fb3afkHqGXP9d4njmDWZo1
         URCg==
X-Forwarded-Encrypted: i=1; AFNElJ9L2+cKV6oc/SzxMIjfZm1POqdULSNZ3sB5nFysbjvG8/ltVCzMLYe/8axKPvazIM5JszTfJMH8NNCrh+w/mQeB@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9Z/kL+FPatMp4ioRvT9l+C/YcI02pbUh+JYrF62Ds/rP46zr
	9CI854Sig21heJnsvbDiLIjmQR+oTq6hfXd64TCKsUJZEeEVSAKybbWLBfjCeNJpEf0=
X-Gm-Gg: Acq92OFNcvjGIjoCWhPBGy6ZP2EsneKluLi4l/t2QwcRwtkvYPIHG3oEyXxZqRn63XW
	4cQIFsRTwje3JWCTN9AuAmHRIodrWWMvULtxUyUIdm9Y+w6bukjGNrUOe1oIPeyW1NHGMnRL69k
	6+heaus0PgDOHg01BvS0YY8HxdeiiXVGfAGExP9FF2lrbYX7TbfTj0QPMczPquurzl5R6Vp9gqH
	Z2qyubOKXQLhos6YkGy6sNXETBxmsu4Z/B6ga71cUTB2GQG4f38Xegs/HrHUniEJfDVvwr8MOAS
	nXsYS7HsrXQiIzUGwzqq/v6NJC/avL6j2m07zbsnQCX5kjPpXHM1qrJ8ah/ca8ktNWfiNSHf7wb
	as0eoN62hFuHHIPXFgQ8QTzWeqFrQMlp+qrhpFgI2jq/fyfxbB4C9ashC5m3JgS0UC9lEyp0OD1
	x7IsZ4q2AfmdWk2Ep7A9CEXw4sRiQpcW/9rAshVWY=
X-Received: by 2002:a17:907:6e89:b0:beb:f71c:63a with SMTP id a640c23a62f3a-bf0ac304ccfmr461348966b.2.1780579891965;
        Thu, 04 Jun 2026 06:31:31 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055303fc6sm309199566b.42.2026.06.04.06.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:31:31 -0700 (PDT)
Message-ID: <8721d1b4-ce27-4ab0-9a24-138c31440e94@linaro.org>
Date: Thu, 4 Jun 2026 14:31:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] perf test cs-etm: Remove unused Coresight
 workloads
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
 <20260602-james-cs-context-tracking-fix-v2-14-85b5ce6f55c6@linaro.org>
 <20260603172546.GE101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603172546.GE101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 6:25 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:56PM +0100, James Clark wrote:
> 
> [...]
> 
>> -When you run perf test, it will do a lot of self tests. Some of those
>> -tests will cover CoreSight (only if enabled and on ARM64). You
>> -generally would run perf test from the tools/perf directory in the
>> -kernel tree. Some tests will check some internal perf support like:
>> -
>> -   Check Arm CoreSight trace data recording and synthesized samples
>> -   Check Arm SPE trace data recording and synthesized samples
> 
> Should we keep the chunk for but suggest a perf command as
> 
>    perf test "CoreSight" ?
> 

I put this at the end, not sure if you saw it:

  +There are a set of Perf tests for CoreSight which can be run with::
  +
  +  sudo perf test coresight


"When you run perf test, it will do a lot of self tests." didn't seem 
useful. And the other part about the directory was general advice which 
I'm not even sure is accurate. The tests are supposed to install and you 
can run them from anywhere.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b539be153f6a..7efb893edcbb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2751,7 +2751,6 @@ F:	tools/perf/arch/arm/util/cs-etm.h
>>   F:	tools/perf/arch/arm/util/pmu.c
>>   F:	tools/perf/tests/shell/*coresight*
>>   F:	tools/perf/tests/shell/coresight/*
>> -F:	tools/perf/tests/shell/lib/*coresight*
> 
> Need to delete tools/perf/tests/shell/coresight/* ?
> 
> Thanks,
> Leo

