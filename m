Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430083921DC
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549886; cv=none; b=djc9reEO4IjLf965D5qjI8PBm1pSSSwUXAj140Lf1hoUxDi1we0mP65rCXWXm2mX2jmMpUX3gO60+HxI9p18G+7eBt9INv+h7irNPMzU+W7Zra1J1hyZxSfP5tJ1zd2czScQoEKSVv0OZMlgI+P7DHPSUCrxqQIAGkvOJ4pVE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549886; c=relaxed/simple;
	bh=sc9VkNZdxRQj3hWGaSP+0jlEqxJcRXkEOI79dDWJ6/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg+hy9hfTKyz9ulotj8nt4KBjpPG+3O0bMcto/9gJ1QskqIwnLcSgiElTNo9arYQvT/XNfZ7vc1/wn/DHrsFkrycMyhJ6GGI2cFeBhu5yGeH98uLYsM7P3W4RoqEHT0rPMKsHlMpRppH3zu9/Q9/yAKH3xuvP75LmIEQ52CA3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0wcgOCA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0wcgOCA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so45813565e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775549883; x=1776154683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YF+vzkW/sLkkCK6eYuO/W7phgVcJivF+sw7H1piAQWk=;
        b=j0wcgOCAgUfCSsd3CGRw/tp+ELQjI/GSyNLKaLR4l5GP/klvxOewuKBuvC+UwkXI4N
         yk6kmhR8HbtbgjyzjqYaK1cHRuXWL5TWXM+JnR+Hb/snUJ8rebkNEWcDPogspyHp0mXG
         jcnBfVaugVGvFYtXYjHA1zHUUZ7bcQVHWixyJIuvckvA/3hFQon3apkfBZeKRrtvcX7j
         wgHwPpKPjfqaykxfEJfCcLgCnLPMijlqxH5QLduy+UsTEnkFbMoHu0aHuH6mPOm58SSp
         J+BrGbr6gtrcPX7kdFAhDJZQEyYNCjCHGB8u2QEvXzrqEFl86Qc2tBiZ7eLOLeojBG8o
         CCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549883; x=1776154683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF+vzkW/sLkkCK6eYuO/W7phgVcJivF+sw7H1piAQWk=;
        b=RrHF04lq9Pv9I7zWdt3GN06xzCvJGhoBhMI7PIQaD+bKoCryRIVt9NCz/dItPca1mL
         MnLlQPTkSI4TWPdIlVRfiSPJXpLXJrJTSsjripT52YsSItUhr9TD08pmtN+w9U5wgLG0
         Yoor5GaWrqLAi4WZPzuqWeECcTVdXyGnNGoSJAmlaSAxToNlRBQ65XxU9Nj0OH0RJgrz
         rgkrceBers1+H8qKk7a3mysIMDHc2Lpmk7FezzeSM8U1DmKHyvfY8TIpIgxHwK31YDcp
         QIptWrZ/5bL/GZPbSy0wEqCZZJBkyqhAB5A12PzD+x8Umy2Kxc0raiEMhDJhA6DzAAw3
         dSbw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUXgk6ZrfJulURf97XHXcUDyvaRe9kxmocifh1+oPPvRPuZbRwmk3JCoWHhBh/MyLVMJuCevguWBoKtMc4EKm@vger.kernel.org
X-Gm-Message-State: AOJu0YyfS7rrKioKB6fIy8PPxKZIF28D0YTLWwtt+oopc2wQvbyGgdv7
	AdUQZt/QIj+fs1D+LxowLNjKRM+vEkmcWBG9109PN3/AprW3CKumFr87ahpFoGym2RY=
X-Gm-Gg: AeBDietMK9NcZDhyyGKfLXwY1GiLANfViq1+swW35It27yjmaClSe4nj/+kc1tQHyTF
	kIxH2eECHOBNdp7k9H+ClCxCVnNKhI6EqRDHXHp0olo8pXjusdmvphJyAmvPqTBaf5+upWfzDiN
	9dxk0GB4QwWuJS9J4d1eiMFxZFDX9O1bEDGaecNabrhCdrcpVRtWSxmSRY0g9dInoBN2PXMwiG/
	63Dvgp/ACFDGpVDBU1Lz6hK+dubYdgjO6ZfkLlBXRxeO1INrbtrWB47U40jOSgzjw+micaz4ye6
	soghY3ynjcIvtkq9RSVQX3mlgpKajgS2j1jjwZanr5dEKI8o0vEQlHQ4uMEVB26C/G24Dz+O9xI
	sji91fcSKs+1pZdZbgrEhOg4LqaL05vbcb9ktA+vTrzCyl9UbiPtFXX7wRoaDw5IusUJbjXlhRp
	JVn5cUa+17swimO7H2EYKWEpinq+Oj
X-Received: by 2002:a05:600c:5392:b0:486:fa9c:185 with SMTP id 5b1f17b1804b1-488997d69e4mr234861545e9.31.1775549883529;
        Tue, 07 Apr 2026 01:18:03 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm43051405f8f.28.2026.04.07.01.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 01:18:02 -0700 (PDT)
Message-ID: <d45195c7-ad32-4bc0-8d60-4b242cb3e2a7@linaro.org>
Date: Tue, 7 Apr 2026 09:18:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] perf arm_spe: Dump IMPDEF events
To: Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <adP44THdD-HBB8cY@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <adP44THdD-HBB8cY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/04/2026 7:18 pm, Namhyung Kim wrote:
> Hi James,
> 
> On Wed, Apr 01, 2026 at 03:25:48PM +0100, James Clark wrote:
>> In the Arm SPE raw data dump, IMPDEF events aren't printed. Add the
>> ability to add names for some known events or print the raw event number
>> for unknown events.
>>
>> For example:
>>
>>    $ perf report -D
>>
>>    ... ARM SPE data: size 0xd000 bytes
>>    00000000: b0 18 c6 32 80 00 80 ff a0  PC 0xff80008032c618 el1 ns=1
>>    00000009: 64 e7 42 00 00              CONTEXT 0x42e7 el1
>>    0000000e: 00 00 00 00 00              PAD
>>    00000013: 49 00                       LD GP-REG
>>    00000015: 52 16 10               	EV RETIRED L1D-ACCESS TLB-ACCESS
>>
>> On N1 the event line becomes:
>>
>>    00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS LATE-PREFETCH
>>
>> Or on other cores it becomes:
>>
>>    00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS IMPDEF:12
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> James Clark (4):
>>        perf arm_spe: Make a function to get the MIDR
>>        perf arm_spe: Turn event name mappings into an array
>>        perf arm_spe: Decode Arm N1 IMPDEF events
>>        perf arm_spe: Print remaining IMPDEF event numbers
> 
> Will you send v2 or do you think it's ok to merge v1?
> 
> Thanks,
> Namhyung
> 

I'll send a v2, thanks.

>>
>>   tools/perf/util/arm-spe-decoder/Build              |   2 +
>>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 147 ++++++++++++++-------
>>   .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   5 +-
>>   tools/perf/util/arm-spe.c                          |  49 ++++---
>>   4 files changed, 135 insertions(+), 68 deletions(-)
>> ---
>> base-commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566
>> change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7
>>
>> Best regards,
>> -- 
>> James Clark <james.clark@linaro.org>
>>

