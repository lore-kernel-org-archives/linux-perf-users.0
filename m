Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626966;
	b=JD8gzmQWyHKfGDhoCsUOETuk30fKWhwJjaUcEVJK9NEW078jydCQNI7fsmU6yaYmUCVY
	 SnSlqnPoL+WHXFYvL0mWxRg4YCojeF/WcPM8EwgCPPdnUA1wZtSocHvfFfgdnEVwOk3C2
	 UjiURdC0+6w9AUN6VCVLtub4vajpdrnTNYPxmx6oWFx70Cgrpcrv9jeQB//gUoWkcM0Gk
	 pkL33xl7E/NBB+zk23qLId7RdrsO0SsvlzK7KgFLRDGidUOGab+HuUVV+guI3qUs7QiU/
	 x2/P8dK4R3vKHriZ+wLbHLFlDFV5nwLxGayleDL91iu1CBQ03j0DGfYVqSDq5spm0Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zJCo746vCT0APaOPgFzPUiMEUXJMpw9sJQ2IynKBcN4=;
	b=U2XSzjOTuj7bMqTH02D70+iDUbXsYEqabIkNuDXVo+YebQ+tqG83EY0ezNE99ohJ+0p7
	 /GrrS5dDI04GdTS7qJN8QrdduweCvAxEuxpEgAOflwmLd0Qu/PyF+x6ITxQwBwbXP69mj
	 rHhD04sLQ/N6A0637jIoxuKNkhv4qPi8uDnmjf1EHMQcpCAdBYaAHcUcc/QYbKFD6OZ42
	 yejrpMurOfMjdWn5l7uVcZjFYf9Jnkx8MJ9/II0e4cXDuuGZyrtXKct/y6CzLq83w0ytd
	 6HKlcTaCh+JJonyYw7wWcFwlqg5jlfTXtksbi9riO2pcEu70HyW01vGQ7JImJAyniWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyWx1EMw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C20606A31B;
	Wed, 21 Oct 2026 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyWx1EMw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0ED1F000C1;
	Wed, 21 Oct 2026 23:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792626966;
	bh=zJCo746vCT0APaOPgFzPUiMEUXJMpw9sJQ2IynKBcN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PyWx1EMwWgvWa51KkecuHJ+eA6A3DjhDmGCm53nFZjbacUb4nStV/njlTuUuVvboW
	 f4YHR9i9MysqXeIEQxXG9FHjlyVKkCAkp7epA7jFqD/ixgIvMHCsEZpUlH5nDjpRmW
	 BWGDaH0e7HGlEaoCCSgk/TPwH+6S2t77fAtJx1bwLTNdAu6dSu+jHCecRKJJ56XkZJ
	 4RTGMQ3bQzEF76eunSJdBsggwz8T4RnqDW7sB/JuxTlRfcOmmckx7la92F9sVQNwJG
	 9s05rHkvCRLsWp9FkgY1FGOqHlx82llsonq2Wy7DxxImKgOlMYlQXfH8HErFNfh2YX
	 YHKVRs9Awx74A==
Date: Wed, 21 Oct 2026 16:56:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 1/6] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Message-ID: <atlRFHWsyxcO8PQJ@google.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-2-atomlin@atomlin.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261021023337.809936-2-atomlin@atomlin.com>

On Tue, Oct 20, 2026 at 10:33:32PM -0400, Aaron Tomlin wrote:
> In __cmd_ftrace(), incoming trace data from trace_pipe was historically
> buffered in a fixed 4096-byte array allocated directly on the stack
> frame. Furthermore, reads were written directly to stdout via fwrite()
> in arbitrary chunk sizes, rather than as discrete, well-delimited
> trace lines.
> 
> Refactor __cmd_ftrace() to employ dynamic heap allocation for the read
> buffer alongside a dynamic struct strbuf to accumulate streamed
> characters into whole lines. Pre-allocating the strbuf ensures that
> line processing incurs zero heap reallocations during steady-state
> polling, while the stack frame of __cmd_ftrace() is reduced by over 96%
> (down to ~160 bytes). Robust error and EOF detection on stdout and the
> trace stream ensures polling terminates cleanly upon pipeline or pager
> exit, while retrying on non-fatal EAGAIN and EINTR conditions prevents
> premature termination on non-blocking reads or signal interruptions.

I think it's better to split the error handling into its own commit
maybe with a Fixes tag.  But I'm curious if it's possible to get EAGAIN
on read() after poll().

Thanks,
Namhyung

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-ftrace.c | 79 +++++++++++++++++++++++++++++++------
>  1 file changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6017493ff179..65983259b07e 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -14,6 +14,7 @@
>  #include <poll.h>
>  #include <semaphore.h>
>  #include <signal.h>
> +#include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <linux/capability.h>
> @@ -41,7 +42,10 @@
>  #include "util/units.h"
>  #include "util/parse-sublevel-options.h"
>  
> +#include "util/strbuf.h"
> +
>  #define DEFAULT_TRACER  "function_graph"
> +#define TRACE_BUF_SIZE  4096
>  
>  static volatile sig_atomic_t workload_exec_errno;
>  static volatile sig_atomic_t done;
> @@ -738,7 +742,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  {
>  	char *trace_file;
>  	int trace_fd;
> -	char buf[4096];
> +	char *buf = NULL;
> +	struct strbuf linebuf = STRBUF_INIT;
>  	struct pollfd pollfd = {
>  		.events = POLLIN,
>  	};
> @@ -767,10 +772,18 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  
>  	setup_pager();
>  
> +	buf = malloc(TRACE_BUF_SIZE);
> +	if (!buf) {
> +		pr_err("failed to allocate trace buffer\n");
> +		goto out_reset;
> +	}
> +	strbuf_init(&linebuf, 512);
> +	strbuf_setlen(&linebuf, 0);
> +
>  	trace_file = get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
> -		goto out_reset;
> +		goto out_free;
>  	}
>  
>  	trace_fd = open(trace_file, O_RDONLY);
> @@ -779,7 +792,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  
>  	if (trace_fd < 0) {
>  		pr_err("failed to open trace_pipe\n");
> -		goto out_reset;
> +		goto out_free;
>  	}
>  
>  	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
> @@ -806,24 +819,42 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	}
>  
>  	while (!done) {
> -		if (poll(&pollfd, 1, -1) < 0)
> +		if (poll(&pollfd, 1, -1) < 0) {
> +			if (errno == EINTR)
> +				continue;
>  			break;
> +		}
>  
>  		if (pollfd.revents & POLLIN) {
> -			int n = read(trace_fd, buf, sizeof(buf));
> -			if (n < 0)
> +			int n = read(trace_fd, buf, TRACE_BUF_SIZE);
> +
> +			if (n < 0) {
> +				if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
> +					continue;
>  				break;
> -			if (fwrite(buf, n, 1, stdout) != 1)
> +			}
> +			if (n == 0)
>  				break;
> +			for (int i = 0; i < n; i++) {
> +				if (buf[i] == '\n') {
> +					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
> +						break;
> +					strbuf_setlen(&linebuf, 0);
> +				} else {
> +					if (strbuf_addch(&linebuf, buf[i]) < 0)
> +						goto out_close_fd;
> +				}
> +			}
>  			/* flush output since stdout is in full buffering mode due to pager */
> -			fflush(stdout);
> +			if (fflush(stdout) < 0 || ferror(stdout))
> +				break;
>  		}
>  	}
>  
>  	write_tracing_file("tracing_on", "0");
>  
>  	if (workload_exec_errno) {
> -		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
> +		const char *emsg = str_error_r(workload_exec_errno, buf, TRACE_BUF_SIZE);
>  		/* flush stdout first so below error msg appears at the end. */
>  		fflush(stdout);
>  		pr_err("workload failed: %s\n", emsg);
> @@ -831,16 +862,38 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	}
>  
>  	/* read remaining buffer contents */
> -	while (true) {
> -		int n = read(trace_fd, buf, sizeof(buf));
> -		if (n <= 0)
> +	while (!ferror(stdout)) {
> +		int n = read(trace_fd, buf, TRACE_BUF_SIZE);
> +
> +		if (n < 0) {
> +			if (errno == EINTR)
> +				continue;
>  			break;
> -		if (fwrite(buf, n, 1, stdout) != 1)
> +		}
> +		if (n == 0)
>  			break;
> +		for (int i = 0; i < n; i++) {
> +			if (buf[i] == '\n') {
> +				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
> +					break;
> +				strbuf_setlen(&linebuf, 0);
> +			} else {
> +				if (strbuf_addch(&linebuf, buf[i]) < 0)
> +					goto out_close_fd;
> +			}
> +		}
> +	}
> +
> +	if (!ferror(stdout) && linebuf.len > 0) {
> +		fprintf(stdout, "%s\n", linebuf.buf);
> +		strbuf_setlen(&linebuf, 0);
>  	}
>  
>  out_close_fd:
>  	close(trace_fd);
> +out_free:
> +	free(buf);
> +	strbuf_release(&linebuf);
>  out_reset:
>  	exit_tracing_instance();
>  out:
> -- 
> 2.55.0
> 
