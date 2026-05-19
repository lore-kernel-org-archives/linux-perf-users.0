Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE693D8910;
	Tue, 19 May 2026 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226285; cv=none; b=mT3AosXcDPTSNTCiiGTS6Azuly6ZVF5AqkK1Zc/JGZUEAO1kAzmg+BroxKIT8rr34LwCqZW6BbkDcekXihkfjT2Nfh6mpHWa8QLgbzA25pB8B69/5AuW3fpeCjo39QXPwcaVN2A+yLdJCP++7vWAVALY1u80zKzrp80Wc8wtP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226285; c=relaxed/simple;
	bh=WP+5aN4yFnRFE3CqqWqa1/oIbbY/SijlVVp9OxavnjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO7ARbIQadR5+fziJ4BJMUApBXqL5AfWv0RsdkpzuXjRhWrcxsBRU4ePAUSmJEBmwkMgFUFr2P00uwPjvKrr9kTH97ReVGBqNsWnU1kOmvkEw6fPSlBAdr9w9Z0E+f3kddaTdnx0wlqQWm/ff/R1k90D2NtexRIA8JrWvBTpCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjZfkbF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjZfkbF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8891F000E9;
	Tue, 19 May 2026 21:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779226284;
	bh=nJYkUrIZHHAAvKGurVcOWkMDiWi5hXMG4kCIa+vdU2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GjZfkbF937/quin6amUkYmrdSMUKAORX68LgNexqmqLrAL2cf5EHrwT1mEHA8U92v
	 DXg7r+j7+RYvMcdEaQcIWxSbEzTzU4FFI5bAUDmNtPhoYZ8iGcTRl8bzm6YG+broKS
	 tk+8EXZlzqe6n1t9/OOFTBaV8GbkA21kZwJVmNy8GCeZjeS4GvvbbxUzWH2gVfXjzx
	 FjwJBXlZWMfkPfSOLmRZNd7cRmLXN/cP8rKke+3eGEX3k9Zk3oREug7W/EdAk74zLI
	 uoiXnkHORKDo0k5dyQOpRJIswj/540qhbVxFswOeEKyxgQoEMX29vWKpPpPYpjksKs
	 RQMQoG574NNXQ==
Date: Tue, 19 May 2026 14:31:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v13 24/32] perf timechart: Fix memory leaks
Message-ID: <agzWqrn6XPEwTAsb@google.com>
References: <20260413041143.1736055-1-irogers@google.com>
 <20260512223001.2952848-1-irogers@google.com>
 <20260512223001.2952848-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512223001.2952848-25-irogers@google.com>

On Tue, May 12, 2026 at 03:29:53PM -0700, Ian Rogers wrote:
> Fix missing free from cat_backtrace, which requires copies of the
> backtrace being made in functions that save it.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-timechart.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 1d24d8738519..64f69bd67c6b 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -299,7 +299,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
>  	sample->type = type;
>  	sample->next = c->samples;
>  	sample->cpu = cpu;
> -	sample->backtrace = backtrace;
> +	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
>  	c->samples = sample;
>  
>  	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
> @@ -433,7 +433,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
>  
>  	we->time = timestamp;
>  	we->waker = waker;
> -	we->backtrace = backtrace;
> +	we->backtrace = backtrace ? strdup(backtrace) : NULL;
>  
>  	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
>  		we->waker = -1;
> @@ -489,9 +489,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
>  	}
>  }
>  
> -static const char *cat_backtrace(union perf_event *event,
> -				 struct perf_sample *sample,
> -				 struct machine *machine)
> +static char *cat_backtrace(union perf_event *event,
> +			   struct perf_sample *sample,
> +			   struct machine *machine)
>  {
>  	struct addr_location al;
>  	unsigned int i;
> @@ -544,8 +544,10 @@ static const char *cat_backtrace(union perf_event *event,
>  				 * It seems the callchain is corrupted.
>  				 * Discard all.
>  				 */
> -				zfree(&p);
> -				goto exit;
> +				addr_location__exit(&al);
> +				fclose(f);
> +				free(p);
> +				return NULL;

Nit: it looks like an unnecessary change.


>  			}
>  			continue;
>  		}
> @@ -577,6 +579,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  {
>  	struct timechart *tchart = container_of(tool, struct timechart, tool);
>  	struct evsel *evsel = sample->evsel;
> +	int ret = 0;
>  
>  	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
>  		if (!tchart->first_time || tchart->first_time > sample->time)
> @@ -587,11 +590,13 @@ static int process_sample_event(const struct perf_tool *tool,
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> +		char *backtrace = cat_backtrace(event, sample, machine);
>  
> -		return f(tchart, sample, cat_backtrace(event, sample, machine));
> +		ret = f(tchart, sample, backtrace);
> +		free(backtrace);

It's suboptimial that it generates backtrace always and copy it again.
But it can be fixed separately.

Thanks,
Namhyung

>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
