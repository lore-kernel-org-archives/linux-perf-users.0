Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1108F6B;
	Wed, 28 May 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464735; cv=none; b=esBWVHREaHMv7mnGAE/OV9Nlb/9hjhpm5ehik15m+NrSn4RksRc8u8BhzeH8TtF3vK2CD0W5k7hs1h1BwY2B2bhxiqNQRjFarcETRntvu6K2eoFIvAazaE7B5pevWU2khJO0YHRYJ80vIXWJdzmcM6PsBhoFt3O+k9MdGzPyyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464735; c=relaxed/simple;
	bh=3zK/FpG9cFN4FNW66UMTc0FyOKX8r+B1iM0GpFXw7Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBdA2iHfKpOg/vJCsYy5HqthTrIIaHbYcknFehFBI4C7Edi2Fcr9nDQnsYqczJefj9t2rMd5xBF0ewJgAKGS8WE1dgOruqZjQZgS8qDxCa3sh1srx37gB735Y0jh6Jy/yn5mMiDuxv605h4UAJQINi1VuFZmHNOr7s4kWbjCkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKkJN0PP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKkJN0PP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C970C4CEE3;
	Wed, 28 May 2025 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748464733;
	bh=3zK/FpG9cFN4FNW66UMTc0FyOKX8r+B1iM0GpFXw7Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKkJN0PP8+TL9eZGuvKhU/gkuXwxwnVvLQv9TnuUtpIk4jdJvQWOHRBvT48uH0Im7
	 1SyNpDSvP8cR7xRBloHrC1zsCqEoxHTpLr2UAY4d8I1r6kFomw4sFknxNL9IuJAvhn
	 boapk1UZr5IIlUkemUp6y8r6iLX8EQuewSqYj1RUP5T9tFGEhuv726NRb/KP4LqI8s
	 ICiosW21SS10CO70ar0A/50OnEVydsSViWc0GMsn6tDmJ4dipxuPd0tVQ5kbabFMgH
	 ytdVWqXdavcUgWlyYPXV6+htEvsgWjwG+bpodOaspB3EsorY3KQujRZsrWc98GoVaY
	 fEnSUYJ79brLg==
Date: Wed, 28 May 2025 13:38:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] perf record: Make --buildid-mmap the default
Message-ID: <aDd0Wqy6yw6Tu0vg@google.com>
References: <20250428213409.1417584-1-irogers@google.com>
 <20250428213409.1417584-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428213409.1417584-10-irogers@google.com>

On Mon, Apr 28, 2025 at 02:34:08PM -0700, Ian Rogers wrote:
> Support for build IDs in mmap2 perf events has been present since
> Linux v5.12:
> https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
> Build ID mmap events don't avoid the need to inject build IDs for DSO
> touched by samples as the build ID cache is populated by perf
> record. They can avoid some cases of symbol mis-resolution caused by
> the file system changing from when a sample occurred and when the DSO
> is sought. To disable build ID scanning
> 
> Unlike the --buildid-mmap option, this doesn't disable the build ID
> cache but it does disable the processing of samples looking for DSOs
> to inject build IDs for. To disable the build ID cache the -B
> (--no-buildid) option should be used.
> 
> Making this option the default was raised on the list in:
> https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c        | 33 +++++++++++++++++++-----------
>  tools/perf/util/symbol_conf.h      |  2 +-
>  tools/perf/util/synthetic-events.c | 16 +++++++--------
>  3 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba20bf7c011d..7b64013ba8c0 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -169,6 +169,7 @@ struct record {
>  	bool			no_buildid_cache_set;
>  	bool			buildid_all;
>  	bool			buildid_mmap;
> +	bool			buildid_mmap_set;
>  	bool			timestamp_filename;
>  	bool			timestamp_boundary;
>  	bool			off_cpu;
> @@ -1795,6 +1796,7 @@ record__finish_output(struct record *rec)
>  			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
>  	}
>  
> +	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
>  	if (!rec->no_buildid) {
>  		process_buildids(rec);
>  
> @@ -2966,6 +2968,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  			rec->no_buildid = true;
>  		else if (!strcmp(value, "mmap"))
>  			rec->buildid_mmap = true;
> +		else if (!strcmp(value, "no-mmap"))
> +			rec->buildid_mmap = false;
>  		else
>  			return -1;
>  		return 0;
> @@ -3349,6 +3353,7 @@ static struct record record = {
>  		.ctl_fd_ack          = -1,
>  		.synth               = PERF_SYNTH_ALL,
>  	},
> +	.buildid_mmap = true,
>  };
>  
>  const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
> @@ -3514,8 +3519,8 @@ static struct option __record_options[] = {
>  		   "file", "vmlinux pathname"),
>  	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
>  		    "Record build-id of all DSOs regardless of hits"),
> -	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> -		    "Record build-id in map events"),
> +	OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.buildid_mmap_set,
> +			"Legacy record build-id in map events option which is now the default. Behaves indentically to --no-buildid. Disable with --no-buildid-mmap"),
>  	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
>  		    "append timestamp to output filename"),
>  	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> @@ -4042,19 +4047,23 @@ int cmd_record(int argc, const char **argv)
>  		record.opts.record_switch_events = true;
>  	}
>  
> +	if (!rec->buildid_mmap) {
> +		pr_debug("Disabling build id in synthesized mmap2 events.\n");
> +		symbol_conf.no_buildid_mmap2 = true;
> +	} else if (rec->buildid_mmap_set) {
> +		/*
> +		 * Explicitly passing --buildid-mmap disables buildid processing
> +		 * and cache generation.
> +		 */
> +		rec->no_buildid = true;
> +	}
> +	if (rec->buildid_mmap && !perf_can_record_build_id()) {
> +		pr_warning("Missing support for build id in kernel mmap events. Disable this warning with --no-buildid-mmap\n");
> +		rec->buildid_mmap = false;
> +	}
>  	if (rec->buildid_mmap) {
> -		if (!perf_can_record_build_id()) {
> -			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> -			err = -EINVAL;
> -			goto out_opts;
> -		}
> -		pr_debug("Enabling build id in mmap2 events.\n");
> -		/* Enable mmap build id synthesizing. */
> -		symbol_conf.buildid_mmap2 = true;
>  		/* Enable perf_event_attr::build_id bit. */
>  		rec->opts.build_id = true;
> -		/* Disable build id cache. */
> -		rec->no_buildid = true;
>  	}
>  
>  	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index cd9aa82c7d5a..7a80d2c14d9b 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -43,7 +43,7 @@ struct symbol_conf {
>  			report_individual_block,
>  			inline_name,
>  			disable_add2line_warn,
> -			buildid_mmap2,
> +			no_buildid_mmap2,
>  			guest_code,
>  			lazy_load_kernel_maps,
>  			keep_exited_threads,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 69b98023ce74..638d7dd7fa4b 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -532,7 +532,7 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool,
>  		event->mmap2.pid = tgid;
>  		event->mmap2.tid = pid;
>  
> -		if (symbol_conf.buildid_mmap2)
> +		if (!symbol_conf.no_buildid_mmap2)

I find the double negation confusing.  Can we keep it positive?

Thanks,
Namhyung


>  			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
>  
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
> @@ -690,7 +690,7 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
>  		return 0;
>  
>  	dso = map__dso(map);
> -	if (symbol_conf.buildid_mmap2) {
> +	if (!symbol_conf.no_buildid_mmap2) {
>  		size = PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u64));
>  		event->mmap2.header.type = PERF_RECORD_MMAP2;
>  		event->mmap2.header.size = (sizeof(event->mmap2) -
> @@ -734,9 +734,9 @@ int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__han
>  		.process = process,
>  		.machine = machine,
>  	};
> -	size_t size = symbol_conf.buildid_mmap2
> -		? sizeof(args.event->mmap2)
> -		: sizeof(args.event->mmap);
> +	size_t size = symbol_conf.no_buildid_mmap2
> +		? sizeof(args.event->mmap)
> +		: sizeof(args.event->mmap2);
>  
>  	args.event = zalloc(size + machine->id_hdr_size);
>  	if (args.event == NULL) {
> @@ -1124,8 +1124,8 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
>  						struct machine *machine)
>  {
>  	union perf_event *event;
> -	size_t size = symbol_conf.buildid_mmap2 ?
> -			sizeof(event->mmap2) : sizeof(event->mmap);
> +	size_t size = symbol_conf.no_buildid_mmap2 ?
> +			sizeof(event->mmap) : sizeof(event->mmap2);
>  	struct map *map = machine__kernel_map(machine);
>  	struct kmap *kmap;
>  	int err;
> @@ -1159,7 +1159,7 @@ static int __perf_event__synthesize_kernel_mmap(const struct perf_tool *tool,
>  		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
>  	}
>  
> -	if (symbol_conf.buildid_mmap2) {
> +	if (!symbol_conf.no_buildid_mmap2) {
>  		size = snprintf(event->mmap2.filename, sizeof(event->mmap2.filename),
>  				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
>  		size = PERF_ALIGN(size, sizeof(u64));
> -- 
> 2.49.0.901.g37484f566f-goog
> 
