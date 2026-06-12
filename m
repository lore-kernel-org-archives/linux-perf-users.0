Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370D37F8A1
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252675; cv=none; b=t3/gIm79ko4IpKB95U2uKhpv/GvPC3zmHi90dtUXFY6aB0+nab4WxsvkY8DB7tOTPHRlPahfITbc2fy7nwP8mQWxKAQKLmw3EhXuvZtdd7Wp0/mpPm0yXWu/7f+pxWv0ePbT4rA2cdr2TRtFl1m78vcQf+idLKl27cs/ftvKKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252675; c=relaxed/simple;
	bh=pHsTtRh3BgJvRzkVkxECUE2h14thLlMYtqhfQrfyDAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZeXC4zwZ9SjmPozT/oOm5zDz99/HarQMonO7Q8ub8PJ1HXcdh/HfLU44ghPx35VN9lMAlwRrDIjczWW0LL0Na+dAiIxDZLt1rQnu9Ss85uMjFL5bPEmMrT9mGgc1EfLKuOdC8En9sOjtkTA6O+1kbIZnilJGGVM9gy1RagaKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TY/zRNk0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TY/zRNk0"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c1630159bso705142a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781252671; x=1781857471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppN3q6i1kLf7wFBLTi3clAGN0Ie4CZBFcKsjThSzwnI=;
        b=TY/zRNk0OcTX2xzoYUwnHaiuY4dGE5v3Yf/BCLV3UWKEHlZ153j+srcPgtG8b1p8F4
         mMBMrSlc/NBERyh4caQhmZm83ZDZufIFTYniHuUPP0v3vvD8BJknkCJxgGEwFz2H9Z5+
         BI/mX+qxYKn3wPXWPF+Bi51zxxLzgF6FALs9GwhO/riy2Ja5PRLUaRs4hPPNCEgJ3EBL
         CJqa4yZUX5G+dEpl9dwskFCPvmlVwOTr8GmrGZRLZF90IJUOUtbLGv7vfDNeGBRoMYbF
         hdWybRw3i1K4OB4UQueEEOgjWEbU3JCqGtzdH6SbWs2UXCSuQh9etNqnIC8MjHLWSDyz
         NsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252671; x=1781857471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppN3q6i1kLf7wFBLTi3clAGN0Ie4CZBFcKsjThSzwnI=;
        b=N2k1hTkPFVP5JNv/ddCQC4C3DoPM4PeGtB0RPQzqScb5GnXuuj/YXuabX830fRqVAz
         GD5URY1cpubQhdQlXbkazPATdCIRxdUgTXJK6nQCEYoC3O0NLhk4e9tkIYlHfmikebL2
         72uSgaW4mqfsT73uyP1xSDDljBP4N89t8w73O0ttETXOINUApq5SDP3toU7k1/eNuuc5
         jEhAJSIYvEigxs3mEfSOQZYQZhvm0XARfrOHwPF6rbIxWjmCdksvWQBbtVJaFec6Ye+Q
         /1offRT+AKV6RNRG9tx/o2qcSuVAGllgrl1zTFb3JRqAojwxGKA+2Bjr7G6FmhpAKoQ+
         BREA==
X-Forwarded-Encrypted: i=1; AFNElJ8GsPbiwAUTgKZJcMkWU8s86WEIAnRZAaB6gwMuZsAhQmGpvqM58NXDWiPRMHUOQ+bqASgi+npCVFeec8CDI4aV@vger.kernel.org
X-Gm-Message-State: AOJu0YxkidbClV3ZuJi/h/OA0TCM7RxBf3LwgdpJ/AfnP8yqnu4HATRp
	ESSJ35NueqcFTFHYY5vFEcAMCjuoeCALhg6Z9w3hEKj59ZZLJlJH2gz0rQKI53fgiHQ=
X-Gm-Gg: Acq92OGuVYKd2sfj8v8qqIcWyW7sSoyj77z5opl6Qa5u4bhstwzPSCrAfjYami9+JqN
	m7b2KYWLFYINGMGfzNfu8ehxJO3BtLdKA4D8P/ZiTxLMRhMqLSqbPceQRKh+1rVpteWOCWwBnIw
	u4rKeaNIP4t37jx8xznojcGLJPcjCiwZSEddlYnU49S5S7Qig3nxB5kZlh5i0KCfZfL8fwfnmUQ
	SXUrKAFtZgiyjIRFpJC11N2LgKgDS6E4Biq7eUI1f+t+UTLRN6Si5CDXw6Rl3uodF/gl5edqHVT
	JEkP63kKWNnCB6eR9tOXIoG0sc1iHoclDZ9GSWwYfc/9Aey1Dx3dWOKLt0ucgvAaxskH7wb0yvP
	AUFl/07mAosuJ98cpowI2SW3Mm9PPq+xqcXL27RfhwK8y+GHK25SGMgvk74tp1jN2Lj+FLTE35v
	svMYeki6l6qX5uVhlzCLkgD8NT2zyd
X-Received: by 2002:a17:906:ef0d:b0:bec:157:a630 with SMTP id a640c23a62f3a-bfe28e12485mr87169166b.23.1781252670620;
        Fri, 12 Jun 2026 01:24:30 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb44208c9sm77618266b.13.2026.06.12.01.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 01:24:30 -0700 (PDT)
Message-ID: <453d71dc-1bd1-40e0-81e4-c578f64f438c@linaro.org>
Date: Fri, 12 Jun 2026 09:24:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Compile named_threads workload with -O0
To: David Laight <david.laight.linux@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
 <20260611195449.7230e316@pumpkin>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260611195449.7230e316@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2026 7:54 pm, David Laight wrote:
> On Thu, 11 Jun 2026 12:13:46 +0100
> James Clark <james.clark@linaro.org> wrote:
> 
>> The work loop relies on the compiler not optimizing it away, although
>> named_threads_work is not static for that reason, the compiler could
>> still do it.
> 
> Isn't in enough to put barrier() in the loop?
> 
> 	David
> 

Probably, but I don't think it would make a difference for this specific 
test workload, and I don't think that style has ever been used for any 
of the Perf tests.

I think Sashiko's comment leading to this was overly pedantic, neither 
GCC or Clang optimize this away even with -O2. So in this specific case 
it was only fixing a hypothetical which is why I didn't add a fixes tag. 
Although I admit there is some chance it could happen with other changes.

However, I think -O0 is the appropriate fix for a workload because it 
makes the stacks and order of execution predictable, which is what the 
tests look at. And that also has the effect of guaranteeing this isn't 
optimized away, so we probably don't need both.

Thanks
James

>>
>> Fix it by compiling without optimization. Also add -fno-inline for
>> consistency and in case anyone wants to look at callstacks.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> One trailing Sashiko fix from the "perf cs-etm: Queue context packets
>> for frontend" patch series that has been applied already.
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
> 

