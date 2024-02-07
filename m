Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DA1CF87
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Feb 2024 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289350; cv=none; b=C/+/CXp5ZaqYFg/BTUn/cQxCou7NHIQuZt4XpNAjCoJDvB/mydUWng0PLn0Sgd6wP/DiLb+Y82J86AkQwl3/vB1lu61zFlwp7ffBxzP4sa61+o9qov3io93B1/39qlDE60w9/Jlo9NMvAKWSYsOfKl0mizLHycV0fV9Rmdyu2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289350; c=relaxed/simple;
	bh=1tcllk+dmnf2G/3fkLKNK5sVF94t14gedQ/GAw6FJiQ=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dNQnGQCMmi7YQuUGsxSyvPnrxbFuXvB3dGvwiXPA+bDwYvmG4qz/88I1ImyAuUTYFTRyHZNQvgmKURrNprKoMhdZT9gv1Dk+PTJ2g8m09cDLkuPJJr1e/gKWrZrsaPtK3/7k6xybaq9HSW7+zH41mNVXRt3Q/DiH5m3oenHEiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TV9yr4P4zz1vtCb;
	Wed,  7 Feb 2024 15:01:56 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id A8FEE1404DB;
	Wed,  7 Feb 2024 15:02:24 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 15:02:24 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@arm.com>, <mike.leach@linaro.org>, <leo.yan@linaro.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] perf stat: Enable iostat mode for HiSilicon PCIe PMU
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20240123071201.30914-1-yangyicong@huawei.com>
 <20240206100929.00007128@Huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <693e27ed-48e6-5463-a827-a020f0ed5fc2@huawei.com>
Date: Wed, 7 Feb 2024 15:02:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240206100929.00007128@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/6 18:09, Jonathan Cameron wrote:
> On Tue, 23 Jan 2024 15:12:01 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> If you end up doing a v2, a few typos and grammar tweaks.
> A few other trivial comments inline on things that might improve readability
> a tiny bit.
> 

Thanks for the comments.

> 
>>
>> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
>> throughout and latency of PCIe traffic. With the support of PCIe PMU
>> we can enable the perf iostat mode.
>>
>> The HiSilicon PCIe PMU can support measuring the throughout of certain
>> TLP types and of certian root port. Totally 6 metrics are provided in
> 
> certain
> 

ok.

>> the unit of MB:
>>
>> - Inbound MWR: The memory write TLPs from the devices downstream the root port
>> - Inbound MRD: The memory read TLPs from the devices downstream the root port
>> - Inbound CPL: The completion TLPs from the devices downstream the root port
>> - Outbound MWR: The memory write TLPs from the CPU to the downstream devices
>> - Outbound MRD: The memory read TLPs from the CPU to the downstream devices
>> - Outbound CPL: The completions TLPs from the CPU to the downstream devices
>>
>> Since the PMU measures the throughout with unit of DWords. So we need to
> throughput in DWords
> 

ok.

>> calculate the throughout in MB like:
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
>>  tools/perf/arch/arm64/util/Build         |   1 +
>>  tools/perf/arch/arm64/util/hisi-iostat.c | 433 +++++++++++++++++++++++
>>  2 files changed, 434 insertions(+)
>>  create mode 100644 tools/perf/arch/arm64/util/hisi-iostat.c
>>
>> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
>> index 78ef7115be3d..4e8dabf98b29 100644
>> --- a/tools/perf/arch/arm64/util/Build
>> +++ b/tools/perf/arch/arm64/util/Build
>> @@ -3,6 +3,7 @@ perf-y += machine.o
>>  perf-y += perf_regs.o
>>  perf-y += tsc.o
>>  perf-y += pmu.o
>> +perf-y += hisi-iostat.o
>>  perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>> diff --git a/tools/perf/arch/arm64/util/hisi-iostat.c b/tools/perf/arch/arm64/util/hisi-iostat.c
>> new file mode 100644
>> index 000000000000..418eebece184
>> --- /dev/null
>> +++ b/tools/perf/arch/arm64/util/hisi-iostat.c
>> @@ -0,0 +1,433 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * perf iostat support for HiSilicon PCIe PMU.
>> + * Partly derived from tools/perf/arch/x86/util/iostat.c.
>> + *
>> + * Copyright (c) 2024 HiSilicon Technologies Co., Ltd.
>> + * Author: Yicong Yang <yangyicong@hisilicon.com>
>> + */
>> +
>> +#include <api/fs/fs.h>
>> +#include <linux/err.h>
>> +#include <linux/zalloc.h>
>> +#include <linux/limits.h>
>> +#include <dirent.h>
>> +#include <stdio.h>
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +
>> +#include "util/counts.h"
>> +#include "util/cpumap.h"
>> +#include "util/debug.h"
>> +#include "util/iostat.h"
>> +#include "util/pmu.h"
>> +
>> +#define PCI_DEFAULT_DOMAIN		0
>> +#define PCI_DEVICE_NAME_PATTERN		"%04x:%02hhx:%02hhx.%hhu"
>> +#define PCI_ROOT_BUS_DEVICES_PATH	"bus/pci/devices"
>> +
>> +static const char * const hisi_iostat_metrics[] = {
>> +	"Inbound MWR(MB)",
>> +	"Inbound MRD(MB)",
>> +	"Inbound CPL(MB)",
>> +	"Outbound MWR(MB)",
>> +	"Outbound MRD(MB)",
>> +	"Outbound CPL(MB)",
>> +};
>> +
>> +static const char * const hisi_iostat_cmd_template[] = {
> 
> Given this array and the one above have to remain in same order, perhaps
> an enum?  Would also remove need to have the comments via
> [in_bound_wr] = "....
> etc
> 

sure. Will use an enum to define both the metric event string and here
for cmd template.

> 
>> +	/* Inbound Memory Write */
>> +	"hisi_pcie%hu_core%hu/event=0x0104,port=0x%hx/",
>> +	/* Inbound Memory Read */
>> +	"hisi_pcie%hu_core%hu/event=0x0804,port=0x%hx/",
>> +	/* Inbound Memory Completion */
>> +	"hisi_pcie%hu_core%hu/event=0x2004,port=0x%hx/",
>> +	/* Outbound Memory Write */
>> +	"hisi_pcie%hu_core%hu/event=0x0105,port=0x%hx/",
>> +	/* Outbound Memory Read */
>> +	"hisi_pcie%hu_core%hu/event=0x0405,port=0x%hx/",
>> +	/* Outbound Memory Completion */
>> +	"hisi_pcie%hu_core%hu/event=0x1005,port=0x%hx/",
>> +};
>>
> 
> ...
> 
> 
> 
> 
>> +
>> +void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>> +			 struct perf_stat_output_ctx *out)
>> +{
>> +	struct perf_counts_values *count;
>> +	const char *iostat_metric;
>> +	double iostat_value;
>> +
>> +	iostat_metric = hisi_iostat_metrics[evsel->core.idx % ARRAY_SIZE(hisi_iostat_metrics)];
>> +
>> +	/* We're using AGGR_GLOBAL so there's only one aggr counts aggr[0]. */
>> +	count = &evsel->stats->aggr[0].counts;
>> +
>> +	/* The counts has been scaled, we can use it directly. */
>> +	iostat_value = (double)count->val;
>> +
>> +	/*
>> +	 * Display two digits after decimal point for better accuracy if the
>> +	 * value is non-zero.
>> +	 */
>> +	out->print_metric(config, out->ctx, NULL,
>> +			  iostat_value > 0 ? "%8.2f" : "%8.0f",
>> +			  iostat_metric, iostat_value / (256 * 1024));
> 
> I assume that 256 * 1024 is MiB/sizeof(dword)?  Perhaps express it as
> that to make the reasoning clearer?
> 
> 

Yes you're right. I mentioned it in the commit. Will add some comment it to
make it clearer here.

Thanks,
Yicong


