Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B21449EA9
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580046; cv=none; b=OF6KDrzJ9WcUA9rLF3i1dQPOJl0oz8hcblHXWcb4mCYEvSrDK972c2ITrMWcc9rV1hcyIevbyo5KUB4PVWmNsSQvUe1xAhVMKLGZBaRdL7rlKfkDi0wJJ2k5hms4vdETrwa+QJjC+DC12VF/Xnjw7NVpXqjQugJKpw0DN4UHNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580046; c=relaxed/simple;
	bh=Q+2riaQ4bkpEOGbfcGsgWYBHaiPit5haYTT9ORAITwU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eFyu5H102kmUoVIniJaVX5lqiiUv/AFSpljtrFZVDZzsKj16DIxN8Fd6nSzj7zxjTJP19TArwL33p7nDWPouZe7DMP0cNgmQtsSlOHHdsrWh7DuhE5hdpoHmv6waQO+MuOXGaxWczTzesU4vEmPxH4A3t7b0KQR3T6fPhxIYGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQFA/tQI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQFA/tQI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45efa80e0afso612762f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780580042; x=1781184842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ue7J7mL4SO+to/BOU4/AYhoa7RJi/0UZqIbNqRbPrJo=;
        b=BQFA/tQI8/d2OKczypwOcm3HGsZXNaEtutbHxYFxwcDcysMaReER/Mx6QAPwRY9r0Z
         Wr7IjlSzy3UUMxH2u1HwDYVzcZN1U/+lHbRo1MUjUvU46MJUkVrgMn3FTVHSu/waEfGR
         ngV/nJAJWzs5rDPsSZlSHOwY4caG6f1YAl80J0vcj65JH+DIVvbwXcrf21h3axQIm6sD
         MbeHUzhKZ+PjkhIF9DY5Dk2e05ApCzVoMmGddPlCyNJK1wBXGAo+m9gDagoZegqXB8YQ
         5WVhSr2OkHNNhCWfKfUYX0m2+hd4675/9sV8usKZgenyuCVZ8PEbxcemZ0CtdMFT8ULg
         oKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580042; x=1781184842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue7J7mL4SO+to/BOU4/AYhoa7RJi/0UZqIbNqRbPrJo=;
        b=dnnW+Kqn1JYgbaoVj8II2cu2MeoUk1jKb9vYJzxp+dMlZAcvUXtsCju7WT7UvmcMlT
         jvIz4YOWLQc0nQ+u2gzKTYufDyQMqV5qelAWaqLp6avCBBUIZJyYwRm+QzK9SbAjBXwc
         5drEIHXK1cLU4MQeqkhFPnqdfDBY0GNiR/JtsJbLgzMairbHLI38eYtm7Z/aJWcCy15a
         qsrpkDGRx5Q0N2bCwXgRbl4fxa70ZOtnZoxXal8PU6oTZJTseAy98tG6rfZzVB4yPTb0
         3S1Y7QToDltlsVcrObi7I/GTngkaRrfBvSR10dMbV7lQm16FoAUSla2DRzwnJ1OKfd6E
         LR5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9VjFB4I3AF/eH4XkAW9c+9Vty8J6XtOvAp4w/y4IozWx+GMsqbrdabLtET4swscoRU3/rAzQbJc5RVm6jggnyq@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZxdqGYK6/+h5N1jS/xCPDgPRFcoB3ZUy2NLnjUWFnbLtxXbJ
	Ty6FwYq9An9dGv+j0OesEGELOrURyvursp08+Y6qoTfglo3ZLyL4ZLhezPJi6rjkbiI=
X-Gm-Gg: Acq92OHUTbQc2nrwc/artnmmZX1xwfWbkzE0n/DdzDiL/3QGeBXybrzWqQ69egb+Pxz
	hDMXvcw9xy4cwIMig/VikP+lkESTKToEBzhAJe+50mux6G3B2PgT0NWVO9HAtg26JyE6i69cfMe
	nOqzxmnlvlGMtQqNjSl8HS5JKGI6GiVDgCp1wJE3/Amsj06G7oWUghhdLmaCpuoOc7K2qbq1NcN
	C+NOUDuoj7Uuo+iVx76TD3rPSTUWCT8SBi2tdOQxXspITcwsNPP+2db8cLOm6Vflxb8FGT8Xq3y
	DkoSjADjSdxjVIIkWF8/n6VInB6mFumUTHNqJ8Xd/YS8gyXFJMM0mm69VFYxxr1k+bso/W7J31+
	/OaWtmZEifyYDE/cxOaK4XCG2yBe8k5/x0gE4qkS2UNpe7N0cF7M7f4p2zkxOE4C3gwkQj3QAib
	f09bNd1zUl86wSt5lGIet3RZjWYELo6mb8FwrHXmwfkIkzdYBElw==
X-Received: by 2002:a05:6000:1cc8:b0:45e:ed7f:1d9 with SMTP id ffacd0b85a97d-460216e6c10mr9128085f8f.17.1780580042209;
        Thu, 04 Jun 2026 06:34:02 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm27068067f8f.27.2026.06.04.06.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:34:01 -0700 (PDT)
Message-ID: <e7118c8c-a9a9-4c34-971a-ebc93f193fc0@linaro.org>
Date: Thu, 4 Jun 2026 14:34:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] perf test cs-etm: Remove unused Coresight
 workloads
From: James Clark <james.clark@linaro.org>
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
 <8721d1b4-ce27-4ab0-9a24-138c31440e94@linaro.org>
Content-Language: en-US
In-Reply-To: <8721d1b4-ce27-4ab0-9a24-138c31440e94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/06/2026 2:31 pm, James Clark wrote:
> 
> 
> On 03/06/2026 6:25 pm, Leo Yan wrote:
>> On Tue, Jun 02, 2026 at 03:26:56PM +0100, James Clark wrote:
>>
>> [...]
>>
>>> -When you run perf test, it will do a lot of self tests. Some of those
>>> -tests will cover CoreSight (only if enabled and on ARM64). You
>>> -generally would run perf test from the tools/perf directory in the
>>> -kernel tree. Some tests will check some internal perf support like:
>>> -
>>> -   Check Arm CoreSight trace data recording and synthesized samples
>>> -   Check Arm SPE trace data recording and synthesized samples
>>
>> Should we keep the chunk for but suggest a perf command as
>>
>>    perf test "CoreSight" ?
>>
> 
> I put this at the end, not sure if you saw it:
> 
>   +There are a set of Perf tests for CoreSight which can be run with::
>   +
>   +  sudo perf test coresight
> 
> 
> "When you run perf test, it will do a lot of self tests." didn't seem 
> useful. And the other part about the directory was general advice which 
> I'm not even sure is accurate. The tests are supposed to install and you 
> can run them from anywhere.
> 
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b539be153f6a..7efb893edcbb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2751,7 +2751,6 @@ F:    tools/perf/arch/arm/util/cs-etm.h
>>>   F:    tools/perf/arch/arm/util/pmu.c
>>>   F:    tools/perf/tests/shell/*coresight*
>>>   F:    tools/perf/tests/shell/coresight/*
>>> -F:    tools/perf/tests/shell/lib/*coresight*
>>
>> Need to delete tools/perf/tests/shell/coresight/* ?

I delete /*coresight* in the later commit when moving everything into 
the coresight/ folder, so only coresight/* remains. I think that's right?

>>
>> Thanks,
>> Leo
> 

