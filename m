Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68722BE5E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305173; cv=none; b=tGQrWeB/GGGrtZKQ2HyzIucuthJiuUNNeImp630joDqYEALyHIDPmRsuBcG8q8gLfxlmxaqejIC88Qi8UO1rEnb9VGyCTuu+GErAlmhcS7HfUF7VQEh9Dj3VPj5waMKJFpB6VyA26/py2Epk5SYBLKD82/0k7OpYqNfSfO8k+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305173; c=relaxed/simple;
	bh=4Hq45kjxgVvbXKdPestj9Ng8UcYehgPRo7UiAv4Uv0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT0fVuyd9PkX1RDp0BcnTFx+LkbJedVavkccvQNU3dJc5sQDlC2UkRhodFoK3eXe7os11A2/T+X6cvp7SPh6fPdZvAbIlkEWQKMI6RHkyRpjOuyBOIaKEczmdqY2EuNP2z9L+bCrsBJYQeLFk9CQPW3ci7OFIb7i8abxqoQbC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aD9RtNbz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD9RtNbz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434aa472617so53850255e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 01:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733305170; x=1733909970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jh4ghP2vIJfBNOGnYLYZqwsrjcMAw6lyfxuIkkRvS34=;
        b=aD9RtNbz6Omlj5HymBoZZsxekti4Opz0Vc/0rJYVG9nfBYEcAje6MSzxJb2LfDWuLQ
         qJ2wdANWNMK0TYtSA6OkM3QQWsxw2WngXEgc0TMbvdPQ7GUFqFGjysxlK2xews4DUGen
         mcnrxEy5ip2hL2q/Xbm2noWetEG4WzfVAZRYVRNoAKf8vR29J6fZA8JO1A7LwLg7vrET
         no5qFiJFW/RGqOjVl6yRbBs4b9d8NcKJ+GkF8+3fH8RVhpBgfPp4ReyP0cwYlR+37sVX
         s5Ip6fOO7ehZfM8IRCUWn1TRf6zD+V7Gtjd0uY+e2UBCVwDAe8jSBjOQy6WIR2Hng/MW
         4z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305170; x=1733909970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jh4ghP2vIJfBNOGnYLYZqwsrjcMAw6lyfxuIkkRvS34=;
        b=aVvm9p4FxU/KA50kSIJ3RgSutDIAF2c26AcxCuBumksK45hdAd+U5PkOaMRjeBCmDm
         6H9gDuWQ1kSX4mdd6A7OWJfs2b+Rm3EDbAbrXpZUzejdla1PE7qdUfC6/DCExs0CCFxh
         CsMgWNkP5v1cXm0pewyBMekpOTp1nqx/h2zfXnPO7EaV5mzqtma+mouEqrIXx7DP/DEu
         NR3zrNI8cpdHXzTD+2qZ/p9UkXGqBt5g+sU7+h5yVV7C3+6g+tzUZdtJfZT+Jl4anFSA
         meqCQ7HjUU6TV2E8PFEq4uXS8ludAxNxl9clmMyKrar3/IDz8ZlHjtgAwwxpSt73ch76
         WDjw==
X-Forwarded-Encrypted: i=1; AJvYcCUcMSWm6XVJ2q+PE3Qzthgq1fGISVE5KOK/OORDnt33vw7prF3TPwN9aZvyb2lFgRggcayOJEEZwzvqrv86agsw@vger.kernel.org
X-Gm-Message-State: AOJu0YwJz95nft/9bvAHSTdax3Gsm3WOd22ktLCnnrrLAxK+XTE0NzC5
	UHqFDkK1VueKeUB4Wszd2ybVsTBxL2rFq7/4OuxLjVS/0IKSyNudkp0b1nPGIek=
X-Gm-Gg: ASbGncudEoDxJvVXhGQPFr8JoQHGtzfGJoPxe79D3tWJAZNVSub0hYpDtj2kFFel548
	40UbGLb7awRgVJqSCIk/un9yOGgd6fMSuAAKYwbTgUlgYHubytr9YZ6yLiEBjtayhtkdkk6vePg
	H86/c2BLdm1auk64M8ErVnwHr6+PO9dRe3m5ODM/fdk0nHgynh4OKb5AxtRayDCVkEkehTnNA1t
	TCWsC1WDSe1kpeboptmJFSTc2gtqxlFJAiF0tUQyNqe6rIhlcJOrMKkx0aOcA==
X-Google-Smtp-Source: AGHT+IGB7WUiv++OomTBoRqMx05UkP8zy1PF4dkfs0RF7wyiIACspJqrvuDsP0YhoCmqNFpLeOZDdQ==
X-Received: by 2002:a05:600c:1c07:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-434d09bf7b4mr52704295e9.13.1733305169696;
        Wed, 04 Dec 2024 01:39:29 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm18080135e9.35.2024.12.04.01.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:39:29 -0800 (PST)
Message-ID: <3fae886d-baa6-4670-8418-a57c02572f78@linaro.org>
Date: Wed, 4 Dec 2024 09:39:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] perf tools: Fix build error on
 generated/fs_at_flags_array.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241203035349.1901262-1-namhyung@kernel.org>
 <20241203035349.1901262-12-namhyung@kernel.org>
 <981436ce-2d41-4c3e-b77e-63e4c200cd0e@linaro.org>
 <Z09-GGWh87_wrslp@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z09-GGWh87_wrslp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/12/2024 9:54 pm, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 04:43:44PM +0000, James Clark wrote:
>>
>>
>> On 03/12/2024 3:53 am, Namhyung Kim wrote:
>>> It should only have generic flags in the array but the recent header
>>> sync brought a new flags to fcntl.h and caused a build error.  Let's
>>> update the shell script to exclude flags specific to name_to_handle_at().
>>>
>>>       CC      trace/beauty/fs_at_flags.o
>>>     In file included from trace/beauty/fs_at_flags.c:21:
>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: error: initialized field overwritten [-Werror=override-init]
>>>        13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
>>>           |                              ^~~~~~~~~~~~~~~~~~~~
>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: note: (near initialization for ‘fs_at_flags[2]’)
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>
>> Hi Namhyung,
>>
>> Is it possible to fix this before the updates to keep it buildable? Maybe
>> it's not feasible, I didn't check.
>>
>> I did notice a build issue in the kvm tests after this update:
>>
>> $ make O=../build/local/ summary=1 TARGETS=kvm kselftest
>>
>> In file included from aarch64/aarch32_id_regs.c:14:
>> include/aarch64/processor.h:15:10: fatal error: asm/brk-imm.h: No such file
>> or directory
>>     15 | #include <asm/brk-imm.h>
>>
>> But I tried the same on v6.13-rc1 and got a different error, so I don't know
>> if it's any worse.
> 
> I suspect it's an unrelated issue.  This fix is about generating
> descriptions of the flags for perf trace beautifier.
> 
> The below is the only change I made in this series for arm64.
> 
> Thanks,
> Namhyung
> 

I'll take a look

> 
> ---8<---
> diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
> index 964df31da9751c96..66736ff04011e0fa 100644
> --- a/tools/arch/arm64/include/uapi/asm/kvm.h
> +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
> @@ -484,6 +484,12 @@ enum {
>    */
>   #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2        (1ULL << 0)
>   
> +/*
> + * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
> + * Valid only when the system event has a type of KVM_SYSTEM_EVENT_SHUTDOWN.
> + */
> +#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2       (1ULL << 0)
> +
>   /* run->fail_entry.hardware_entry_failure_reason codes. */
>   #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED    (1ULL << 0)

