Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589A37C911;
	Fri, 31 Jul 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535166; cv=none; b=XS8Z4alt2VxAhLQgk4HGrppDPU/QWdDWmdB2Q702NQshpn3iFuI5QYXZsoJLIksAMxFmgTghMDSDSrpqWMc/2KQcwsmQwLb3lrmrLf/XvNBWTu0A2b4DBsJN7UnuKustL6jmDBA4gNnGExZGgBYGZ2kuYHm4sbfFrL/DF4XIC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535166; c=relaxed/simple;
	bh=cwlvZpOTayRtDymN+p4gHUKEq+3aSbiKk/6abhwTa4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XneWv23Za4lbNEMPetmiiLqGJbpSustzQtB57xqBoC51POKvTYglq9nNEfm2lJwNQYPLTDe2Yj4vWt+9uwCJ6luB6WihAFcXlTxD4JLmms4AtoLvFNgrlQ4fd6Fwzaw1HkP+H3w4UeHFNJpbw3IOdicVzT7+T9GAP/adDiv4n5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgJvntiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgJvntiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C3A1F00ACF;
	Fri, 31 Jul 2026 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785535165;
	bh=yeiGENvvXb89nexaVFuCWa4iDhr2hp2Ajd+JGZL7FCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BgJvntiDp07VLabnewq3kA7cZSqZT2mu7QZ8w7gJdAfGDOIxsCRjTWKhaDHz9FgAV
	 gpj5Dqt70yzrGZ0HgxV4jYf32Gzj1WGJQCPzB3h2c+9cNPC2kEYsRgFtowDxphSX9g
	 /RkzGnwKnD7c72BiRMo/XYkr1ufXJFEdkwDkIjOkg7P7lqDXDANNu05KGiOC5THifu
	 VMCJ4NvsYDqoRqJaQejgRRMs7mg+jNiTu3C1aiz/xDSSjcUlYJGgou6Nql9LFUnrEs
	 1kLEzNY0ykbKrbyWoSqhRag51ZBhriz050tImpAFqzCLktNGKv0h171HyfRgWm1jO3
	 seXQbx038eiYg==
Date: Fri, 31 Jul 2026 14:59:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Message-ID: <am0auzlYObfEmwCe@google.com>
References: <20260730185416.97166-1-atomlin@atomlin.com>
 <20260730185416.97166-2-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730185416.97166-2-atomlin@atomlin.com>

Hello,

On Thu, Jul 30, 2026 at 02:54:14PM -0400, Aaron Tomlin wrote:
> When 'perf sched latency' is executed on a perf.data file that lacks
> tracepoint samples (i.e., a file recorded without the -R flag or
> containing only non-tracepoint events), perf_session__has_traces()
> correctly outputs an error message. However, perf_sched__read_events()
> subsequently falls through and returns 0 (success).
> 
> Consequently, caller functions such as perf_sched__lat() assume event
> processing succeeded and proceed to render empty latency header tables
> and total summary statistics.
> 
> Fix this behaviour by ensuring perf_sched__read_events() aborts early and
> returns a suitable error code when perf_session__has_traces() evaluates
> to false.
> 
> For pipe mode streams, event attributes are received dynamically during
> event processing, meaning session->evlist is not populated prior to
> perf_session__process_events(). To handle pipe input correctly:
>   - Register the missing .attr, .tracing_data, .build_id, and .feature
>     callbacks in cmd_sched()
> 
>   - Promote the handlers array to file-scope (latency_handlers[]) and
>     invoke evlist__set_tracepoints_handlers() dynamically inside
>     perf_sched__process_tracepoint_sample() when evsel->handler is NULL
> 
>   - Perform the trace check post-processing when handling pipe data

Can you please split the pipe mode changes into a separate commit?

> 
> Additionally, validate thread__get_runtime() against NULL in
> map_switch_event() to prevent potential null-pointer dereferences.

This is small enough to be squashed.

Thanks,
Namhyung
