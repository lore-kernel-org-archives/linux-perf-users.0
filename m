Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB92BCF50
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918506; cv=none; b=L1awPxqKtS0H6bDZcQr+XaRN1MktjDylVvwEq/UWxfBCxcbhaSLf1lIvHP8JpSeztxJNbKxW4q6Zb1QZmNHN4Y8LANqSOm7YsgDb7T0ywI5S1J+/C4R6FysyRqpqr7MPxLW4JwCedJRDTy9GVo72K2DrROS1f44o3ZKCRdqQ2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918506; c=relaxed/simple;
	bh=yylSKJDv8HkOf0iH+SYlqcQffyWxREZ928vnNlKrMhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpYJChMjYQQ1zUmaN/BqmHrsrWRdkAMngj2eXos087HSAqiWs/06d2rizkzmU8mG4oqfBaF9oGp/4sy2Y0zJye+JEUNfEa8XJA7kxRT7Np0+zvSyRkel6QxT7fGhELt9feUllX6Z+iZWKPZEnx8psoFnreWgsr2aJz+FCnIpg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z90x38ny; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z90x38ny"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso43199555e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745918503; x=1746523303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TI3jdvpeyG/XLxQ3dsLKaff+2PtCT4KthrhFkzjVZAM=;
        b=Z90x38nygZHLQlMLbTcx4J7BKNQ3skhVLdP8aZYZ5rH/RdqkSCQ/IiMYkhxdfm0o+w
         fPM4KpFd0+8rLvVmXtgbXHIzyTIgiHj3Q0shjAf/CZN9cRhdCoiZEjvNyM6R32fvJveb
         ul9ZfypIvW6qqZ2JPdJLXKe91fQZTQRK6c+EYOg1BeOE333s6mtYxEhjN0nNjzrEEsM7
         zr8XMkwzkdc25MXIECUAKkLF/lt0caGQDQIgQ3M0wwIxfwlUMlU5+592pi5mTN38SuT3
         U93Eo7qqPqRCeRPdRPhahpRgAqCVwGT5fLO552j2B6I9sV1r+C30cp0X9c3fHe8XnPL7
         LSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918503; x=1746523303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TI3jdvpeyG/XLxQ3dsLKaff+2PtCT4KthrhFkzjVZAM=;
        b=n2EUmNganc/KAF8UJO5DsAT8p52G885GLDn146c/SnXlLoYhcVMat8Mapm0SSXLv+m
         +asIRSEsnQ4ooj/6DfVcBclJmR8QsCUMq9BEUCFe2vvGO2x33t9fsD7b7a3d0TfN9QJJ
         fH8HlusfIxoE3QAm/g8BdO4uoSA7TEFdBcOrEhWv7aB6xngkW9ZLrgNqFjxu+f3hmU+J
         p4vudpIrPDWrLPExj2eI0wbd+yO1R+9LPWgBDac6mbpspgqAdsZsjwPzC0ayyh/MWmuR
         rgE/TM+F0ymio7aLsOFsTylwqeNpYWW4In0H81QLOQ81FSol3GrRY95c90uGGI8GyVYD
         iUzw==
X-Forwarded-Encrypted: i=1; AJvYcCWSQG+1ksBziu8VRIYuSkqsSoLcGAaU9ZZrFUF0X44f7iQLQdNzhm5wTV+JrcyWVP5h90ZRSswUWOIcd59LNmcn@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcWKg0K244+e3ITKT7MuYbDGVQN5YgNwyY9A7LLd4Wqj7j1Dd
	jvonFIrX5ohC0f2wlBNnGAFAWV6XUHqXVXB7gfABGHytkTyWU/4XFuzUII7rs6Q=
X-Gm-Gg: ASbGncv2zz9Ze9j/dc4In4XcqS8n4+42jKCP4svgB3tHv4EhSS7ecD4pryIlUlKzoeO
	NQsryFaPknRAyHpGS0fuF7iETxSQbmgWHVMfR5l7AxEK+BS4fJTyehuZWgSXHVi3dQkZ//iIF/f
	r3JzuPe1VGudvClBPjWyrw+2X6LmhiAdby4OKw/uDubFN4bI+SBFyaOvgCZSDs36Y/1VddmpoqC
	Cr/Z1bzymE3jcs94SNfYJ8GuZOpoNgbz88LgOroRzXTDVybDuc/akVrQXc7RiUiP+2XfHrSPfT5
	jl9WU3hkHyi1AAorqbVVgpzm3qLa47Oom0dXiUJnw9NByaSFG0tyQw==
X-Google-Smtp-Source: AGHT+IEUGW55N4u/mThqrlEDhA9YSxZ89qDIJshXeMtSzbHkz+MFGGxdrPryOqnbUPm5rxvbTdTFqA==
X-Received: by 2002:a05:6000:18ac:b0:39e:f89b:85dc with SMTP id ffacd0b85a97d-3a07aa65134mr7471133f8f.17.1745918502621;
        Tue, 29 Apr 2025 02:21:42 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c6a0sm13337100f8f.86.2025.04.29.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:21:42 -0700 (PDT)
Message-ID: <b2f05ef5-4ba7-4041-8d11-021aa2c3f6e3@linaro.org>
Date: Tue, 29 Apr 2025 10:21:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, arnd@linaro.org
References: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
 <7703f88e-ccb7-4c98-9da4-8aad224e780f@leemhuis.info>
 <4c92fd9c-e545-47f9-bc67-0dfff962f506@linaro.org>
 <4c5eb1e1-f8ef-46a5-92da-50d77aba1405@linaro.org>
 <f0bab5f8-ff61-4eee-a736-8c2dbd33bc72@leemhuis.info>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <f0bab5f8-ff61-4eee-a736-8c2dbd33bc72@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/04/2025 9:02 am, Thorsten Leemhuis wrote:
> On 29.04.25 09:52, James Clark wrote:
>> On 29/04/2025 8:42 am, James Clark wrote:
>>> On 28/04/2025 2:23 pm, Thorsten Leemhuis wrote:
>>>> On 17.04.25 15:55, James Clark wrote:
>>>>> Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
>>>>> headers: Update the syscall table with the kernel sources"), arm64 is
>>>>> no longer using a generic syscall header and generates one from the
>>>>> syscall table. Therefore we must also generate the syscall header for
>>>>> arm64 before building Perf.
>>>>>
>>>>> Add it as a dependency to libperf which uses one syscall number. Perf
>>>>> uses more, but as libperf is a dependency of Perf it will be generated
>>>>> for both.
>>>>>
>>>>> Future platforms that need this will have to add their own syscall-y
>>>>> targets in libperf manually. Unfortunately the arch specific files that
>>>>> do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
>>>>> into the Perf build. But Perf only needs a subset of the generated
>>>>> files
>>>>> anyway, so redefining them is probably the correct thing to do.
>>>>
>>>> FYI, my daily -next build for Fedora based on its RPM spec file broke
>>>> on arm64 (x86_64 worked fine) while building libperf. I haven't checked
>>>> yet, but due to the error messages and a quick look in the history I
>>>> wonder if this is due to the quoted change, which showed up in -next
>>>> today:
>>>>
>>>> """
>>>> kernel.spec:3115: build libperf
>>>> + /usr/bin/make -s 'EXTRA_CFLAGS=-O2  -fexceptions -g -grecord-gcc-
>>>> switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security
>>>> -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -
>>>> specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-
>>>> strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch-
>>>> protection=standard -fasynchronous-unwind-tables -fstack-clash-
>>>> protection  ' 'LDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-
>>>> relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-
>>>> hardened- ld -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -
>>>> specs=/usr/ lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -
>>>> specs=/usr/ lib/rpm/redhat/redhat-package-notes ' -C tools/lib/perf
>>>> V=1 DESTDIR=/ builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT
>>>> mkdir: cannot create directory â€˜/../archâ€™: Permission denied
>>>> /builddir/build/BUILD/kernel-6.15.0-build/kernel-next-20250428/
>>>> linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/scripts/
>>>> syscallhdr.sh: line 98: /../arch/arm64/include/generated/uapi/asm/
>>>> unistd_64.h: No such file or directory
>>>> make[2]: *** [/builddir/build/BUILD/kernel-6.15.0-build/kernel-
>>>> next-20250428/
>>>> linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/ scripts/
>>>> Makefile.asm-headers:81: /../arch/arm64/include/generated/ uapi/asm/
>>>> unistd_64.h] Error 1
>>>> make[1]: *** [Makefile:108: uapi-asm-generic] Error 2
>>>> make: *** [Makefile:128: all] Error 2
>>>> error: Bad exit status from /var/tmp/rpm-tmp.vAfil2 (%build)
>>>> """
>>>>
>>>> Full log: https://download.copr.fedorainfracloud.org/results/@kernel-
>>>> vanilla/next/fedora-rawhide-aarch64/08975350-next-next-all/builder-
>>>> live.log.gz
>>>
>>> Yes, this is the error that the fix is for.
>>
>> Sorry I had it the wrong way around,
> 
> Okay, for a moment I was confused and wondered if I was holding things
> wrong. :-D
> 
>> I see you were asking about a new
>> build failure caused by the fix. Looking into it now.
> 
> Many thx!
> 
>> I noticed some strange characters in here
> 
> Sorry, that was my (or my browsers) fault (some encoding mixup somewhere
> I've seen earlier) and highly unlikely to be related.
> 

Yep, not related it's just the quotes around the error printout. I just 
need to use $(OUTPUT) properly without the "/../" on the end of it. If 
OUTPUT isn't set it tries to go up one from root rather than being 
relative to cwd.

I'll send a patch.

>>    mkdir: cannot create directory â€˜/../archâ€™: Permission denied
> 
> Ciao, Thorsten

