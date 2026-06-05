Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132332470E;
	Fri,  5 Jun 2026 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701715; cv=none; b=tP2RDt6L4l8gqCVoWVxpM6Ck9+zz8bBeb4x2TzUF/0OfyniTT0it0EXwcuoS4SKrMQ39Nery1NQq6ikWDUpeLHFiVDD4E+mO66QhVK8P+Eu6uJOP82huI2dId/BNJVXApWWoSpWZk0j3XwXqMsDkkqHua6nCk64PkUWValxr0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701715; c=relaxed/simple;
	bh=eLmcdzM7BGYj/sumolcAo6QMjD85FV9rCVaIG8dbMcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dllfUDDUZJpPHvUZ+GOQlW6xJMGv93z6aFkQSULtp5egzCGNu3ef2kIDBdxtKgZS1cv75Q99TunjC4yljp7L65q6bLYHPidpMFfPyS/V4PB+h+H6EoFDyossXox0xVLdVToRuzopWn/QWkony/IfhVtVmkRzgOhLOF+RK32Tneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjXiArxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjXiArxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254A71F00893;
	Fri,  5 Jun 2026 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701714;
	bh=8Xh3O2kf0q7xAq8+1l9izMhTLnQMa/rxCE/oxzIRysU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EjXiArxVBWE0Zu24+KdQLuX3OKF9pnilllMQzi0SElDz9acV+W61j5cGku/Ry8YxN
	 g5tHJi9YlHcjNOg/kzZxPjhR4dhw+iVtahieSH1g5QYL+tKSKIIxnY3qOSLaj1xE87
	 E9Xl/th3wa5k0tJIvbx9PPSlghNwubBHhiEq96ZUo5fCkyj/XebDycHD2zjEBcePmi
	 gKgXgf8Rr4PTIGa16fVMPtqtbCk0tZwmtB05MGrdAosimBU4mwhTonG3uOf/wBru3L
	 w68eZXxPmEI7aFQiCLdESmbaWkZfR0/VjL49PyTjqi2ECirmiECg5qGweH08pjdgps
	 qtyThVri0UXNQ==
Date: Fri, 5 Jun 2026 20:21:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf timechart: Release event samples at the end
Message-ID: <aiNaDclowc8qm2Qs@x1>
References: <20260605231155.2415760-1-namhyung@kernel.org>
 <20260605231155.2415760-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605231155.2415760-2-namhyung@kernel.org>

On Fri, Jun 05, 2026 at 04:11:52PM -0700, Namhyung Kim wrote:
> Add timechart__release() to free all data structures added during the
> sample processing.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-timechart.c | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 04dbb944a42720b4..7c4ace51302e260c 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -1548,6 +1548,59 @@ static void write_svg_file(struct timechart *tchart, const char *filename)
>  	svg_close();
>  }
>  
> +static void timechart__release(struct timechart *tchart)
> +{
> +	struct per_pid *p = tchart->all_data;
> +	struct power_event *pwr = tchart->power_events;
> +	struct wake_event *we = tchart->wake_events;
> +
> +	while (p) {
> +		struct per_pid *next_pid = p->next;
> +		struct per_pidcomm *c = p->all;
> +
> +		while (c) {
> +			struct per_pidcomm *next_comm = c->next;
> +			struct cpu_sample *cs = c->samples;
> +			struct io_sample *ios = c->io_samples;
> +
> +			while (cs) {
> +				struct cpu_sample *next = cs->next;
> +
> +				free((char *)cs->backtrace);

				zfree()? This way if somebody has a
				pointer to cs and tries to use
				cs->backtrace after this free, it will
				segfault instead of using garbage or
				worse, setting some other unrelated
				struct to some cpu_sample field supposed
				value.

> +				free(cs);
> +				cs = next;
> +			}
> +
> +			while (ios) {
> +				struct io_sample *next = ios->next;
> +
> +				free(ios);

				io->next = NULL;

> +				ios = next;
> +			}
> +
> +			free(c->comm);

			zfree

> +			free(c);
> +			c = next_comm;
> +		}
> +		p = next_pid;
> +	}
> +
> +	while (pwr) {
> +		struct power_event *next = pwr->next;
> +
> +		free(pwr);
		pwr->next = NULL;
> +		pwr = next;
> +	}
> +
> +	while (we) {
> +		struct wake_event *next = we->next;
> +
> +		free((char *)we->backtrace);
		zfree
> +		free(we);
> +		we = next;
> +	}
> +}
> +
>  static int process_header(struct perf_file_section *section __maybe_unused,
>  			  struct perf_header *ph,
>  			  int feat,
> @@ -2079,6 +2132,7 @@ int cmd_timechart(int argc, const char **argv)
>  
>  	ret = __cmd_timechart(&tchart, output_name);
>  out:
> +	timechart__release(&tchart);
>  	zfree(&cpus_cstate_start_times);
>  	zfree(&cpus_cstate_state);
>  	zfree(&cpus_pstate_start_times);
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
