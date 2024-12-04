Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F21AB52F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306392; cv=none; b=MmVIQ8ActptUFAbpcdFbP9SybWx5jBS0rcJu5g/GQy+ZC94Lhtr2TcHipmj2830xywfapJ1Q0Rv6IflVA2/BwpshrhVNXqFYi2GE/p8rp28ffsXppEyJxZItykTxHBErZh1dIoPyiYSuDSHV5L7SVeKy6cBtK6urfC5b3+UruHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306392; c=relaxed/simple;
	bh=byZXgeZ2ivwY8dQMLRKWWL+jQ2EnfPchXyu1tYJxbc8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e8wwbT6lJkvZ1cGFgbUV8RUBoWmihq9xzIsfVpASqnWVcISpCycUX8q9FvrF7ix5J2bwvcCcvFJsl6Be/yWAeiKCzBjAa4SnIJMkyowCE0ozrL4tS08iWrurfhuOsm9mxkaoJNbV5mWh2r9YT2pUa2MR/ZV3pJf1NXlivViJTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8VuUgo5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8VuUgo5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-432d86a3085so55636915e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 01:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733306388; x=1733911188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JAePphPcnp1eAgPvdLOuOSkuEbV5V4trB4aVsssHkQ=;
        b=I8VuUgo506MxsZSw1aQZcoEpgJ1oZZJBOqM+faHYmNIf44lpwD+NUdFFKdj02bNsTB
         pcEb/sKZT1JlkLRFTNRM7/HtEbM0mHy/iSZBL1yW+8Ij4Al48UKEOsWk7MvsdKS1WBUx
         NI6mkbOcjVnCIENUEIbe6Q7KiH8DdB5PGVw2oNUYdlGVk34lxxgIeZP46duNs6mhsakU
         FZeEytOyzY4CX8vcCSDDqunz7D/+moCuSrZjXCiDLQn/SuWRt5u3GfexSx+xy6jyVM2c
         je9B0d2q/tTeVBPwx9MvLLKcnPatih1RgKu85CQgvn3cr8EwR5qSDhNHFneu1Kgf4wTL
         Itpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306388; x=1733911188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JAePphPcnp1eAgPvdLOuOSkuEbV5V4trB4aVsssHkQ=;
        b=aHwL+1w9msW/kmxN3JzZu5qHZegDMc0pznd3/sU6/NdHI/ylDeTpNBoSclUTsuVVRI
         aXaXkSnvqSS/OV9sDKWls9X75F+OoiyUBffhBOvKa0lBxw4UQ2SRe2/kso8GCaVGlQ7d
         +WjUjRP6D8cO4s+tnCzz+KIDDS9SvAP0AIzxXN+a/Biu593poUabKy2Or/sQyMRUEEvg
         HVLUhQCC0b0u5kXg7fFDGvPJNib06reKgbPlB+yDo4oWFo8oWi6XJ8T8UDVBKLw81I92
         tbpk7Td1YmbUaUsFpJHhwVPmwReJ8uEcD4Zf9GtHzOCEPUiy5QCL9QGD06R/29wDdjD8
         kUFg==
X-Forwarded-Encrypted: i=1; AJvYcCUo+BJC11mhqEorxLmHjnW8r/HIyDJsXpiQKMkKXZn5wM6rysTkVDZnz+PDnHXS3rnzvuzX0l8PPTJ7ywvQvw+C@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSGrz54grq5t7CAKMIizQ6dSGadhsc1yjbxZmlxnB5LTmnv7n
	a5A6bpqQnDM4C9JwgZJATJ8XLCCc95R1ZJLsGB6mkq89c/eJ68ebojWHEGccGUE=
X-Gm-Gg: ASbGncu/NslPV6sif5YgjqTwRfBt3vfyS88NXJFsuJjG3NFlW6bZ++KNZJJ5dzSZdJu
	F5juNXTtFiNx8u47Yo7cVxtsTzV3NbehFQdQJtbnkZwdhkf2+46IXrfebnxsBI1mY/jhXA26Tbx
	5UxXxlfoXZwZGeiAg4P0sxaEg/SyuZ4RFLFKpYCdr5f4GPiglYsXZg147+RQkqgFwe2by9z6gso
	aPazb93CJMP/Z7eL3+F6vxfZnivgtALm0jVmROQo3yuiRycIxKXEtU6VKkT2w==
X-Google-Smtp-Source: AGHT+IGidQDLyHMD3KI1jIdL4LmanrH/fT/0s6EUXalZdsQ7+VfmdI1b9R90aH/W7GH8cFt9sBHQTQ==
X-Received: by 2002:a5d:588f:0:b0:385:f062:c2df with SMTP id ffacd0b85a97d-385fd3ccda2mr5610676f8f.11.1733306388380;
        Wed, 04 Dec 2024 01:59:48 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ea17f78esm10836309f8f.64.2024.12.04.01.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:59:47 -0800 (PST)
Message-ID: <38205401-3fdc-4b3d-a018-bb5a569fdc12@linaro.org>
Date: Wed, 4 Dec 2024 09:59:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] perf tools: Fix build error on
 generated/fs_at_flags_array.c
From: James Clark <james.clark@linaro.org>
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
 <3fae886d-baa6-4670-8418-a57c02572f78@linaro.org>
Content-Language: en-US
In-Reply-To: <3fae886d-baa6-4670-8418-a57c02572f78@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/12/2024 9:39 am, James Clark wrote:
> 
> 
> On 03/12/2024 9:54 pm, Namhyung Kim wrote:
>> Hello,
>>
>> On Tue, Dec 03, 2024 at 04:43:44PM +0000, James Clark wrote:
>>>
>>>
>>> On 03/12/2024 3:53 am, Namhyung Kim wrote:
>>>> It should only have generic flags in the array but the recent header
>>>> sync brought a new flags to fcntl.h and caused a build error.  Let's
>>>> update the shell script to exclude flags specific to 
>>>> name_to_handle_at().
>>>>
>>>>       CC      trace/beauty/fs_at_flags.o
>>>>     In file included from trace/beauty/fs_at_flags.c:21:
>>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: 
>>>> error: initialized field overwritten [-Werror=override-init]
>>>>        13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
>>>>           |                              ^~~~~~~~~~~~~~~~~~~~
>>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: 
>>>> note: (near initialization for ‘fs_at_flags[2]’)
>>>>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>
>>> Hi Namhyung,
>>>
>>> Is it possible to fix this before the updates to keep it buildable? 
>>> Maybe
>>> it's not feasible, I didn't check.
>>>
>>> I did notice a build issue in the kvm tests after this update:
>>>
>>> $ make O=../build/local/ summary=1 TARGETS=kvm kselftest
>>>
>>> In file included from aarch64/aarch32_id_regs.c:14:
>>> include/aarch64/processor.h:15:10: fatal error: asm/brk-imm.h: No 
>>> such file
>>> or directory
>>>     15 | #include <asm/brk-imm.h>
>>>
>>> But I tried the same on v6.13-rc1 and got a different error, so I 
>>> don't know
>>> if it's any worse.
>>
>> I suspect it's an unrelated issue.  This fix is about generating
>> descriptions of the flags for perf trace beautifier.
>>
>> The below is the only change I made in this series for arm64.
>>
>> Thanks,
>> Namhyung
>>
> 
> I'll take a look
> 

Looked like some kind of stale build issue. A clean fixed it but I 
wasn't able to reproduce it.

>>
>> ---8<---
>> diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/ 
>> arm64/include/uapi/asm/kvm.h
>> index 964df31da9751c96..66736ff04011e0fa 100644
>> --- a/tools/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
>> @@ -484,6 +484,12 @@ enum {
>>    */
>>   #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2        (1ULL << 0)
>> +/*
>> + * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
>> + * Valid only when the system event has a type of 
>> KVM_SYSTEM_EVENT_SHUTDOWN.
>> + */
>> +#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2       (1ULL << 0)
>> +
>>   /* run->fail_entry.hardware_entry_failure_reason codes. */
>>   #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED    (1ULL << 0)
> 

