Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DF33FE15;
	Thu,  7 May 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135873; cv=none; b=Zr4p2ztcoAnx3ljpEXJYgHcCYrP7iE5Uhb+YuhkKC6wtIC7JTUcjyI5wgQzcRKoF2NA8AeqYHsgTnLU8pWR1bp4vgCrJkKU2hVN444Svi4qQuhu+qaPIBx0VbOGVeF02PDyFUt7T/iEt9ontlSbA6RtF9kyPFzQcUD7R+FeZySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135873; c=relaxed/simple;
	bh=oEcTQcKLvGB5AyBANtKcXjHU2cbID8Z5R8vqiu5ojkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMHUenblpO7GGSvUPRQCxEjnkskvoT53DqFdtVoUrCjqSn5isInGyUMGfHVf4aq4gQumbkvW34nnTnYYKCetsuv70/GD7IJG/nRL4weJHuc/QHkuvnbfSEeANw1BV0K2iT9yjrRa8OMqt/y+knSquUw0KemNEVx0en04Otmzxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=36qIw/JH; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="36qIw/JH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+7BtQih2nQeoFC7zgs9Php1wZHaZ0m/JdrDGYCi/tXc=;
	b=36qIw/JHrhAUHZyZT2dEpkhb2OrKKvkX2TaubisfmbX7HmvTM4LNmU/fKaPs4LqnUCFOnNL/q
	6Q8XRavxU94DBUQZ+HC2+vW6YIvD3zfdtgxAghZ9RLEb6nEUyvCKBR4xkptgF/uSHVHUd1FEZRo
	AJq+Qv/8kq3/beGkSWJshU0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gB2Rk3xlbz1T4Fx;
	Thu,  7 May 2026 14:30:10 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 426A240571;
	Thu,  7 May 2026 14:37:43 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:43 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:42 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH v2 7/7] perf-iostat: Enable iostat mode for HiSilicon PCIe PMU
Date: Thu, 7 May 2026 14:37:37 +0800
Message-ID: <20260507063737.3542950-8-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507063737.3542950-1-wangyushan12@huawei.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

From: Yicong Yang <yangyicong@hisilicon.com>

Some HiSilicon platforms provide PCIe PMU devices for monitoring the
throughput and latency of PCIe traffic. With the support of PCIe PMU
we can enable the perf iostat mode.

The HiSilicon PCIe PMU can support measuring the throughput of certain
TLP types and of certain root port. Totally 6 metrics are provided in
the unit of MB:

- Inbound MWR: Memory write TLPs from downstream devices to root port
- Inbound MRD: Memory read TLPs from downstream devices to root port
- Inbound CPL: Completion TLPs from downstream devices to root port
- Outbound MWR: Memory write TLPs from CPU to downstream devices
- Outbound MRD: Memory read TLPs from CPU to downstream devices
- Outbound CPL: Completions TLPs from CPU to downstream devices

Since the PMU measures the throughput in DWords, we need to calculate
the throughput in MB like:
  Count * 4B / 1024 / 1024

Some of the display of the `perf iostat` will be like:
[root@localhost tmp]# ./perf iostat list
hisi_pcie0_core2<0000:40:00.0>
hisi_pcie2_core2<0000:5f:00.0>
hisi_pcie0_core1<0000:16:00.0>
hisi_pcie0_core1<0000:16:04.0>
[root@localhost tmp]# ./perf iostat --timeout 10000

 Performance counter stats for 'system wide':

    port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
0000:40:00.0                    0                    0                    0                    0                    0                    0
0000:5f:00.0                    0                    0                    0                    0                    0                    0
0000:16:00.0             16272.99               366.58                    0                15.09                    0             16156.85
0000:16:04.0                    0                    0                    0                    0                    0                    0

      10.008227512 seconds time elapsed

[root@localhost tmp]# ./perf iostat 0000:16:00.0 -- fio -name=rw -numjobs=30 -filename=/dev/nvme0n1 -rw=rw -iodepth=128 -direct=1 -sync=0 -norandommap -group_reporting -runtime=10 -time_based -bs=64k 2>&1 > /dev/null

 Performance counter stats for 'system wide':

    port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
0000:16:00.0                16614                  379                    0                   16                    0                16721

      10.180349717 seconds time elapsed

       0.558810000 seconds user
       2.495016000 seconds sys

More information of the HiSilicon PCIe PMU can be found at
Documentation/admin-guide/perf/hisi-pcie-pmu.rst.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Shiju Jose  <shiju.jose@huawei.com>
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/util/Build         |   1 +
 tools/perf/util/hisi-iostat.c | 478 ++++++++++++++++++++++++++++++++++
 2 files changed, 479 insertions(+)
 create mode 100644 tools/perf/util/hisi-iostat.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c7e5ada3800d..fee9980cee77 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -128,6 +128,7 @@ perf-util-y += spark.o
 perf-util-y += topdown.o
 perf-util-y += iostat.o
 perf-util-y += x86-iostat.o
+perf-util-y += hisi-iostat.o
 perf-util-y += stream.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += kvm-stat-arch/
diff --git a/tools/perf/util/hisi-iostat.c b/tools/perf/util/hisi-iostat.c
new file mode 100644
index 000000000000..30041fd08614
--- /dev/null
+++ b/tools/perf/util/hisi-iostat.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * perf iostat support for HiSilicon PCIe PMU.
+ * Partly derived from tools/perf/arch/x86/util/iostat.c.
+ *
+ * Copyright (c) 2024 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ * Author: Yushan Wang <wangyushan12@huawei.com>
+ */
+
+#include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/zalloc.h>
+
+#include <api/fs/fs.h>
+#include <dirent.h>
+#include <errno.h>
+#include <stdio.h>
+
+#include "util/counts.h"
+#include "util/debug.h"
+#include "util/iostat.h"
+#include "util/pmu.h"
+
+/* From include/uapi/linux/pci.h */
+#define PCI_SLOT(devfn)		(((devfn) >> 3) & 0x1f)
+#define PCI_DEVFN(slot, func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
+
+#define PCI_DEVICE_NAME_PATTERN		"%04x:%02hhx:%02hhx.%hhu"
+#define PCI_ROOT_BUS_DEVICES_PATH	"bus/pci/devices"
+
+static const char * const hisi_iostat_metrics[] = {
+	"Inbound MWR(MB)",
+	"Inbound MRD(MB)",
+	"Inbound CPL(MB)",
+	"Outbound MWR(MB)",
+	"Outbound MRD(MB)",
+	"Outbound CPL(MB)",
+};
+
+static const char * const hisi_iostat_cmd_template[] = {
+	/* Inbound Memory Write */
+	"hisi_pcie%hu_core%hu/event=0x0104,port=0x%hx/",
+	/* Inbound Memory Read */
+	"hisi_pcie%hu_core%hu/event=0x0804,port=0x%hx/",
+	/* Inbound Memory Completion */
+	"hisi_pcie%hu_core%hu/event=0x2004,port=0x%hx/",
+	/* Outbound Memory Write */
+	"hisi_pcie%hu_core%hu/event=0x0105,port=0x%hx/",
+	/* Outbound Memory Read */
+	"hisi_pcie%hu_core%hu/event=0x0405,port=0x%hx/",
+	/* Outbound Memory Completion */
+	"hisi_pcie%hu_core%hu/event=0x1005,port=0x%hx/",
+};
+
+struct hisi_pcie_root_port {
+	struct list_head list;
+	/* Is this Root Port selected for monitoring */
+	bool selected;
+	/* IDs to locate the PMU */
+	u16 sicl_id;
+	u16 core_id;
+	/* Filter mask for this Root Port */
+	u16 mask;
+	/* PCIe Root Port's <domain>:<bus>:<device>.<function> */
+	u32 domain;
+	u8 bus;
+	u8 dev;
+	u8 fn;
+};
+
+static LIST_HEAD(hisi_pcie_root_ports_list);
+
+/*
+ * Select specific Root Port to monitor. Return 0 if successfully find the
+ * Root Port, Otherwise -EINVAL.
+ */
+static int hisi_pcie_root_ports_select_one(u32 domain, u8 bus, u8 dev, u8 fn)
+{
+	struct hisi_pcie_root_port *rp;
+
+	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list)
+		if (domain == rp->domain && bus == rp->bus &&
+		    dev == rp->dev && fn == rp->fn) {
+			rp->selected = true;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
+static void hisi_pcie_root_ports_select_all(void)
+{
+	struct hisi_pcie_root_port *rp;
+
+	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list)
+		rp->selected = true;
+}
+
+static void hisi_pcie_root_ports_add(u16 sicl_id, u16 core_id, u8 target_bus,
+				     u16 bdf_min, u16 bdf_max)
+{
+	const char *sysfs = sysfs__mountpoint();
+	struct hisi_pcie_root_port *rp;
+	unsigned long path_len;
+	struct dirent *dent;
+	char path[PATH_MAX];
+	u8 bus, dev, fn;
+	u32 domain;
+	DIR *dir;
+	u16 bdf;
+	int ret;
+
+	path_len = snprintf(path, PATH_MAX, "%s/%s", sysfs, PCI_ROOT_BUS_DEVICES_PATH);
+	if (path_len > PATH_MAX)
+		return;
+
+	dir = opendir(path);
+	if (!dir)
+		return;
+
+	/* Scan the PCI root bus to find the match root port on @target_bus */
+	while ((dent = readdir(dir))) {
+		ret = sscanf(dent->d_name, PCI_DEVICE_NAME_PATTERN,
+			     &domain, &bus, &dev, &fn);
+		if (ret != 4 || bus != target_bus)
+			continue;
+
+		bdf = (bus << 8) | PCI_DEVFN(dev, fn);
+		if (bdf < bdf_min || bdf > bdf_max)
+			continue;
+
+		rp = zalloc(sizeof(*rp));
+		if (!rp)
+			continue;
+
+		rp->selected = false;
+		rp->sicl_id = sicl_id;
+		rp->core_id = core_id;
+		rp->domain = domain;
+		rp->bus = bus;
+		rp->dev = dev;
+		rp->fn = fn;
+
+		rp->mask = BIT((rp->dev - PCI_SLOT(bdf_min)) << 1);
+
+		list_add(&rp->list, &hisi_pcie_root_ports_list);
+
+		pr_debug3("Found root port %s\n", dent->d_name);
+	}
+
+	closedir(dir);
+}
+
+/* Scan the PMUs and build the mapping of the Root Ports to the PMU */
+static int hisi_pcie_root_ports_init(void)
+{
+	char event_source[PATH_MAX], bus_path[PATH_MAX];
+	unsigned long long bus, bdf_max, bdf_min;
+	u16 sicl_id, core_id;
+	struct dirent *dent;
+	DIR *dir;
+
+	perf_pmu__event_source_devices_scnprintf(event_source, sizeof(event_source));
+	dir = opendir(event_source);
+	if (!dir)
+		return -ENOENT;
+
+	while ((dent = readdir(dir))) {
+		/*
+		 * This HiSilicon PCIe PMU will be named as:
+		 *   hisi_pcie<sicl_id>_core<core_id>
+		 */
+		if ((sscanf(dent->d_name, "hisi_pcie%hu_core%hu", &sicl_id, &core_id)) != 2)
+			continue;
+
+		/*
+		 * Driver will export the root port it can monitor through
+		 * the "bus" sysfs attribute.
+		 */
+		scnprintf(bus_path, sizeof(bus_path), "%s/hisi_pcie%hu_core%hu/bus",
+			  event_source, sicl_id, core_id);
+
+		/*
+		 * Per PCIe spec the bus should be 8bit, use unsigned long long
+		 * for the convenience of the library function.
+		 */
+		if (filename__read_ull(bus_path, &bus))
+			continue;
+
+		scnprintf(bus_path, sizeof(bus_path), "%s/hisi_pcie%hu_core%hu/bdf_max",
+			  event_source, sicl_id, core_id);
+		if (filename__read_xll(bus_path, &bdf_max))
+			bdf_max = -1;
+
+		scnprintf(bus_path, sizeof(bus_path), "%s/hisi_pcie%hu_core%hu/bdf_min",
+			  event_source, sicl_id, core_id);
+		if (filename__read_xll(bus_path, &bdf_min))
+			bdf_min = 0;
+
+		pr_debug3("Found pmu %s bus 0x%llx\n", dent->d_name, bus);
+
+		hisi_pcie_root_ports_add(sicl_id, core_id, (u8)bus, (u16)bdf_min, (u16)bdf_max);
+	}
+
+	closedir(dir);
+	return !list_empty(&hisi_pcie_root_ports_list) ? 0 : -ENOENT;
+}
+
+static void hisi_pcie_root_ports_free(void)
+{
+	struct hisi_pcie_root_port *rp, *tmp;
+
+	if (list_empty(&hisi_pcie_root_ports_list))
+		return;
+
+	list_for_each_entry_safe(rp, tmp, &hisi_pcie_root_ports_list, list) {
+		list_del(&rp->list);
+		zfree(&rp);
+	}
+}
+
+static int hisi_iostat_add_events(struct evlist *evl)
+{
+	struct hisi_pcie_root_port *rp;
+	struct evsel *evsel;
+	unsigned int i, j;
+	char *iostat_cmd;
+	int pos = 0;
+	int ret;
+
+	if (list_empty(&hisi_pcie_root_ports_list))
+		return -ENOENT;
+
+	iostat_cmd = zalloc(PATH_MAX);
+	if (!iostat_cmd)
+		return -ENOMEM;
+
+	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list) {
+		if (!rp->selected)
+			continue;
+
+		iostat_cmd[pos++] = '{';
+		for (j = 0; j < ARRAY_SIZE(hisi_iostat_cmd_template); j++) {
+			pos += snprintf(iostat_cmd + pos, ARG_MAX - pos - 1,
+					hisi_iostat_cmd_template[j],
+					rp->sicl_id, rp->core_id, rp->mask);
+
+			if (j == ARRAY_SIZE(hisi_iostat_cmd_template) - 1)
+				iostat_cmd[pos++] = '}';
+			else
+				iostat_cmd[pos++] = ',';
+		}
+
+		ret = parse_event(evl, iostat_cmd);
+		if (ret)
+			break;
+
+		i = 0;
+		evlist__for_each_entry_reverse(evl, evsel) {
+			if (i == ARRAY_SIZE(hisi_iostat_cmd_template))
+				break;
+
+			evsel->priv = rp;
+			i++;
+		}
+
+		memset(iostat_cmd, 0, PATH_MAX);
+		pos = 0;
+	}
+
+	zfree(&iostat_cmd);
+	return ret;
+}
+
+static int hisi_iostat_prepare(struct evlist *evlist,
+			       struct perf_stat_config *config)
+{
+	if (evlist->core.nr_entries > 0) {
+		pr_warning("The -e and -M options are not supported."
+			   "All chosen events/metrics will be dropped\n");
+		evlist__delete(evlist);
+		evlist = evlist__new();
+		if (!evlist)
+			return -ENOMEM;
+	}
+
+	config->metric_only = true;
+	config->aggr_mode = AGGR_GLOBAL;
+
+	return hisi_iostat_add_events(evlist);
+}
+
+static int hisi_pcie_root_ports_list_filter(const char *str)
+{
+	char *tok, *tmp, *copy = NULL;
+	u8 bus, dev, fn;
+	u32 domain;
+	int ret;
+
+	copy = strdup(str);
+	if (!copy)
+		return -ENOMEM;
+
+	for (tok = strtok_r(copy, ",", &tmp); tok; tok = strtok_r(NULL, ",", &tmp)) {
+		ret = sscanf(tok, PCI_DEVICE_NAME_PATTERN, &domain, &bus, &dev, &fn);
+		if (ret != 4) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = hisi_pcie_root_ports_select_one(domain, bus, dev, fn);
+		if (ret)
+			break;
+	}
+
+	zfree(&copy);
+	return ret;
+}
+
+static int hisi_iostat_parse(const struct option *opt, const char *str, int unset __maybe_unused)
+{
+	struct perf_stat_config *config = (struct perf_stat_config *)opt->data;
+	int ret;
+
+	ret = hisi_pcie_root_ports_init();
+	if (ret)
+		return ret;
+
+	config->iostat_run = true;
+
+	if (!str) {
+		iostat_mode = IOSTAT_RUN;
+		hisi_pcie_root_ports_select_all();
+	} else if (!strcmp(str, "list")) {
+		iostat_mode = IOSTAT_LIST;
+		hisi_pcie_root_ports_select_all();
+	} else {
+		iostat_mode = IOSTAT_RUN;
+		ret = hisi_pcie_root_ports_list_filter(str);
+	}
+
+	if (ret)
+		hisi_pcie_root_ports_free();
+
+	return ret;
+}
+
+static void hisi_pcie_root_port_show(FILE *output,
+				     const struct hisi_pcie_root_port * const rp)
+{
+	if (output && rp)
+		fprintf(output, "hisi_pcie%hu_core%hu<" PCI_DEVICE_NAME_PATTERN ">\n",
+			rp->sicl_id, rp->core_id, rp->domain, rp->bus, rp->dev, rp->fn);
+}
+
+static void hisi_iostat_list(struct evlist *evlist __maybe_unused, struct perf_stat_config *config)
+{
+	struct hisi_pcie_root_port *rp = NULL;
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (rp != evsel->priv) {
+			hisi_pcie_root_port_show(config->output, evsel->priv);
+			rp = evsel->priv;
+		}
+	}
+}
+
+static void hisi_iostat_release(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel->priv = NULL;
+
+	hisi_pcie_root_ports_free();
+}
+
+static void hisi_iostat_print_header_prefix(struct perf_stat_config *config)
+{
+	if (config->csv_output)
+		fputs("port,", config->output);
+	else if (config->interval)
+		fprintf(config->output, "#          time    port         ");
+	else
+		fprintf(config->output, "   port         ");
+}
+
+static void hisi_iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+				     struct perf_stat_output_ctx *out)
+{
+	const char *iostat_metric = hisi_iostat_metrics[evsel->core.idx % ARRAY_SIZE(hisi_iostat_metrics)];
+	struct perf_counts_values *count;
+	double iostat_value;
+
+	/* We're using AGGR_GLOBAL so there's only one aggr counts aggr[0]. */
+	count = &evsel->stats->aggr[0].counts;
+
+	/* The counts has been scaled, we can use it directly. */
+	iostat_value = (double)count->val;
+
+	/*
+	 * Display two digits after decimal point for better accuracy if the
+	 * value is non-zero.
+	 */
+	out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN,
+			  iostat_value > 0 ? "%8.2f" : "%8.0f",
+			  iostat_metric, iostat_value / (256 * 1024));
+}
+
+static void hisi_iostat_prefix(struct evlist *evlist, struct perf_stat_config *config,
+			       char *prefix, struct timespec *ts)
+{
+	struct hisi_pcie_root_port *rp = evlist->selected->priv;
+
+	if (!rp)
+		return;
+
+	if (ts)
+		sprintf(prefix, "%6lu.%09lu%s" PCI_DEVICE_NAME_PATTERN "%s",
+			ts->tv_sec, ts->tv_nsec, config->csv_sep,
+			rp->domain, rp->bus, rp->dev, rp->fn,
+			config->csv_sep);
+	else
+		sprintf(prefix, PCI_DEVICE_NAME_PATTERN "%s",
+			rp->domain, rp->bus, rp->dev, rp->fn,
+			config->csv_sep);
+}
+
+static void hisi_iostat_print_counters(struct evlist *evlist, struct perf_stat_config *config,
+				       struct timespec *ts, char *prefix,
+				       iostat_print_counter_t print_cnt_cb, void *arg)
+{
+	struct evsel *counter = evlist__first(evlist);
+	void *perf_device;
+
+	evlist__set_selected(evlist, counter);
+	hisi_iostat_prefix(evlist, config, prefix, ts);
+	fprintf(config->output, "%s", prefix);
+	evlist__for_each_entry(evlist, counter) {
+		perf_device = evlist->selected->priv;
+		if (perf_device && perf_device != counter->priv) {
+			evlist__set_selected(evlist, counter);
+			hisi_iostat_prefix(evlist, config, prefix, ts);
+			fprintf(config->output, "\n%s", prefix);
+		}
+		print_cnt_cb(config, counter, arg);
+	}
+	fputc('\n', config->output);
+}
+
+static bool hisi_iostat_match(struct iostat_pmu *iostat_pmu)
+{
+	return perf_pmus__scan_matching_wildcard(NULL, iostat_pmu->pmu_name_wildcard);
+}
+
+static struct iostat_pmu hisi_iostat_pmu_list[] = {
+	{
+		.pmu_name_wildcard = "hisi_pcie*",
+		.match = hisi_iostat_match,
+		.prepare = hisi_iostat_prepare,
+		.parse = hisi_iostat_parse,
+		.list = hisi_iostat_list,
+		.print_header_prefix = hisi_iostat_print_header_prefix,
+		.print_metric = hisi_iostat_print_metric,
+		.print_counters = hisi_iostat_print_counters,
+		.release = hisi_iostat_release,
+	},
+};
+
+static void __attribute__((constructor)) hisi_iostat_pmu_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(hisi_iostat_pmu_list); i++)
+		register_iostat_pmu(&hisi_iostat_pmu_list[i]);
+}
-- 
2.33.0

