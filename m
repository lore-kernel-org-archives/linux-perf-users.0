Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008321019C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628060; cv=none; b=fBUJ2g4EKH/46Fb82ItaKv0FDXvVk0MHGqYLUQn3g+vPbHDpjaOuN4qwkRwZ7h4vKbYo4VSj0Tj8Fg0WuWh0MImfdQfIdOLYHZhusG0/ixR5opEBXm6rSUL8KLUd4Xek4polazCNbMi+3WqAq+VvQN3lIe8UMztATlZsRZLLQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628060; c=relaxed/simple;
	bh=Zxw2xGLDIC+cPVn4MqSgFOEgaYgLQumhIed57+IGQ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl2b7qRTxeyeJ6tiizO/CdhMp0pZjmDYbk5ROEKKNuFpkSkOqEIkuzc4kN/THDegmJSFGPiAF59A/5q5VKO/ydbCI0kMk9d0AZ6afE+YmgImHypIeufuAmobKmWpNn2GyelMvFoGgeLblR0wjY0putLkOP8neqXwebfTz4RKEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUqTfhBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUqTfhBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62828C4CEF5;
	Thu, 11 Sep 2025 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757628060;
	bh=Zxw2xGLDIC+cPVn4MqSgFOEgaYgLQumhIed57+IGQ1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUqTfhBvp38BEBBrgquArHdvem7wbLMQDkN7Nlpzx5fy9xAyceWcOhcYT97uwQrYS
	 ulHkw0iLPGSPZYM14Efvb5zk+2OlmRFROhtwnjvqDNTtUocpHpvRDWvzx9ItY9tit1
	 2bv/UagDsmApXKJJaNzJU6SLbyS8IOGvdjHLKLQ0F/QB+SwnlR/x+Da8z3kEGx8lpu
	 X9tJDEe2vaIxYXdvBXybaQ9vbi752K5ZKzDcAztYJhjG3Xf21rbQhOEJanv2rBx1k2
	 0qKhpOvmU4h4ay87Ewc6XolV3+0K9gcRO0G/9hr9pHSJeuOBm9mFLIPC2Y71R+2iSY
	 s5x7oSONBktIw==
Date: Thu, 11 Sep 2025 15:00:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf trace: don't show comm/tid for regular syscalls for
 single-pid traces
Message-ID: <aMNGmR1pMsI6WFCa@google.com>
References: <20250821165831.184569-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821165831.184569-2-ashelat@redhat.com>

On Thu, Aug 21, 2025 at 12:58:32PM -0400, Anubhav Shelat wrote:
> Previously when attaching perf trace to a specific pid the output would
> look like this:
> 
>          ? (         ): vest/616160  ... [continued]: clock_nanosleep())                                  = 0
>      0.041 ( 0.013 ms): vest/616160 fstat(statbuf: 0xfffff2c60038)                                        = 0
>      0.073 ( 0.008 ms): vest/616160 read(buf: 0x3bede330, count: 4096)                                    = 17
>      0.090 (1000.095 ms): vest/616160 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0xfffff2c601d8) = 0
>   1000.210 ( 0.136 ms): vest/616160 openat(dfd: CWD, filename: "/tmp/something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) = 3
>   1000.361 ( 0.004 ms): vest/616160 fstat(fd: 3, statbuf: 0xfffff2c60088)                                 = 0
>   1000.375 ( 0.018 ms): vest/616160 write(fd: 3, buf: SOME TEST STRING\10, count: 17)                     = 17
>   1000.395 ( 0.072 ms): vest/616160 close(fd: 3)                                                          = 0
>   1000.476 (         ): vest/616160 exit_group()
> 
> which would cause an error in the perftool-testsuite since the comm/tid
> shouldn't be in trace lines for regular syscalls. With this change the
> output looks like this:

I'm not sure if it's the right test.  It's controlled by the
trace->multiple_threads condition which I believe should use
trace->opts.no_inherit condition instead of the attribute of the
first event.

Thanks,
Namhyung

> 
>          ? (         ): vest/612038  ... [continued]: clock_nanosleep())                                  = 0
>      0.039 ( 0.012 ms): fstat(statbuf: 0xfffff8e94cb8)                                        = 0
>      0.069 ( 0.008 ms): read(buf: 0x3b997330, count: 4096)                                    = 17
>      0.086 (1000.436 ms): clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0xfffff8e94e58) = 0
>   1000.545 ( 0.136 ms): openat(dfd: CWD, filename: "/tmp/something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) = 3
>   1000.700 ( 0.006 ms): fstat(fd: 3, statbuf: 0xfffff8e94d08)                                 = 0
>   1000.720 ( 0.024 ms): write(fd: 3, buf: SOME TEST STRING\10, count: 17)                     = 17
>   1000.750 ( 0.073 ms): close(fd: 3)                                                          = 0
>   1000.833 (         ): vest/612038 exit_group()
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index fe737b3ac6e6..4cc38ee6aad9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2955,11 +2955,17 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  	if (trace->summary_only || (ret >= 0 && trace->failure_only))
>  		goto out;
>  
> -	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
> -
>  	if (ttrace->entry_pending) {
> +		if (trace->opts.target.pid) {
> +			if (trace->show_tstamp)
> +				printed = trace__fprintf_tstamp(trace, ttrace->entry_time, trace->output);
> +			if (trace->show_duration)
> +				printed += fprintf_duration(duration, duration_calculated, trace->output);
> +		} else
> +			trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
>  		printed = fprintf(trace->output, "%s", ttrace->entry_str);
>  	} else {
> +		trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
>  		printed += fprintf(trace->output, " ... [");
>  		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
>  		printed += 9;
> -- 
> 2.50.1
> 
