Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64423A75A6
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190700; cv=none; b=RaXZQQZ7hKIq+FTdCxwuPOyp5kpce77IFpUERKhselqp4d51uTAyKVzuQsIpczvQTSLMy+84HK16vht+LWgf7Hh4FLjhwmeuv25KnMOvSfvzlBufPg1/xPM+KTzO01u/JD/9PplCJJ7pRdiYfO/4ZWQwJvlKw4M8WmNsYVgBjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190700; c=relaxed/simple;
	bh=OFfMbmhFlpztf4GrLXCUWh8HSsj5kyncAzyCoJW/GgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKD0GyICP9AuGdhMjKUvZCRqdVg310Zh751NAWB+OVxWAmvKu/pAtAaP2EasGr8/nIgND4OQBTPfsruKK4r3O7k8Sj7aHUFEGbezHFekENLlCRv0utUrRBEwCU5cDl8n2BPIX1wCUCf1jll3D0n7Coz/uQUSwajLbn078gWkjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Omp8uPnc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Omp8uPnc"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-692491fec0bso5860847a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781190697; x=1781795497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ov/F30wJHn+0lwS3O5NBWdMUO+e2BK5WvLx212UwCo=;
        b=Omp8uPncP1dJ59cYz37i26J1NHuaQdAKBkjOnnXmNII+nTVtTeFjbZ3IbdbYhOOWQu
         reEb3+G6zQ69ziXTw5shAbBqHVLYQZku1dNFnq+aVMXZkhsxgAJlCk3ETOgpGRzXsbb6
         YY75X+2+TgAhKYb3Mfdx4tFaK1Pl9teslbFqUUW0HUPjQ3xVV/Qud79of7PVmws0is/P
         zK8oC9Qjcc4I1XDmqe2TtMGHPXDds0b+7b6IezKkXaUEMpNzbxOMvMQLWaEPTQO5RgGK
         ODhWoHufkAdlvPr0CRdxFlWBhKy3BjJLXTS9aGme8EJO95FZhB4O5Q9CHZ3cpzm6jQ3S
         EkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190697; x=1781795497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ov/F30wJHn+0lwS3O5NBWdMUO+e2BK5WvLx212UwCo=;
        b=OG/Gyf3O1NvQD2sCSmK3klkgKvRiEvVuIZU3Mh28yeZt1A200sLLueU3/IuADVh2lz
         ddPuksc01AIakOydfpHd0f87BdPw0fApb/Z2l97NBdcxJo3J2t2ZpLbTICkLdjYwPIj9
         iJDFQhMmzstz6SPIVH41P5Az1f/A8N0TB4xiZvxucBy994J8dYZ7w2b0Qaaid55+PGTh
         oItsKNHpnMTYNclPeItfi2OVrSQBx2lxSZYeEL8DzxwdH2lQb83kgsz8DhHejvkX6YLQ
         0kUys+AMrVZqWPvXADIQD8Hfo3y4dIa2ODxIcuhSiWQ30XioIYgn+5wcTCG78VHP7/6m
         1z1w==
X-Forwarded-Encrypted: i=1; AFNElJ8V7gkj6Jtj6hGqkTAe71OrVhIiLwfITFZ0nnJA/v89dWL2bUMeAR2qY555gPA3Y5LCpUIm6KHTgQEDSvovCv1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEobv7fDIpVMJL4xDgAF+twZ+/3w45uBfYrbsmxUX13IVjzUb
	HuMIZ41XE9c43SV0t91ywzpio8eIQHAHHw+0tkEnlJtqlbDN6NvFMj7CvlMxdMdEB4g=
X-Gm-Gg: Acq92OEK53kLd/1EzTbrifmfK6e+9jCHE4fN9yONcU817VHBq7zcV676pHvaqMTsuGb
	SJ1cQTIkvTcUQZQYLxYF6hn2X4q7chty33/P57TwiiE2xJoa7MTsK6cb7UgTEwExg/dR3bc/aLb
	6gZXkogzXNaUmj6fNhRKTw1+GsekIJFsI51VLBZd3b8y0vzw7imiZ+ATXx/kucQ7z+mtnVqWLBI
	CegdaSmIkKWSXREGrobXumMU9i3erwTNZXw88K174RTlBGGhT+SpsaxQOB9vmyPPBbKbRmxE/SM
	oztBPN1L3cYJDz7Dk2JYcyguNdqSc2gsFpMkOy3MMzh7mX5M3hPIzgSncS/bHmcLXzy1EgaW7qs
	vxAesrTG8jAJ7/kvhcXrDfu8k6/VmAN13hSEvEV4YDeYDSvYx/RY6kzcMsXNVhnA0a1fjsoHw76
	JzBgOnG99N73auDj/Vu7w0Gcbcn3DkmY8JLO1z5IY=
X-Received: by 2002:a05:6402:13d6:b0:687:3580:fc26 with SMTP id 4fb4d7f45d1cf-6930e2b7190mr1806379a12.13.1781190697225;
        Thu, 11 Jun 2026 08:11:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm7249748a12.19.2026.06.11.08.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 08:11:36 -0700 (PDT)
Message-ID: <d617dec9-9413-4de0-8bc5-4ecd2e1abba8@linaro.org>
Date: Thu, 11 Jun 2026 16:11:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Compile named_threads workload with -O0
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
 <airPimFmTCute2PT@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <airPimFmTCute2PT@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2026 4:08 pm, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 11, 2026 at 12:13:46PM +0100, James Clark wrote:
>> The work loop relies on the compiler not optimizing it away, although
>> named_threads_work is not static for that reason, the compiler could
>> still do it.
>>
>> Fix it by compiling without optimization. Also add -fno-inline for
>> consistency and in case anyone wants to look at callstacks.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> One trailing Sashiko fix from the "perf cs-etm: Queue context packets
>> for frontend" patch series that has been applied already.
> 
> I'll add a Fixes tag pointing to that cset, also a reported-by sashiko
> and a closes, for completeness.
> 
> Thanks, applying.
> 
> - Arnaldo
> 

Thanks, makes sense yeah. I probably could have been a bit more thorough.

>> ---
>>   tools/perf/tests/workloads/Build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
>> index 75b377934a0e..7bb4b9829ba2 100644
>> --- a/tools/perf/tests/workloads/Build
>> +++ b/tools/perf/tests/workloads/Build
>> @@ -26,3 +26,4 @@ CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>   CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>   CFLAGS_inlineloop.o       = -g -O2
>>   CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>> +CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>
>> ---
>> base-commit: 7336514f41e75d44782fee7e0990d4195a3d3161
>> change-id: 20260611-james-cs-unformatted-per-thread-fix-followup-babf28a4e640
>>
>> Best regards,
>> -- 
>> James Clark <james.clark@linaro.org>

