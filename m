Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405C27933D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395086; cv=none; b=YXx+1hviS+DbHdn0nWnyKpU8lAwURogjt/GAvSl2z7aj5IWK3yGRs4O0UZG5g/DEOeH40Fg/Zo1qbZTF7P5Xeme0nN1pLFQyXX2WHY2es9GlORRPt14UkyeixLtGCnRJJq+c57RLa5G2TQCGxu/tlK3KYOxM3s0uXgQpauP8i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395086; c=relaxed/simple;
	bh=BgyXH/cZ67T7fY7Xn4zvcUzvbl4LSoTw2pTKf4/qCK4=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JG3LUMGbZXnVVeQu36us/XV7NRIRUN64XnuwttXe224ISkszCKKY0pgNKkBnX+NWICAAolHP+q1ZUwNVchI+FaXA/un89emJOaL+U1yiF0NpfKnCviolUNTgs+MO/XTaJYcMQCHHQtxrTsdEgajgKLXRFZKWdaHGR/oFkNQZMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZjBLj3YJ7z27hTJ;
	Wed, 23 Apr 2025 15:58:37 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 47CEB1800B2;
	Wed, 23 Apr 2025 15:57:54 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Apr 2025 15:57:53 +0800
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
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <0098923f-0982-8d08-3c4f-810170ca0b87@huawei.com>
Date: Wed, 23 Apr 2025 15:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250422132006.GG28953@e132581.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/4/22 21:20, Leo Yan wrote:
> On Tue, Apr 22, 2025 at 08:31:43PM +0800, Yicong Yang wrote:
> 
> [...]
> 
>>>>> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
>>>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
>>>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>>
>>> Seems to me, a CPU has L3 cache, would the cluster has a higher level's
>>> cache?
>>
>> In my case, the cluster CPUs share the L3 cache and there's several clusters.
>> L3's the highest level cache in the system.
> 
> If so, you might need to revise the cache levels for:
> 
>   ARM_SPE_HISI_HIP_PEER_CPU
>   ARM_SPE_HISI_HIP_PEER_CPU_HITM
> 
> IIUC, cluster CPUs share L3 cache, and every CPU in a cluster has
> L1/L2 cache, for PEER_CPU cases, the memory level should be L2.
> 

confirmed with our hardware people, should be L2 for these two data sources.
I misunderstood here, thanks for pointing it out.

> [...]
> 
>>>>> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
>>>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
>>>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
>>>>> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>>>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>>>>
>>>> Hi Yicong,
>>>>
>>>> Is the mem_snoop setting missing from this one?
>>>
>>> The field 'mem_snoopx' is an extension to the field 'mem_snoop'.
>>>
>>> If the field 'mem_snoopx' is set, it is no need to set 'mem_snoop'.
>>>
>>
>> they should not be mutal exclusive. mem_snoopx provides the information where
>> the cacheline comes from while mem_snoop provides the status of the cacheline.
>> if hardware supports we can gather both information from the data source, like
>> above for ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM.
> 
> My understanding is the PERF_MEM_SNOOPX_PEER flag was extended for
> support Arm SPE.  Other snoop flags were original from x86 arch.
> 
> I agreed that in some cases above, both the flags PERF_MEM_SNOOPX_PEER
> and PERF_MEM_SNOOP_HITM can be set together, you can parse cache sharing
> with different --display options:
> 
>   perf c2c report --display tot    => based on HITM flags
>   perf c2c report --display peer   => based on SNOOPX_PEER flag
> 

that's exactly what we want to support :)

>> for other cases if there's mem_snoopx information I think mem_snoop can be dropped,
>> this won't make differeces. Checked c2c_decode_stats(), only PERF_MEM_SNOOP_HIT and
>> PERF_MEM_SNOOP_HITM is useful when summarizing c2c statistics.
> 
> It is about how to present accurate results.
> 
> E.g., for REMOTE_SOCKET type, it is hard to say the data from remote
> DRAM or any level's cache.  Since more hardware details are absent, this
> is why I suggested not to set 'mem_snoop' for REMOTE_SOCKET.
> 

this makes sense. will drop mem_snoop if no indications from the data source.

Thanks.

