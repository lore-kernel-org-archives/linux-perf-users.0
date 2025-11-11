Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D534FF77
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858321; cv=none; b=e1cOTTrfKKSTzxjBcNJygeueCIP0X/T2j0YbU+LPKP3NgcUUv3robST5zPMdncr2G1L5c2TxfhUqfPNreK/6FIxudkPxLXpO3k2sQSFuuOjMVf71Hplm5eUVAmELWsLL9ff46wowf4ek7gNSAqI2Pq/me9h4iiCslqEN8AdKon4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858321; c=relaxed/simple;
	bh=m6qWbR+1BOc5g/YUkO6gL6vx0ximRu5ja0IB00oIB0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcJPtqztffhPV0bZoIUzJe5NbqdR7odUSYBGsKATB2dFGJ4m7+DxGCxuHCxuBFu7qCAmqtOCPNbKflPXNHZse9TS0lFvu+5go6IcdYg9FbKl8tbW2qq7jpyXNCgFqrO+BIW0YK4xVNVVuwqv3aYY8/lfTyjXHJbt0i0wb2vIsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ier0bqY4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ier0bqY4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b312a08a2so2083259f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 02:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762858318; x=1763463118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4fv3AqTrlyRPmxlWB1ltGRDPoMxkylJndccFFj9vmU=;
        b=ier0bqY4y+RoD0OaNwkAWLgWuSC2uFSSOkTQfQsYfQ2ruONR4dtT2K53RqfkxYFcxr
         oaLUAPg8rBbgqkpfN7QzzpYhMD/hF9dcmEx34NBHm8PytOhZnu3kFP3/ztqlIY3dcY6Q
         YsrA4dnQ5znrLze/0Q1fpqCaWY0/FE/W7vo/B/qYUUBNVbi5HiEBJyamdt9zpW8UJK90
         G+AQP0GrC3frGjFx/ud3OTwQwVGeOf3gxI9tlIuD388EzqxdhtjtWrK041tdPjJhrSl5
         V44aYDSnHv4dO4p9gtBP5zKZg2TzmapjKQr24OA/YYrdPx8OZhAjeGKQGe27z6xa77Uq
         7ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858318; x=1763463118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4fv3AqTrlyRPmxlWB1ltGRDPoMxkylJndccFFj9vmU=;
        b=pQj5HWY3prfIHJBW97pd9w5tjEC8OQrGs7hkRlyP0cE179ZebpFe4Mpm+1eyFvvASh
         8MsnMvz0WRgUgLl1j/5KxUATICjUNX6S7A9JJYJSfRAp0o5UD2lQ6int1BZoAJBrJPtv
         +VIwq5VL9AmhYYXfBl/vG+WTws9GyJ8cE0xWDyVng9SwrzJIM0QZtH2v9Fjr2EnMstcy
         TF5y/DyzoPpSMT+cYOL6k+9PVT2BJZJJZdadP5hDuEFfvRXWP3MMdvbIHFr+nsGL96vQ
         e+XDDXMzqQBe1Yo7yOO183pbTTMaHerHNb2p2GssCxGceyVaxola6/Lh4t0gT4GRuexD
         Qbpg==
X-Forwarded-Encrypted: i=1; AJvYcCXCntXxR5pWAksE6ZzmtICnUxuREOMrDrmVttWM1/POotZr6Wj/RoKpQ27al+0eXGXqHxMI3pw7JWTB1PjW2bLU@vger.kernel.org
X-Gm-Message-State: AOJu0YwJneB6Z22S6wZcqzQ2PE0CFaCQKpPNuOwCHMRVMgRSavWZ/uRT
	mKPDZdPKmHxvd+ArBHppnqRlKCoEDDLqsOu11xkSFdXO8p6nsqijeeGL06iuBmcaZvg=
X-Gm-Gg: ASbGncsBL6JDas355Hw23UySwtamI1gmCjNdvKB8kdgvl/PpMWEgo9Wiwx9TtEa2myv
	8KBFaIVUPvr5O8UgufhprgUrjFHmOco87e+Pm23YTKIgoJLhnW58kXSCN8zSbXlmAxaycDYuZgV
	2rjSHe/CJeGQHZ5SeeGUjvnelhL/cAkFf86R4CkOe41j/8pEWPkQBTjyIyOhLhl3KI5vO7DVDLR
	wZmT15GtK4xtXey4KQ85w8OtjkTEnZMO5YW88ULHZWahUjFLSTAMr4LtKGUhQQuQpYIjl0d9Sf2
	FE1THNg7qQ+AnXJQqsx7UBMtWyT77jibYxnfttQbL46qYevmTQEv63qRGOqJEbZ6dlUBmw3XzQZ
	szjxZ6cwophsBSpUaKkxOBG6FSQkBPnDCGkyHHJyH9nb7Rt0njL7IXoeHc63rWfngXxSS6/otAL
	Q7LDL7RQ==
X-Google-Smtp-Source: AGHT+IHhoshuEgKwX8/Ru0TwidruwNS7pASY+Vm/EhvoTXpz7woWAzVfFchx4yQuMVjUwDXm+8FRJQ==
X-Received: by 2002:a5d:5d87:0:b0:42b:4069:428b with SMTP id ffacd0b85a97d-42b4069458cmr4219569f8f.51.1762858318427;
        Tue, 11 Nov 2025 02:51:58 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm17429537f8f.16.2025.11.11.02.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:51:58 -0800 (PST)
Message-ID: <8078e440-e97c-425c-b046-987b642640f7@linaro.org>
Date: Tue, 11 Nov 2025 10:51:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] perf: arm_spe: Add support for filtering on data
 source
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev
References: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
 <20251029-james-perf-feat_spe_eft-v9-2-d22536b9cf94@linaro.org>
 <20251110154827.GA278048@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251110154827.GA278048@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/2025 3:48 pm, Peter Zijlstra wrote:
> On Wed, Oct 29, 2025 at 03:46:02PM +0000, James Clark wrote:
>> SPE_FEAT_FDS adds the ability to filter on the data source of packets.
>> Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
>> when any of the filter bits are set.
>>
>> Each bit maps to data sources 0-63 described by bits[0:5] in the data
>> source packet (although the full range of data source is 16 bits so
>> higher value data sources can't be filtered on). The filter is an OR of
>> all the bits, so for example clearing bits 0 and 3 only includes packets
>> from data sources 0 OR 3.
>>
>> Invert the filter given by userspace so that the default value of 0 is
>> equivalent to including all values (no filtering). This allows us to
>> skip adding a new format bit to enable filtering and still support
>> excluding all data sources which would have been a filter value of 0 if
>> not for the inversion.
> 
> So from that I'm reading the config4 field will only have like 16 bits,

The _data source_ is 16 bits, but the _data source filter_ is 64 bits.

> but here:
> 
>> +#define ATTR_CFG_FLD_inv_data_src_filter_CFG	config4	/* inverse of PMSDSFR_EL1 */
>> +#define ATTR_CFG_FLD_inv_data_src_filter_LO	0
>> +#define ATTR_CFG_FLD_inv_data_src_filter_HI	63
> 
> you claim all 64 bits.
> 
> Also, afaict:
> 
>    #define ATTR_CFG_FLD_min_latency_CFG            config2 /* PMSLATFR_EL1.MINLAT */
>    #define ATTR_CFG_FLD_min_latency_LO             0
>    #define ATTR_CFG_FLD_min_latency_HI             11
> 
> Still has more than 16 bits left.
> 
> 
> So why exactly are we needing config4? Can we please get a more solid
> argument?

Each filter bit position maps onto one numerical data source value. The 
16 bit field in the data source packet gives us possible data sources 
from 0 - 65535. The 64 bits of the filter allow us to filter on a subset 
of data sources (0 - 63), but that uses all 64 bits of the filter with 
one bit used for each source.

I think you are assuming the data source filter can only filter on a 
single value as if it was interpreted numerically, rather than bitwise? 
But it's actually interpreted as a separate filter for each bit, which 
allows the OR semantics that are described in the commit message.

It might be clearer if I add a few more words to differentiate "data 
source" and "filter":

   Each bit of the 64 bit filter maps to data sources 0-63 described by
   bits[0:5] in the data source packet (although the full range of data
   source is 16 bits so higher value data sources can't be filtered on).
   The filter is an OR of all the filter bits, so for example clearing
   filter bits 0 and 3 only includes packets from data sources 0 OR 3.

