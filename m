Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755C1ABEA9;
	Fri,  2 Aug 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623025; cv=none; b=GB6eUD73QTMmhPPQXJNYqvEzhXpRz9JvLy5EOZ9F24EMpq7qatXx5MP3Q9IBAyhVqVJZSIy0v7I3sWC6OdpXh57Xq/L2MWl1Gc/ypKwzHUT6RFPglQjxgTeZl/0qyojgcXxdEKHFr0Bl9SsbEDoAnL5HFMQnJ2nIT7R5Wy8+1ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623025; c=relaxed/simple;
	bh=0nh586fdYKbqYE7Xx1zKbVfE2k9oRTxAHMyDsfqXHX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp+HVRzzxiwAuGo3z8qLlLaBf8Jg5o5utBec4WRAQhXbaNibOpOkLXvMMmVukmZjS+Q3mtya86uoj31KSmV3PLh1TTrx5reiVwFGVJ35W3TKfGES/kiskYWuSmHE6hKFEkeumwtL1b7apvkQZ02/9dwHmrcFuK0aSIWC6TjL08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNDS4bDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNDS4bDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CD1C32782;
	Fri,  2 Aug 2024 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722623025;
	bh=0nh586fdYKbqYE7Xx1zKbVfE2k9oRTxAHMyDsfqXHX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNDS4bDCnwNQ9Su7UPeetcV9aqZtm8+IPybJ/LTvTbLsYvq4HCtbydVylhvLN6lXE
	 U5j3o87n+QCLXZHE8NkUeeAhz446lYGaWFhubmXMRDWChjwm9EYoYqk9PW/HKyjd3Z
	 A/WdEft1mY5lz148SYVeh1li8OFQUKGx109MFy/5RMnvOVekVQz8sMAengoRPqalR7
	 tHNDRFCQ8mqvP4pixedBQ8pczsDy/7S+16DPmD/puStXYWPSQdYH+eErdffBvQ+wOw
	 AevS+iavdWmaC9Ju0TIVuwr6+ZQTw1ba5JMWExOT8+MPOwf4ZFjbenDbDy7Z4S3KSZ
	 38YQnaXDLioaw==
Date: Fri, 2 Aug 2024 11:23:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf inject: Inject build ids for entire call chain
Message-ID: <Zq0kL-lyCqkM3P4G@google.com>
References: <20240801031249.176913-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801031249.176913-1-irogers@google.com>

Hi Ian,

On Wed, Jul 31, 2024 at 08:12:49PM -0700, Ian Rogers wrote:
> The DSO build id is injected when the dso is first encountered but the
> checking for first encountered only looks at the sample->ip not the
> entire callchain. Use the callchain logic to ensure all build ids are
> inserted.
> 
> Add a for_each callback style API to callchain with
> sample__for_each_callchain_node. Possibly in the future such an API
> can avoid the overhead of constructing the call chain list.
> 
> Fixes: 454c407ec17a ("perf: add perf-inject builtin")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.h |  6 ++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 7b4a5d56d279..ea5f1d57e7e1 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -743,6 +743,29 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
>  	return 0;
>  }
>  
> +struct mark_dso_hit_args {
> +	struct perf_tool *tool;
> +	struct machine *machine;
> +	u8 cpumode;
> +};
> +
> +static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
> +{
> +	struct mark_dso_hit_args *args = data;
> +	struct map *map = node->ms.map;
> +
> +	if (map) {
> +		struct dso *dso = map__dso(map);
> +
> +		if (dso && !dso__hit(dso)) {
> +			dso__set_hit(dso);
> +			dso__inject_build_id(dso, args->tool, args->machine,
> +					     args->cpumode, map__flags(map));
> +		}
> +	}
> +	return 0;
> +}
> +
>  int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
>  			       struct perf_sample *sample,
>  			       struct evsel *evsel __maybe_unused,
> @@ -750,6 +773,11 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
>  {
>  	struct addr_location al;
>  	struct thread *thread;
> +	struct mark_dso_hit_args args = {
> +		.tool = tool,
> +		.machine = machine,
> +		.cpumode = sample->cpumode,
> +	};
>  
>  	addr_location__init(&al);
>  	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
> @@ -769,6 +797,9 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
>  		}
>  	}
>  
> +	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
> +					mark_dso_hit_callback, &args);
> +
>  	thread__put(thread);
>  repipe:
>  	perf_event__repipe(tool, event, sample, machine);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 6d075648d2cc..0d608e875fe9 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1797,3 +1797,38 @@ s64 callchain_avg_cycles(struct callchain_node *cnode)
>  
>  	return cycles;
>  }
> +
> +int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
> +				    struct perf_sample *sample, int max_stack,
> +				    callchain_iter_fn cb, void *data)
> +{
> +	struct callchain_cursor *cursor = get_tls_callchain_cursor();
> +	int ret;
> +
> +	if (!cursor)
> +		return -ENOMEM;
> +
> +	/* Fill in the callchain. */
> +	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					max_stack);
> +	if (ret)
> +		return ret;
> +
> +	/* Switch from writing the callchain to reading it. */
> +	callchain_cursor_commit(cursor);
> +
> +	while (1) {
> +		struct callchain_cursor_node *node = callchain_cursor_current(cursor);
> +
> +		if (!node)
> +			break;
> +
> +		ret = cb(node, data);
> +		if (ret)
> +			return ret;
> +
> +		callchain_cursor_advance(cursor);
> +	}
> +	return 0;
> +}
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index d5c66345ae31..76891f8e2373 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -311,4 +311,10 @@ u64 callchain_total_hits(struct hists *hists);
>  
>  s64 callchain_avg_cycles(struct callchain_node *cnode);
>  
> +typedef int (*callchain_iter_fn)(struct callchain_cursor_node *node, void *data);
> +
> +int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
> +				    struct perf_sample *sample, int max_stack,
> +				    callchain_iter_fn cb, void *data);
> +
>  #endif	/* __PERF_CALLCHAIN_H */
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 
