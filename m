Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7B3BB21
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503519; cv=none; b=rrDx2hFE9sTr3QxLruHtQERZG9urjiq0+m8vs8T9+WNX5N3ciUZ0THZwTGgDnZalPMikrkzKwZhZAPUgunJNmgGn7edPE1PpAa1evc8aNswEdAU/pWZ/TZ+OyZcNnLwJBIxtBGRNGl+wvLw5GuzF5gH18Zd1FhtlEVrCsUk2yKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503519; c=relaxed/simple;
	bh=PsZJvCbooyDKrHEcs5K22oyyfbugSK6HCUu1mmFWjqw=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b1whQUVGEJm/KQvsEJNSN6Dmavcdg1t1uqlnjDaoKCLQH0TpbZ8qrNTiWMbW758VabPYGuZwK/5Sk1WLsLzRyDHCmIXMAcXcoutyB5KNAgmqQSx4rTUilkaB3F5w/HWKf9Bxo/GtMfKBXgxxWnFW6MvNJKiY3Og6vS4bm4gSw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TfpyK26Rmz1h0Jy;
	Wed, 21 Feb 2024 16:16:25 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id DDFA9140158;
	Wed, 21 Feb 2024 16:18:33 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 16:16:31 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@arm.com>, <mike.leach@linaro.org>, <leo.yan@linaro.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20240208032518.25830-1-yangyicong@huawei.com>
 <20240208104642.000001ad@Huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b3c3a18d-2766-337c-c79e-d4ccfb2a1771@huawei.com>
Date: Wed, 21 Feb 2024 16:16:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240208104642.000001ad@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/8 18:46, Jonathan Cameron wrote:
> On Thu, 8 Feb 2024 11:25:18 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
>> throughput and latency of PCIe traffic. With the support of PCIe PMU
>> we can enable the perf iostat mode.
>>
>> The HiSilicon PCIe PMU can support measuring the throughput of certain
>> TLP types and of certain root port. Totally 6 metrics are provided in
>> the unit of MB:
>>
>> - Inbound MWR: The memory write TLPs from the devices downstream the root port
>> - Inbound MRD: The memory read TLPs from the devices downstream the root port
>> - Inbound CPL: The completion TLPs from the devices downstream the root port
>> - Outbound MWR: The memory write TLPs from the CPU to the downstream devices
>> - Outbound MRD: The memory read TLPs from the CPU to the downstream devices
>> - Outbound CPL: The completions TLPs from the CPU to the downstream devices
>>
>> Since the PMU measures the throughput in DWords. So we need to calculate
>> the throughput in MB like:
>>   Count * 4B / 1024 / 1024
>>
>> Some of the display of the `perf iostat` will be like:
>> [root@localhost tmp]# ./perf iostat list
>> hisi_pcie0_core2<0000:40:00.0>
>> hisi_pcie2_core2<0000:5f:00.0>
>> hisi_pcie0_core1<0000:16:00.0>
>> hisi_pcie0_core1<0000:16:04.0>
>> [root@localhost tmp]# ./perf iostat --timeout 10000
>>
>>  Performance counter stats for 'system wide':
>>
>>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
>> 0000:40:00.0                    0                    0                    0                    0                    0                    0
>> 0000:5f:00.0                    0                    0                    0                    0                    0                    0
>> 0000:16:00.0             16272.99               366.58                    0                15.09                    0             16156.85
>> 0000:16:04.0                    0                    0                    0                    0                    0                    0
>>
>>       10.008227512 seconds time elapsed
>>
>> [root@localhost tmp]# ./perf iostat 0000:16:00.0 -- fio -name=read
>> -numjobs=30 -filename=/dev/nvme0n1 -rw=rw -iodepth=128 -direct=1 -sync=0
>> -norandommap -group_reporting -runtime=10 -time_based -bs=64k
>>
>>  Performance counter stats for 'system wide':
>>
>>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
>> 0000:40:00.0                    0                    0                    0                    0                    0                    0
>> 0000:5f:00.0                    0                    0                    0                    0                    0                    0
>> 0000:16:00.0             16314.30               371.22                    0                15.21                    0             16362.20
>> 0000:16:04.0                    0                    0                    0                    0                    0                    0
>>
>>       10.168561767 seconds time elapsed
>>
>>        0.465373000 seconds user
>>        1.952948000 seconds sys
>>
>> More information of the HiSilicon PCIe PMU can be found at
>> Documentation/admin-guide/perf/hisi-pcie-pmu.rst.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
> If you are doing a v3 for any reason, one trivial comment inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks.

>> +
>> +enum hisi_iostat_metric_type {
>> +	METRIC_IN_MWR,		/* Inbound Memory Write */
>> +	METRIC_IN_MRD,		/* Inbound Memory Read */
>> +	METRIC_IN_CPL,		/* Inbound Memory Completion */
>> +	METRIC_OUT_MWR,		/* Outbound Memory Write */
>> +	METRIC_OUT_MRD,		/* Outbound Memory Read */
>> +	METRIC_OUT_CPL,		/* Outbound Memory Completion */
>> +	METRIC_TYPE_MAX,
> 
> Given it is the terminator, no comma needed.
> 

Sure. Will drop the comma.

Thanks.

