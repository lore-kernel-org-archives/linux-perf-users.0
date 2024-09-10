Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647D18FDA5
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977202; cv=none; b=XuFnXgzjqKLrKF7M5grNHt5d0cThWTNDrFxyB1kSNS11peOe22sC3tsABxiwWwQbE4GDeMuSsds9G4o6uV1hhCR3GzJuZiaV5ib/kW+Q6MoUWXkHXqArywOIZHZFdLL9DkHk4g8+Pr0+keUqCfnejOVhZo3e60yegli8MieA0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977202; c=relaxed/simple;
	bh=U8OTsToaWfVMxFIRMdzr1xo9cfxaKTYwFlNjVCRaQ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etYp4jlfJbDZzClVl9c2dMbKkvFWrd1jNr40umRgVPzZ8AzmFeHe4J0WPa5CG7V6LqILI6MH7R+AiNuzrC573nHA7LcdqiOyIHPseTZFR4p5HQA22TVb4METghfMSEO055D7MMaqj0T3g0w4FdUUdWXFDUqqq1UtzV1wMV5Hajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FZZWJ7By; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZZWJ7By"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso7665465e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725977199; x=1726581999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1Z0JUhOsYgTNsTyk5PimUJPDh+yOKaKvqM5P8Qrzh4=;
        b=FZZWJ7BynjwPAbvrKZqpmWOY0ydbDzp6snnbuSBPNaB4zLknCdhBdZzPqxgUhcJWLA
         ihqlK/5K+lxNiIvjZAzvocfCmS00O3GJcyrVTU2LVJwOh/JKEEDzmbpuPcn2zmjU8TLK
         3z+xMKgPOvQZJ2N1ctS56aMfREv9D/JnqDOgEFpMLGIrAYSlvVD8FKYV0r/9KjySAemE
         s2+thar0TnFzqOKw6bbwc6G5+3B3wpxqjaI9o32bthMcbFgnuXNlEaN2ERScdDClGyqK
         rb4XcQOgpPJnUkP00RBJl6i/ecX8ojXhDPXTEx2dn+lq7Fhkzuv+i6LuLeUjYSbqTauh
         OVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977199; x=1726581999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1Z0JUhOsYgTNsTyk5PimUJPDh+yOKaKvqM5P8Qrzh4=;
        b=C44cy4GeH6CX1JlOxw8rPB2Nef3MWbvBd8SKxjKUnKSsvxXCRTZSjJIXIOkMulZvpm
         XXdf1Au7u4WaJTJY/uooWBMu0j1GF9QPd81FHM9TRLxTeUXPPwjnNaqOQmAh29GveKMv
         u+A67Wo5f+Oo/YSVxE9YRyfXNngBamIQrGZxgzR4u/Zvz4B8nK/KNbMz4vK99SZz7RyV
         H6H6AP87ooP5jc5juL1W2Zt2fHR7jW/Xowwb1SbtUwXrbGoTdQ/VuAiNpinweML2hdhZ
         3ToD5ocEWmzQQlN5va+xVS02Kyfuoa9xu+qfeGtwXZfwHcpMHR6FykHvfDxSsEWll55Z
         cU9w==
X-Gm-Message-State: AOJu0YyXLbjry8upVdDINmMVUP8Lk+bsX0dvSX6V8onQy3ooz6EQbe2n
	+kE9QQq2VHze1ndg0dz/KSZ8UNvE9v9/hrEioYIqd+CFbvwj9pcmq2Mqr9oR17Q=
X-Google-Smtp-Source: AGHT+IF+SuIaYUhS9ZzflXfMD7MbhhkHr6SfEY3NmvG6VZJUm6PBixRhQksR8W/YMdbqbZdBl9N98w==
X-Received: by 2002:a05:600c:5025:b0:42c:bc03:e765 with SMTP id 5b1f17b1804b1-42cbc03ea7cmr32813575e9.16.1725977198215;
        Tue, 10 Sep 2024 07:06:38 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5ba4532sm86596495e9.38.2024.09.10.07.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:06:37 -0700 (PDT)
Message-ID: <0900b672-57d2-4e4f-b5be-964da82c7a12@linaro.org>
Date: Tue, 10 Sep 2024 15:06:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240719150051.520317-1-sesse@google.com> <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1> <ZtRIla5pCqlMIKvN@google.com> <Ztbga0xLyt1eaehi@x1>
 <ZtcWwANOWyXEnGdC@x1> <ZtcaC5WOTj-fh_Px@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZtcaC5WOTj-fh_Px@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/24 15:15, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 03, 2024 at 11:01:36AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Tue, Sep 03, 2024 at 07:09:47AM -0300, Arnaldo Carvalho de Melo wrote:
>>>     3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>>> WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>>>      17.58 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
>>>      util/llvm-c-helpers.cpp: In function ‘char* make_symbol_relative_string(dso*, const char*, u64, u64)’:
>>>      util/llvm-c-helpers.cpp:150:52: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64’ {aka ‘long long unsigned int’} [-Werror=format=]
>>>        150 |                 snprintf(buf, sizeof(buf), "%s+0x%lx",
>>>            |                                                  ~~^
>>>            |                                                    |
>>>            |                                                    long unsigned int
>>>            |                                                  %llx
>>>        151 |                          demangled ? demangled : sym_name, addr - base_addr);
>>>            |                                                            ~~~~~~~~~~~~~~~~
>>>            |                                                                 |
>>>            |                                                                 u64 {aka long long unsigned int}
>>>      cc1plus: all warnings being treated as errors
>>>      make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
>>
>> The one above is fixed by the patch at the end, that I already added to
>> the cset where the problem was being introduced.
>>
>> Now there is something a bit more tricky, we'll have to add a feature
>> check to see if the libllvm has what is needed if this appears in some
>> distro we still want to support, since alpine 3.16 has what is needed
>> I'll take the opportunity to drop test building on alpine 3.15.
> 
> Or, as I'll do with debian:11, just remove llvm-dev and not build the
> features it enables:
> 
>    17    13.79 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
>      util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
>      util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
>        178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
>            |                     ^~~~~~~~~~~~
>      util/llvm-c-helpers.cpp:178:49: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
>        178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
>            |                                                 ^~~~~~~~~~~~
>      make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2
> 

I also hit this issue. I think it makes sense to auto detect the version 
so I sent a patch. It was quite easy to autodetect and it might not be 
that obvious to others how to get the build working again given this error.
