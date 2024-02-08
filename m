Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB236A352
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Feb 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389210; cv=none; b=oxIYjNu6jUuy5P7YNMjJX/xy2NdK0jH1CzVGH+izXDm6GGvnxB7F+RgM2g1M9A+/z8CeDAT5J47MVSvkXzs67H4seb7DJcdlW35qSYj/mawTQgc/KgY+m9DxzP+FNgeC5+XUr8gDuMoYkmb+AbBvnhmkBMkfVihIxU/s05X6tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389210; c=relaxed/simple;
	bh=9QWa9TWs8MUk2ZFRdewlxUMrn8h0ZBiMcXSYIsblDqg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0iEx8bNNTt53TqCItaprh2OFtwglEpUMBxkc2hBCgkTvKpAzp6asKYb4DUEhN6HU6G4Qahtlvgm+x4dmnAjMJ53zIPyxtKvgFrDylNZWH62QW2xqqttonr0PKjK6vrZtpbH50Ae1I9Xl1jI6q5fmf/UmPaAhUnYWbsZyq6vmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVtqT54zlz6JB2p;
	Thu,  8 Feb 2024 18:43:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 057DD140595;
	Thu,  8 Feb 2024 18:46:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 10:46:43 +0000
Date: Thu, 8 Feb 2024 10:46:42 +0000
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
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
Message-ID: <20240208104642.000001ad@Huawei.com>
In-Reply-To: <20240208032518.25830-1-yangyicong@huawei.com>
References: <20240208032518.25830-1-yangyicong@huawei.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 8 Feb 2024 11:25:18 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
> throughput and latency of PCIe traffic. With the support of PCIe PMU
> we can enable the perf iostat mode.
> 
> The HiSilicon PCIe PMU can support measuring the throughput of certain
> TLP types and of certain root port. Totally 6 metrics are provided in
> the unit of MB:
> 
> - Inbound MWR: The memory write TLPs from the devices downstream the root port
> - Inbound MRD: The memory read TLPs from the devices downstream the root port
> - Inbound CPL: The completion TLPs from the devices downstream the root port
> - Outbound MWR: The memory write TLPs from the CPU to the downstream devices
> - Outbound MRD: The memory read TLPs from the CPU to the downstream devices
> - Outbound CPL: The completions TLPs from the CPU to the downstream devices
> 
> Since the PMU measures the throughput in DWords. So we need to calculate
> the throughput in MB like:
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
If you are doing a v3 for any reason, one trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +
> +enum hisi_iostat_metric_type {
> +	METRIC_IN_MWR,		/* Inbound Memory Write */
> +	METRIC_IN_MRD,		/* Inbound Memory Read */
> +	METRIC_IN_CPL,		/* Inbound Memory Completion */
> +	METRIC_OUT_MWR,		/* Outbound Memory Write */
> +	METRIC_OUT_MRD,		/* Outbound Memory Read */
> +	METRIC_OUT_CPL,		/* Outbound Memory Completion */
> +	METRIC_TYPE_MAX,

Given it is the terminator, no comma needed.

> +};
