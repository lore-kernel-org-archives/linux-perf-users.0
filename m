Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA53976B4;
	Thu, 26 Mar 2026 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567202; cv=none; b=PFBmC/vGy4jC6LZX4syHZsBeRIFFGW5uvFPynvxfSMH7X4AOOrER7SQr6Qf8dfWACuH3LAR5SWuYa6J59/rUUk6dki639pDqIQtFcbXFyQrPyTveHLI8V0wtjoJlliZw0HkTiHgTSMqUQrC1X4X2VKm3XfPVIx0iM8djbnwfowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567202; c=relaxed/simple;
	bh=OdJ0mr0Q+J7aSOK3e6/OuzVJWsvS37DwMEZMXFcbh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msi5WiFfSuH/N3JxaJFLiYM8Lmeyv4fdelkyoLCTLDmOdjlWuuCBjnDNohmr7X/GR5Ey5iDDWILENqzSxFxCqxfL8TzHPXUU8KXCn5KVCZ5Am254nRbZFeR5OltAUnAifmP4Y1IptyBnT+9sU0x4NNlrQygOYn1ERnNspPMcqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCtvqdjQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCtvqdjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F335CC116C6;
	Thu, 26 Mar 2026 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774567202;
	bh=OdJ0mr0Q+J7aSOK3e6/OuzVJWsvS37DwMEZMXFcbh8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCtvqdjQnV5E1glsxqFmXD6dVWJbeakO8dMEvNXUxSEOD7yef1jEAOOQJqXeZyZ6a
	 nSuW4o1LHXaJx3jptN8PvFJ/uavOzh4T9IL/3TKUGE7uRQr04goBK04raDiPWNWP+B
	 j7kViuB8UIo2n8RJ//qBQCUN8i7CJKG/gpKe4iIfUqtdvX/+XYZb0P400myf/LNixP
	 Uozl3yv36ex8DEBNgUVPB2VdxWuYC9PotOmOT+/NTGRZlRNIno94rDjpnXlKjoiPIY
	 edK1AAwst2wBzw87RD8eb8Wx/iD4xGaNqUiWSt9pDC76fO0HWIN3MEszFCp+jSEMj6
	 y1COiMwpej4uQ==
Date: Thu, 26 Mar 2026 16:20:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
Message-ID: <acW_IHQVZnxIETdd@google.com>
References: <20260321061448.810525-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321061448.810525-1-irogers@google.com>

On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> Doing a `perf sched record` then `perf sched stats report` crashes as
> the tp_handler isn't set. Add extra checks that tp_handler is set
> before accessing through it.

Oh.. unintended use case. :)  Probably better to add a dummy handler
for `perf sched stats report`.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-sched.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index d083e2bb7703..196f263ff667 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1525,7 +1525,7 @@ static int process_sched_wakeup_event(const struct perf_tool *tool,
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  
> -	if (sched->tp_handler->wakeup_event)
> +	if (sched->tp_handler && sched->tp_handler->wakeup_event)
>  		return sched->tp_handler->wakeup_event(sched, evsel, sample, machine);
>  
>  	return 0;
> @@ -1809,7 +1809,7 @@ static int process_sched_switch_event(const struct perf_tool *tool,
>  			sched->nr_context_switch_bugs++;
>  	}
>  
> -	if (sched->tp_handler->switch_event)
> +	if (sched->tp_handler && sched->tp_handler->switch_event)
>  		err = sched->tp_handler->switch_event(sched, evsel, sample, machine);
>  
>  	sched->curr_pid[this_cpu] = next_pid;
> @@ -1823,7 +1823,7 @@ static int process_sched_runtime_event(const struct perf_tool *tool,
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  
> -	if (sched->tp_handler->runtime_event)
> +	if (sched->tp_handler && sched->tp_handler->runtime_event)
>  		return sched->tp_handler->runtime_event(sched, evsel, sample, machine);
>  
>  	return 0;
> @@ -1840,7 +1840,7 @@ static int perf_sched__process_fork_event(const struct perf_tool *tool,
>  	perf_event__process_fork(tool, event, sample, machine);
>  
>  	/* and then run additional processing needed for this command */
> -	if (sched->tp_handler->fork_event)
> +	if (sched->tp_handler && sched->tp_handler->fork_event)
>  		return sched->tp_handler->fork_event(sched, event, machine);
>  
>  	return 0;
> @@ -1853,7 +1853,7 @@ static int process_sched_migrate_task_event(const struct perf_tool *tool,
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  
> -	if (sched->tp_handler->migrate_task_event)
> +	if (sched->tp_handler && sched->tp_handler->migrate_task_event)
>  		return sched->tp_handler->migrate_task_event(sched, evsel, sample, machine);
>  
>  	return 0;
> -- 
> 2.53.0.959.g497ff81fa9-goog
> 
