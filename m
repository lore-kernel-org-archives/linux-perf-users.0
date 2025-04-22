Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885227D77B
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325111; cv=none; b=N+gUgvgkyNdlPE5BOsTiTEuaIYN84ofLrvbIOP0KnoZ1CkxzHMjVBK/AhHXLVswrkAEmlUnJazphAcKU1C+BMTkxhyq4cBWHIFmdX1l2kBxm5jts0Cs4gKXWYY8Ezcu5gFko1cWY6Co5+f7kxItTmPFAQa7Tj6ntMv/YeT2om3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325111; c=relaxed/simple;
	bh=q6Td+l+W/9+Bn7dgxpWUU2aZ0vlD19qRoos3jiiX9EY=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lpACMlzkcz9wgh73UTESi/mPGkgWTKvUC8uUMQkUW4GNPkB1Sl0RSZF/qOnynjKxtCjqrl6ZO9aEF46QVyadId3cv18r8mvwVVKddiEQPSjqFtsCfQgykcQwxCRGJzxatfeadYlAgt7x6wgRcQwgkGLmPaiF0sUph7alWTxgMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZhhMX1t5MzvWrn;
	Tue, 22 Apr 2025 20:27:36 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 072551400D4;
	Tue, 22 Apr 2025 20:31:45 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 22 Apr 2025 20:31:43 +0800
CC: <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<hejunhao3@huawei.com>, <linuxarm@huawei.com>, <wangyushan12@huawei.com>,
	<caijingtao@huawei.com>, <xueshan2@huawei.com>, <prime.zeng@hisilicon.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <jolsa@kernel.org>, <john.g.garry@oracle.com>,
	<leo.yan@linux.dev>, <irogers@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 HiSilicon HIP12
To: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>
References: <20250408122809.37884-1-yangyicong@huawei.com>
 <89741897-6c8f-4b75-8ec3-675111ea60a1@linaro.org>
 <20250422102952.GD28953@e132581.arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <ccb8ce65-8241-0670-25c8-f8245fbc5e22@huawei.com>
Date: Tue, 22 Apr 2025 20:31:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250422102952.GD28953@e132581.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/4/22 18:29, Leo Yan wrote:
> On Tue, Apr 22, 2025 at 10:16:40AM +0100, James Clark wrote:
>>>
>>> Add data source encoding for HiSilicon HIP12 and coresponding mapping
>>> to the perf's memory data source. This will help to synthesize the data
>>> and support upper layer tools like perf-mem and perf-c2c.
>>>
>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>> ---
>>>   arch/arm64/include/asm/cputype.h              |   2 +
>>>   tools/arch/arm64/include/asm/cputype.h        |   2 +
> 
> Please split into two patches.  One is a kernel patch and another is a
> tool patch.

will do in next version.

> 
> [...]
> 
>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>>> @@ -82,6 +82,23 @@ enum arm_spe_ampereone_data_source {
>>>   	ARM_SPE_AMPEREONE_L2D                           = 0x9,
>>>   };
>>> +enum arm_spe_hisi_hip_data_source {
>>> +	ARM_SPE_HISI_HIP_PEER_CPU		= 0,
>>> +	ARM_SPE_HISI_HIP_PEER_CPU_HITM		= 1,
>>> +	ARM_SPE_HISI_HIP_L3			= 2,
>>> +	ARM_SPE_HISI_HIP_L3_HITM		= 3,
>>> +	ARM_SPE_HISI_HIP_PEER_CLUSTER		= 4,
>>> +	ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM	= 5,
>>> +	ARM_SPE_HISI_HIP_REMOTE_SOCKET		= 6,
>>> +	ARM_SPE_HISI_HIP_REMOTE_SOCKET_HITM	= 7,
>>> +	ARM_SPE_HISI_HIP_LOCAL			= 8,
>>> +	ARM_SPE_HISI_HIP_REMOTE			= 9,
>>> +	ARM_SPE_HISI_HIP_NC_DEV			= 13,
>>> +	ARM_SPE_HISI_HIP_L2			= 16,
>>> +	ARM_SPE_HISI_HIP_L2_HITM		= 17,
>>> +	ARM_SPE_HISI_HIP_L1			= 18,
>>> +};
>>> +
>>>   struct arm_spe_record {
>>>   	enum arm_spe_sample_type type;
>>>   	int err;
>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>> index 2a9775649cc2..eceae4219601 100644
>>> --- a/tools/perf/util/arm-spe.c
>>> +++ b/tools/perf/util/arm-spe.c
>>> @@ -571,6 +571,11 @@ static const struct midr_range ampereone_ds_encoding_cpus[] = {
>>>   	{},
>>>   };
>>> +static const struct midr_range hisi_hip_ds_encoding_cpus[] = {
>>> +	MIDR_ALL_VERSIONS(MIDR_HISI_HIP12),
>>> +	{},
>>> +};
>>> +
>>>   static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>>>   {
>>>   	const struct arm_spe_record *record = &speq->decoder->record;
>>> @@ -718,9 +723,105 @@ static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *re
>>>   	arm_spe__synth_data_source_common(&common_record, data_src);
>>>   }
>>> +static void arm_spe__synth_data_source_hisi_hip(const struct arm_spe_record *record,
>>> +						union perf_mem_data_src *data_src)
>>> +{
>>> +	/* Use common synthesis method to handle store operations */
>>> +	if (record->op & ARM_SPE_OP_ST) {
>>> +		arm_spe__synth_data_source_common(record, data_src);
>>> +		return;
>>> +	}
>>> +
>>> +	switch (record->source) {
>>> +	case ARM_SPE_HISI_HIP_PEER_CPU:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> 
> Seems it is conflict to set both 'PERF_MEM_SNOOP_NONE' and
> 'PERF_MEM_SNOOPX_PEER'.
> 
> Remove setting 'PERF_MEM_SNOOP_NONE' in this case?
> 
>>> +		break;
>>> +	case ARM_SPE_HISI_HIP_PEER_CPU_HITM:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>>> +		break;
>>> +	case ARM_SPE_HISI_HIP_L3:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
>>> +		break;
>>> +	case ARM_SPE_HISI_HIP_L3_HITM:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>>> +		break;
>>> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> 
> Seems to me, a CPU has L3 cache, would the cluster has a higher level's
> cache?

In my case, the cluster CPUs share the L3 cache and there's several clusters.
L3's the highest level cache in the system.

> 
>>> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> 
> Ditto for the confliction for the two flags 'SNOOP_NONE' and
> 'SNOOPX_PEER'.
> 
>>> +		break;
>>> +	case ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>>> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>>> +		break;
>>> +	case ARM_SPE_HISI_HIP_REMOTE_SOCKET:
>>> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2;
>>> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
>>> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>>> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>>
>> Hi Yicong,
>>
>> Is the mem_snoop setting missing from this one?
> 
> The field 'mem_snoopx' is an extension to the field 'mem_snoop'.
> 
> If the field 'mem_snoopx' is set, it is no need to set 'mem_snoop'.
> 

they should not be mutal exclusive. mem_snoopx provides the information where
the cacheline comes from while mem_snoop provides the status of the cacheline.
if hardware supports we can gather both information from the data source, like
above for ARM_SPE_HISI_HIP_PEER_CLUSTER_HITM.

for other cases if there's mem_snoopx information I think mem_snoop can be dropped,
this won't make differeces. Checked c2c_decode_stats(), only PERF_MEM_SNOOP_HIT and
PERF_MEM_SNOOP_HITM is useful when summarizing c2c statistics.

Thanks.
