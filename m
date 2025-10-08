Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D121767A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922656; cv=none; b=Teb9gV9yIh9z0GvsBpN2s13jNppM5fCJaGn2JBOFLkE6UHdj3ebfuL623//OLe7aMkWa/qlvf/2RDuvjzIQ94y4b8j8EL3IpxKMrj0k6G530fN7rtimJCcyRzLsrAIP3Zg8yl8RZWtIrVjg838wJ/T0U7qmwOMPWBdAJLwf3CLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922656; c=relaxed/simple;
	bh=EayhN+7SAxWZPlkJfFnjV3AW17hD4MGHUCwlSSCrdcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmTUafHV7rHOet1CJWd/Yc1Pls9A4/xkXS9A//VDHWIuJ3O0j7Po7bVjVeZEAtAMdPiECDTsIcv3/800eAlpdTpN9WRkVohIPEBSg7sG51PxK1M3Mgk5msHSyRmnxCwkypWcNGTbSoItnR7lGyKGIJeVsAcJh7+dXehMsI2aECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yg29ShjN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yg29ShjN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46b303f7469so47508695e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759922653; x=1760527453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxCpWxnbuxzafJAcwUoMWnGeMixIxITv5AqxWDo+5E4=;
        b=Yg29ShjNrWhE5/Ed190DjwWHiyXsD3Z+NZjN3+KERzJbVAiJfQnIst83tfVFLj6ll3
         /90thPJN8LfD4c7V7tQoAlLeE4u9ozpt/IAfzN+gwh/sCqPJNM738xyoBAs0x99VZ0cl
         cn/ceHhPZGuWNHikCFXWwyH2bGt349lMAiLOT/3lsAybk1cg9Ofef6OLTqM6E+/Yit7L
         ENqMuHDFMotIp5P4qsmCGdR3iDiIsiyygStw9fdtozFgXRZJsKHvTwZggJSYECrxS5yE
         rzAYcH1Jf6T5PMJtuF+3FQIZHtZwhlcijCZGFWrSs3KDzeH3GkBW6kkU3E4ufopEAFtE
         3BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759922653; x=1760527453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxCpWxnbuxzafJAcwUoMWnGeMixIxITv5AqxWDo+5E4=;
        b=nUyg4k24BMMtn2+osvlV15zKJ5YLOXOxDKguzQoJtKRYPAfzDyh/6+2eDsK4JXvQ7V
         jH6G+oUXDXZ9OTzBJaBYZhTWLNpaekFc1eLgUqd3JhXRTWXDnhWTfW3n3UBVgfZZ8XIb
         14cw85j8aZPPLZ3WguN2iHyWncZ6XFoYXdgUCxdRJEQ7iI1U1d8ZpyVENep50NZNkzCG
         wOuEOZr7hOBDfGoe271fgDS3FY6G5XSTZhJvrQW+VNeXgd5tJp/5aMN38L+DCn5szouY
         gSK0kcpJ9R+fvA1jzFrgGcuvWJYtwBg6RA/Ddu3Sdr69AeniWAc9Uy62PfQEeOMn6IW1
         5Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCXqi1zOPZlvJc4n+Za/RowWYL+KsGm6Y8AyWklvL+TFzZwuY7GbR25G/0bbs5s50petANt7zhfmM6SHl7GUennI@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwExNp5uKj6ecS+c5DbSCT9asAfQ4mDkRuLgnxLzN398wcjd5
	EUuFlCdivVCQifdEjqarvuaw0poEwxgOhH9Yx/evGFoW5Rtoz+0A98lE7dJUcj4dFhY=
X-Gm-Gg: ASbGnctExNp5XmvWJVcCyTlptQu3ZdZDyhXEBjOztwsPetSR0ymO+xjv2qfbN/0lEp7
	8pYP3M6YTd8/wAIwZ4M+4oHXyrBkwWAiDC/g3FTW1cWp5eOSL1mBX4LVt14jMUfwUPm0vtGBDK7
	AAlsd93e820qgAeyrfnXzBR4ZSSZt7t/lDwSAaPgwIhNix5ajH2piN9MEDNxRTSD6jVP0IF2Uwq
	0YBeS0N3+s+N132eRTvX9cXODbL9Mk7uDJhRGMekcgl/z8usN8ny2M0D/HGKNaQ8RIa5rUS6Xqm
	IYuKpZtpx98CtJIc9LyqRFrd1WOt7oK0H6djp5tUfvNm2VE9qwGrrAEJzK1yhk1ZS9bXZjZpIxQ
	8o7JxtEv1tH/CCWAOoblEAaiQ9bct5tTiLtbhB4KdUtFFxeW9FThWmvTl
X-Google-Smtp-Source: AGHT+IET88e5SHIR+qMVlh+T1ffTflwo62em8LHiC6PcUpcorGMk44nhcvPUkzM/0cFTMxn3TIg2Cw==
X-Received: by 2002:a05:600c:350b:b0:46e:6603:2ab0 with SMTP id 5b1f17b1804b1-46fa9aeff11mr23495685e9.24.1759922652901;
        Wed, 08 Oct 2025 04:24:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07a83sm37054045e9.6.2025.10.08.04.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:24:12 -0700 (PDT)
Message-ID: <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
Date: Wed, 8 Oct 2025 12:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Thomas Richter <tmricht@linux.ibm.com>,
 Anubhav Shelat <ashelat@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
 linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/10/2025 11:48 am, Thomas Richter wrote:
> On 10/7/25 14:34, James Clark wrote:
>>
>>
>> On 07/10/2025 6:47 am, Thomas Richter wrote:
>>> On 10/2/25 15:39, Anubhav Shelat wrote:
>>>> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>>>>> If cycles is 0 then this will always pass, should this be checking a
>>>> range?
>>>>
>>>> Yes you're right this will be better.
>>>>
>>>> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>>>>> Can we use a larger range to allow the test to pass?
>>>>
>>>> What range do you get on s390? When I do group measurements using "perf
>>>> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
>>>> always get somewhere between 20 and 50 cycles difference. I haven't tested
>>>> on s390x, but I see no cycle count difference when testing the same command
>>>> on x86. I have observed much larger, more varied differences when using
>>>> software events.
>>>>
>>>> Anubhav
>>>>
>>>
>>> Here is the output of the
>>>
>>>    # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
>>>    # perf script | grep brstack
>>>
>>> commands:
>>>
>>> perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
>>> perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
>>> perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
>>> perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
>>> perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
>>> perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
>>> perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>> perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
>>> perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
>>> perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
>>> perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>> perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
>>> perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
>>> perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc
>>>
>>> They are usual identical values beside one or two which are way off. Ignoring those would
>>> be good.
>>>
>>
>> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test passed every time.
>>
>> Are we sure there isn't some kind of race condition or bug that the test has found? Rather than a bug in the test?
> There is always a possibility of a bug, that can not be ruled out for certain.
> However as LPARs on s390 run on top of a hypervisor, there is a chance for the
> linux guest being stopped while hardware keeps running.
> 

I have no idea what's going on or how that works, so maybe this question 
is useless, but doesn't that mean that guests can determine/guess the 
counter values from other guests? If the hardware keeps the counter 
running when the guest isn't, that sounds like something is leaking from 
one guest to another? Should the hypervisor not be saving and restoring 
context?

> I see these runoff values time and again, roughly every second run fails with
> one runoff value
> 
> Hope this helps
> 

That may explain the issue for s390 then, but I'm assuming it doesn't 
explain the issues on Arm if the failures there aren't in a VM. But even 
if they were in a VM, the PMU is fully virtualised and the events would 
be stopped and resumed when the guest is switched out.

James

