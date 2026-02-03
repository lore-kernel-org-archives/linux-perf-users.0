Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013322BF3DB
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115602; cv=none; b=kHDDBGesXSOwbGzCYYovKmj/ei8leBFTcHIOeX9mOWBhXC+AO46/MjGPTIhkGbC/Urxa/QeGm40HKst4unXZ0rBDLS5JV/rmHUaT9mBX5c28aWhrWYwUVTfUIzH1/KW7QTlyIchtfzXD0ueLFvIH+l43ovlQ5bMDKMbe+W/KxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115602; c=relaxed/simple;
	bh=dU5PMbFjeSaZiIXv05iCDeaergWDFpV7s5wXJkHJ8ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eK9fsW52bf35I3SJw35u1twCmSW/sHjcV7j9EngiB621qNdk1UwkeadmL3UfkEfh1xXkMfPt7jpBKC85udDy23SSXB0iPgUUVNT1nm79Byia5+SDlCwc8pOpGiAyOgk0OawQP7cR+FTUl2bZd5CRAgZtJMzXBMM0XA64Pobfp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BcSsk+5w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcSsk+5w"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso46393365e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 02:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770115599; x=1770720399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6pk37gWj4Ao60hHiNwtAWN3UnalWQ7UEtWm6JRc280=;
        b=BcSsk+5wuShsbHSJg8jLO+u9Y0bXnGO3u/lTU4TXhyqU/CSk7O7oI2sBA/XMT1tsgK
         LnQRqJn01jpMlduzn109A7BuPi1seb5b/uY3KTPtIWKRcrob0vrb9jcjOzWo8MAYzwq4
         9xNqoG97gdVgVg9ruXgGp+0OU3pUVWISHYxYxNvbYR++zou9LZHLDrZPfZX1U/lYe5J0
         RBCC2GRwhEM/YZn6iyk2Eq7R7ghIz73VBOVkY9PnDZbBy+pLFmS7t7CE+LglmdMmrBY1
         +jF3kuvHKcwamCJo43w5oEzuxL6QVCyJpmq9HuKIsHCtR6hPW9RZQWOwt0ewnb5TVSCd
         PCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115599; x=1770720399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6pk37gWj4Ao60hHiNwtAWN3UnalWQ7UEtWm6JRc280=;
        b=ehiVXMHHoOmgkYUe4eaBNdSisystAVkZAGZHfSAwfgnlUCmIFIZqQAuE1cQky4NVa3
         T/dxpah7Diy1yEj2PTRQPJucl4uPZmt/jGzWrfNXHavVTdHXksBcgTEpG9gye6hdjbuZ
         vapGZhj+zOzzBMe/9KZXprqENSjTcHqcffi5vB1E9J80oJ46CL92QUVfkDxm9VqmcOga
         FiQbLUuY54TvQbvc9FETNYX33qj+5AMTMzugmTIdocnXGQhGsGM2GBD1VgP0m4So98xt
         AEtQvtmFJu/CHenDTQWHOplfrovnKqyVRALy+TU3QPxIIIWBBxcUmxJBp/RhvwvoL4nm
         9Huw==
X-Forwarded-Encrypted: i=1; AJvYcCVkbnRWciVwIQBxcTBwVWxzGXnkCUhvc6GqgtcgO0ZqC5pdKDenI7HF8gsNsm/1/c2EZMJvNEELotsaWlUzms8C@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOlhbITtwtGYWL1z+ZWFSpzPztBhUj3nJBFoijR/HqhMBQFTS
	dw6PtpOU6XaMTbBKBDetnCl37W0ivcy1Kc5qEwRI9H+ooiv/7wPlCpxkNgr2AOvjuBc=
X-Gm-Gg: AZuq6aK2JVawmI4SggXxA4harrV2Uuot8KhfIDkziCSIIQ288absDyLin9dlsTnL3oh
	ufds+r8i+ozzfvfRy2V8wwbKJM5E2eLa2wPUYHX+oAfIeeRT83VZDLUl0wa0GSHk68IbSbazoIu
	vEXg2qMl0s0jRb0ryWgwlBS3gHgC8BvoVcch3J65FOkozLheyPD6cvtBiYmgwz/802LlCJxLE97
	l/UrLAyYJPXUhSFC06rz62MEGY/lubIfqty1HbgebxorpYUG3iRXra4p60ID/4HWJ+yJFW1T31W
	p/VkwXVeFOAT0Nx+fGWpX7M299CJj4AEtjaPhjB65rXqnLNNbrRNhEMsh+VpdwDMSuvlo19E07h
	aDnyXczOZEbRPakdn269AQ4lLSZSOUGy6BDDvSDwacMzDOASl9Lj4jvhAj3ypbzy0xrHpjcalAE
	C6pcnRYa3gN8LqxBvfO9Lq4DeqrRs=
X-Received: by 2002:a05:600c:6610:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-482db45211fmr187500675e9.11.1770115599291;
        Tue, 03 Feb 2026 02:46:39 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051286e0sm57339175e9.5.2026.02.03.02.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:46:38 -0800 (PST)
Message-ID: <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
Date: Tue, 3 Feb 2026 10:46:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aYD08d42SewAAQCB@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/02/2026 7:03 pm, Will Deacon wrote:
> On Fri, Jan 23, 2026 at 04:03:53PM +0000, James Clark wrote:
>> The Arm ARM known issues document [1] states that the architecture will
>> be relaxed so that the profiling buffer must be correctly configured
>> when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
>> PMBLIMITR_EL1.FM != DISCARD:
>>
>>    R24557
>>
>>    While the Profiling Buffer is enabled, profiling is not stopped, and
>>    Discard mode is not enabled, all of the following must be true:
>>
>>    * The current write pointer must be at least one sample record below
>>      the write limit pointer.
>>
>> The same relaxation also says that writes may be completely ignored:
>>
>>    When the Profiling Buffer is enabled, profiling is not stopped, and
>>    Discard mode is not enabled, the PE might ignore a direct write to any
>>    of the following Profiling Buffer registers, other than a direct write
>>    to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:
>>
>>    * The current write pointer, PMBPTR_EL1.
>>    * The Limit pointer, PMBLIMITR_EL1.
>>    * PMBSR_EL1.
> 
> Thinking about this some more, does that mean that the direct write to
> PMBPTR_EL1 performs an indirect read of PMBLIMITR_EL1 so that it can
> determine the write-ignore semantics? If so, doesn't that mean that
> we'll get order against a subsequent direct write of PMBLIMITR_EL1
> without an ISB thanks to table "D24-1 Synchronization requirements"
> which says that an indirect read followed by a direct write doesn't
> require synchronisation?
> 
> There's also a sentence above the table stating:
> 
> "Direct writes to System registers are not allowed to affect any
>   instructions appearing in program order before the direct write."
> 
> so after all that, I'm not really sure why the ISB is required.
> 
> Will

We were under the impression that this was required for the SPU as it is 
treated as a separate entity than the PE.

In "D17.9 Synchronization and Statistical Profiling" there is:

   INDWCG

   A Context Synchronization event guarantees that a direct write to a
   System register made by the PE in program order before the Context
   synchronization event are observable by indirect reads and indirect
   writes of the same System register made by a profiling operation
   relating to a sampled operation in program order after the Context
   synchronization event.

That specifically mentions an indirect read following a direct write, 
which seems to contradict D24-1. Although I thought this is a special 
case for SPE.


