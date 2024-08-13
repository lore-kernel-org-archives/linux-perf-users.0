Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8519EEC0;
	Tue, 13 Aug 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559316; cv=none; b=sdyg5q9irzxOEAu5kZ2n9r/h3AkEh8P9pCE/aiZCao7ZgLUJgFbx33WO1xCtt2qSHDiadxHjlr3LglKoZhs/cIDipOKd2nACAC8YckD5Gwk2vn/prKTmCSCfP/nTtGsodJNtC1jZwGcSQHji38fw8Ro7yxNV/zMBLgCieKUFxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559316; c=relaxed/simple;
	bh=MXNZ/zeDWQXz9ILdX6QMiT8hkUjUFvD51FnJbgAZ3o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Q7iCP1sywoFyC0O273I9DkJQvzmZUEnqOK4+wdTgLPoRUTBY3pfBqdPAgDwjKACUnhD30MD1snF77afgbl9yDyykIBBiFjNU8umbI6NNgW72A9G7dLqWACui0Ou3bCc3GvuqSsd6sR7am6nH8r+XeBO/z8w5bZrzhzSbfHok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms+JB4ZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms+JB4ZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F94C4AF09;
	Tue, 13 Aug 2024 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559316;
	bh=MXNZ/zeDWQXz9ILdX6QMiT8hkUjUFvD51FnJbgAZ3o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ms+JB4ZPldx9SMqL/CSuafJ0nAGICY6NuBj/s1vhr6Mh+Nu3MjOfLRx20h0sVTgvf
	 9vNDspD6cB5nch2/hQJTvVkldq3CyypACAxrf06+kA8awQLmYxq/xDNTPL2UfSLRoE
	 6E5eMKbUYX5F1Mw80U4c/q8ESQj2e9O5esYEANPqhQlikuBOY1zMAjvMlhkwHgvxkc
	 NTrMn1nXDTuljOmGjf/TWwyuTpLVwmMBaJoy8KWANW6cxN+4xsYRGg78Q9K8UH6Vm0
	 8yrZaL3iT7UXvbWh3d+IYxq7Lx8m+vDN0wFwg56AooCo5sbMe5YB/c18AF8gk3OpKA
	 QF6QTaMapseSw==
Date: Tue, 13 Aug 2024 11:28:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf inject: Inject build ids for entire call chain
Message-ID: <ZrttkJHX5DAmHGvP@x1>
References: <20240812224119.744968-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812224119.744968-1-irogers@google.com>

On Mon, Aug 12, 2024 at 03:41:19PM -0700, Ian Rogers wrote:
> The DSO build id is injected when the dso is first encountered but the
> checking for first encountered only looks at the sample->ip not the
> entire callchain. Use the callchain logic to ensure all build ids are
> inserted.

Split into two patches, one with the paragraph below and the other, a
followup to that, with the fix and the paragraph above.

Applied to perf-tools-next,

Thanks,

- Arnaldo
 
> Add a for_each callback style API to callchain with
> sample__for_each_callchain_node. Possibly in the future such an API
> can avoid the overhead of constructing the call chain list.
> 
> Fixes: 454c407ec17a ("perf: add perf-inject builtin")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2. Rebase and add Namhyung's acked-by.
> ---
>  tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.c | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.h |  6 ++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index ef9cba173dd2..a35bde3f3c09 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -743,6 +743,29 @@ static int dso__inject_build_id(struct dso *dso, const struct perf_tool *tool,
>  	return 0;
>  }
>  
> +struct mark_dso_hit_args {
> +	const struct perf_tool *tool;
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
>  int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
>  			       struct perf_sample *sample,
>  			       struct evsel *evsel __maybe_unused,
> @@ -750,6 +773,11 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
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
> @@ -769,6 +797,9 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
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
> 2.46.0.76.ge559c4bf1a-goog
> 
