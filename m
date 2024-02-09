Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD553716F
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486480; cv=none; b=TTnwewRtJ1M6eOWYsKFlXvzBRmaXPIV75wMEWFMZcJ8oqX+uUt5oVIbOZy6SNlcHsmZ8hUMUcKcp2tMImxmDr50gof+c5Ne7FQ6IEDeSDvK0NLPAmhG4X16Rek16geRR0AfF8RR/5YXB6igiB6XaCJkIJQVdgP/3I3Kg4t+zJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486480; c=relaxed/simple;
	bh=keJXc33ZdgHXMsoMSp5mRpPbIis5S5xUtg7Nh9F+yvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmv4Iady3WqAXMbzzq+JXeqMS6Pqe4Jf1g6n9B92IbrU90Bipy6DyuxcjgpPqJBKneNl4XPATTTAZTNhemFnbLtPMx8QpXpisrQ0qGW5qrZni5QxwPrvLoeuS9y5XH0O3Qj7ksuEGnL0WTF+N3lJfgs3U3xKh00JCwizAkHmBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkPChFG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkPChFG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806CFC433C7;
	Fri,  9 Feb 2024 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707486480;
	bh=keJXc33ZdgHXMsoMSp5mRpPbIis5S5xUtg7Nh9F+yvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkPChFG9zVu+yKD0sbkQUWtC7KzqujMHyF321c4GiycRMwvQ8Fuq2ZWGu3QA5U2on
	 nPGDByothQO4n2bgsFk3xODu2EfHaMzjN83ZqJuasGoBgVE6JhUZ6uNd4yyheVMcQX
	 omRExs/BjLVpCYshnO0Q/AfiaLiYYMtBasgJu5GMRKEgP+HG/FCDkw4ZlfYnNaTop5
	 pFG9CB5dDftU1AufA2I7QMb1PYPu343/DDReAX8bDVP6PJHCkCCxIHYinlhBT9eF++
	 ltqdj5yuEUtQn6WDSN+OkidpS6mGQuZ3czkQOBKE3dvfE6HLfn1eeAR0VqPnU+XHGA
	 vKhYKat0B1fZQ==
Date: Fri, 9 Feb 2024 10:47:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: will@kernel.org, john.g.garry@oracle.com, james.clark@arm.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, prime.zeng@hisilicon.com,
	yangyicong@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
Message-ID: <ZcYtDHLr6NQ-BFbx@x1>
References: <20240208032518.25830-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208032518.25830-1-yangyicong@huawei.com>

On Thu, Feb 08, 2024 at 11:25:18AM +0800, Yicong Yang wrote:
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
> Change since v1:
> - Tweak the comments per Jonathan
> - Use an enum to define the metrics and relevant command templates per Jonathan
> Thanks!
> Link: https://lore.kernel.org/linux-perf-users/20240123071201.30914-1-yangyicong@huawei.com/
> 
>  tools/perf/arch/arm64/util/Build         |   1 +
>  tools/perf/arch/arm64/util/hisi-iostat.c | 439 +++++++++++++++++++++++
>  2 files changed, 440 insertions(+)
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
> index 000000000000..43df43b83f3f
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/hisi-iostat.c
> @@ -0,0 +1,439 @@
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
> +#include <stdint.h>
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
> +enum hisi_iostat_metric_type {
> +	METRIC_IN_MWR,		/* Inbound Memory Write */
> +	METRIC_IN_MRD,		/* Inbound Memory Read */
> +	METRIC_IN_CPL,		/* Inbound Memory Completion */
> +	METRIC_OUT_MWR,		/* Outbound Memory Write */
> +	METRIC_OUT_MRD,		/* Outbound Memory Read */
> +	METRIC_OUT_CPL,		/* Outbound Memory Completion */
> +	METRIC_TYPE_MAX,
> +};
> +
> +static const char * const hisi_iostat_metrics[] = {
> +	[METRIC_IN_MWR] = "Inbound MWR(MB)",
> +	[METRIC_IN_MRD] = "Inbound MRD(MB)",
> +	[METRIC_IN_CPL] = "Inbound CPL(MB)",
> +	[METRIC_OUT_MWR] = "Outbound MWR(MB)",
> +	[METRIC_OUT_MRD] = "Outbound MRD(MB)",
> +	[METRIC_OUT_CPL] = "Outbound CPL(MB)",
> +};
> +
> +static const char * const hisi_iostat_cmd_template[] = {
> +	[METRIC_IN_MWR] = "hisi_pcie%hu_core%hu/event=0x0104,port=0x%hx/",
> +	[METRIC_IN_MRD] = "hisi_pcie%hu_core%hu/event=0x0804,port=0x%hx/",
> +	[METRIC_IN_CPL] = "hisi_pcie%hu_core%hu/event=0x2004,port=0x%hx/",
> +	[METRIC_OUT_MWR] = "hisi_pcie%hu_core%hu/event=0x0105,port=0x%hx/",
> +	[METRIC_OUT_MRD] = "hisi_pcie%hu_core%hu/event=0x0405,port=0x%hx/",
> +	[METRIC_OUT_CPL] = "hisi_pcie%hu_core%hu/event=0x1005,port=0x%hx/",
> +};
> +
> +struct hisi_pcie_root_port {
> +	struct list_head list;
> +	/* Is this Root Port selected for monitoring */
> +	bool selected;
> +	/* IDs to locate the PMU */
> +	u16 sicl_id;
> +	u16 core_id;
> +	/* Filter mask for this Root Port */
> +	u16 mask;
> +	/* PCIe Root Port's <domain>:<bus>:<device>.<function> */
> +	u32 domain;
> +	u8 bus;
> +	u8 dev;
> +	u8 fn;
> +};
> +
> +LIST_HEAD(hisi_pcie_root_ports_list);
> +static int hisi_pcie_root_ports_num;
> +
> +static void hisi_pcie_init_root_port_mask(struct hisi_pcie_root_port *rp)
> +{
> +	rp->mask = BIT(rp->dev << 1);
> +}
> +
> +/*
> + * Select specific Root Port to monitor. Return 0 if successfully find the
> + * Root Port, Otherwise -EINVAL.
> + */
> +static int hisi_pcie_root_ports_select_one(u32 domain, u8 bus, u8 dev, u8 fn)
> +{
> +	struct hisi_pcie_root_port *rp;
> +
> +	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list)
> +		if (domain == rp->domain && bus == rp->bus &&
> +		    dev == rp->dev && fn == rp->fn) {
> +			rp->selected = true;
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static void hisi_pcie_root_ports_select_all(void)
> +{
> +	struct hisi_pcie_root_port *rp;
> +
> +	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list)
> +		rp->selected = true;
> +}
> +
> +static void hisi_pcie_root_ports_add(u16 sicl_id, u16 core_id, u8 target_bus)
> +{
> +	const char *sysfs = sysfs__mountpoint();
> +	struct hisi_pcie_root_port *rp;
> +	struct dirent *dent;
> +	char path[PATH_MAX];
> +	u8 bus, dev, fn;
> +	u32 domain;
> +	DIR *dir;
> +	int ret;
> +
> +	snprintf(path, PATH_MAX, "%s/%s", sysfs, PCI_ROOT_BUS_DEVICES_PATH);
> +	dir = opendir(path);
> +	if (!dir)
> +		return;
> +
> +	/* Scan the PCI root bus to find the match root port on @target_bus */
> +	while ((dent = readdir(dir))) {
> +		ret = sscanf(dent->d_name, PCI_DEVICE_NAME_PATTERN,
> +			     &domain, &bus, &dev, &fn);
> +		if (ret != 4 || bus != target_bus)
> +			continue;
> +
> +		rp = zalloc(sizeof(*rp));
> +		if (!rp)
> +			continue;

shouldn't it emit some pr_debug message? Like you did with that
pr_debug3() info message below.

> +
> +		rp->selected = false;
> +		rp->sicl_id = sicl_id;
> +		rp->core_id = core_id;
> +		rp->domain = domain;
> +		rp->bus = bus;
> +		rp->dev = dev;
> +		rp->fn = fn;
> +
> +		hisi_pcie_init_root_port_mask(rp);
> +
> +		list_add(&rp->list, &hisi_pcie_root_ports_list);
> +		hisi_pcie_root_ports_num++;
> +
> +		pr_debug3("Found root port %s\n", dent->d_name);
> +	}
> +
> +	closedir(dir);
> +}
> +
> +/* Scan the PMUs and build the mapping of the Root Ports to the PMU */
> +static int hisi_pcie_root_ports_init(void)
> +{
> +	char event_source[PATH_MAX], bus_path[PATH_MAX];
> +	unsigned long long bus;
> +	u16 sicl_id, core_id;
> +	struct dirent *dent;
> +	DIR *dir;
> +
> +	perf_pmu__event_source_devices_scnprintf(event_source, sizeof(event_source));
> +	dir = opendir(event_source);
> +	if (!dir)
> +		return -ENOENT;

Is this the only possibility? I.e. if a non root user tries this and the
file is there, shouldn't we inform that root permission is needed? Or
any other access mechanism that may be used.

For instance, in perf we have things like kernel.perf_event_paranoid,
capabilities, etc.

Take a look at the evsel__open_strerror() function, to see how it tries
to translate errors like the above to an informative message to help the
user setup its system.

> +
> +	while ((dent = readdir(dir))) {
> +		/*
> +		 * This HiSilicon PCIe PMU will be named as:
> +		 *   hisi_pcie<sicl_id>_core<core_id>
> +		 */
> +		if ((sscanf(dent->d_name, "hisi_pcie%hu_core%hu", &sicl_id, &core_id)) != 2)
> +			continue;
> +
> +		/*
> +		 * Driver will export the root port it can monitor through
> +		 * the "bus" sysfs attribute.
> +		 */
> +		scnprintf(bus_path, sizeof(bus_path), "%s/hisi_pcie%hu_core%hu/bus",
> +			  event_source, sicl_id, core_id);
> +
> +		/*
> +		 * Per PCIe spec the bus should be 8bit, use unsigned long long
> +		 * for the convience of the library function.
> +		 */
> +		if (filename__read_ull(bus_path, &bus))

Shouldn't we have a pr_debug3() here as well?

> +			continue;

> +
> +		pr_debug3("Found pmu %s bus 0x%llx\n", dent->d_name, bus);
> +
> +		hisi_pcie_root_ports_add(sicl_id, core_id, (u8)bus);
> +	}
> +
> +	closedir(dir);
> +	return hisi_pcie_root_ports_num > 0 ? 0 : -ENOENT;
> +}
> +
> +static void hisi_pcie_root_ports_free(void)
> +{
> +	struct hisi_pcie_root_port *rp, *tmp;
> +
> +	if (hisi_pcie_root_ports_num == 0)
> +		return;
> +
> +	list_for_each_entry_safe(rp, tmp, &hisi_pcie_root_ports_list, list) {
> +		list_del(&rp->list);

list_del_init()

> +		zfree(&rp);

No need to use zfree here, its a local variable, not something that is
in a data structure that may have some dangling connection somewhere and
thus we better initialize to zero instead of reading random deleted
memory.

> +		hisi_pcie_root_ports_num--;
> +	}
> +}
> +
> +static int hisi_iostat_add_events(struct evlist *evl)
> +{
> +	struct hisi_pcie_root_port *rp;
> +	struct evsel *evsel;
> +	unsigned int i, j;
> +	char *iostat_cmd;
> +	int pos = 0;
> +	int ret;
> +
> +	if (!hisi_pcie_root_ports_num)
> +		return -ENOENT;
> +
> +	iostat_cmd = zalloc(PATH_MAX);
> +	if (!iostat_cmd)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list) {
> +		if (!rp->selected)
> +			continue;
> +
> +		iostat_cmd[pos++] = '{';
> +		for (j = 0; j < METRIC_TYPE_MAX; j++) {
> +			pos += snprintf(iostat_cmd + pos, ARG_MAX - pos - 1,
> +					hisi_iostat_cmd_template[j],
> +					rp->sicl_id, rp->core_id, rp->mask);
> +
> +			if (j == METRIC_TYPE_MAX - 1)
> +				iostat_cmd[pos++] = '}';
> +			else
> +				iostat_cmd[pos++] = ',';
> +		}
> +
> +		ret = parse_event(evl, iostat_cmd);
> +		if (ret)

pr_debug3()?

> +			break;
> +
> +		i = 0;
> +		evlist__for_each_entry_reverse(evl, evsel) {
> +			if (i == METRIC_TYPE_MAX)
> +				break;
> +
> +			evsel->priv = rp;
> +			i++;
> +		}
> +
> +		memset(iostat_cmd, 0, PATH_MAX);
> +		pos = 0;
> +	}
> +
> +	zfree(&iostat_cmd);

no need for zfree here, again its a local variable.

> +	return ret;
> +}
> +
> +int iostat_prepare(struct evlist *evlist,
> +		   struct perf_stat_config *config)
> +{
> +	if (evlist->core.nr_entries > 0) {
> +		pr_warning("The -e and -M options are not supported."
> +			   "All chosen events/metrics will be dropped\n");
> +		evlist__delete(evlist);
> +		evlist = evlist__new();
> +		if (!evlist)
> +			return -ENOMEM;

Can you explain how this works? Shouldn't we just bail out completely
instead of creating an empty evlist?

> +	}
> +
> +	config->metric_only = true;
> +	config->aggr_mode = AGGR_GLOBAL;
> +
> +	return hisi_iostat_add_events(evlist);
> +}
> +
> +static int hisi_pcie_root_ports_list_filter(const char *str)
> +{
> +	char *tok, *tmp, *copy = NULL;
> +	u8 bus, dev, fn;
> +	u32 domain;
> +	int ret;
> +
> +	copy = strdup(str);
> +	if (!copy)
> +		return -ENOMEM;
> +
> +	for (tok = strtok_r(copy, ",", &tmp); tok; tok = strtok_r(NULL, ",", &tmp)) {
> +		ret = sscanf(tok, PCI_DEVICE_NAME_PATTERN, &domain, &bus, &dev, &fn);
> +		if (ret != 4) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = hisi_pcie_root_ports_select_one(domain, bus, dev, fn);
> +		if (ret)
> +			break;
> +	}
> +
> +	zfree(&copy);

No need for zfree()

> +	return ret;
> +}
> +
> +int iostat_parse(const struct option *opt, const char *str, int unset __maybe_unused)
> +{
> +	struct perf_stat_config *config = (struct perf_stat_config *)opt->data;
> +	int ret;
> +
> +	ret = hisi_pcie_root_ports_init();
> +	if (!ret) {
> +		config->iostat_run = true;
> +
> +		if (!str) {
> +			iostat_mode = IOSTAT_RUN;
> +			hisi_pcie_root_ports_select_all();
> +		} else if (!strcmp(str, "list")) {
> +			iostat_mode = IOSTAT_LIST;
> +			hisi_pcie_root_ports_select_all();
> +		} else {
> +			iostat_mode = IOSTAT_RUN;
> +			ret = hisi_pcie_root_ports_list_filter(str);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void hisi_pcie_root_port_show(FILE *output,
> +				     const struct hisi_pcie_root_port * const rp)
> +{
> +	if (output && rp)
> +		fprintf(output, "hisi_pcie%hu_core%hu<" PCI_DEVICE_NAME_PATTERN ">\n",
> +			rp->sicl_id, rp->core_id, rp->domain, rp->bus, rp->dev, rp->fn);

Multi line if blocks should be enclosed in {}

> +}
> +
> +void iostat_list(struct evlist *evlist __maybe_unused, struct perf_stat_config *config)
> +{
> +	struct hisi_pcie_root_port *rp = NULL;
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {

Can you add a comment explaining this evsel->priv check? Probably we
have multiple ports and some are shared with multiple evsels and we
don't have a ports list, so we reuse the evsel list, etc.

Having a comment with the above info may help future reviewers?

> +		if (rp != evsel->priv) {
> +			hisi_pcie_root_port_show(config->output, evsel->priv);
> +			rp = evsel->priv;
> +		}
> +	}
> +}
> +
> +void iostat_release(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel)
> +		evsel->priv = NULL;
> +

But then here you zero out all the privs and still can iterate the list
of ports in the following function:

> +	hisi_pcie_root_ports_free();

Why not iterate on hisi_pcie_root_ports_list in iostat_list()?

> +}
> +
> +void iostat_print_header_prefix(struct perf_stat_config *config)
> +{
> +	if (config->csv_output)
> +		fputs("port,", config->output);
> +	else if (config->interval)
> +		fprintf(config->output, "#          time    port         ");
> +	else
> +		fprintf(config->output, "   port         ");
> +}
> +
> +void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
> +			 struct perf_stat_output_ctx *out)
> +{
> +	struct perf_counts_values *count;
> +	const char *iostat_metric;
> +	double iostat_value;
> +
> +	iostat_metric = hisi_iostat_metrics[evsel->core.idx % METRIC_TYPE_MAX];
> +
> +	/* We're using AGGR_GLOBAL so there's only one aggr counts aggr[0]. */
> +	count = &evsel->stats->aggr[0].counts;
> +
> +	/* The counts has been scaled, we can use it directly. */
> +	iostat_value = (double)count->val;
> +
> +	/*
> +	 * Calculate the bandwidth in MiB since the PMU counts in DWord.
> +	 * Display two digits after decimal point for better accuracy if the
> +	 * value is non-zero.
> +	 */
> +	out->print_metric(config, out->ctx, NULL,
> +			  iostat_value > 0 ? "%8.2f" : "%8.0f", iostat_metric,
> +			  iostat_value * sizeof(uint32_t) / (1024 * 1024));
> +}
> +
> +void iostat_prefix(struct evlist *evlist, struct perf_stat_config *config,
> +		   char *prefix, struct timespec *ts)
> +{
> +	struct hisi_pcie_root_port *rp = evlist->selected->priv;
> +
> +	if (rp) {
> +		if (ts)
> +			sprintf(prefix, "%6lu.%09lu%s" PCI_DEVICE_NAME_PATTERN "%s",

Can you use scnprintf? and pass the size of prefix to iostat_prefix()?

> +				ts->tv_sec, ts->tv_nsec, config->csv_sep,
> +				rp->domain, rp->bus, rp->dev, rp->fn,
> +				config->csv_sep);
> +		else
> +			sprintf(prefix, PCI_DEVICE_NAME_PATTERN "%s",
> +				rp->domain, rp->bus, rp->dev, rp->fn,
> +				config->csv_sep);
> +	}
> +}
> +
> +void iostat_print_counters(struct evlist *evlist, struct perf_stat_config *config,
> +			   struct timespec *ts, char *prefix,
> +			   iostat_print_counter_t print_cnt_cb, void *arg)
> +{
> +	struct evsel *counter = evlist__first(evlist);
> +	void *perf_device;
> +
> +	evlist__set_selected(evlist, counter);
> +	iostat_prefix(evlist, config, prefix, ts);
> +	fprintf(config->output, "%s", prefix);
> +	evlist__for_each_entry(evlist, counter) {
> +		perf_device = evlist->selected->priv;
> +		if (perf_device && perf_device != counter->priv) {
> +			evlist__set_selected(evlist, counter);
> +			iostat_prefix(evlist, config, prefix, ts);
> +			fprintf(config->output, "\n%s", prefix);
> +		}
> +		print_cnt_cb(config, counter, arg);
> +	}
> +	fputc('\n', config->output);
> +}
> -- 
> 2.24.0
> 
