Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430755;
	b=efixXLP7+yzCJsIprZ7BFFwr4GBwDTqbD1r4SiItTsZ3Mb7+rqTM6G+vKHwjHXuU96/Z
	 R+hNlm/XLaxFj6co7jkbQgJZ6/oxOqfwJZAkPhq1sp9UmnHu6VXzHTayyLm4gz7IyYIWk
	 z8bStvS4Trr+n3/yyNpi+MeGhvbb9GAGhA/C7Qgyl3A9RkZr2PTJ83lKXk3B2vND7yhg+
	 aOdVq6DRWf64vzSPJQYY3FXn9twqQ7ClaniU04pLhgvi0R79Ym/qQQqlk1SSlPvkFCbmS
	 nY2MpioYJGKzqT8R6vvF9z6sCHB82H9bAKM3Ipse6eDWMawIMc5dwZk5/PlrcSgLuJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430755;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mdeGvQS0yFU+asyxeTn883CRMkX9rxUkNbr2QkmveTo=;
	b=po7f1RE2M+lLlD0wvM/sLDc2PO7KIuactHpU/aZiWsOpgJjrhAm9uIpS9fRi3sX01fIA
	 YPThCVyb9L1xPvIU1/040z4s2OoSyopDJRb5mGbVNu07e9BY8iOC8TMlXQehc9Fu8plsp
	 /4AcdE50HAeoCye3eEh0+WR5igAoNehSQonXus3X9KjWJ1Wa8a/cm4zA70kiUm0T428P4
	 uG2EK/O/fvUipJlm5OVOvWGMAr0FqGvGV2H5wq3kmEHb6OBMA0S0bAFCMQnYgbKhsuZw4
	 Us+kiDl7cfGx8vL7aw+xZvIbG37sZkAxghOW2VvIcXwJ0H2Azc4iSZBExQlAAd6O7gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKIFkL5N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4956606A31A;
	Sat, 31 Oct 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKIFkL5N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCB61F000C1;
	Sat, 31 Oct 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793430754;
	bh=mdeGvQS0yFU+asyxeTn883CRMkX9rxUkNbr2QkmveTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mKIFkL5NML8LqkjgaT5a+l+A1H902JGVUTF+2RRd58IFbGPLf9aSJpy4v0E9Z3Qg9
	 39dxV5AQEoO8VoL6BIeILzFa+/pqpCFt2NViV+faJ2oX1gFF0+PWBZiJ41S2+fPXsg
	 JqSqY05yDQWh0ygZ2GVC0jirPRTEg1xfCXPMplyrUjBth1cf2krPFZu7KAu+fROMwj
	 kTise0DKH8MdLqXbLusAcfy/XazSdZL3Ef7tFtIhA91UJ4g8XBWPNRKSyTmsjZRhrg
	 EeXXgx6HE1beZawthHB4KH4Ck1y8DLKLV2v8aj69uSzBLFnt2/A7mILE+8jVMiVwXA
	 p8MNUXcwU3O1w==
Date: Sat, 31 Oct 2026 00:12:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Message-ID: <auWU4JndXjxKzBbm@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-2-atomlin@atomlin.com>
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
In-Reply-To: <20261026025735.546101-2-atomlin@atomlin.com>

On Sun, Oct 25, 2026 at 10:57:26PM -0400, Aaron Tomlin wrote:
> In __cmd_ftrace(), trace_fd is configured for non-blocking I/O via
> fcntl(trace_fd, F_SETFL, O_NONBLOCK) and polled using poll(). However,
> the polling loop previously treated any negative return code from poll()
> or read() as an unrecoverable failure.
> 
> If poll() or read() is interrupted by a non-fatal signal (i.e. SIGWINCH
> upon terminal resizing), errno is set to EINTR. Furthermore, read() on
> trace_pipe can return EAGAIN/EWOULDBLOCK even after poll() indicates
> POLLIN (for instance, under concurrent readers, spurious wakeups, or
> block-mode trace iterator options). In all such cases, breaking from the
> loop causes perf ftrace to terminate tracing prematurely.
> 
> Additionally, output errors on stdout (i.e. when a pager or consumer
> process exits, closing the downstream pipe) were ignored by fflush(),
> leaving __cmd_ftrace() polling indefinitely until the workload
> completes.
> 
> Resolve these concerns by retrying poll() upon receiving EINTR, retrying
> read() on EAGAIN, EWOULDBLOCK, and EINTR, and breaking on EOF (n == 0).
> Furthermore, detect stdout errors and broken pipes via fflush() and
> ferror() to exit immediately when the downstream output sink closes, and
> handle EINTR and ferror(stdout) cleanly in the subsequent buffer
> draining loop.
> 
> Fixes: d01f4e8db22c ("perf ftrace: Introduce new 'ftrace' tool")
> Cc: stable@vger.kernel.org
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-ftrace.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6017493ff179..7cdc9ae2fbbb 100644
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
> @@ -806,17 +807,27 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
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
>  			int n = read(trace_fd, buf, sizeof(buf));
> -			if (n < 0)
> +
> +			if (n < 0) {
> +				if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
> +					continue;
> +				break;
> +			}
> +			if (n == 0)
>  				break;
>  			if (fwrite(buf, n, 1, stdout) != 1)
>  				break;
>  			/* flush output since stdout is in full buffering mode due to pager */
> -			fflush(stdout);
> +			if (fflush(stdout) < 0 || ferror(stdout))
> +				break;
>  		}
>  	}
>  
> @@ -831,9 +842,15 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	}
>  
>  	/* read remaining buffer contents */
> -	while (true) {
> +	while (!ferror(stdout)) {
>  		int n = read(trace_fd, buf, sizeof(buf));
> -		if (n <= 0)
> +
> +		if (n < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			break;
> +		}
> +		if (n == 0)
>  			break;
>  		if (fwrite(buf, n, 1, stdout) != 1)
>  			break;
> -- 
> 2.55.0
> 
