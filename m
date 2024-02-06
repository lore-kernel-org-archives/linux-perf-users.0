Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE5712D17A
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214177; cv=none; b=dZo9ZAcYiSSrmHs2evJUjKa8dRZqQJ0U+/n1MQ+0Vbz/YLFBLMFZ+d+FFPGiafpL9wwk5Rm429pGKAoTqTEiipf6+BCsCzR1rQ/5OrIiE8ElK5M+kj0E9yqc+MNp6mVqAS4QSYhaM1ieHJfh6rKNSaOzEv3JTrLMB8JsuDKzkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214177; c=relaxed/simple;
	bh=Cs2doAgftDMcg7geXNAFXFaOFW/SwuUYgLlQN6bw6Cw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8oQXepZ2eAir3A87Ep8bLxoEeLcqe1AG6Dm1S+4VlMwEpL87pz3bFPAf4oaKHYVZdrqYytTuztT0/ZujBlmqTqK3wsFhlYYASzWZXmMlBVpr3pz9IrOoyTR7rumAb0GLTAx+M1KydekqZtfwUbX19IaiWm5fBJDL4nvJI5I2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TTf60574Wz67Q86;
	Tue,  6 Feb 2024 18:06:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FC44140D27;
	Tue,  6 Feb 2024 18:09:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 6 Feb
 2024 10:09:30 +0000
Date: Tue, 6 Feb 2024 10:09:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <john.g.garry@oracle.com>, <james.clark@arm.com>,
	<mike.leach@linaro.org>, <leo.yan@linaro.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] perf stat: Enable iostat mode for HiSilicon PCIe PMU
Message-ID: <20240206100929.00007128@Huawei.com>
In-Reply-To: <20240123071201.30914-1-yangyicong@huawei.com>
References: <20240123071201.30914-1-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Jan 2024 15:12:01 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>

If you end up doing a v2, a few typos and grammar tweaks.
A few other trivial comments inline on things that might improve readability
a tiny bit.


> 
> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
> throughout and latency of PCIe traffic. With the support of PCIe PMU
> we can enable the perf iostat mode.
> 
> The HiSilicon PCIe PMU can support measuring the throughout of certain
> TLP types and of certian root port. Totally 6 metrics are provided in

certain

> the unit of MB:
> 
> - Inbound MWR: The memory write TLPs from the devices downstream the root port
> - Inbound MRD: The memory read TLPs from the devices downstream the root port
> - Inbound CPL: The completion TLPs from the devices downstream the root port
> - Outbound MWR: The memory write TLPs from the CPU to the downstream devices
> - Outbound MRD: The memory read TLPs from the CPU to the downstream devices
> - Outbound CPL: The completions TLPs from the CPU to the downstream devices
> 
> Since the PMU measures the throughout with unit of DWords. So we need to
throughput in DWords

> calculate the throughout in MB like:
>   Count * 4B / 1024 / 1024
> 
> Some of the display of the `perf iostat` will be like:
> [root@localhost tmp]# ./perf iostat list
> hisi_pcie0_core2<0000:40:00.0>
> hisi_pcie2_core2<0000:5f:00.0>
> hisi_pcie0_core1<0000:16:00.0>
> hisi_pcie0_core1<0000:16:04.0>
> [root@localhost tmp]# ./perf iostat --timeout 10000
> 
>  Performance counter stats for 'system wide':
> 
>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
> 0000:40:00.0                    0                    0                    0                    0                    0                    0
> 0000:5f:00.0                    0                    0                    0                    0                    0                    0
> 0000:16:00.0             16272.99               366.58                    0                15.09                    0             16156.85
> 0000:16:04.0                    0                    0                    0                    0                    0                    0
> 
>       10.008227512 seconds time elapsed
> 
> [root@localhost tmp]# ./perf iostat 0000:16:00.0 -- fio -name=read
> -numjobs=30 -filename=/dev/nvme0n1 -rw=rw -iodepth=128 -direct=1 -sync=0
> -norandommap -group_reporting -runtime=10 -time_based -bs=64k
> 
>  Performance counter stats for 'system wide':
> 
>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
> 0000:40:00.0                    0                    0                    0                    0                    0                    0
> 0000:5f:00.0                    0                    0                    0                    0                    0                    0
> 0000:16:00.0             16314.30               371.22                    0                15.21                    0             16362.20
> 0000:16:04.0                    0                    0                    0                    0                    0                    0
> 
>       10.168561767 seconds time elapsed
> 
>        0.465373000 seconds user
>        1.952948000 seconds sys
> 
> More information of the HiSilicon PCIe PMU can be found at
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/perf/arch/arm64/util/Build         |   1 +
>  tools/perf/arch/arm64/util/hisi-iostat.c | 433 +++++++++++++++++++++++
>  2 files changed, 434 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/hisi-iostat.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 78ef7115be3d..4e8dabf98b29 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -3,6 +3,7 @@ perf-y += machine.o
>  perf-y += perf_regs.o
>  perf-y += tsc.o
>  perf-y += pmu.o
> +perf-y += hisi-iostat.o
>  perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> diff --git a/tools/perf/arch/arm64/util/hisi-iostat.c b/tools/perf/arch/arm64/util/hisi-iostat.c
> new file mode 100644
> index 000000000000..418eebece184
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/hisi-iostat.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * perf iostat support for HiSilicon PCIe PMU.
> + * Partly derived from tools/perf/arch/x86/util/iostat.c.
> + *
> + * Copyright (c) 2024 HiSilicon Technologies Co., Ltd.
> + * Author: Yicong Yang <yangyicong@hisilicon.com>
> + */
> +
> +#include <api/fs/fs.h>
> +#include <linux/err.h>
> +#include <linux/zalloc.h>
> +#include <linux/limits.h>
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +#include "util/counts.h"
> +#include "util/cpumap.h"
> +#include "util/debug.h"
> +#include "util/iostat.h"
> +#include "util/pmu.h"
> +
> +#define PCI_DEFAULT_DOMAIN		0
> +#define PCI_DEVICE_NAME_PATTERN		"%04x:%02hhx:%02hhx.%hhu"
> +#define PCI_ROOT_BUS_DEVICES_PATH	"bus/pci/devices"
> +
> +static const char * const hisi_iostat_metrics[] = {
> +	"Inbound MWR(MB)",
> +	"Inbound MRD(MB)",
> +	"Inbound CPL(MB)",
> +	"Outbound MWR(MB)",
> +	"Outbound MRD(MB)",
> +	"Outbound CPL(MB)",
> +};
> +
> +static const char * const hisi_iostat_cmd_template[] = {

Given this array and the one above have to remain in same order, perhaps
an enum?  Would also remove need to have the comments via
[in_bound_wr] = "....
etc


> +	/* Inbound Memory Write */
> +	"hisi_pcie%hu_core%hu/event=0x0104,port=0x%hx/",
> +	/* Inbound Memory Read */
> +	"hisi_pcie%hu_core%hu/event=0x0804,port=0x%hx/",
> +	/* Inbound Memory Completion */
> +	"hisi_pcie%hu_core%hu/event=0x2004,port=0x%hx/",
> +	/* Outbound Memory Write */
> +	"hisi_pcie%hu_core%hu/event=0x0105,port=0x%hx/",
> +	/* Outbound Memory Read */
> +	"hisi_pcie%hu_core%hu/event=0x0405,port=0x%hx/",
> +	/* Outbound Memory Completion */
> +	"hisi_pcie%hu_core%hu/event=0x1005,port=0x%hx/",
> +};
>

...




> +
> +void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
> +			 struct perf_stat_output_ctx *out)
> +{
> +	struct perf_counts_values *count;
> +	const char *iostat_metric;
> +	double iostat_value;
> +
> +	iostat_metric = hisi_iostat_metrics[evsel->core.idx % ARRAY_SIZE(hisi_iostat_metrics)];
> +
> +	/* We're using AGGR_GLOBAL so there's only one aggr counts aggr[0]. */
> +	count = &evsel->stats->aggr[0].counts;
> +
> +	/* The counts has been scaled, we can use it directly. */
> +	iostat_value = (double)count->val;
> +
> +	/*
> +	 * Display two digits after decimal point for better accuracy if the
> +	 * value is non-zero.
> +	 */
> +	out->print_metric(config, out->ctx, NULL,
> +			  iostat_value > 0 ? "%8.2f" : "%8.0f",
> +			  iostat_metric, iostat_value / (256 * 1024));

I assume that 256 * 1024 is MiB/sizeof(dword)?  Perhaps express it as
that to make the reasoning clearer?




