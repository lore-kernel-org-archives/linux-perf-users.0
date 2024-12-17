Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B31DE3D7
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429494; cv=none; b=kJqwv9Z5rogL4DENqS4FSEy8W4IRT9uz9hiFfr8tpNBJaRHQgMlGl0NrVWTRPdSeBtFiCWEb3Qqox2+AUGAqHpFn7zFZB8cjqoADlPPrcAh5Oulh+HzVyQdvyZXlgaSM2x3BA+lU8EbNoQkzXG24i6hhmhYivf632fwvlzDBa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429494; c=relaxed/simple;
	bh=U6oBPhvDLx0rEmMRcE+K74j+YiLxx5/kbqELNfLlE3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Are+VU1PFOQqeuLqN6hYfL46/rQP1LJ+EFJARn2tD5xWf3MQzR9ZyL4ieMHQXC0TfpKN9uNvtVlX53vRgk6+O23WowraGFuIoDf1qwitPky1w1Nlkx2CDfX7fMPvwnhEyHhsT0Gy3R86KkXLwwCDg/GnhRCH2zT7tZC8LMZWV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVIqhT4I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVIqhT4I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361815b96cso33706165e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734429491; x=1735034291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/VKyM8ryPjHMJUY0N3SOuUv5n1VPnB0Cz+2hkmq5/I=;
        b=bVIqhT4IuCSD+XtRU6u4lI4j+5NsAzW8Uq+v2XzZMHjePc0FuuKhfiOI4ySFbp2VV0
         eYooC1yBDxJ3Ii1xw0HDF1XKeRprILPKOx5hOPhUjtDURAb8shHuh8r85Urx1GFzYggD
         OLrl95DK5mPRciMet90E3jnUhGGgMTp5RtE5EcSRN/t8push0YdAgSSFRqZuZYQnfjLE
         Glzj8OA3fNegufX6izGVhd9oZuwZn4zx2kPYmT/rFsrJtUlILyIP2lRdiCnOvxMTPRQV
         7CITpePNKSCBpeVvm5EL7wpSCJZV9DWB2ynqeIyyY/CP9e9tnwItp67+PJpR9OgYIGkL
         5edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734429491; x=1735034291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/VKyM8ryPjHMJUY0N3SOuUv5n1VPnB0Cz+2hkmq5/I=;
        b=k5mRQI33Skz9EUCZ59KETlzPGx++IARKQLJk+11j0Q/S2zxUh0TUMZEdHypneAwJ6X
         /I3nkx3ZxLab6s1xtnusRvGrK5t0eQx+6ppwCh7rrRL31dZQIJE/8i0Sta01IpVGR0aw
         rdjGyr/X4razsuBvboIpCGOHPYuPVwP40WYU3AoiIRYl6T1JXc1OMIhr5yhTfZOpE2A6
         GEdoUX0Qo7/IpAFikcoewtFXGEjnksbuhUdFh9gUK9PXznQZ5kr/KbRLagMbJT3Rg8Wy
         1icuhLmcssR7imrZGGlAyypyhbQNoAcf1WEFMQwAti3HKUE/VuthKF0yntS49pzAEvXb
         UF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3g8C/uVyid5fHsHw1tXXxMXY7nUIyIms68uw6gfI/X0MYTFxSgMI0eW+rQS+gHBUXzRYD1K+YcootWRQ57B8V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+e96yZI+fF1Tyv94qTU3uxhswAc7cu0Yl6gmGKTs5Tfkx+Vm
	mrLhdzZIqkT/zwbadfyMrBKGWfK/YIuGEk6BOxIKpwvk3ZGJBzovPvBKQ5GPbgE=
X-Gm-Gg: ASbGncu0k9B4OTpw/dc+NtVek2KfXeEiM++x2altCjtqZ07ViClf7XgGGNxpjj1PM8n
	9vgN4QC4mRaVevscvXdALRJj+tYOGusRJobEmr9u+gO7l5fKUShZ53aOQaWAl735v6pTLNYOEOJ
	vnUbR3GzJaY1AO6O9Ic17cUBZmtojmiI77hLHOpZMS2aQG3c4XvpXM9t7fy9xy73EZcTq35C9Bx
	f6923i++o4ax6cQoNLL2vGGyqc1Z8NWYRVwS+CmkFaxCA+TlpAB9+gem129C1uRJjk=
X-Google-Smtp-Source: AGHT+IHZ5G++DI6ac3nyEo1wQgi/CHocyZJfFsN7w9MxFXI87OESVz+Q9Oxf6gwUCboWcpHim+BSPA==
X-Received: by 2002:a5d:5f42:0:b0:382:51ae:7569 with SMTP id ffacd0b85a97d-38880ac7758mr11514269f8f.18.1734429490745;
        Tue, 17 Dec 2024 01:58:10 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c54bsm166398105e9.13.2024.12.17.01.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:58:10 -0800 (PST)
Message-ID: <cb11fe5e-e6ab-4653-b925-4c3cb5273b43@linaro.org>
Date: Tue, 17 Dec 2024 09:58:07 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
To: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
Cc: 'John Garry' <john.g.garry@oracle.com>, 'Will Deacon' <will@kernel.org>,
 'Mike Leach' <mike.leach@linaro.org>, 'Leo Yan' <leo.yan@linux.dev>,
 'Peter Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@redhat.com>,
 'Arnaldo Carvalho de Melo' <acme@kernel.org>,
 'Namhyung Kim' <namhyung@kernel.org>, 'Mark Rutland' <mark.rutland@arm.com>,
 'Alexander Shishkin' <alexander.shishkin@linux.intel.com>,
 'Jiri Olsa' <jolsa@kernel.org>, 'Ian Rogers' <irogers@google.com>,
 'Adrian Hunter' <adrian.hunter@intel.com>,
 "'Liang, Kan'" <kan.liang@linux.intel.com>,
 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>,
 'Xu Yang' <xu.yang_2@nxp.com>, 'Jing Zhang' <renyu.zj@linux.alibaba.com>,
 'Lucas Stach' <l.stach@pengutronix.de>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>,
 "'linux-perf-users@vger.kernel.org'" <linux-perf-users@vger.kernel.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "Akio Kakuno (Fujitsu)" <fj3333bs@fujitsu.com>,
 "'nick.forrington@arm.com'" <nick.forrington@arm.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
 <ee89c235-a126-4874-994d-b2489eb1c00f@linaro.org>
 <OS3PR01MB690303F6D0FAF71ADDE7AA4BD43D2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
 <OS3PR01MB6903A0317D8BB90A9B4DD7E8D4042@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <OS3PR01MB6903A0317D8BB90A9B4DD7E8D4042@OS3PR01MB6903.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/12/2024 6:35 am, Yoshihiro Furudera (Fujitsu) wrote:
> Hi, James
> 
>>> Also in the common files, we're using the description strings from the
>>> Arm ARM. I noticed that the ones from your spec are slightly different.
>>> This is ok for now, but if we add any new Arm cores that use the same
>>> events this description may get overwritten. For example
>>> ASE_SVE_INST_SPEC in the Arm ARM is currently "Operation speculatively
>> executed, Advanced SIMD or SVE".
>>>
>>> If you have any actual relevant details that are different from the
>>> common string, you should put them in .../arch/arm64/fujitsu/monaka.
>>> But if you are ok with the potential overwrite (which looks like it
>>> should be ok) then you can leave them as is.
>>
>> I think it's okay to overwrite it, but I'll check the specs.
> 
> Regarding this matter, the descriptions of the events added to the common files
> (common-and-microarch.json, recommended.json) will be modified to match Arm ARM.
> Then, we will write current descriptions as "BriefDescription" in .../arch/arm64/fujitsu/monaka.
> We will post this as a v3 patch later.
> 
>>
>>>
>>> [...]
>>>
>>>> diff --git
>>>> a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>>>> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>>>> new file mode 100644
>>>> index 000000000000..80bf17fb8f4c
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>>>> @@ -0,0 +1,8 @@
>>>> +[
>>>> +    {
>>>> +        "ArchStdEvent": "CPU_CYCLES"
>>>> +    },
>>>
>>> Other cores put CPU_CYCLES in bus.json. For user friendlyness I would
>>> put the common ones into the same existing groups. The same issue
>>> applies for some other common events.
>>>
>>
>> I will update as suggested.
> 
> MONAKA's event grouping is based on the grouping of "neoverse n1/n2".
> We found that the groups in "neoverse n1/n2" may differ from those in other cores.
> For example, "CPU_CYCLES" is classified in general.json in "neoverse n1/n2",
> but in bus.json in many other cores.
> 
> As a result, it is not possible to completely match the event groups of other cores.
> We will be checking the current grouping of events and modifying them as much as possible
> to match the other core, and will post this later as a v3 patch.
> 
> Best Regards,
> Yoshihiro Furudera

Hmmm ok, I didn't realize it was already inconsistent. Still it's better 
to try to not introduce a third variant though.

