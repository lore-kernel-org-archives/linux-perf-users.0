Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E51CAAF;
	Mon, 19 Aug 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090516; cv=none; b=DAsIDlakvQAfkAW0d8tRSkOWVv+I1TBtESyVn4sth/4WaWQWHVfFz7FQISsENuyz6xnib9xClZ2ByX6SuXXE+CoHbuVY5Nu2O2qpQxKjYDFKCzc9V0iZR+rHdL77k+rdxQM0vljuG2+IQbYmWVNxJLllocmqvu1k6ECtfx/lqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090516; c=relaxed/simple;
	bh=I5U95G16WmoI5DaLDXWkHZxvA3Z4XxwD4z4ZqotGIlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyOlDhCoppOAfiguHFkMGhQT5Mm/N8A3od1tvQVcG/GW5k0XFd3PQll3MfFZ/YtsQ5WAfqIw9D6cdXuc35zpC2k0kkTk+GLgS1yw2Qtk7DUobZHN3zrZhbHSpv2s8LJiZjajzg0oDyX8n31lEeYm/kJmNWQSZtbuIzFmBncsZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvLtQ28u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvLtQ28u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F35C32782;
	Mon, 19 Aug 2024 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090515;
	bh=I5U95G16WmoI5DaLDXWkHZxvA3Z4XxwD4z4ZqotGIlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvLtQ28u66xtgnBQBu4uRzvkkv4IyXqonj9cGJmkucKUw57A0cDds9sL0KuxS/ZlL
	 N9d3GOlMKH0HHfuE1llRbAwvv+S6Uytxjd5XznnaWi2BXiHY1ShjBwBgk1zuT/vJfz
	 b4ZJvfpn0IXeWmBrFf4VDd13g1ElPYDg+AAaRZBt6utDVND8CEp5jU+uRjY6yJmqx9
	 rPT9yxOJaFa9oHiHyysjM+bVlBpLh+OdQfH00Ns3G3+cGdPydON4QluH8vV+Gx9BAr
	 4Hl8g1iIdyBvG2u0jaoZ3hkAiJFETK8r0gaN1AvWGF4g9+y9BpoYP05fUbM8GkAd6W
	 vNRRmaCjU5P0g==
Date: Mon, 19 Aug 2024 15:01:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Anne Macedo <retpolanne@posteo.net>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/13] perf inject: Fix build ID injection
Message-ID: <ZsOIkMEf3l6e-mdX@x1>
References: <20240817064442.2152089-1-irogers@google.com>
 <20240817064442.2152089-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817064442.2152089-11-irogers@google.com>

On Fri, Aug 16, 2024 at 11:44:39PM -0700, Ian Rogers wrote:
> Build ID injection wasn't inserting a sample ID and aligning events to
> 64 bytes rather than 8. No sample ID means events are unordered and
> two different build_id events for the same path, as happens when a
> file is replaced, can't be differentiated.
> 
> Add in sample ID insertion for the build_id events alongside some
> refactoring. The refactoring better aligns the function arguments for
> different use cases, such as synthesizing build_id events without
> needing to have a dso. The misc bits are explicitly passed as with
> callchains the maps/dsos may span user and kernel land, so using
> sample->cpumode isn't good enough.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c        | 170 ++++++++++++++++++++++-------
>  tools/perf/util/build-id.c         |   6 +-
>  tools/perf/util/synthetic-events.c |  44 ++++++--
>  tools/perf/util/synthetic-events.h |  10 +-
>  4 files changed, 175 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a7c859db2e15..84a4bdb5cb0a 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -131,6 +131,7 @@ struct perf_inject {
>  	struct perf_file_section secs[HEADER_FEAT_BITS];
>  	struct guest_session	guest_session;
>  	struct strlist		*known_build_ids;
> +	const struct evsel	*mmap_evsel;
>  };
>  
>  struct event_entry {
> @@ -139,8 +140,13 @@ struct event_entry {
>  	union perf_event event[];
>  };
>  
> -static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
> -				struct machine *machine, u8 cpumode, u32 flags);
> +static int dso__inject_build_id(const struct perf_tool *tool,
> +				struct perf_sample *sample,
> +				struct machine *machine,
> +				const struct evsel *evsel,
> +				__u16 misc,
> +				const char *filename,
> +				struct dso *dso, u32 flags);

So in the end the dso was needed, the name of the function remains
dso__something(), so first arg would be a 'struct dso *'

I processed the patches up to 9/13, so that they can get tested now.

- Arnaldo

>  
>  static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
>  {
> @@ -422,6 +428,28 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
>  	return dso;
>  }
>  
> +/*
> + * The evsel used for the sample ID for mmap events. Typically stashed when
> + * processing mmap events. If not stashed, search the evlist for the first mmap
> + * gathering event.
> + */
> +static const struct evsel *inject__mmap_evsel(struct perf_inject *inject)
> +{
> +	struct evsel *pos;
> +
> +	if (inject->mmap_evsel)
> +		return inject->mmap_evsel;
> +
> +	evlist__for_each_entry(inject->session->evlist, pos) {
> +		if (pos->core.attr.mmap) {
> +			inject->mmap_evsel = pos;
> +			return pos;
> +		}
> +	}
> +	pr_err("No mmap events found\n");
> +	return NULL;
> +}
> +
>  static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
>  					  union perf_event *event,
>  					  struct perf_sample *sample,
> @@ -469,12 +497,28 @@ static int perf_event__repipe_common_mmap(const struct perf_tool *tool,
>  		}
>  
>  		if (dso && !dso__hit(dso)) {
> -			dso__set_hit(dso);
> -			dso__inject_build_id(dso, tool, machine, sample->cpumode, flags);
> +			struct evsel *evsel = evlist__event2evsel(inject->session->evlist, event);
> +
> +			if (evsel) {
> +				dso__set_hit(dso);
> +				dso__inject_build_id(tool, sample, machine, evsel,
> +						     /*misc=*/sample->cpumode,
> +						     filename, dso, flags);
> +			}
>  		}
>  	} else {
> +		int err;
> +
> +		/*
> +		 * Remember the evsel for lazy build id generation. It is used
> +		 * for the sample id header type.
> +		 */
> +		if (inject->build_id_style == BID_RWS__INJECT_HEADER_LAZY &&
> +		    !inject->mmap_evsel)
> +			inject->mmap_evsel = evlist__event2evsel(inject->session->evlist, event);
> +
>  		/* Create the thread, map, etc. Not done for the unordered inject all case. */
> -		int err = perf_event_process(tool, event, sample, machine);
> +		err = perf_event_process(tool, event, sample, machine);
>  
>  		if (err) {
>  			dso__put(dso);
> @@ -667,16 +711,20 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
>  	return false;
>  }
>  
> -static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
> -				struct machine *machine, u8 cpumode, u32 flags)
> +static int dso__inject_build_id(const struct perf_tool *tool,
> +				struct perf_sample *sample,
> +				struct machine *machine,
> +				const struct evsel *evsel,
> +				__u16 misc,
> +				const char *filename,
> +				struct dso *dso, u32 flags)
>  {
> -	struct perf_inject *inject = container_of(tool, struct perf_inject,
> -						  tool);
> +	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
>  	int err;
>  
> -	if (is_anon_memory(dso__long_name(dso)) || flags & MAP_HUGETLB)
> +	if (is_anon_memory(filename) || flags & MAP_HUGETLB)
>  		return 0;
> -	if (is_no_dso_memory(dso__long_name(dso)))
> +	if (is_no_dso_memory(filename))
>  		return 0;
>  
>  	if (inject->known_build_ids != NULL &&
> @@ -684,24 +732,65 @@ static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
>  		return 1;
>  
>  	if (dso__read_build_id(dso) < 0) {
> -		pr_debug("no build_id found for %s\n", dso__long_name(dso));
> +		pr_debug("no build_id found for %s\n", filename);
>  		return -1;
>  	}
>  
> -	err = perf_event__synthesize_build_id(tool, dso, cpumode,
> -					      perf_event__repipe, machine);
> +	err = perf_event__synthesize_build_id(tool, sample, machine,
> +					      perf_event__repipe,
> +					      evsel, misc, dso__bid(dso),
> +					      filename);
>  	if (err) {
> -		pr_err("Can't synthesize build_id event for %s\n", dso__long_name(dso));
> +		pr_err("Can't synthesize build_id event for %s\n", filename);
>  		return -1;
>  	}
>  
>  	return 0;
>  }
>  
> +static int mark_dso_hit(const struct perf_tool *tool,
> +			struct perf_sample *sample,
> +			struct machine *machine,
> +			const struct evsel *mmap_evsel,
> +			struct map *map, bool sample_in_dso)
> +{
> +	struct dso *dso;
> +	u16 misc = sample->cpumode;
> +
> +	if (!map)
> +		return 0;
> +
> +	if (!sample_in_dso) {
> +		u16 guest_mask = PERF_RECORD_MISC_GUEST_KERNEL |
> +			PERF_RECORD_MISC_GUEST_USER;
> +
> +		if ((misc & guest_mask) != 0) {
> +			misc &= PERF_RECORD_MISC_HYPERVISOR;
> +			misc |= __map__is_kernel(map)
> +				? PERF_RECORD_MISC_GUEST_KERNEL
> +				: PERF_RECORD_MISC_GUEST_USER;
> +		} else {
> +			misc &= PERF_RECORD_MISC_HYPERVISOR;
> +			misc |= __map__is_kernel(map)
> +				? PERF_RECORD_MISC_KERNEL
> +				: PERF_RECORD_MISC_USER;
> +		}
> +	}
> +	dso = map__dso(map);
> +	if (dso && !dso__hit(dso)) {
> +		dso__set_hit(dso);
> +		dso__inject_build_id(tool, sample, machine,
> +				mmap_evsel, misc, dso__long_name(dso), dso,
> +				map__flags(map));
> +	}
> +	return 0;
> +}
> +
>  struct mark_dso_hit_args {
>  	const struct perf_tool *tool;
> +	struct perf_sample *sample;
>  	struct machine *machine;
> -	u8 cpumode;
> +	const struct evsel *mmap_evsel;
>  };
>  
>  static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
> @@ -709,16 +798,8 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
>  	struct mark_dso_hit_args *args = data;
>  	struct map *map = node->ms.map;
>  
> -	if (map) {
> -		struct dso *dso = map__dso(map);
> -
> -		if (dso && !dso__hit(dso)) {
> -			dso__set_hit(dso);
> -			dso__inject_build_id(dso, args->tool, args->machine,
> -					     args->cpumode, map__flags(map));
> -		}
> -	}
> -	return 0;
> +	return mark_dso_hit(args->tool, args->sample, args->machine,
> +			    args->mmap_evsel, map, /*sample_in_dso=*/false);
>  }
>  
>  int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
> @@ -728,10 +809,16 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
>  {
>  	struct addr_location al;
>  	struct thread *thread;
> +	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
>  	struct mark_dso_hit_args args = {
>  		.tool = tool,
> +		/*
> +		 * Use the parsed sample data of the sample event, which will
> +		 * have a later timestamp than the mmap event.
> +		 */
> +		.sample = sample,
>  		.machine = machine,
> -		.cpumode = sample->cpumode,
> +		.mmap_evsel = inject__mmap_evsel(inject),
>  	};
>  
>  	addr_location__init(&al);
> @@ -743,13 +830,8 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
>  	}
>  
>  	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
> -		struct dso *dso = map__dso(al.map);
> -
> -		if (!dso__hit(dso)) {
> -			dso__set_hit(dso);
> -			dso__inject_build_id(dso, tool, machine,
> -					     sample->cpumode, map__flags(al.map));
> -		}
> +		mark_dso_hit(tool, sample, machine, args.mmap_evsel, al.map,
> +			     /*sample_in_dso=*/true);
>  	}
>  
>  	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
> @@ -1159,17 +1241,27 @@ static int process_build_id(const struct perf_tool *tool,
>  static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_t machine_pid)
>  {
>  	struct machine *machine = perf_session__findnew_machine(inject->session, machine_pid);
> -	u8 cpumode = dso__is_in_kernel_space(dso) ?
> -			PERF_RECORD_MISC_GUEST_KERNEL :
> -			PERF_RECORD_MISC_GUEST_USER;
> +	struct perf_sample synth_sample = {
> +		.pid	   = -1,
> +		.tid	   = -1,
> +		.time	   = -1,
> +		.stream_id = -1,
> +		.cpu	   = -1,
> +		.period	   = 1,
> +		.cpumode   = dso__is_in_kernel_space(dso)
> +		? PERF_RECORD_MISC_GUEST_KERNEL
> +		: PERF_RECORD_MISC_GUEST_USER,
> +	};
>  
>  	if (!machine)
>  		return -ENOMEM;
>  
>  	dso__set_hit(dso);
>  
> -	return perf_event__synthesize_build_id(&inject->tool, dso, cpumode,
> -					       process_build_id, machine);
> +	return perf_event__synthesize_build_id(&inject->tool, &synth_sample, machine,
> +					       process_build_id, inject__mmap_evsel(inject),
> +					       /*misc=*/synth_sample.cpumode,
> +					       dso__bid(dso), dso__long_name(dso));
>  }
>  
>  static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 451d145fa4ed..8982f68e7230 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -277,8 +277,8 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
>  	struct perf_record_header_build_id b;
>  	size_t len;
>  
> -	len = name_len + 1;
> -	len = PERF_ALIGN(len, NAME_ALIGN);
> +	len = sizeof(b) + name_len + 1;
> +	len = PERF_ALIGN(len, sizeof(u64));
>  
>  	memset(&b, 0, sizeof(b));
>  	memcpy(&b.data, bid->data, bid->size);
> @@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
>  	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
>  	b.pid = pid;
>  	b.header.misc = misc;
> -	b.header.size = sizeof(b) + len;
> +	b.header.size = len;
>  
>  	err = do_write(fd, &b, sizeof(b));
>  	if (err < 0)
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 0a7f93ae76fb..6bb62e4e2d5d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2225,28 +2225,48 @@ int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, st
>  }
>  #endif
>  
> -int perf_event__synthesize_build_id(const struct perf_tool *tool, struct dso *pos, u16 misc,
> -				    perf_event__handler_t process, struct machine *machine)
> +int perf_event__synthesize_build_id(const struct perf_tool *tool,
> +				    struct perf_sample *sample,
> +				    struct machine *machine,
> +				    perf_event__handler_t process,
> +				    const struct evsel *evsel,
> +				    __u16 misc,
> +				    const struct build_id *bid,
> +				    const char *filename)
>  {
>  	union perf_event ev;
>  	size_t len;
>  
> -	if (!dso__hit(pos))
> -		return 0;
> +	len = sizeof(ev.build_id) + strlen(filename) + 1;
> +	len = PERF_ALIGN(len, sizeof(u64));
>  
> -	memset(&ev, 0, sizeof(ev));
> +	memset(&ev, 0, len);
>  
> -	len = dso__long_name_len(pos) + 1;
> -	len = PERF_ALIGN(len, NAME_ALIGN);
> -	ev.build_id.size = min(dso__bid(pos)->size, sizeof(dso__bid(pos)->data));
> -	memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.size);
> +	ev.build_id.size = min(bid->size, sizeof(ev.build_id.build_id));
> +	memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
>  	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
>  	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
>  	ev.build_id.pid = machine->pid;
> -	ev.build_id.header.size = sizeof(ev.build_id) + len;
> -	memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name_len(pos));
> +	ev.build_id.header.size = len;
> +	strcpy(ev.build_id.filename, filename);
> +
> +	if (evsel) {
> +		void *array = &ev;
> +		int ret;
>  
> -	return process(tool, &ev, NULL, machine);
> +		array += ev.header.size;
> +		ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & 7) {
> +			pr_err("Bad id sample size %d\n", ret);
> +			return -EINVAL;
> +		}
> +
> +		ev.header.size += ret;
> +	}
> +	return process(tool, &ev, sample, machine);
>  }
>  
>  int perf_event__synthesize_stat_events(struct perf_stat_config *config, const struct perf_tool *tool,
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index 31df7653677f..795bf3e18396 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -9,6 +9,7 @@
>  #include <perf/cpumap.h>
>  
>  struct auxtrace_record;
> +struct build_id;
>  struct dso;
>  struct evlist;
>  struct evsel;
> @@ -45,7 +46,14 @@ typedef int (*perf_event__handler_t)(const struct perf_tool *tool, union perf_ev
>  
>  int perf_event__synthesize_attrs(const struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process);
>  int perf_event__synthesize_attr(const struct perf_tool *tool, struct perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
> -int perf_event__synthesize_build_id(const struct perf_tool *tool, struct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machine);
> +int perf_event__synthesize_build_id(const struct perf_tool *tool,
> +				    struct perf_sample *sample,
> +				    struct machine *machine,
> +				    perf_event__handler_t process,
> +				    const struct evsel *evsel,
> +				    __u16 misc,
> +				    const struct build_id *bid,
> +				    const char *filename);
>  int perf_event__synthesize_cpu_map(const struct perf_tool *tool, const struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
>  int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struct evsel *evsel, perf_event__handler_t process);
> -- 
> 2.46.0.184.g6999bdac58-goog
