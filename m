Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA76200106
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358119; cv=none; b=ZDh0LS4bssqLmzqzj/VA0+K4MP9YHKSi4CKL49IMdXoqdIh2+iuEtKibGASTva5TbJb4B+o860lE8zhzbUEXSp0EHLLvvzqk8yybPgfVDjlJGLPZqKlpH+x1/jgLsGmGK15Ben1Kb9N+bob9dGqYgU9PfxHiVoM4KO5Qcx+JFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358119; c=relaxed/simple;
	bh=Mn1QK+aoON3rYu+szlpT1sadCQOrFdOpHCzqjYoAJ8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fQg1yimkEmzp+/j8dOQZ0I1LZBG/h6AhPVIECmEn6CpK4nyEodH5VQO0O2l9uMVKN3v9hoYWvE0rK9ZTrb8WpjpuNLb5tBHtze5Hc9ZDuGKJ4eERfbNJ1VfG/ck+fTj2J5yLCWcjjPkzKwai3w+lE8WITCaCMrgDSMuWQtr5rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/m+PLsD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/m+PLsD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43626213fffso7430665e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736358116; x=1736962916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pH13aNiEqe4dlmRSRlCD6aVixneaHpo8RLuNm26iewo=;
        b=x/m+PLsDYJRA4wyWw//2JaePiwzKbrPnHS6XbiOOwqV1W8PahcCMjWOLdD28LS5YZ+
         a5NtH3hjHm1xjcYLqky08JlfxW9hhjNNRhDPEnsADyGh2ilQxUoWNo6GrwukFPJv0Kxh
         ySYwVrDKQtOeQlVBSaNnPvLl7q0KOEYP3VnHnZSmdwc2vM9bL2fUozqmS6PnpF0btNw/
         nllu0jfVOgesRXPrynCGebd3jmfVjyof3jLhR06pR11Q+d02zgpYnBEauMc00teGkkQS
         9l9bhiU96ZToE2G/BZGxeZw0ry83uqWisjrJ5GCDPSBvJFYsJkhOreh//RH0sATBvuL6
         qTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736358116; x=1736962916;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pH13aNiEqe4dlmRSRlCD6aVixneaHpo8RLuNm26iewo=;
        b=KB9IDhi/om81Izmjix1PZ/ury91ZM0DymSo2sBvinYe2MYmF8Sj3iaCuM++lfJGF+Z
         OUMfYjecwxMZM82cgAvqkUGi2lSYzMlomoOVTANedZMWI5DfUBw0TAMG/LxDzOffgTEd
         bFNphRLT95ckampW2xkhf+eBSF0EPfOeq4nwjm2znCiTcY0WOQ0j58rSUQrGwXKAoHNM
         zwt7j0+ezncE+vhhGzs0fedrr0yKsxUE/DSunV/92Gl2Rn1afjVX3W+ezMMk/pvQ8nn3
         rwO8acLO+3ENwg/5vXVs1MDM4cArg8N2gp0wmheYppkCI4GAN+r3BlgyCogTeNViBP1U
         brOg==
X-Gm-Message-State: AOJu0Yy0L4ZXnJ4vB1F6dhMBKKnXXeuL9+6Uy4hCfO1V4h5ySC/JRPPz
	UCek6IHSNetgEWO32QuVpll/DL1hHX9QnCkF5xpRW69ghQLNIbFDr7ys1mZUfuQ=
X-Gm-Gg: ASbGncsHSQAc6+kGTPuXx7FHr1YKwA8A7QvUi9MiOfPQjakimfTjF40VSy/Uzu/398q
	wvZHXhAuj2JVUY6dgN0ZTKngTOsX8mBew9qV22i8l26m7WLyBDxKpORy6v1EKFlwvOPHVfeFdDT
	AuB2pbpa3a0ngZtliD4Mt/1+3hXwQTfaYOZ2pewsgI6Fii9TP8nLBHuj4cxNo364ul+hVceaiux
	/06b4dEP0i5jFW/QcRkvF2YdlSyo1CC3CHMwZesn0hMjwrrOX+JKcM9gk+vCVmZ+l0=
X-Google-Smtp-Source: AGHT+IG8LdNpEL4SWf4D1T/ymQ4wSC2LwPNOnCTwT+6z9Fn3Hb+IhKCJi8cNPHjArA2oX1w+GGq62Q==
X-Received: by 2002:a05:600c:46c7:b0:436:17a6:32ee with SMTP id 5b1f17b1804b1-436e8843d81mr1673755e9.10.1736358116496;
        Wed, 08 Jan 2025 09:41:56 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2de8eb0sm28232275e9.24.2025.01.08.09.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 09:41:56 -0800 (PST)
Message-ID: <c2d6551a-2345-4d6c-a0ec-06096a4d3a21@linaro.org>
Date: Wed, 8 Jan 2025 17:41:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf hist: Fix width calculation in hpp__fmt()
From: James Clark <james.clark@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20250108065949.235718-1-dvyukov@google.com>
 <dc6b9a84-75d7-483d-87e5-3f5d76858d67@linaro.org>
Content-Language: en-US
In-Reply-To: <dc6b9a84-75d7-483d-87e5-3f5d76858d67@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/01/2025 5:26 pm, James Clark wrote:
> 
> 
> On 08/01/2025 6:59 am, Dmitry Vyukov wrote:
>> hpp__width_fn() round up width to length of the field name,
>> hpp__fmt() should do it too. Otherwise, the numbers may
>> end up unaligned if the field name is long.
>>
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   tools/perf/ui/hist.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
>> index e5491995adf08..34fda1d5eccb4 100644
>> --- a/tools/perf/ui/hist.c
>> +++ b/tools/perf/ui/hist.c
>> @@ -121,7 +121,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct 
>> perf_hpp *hpp,
>>            const char *fmtstr, hpp_snprint_fn print_fn,
>>            enum perf_hpp_fmt_type fmtype)
>>   {
>> -    int len = fmt->user_len ?: fmt->len;
>> +    int len = max(fmt->user_len ?: fmt->len, (int)strlen(fmt->name));
>>       if (symbol_conf.field_sep) {
>>           return __hpp__fmt(hpp, he, get_field, fmtstr, 1,
>>
>> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
> 
> This seems to right align the field correctly with a long name. Although 
> it's worth noting I had to add a long name to make it obvious.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> I saw some other existing issue with small column-width arguments which 
> is changed slightly by this patch. But I don't think it's worse:
> 

Ah maybe I was looking at it wrong, before and after are the same with 
width=3, apart from the intended fix. False alarm.

> 
> $ perf report --fields 
> overhead,overhead_sys,overhead_us,overhead_guest_us,dso --column- 
> widths=3,3,3,3,3
> 
> After:
> ------
> Overhead       sys       usr  guest usr long name  Shared Object
>    63.78%     0.00%    63.78%                0.00%  ld-linux-x86-64.so
> 
> After, width=3:
> --------------
> Overhead       sys       usr  guest usr long name  Sha
>    63.78%   0.00%     63.78%                 0.00%  ld-
> 
> Before:
> ---------------
> Overhead       sys       usr  guest usr long name  Shared Object
>    63.78%     0.00%    63.78%      0.00%            ld-linux-x86-64.so
> 
> Before, width=3:
> ---------------
> Overhead       sys       usr  guest usr long name  Sha
>   63.78%    0.00%     63.78%    0.00%               ld-

