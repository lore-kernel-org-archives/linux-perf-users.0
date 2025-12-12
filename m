Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6B19D081
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551057; cv=none; b=ZNdDI4moWClLKko3vwk4yi2kouZDy9X0s7d48hQGkxwQlO2k4ptcvrQxmAZLUDcWlUrasr0A2BTRndsgByZhIuisEzuLDtKhveZsYo0g4wZ0kj5azqSlm35FtdkUd5dKs2h+B4mLHBXUQ30pwsviBYhXYouTGnkds6kU1N7NZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551057; c=relaxed/simple;
	bh=F3S/6Wwi9xOYCpVo8Q76NbldA6PKCJWkKj9M3rJexMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya43DMIaGfruovAmymbjW3zC/Puo8h2n4mLVVWyc1AZjp9CyAF9yc6ZDeiwMxQi5J/uWhO8IeSGkYZxwjvExs5sfkPgrveFP3b/wJwoPgDuEIXrUpV91GbmcxW0C8KsYzeWIca3QzjHpBTIddHeNzHRhHADc19KTKGdbCa2+8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uSCzjJq5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSCzjJq5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so2552577a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765551054; x=1766155854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sHdy2ADgTZPMkZ6aLR22PcGlzZUf/wOZQV/WRzdYkM=;
        b=uSCzjJq5NBevbzqaU6Wcf+cjgj9yOmr3DAYZ/+KsonZA5j6+coDna8NptF/iEGa7Nu
         BL2ibBh3yK6V/KvnMYBrJhn64HJ+WQK+Rikf1KCZEOETemAASvhQJZUimZEMJz4JbiAH
         KxGP74UUu9SgcrxT0wFJ6ul4mzheAaP6FmW1+RAATRRAe/Q7vQ9ARe+GyL06kOHfKbB8
         JYx/ANPclpTA+Jjf4T1mhgHn43+cd0FBJ6XSM0H4ntDGrG8VAI4tC0ChyWtk1R75Rg17
         8BHhV/bR0OLmybQ+0B/bU04dOI3v1L4jWqN+1G70aYSJpxMAlX3634YOuktbO4eTmVLZ
         PX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551054; x=1766155854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sHdy2ADgTZPMkZ6aLR22PcGlzZUf/wOZQV/WRzdYkM=;
        b=VYcMC9q6v6l9iR6DAtdJfzT6RhziujPFLNoLWKkQOFr+BOpFtVIlvgK8rtaVqElT/7
         3KnkkAT7j4sEHE3g/rfr45OfBplne/bEzbPSWNkhmsYwIcugUh2WpxessINtCmGKP3w7
         58l9xX/zfG4kivKzzrOoRTWH+f6s3UF8FPST0g2mhefwW+Cip1TpXC8SMMMBrjJkY38E
         YQ1u9QPHq7Ekps7VH9MctFJNlERZf9vam4Teg4VOMmaEy0WuUSWy8YXj9r1c4GKG3WpZ
         iNttvQa2y1xOcw4mLhQgx3ZxzLylV1zw2PufizG00kbFeBiLjEVuLGmINcFKYSvIzMBc
         HDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9uqqrEUW85+tSQF99HHqPEbHF+rB1ij8g7/tVtjNVBbJvxr6c8EUIDIHh6h+r0qsuI0vmSSoXK7EvFdhUzAW4@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXGs1jsxjIU3LsCO5qqvVLhyjg6Er88dvXJ2bkLyUulqeun44
	DxSxGPNmQBYZHZFI7p+aHUKnPQFCLxk0UZFFx0dEKFDHTtqp2Ql55e97h/G9jiDLauA=
X-Gm-Gg: AY/fxX6OW99YICxwZzSLiBBO0NLdMcN0wogkmHN6myzNbSZjhBmwd3YtU9IR2rVJSmF
	mMB7qBVWSJSMioLaJR2MF28Ayz+U+SXccw00biftRbt/L3BRVSigFOWK0Df9/wEkuSAZNqICh2V
	2XhlxIj0TQiN6oRDk8EIFLqJmEah51CsJs9K93EifnoFahkWA375kawIOQAwuYAMqbOSfPBaYyz
	Q2z28+6MVWizc0K66FksDH9AYSyRPBU3M2d5nNndeQHJ8nBrdAJDRXfPzsjRL3ijT/veF+bTrfj
	9A7wZmBUXfqdRjjT+3iDQugVTTtUyRnuZCXP5feSHhH4CjBQKs5V/kvxVfZ3Q5xdZ6BeEv/w+Jx
	NPjfqyAgjm8mg4O1ZYg/CV3/J1VQztFwR5hGODTgkHiTGMJiPPdg6jQRlBHDsiv4TmXKfGlpkBi
	ZX0exxzh2RSnFLNdYl2r5Z
X-Google-Smtp-Source: AGHT+IHbdskdCmAkYG3vG2sMYEBW2mjhBkod6LOvZhTWtcYM3sRHnERtPgTtm3eIUz9lQUSEGEvdcw==
X-Received: by 2002:a05:6402:35d0:b0:649:8a7f:97f8 with SMTP id 4fb4d7f45d1cf-6499b157415mr1924358a12.9.1765551054515;
        Fri, 12 Dec 2025 06:50:54 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64982040fbcsm5499695a12.1.2025.12.12.06.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 06:50:54 -0800 (PST)
Message-ID: <27417fd5-902e-4474-8d60-356a94ac9590@linaro.org>
Date: Fri, 12 Dec 2025 16:50:52 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] coresight: trbe: Refactor AUX flag setting
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-7-7da32b076b28@arm.com>
 <a638f74f-94bc-4052-b8e1-e940aca2d4ce@linaro.org>
 <20251210154308.GZ724103@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251210154308.GZ724103@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2025 17:43, Leo Yan wrote:
> On Tue, Dec 09, 2025 at 01:37:39PM +0000, James Clark wrote:
> 
> [...]
> 
>>> +	if (!is_trbe_running(trbsr))
>>> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
>>> +
>>
>> Do we need the complexity of COLLISION (changed to PARTIAL in a later
>> commit) and TRUNCATED at the same time?
> 
>>  From my understanding, TRUNCATED would be when Perf is too slow and we want
>> to disable the event for it to catch up, and PARTIAL is when there was some
>> buffer error so technically we don't need the event to be disabled, but Perf
>> still needs to be notified if we want to start only resetting the decoder
>> when a flag is set rather than on all aux records?
> 
> The main difference between the TRUNCATED flag and the COLLISION/PARTIAL
> flags is that the TRUNCATED flag implicitly asks the event core layer to
> disable the PMU event.  In contrast, the COLLISION and PARTIAL flags are
> only stored in AUX record and no additional action in the event core
> layer.
> 
> Setting the TRUNCATED flag would be a over-killer if the buffer has
> free space, as it would run the expensive sequence of disabling both ETE
> and TRBE and then requiring userspace to re-enable them.
> 
>> There is no happy path where there is a buffer error, so I'm not sure why we
>> need the complexity of an extra case? There's no harm in disabling the event
>> on a buffer error. Also it's hard to see what the exact scenario for PARTIAL
>> is, because we set truncated anyway for fatal statuses. The comment in the
>> later commit for the PARTIAL change just says "trace was stopped", but not
>> why.
> 
> The trace can be stopped on Fill mode (stop on wrap) or Stop on trigger, so
> it is not (only) about buffer error.  In these cases, even though the trace
> unit is stopped, the buffer may still have space available, tracing can be
> directly re-enabled in interrupt handler, thus the COLLISION/PARTIAL flags
> are better choices.

I suppose this is the bit that I don't understand. If there is space 
left then why is the stop hit at all?

For the other cases, I agree that it's overkill, but my point is that 
doesn't matter because we don't expect it to be hit in normal cases 
anyway. So it's worth the simplification of not doing anything different 
than TRUNCATED.

> 
> Only when the buffer is actually used out (i.e., handle->size == 0), it is
> appropriate to set TRUNCATED flag, since at that point we must wait for
> userspace to read out the data.
> 
> Thanks,
> Leo

