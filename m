Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071E3A8F0
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503236; cv=none; b=rWR1LteXiTNXhTRg9swxJjW/G/QqizzwcpcFIfymOLPIjg16NKRk/ps3q0sfkddGToFcH/kkO9TDJPCiSg7a4c/H3JqJ1qUqp+g4kxHbzU6WPcXjsGNk87uRON2M5YCwnC+9cYOct7l2y6L1psKIbUFiLwxclqBAiwmaVa7jV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503236; c=relaxed/simple;
	bh=LggmRAJYF3cwsI+fNoDjAFr/FMi5iyRzEM83eOmp6BA=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MggpbGMipKftA3X1M7Vor5CjWopY9J/xC6Adjcux4IuSXHSj5DmwuxFGNe1S+izP91DaURcLaJtdufCxZRve+IInJe95TWKi+KE5he3QbTnoRPEBD40k5gywT4xuVuuBtw7FFCbTlEtNH1HW4csGDb9CIUZfF0zCNe+9Xpz0j68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tfprt54c2z1h0W3;
	Wed, 21 Feb 2024 16:11:42 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A3791A0172;
	Wed, 21 Feb 2024 16:13:51 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 16:13:50 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@arm.com>, <mike.leach@linaro.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
To: Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20240208032518.25830-1-yangyicong@huawei.com>
 <ZcYtDHLr6NQ-BFbx@x1>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <3942d4f7-7282-6fcf-90d5-8f864e43dd19@huawei.com>
Date: Wed, 21 Feb 2024 16:13:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcYtDHLr6NQ-BFbx@x1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)

Hi Arnaldo,

Thanks for the comments.

On 2024/2/9 21:47, Arnaldo Carvalho de Melo wrote:
> On Thu, Feb 08, 2024 at 11:25:18AM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Some HiSilicon platforms provide PCIe PMU devices for monitoring the
>> throughput and latency of PCIe traffic. With the support of PCIe PMU
>> we can enable the perf iostat mode.
[...]
>> +static void hisi_pcie_root_ports_add(u16 sicl_id, u16 core_id, u8 target_bus)
>> +{
>> +	const char *sysfs = sysfs__mountpoint();
>> +	struct hisi_pcie_root_port *rp;
>> +	struct dirent *dent;
>> +	char path[PATH_MAX];
>> +	u8 bus, dev, fn;
>> +	u32 domain;
>> +	DIR *dir;
>> +	int ret;
>> +
>> +	snprintf(path, PATH_MAX, "%s/%s", sysfs, PCI_ROOT_BUS_DEVICES_PATH);
>> +	dir = opendir(path);
>> +	if (!dir)
>> +		return;
>> +
>> +	/* Scan the PCI root bus to find the match root port on @target_bus */
>> +	while ((dent = readdir(dir))) {
>> +		ret = sscanf(dent->d_name, PCI_DEVICE_NAME_PATTERN,
>> +			     &domain, &bus, &dev, &fn);
>> +		if (ret != 4 || bus != target_bus)
>> +			continue;
>> +
>> +		rp = zalloc(sizeof(*rp));
>> +		if (!rp)
>> +			continue;
> 
> shouldn't it emit some pr_debug message? Like you did with that
> pr_debug3() info message below.
> 

ok will complete the debug messages here and below. I didn't add it here may because
I didn't met the issue here when debugging..

>> +
>> +		rp->selected = false;
>> +		rp->sicl_id = sicl_id;
>> +		rp->core_id = core_id;
>> +		rp->domain = domain;
>> +		rp->bus = bus;
>> +		rp->dev = dev;
>> +		rp->fn = fn;
>> +
>> +		hisi_pcie_init_root_port_mask(rp);
>> +
>> +		list_add(&rp->list, &hisi_pcie_root_ports_list);
>> +		hisi_pcie_root_ports_num++;
>> +
>> +		pr_debug3("Found root port %s\n", dent->d_name);
>> +	}
>> +
>> +	closedir(dir);
>> +}
>> +
>> +/* Scan the PMUs and build the mapping of the Root Ports to the PMU */
>> +static int hisi_pcie_root_ports_init(void)
>> +{
>> +	char event_source[PATH_MAX], bus_path[PATH_MAX];
>> +	unsigned long long bus;
>> +	u16 sicl_id, core_id;
>> +	struct dirent *dent;
>> +	DIR *dir;
>> +
>> +	perf_pmu__event_source_devices_scnprintf(event_source, sizeof(event_source));
>> +	dir = opendir(event_source);
>> +	if (!dir)
>> +		return -ENOENT;
> 
> Is this the only possibility? I.e. if a non root user tries this and the
> file is there, shouldn't we inform that root permission is needed? Or
> any other access mechanism that may be used.
> 
> For instance, in perf we have things like kernel.perf_event_paranoid,
> capabilities, etc.
> 

Thanks for the information. Will have a check on it, didn't consider about the
permission things.

> Take a look at the evsel__open_strerror() function, to see how it tries
> to translate errors like the above to an informative message to help the
> user setup its system.
> 

Thanks for the hint. Will have a reference on that.

>> +
>> +	while ((dent = readdir(dir))) {
>> +		/*
>> +		 * This HiSilicon PCIe PMU will be named as:
>> +		 *   hisi_pcie<sicl_id>_core<core_id>
>> +		 */
>> +		if ((sscanf(dent->d_name, "hisi_pcie%hu_core%hu", &sicl_id, &core_id)) != 2)
>> +			continue;
>> +
>> +		/*
>> +		 * Driver will export the root port it can monitor through
>> +		 * the "bus" sysfs attribute.
>> +		 */
>> +		scnprintf(bus_path, sizeof(bus_path), "%s/hisi_pcie%hu_core%hu/bus",
>> +			  event_source, sicl_id, core_id);
>> +
>> +		/*
>> +		 * Per PCIe spec the bus should be 8bit, use unsigned long long
>> +		 * for the convience of the library function.
>> +		 */
>> +		if (filename__read_ull(bus_path, &bus))
> 
> Shouldn't we have a pr_debug3() here as well?
> 

will add.

>> +			continue;
> 
>> +
>> +		pr_debug3("Found pmu %s bus 0x%llx\n", dent->d_name, bus);
>> +
>> +		hisi_pcie_root_ports_add(sicl_id, core_id, (u8)bus);
>> +	}
>> +
>> +	closedir(dir);
>> +	return hisi_pcie_root_ports_num > 0 ? 0 : -ENOENT;
>> +}
>> +
>> +static void hisi_pcie_root_ports_free(void)
>> +{
>> +	struct hisi_pcie_root_port *rp, *tmp;
>> +
>> +	if (hisi_pcie_root_ports_num == 0)
>> +		return;
>> +
>> +	list_for_each_entry_safe(rp, tmp, &hisi_pcie_root_ports_list, list) {
>> +		list_del(&rp->list);
> 
> list_del_init()
> 

will use it.

>> +		zfree(&rp);
> 
> No need to use zfree here, its a local variable, not something that is
> in a data structure that may have some dangling connection somewhere and
> thus we better initialize to zero instead of reading random deleted
> memory.
> 

got it. Will use free() instead here.

>> +		hisi_pcie_root_ports_num--;
>> +	}
>> +}
>> +
>> +static int hisi_iostat_add_events(struct evlist *evl)
>> +{
>> +	struct hisi_pcie_root_port *rp;
>> +	struct evsel *evsel;
>> +	unsigned int i, j;
>> +	char *iostat_cmd;
>> +	int pos = 0;
>> +	int ret;
>> +
>> +	if (!hisi_pcie_root_ports_num)
>> +		return -ENOENT;
>> +
>> +	iostat_cmd = zalloc(PATH_MAX);
>> +	if (!iostat_cmd)
>> +		return -ENOMEM;
>> +
>> +	list_for_each_entry(rp, &hisi_pcie_root_ports_list, list) {
>> +		if (!rp->selected)
>> +			continue;
>> +
>> +		iostat_cmd[pos++] = '{';
>> +		for (j = 0; j < METRIC_TYPE_MAX; j++) {
>> +			pos += snprintf(iostat_cmd + pos, ARG_MAX - pos - 1,
>> +					hisi_iostat_cmd_template[j],
>> +					rp->sicl_id, rp->core_id, rp->mask);
>> +
>> +			if (j == METRIC_TYPE_MAX - 1)
>> +				iostat_cmd[pos++] = '}';
>> +			else
>> +				iostat_cmd[pos++] = ',';
>> +		}
>> +
>> +		ret = parse_event(evl, iostat_cmd);
>> +		if (ret)
> 
> pr_debug3()?
ok.

>> +			break;
>> +
>> +		i = 0;
>> +		evlist__for_each_entry_reverse(evl, evsel) {
>> +			if (i == METRIC_TYPE_MAX)
>> +				break;
>> +
>> +			evsel->priv = rp;
>> +			i++;
>> +		}
>> +
>> +		memset(iostat_cmd, 0, PATH_MAX);
>> +		pos = 0;
>> +	}
>> +
>> +	zfree(&iostat_cmd);
> 
> no need for zfree here, again its a local variable.
> 
>> +	return ret;
>> +}
>> +
>> +int iostat_prepare(struct evlist *evlist,
>> +		   struct perf_stat_config *config)
>> +{
>> +	if (evlist->core.nr_entries > 0) {
>> +		pr_warning("The -e and -M options are not supported."
>> +			   "All chosen events/metrics will be dropped\n");
>> +		evlist__delete(evlist);
>> +		evlist = evlist__new();
>> +		if (!evlist)
>> +			return -ENOMEM;
> 
> Can you explain how this works? Shouldn't we just bail out completely
> instead of creating an empty evlist?
> 

Here I just keep consistence with x86's implementation. For iostat only
iostat related evsels should be added and organized in certain order.

Warn the user and bail out completely with out continue may be another
choice.

Do you suggest to bail out here and also for x86 iostat for consistence?

>> +	}
>> +
>> +	config->metric_only = true;
>> +	config->aggr_mode = AGGR_GLOBAL;
>> +
>> +	return hisi_iostat_add_events(evlist);
>> +}
>> +
>> +static int hisi_pcie_root_ports_list_filter(const char *str)
>> +{
>> +	char *tok, *tmp, *copy = NULL;
>> +	u8 bus, dev, fn;
>> +	u32 domain;
>> +	int ret;
>> +
>> +	copy = strdup(str);
>> +	if (!copy)
>> +		return -ENOMEM;
>> +
>> +	for (tok = strtok_r(copy, ",", &tmp); tok; tok = strtok_r(NULL, ",", &tmp)) {
>> +		ret = sscanf(tok, PCI_DEVICE_NAME_PATTERN, &domain, &bus, &dev, &fn);
>> +		if (ret != 4) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		ret = hisi_pcie_root_ports_select_one(domain, bus, dev, fn);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	zfree(&copy);
> 
> No need for zfree()
> 

ok.

>> +	return ret;
>> +}
>> +
>> +int iostat_parse(const struct option *opt, const char *str, int unset __maybe_unused)
>> +{
>> +	struct perf_stat_config *config = (struct perf_stat_config *)opt->data;
>> +	int ret;
>> +
>> +	ret = hisi_pcie_root_ports_init();
>> +	if (!ret) {
>> +		config->iostat_run = true;
>> +
>> +		if (!str) {
>> +			iostat_mode = IOSTAT_RUN;
>> +			hisi_pcie_root_ports_select_all();
>> +		} else if (!strcmp(str, "list")) {
>> +			iostat_mode = IOSTAT_LIST;
>> +			hisi_pcie_root_ports_select_all();
>> +		} else {
>> +			iostat_mode = IOSTAT_RUN;
>> +			ret = hisi_pcie_root_ports_list_filter(str);
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void hisi_pcie_root_port_show(FILE *output,
>> +				     const struct hisi_pcie_root_port * const rp)
>> +{
>> +	if (output && rp)
>> +		fprintf(output, "hisi_pcie%hu_core%hu<" PCI_DEVICE_NAME_PATTERN ">\n",
>> +			rp->sicl_id, rp->core_id, rp->domain, rp->bus, rp->dev, rp->fn);
> 
> Multi line if blocks should be enclosed in {}
> 

got it. will enclose it with {}.

>> +}
>> +
>> +void iostat_list(struct evlist *evlist __maybe_unused, struct perf_stat_config *config)
>> +{
>> +	struct hisi_pcie_root_port *rp = NULL;
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
> 
> Can you add a comment explaining this evsel->priv check? Probably we
> have multiple ports and some are shared with multiple evsels and we
> don't have a ports list, so we reuse the evsel list, etc.
> 
> Having a comment with the above info may help future reviewers?
> 

sure. will add comment here.

>> +		if (rp != evsel->priv) {
>> +			hisi_pcie_root_port_show(config->output, evsel->priv);
>> +			rp = evsel->priv;
>> +		}
>> +	}
>> +}
>> +
>> +void iostat_release(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel)
>> +		evsel->priv = NULL;
>> +
> 
> But then here you zero out all the privs and still can iterate the list
> of ports in the following function:
> 
>> +	hisi_pcie_root_ports_free();
> 
> Why not iterate on hisi_pcie_root_ports_list in iostat_list()?
> 

I think you're right. For listing mode (`perf iostat list`) we don't need
to counting and adding evsels, so iterate hisi_pcie_root_ports_list will be
enough. Since no evsels added evlist will be empty.

>> +}
>> +
>> +void iostat_print_header_prefix(struct perf_stat_config *config)
>> +{
>> +	if (config->csv_output)
>> +		fputs("port,", config->output);
>> +	else if (config->interval)
>> +		fprintf(config->output, "#          time    port         ");
>> +	else
>> +		fprintf(config->output, "   port         ");
>> +}
>> +
>> +void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>> +			 struct perf_stat_output_ctx *out)
>> +{
>> +	struct perf_counts_values *count;
>> +	const char *iostat_metric;
>> +	double iostat_value;
>> +
>> +	iostat_metric = hisi_iostat_metrics[evsel->core.idx % METRIC_TYPE_MAX];
>> +
>> +	/* We're using AGGR_GLOBAL so there's only one aggr counts aggr[0]. */
>> +	count = &evsel->stats->aggr[0].counts;
>> +
>> +	/* The counts has been scaled, we can use it directly. */
>> +	iostat_value = (double)count->val;
>> +
>> +	/*
>> +	 * Calculate the bandwidth in MiB since the PMU counts in DWord.
>> +	 * Display two digits after decimal point for better accuracy if the
>> +	 * value is non-zero.
>> +	 */
>> +	out->print_metric(config, out->ctx, NULL,
>> +			  iostat_value > 0 ? "%8.2f" : "%8.0f", iostat_metric,
>> +			  iostat_value * sizeof(uint32_t) / (1024 * 1024));
>> +}
>> +
>> +void iostat_prefix(struct evlist *evlist, struct perf_stat_config *config,
>> +		   char *prefix, struct timespec *ts)
>> +{
>> +	struct hisi_pcie_root_port *rp = evlist->selected->priv;
>> +
>> +	if (rp) {
>> +		if (ts)
>> +			sprintf(prefix, "%6lu.%09lu%s" PCI_DEVICE_NAME_PATTERN "%s",
> 
> Can you use scnprintf? and pass the size of prefix to iostat_prefix()?
> 

sure. will use scnprintf().

Thanks,
Yicong
