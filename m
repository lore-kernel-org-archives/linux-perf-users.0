Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F17279356
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913148; cv=none; b=o91xZnLlx6lWrgqp4fC8N3xiEJFnO2DuLLzHQ1UjRdJIJHhtg/zdV1Vw/xwW8cVF2oIXLKGcUfiB2/1q2Mx903N9MbRAe1w60Za+EactltmqMvLzqE/pFF0Dm3pYP+GTIsRXxahG+OOddvo5bxn1/vXCXYFxkXlcNfJ7+QGjfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913148; c=relaxed/simple;
	bh=f3kOrGVppFlTurzyKRffUEWgIU+mOrq3ADeX0U8XaFI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dRymtQ+/5Nt6/EScFpc/lG1B91G4oe9p9wVliyef9G/MvYNc9wWQGBQ2QwTFxsBIW6YQUGYxDFEmGZNRcli3u//rz0JX4a+b6gYxH2U/84MraC89WucWhI3c7++r9PG3CtXtG527YKI2kVynSTy3CDJGpRiw0g2TzcvaQiSiHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=plXnjQue; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plXnjQue"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c266c1389so4125610f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745913145; x=1746517945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IP0g6Az1qg6/PdzbTEpbc2W905Osm3FKSg9EV8HEtrU=;
        b=plXnjQueqEy1y78R8r0bGDOEMp6NXsmbeZxEW8uWP4gI8OQNc+HtfXJJnaN9J0wcqi
         SLzi4M+jNvhHsLQzIUCKVpANZZtQhZoBUPfC1WP83cbGvNxShI3FU5a+ajQqi28pMUWA
         W0UK8PIa7qcm12xdvOdilcgxNtG8JsxesV7NNxVpmWpdrk/Sxt6R+tVLGBVgQMf+Ll/A
         hNa7DPDXuUJmJfRMWbM90swQK2YcPB0wlNaREHep5lZvVoKN4tHiggVuUtdR5SR/QRrL
         GcjZIZbpZdD1s6ggkzEo9F6U237tS3CqinZrJZKCNBEim2KBsyXkidHTd0wUreLMTdJ4
         zHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745913145; x=1746517945;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IP0g6Az1qg6/PdzbTEpbc2W905Osm3FKSg9EV8HEtrU=;
        b=Tw62WqT4ba1NpqihqOc+ZvmnQOppfsOCOZLGbnWWBNf7TKpuDS3yCs09GB10WmFF5M
         Pqp0ErR4ZTpKsIDbe4M6AdCrOYWUi+E9/WnGvV09tNyKzASsAFv45RBZqrOJ+jXVM6JM
         aP9GsE0kgF8/k7CuxkilPuMwM4/wAXcqFjJWiHVZwlxz8NU02EZD54bb5l9S6UMHBTOK
         5tYn4mPj6Wh6ptTxoSAgHwuXLQhHhF70Gh3awt9ltrhhwy8tMovJkbagy2ZGp+Juu7D/
         7vZzg3acOkfckW1/jHtRXt60VTDXLP0Krv4b50d0eOwiof8IGLah6zXXVtQzF4DaBsV4
         WyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR+YJ6RufTztcCnbYqndY74mHRRl0oeT3TjvFc/vv/fdyLRgtojZ9x9AZAXY3VcVStA0Y4JJsUDBLe6KCzsAnD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KmhGCDTgfwTrYx9kng1XhfHCKCUsuvvBDwYCS9BVr2njPjZM
	z/cUW96ximeWlZDSs8JFX1ioJGiZYWMIQaZT+Kp5EewasHziRKEeK6nTGaWut6Y=
X-Gm-Gg: ASbGnctS6aunVGxq4+Z9E0O2DVwb4NFAhPLcTb/e9FlYM5W7Evyuhiie5sSFBE+BRGT
	egvBzjrOckzzoRoQiF+WXImX3eHGeLpwJLzY7fOPFk0fT3iKuo4Ku2uwsAtWEiUsmNtLMHjYv0v
	6gGoPvt8H3sxQTdonSl8KW9lPPzZKtKcn3xmjAkIja3Jb686TeH6ksPVzUVIb5u3p4M0tNpvJ8M
	ZaeG5hAj5KDGC04PXTW6kFaA5hCbAapRABntGC/XPvAnaNU3lQS8eXcS4lU1Zvryz9aETZEXjfJ
	W1KGln2/y5QPiAA7iuLDfhfds2GP5kh9nrprlZ38i5Y=
X-Google-Smtp-Source: AGHT+IGuBGfFJec7/To+e+YvCZS6DGgY+MBgTwoivHQuGe6+RlkaR/yseql0t1IC3PzvnNkFfvupOA==
X-Received: by 2002:a05:6000:430c:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a0890a5862mr2211069f8f.6.1745913144897;
        Tue, 29 Apr 2025 00:52:24 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cc199fsm13354105f8f.55.2025.04.29.00.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 00:52:24 -0700 (PDT)
Message-ID: <4c5eb1e1-f8ef-46a5-92da-50d77aba1405@linaro.org>
Date: Tue, 29 Apr 2025 08:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
From: James Clark <james.clark@linaro.org>
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
Content-Language: en-US
In-Reply-To: <4c92fd9c-e545-47f9-bc67-0dfff962f506@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29/04/2025 8:42 am, James Clark wrote:
> 
> 
> On 28/04/2025 2:23 pm, Thorsten Leemhuis wrote:
>> On 17.04.25 15:55, James Clark wrote:
>>> Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
>>> headers: Update the syscall table with the kernel sources"), arm64 is
>>> no longer using a generic syscall header and generates one from the
>>> syscall table. Therefore we must also generate the syscall header for
>>> arm64 before building Perf.
>>>
>>> Add it as a dependency to libperf which uses one syscall number. Perf
>>> uses more, but as libperf is a dependency of Perf it will be generated
>>> for both.
>>>
>>> Future platforms that need this will have to add their own syscall-y
>>> targets in libperf manually. Unfortunately the arch specific files that
>>> do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
>>> into the Perf build. But Perf only needs a subset of the generated files
>>> anyway, so redefining them is probably the correct thing to do.
>>
>> FYI, my daily -next build for Fedora based on its RPM spec file broke
>> on arm64 (x86_64 worked fine) while building libperf. I haven't checked
>> yet, but due to the error messages and a quick look in the history I
>> wonder if this is due to the quoted change, which showed up in -next
>> today:
>>
>> """
>> kernel.spec:3115: build libperf
>> + /usr/bin/make -s 'EXTRA_CFLAGS=-O2  -fexceptions -g -grecord-gcc- 
>> switches -pipe -Wall -Wno-complain-wrong-lang -Werror=format-security 
>> -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS - 
>> specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong 
>> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch- 
>> protection=standard -fasynchronous-unwind-tables -fstack-clash- 
>> protection  ' 'LDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack- 
>> relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened- 
>> ld -specs=/usr/lib/rpm/redhat/redhat-hardened-ld-errors -specs=/usr/ 
>> lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/ 
>> lib/rpm/redhat/redhat-package-notes ' -C tools/lib/perf V=1 DESTDIR=/ 
>> builddir/build/BUILD/kernel-6.15.0-build/BUILDROOT
>> mkdir: cannot create directory â€˜/../archâ€™: Permission denied
>> /builddir/build/BUILD/kernel-6.15.0-build/kernel-next-20250428/ 
>> linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/scripts/ 
>> syscallhdr.sh: line 98: /../arch/arm64/include/generated/uapi/asm/ 
>> unistd_64.h: No such file or directory
>> make[2]: *** [/builddir/build/BUILD/kernel-6.15.0-build/kernel- 
>> next-20250428/linux-6.15.0-0.0.next.20250428.435.vanilla.fc43.aarch64/ 
>> scripts/Makefile.asm-headers:81: /../arch/arm64/include/generated/ 
>> uapi/asm/unistd_64.h] Error 1
>> make[1]: *** [Makefile:108: uapi-asm-generic] Error 2
>> make: *** [Makefile:128: all] Error 2
>> error: Bad exit status from /var/tmp/rpm-tmp.vAfil2 (%build)
>> """
>>
>> Full log: https://download.copr.fedorainfracloud.org/results/@kernel- 
>> vanilla/next/fedora-rawhide-aarch64/08975350-next-next-all/builder- 
>> live.log.gz
>>
>> Ciao, Thorsten
> 
> Hi Thorsten,
> 
> Yes, this is the error that the fix is for.
> 
> 
> James
> 

Sorry I had it the wrong way around, I see you were asking about a new 
build failure caused by the fix. Looking into it now.

I noticed some strange characters in here, but I might have enough to go 
on from the logs:

   mkdir: cannot create directory â€˜/../archâ€™: Permission denied

