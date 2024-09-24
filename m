Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7581AC458;
	Tue, 24 Sep 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206152; cv=none; b=VZ5L6wfzEFqhGtDOvzQ3gdONtcbKqwUa+XRWqBzGsBntMH4PhgYa6INUORiQGsbkXldf7cV8z4Shlbw+kgeEK/xoycViYa85Hvkn/fGJR3aovLWWttl0ZliYAJZUR5xeczfE+8p+iLwWLcejvDIelhjxrP5mTWrzQM2cFv+3XjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206152; c=relaxed/simple;
	bh=/1y5DAKEaa73LT3bRfv9WDo15j9LQIYDIMNv4BdG5lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gucqNxMuxw77GAaQfcOoBmJdeZkmNum19XpGz4yqbTdfC4DOqCfhweO81gm5WTHjT0DE2Jiv5JWc0WuRWwqyyemOBf5HJ8TFSFqT/XRpgEbVf78GGIq/o9yj2F7EGPVWSOlVwssGCvyqWoeeG9TCec1hEl8tAPeU0VAwJ1IkVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Gmi2tA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Gmi2tA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A947C4CED0;
	Tue, 24 Sep 2024 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727206152;
	bh=/1y5DAKEaa73LT3bRfv9WDo15j9LQIYDIMNv4BdG5lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5Gmi2tAphnpBnUa07dzx3wsjhqWvkSfXuKS017Tx8h/S4N6UOCQeFSkwXydEKm6h
	 Y0c7q3wnc9Ilo0k1lsfMiKeUepLj0usrOgtSoZzc/C6oaMnwJpadsVE38dnSvAgWta
	 kr1GKfDr8Bp1CJejVHplyzYLFbLmZJDV3JNc1D7AaK835BSZekEeiLz79BdTnEdWT6
	 T1qewE2ChaaC1oQIl1dx7yolhXTDQznD9nctc7RNmWu6ZaEra5/aV5GDv9QlT2F2dd
	 8hasK7FowJgE80Dwsx4BAXoFaj0FzqaCgF/U2ylzrGjfbEP0OgJZB05WMNzcC096M5
	 tOoHTIlqGb1Vw==
Date: Tue, 24 Sep 2024 12:29:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Levi Yun <yeoreum.yun@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, james.clark@linaro.org,
	asmadeus@codewreck.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v4 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
Message-ID: <ZvMTBryjl5xTYr8W@google.com>
References: <20240913135907.648734-1-yeoreum.yun@arm.com>
 <20240913135907.648734-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913135907.648734-2-yeoreum.yun@arm.com>

Hello,

On Fri, Sep 13, 2024 at 02:59:06PM +0100, Levi Yun wrote:
> When create_perf_stat_counter() failed, it doesn't close workload.cork_fd
> open in evlist__prepare_workload(). This could make too many open file
> error while __run_perf_stat() repeats.
> 
> Introduce evlist__cancel_workload to close workload.cork_fd and
> wait workload.child_pid until exit to clear child process
> when create_perf_stat_counter() is failed with COUNTER_FATAL.
> 
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-stat.c |  4 ++++
>  tools/perf/util/evlist.c  | 14 +++++++++++++-
>  tools/perf/util/evlist.h  |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 661832756a24..954eb37ce7b8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -763,6 +763,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  			switch (stat_handle_error(counter)) {
>  			case COUNTER_FATAL:
> +				if (forks)
> +					evlist__cancel_workload(evsel_list);
>  				return -1;
>  			case COUNTER_RETRY:
>  				goto try_again;
> @@ -804,6 +806,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  				switch (stat_handle_error(counter)) {
>  				case COUNTER_FATAL:
> +					if (forks)
> +						evlist__cancel_workload(evsel_list);
>  					return -1;

I don't think you covered all the places it can return before starting
the workload.  You'd better have an error handling code at the end with
a label and then goto there.

Thanks,
Namhyung


>  				case COUNTER_RETRY:
>  					goto try_again_reset;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 3a719edafc7a..51a221679c92 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -46,6 +46,7 @@
>  #include <sys/mman.h>
>  #include <sys/prctl.h>
>  #include <sys/timerfd.h>
> +#include <sys/wait.h>
>  
>  #include <linux/bitops.h>
>  #include <linux/hash.h>
> @@ -1465,7 +1466,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
>  		 * For cancelling the workload without actually running it,
>  		 * the parent will just close workload.cork_fd, without writing
>  		 * anything, i.e. read will return zero and we just exit()
> -		 * here.
> +		 * here (See evlist__cancel_workload()).
>  		 */
>  		if (ret != 1) {
>  			if (ret == -1)
> @@ -1546,6 +1547,17 @@ int evlist__start_workload(struct evlist *evlist)
>  	return 0;
>  }
>  
> +void evlist__cancel_workload(struct evlist *evlist)
> +{
> +	int status;
> +
> +	if (evlist->workload.cork_fd > 0) {
> +		close(evlist->workload.cork_fd);
> +		evlist->workload.cork_fd = -1;
> +		waitpid(evlist->workload.pid, &status, WNOHANG);
> +	}
> +}
> +
>  int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
>  {
>  	struct evsel *evsel = evlist__event2evsel(evlist, event);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index cb91dc9117a2..12f929ffdf92 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -184,6 +184,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target,
>  			     const char *argv[], bool pipe_output,
>  			     void (*exec_error)(int signo, siginfo_t *info, void *ucontext));
>  int evlist__start_workload(struct evlist *evlist);
> +void evlist__cancel_workload(struct evlist *evlist);
>  
>  struct option;
>  
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
