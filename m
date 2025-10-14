Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903230F808
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430594; cv=none; b=LMcRWpqLEwAbRAkhX9o5bPaDDV8e5zIYVNY78+y8Lg/cKwBFHbi5Tmt+3dzY7p7fdIpbqXvBuVDpOAFqOmiA0OGoX+2HT23pt6MUmt+tv6hbzfJj0QfYfS0lOGQ0G1x9MH9z0hyVErKMxiGIAsuaT/RSS6hl8vZv/Z2uW0PcMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430594; c=relaxed/simple;
	bh=u9WemJDgzhDrzm1vkp0ghAlUTeBBtXLodqPOpU+l47o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX/J6etzIiCyiNxxd5qVPVIFgOIfhDWUiZaOcNHnD6CwnTkU3b1RJNaxVMmZuoEcrkr1XJXU8ETXqwmfD5cHnM675uTuNTE/FwTB8+D33jGfuM1O/+r8EkHbFuMHp99zDytZrQnbBYXQu1yfHMNfaHMQqP8Kb0MjdC1t2biknNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oxgTO8A6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oxgTO8A6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso4319586f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760430590; x=1761035390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrpS4zQfX/DIeYparCnX9IpLDB0h8rqMiaUVM3cvJQI=;
        b=oxgTO8A6yMFWyFDMDppO/O8y3LL5MCECj40f135bq0bgEJE2chtRCiFLIspmoJN+Wf
         ZwW1bmcxhAb5jVhkUyyqhdK4UO8veNKLVDRd1Dy+VcyMABk1Hocx+3tjpM6oVu2wDpYi
         GKKg7R+UwjZKxHiVCe4+vZ97tbtXeSXjiNwhEFhXlSoz7nogcgXop03vXapKEHA9mE+X
         QpD7FM3kT2jRKt52O26hOlWvSiRN0S2XAkIn5d9YqCR5SbFK9ZPyf5H9iAbmZfgkRSCA
         DSbuRHfDLaEZn8ZKR6R4rmBo3C+jngww7nzTy0QRV3hQE/vyiq1HsVHIpp1Z1CcaEUqs
         gCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430590; x=1761035390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrpS4zQfX/DIeYparCnX9IpLDB0h8rqMiaUVM3cvJQI=;
        b=I0+Jnj6WKLT52BVyu+u/52FncukQ0KJ9YoORSKXTFNn/9yYMR8UFu7mZPseHx/NHOc
         KW0QTEyumFRGoiQNqe4Fpj52QkK3Q2baVUEbcRAxpCU7+8pG0PEz5d10/MEwQEsl3Jmg
         TqCd69VwI2I67RXmh4bVY203rO71R5layWFwZrjVgZ12svhk7LxJYFnqafKS4WUlE7wZ
         yJLPO6GeB3MI/Hsv3k4dHnXB4wV9Z1yFOVcf1anlHiQdcieglPEoM4rmV6uhxScatIQX
         4oSTkIxk8OAPsUPRekfKgEA2VzTfeJ3zp15xo/QE6/ml6ZoESGan9kqiUz7pACcp0Ot3
         6ziw==
X-Forwarded-Encrypted: i=1; AJvYcCX09pYDZ7J27GEM782Q+cu1Q7mdfiUeoWVBN5X9aesUYOauPYClAcysYyN1zIRnfRI+bIu+ZewbXmVtuQfcrx2c@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUntj9povC4Qi3mK1UmtIpu8VZCJmXoS/ADPMZAjUrmWmdN+E
	akcQdQb4CH8LYyeslFQhleOYvDTiOR5K5ccDiFPkcPytaFfwrihpWqSbMmfCSJtQaHM=
X-Gm-Gg: ASbGnctpe5MS5iTp4vmGJN8XL3UZ+GLsW4aR6sNbtqPkdnimUiDsqoe7ly8Yy9r32W7
	nUwRQJM8+NTc5tPUamtRRM4w1cuWg+YS31UeeX4MJ1rGaZ6BrIaE7X28rWa7oDXlLM1D1r7Xzwq
	Pz2WSMNdNCbcBsbUJZRyNxt6+f/OCX3vFE/KcYcpAM2HszN6oG9GCaKIOt4S4BCI2FjwSximQh2
	TtV8LicFe9qkElkoyjFdy2gtv4aZpwW60Ln+O9VjBJPIWG/8v8pRSD4zpIiGYOzg4Lsio7YQPIB
	OSV/OHpwjMTk2RDD0UDab2LK+3tldUuGWLXz2a6lteRhxIiUvHUCTrJJ7ZVIEBYhgvUqRLDGzYG
	6iQ8zaQQ65gHdOwSA8hLNaLFm4H14JGYKNpqWV7latJ9Vg1bksDwV/Dm5jIWseA==
X-Google-Smtp-Source: AGHT+IEK4q98aBS+Tm261m4wowTgHp+2q5HO8L4oX4MvkwEWw/WXidRiXnuHWIPeBdjBYv4s1wVmQQ==
X-Received: by 2002:a05:6000:604:b0:426:ec63:18fc with SMTP id ffacd0b85a97d-426ec6319d2mr1580450f8f.20.1760430590146;
        Tue, 14 Oct 2025 01:29:50 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0a03sm22432901f8f.37.2025.10.14.01.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:29:49 -0700 (PDT)
Message-ID: <9e4d4f05-0c34-46b0-aad9-1431bf8cf9f4@linaro.org>
Date: Tue, 14 Oct 2025 09:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anubhav Shelat <ashelat@redhat.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 mpetlan@redhat.com, irogers@google.com, linux-perf-users@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
 <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org> <aO0ci1wX-J3au0-p@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aO0ci1wX-J3au0-p@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/10/2025 4:36 pm, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 09, 2025 at 03:59:54PM +0100, James Clark wrote:
>>
>>
>> On 09/10/2025 3:43 pm, Anubhav Shelat wrote:
>>> The first machine was running kernel 6.12.0-55.37.1.el10_0.aarch64 on a KVM
>>> virtual machine.
>>> The second machine was running kernel 6.12.0-119.el10.aarch64 also on a KVM.
>   
>> That's quite old. Make sure you test on the latest kernel before sending
> 
> While I agree with you I think that 6.12 is not really that 6.12ish, as
> its a disto kernel, an enterprise one at that, so tons of backports.
> 
> Having said that, yeah, the right thing is to build the latest upstream
> kernel and see if it works, if it works, try to identify backports, and
> only when its determined that it is something present on upstream,
> report it publicly.
> 
>> patches. The tests in mainline should be targeting the latest kernel,
>> especially in this case because the throttling fix didn't have a fixes tag
>> so won't be backported.
> 
> Right.
>   
>> That change to fix throttling and group sampling is only from v6.16.
>   
>> Also what hardware is the VM running on?
> 
> Anubhav, please provide this info,

On the adjacent thread:

 > Both were running on an HPE Apollo CN99XX server.

But now that I've seen the older kernel version, I think the issue is 
that the throttling fix isn't present and the specific hardware isn't 
important. If Anubhav confirms a newer kernel fixes it we should look 
into possibly removing the tolerance from the test and start looking for 
exact matches.

James

> 
> Thanks,
> 
> - Arnaldo
>   
>>> On Thu, Oct 9, 2025 at 3:17 PM James Clark <james.clark@linaro.org> wrote:
>>>> After reading that patch it seems like we should actually be removing
>>>> the 80% tolerance from the leader sampling test. Both instances of the
>>>> cycles counts should be the same now.
> 
>>> If there's no tolerance then the leader sampling test would fail much more
>>> often. In most of the runs there's at least one case where the leader event
>>> has much fewer cycles.
>   
>> That's assuming that we've agreed that any difference in cycle counts is
>> expected and valid. I don't agree that's the case yet and I think it's a
>> bug. I only see identical counts, and the commit message in Kan's fix
>> describes that the values should be the same for all architectures.
>   
>>>> (Excluding s390) I'm starting to think you were hitting this bug on an
>>>> older kernel? Or something else is going wrong that we should  get to
>>>> the bottom of. The test could have found something and we shouldn't
>>>> ignore it yet.
> 
>>> I agree that the first bug I mentioned might be from an older kernel, but
>>> there's still the case here where the cycle counts don't match. I'll keep
>>> looking into it.

