Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D533C50D;
	Thu,  6 Nov 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456132; cv=none; b=c0YS5EDlFl1HpxnpcnEUrMfn8qhunK1rJkN7e/gRr6AzBvz2TyGuA+LcX7YQsHff5YEyMJMAMpmqua62f3nirIEPr8gEk2xZtMRDb7XQyCS857EG6/l9kVghNRAPT8HInnKZPXG1Z/r+mLcCcJzbQo4i2K0G1u+YlBIkH91Ddyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456132; c=relaxed/simple;
	bh=T9zay+12a0voS7iC6ls/mch2JLcJxMY0qU+AWDdJF/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFtKDboBFVkNh/3dyycH7iREf3Lqkm30BLqSg5fnwkW1ANniRtkgNgoNGZONJyvkdVzEEJPPDf4TpqT6wf/iq3xoezKNMuPglLbqKYT8sq6w4YbSWbUiN7VTeGK+ePRNN3D7SSb7Ihopq/ItBvnNZYxlEbkXHSevDHvbQoevKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnZeZyr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnZeZyr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6ADC113D0;
	Thu,  6 Nov 2025 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762456130;
	bh=T9zay+12a0voS7iC6ls/mch2JLcJxMY0qU+AWDdJF/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnZeZyr8lVHtgMwRQG6RU3DlsYh22jGct8VfVTZU82iKlGyofCTWuHrJfDkvkKLaU
	 P6o3c1vYPD0TttpI6ef+uGXZQma/KY07Q1KIsN6tKy2lMvMD7LmNd1jSBm2+FxnyGe
	 l7hdJWtIizZnX1OZkHW/0dZewZXl8AMcjwFxU+VeDjZoJgYUY+hEOFsLVG/gc7NW8d
	 sDfuEc8Qt9PFRbAxQFvQAmrSxKTgHsb7s2BZi144Ey2G+p8hBMPsCZs80AWWG5I4Zr
	 aMr/9UDRNn0Tuom+uGx+5Kpwtd+W3/JvDZWFQKbz+ovofLQoI1kSJ2qB+6bqarwqZc
	 h3x7N++z7qkEA==
Date: Thu, 6 Nov 2025 11:08:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gabriel Marin <gmx@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Gautam Menghani <gautam@linux.ibm.com>, tanze <tanze@kylinos.cn>,
	Andi Kleen <ak@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Blake Jones <blakejones@google.com>,
	Anubhav Shelat <ashelat@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf tool: Add a delegate_tool that just
 delegates actions to another tool
Message-ID: <aQzyPf1_vln3WoSL@google.com>
References: <20251105001103.1296863-1-irogers@google.com>
 <20251105001103.1296863-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105001103.1296863-2-irogers@google.com>

On Tue, Nov 04, 2025 at 04:11:03PM -0800, Ian Rogers wrote:
> Add an ability to be able to compose perf_tools, by having one perform
> an action and then calling a delegate. Currently the perf_tools have
> if-then-elses setting the callback and then if-then-elses within the
> callback. Understanding the behavior is complex as it is in two places
> and logic for numerous operations, within things like perf inject, is
> interwoven. By chaining perf_tools together based on command line
> options this kind of code can be avoided.

Can you please explain what the actual usecase is?  Do you plan to use
it for perf inject?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/tool.c | 171 +++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/tool.h |   9 +++
>  2 files changed, 180 insertions(+)
> 
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index c983b526b30d..22a8a4ffe05f 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -321,3 +321,174 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
>  {
>  	return tool->compressed == perf_session__process_compressed_event_stub;
>  }
> +
> +#define CREATE_DELEGATE_SAMPLE(name) \
> +	static int delegate_ ## name(const struct perf_tool *tool, \
> +				     union perf_event *event, \
> +				     struct perf_sample *sample, \
> +				     struct evsel *evsel, \
> +				     struct machine *machine) \
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;		\
> +		return delegate->name(delegate, event, sample, evsel, machine);	\
> +	}
> +CREATE_DELEGATE_SAMPLE(read);
> +CREATE_DELEGATE_SAMPLE(sample);
> +
> +#define CREATE_DELEGATE_ATTR(name)					\
> +	static int delegate_ ## name(const struct perf_tool *tool,	\
> +				union perf_event *event,		\
> +				struct evlist **pevlist)		\
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;		\
> +		return delegate->name(delegate, event, pevlist);	\
> +	}
> +CREATE_DELEGATE_ATTR(attr);
> +CREATE_DELEGATE_ATTR(event_update);
> +
> +#define CREATE_DELEGATE_OE(name)				   \
> +	static int delegate_ ## name(const struct perf_tool *tool, \
> +				     union perf_event *event,	   \
> +				     struct ordered_events *oe)	   \
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;		\
> +		return delegate->name(delegate, event, oe);	\
> +	}
> +CREATE_DELEGATE_OE(finished_round);
> +
> +#define CREATE_DELEGATE_OP(name)				   \
> +	static int delegate_ ## name(const struct perf_tool *tool, \
> +				     union perf_event *event, \
> +				     struct perf_sample *sample, \
> +				     struct machine *machine) \
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;		\
> +		return delegate->name(delegate, event, sample, machine); \
> +	}
> +CREATE_DELEGATE_OP(aux);
> +CREATE_DELEGATE_OP(aux_output_hw_id);
> +CREATE_DELEGATE_OP(bpf);
> +CREATE_DELEGATE_OP(cgroup);
> +CREATE_DELEGATE_OP(comm);
> +CREATE_DELEGATE_OP(context_switch);
> +CREATE_DELEGATE_OP(exit);
> +CREATE_DELEGATE_OP(fork);
> +CREATE_DELEGATE_OP(itrace_start);
> +CREATE_DELEGATE_OP(ksymbol);
> +CREATE_DELEGATE_OP(lost);
> +CREATE_DELEGATE_OP(lost_samples);
> +CREATE_DELEGATE_OP(mmap);
> +CREATE_DELEGATE_OP(mmap2);
> +CREATE_DELEGATE_OP(namespaces);
> +CREATE_DELEGATE_OP(text_poke);
> +CREATE_DELEGATE_OP(throttle);
> +CREATE_DELEGATE_OP(unthrottle);
> +
> +#define CREATE_DELEGATE_OP2(name)					\
> +	static int delegate_ ## name(const struct perf_tool *tool,	\
> +				     struct perf_session *session,	\
> +				     union perf_event *event)		\
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;		\
> +		return delegate->name(delegate, session, event);	\
> +	}
> +CREATE_DELEGATE_OP2(auxtrace_error);
> +CREATE_DELEGATE_OP2(auxtrace_info);
> +CREATE_DELEGATE_OP2(bpf_metadata);
> +CREATE_DELEGATE_OP2(build_id);
> +CREATE_DELEGATE_OP2(cpu_map);
> +CREATE_DELEGATE_OP2(feature);
> +CREATE_DELEGATE_OP2(finished_init);
> +CREATE_DELEGATE_OP2(id_index);
> +CREATE_DELEGATE_OP2(stat);
> +CREATE_DELEGATE_OP2(stat_config);
> +CREATE_DELEGATE_OP2(stat_round);
> +CREATE_DELEGATE_OP2(thread_map);
> +CREATE_DELEGATE_OP2(time_conv);
> +CREATE_DELEGATE_OP2(tracing_data);
> +
> +#define CREATE_DELEGATE_OP3(name)					\
> +	static s64 delegate_ ## name(const struct perf_tool *tool,	\
> +				     struct perf_session *session,      \
> +				     union perf_event *event)           \
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;	\
> +		return delegate->name(delegate, session, event);	\
> +	}
> +CREATE_DELEGATE_OP3(auxtrace);
> +
> +#define CREATE_DELEGATE_OP4(name)					\
> +	static int delegate_ ## name(const struct perf_tool *tool, \
> +			struct perf_session *session, \
> +			union perf_event *event, \
> +			u64 data, \
> +			const char *str) \
> +	{								\
> +		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
> +		struct perf_tool *delegate = del_tool->delegate;		\
> +		return delegate->name(delegate, session, event, data, str);	\
> +	}
> +CREATE_DELEGATE_OP4(compressed);
> +
> +void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate)
> +{
> +	tool->delegate = delegate;
> +
> +	tool->tool.ordered_events = delegate->ordered_events;
> +	tool->tool.ordering_requires_timestamps = delegate->ordering_requires_timestamps;
> +	tool->tool.namespace_events = delegate->namespace_events;
> +	tool->tool.cgroup_events = delegate->cgroup_events;
> +	tool->tool.no_warn = delegate->no_warn;
> +	tool->tool.show_feat_hdr = delegate->show_feat_hdr;
> +
> +	tool->tool.sample = delegate_sample;
> +	tool->tool.read = delegate_read;
> +
> +	tool->tool.mmap = delegate_mmap;
> +	tool->tool.mmap2 = delegate_mmap2;
> +	tool->tool.comm = delegate_comm;
> +	tool->tool.namespaces = delegate_namespaces;
> +	tool->tool.cgroup = delegate_cgroup;
> +	tool->tool.fork = delegate_fork;
> +	tool->tool.exit = delegate_exit;
> +	tool->tool.lost = delegate_lost;
> +	tool->tool.lost_samples = delegate_lost_samples;
> +	tool->tool.aux = delegate_aux;
> +	tool->tool.itrace_start = delegate_itrace_start;
> +	tool->tool.aux_output_hw_id = delegate_aux_output_hw_id;
> +	tool->tool.context_switch = delegate_context_switch;
> +	tool->tool.throttle = delegate_throttle;
> +	tool->tool.unthrottle = delegate_unthrottle;
> +	tool->tool.ksymbol = delegate_ksymbol;
> +	tool->tool.bpf = delegate_bpf;
> +	tool->tool.text_poke = delegate_text_poke;
> +
> +	tool->tool.attr = delegate_attr;
> +	tool->tool.event_update = delegate_event_update;
> +
> +	tool->tool.tracing_data = delegate_tracing_data;
> +
> +	tool->tool.finished_round = delegate_finished_round;
> +
> +	tool->tool.build_id = delegate_build_id;
> +	tool->tool.id_index = delegate_id_index;
> +	tool->tool.auxtrace_info = delegate_auxtrace_info;
> +	tool->tool.auxtrace_error = delegate_auxtrace_error;
> +	tool->tool.time_conv = delegate_time_conv;
> +	tool->tool.thread_map = delegate_thread_map;
> +	tool->tool.cpu_map = delegate_cpu_map;
> +	tool->tool.stat_config = delegate_stat_config;
> +	tool->tool.stat = delegate_stat;
> +	tool->tool.stat_round = delegate_stat_round;
> +	tool->tool.feature = delegate_feature;
> +	tool->tool.finished_init = delegate_finished_init;
> +	tool->tool.bpf_metadata = delegate_bpf_metadata;
> +	tool->tool.compressed = delegate_compressed;
> +	tool->tool.auxtrace = delegate_auxtrace;
> +}
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 1f1461808371..88337cee1e3e 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -102,4 +102,13 @@ int process_event_sample_stub(const struct perf_tool *tool,
>  			      struct evsel *evsel,
>  			      struct machine *machine);
>  
> +struct delegate_tool {
> +	/** @tool: The actual tool that calls the delegate. */
> +	struct perf_tool tool;
> +	/** @delegate: The tool that is delegated to. */
> +	struct perf_tool *delegate;
> +};
> +
> +void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate);
> +
>  #endif /* __PERF_TOOL_H */
> -- 
> 2.51.2.1006.ga50a493c49-goog
> 
