Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C013B293
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856126; cv=none; b=HGQkNOFy7BQYV16B+UqS2HzvRTlGwJNrPBE2diMCScOirBwsKXtZ/md1CLOKojfNX/rwLf3ynQFVtPIa38Ff/MRMJV7ZIbuDM+fJGvablb7/5yuIW54kyu8rS54NDrosUE6VNL0JhaNfvp0iBrFD4noInro6F1IQwBVCCUaZzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856126; c=relaxed/simple;
	bh=bKZcUM4R8qu+bIeyk+A8TiUztSnAXixp6m7EmgfhTac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Akk4M6alQX7G24prTI/G9/qvFsShx1SkdY9GrwArGweCXKAsePgzpd3yEiqXMC3fkoMYA9QQ2p0VA37y1pPs5XXULL7iIEzeuIlgdpdQBS2TyjlbKXbchuSXiiknKMnYuNEkPniTauIrYQB1cb7stgBQDFKkJ+9ck20yG7IQH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r6CyX4IX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6CyX4IX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so9553895e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764856122; x=1765460922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSmzlby0QxkDml2TLqk35SaCbc5wltAvOYPrtePTW+Q=;
        b=r6CyX4IXIADB++0M2czIL2gVmEEGirQcE4LAHibwKIucBD59eXLi3TS0V3/VEFvI50
         3q4IshKLfiyuRXcaCHUQcj59jzR7JXSIJCTJYTHtSMIZT4XqJL+zHrGclbiFzKo7cJmn
         EEREK8+Zea1XavMh1onISjbbioRXbTb/hjnKB9ahEumqwLPOeTCh4SNY5Bv4SX34ioXv
         XHfxw1rm+VRQpE9ssoy4hkeU2mZPsKy4Ngp1FXv6P6a+1SEr7MTzkrOwZdZXc73lOzxR
         t1r/Fh51E0xw9ec/neFBYYLZbmkjEsUyriDBewdNLdU9lfxfcF3Rw2SvLBVaChxqgXmt
         WLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764856122; x=1765460922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSmzlby0QxkDml2TLqk35SaCbc5wltAvOYPrtePTW+Q=;
        b=tnGOX2Aif49hc1fOt2DsvJSzobDvvzSe7AhsbpNGazEOFX+r/yvjK1cSCpXjN3zLdL
         DV3WQS2l9ZI7pGqxM+/ByZYuV1erxiltg+SgmUjEtkBc9NTcMQg+GfWadFiatc3zAwtQ
         GmB6PwmZ+PYWzqXVtCZJZwrf74zc+ImYTAKRtsacCv+4JE+38JG0Y18ZdrAVj9lvadob
         uq3ZCm6v6qiSLtqhwoGvBx+hxw0HytgUxkZHv3GOrn1yJmJI+CRCdJ9KcnM1O6UTOQOF
         Tn90Lcc7zoZ5mGZMNPjr+9Q2CM4cz+0kpiCvkpYM4UkSI46nis5XIVE9sakHJiCOSTxs
         CAIA==
X-Forwarded-Encrypted: i=1; AJvYcCUCH8KBweF9U67A8c9HSzaFIblwLTF/Q0yPEFrvcYCr1meoHoQEZ+vK/v4UU55tWRd16DW6zeaBTEL1F/nznqkz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8T4kdaahJlDFxNSGGs1xHl0lyqdaYD6TatMkvso3BfZ3DlZcq
	wtkfmOW7lDpyO2OFvlsfygLd+AXnO6Q7TZXrRFVezM8Q/5fnUe+NLs6u9lNulJBGL3s=
X-Gm-Gg: ASbGncvOekI4VIBmFH/vLV7yIO9Xcx9mcOtxx4Un1XV4cErlm4A8jIb/tdbi49O12Sr
	VHh/nczkhb2aubvsl1SqqeZUuMw73/O18VGD3W8VkPqw3FUwYHRfTiW2Qg4ev4yalHHrGCFcKHZ
	9/7c3ew4ybg1OQamzzTxuKhNeFSOiugkB/XTkhdtiDwitt3y2EU5wgmCUIu1K+VFvEgoRpCGIF7
	qZ0s919MNahwcTyCPYNGr0VYoDjEvw6LMqPNHdYS2qDyphodrMbBkkDO+fUsvB29w9ZoC7z3vXG
	0gxGvMzvKcYQV1Xg1QSGMsj+YedZWR06iWlcVdXYnwObygvuy/UxP2Y/j9F7H7gBN3LpftXtz2s
	poWfbti5qXDfcQ7BO2eOjufmTNQHDzUoNjShuFSsQr1dudBFO2C7sq38SIsYn32di7Wz+bUxPVH
	z/l+T/kwL4QyMfFrpLeOxBFM6u9Wk=
X-Google-Smtp-Source: AGHT+IHhuWnPxDBYXMFRfc5k4QqYpRN3fnrmMm8SaBBgcHLUbKT5rPR0SBJCh2vK71cX/9bR7W04Dg==
X-Received: by 2002:a05:600c:1e8f:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4792f3861bdmr25709275e9.22.1764856122118;
        Thu, 04 Dec 2025 05:48:42 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310c802bsm31044775e9.6.2025.12.04.05.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 05:48:41 -0800 (PST)
Message-ID: <745f9aa8-6f09-46ac-9612-536fa8292825@linaro.org>
Date: Thu, 4 Dec 2025 13:48:40 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] perf cs-etm: Don't use hard coded config bits when
 setting up ETMCR
To: Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>
 <20251202114300.GV724103@e132581.arm.com>
 <53b24702-eb3b-4e08-bca3-70402eaf4db5@linaro.org>
 <96c54895-cebe-4247-86e6-d41b8be0dd40@linaro.org>
 <CAJ9a7Vgn+HBSO0d3s-x+vjqk3Zfm2shpW1di12_OEZVSN6S0yw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7Vgn+HBSO0d3s-x+vjqk3Zfm2shpW1di12_OEZVSN6S0yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/12/2025 1:45 pm, Mike Leach wrote:
> Hi,
> 
> On Thu, 4 Dec 2025 at 10:55, James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 02/12/2025 11:53 am, James Clark wrote:
>>>
>>>
>>> On 02/12/2025 11:43 am, Leo Yan wrote:
>>>> On Mon, Dec 01, 2025 at 04:41:07PM +0000, Coresight ML wrote:
>>>>
>>>> [...]
>>>>
>>>>> @@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu
>>>>> cpu, u32 *offset,
>>>>>        case CS_ETMV3:
>>>>>            magic = __perf_cs_etmv3_magic;
>>>>>            /* Get configuration register */
>>>>> -        info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
>>>>> +        info->priv[*offset + CS_ETM_ETMCR] = cs_etm_guess_etmcr(itr);
>>>>
>>>> I still think cs_etm_get_config() is better than cs_etm_guess_etmcr().
>>>>
>>>> For ETMv3, we directly pass CONFIG to the kernel, and after validation
>>>> in the dirver, then the value will be set to ETMCR.  If we already know
>>>> the config value is consistent between user space and kernel, why
>>
>> One other note is that since moving the timestamp field, this is no
>> longer true either. The value in attr.config isn't directly put into ETMCR.
>>
>>>> introduce a redundant "guess" operation here?
>>>>
>>>> Thanks,
>>>> Leo
>>>
>>> Because userspace doesn't always come up with the same value as the
>>> driver. For example right now in ETM3, ETMCR_RETURN_STACK isn't set
>>> depending on certain conditions that userspace doesn't know about.  ETM4
>>> has the same for TRCCONFIGR_RS and maybe some others. In the future,
>>> other versions of the driver could do different things as long as we
>>> don't break decoding.
>>>
>>> I didn't want the function name to imply it was doing something it
>>> wasn't as that confused me a little bit. It's definitely not "getting"
>>> the value. Maybe "guess" isn't the best it could be, but it's not far off.
>>>
>>
> 
> Perhaps cs_etm_synth_etmcr()? We cannot read it directly as it has not

synth is a good name, I can use that.

> been set at the time of creating these headers. (unlike the sets of
> static read only IDR regs that we do read).
> 
> When in perf mode the only configuration bits set in the ConfigR for
> either ETM3 or 4 are those generated or implied by parameters on the
> perf command line.
> This info has to pass from perf to the driver somehow. Evidently many
> years ago, when only ETMv3/PTM existed the easy way was perf.config ==
> etm.configr, now that is no longer feasible.
> As long as perf and the drivers interpret the command line attributes
> in the same way - all is well.
> 
> As James says, the actual configr can differ from the synth one - the
> key is the bits that control the trace format - e.g. cyclecounts,
> rather than trace filtering e.g. userspace/kernel that affects the
> drivers configr but not the synthesized value in perf.
> Decode cares about format, not about filtering. Additionally some
> things - like return-stack are implementation dependent - optional on
> PTM, not at all on ETMv3. If the trace unit does not support it then
> the drivers ignore this. the only effect on the trace output is less
> compression if retstack cannot be used.
> 
> Generally decode needs to know about things that affect format and
> function, rather than filtering.
> 
> Mike

