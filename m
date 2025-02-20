Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB401F9A8B
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062248; cv=none; b=lo/sCOF7fZdRdheXAgPVyhBaI8zMmpyaLhGR2Tr1wjNP1bx1arXWDOhqtxTWUnXVTGlaiieIkNV4f/KfNCckd5Gi0g5pQYHmawhPJrOFHBAz7eXOOTwEyKjeu9UKtwyzXzZlQsHkv6bbc+lrBythnarKFNH2WdL5U/PDYlOx2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062248; c=relaxed/simple;
	bh=9AzUiFOlDwLpiYj/j5ubt//EixUegy/Q5P4uu7Loxc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxakMTHZySPFrh/PlE4tbHhFXQQdwE7PoucTYwrGJag2UKfPnF/mhP8pQmql678gO0cmtN13kDyG1zQ5sZLtWs30JTzao5RW1SNcvD+7nvX5gwaWQRgWzCddxi7GdQN9KA5BqEZuserHBPnDnBQIimcaSTZ3Jtp8NwDNc5BNaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGuNBU6R; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGuNBU6R"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso601770f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740062243; x=1740667043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9HUjuvS0qbMkBXP42R+8x2GNjJS6p1fMH+ZmxGUJ7g=;
        b=iGuNBU6RnJSq9HsjH3kPKnaTgwPITsBL62o1zXUVHT9lv5nbqqu66WtuG/KF5g+QfF
         wuqoT+Rwi+O60UAsBXe0Mw+pAZFQ4nzBAE8OdCOKLjs5p3QUCtSnVDhiYW5PTGhq9OjY
         UcW/xprA26HH8Wtqv8z2tx/R/icbVXDGLIMh1stjpoKP8xBvgNALOlYKK+V/D8srioN4
         W5MKQDv3s2FGVV+AIOz0n/VWu1dCVMoD4WV6dd9c/DxQG9OIEZg+JvrmvN52/bzISTri
         PiKcxPAeIApQE2jYhSh8mNVAmcpiQ+UH7htmX/a8HXbROTSLt4RTYXtsSAshsCD41xto
         62bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062243; x=1740667043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9HUjuvS0qbMkBXP42R+8x2GNjJS6p1fMH+ZmxGUJ7g=;
        b=KdiBCw9ERBg9FqaNgaVCfiwRkQAYvIBXOLWH1nR3rAEpok8I1vxC1MH7F/YFZoBT58
         PpJcGoCbXtkaSPL7EUcwr+9M5qIS+Ad/it1ABaAiSWcU5wePDojKWtZzos5diV9CruW5
         45cuw1kK1iOdpnbhR7GevReIugXSBDKkhsvALdTTK9TXy7zykaafxhO/Sh/BNCodXO+A
         gEQRW7CsNpim0Pb2+Gfy3Q6HgR18b5m+OQE3uPHabv/jh/HcKhzIP16VU9xAZWla4QHo
         bOy9WpP1Um1NXA0qocYE4JdYc6WNGqqDwouAdIGs5k9PMnlB9AU0nO7BUxFzlIiSGQd2
         KmXw==
X-Forwarded-Encrypted: i=1; AJvYcCVRwFmfvXOLm/AktLTHbijJXN+eP4h7AiYJNmBERl/OUOXnbKMDBre6R5jALKmSpYq6yC/ubyg0Jb5miU6XnMBq@vger.kernel.org
X-Gm-Message-State: AOJu0YyDucqLI+pRm1iTw0MJEQixlHlkjz/gl94aRYidkcnZuO+kWPll
	Tc3vp4cq508Rtdo8R/IzixeBPDZwty9jGtNsrrr1UO5C1cTLL6pvv6YFA1xtMfI=
X-Gm-Gg: ASbGncvO7feXncbQNAsyZ8cNj93uvW81h2YhnbkEGw71JACYkCrYTkTSekSF4P1jkVr
	IP9CrrvnOUDQcRqe/GyDiZw6mIomXj1vT/ayU745tAaE6bkE1n6Djr2mndVUdVPBoKKpZ9T0XFt
	THDmrX9v7o0WZ5jLVjpucQsREOBuM6/hQEDU+lkDpOXmPT4ghbn7t9FAYhwQUPkRaJ6A6D2vHJL
	+o4r8nl7jJIhegw7h+1X8ImJttqxevflAyBi6Sscx0oloZw3kObWVnQiySLirTv3lnI9q87CHY3
	7+lYjAUdjQap0KhbU0/+KfUxWA==
X-Google-Smtp-Source: AGHT+IG4/tsIyjrhWQ2f7/l6PUHnt4yI3yRHElMiAEjZoOcEi2BaOaUdkOVnBjz6wi5f+ZTsWTsGtg==
X-Received: by 2002:a05:6000:1541:b0:38f:3b9b:6f91 with SMTP id ffacd0b85a97d-38f3b9b7389mr15460928f8f.12.1740062243451;
        Thu, 20 Feb 2025 06:37:23 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5b40sm21059070f8f.68.2025.02.20.06.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:37:22 -0800 (PST)
Message-ID: <a498f6ea-abee-4b5a-b426-40aa60a15fc8@linaro.org>
Date: Thu, 20 Feb 2025 14:37:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
To: Yangyu Chen <cyy@cyyself.name>, Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com>
 <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
 <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
 <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org>
 <Z7UHieRRnvRb5_oU@google.com>
 <CAP-5=fWXmNoFLyWv+vo7hhLSqTDy7hf+-huKRD9OUWnO-GESRw@mail.gmail.com>
 <tencent_EDA4AFD185EF51104EDBCEB109D720862B05@qq.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <tencent_EDA4AFD185EF51104EDBCEB109D720862B05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/02/2025 3:33 am, Yangyu Chen wrote:
> 
> 
>> On 19 Feb 2025, at 06:33, Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, Feb 18, 2025 at 2:19 PM Namhyung Kim <namhyung@kernel.org <mailto:namhyung@kernel.org>> wrote:
>>>
>>> On Tue, Feb 18, 2025 at 09:30:23AM +0000, James Clark wrote:
>>>>
>>>>
>>>> On 18/02/2025 12:41 am, Ian Rogers wrote:
>>>>> On Fri, Feb 14, 2025 at 2:02 AM James Clark <james.clark@linaro.org> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 14/02/2025 5:49 am, Yangyu Chen wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
>>>>>>>>> This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
>>>>>>>>> processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
>>>>>>>>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
>>>>>>>>
>>>>>>>> I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
>>>>>>>
>>>>>>> The name of PMUs comes from Arm's documentation. I have included these
>>>>>>> links in each patch.
>>>>>>>
>>>>>>>> I remember there's a logic to check the length of hex digits at the end.
>>>>>>>>
>>>>>>>
>>>>>>> Could you provide more details about this?
>>>>>>>
>>>>>>>> Ian, are you ok with this?
>>>>>>>>
>>>>>>
>>>>>> I think they wouldn't be merged because they're core PMUs, so should be
>>>>>> fine? Even though they would otherwise be merged because they're more
>>>>>> than 3 hex digits.
>>>>>
>>>>> Do we know the PMU names? If they are cortex_a520 and cortex_a720 then
>>>>
>>>> It will be "armv9_cortex_a720" from this line:
>>>>
>>>>   PMUV3_INIT_SIMPLE(armv9_cortex_a720)
>>>
>>> I see, thanks!
>>>
>>>>
>>>>> this comment at least reads a little stale:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n76
>>>>> ```
>>>>> /*
>>>>> * There is a '_{num}' suffix. For decimal suffixes any length
>>>>> * will do, for hexadecimal ensure more than 2 hex digits so
>>>>> * that S390's cpum_cf PMU doesn't match.
>>>>> */
>>>>> ```
>>>>> James is right that core PMUs aren't put on the same list as uncore/other PMUs.
>>>
>>> Ok, then I guess we're good.
>>
>> I think you may be able to do things that look odd, like today the
>> "i915" PMU can be called just "i", I think the a520/a720 naming will
>> allow "armv9_cortex/cycles/" as an event name, then open it on two
>> PMUs if they are present. We may only show one PMU in perf list as
>> that code I think assumes they're the same PMU as they only differ by
>> suffix:
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n384
>> I can imagine aggregation possibly being broken, but I think that
>> works off the number of PMUs not the names of the PMUs, so it should
>> be okay. Probably the only thing broken that matter is perf list when
>> you have a BIG.little system with a520 and a720, this may be broken
>> with say a a53 and a72 today as both of those suffix lengths are >2,
>> but maybe they use the "armv8._pmuv3_0", "armv8._pmuv3_1", etc. naming
>> convention. I suspect the >2 here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n80
>> would still work and be correct if it were >4. If that changes then
>> this will also need to change:
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/Documentation/ABI/testing/sysfs-bus-event_source-devices?h=perf-tools-next#n12
>>
>> Thanks,
>> Ian
>>
> 
> On my system, the names of PMUs are `armv8_pmuv3_0` and
> `armv8_pmuv3_1`:
> 
> ```
> $ ls /sys/bus/event_source/devices/
> armv8_pmuv3_0  armv8_pmuv3_1  breakpoint  kprobe  software  tracepoint  uprobe
> ```
> 
> I searched for ACPI DSDT on my platform, but there's no mention of
> a720 or a520. I haven't delved into the PMU kernel driver yet.

Ah yeah, with ACPI you get those names instead.

> 
> Additionally, there's a more significant problem for aarch64
> BIG.little platforms when two or more types of cores don't have the
> same PMUs. The perf list can only display the core PMUs on core0
> unless we use the PERF_CPUID env to override it. This is because
> perf will only probe the first MIDR here:
> https://github.com/torvalds/linux/blob/87a132e73910e8689902aed7f2fc229d6908383b/tools/perf/arch/arm64/util/header.c#L60
> 
> However, I think this doesn't block this patch for adding events and metrics?
> 
> 
> Thanks,
> Yangyu Chen
> 

I don't think that's an issue because events are listed per PMU rather 
than per CPU and that MIDR function does take a CPU struct. From my 
testing the only thing stopping all PMUs from being listed was the 
numeric suffix de-duplication.

Either way, no, it shouldn't affect your patch. But I'm also looking 
into Ian's suggestion to improve it anyway.

>>>
>>> Thanks,
>>> Namhyung
> 
> 

