Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C83064B1;
	Wed, 15 Oct 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518559; cv=none; b=n8cX9FoHHOd40qEtvZfvNN0ewcO/dbYL0BbQzez2BlPeaMEHA48G6d69S2V9KthZ0Ateenn7D4SLgkr4JEBQ3Ju9mJ/T8gltfsu9NVvWJMtflt51jNk7OQHYnKdFnbPhaLRrucBw4qsvdc0A56b2Tq0Dwe7KcWuQW6gs4/j75Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518559; c=relaxed/simple;
	bh=nc+2CydMl68yydJCR5gpu0Jhaqdx/c6bk8d447JO32Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6n2U+rU0SnDydja2twoV03ejUc9VULGRcJAfPRT4FoqQ0LXJSeKKHx3ay6A0paAsHR4VjeoYGvPkIjrj2Vlzn9u+8fr9dJEH+f59dTLjYyumc1Lp6MaGhDlbGyz5uF0zZoJvD6Ry15LlNtctVs71awkI2grFmJXtZZfX1AOkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b991d332a9a411f0a38c85956e01ac42-20251015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dba242d5-6dce-4d11-ac71-27fb9e267eb2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:359230cc1d789239cbf78763ed5aec16,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b991d332a9a411f0a38c85956e01ac42-20251015
X-User: tanze@kylinos.cn
Received: from [10.42.20.57] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1046902316; Wed, 15 Oct 2025 16:55:40 +0800
Message-ID: <5dee24f7-fc92-44f9-9a21-799a8ae20315@kylinos.cn>
Date: Wed, 15 Oct 2025 16:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/zhaoxin: Fix instructions error by missing
 fixedctr member
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, peterz@infradead.org,
 kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
 <20250620023757.1429898-1-tanze@kylinos.cn>
 <c962d1a5-b941-4361-839c-c34e621de5ee@linux.intel.com>
Content-Language: en-US
From: tanze <tanze@kylinos.cn>
In-Reply-To: <c962d1a5-b941-4361-839c-c34e621de5ee@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dapeng,

在 2025/9/30 10:49, Mi, Dapeng 写道:
> 
> On 6/20/2025 10:37 AM, tanze wrote:
>> Perf's instructions event tests on Zhaoxin CPUs may exhibit:
>>
>>    $perf stat -e instructions,cycles ls -l
>>
>>    ......
>>    Performance counter stats for 'ls -l':
>>
>>                   0      instructions                     #    0.00  insn per cycle
>>           9,488,278      cycles
>>
>>         0.004365407 seconds time elapsed
>>
>>         0.003303000 seconds user
>>         0.001099000 seconds sys
>>
>> The absence of the fixedctr member leads to an incorrect hwc->event_base
>> value on Zhaoxin CPUs, causing a discrepancy in the instruction count
>> reported by perf stat. This commit resolves the instruction count issue
>> by properly initializing the fixedctr member.
>>
>> Fixes: 149fd4712bcd ("perf/x86/intel: Support Perfmon MSRs aliasing")
>> Signed-off-by: tanze <tanze@kylinos.cn>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   arch/x86/events/zhaoxin/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
>> index 4bdfcf091200..3fc3f9abece9 100644
>> --- a/arch/x86/events/zhaoxin/core.c
>> +++ b/arch/x86/events/zhaoxin/core.c
>> @@ -467,6 +467,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst = {
>>   	.schedule_events	= x86_schedule_events,
>>   	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
>>   	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
>> +	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
>>   	.event_map		= zhaoxin_pmu_event_map,
>>   	.max_events		= ARRAY_SIZE(zx_pmon_event_map),
>>   	.apic			= 1,
> 
> LGTM.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thank You
Ze Tan
