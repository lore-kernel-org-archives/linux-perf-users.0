Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D91A3164;
	Sun, 12 Apr 2026 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024812; cv=none; b=osBWL+/jChXUYhTU+fPrXZieVESt9iK6URZP+70ViE+tERLEX1+5V75YbjtzDj3zLDPga6m/F2WZ2ngicI+USQP1S0gofHZGTPlNsxeEVh/axCF5KYiX554/hUOMd6vPVFZ0vytBJZceXJTsqrbdnzLPXY6YHOKHEqhWTGiUMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024812; c=relaxed/simple;
	bh=6jAk7paEK3t/BCdIiBOMyynrj6ApRGNRxtPs3ZUtznU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3peXomR+wVWtC9V9gupb4td6wZA/emVSy0prOx0QykzWgixwDneyuO1Pe4Esf1wTGhem/1RKGXPIexCwADQQV7CCW4A7kbbzRHUSGbf76lP/aZwjwnxOdD8G8mLGZ3WuJGhx/W1a40oQN3nfxEtA44MkYpcxoWWRaukv/XApfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8PFvhJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8PFvhJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007B2C19424;
	Sun, 12 Apr 2026 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776024812;
	bh=6jAk7paEK3t/BCdIiBOMyynrj6ApRGNRxtPs3ZUtznU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8PFvhJCz22nKPuHwiR2Bz7a+iIbGDccA7q5//4ETiJQd+lu1yLoPcokf3BzJ/uNJ
	 zmxg5CfCXRFElEArUaXvxIAfyLxTpQseUIztQSpW1kV9mFdTfxQSFv7k83yutkIczc
	 ujrQDMGQTX2Jg3Ss+E502tDIlZAyqfFtmsSA0NLxBIBADfR4TJtaxwPWzT7YOhbHnK
	 WrBo7feYF9S54pEr7ZHrpZb740D0IiN3/5n3kHH+w8oCQpSKsXopvbKGM9X7sHBamd
	 kX+TCocIYmQ0qJ1nnCq29SvN54jX+ukoqGvqeYlopqw3IekLjTeo+ftgeg21OoMRr7
	 MEvFnGUjAih+g==
Date: Sun, 12 Apr 2026 13:13:29 -0700
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
Subject: Re: [PATCH v10 18/29] perf timechart: Don't pass evsel with sample
Message-ID: <adv86QCTZ4oVyW5L@google.com>
References: <20260411191710.524998-1-irogers@google.com>
 <20260412020833.641177-1-irogers@google.com>
 <20260412020833.641177-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412020833.641177-19-irogers@google.com>

On Sat, Apr 11, 2026 at 07:08:21PM -0700, Ian Rogers wrote:
> The sample contains the evsel and so it is unnecessary to pass the
> evsel as well. Add missing backtrace argument to tracepoint_handler
> functions and mark them unused. Fix missing free from cat_backtrace,
> which requires copies of the backtrace being made in functions that
> save it.

I've splitted the backtrace handling part into a new commit.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-timechart.c | 81 ++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 034e0ba3f9cb..64f69bd67c6b 100644
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
>  			}
>  			continue;
>  		}
> @@ -567,7 +569,6 @@ static const char *cat_backtrace(union perf_event *event,
>  }
>  
>  typedef int (*tracepoint_handler)(struct timechart *tchart,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  const char *backtrace);
>  
> @@ -578,6 +579,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  {
>  	struct timechart *tchart = container_of(tool, struct timechart, tool);
>  	struct evsel *evsel = sample->evsel;
> +	int ret = 0;
>  
>  	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
>  		if (!tchart->first_time || tchart->first_time > sample->time)
> @@ -588,16 +590,17 @@ static int process_sample_event(const struct perf_tool *tool,
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> -		return f(tchart, evsel, sample,
> -			 cat_backtrace(event, sample, machine));
> +		char *backtrace = cat_backtrace(event, sample, machine);
> +
> +		ret = f(tchart, sample, backtrace);
> +		free(backtrace);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int
>  process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
> -			struct evsel *evsel __maybe_unused,
>  			struct perf_sample *sample,
>  			const char *backtrace __maybe_unused)
>  {
> @@ -613,7 +616,6 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
>  
>  static int
>  process_sample_cpu_frequency(struct timechart *tchart,
> -			     struct evsel *evsel __maybe_unused,
>  			     struct perf_sample *sample,
>  			     const char *backtrace __maybe_unused)
>  {
> @@ -626,7 +628,6 @@ process_sample_cpu_frequency(struct timechart *tchart,
>  
>  static int
>  process_sample_sched_wakeup(struct timechart *tchart,
> -			    struct evsel *evsel __maybe_unused,
>  			    struct perf_sample *sample,
>  			    const char *backtrace)
>  {
> @@ -640,7 +641,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
>  
>  static int
>  process_sample_sched_switch(struct timechart *tchart,
> -			    struct evsel *evsel __maybe_unused,
>  			    struct perf_sample *sample,
>  			    const char *backtrace)
>  {
> @@ -656,7 +656,6 @@ process_sample_sched_switch(struct timechart *tchart,
>  #ifdef SUPPORT_OLD_POWER_EVENTS
>  static int
>  process_sample_power_start(struct timechart *tchart __maybe_unused,
> -			   struct evsel *evsel __maybe_unused,
>  			   struct perf_sample *sample,
>  			   const char *backtrace __maybe_unused)
>  {
> @@ -669,7 +668,6 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
>  
>  static int
>  process_sample_power_end(struct timechart *tchart,
> -			 struct evsel *evsel __maybe_unused,
>  			 struct perf_sample *sample,
>  			 const char *backtrace __maybe_unused)
>  {
> @@ -679,7 +677,6 @@ process_sample_power_end(struct timechart *tchart,
>  
>  static int
>  process_sample_power_frequency(struct timechart *tchart,
> -			       struct evsel *evsel __maybe_unused,
>  			       struct perf_sample *sample,
>  			       const char *backtrace __maybe_unused)
>  {
> @@ -849,8 +846,8 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
>  
>  static int
>  process_enter_read(struct timechart *tchart,
> -		   struct evsel *evsel __maybe_unused,
> -		   struct perf_sample *sample)
> +		   struct perf_sample *sample,
> +		   const char *backtrace __maybe_unused)
>  {
>  	long fd = perf_sample__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
> @@ -859,8 +856,8 @@ process_enter_read(struct timechart *tchart,
>  
>  static int
>  process_exit_read(struct timechart *tchart,
> -		  struct evsel *evsel __maybe_unused,
> -		  struct perf_sample *sample)
> +		  struct perf_sample *sample,
> +		  const char *backtrace __maybe_unused)
>  {
>  	long ret = perf_sample__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
> @@ -869,8 +866,8 @@ process_exit_read(struct timechart *tchart,
>  
>  static int
>  process_enter_write(struct timechart *tchart,
> -		    struct evsel *evsel __maybe_unused,
> -		    struct perf_sample *sample)
> +		    struct perf_sample *sample,
> +		    const char *backtrace __maybe_unused)
>  {
>  	long fd = perf_sample__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
> @@ -879,8 +876,8 @@ process_enter_write(struct timechart *tchart,
>  
>  static int
>  process_exit_write(struct timechart *tchart,
> -		   struct evsel *evsel __maybe_unused,
> -		   struct perf_sample *sample)
> +		   struct perf_sample *sample,
> +		   const char *backtrace __maybe_unused)
>  {
>  	long ret = perf_sample__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
> @@ -889,8 +886,8 @@ process_exit_write(struct timechart *tchart,
>  
>  static int
>  process_enter_sync(struct timechart *tchart,
> -		   struct evsel *evsel __maybe_unused,
> -		   struct perf_sample *sample)
> +		   struct perf_sample *sample,
> +		   const char *backtrace __maybe_unused)
>  {
>  	long fd = perf_sample__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
> @@ -899,8 +896,8 @@ process_enter_sync(struct timechart *tchart,
>  
>  static int
>  process_exit_sync(struct timechart *tchart,
> -		  struct evsel *evsel __maybe_unused,
> -		  struct perf_sample *sample)
> +		  struct perf_sample *sample,
> +		  const char *backtrace __maybe_unused)
>  {
>  	long ret = perf_sample__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
> @@ -909,8 +906,8 @@ process_exit_sync(struct timechart *tchart,
>  
>  static int
>  process_enter_tx(struct timechart *tchart,
> -		 struct evsel *evsel __maybe_unused,
> -		 struct perf_sample *sample)
> +		 struct perf_sample *sample,
> +		 const char *backtrace __maybe_unused)
>  {
>  	long fd = perf_sample__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
> @@ -919,8 +916,8 @@ process_enter_tx(struct timechart *tchart,
>  
>  static int
>  process_exit_tx(struct timechart *tchart,
> -		struct evsel *evsel __maybe_unused,
> -		struct perf_sample *sample)
> +		struct perf_sample *sample,
> +		const char *backtrace __maybe_unused)
>  {
>  	long ret = perf_sample__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
> @@ -929,8 +926,8 @@ process_exit_tx(struct timechart *tchart,
>  
>  static int
>  process_enter_rx(struct timechart *tchart,
> -		 struct evsel *evsel __maybe_unused,
> -		 struct perf_sample *sample)
> +		 struct perf_sample *sample,
> +		 const char *backtrace __maybe_unused)
>  {
>  	long fd = perf_sample__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
> @@ -939,8 +936,8 @@ process_enter_rx(struct timechart *tchart,
>  
>  static int
>  process_exit_rx(struct timechart *tchart,
> -		struct evsel *evsel __maybe_unused,
> -		struct perf_sample *sample)
> +		struct perf_sample *sample,
> +		const char *backtrace __maybe_unused)
>  {
>  	long ret = perf_sample__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
> @@ -949,8 +946,8 @@ process_exit_rx(struct timechart *tchart,
>  
>  static int
>  process_enter_poll(struct timechart *tchart,
> -		   struct evsel *evsel __maybe_unused,
> -		   struct perf_sample *sample)
> +		   struct perf_sample *sample,
> +		   const char *backtrace __maybe_unused)
>  {
>  	long fd = perf_sample__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
> @@ -959,8 +956,8 @@ process_enter_poll(struct timechart *tchart,
>  
>  static int
>  process_exit_poll(struct timechart *tchart,
> -		  struct evsel *evsel __maybe_unused,
> -		  struct perf_sample *sample)
> +		  struct perf_sample *sample,
> +		  const char *backtrace __maybe_unused)
>  {
>  	long ret = perf_sample__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
