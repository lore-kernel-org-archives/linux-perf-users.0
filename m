Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290F221FA0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495873; cv=none; b=Brp6AechNWuRg8fVf93l/CZ9AdgnerHsG08nzCIKHMOWhre6L5mnBv1e9QgysuTm32E0kvD2Jj72ovAhISUpGVvShD1LYksMxT0Lm1lIdfGvsPx3Ve2kuOvOonnjwEKBR1UOozCb3NiNbscQOlfvpWJxGnEhFt6mX2SgpqEDMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495873; c=relaxed/simple;
	bh=iCinVPXO2vifv2YIL8dRmqjVdIQhsOw/EYf1hec6lx8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ltLL8m2V+mEem4kM9z3bBwL2s0kRCiOucLIdKxIstiOVgsYTcPu3FaYj1kV8b8mow0W8p50hPi8TECIYwtJA7aIopbl7/GQby4qM82S4LPfyrIlkviQ/hbFtYOivr3vlphq4dt16B66bAP3MFBSJYFKgXg63C6j0p+TsX5ClkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZjvX26P6fz8x9g;
	Thu, 24 Apr 2025 19:54:10 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id F3DB41402C3;
	Thu, 24 Apr 2025 19:57:40 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Apr 2025 19:57:39 +0800
CC: <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>,
	<jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>, <linuxarm@huawei.com>,
	<wangyushan12@huawei.com>, <caijingtao@huawei.com>, <xueshan2@huawei.com>,
	<prime.zeng@hisilicon.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <mark.rutland@arm.com>, <jolsa@kernel.org>,
	<john.g.garry@oracle.com>, <leo.yan@linux.dev>, <irogers@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 HiSilicon HIP12
To: Leo Yan <leo.yan@arm.com>
References: <20250408122809.37884-1-yangyicong@huawei.com>
 <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>
 <20250422102952.GD28953@e132581.arm.com>
 <ccb8ce65-8241-0670-25c8-f8245fbc5e22@huawei.com>
 <20250422132006.GG28953@e132581.arm.com>
 <0098923f-0982-8d08-3c4f-810170ca0b87@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <2fa27176-f820-a03f-033e-7da811643cff@huawei.com>
Date: Thu, 24 Apr 2025 19:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0098923f-0982-8d08-3c4f-810170ca0b87@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi Leo,

On 2025/4/23 15:57, Yicong Yang wrote:
> On 2025/4/22 21:20, Leo Yan wrote:
>> On Tue, Apr 22, 2025 at 08:31:43PM +0800, Yicong Yang wrote:
>>
>> [...]
>>
>>>>>> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
>>>>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
>>>>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>>>
>>>> Seems to me, a CPU has L3 cache, would the cluster has a higher level's
>>>> cache?
>>>
>>> In my case, the cluster CPUs share the L3 cache and there's several clusters.
>>> L3's the highest level cache in the system.
>>
>> If so, you might need to revise the cache levels for:
>>
>>   ARM_SPE_HISI_HIP_PEER_CPU
>>   ARM_SPE_HISI_HIP_PEER_CPU_HITM
>>
>> IIUC, cluster CPUs share L3 cache, and every CPU in a cluster has
>> L1/L2 cache, for PEER_CPU cases, the memory level should be L2.
>>
> 
> confirmed with our hardware people, should be L2 for these two data sources.
> I misunderstood here, thanks for pointing it out.
> 

I recalled why the handling is like this. considering 2 threads have potential false
sharing issues which are running on core0 thread0 and core 1 thread 0 in the same
cluster, we'll have some ARM_SPE_HISI_HIP_PEER_CPU_HITM samples to indicate the
cacheline contention. If the cache level is L2 then we cannot observe this by
`perf c2c report -d tot`, since L2 is not counted for HITM.

does it make sense to have below change to account L2 hitm for lcl_hitm? just like
we account L2 peer snoop for lcl_peer.

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 884d9aebce91..a384a866a562 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -680,7 +680,10 @@ do {                               \
                        if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
                        if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
                        if (lvl & P(LVL, L2)) {
-                               stats->ld_l2hit++;
+                               if (snoop & P(SNOOP, HITM))
+                                       HITM_INC(lcl_hitm);
+                               else
+                                       stats->ld_l2hit++;

                                if (snoopx & P(SNOOPX, PEER))
                                        PEER_INC(lcl_peer);


>> [...]
>>
>>>>>> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
>>>>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
>>>>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
>>>>>> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>>>>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>>>>>
>>>>> Hi Yicong,
>>>>>
>>>>> Is the mem_snoop setting missing from this one?
>>>>
>>>> The field 'mem_snoopx' is an extension to the field 'mem_snoop'.
>>>>
>>>> If the field 'mem_snoopx' is set, it is no need to set 'mem_snoop'.
>>>>
>>>
>>> they should not be mutal exclusive. mem_snoopx provides the information where
>>> the cacheline comes from while mem_snoop provides the status of the cacheline.
>>> if hardware supports we can gather both information from the data source, like
>>> above for ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM.
>>
>> My understanding is the PERF_MEM_SNOOPX_PEER flag was extended for
>> support Arm SPE.  Other snoop flags were original from x86 arch.
>>
>> I agreed that in some cases above, both the flags PERF_MEM_SNOOPX_PEER
>> and PERF_MEM_SNOOP_HITM can be set together, you can parse cache sharing
>> with different --display options:
>>
>>   perf c2c report --display tot    => based on HITM flags
>>   perf c2c report --display peer   => based on SNOOPX_PEER flag
>>
> 
> that's exactly what we want to support :)
> 
>>> for other cases if there's mem_snoopx information I think mem_snoop can be dropped,
>>> this won't make differeces. Checked c2c_decode_stats(), only PERF_MEM_SNOOP_HIT and
>>> PERF_MEM_SNOOP_HITM is useful when summarizing c2c statistics.
>>
>> It is about how to present accurate results.
>>
>> E.g., for REMOTE_SOCKET type, it is hard to say the data from remote
>> DRAM or any level's cache.  Since more hardware details are absent, this
>> is why I suggested not to set 'mem_snoop' for REMOTE_SOCKET.
>>
> 
> this makes sense. will drop mem_snoop if no indications from the data source.
> 
> Thanks.
> 
> .
> 
