Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1C24B2F
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476351; cv=none; b=ZRqqbHmUD6s8nhG/fw9hAItL8HJ5WdCiesL72HYl7KGfZ2di7ES0PZnlK7jzMzMc1jNz9TcauSBQTlsZLv8QV8nunb2dnZMpvdLiAMNiDz3luGNfyf/VsO6Cs8bjp1k3re20NVKx+Cy4o9z+17B2E7ag0Xb0saWjuIwrUFikHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476351; c=relaxed/simple;
	bh=UH+ADFM4q5tUUm8Ma6D04uEKUBHOdyijSyujUBxhfIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVWV9J1sH5wQb9ByRRilglTNIvWfzfQP/XyXRue/5mA444Uf5uh4udDvSAGWnvrSeUEcnIevnK8jzNCv1HsxH407aGFKFKpxgriljuEGUmY0vzztgZwCmD2DzOorS6P+XlBiF4qLr+T95QufwMb0fni27kHE570J+AKZL5j6oSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E97DA7;
	Fri,  9 Feb 2024 02:59:51 -0800 (PST)
Received: from [10.57.47.119] (unknown [10.57.47.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61663F762;
	Fri,  9 Feb 2024 02:59:05 -0800 (PST)
Message-ID: <4688a613-c94a-49b0-9d0f-09173c64082d@arm.com>
Date: Fri, 9 Feb 2024 10:59:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>, Yicong Yang <yangyicong@huawei.com>
Cc: will@kernel.org, john.g.garry@oracle.com, james.clark@arm.com,
 mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
 hejunhao3@huawei.com, prime.zeng@hisilicon.com, yangyicong@hisilicon.com,
 linuxarm@huawei.com
References: <20240208032518.25830-1-yangyicong@huawei.com>
 <CAM9d7cga2rzcpUCa+5sZKQ3g_nC5=5XhSdkX1bRCQQUJca8uSw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAM9d7cga2rzcpUCa+5sZKQ3g_nC5=5XhSdkX1bRCQQUJca8uSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-08 11:58 pm, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Feb 7, 2024 at 7:29 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
>> throughput and latency of PCIe traffic. With the support of PCIe PMU
>> we can enable the perf iostat mode.
> 
> Hmm.. so it only works for HiSilicon.  What if users run it on a different
> platform?

Same thing as if they run it on an AMD or older Intel platform ;)

>  I think ARM should care about this.

Arm don't make PCIe root ports, and there is no PMU standardisation 
between all the myriad different implementers and vendors of PCIe IP, so 
the best perf can reasonably do is simply support the particular PMUs 
that people want perf to support.

Thanks,
Robin.

> 
> Thanks,
> Namhyung
> 
> 
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
>>    Count * 4B / 1024 / 1024
>>
>> Some of the display of the `perf iostat` will be like:
>> [root@localhost tmp]# ./perf iostat list
>> hisi_pcie0_core2<0000:40:00.0>
>> hisi_pcie2_core2<0000:5f:00.0>
>> hisi_pcie0_core1<0000:16:00.0>
>> hisi_pcie0_core1<0000:16:04.0>
>> [root@localhost tmp]# ./perf iostat --timeout 10000
>>
>>   Performance counter stats for 'system wide':
>>
>>      port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
>> 0000:40:00.0                    0                    0                    0                    0                    0                    0
>> 0000:5f:00.0                    0                    0                    0                    0                    0                    0
>> 0000:16:00.0             16272.99               366.58                    0                15.09                    0             16156.85
>> 0000:16:04.0                    0                    0                    0                    0                    0                    0
>>
>>        10.008227512 seconds time elapsed
>>
>> [root@localhost tmp]# ./perf iostat 0000:16:00.0 -- fio -name=read
>> -numjobs=30 -filename=/dev/nvme0n1 -rw=rw -iodepth=128 -direct=1 -sync=0
>> -norandommap -group_reporting -runtime=10 -time_based -bs=64k
>>
>>   Performance counter stats for 'system wide':
>>
>>      port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
>> 0000:40:00.0                    0                    0                    0                    0                    0                    0
>> 0000:5f:00.0                    0                    0                    0                    0                    0                    0
>> 0000:16:00.0             16314.30               371.22                    0                15.21                    0             16362.20
>> 0000:16:04.0                    0                    0                    0                    0                    0                    0
>>
>>        10.168561767 seconds time elapsed
>>
>>         0.465373000 seconds user
>>         1.952948000 seconds sys
>>
>> More information of the HiSilicon PCIe PMU can be found at
>> Documentation/admin-guide/perf/hisi-pcie-pmu.rst.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
