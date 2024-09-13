Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327811DA615
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Sep 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232137; cv=none; b=h2PylE330mTsE1pxFhvEq24k/OYvZDWpMxxB8eD1t3u8unt9Nibsj5i7BZPBhXlvaB1Av2qhL3SW5xw8aXYbEWYjWk6PYwB8bzQxnINAdPgrdhuJSDF+wxlZ2JXX+mkJU+lJ7zxsgS/pKXL8xEpZ/ed8zkKTyjYaciEa5gnReSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232137; c=relaxed/simple;
	bh=VibpCWP3YmxkL1yRz9Wnur+uQ2ERzj4kP8lnxEGAXUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIoMplu2vB18RxToQaelarrog/hj/X1jo16pt45nvlm5pRIWq+qL8jeAad60QHHFNGfXpgIxv8u8T1VhiHTj4TmOIKK4BproQjEnm8HYOMXu07gXTbpvtZbzsVoVxfGLgP37CxXVdpap6OO04EMP9sqYGhSP7psbelcytMffPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwVFRhh0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwVFRhh0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so17280195e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Sep 2024 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726232133; x=1726836933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3YdB8A3+tAwJXt9mCMAtkpxLhhFidgGgWEy3rGW1Co=;
        b=wwVFRhh0bVRU511S/AldHg374yAWgjLKtgWeLxENRD2zb1BOtfcPaflBLS5AY8xkpw
         rdEjtn6TdqUGlgYwGygcSl2Zhu/2EBJs6Ye9cFYhkr5zVeju1SDIaBYx1q8Y/Tlx/jlX
         YmvKY3l11c7ME17r3O9LZeorYDunDQS0fyPBy/VMfOMh2+D7oc9wo7gW+RWQYmC0V2af
         c2WcYhKxnwGPcjewk68+Rs7Kw7qCQdlNYbGHBDBl12GDvAamkZMoKIyjf37t5gFovVRR
         4y/Gvxs2SQE+DmZ1Qo7UTbl2H0fu6HLjj5ZyCNZrOaYyf1+PjuXkeBEh4wS/pDVb6pTY
         mPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232133; x=1726836933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3YdB8A3+tAwJXt9mCMAtkpxLhhFidgGgWEy3rGW1Co=;
        b=d/a5giwVA0rFORsnNdwhvEL/8ilsn2ZrI/tisOxoiVoG3mPi1B5qwxhk0k89CaNAui
         RfpldYve7SLq73nFAiFxEkiyz2HzwUBCh5PCHtYp2N6Tdxo5eJthK0s+u/hR9ZiOPTJM
         hZJCNr1PBfEVJlLgew2NtJ+VmiYqe3qthsTAOas/E3o8j9ZUc/c7i+szV7jZV9Rb88qx
         NM/Jn+9MBX1rPFN3XdevyAPmnP3BWJeo6EgM8ZHFTyftG5Zo7sSVjuGvtEXBsSDotdxR
         N4AbMURJd6FtWqH6tmmqA9QBkjFCmME9GsiySVyW06Vq6H/sWkivZBDnlzW5OHt0i+eX
         9qDA==
X-Forwarded-Encrypted: i=1; AJvYcCV90dHLNs0c1zSaYquJWiIGMGOWg/InXQTgWouTsrlbKoGy8wi0iHKNBrfBevqT7afU8nIhZf3fncaPKj4p+o5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkeNCzB35eUSIQU59h4p5W/YakL+Fco99QytrszcvX1wUy/pD
	1VS3N2siCd1AQtgY0X8GUDkW1IljsAqbWqcYQvNG2ZCVD3T0CuAviJfhuiCwYos=
X-Google-Smtp-Source: AGHT+IGGx/1f0Xqbzuio9EXzQLfnM2JQ1vQwdaqxGaCnNzPjBTjeMczM3VIk8fYxrnkkQVB1FVut1g==
X-Received: by 2002:a05:600c:3b0f:b0:42c:cd7c:a196 with SMTP id 5b1f17b1804b1-42cdb54cf19mr53433445e9.17.1726232133207;
        Fri, 13 Sep 2024 05:55:33 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b055069sm25303905e9.6.2024.09.13.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 05:55:32 -0700 (PDT)
Message-ID: <03f76f48-a0aa-4ae5-a602-9d41809f4d50@linaro.org>
Date: Fri, 13 Sep 2024 13:55:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vender events arm64: Use "Topdown" as topdown metric
 group name
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 john.g.garry@oracle.com, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
 yangyicong@hisilicon.com, prime.zeng@hisilicon.com, hejunhao3@huawei.com
References: <20240730020145.30227-1-yangyicong@huawei.com>
 <e75258ec-ea7c-0bc8-0cb1-b233564d9340@huawei.com>
 <20240911122755.00000e15@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240911122755.00000e15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 12:28, Jonathan Cameron wrote:
> On Mon, 9 Sep 2024 21:06:03 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> another ping...
>>
>> This patch should be very straightforward, due to the changes to use "Topdown" after [1].
>>
>> [1] 1647cd5b8802 ("perf stat: Implement --topdown using json metrics")
> 
> Hi Yicong,
> 
> That reference definitely helps make this obvious given it clearly states
> the pattern match is TopdownL.
> 
> As such this LGTM (but I'm not a perf tool expert by any means!)
> FWIW.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Very minor nit, but there are also some comments in 
tools/perf/util/metricgroup.c that use TopDownL1 for some reason.

Reviewed-by: James Clark <james.clark@linaro.org>

>>
>> Thanks.
>>
>> On 2024/7/30 10:01, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>
>>> HiSilicon HIP08 does support Topdown metrics but perf tool complains
>>> when trying to count Topdown metrics:
>>> [root@localhost tracing]# perf stat --topdown
>>> Topdown requested but the topdown metric groups aren't present.
>>> (See perf list the metric groups have names like TopdownL1)
>>>
>>> It's because tool's using "Topdown" as the metric group name[1] rather
>>> than "TopDown", so follow the convention.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c?h=v6.11-rc1#n1994
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>>   .../arch/arm64/hisilicon/hip08/metrics.json   | 74 +++++++++----------
>>>   1 file changed, 37 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
>>> index 6463531b9941..b6a0d2de8534 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
>>> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
>>> @@ -3,235 +3,235 @@
>>>           "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
>>>           "PublicDescription": "Frontend bound L1 topdown metric",
>>>           "BriefDescription": "Frontend bound L1 topdown metric",
>>> -        "DefaultMetricgroupName": "TopDownL1",
>>> -        "MetricGroup": "Default;TopDownL1",
>>> +        "DefaultMetricgroupName": "TopdownL1",
>>> +        "MetricGroup": "Default;TopdownL1",
>>>           "MetricName": "frontend_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
>>>           "PublicDescription": "Bad Speculation L1 topdown metric",
>>>           "BriefDescription": "Bad Speculation L1 topdown metric",
>>> -        "DefaultMetricgroupName": "TopDownL1",
>>> -        "MetricGroup": "Default;TopDownL1",
>>> +        "DefaultMetricgroupName": "TopdownL1",
>>> +        "MetricGroup": "Default;TopdownL1",
>>>           "MetricName": "bad_speculation"
>>>       },
>>>       {
>>>           "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
>>>           "PublicDescription": "Retiring L1 topdown metric",
>>>           "BriefDescription": "Retiring L1 topdown metric",
>>> -        "DefaultMetricgroupName": "TopDownL1",
>>> -        "MetricGroup": "Default;TopDownL1",
>>> +        "DefaultMetricgroupName": "TopdownL1",
>>> +        "MetricGroup": "Default;TopdownL1",
>>>           "MetricName": "retiring"
>>>       },
>>>       {
>>>           "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)",
>>>           "PublicDescription": "Backend Bound L1 topdown metric",
>>>           "BriefDescription": "Backend Bound L1 topdown metric",
>>> -        "DefaultMetricgroupName": "TopDownL1",
>>> -        "MetricGroup": "Default;TopDownL1",
>>> +        "DefaultMetricgroupName": "TopdownL1",
>>> +        "MetricGroup": "Default;TopdownL1",
>>>           "MetricName": "backend_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x201d@ / CPU_CYCLES",
>>>           "PublicDescription": "Fetch latency bound L2 topdown metric",
>>>           "BriefDescription": "Fetch latency bound L2 topdown metric",
>>> -        "MetricGroup": "TopDownL2",
>>> +        "MetricGroup": "TopdownL2",
>>>           "MetricName": "fetch_latency_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "frontend_bound - fetch_latency_bound",
>>>           "PublicDescription": "Fetch bandwidth bound L2 topdown metric",
>>>           "BriefDescription": "Fetch bandwidth bound L2 topdown metric",
>>> -        "MetricGroup": "TopDownL2",
>>> +        "MetricGroup": "TopdownL2",
>>>           "MetricName": "fetch_bandwidth_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "(bad_speculation * BR_MIS_PRED) / (BR_MIS_PRED + armv8_pmuv3_0@event\\=0x2013@)",
>>>           "PublicDescription": "Branch mispredicts L2 topdown metric",
>>>           "BriefDescription": "Branch mispredicts L2 topdown metric",
>>> -        "MetricGroup": "TopDownL2",
>>> +        "MetricGroup": "TopdownL2",
>>>           "MetricName": "branch_mispredicts"
>>>       },
>>>       {
>>>           "MetricExpr": "bad_speculation - branch_mispredicts",
>>>           "PublicDescription": "Machine clears L2 topdown metric",
>>>           "BriefDescription": "Machine clears L2 topdown metric",
>>> -        "MetricGroup": "TopDownL2",
>>> +        "MetricGroup": "TopdownL2",
>>>           "MetricName": "machine_clears"
>>>       },
>>>       {
>>>           "MetricExpr": "(EXE_STALL_CYCLE - (MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@)) / CPU_CYCLES",
>>>           "PublicDescription": "Core bound L2 topdown metric",
>>>           "BriefDescription": "Core bound L2 topdown metric",
>>> -        "MetricGroup": "TopDownL2",
>>> +        "MetricGroup": "TopdownL2",
>>>           "MetricName": "core_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "(MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@) / CPU_CYCLES",
>>>           "PublicDescription": "Memory bound L2 topdown metric",
>>>           "BriefDescription": "Memory bound L2 topdown metric",
>>> -        "MetricGroup": "TopDownL2",
>>> +        "MetricGroup": "TopdownL2",
>>>           "MetricName": "memory_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "(((L2I_TLB - L2I_TLB_REFILL) * 15) + (L2I_TLB_REFILL * 100)) / CPU_CYCLES",
>>>           "PublicDescription": "Idle by itlb miss L3 topdown metric",
>>>           "BriefDescription": "Idle by itlb miss L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "idle_by_itlb_miss"
>>>       },
>>>       {
>>>           "MetricExpr": "(((L2I_CACHE - L2I_CACHE_REFILL) * 15) + (L2I_CACHE_REFILL * 100)) / CPU_CYCLES",
>>>           "PublicDescription": "Idle by icache miss L3 topdown metric",
>>>           "BriefDescription": "Idle by icache miss L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "idle_by_icache_miss"
>>>       },
>>>       {
>>>           "MetricExpr": "(BR_MIS_PRED * 5) / CPU_CYCLES",
>>>           "PublicDescription": "BP misp flush L3 topdown metric",
>>>           "BriefDescription": "BP misp flush L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "bp_misp_flush"
>>>       },
>>>       {
>>>           "MetricExpr": "(armv8_pmuv3_0@event\\=0x2013@ * 5) / CPU_CYCLES",
>>>           "PublicDescription": "OOO flush L3 topdown metric",
>>>           "BriefDescription": "OOO flush L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "ooo_flush"
>>>       },
>>>       {
>>>           "MetricExpr": "(armv8_pmuv3_0@event\\=0x1001@ * 5) / CPU_CYCLES",
>>>           "PublicDescription": "Static predictor flush L3 topdown metric",
>>>           "BriefDescription": "Static predictor flush L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "sp_flush"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x1010@ / BR_MIS_PRED",
>>>           "PublicDescription": "Indirect branch L3 topdown metric",
>>>           "BriefDescription": "Indirect branch L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "indirect_branch"
>>>       },
>>>       {
>>>           "MetricExpr": "(armv8_pmuv3_0@event\\=0x1013@ + armv8_pmuv3_0@event\\=0x1016@) / BR_MIS_PRED",
>>>           "PublicDescription": "Push branch L3 topdown metric",
>>>           "BriefDescription": "Push branch L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "push_branch"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x100d@ / BR_MIS_PRED",
>>>           "PublicDescription": "Pop branch L3 topdown metric",
>>>           "BriefDescription": "Pop branch L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "pop_branch"
>>>       },
>>>       {
>>>           "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1013@ - armv8_pmuv3_0@event\\=0x1016@ - armv8_pmuv3_0@event\\=0x100d@) / BR_MIS_PRED",
>>>           "PublicDescription": "Other branch L3 topdown metric",
>>>           "BriefDescription": "Other branch L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "other_branch"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x2012@ / armv8_pmuv3_0@event\\=0x2013@",
>>>           "PublicDescription": "Nuke flush L3 topdown metric",
>>>           "BriefDescription": "Nuke flush L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "nuke_flush"
>>>       },
>>>       {
>>>           "MetricExpr": "1 - nuke_flush",
>>>           "PublicDescription": "Other flush L3 topdown metric",
>>>           "BriefDescription": "Other flush L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "other_flush"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x2010@ / CPU_CYCLES",
>>>           "PublicDescription": "Sync stall L3 topdown metric",
>>>           "BriefDescription": "Sync stall L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "sync_stall"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x2004@ / CPU_CYCLES",
>>>           "PublicDescription": "Rob stall L3 topdown metric",
>>>           "BriefDescription": "Rob stall L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "rob_stall"
>>>       },
>>>       {
>>>           "MetricExpr": "(armv8_pmuv3_0@event\\=0x2006@ + armv8_pmuv3_0@event\\=0x2007@ + armv8_pmuv3_0@event\\=0x2008@) / CPU_CYCLES",
>>>           "PublicDescription": "Ptag stall L3 topdown metric",
>>>           "BriefDescription": "Ptag stall L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "ptag_stall"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x201e@ / CPU_CYCLES",
>>>           "PublicDescription": "SaveOpQ stall L3 topdown metric",
>>>           "BriefDescription": "SaveOpQ stall L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "saveopq_stall"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x2005@ / CPU_CYCLES",
>>>           "PublicDescription": "PC buffer stall L3 topdown metric",
>>>           "BriefDescription": "PC buffer stall L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "pc_buffer_stall"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x7002@ / CPU_CYCLES",
>>>           "PublicDescription": "Divider L3 topdown metric",
>>>           "BriefDescription": "Divider L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "divider"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x7003@ / CPU_CYCLES",
>>>           "PublicDescription": "FSU stall L3 topdown metric",
>>>           "BriefDescription": "FSU stall L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "fsu_stall"
>>>       },
>>>       {
>>>           "MetricExpr": "core_bound - divider - fsu_stall",
>>>           "PublicDescription": "EXE ports util L3 topdown metric",
>>>           "BriefDescription": "EXE ports util L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "exe_ports_util"
>>>       },
>>>       {
>>>           "MetricExpr": "(MEM_STALL_ANYLOAD - MEM_STALL_L1MISS) / CPU_CYCLES",
>>>           "PublicDescription": "L1 bound L3 topdown metric",
>>>           "BriefDescription": "L1 bound L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "l1_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "(MEM_STALL_L1MISS - MEM_STALL_L2MISS) / CPU_CYCLES",
>>>           "PublicDescription": "L2 bound L3 topdown metric",
>>>           "BriefDescription": "L2 bound L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "l2_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "MEM_STALL_L2MISS / CPU_CYCLES",
>>>           "PublicDescription": "Mem bound L3 topdown metric",
>>>           "BriefDescription": "Mem bound L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "mem_bound"
>>>       },
>>>       {
>>>           "MetricExpr": "armv8_pmuv3_0@event\\=0x7005@ / CPU_CYCLES",
>>>           "PublicDescription": "Store bound L3 topdown metric",
>>>           "BriefDescription": "Store bound L3 topdown metric",
>>> -        "MetricGroup": "TopDownL3",
>>> +        "MetricGroup": "TopdownL3",
>>>           "MetricName": "store_bound"
>>>       }
>>>   ]
>>>    
> 
