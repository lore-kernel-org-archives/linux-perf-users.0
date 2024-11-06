Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB981514CC;
	Wed,  6 Nov 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878513; cv=none; b=sS392Atr9acr0l4BvzsZuD2bbJCPgCxQcTFciGCLtUJzg3GC6APkZetPg7LrPzs52IgQNWN2MTa7sXMWSuIKs19NiQhF/fgG75E1oLhAVEEJKzz0561fj3vKmmIrc5fNcOnRgsBShLqo0kYWqUfuX7eYFvbNX4aE7Y9YEVTRt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878513; c=relaxed/simple;
	bh=PNzVjE3G8vsQQ1r/KmwaBnxHzJDfpwVNWliRRgu5B/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXT6qQQoM/PhNBzQkTMUFP43CQqo4PPGGkcEylVC6Od/287UQuPQQxKBiBb25rUQVGyALNJoToHzG/mBTHHaLdUG0+zybaB1tokNRP5hhoeygLdgWQxzhvVm+GLHU8fDSLeyhWfbbFbnmhNnLRQM6aPmPNcJoZH4u0bQ9ZRYNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg1WYRzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg1WYRzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600E8C4CECD;
	Wed,  6 Nov 2024 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730878512;
	bh=PNzVjE3G8vsQQ1r/KmwaBnxHzJDfpwVNWliRRgu5B/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fg1WYRznaH9JgzyBIc16RiDUHA8+z4EzR4fMiNtmtYhz8jjRqS/Vi0kFtOP6py9Bx
	 Nx8uEWwy3xq3N/6+YebSzBok8+QKsvCiM51XOq5vG9gvTOJ3dUyfbEwgruI/KjS60T
	 jtifNnhUF/vGnNBj6PA/wUWZ4q/oWIfh4wso1cibOQZCwq7f1RRorYMCaY+UQAUvRD
	 Yt37bW6MMS5UNW2cXOsSCBR5tqcwK7pOSoFUHIpn7G46TJfX9TT5Ldunv03fsfYBLR
	 51TVMQktfSYF95U3fFzXnXq09wDRpeCDdp8ZT/I7ptiSizNw6gyAB4lfZAbUIQ5kSK
	 1C0tfrL4F9Kzg==
Date: Tue, 5 Nov 2024 23:35:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: event: Remove deadcode
Message-ID: <ZyscLqAzo9Z7Zg02@google.com>
References: <20241103142302.230370-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241103142302.230370-1-linux@treblig.org>

Hello,

On Sun, Nov 03, 2024 at 02:23:01PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> event_format__print() last use was removed by 2017's
> commit 894f3f1732cb ("perf script: Use event_format__fprintf()")
> 
> evlist__find_tracepoint_by_id() last use was removed by 2012's
> commit e60fc847cefa ("perf evlist: Remove some unused methods")
> 
> evlist__set_tp_filter_pid() last use was removed by 2017's
> commit dd1a50377c92 ("perf trace: Introduce filter_loop_pids()")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Unfortunately it doesn't apply to the current perf-tools-next cleanly.
Can you please rebase?

Thanks,
Namhyung

> ---
>  tools/perf/util/evlist.c            | 18 ------------------
>  tools/perf/util/evlist.h            |  2 --
>  tools/perf/util/trace-event-parse.c |  6 ------
>  tools/perf/util/trace-event.h       |  3 ---
>  4 files changed, 29 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f14b7e6ff1dc..4b992a3f2985 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -362,19 +362,6 @@ __weak int arch_evlist__add_default_attrs(struct evlist *evlist,
>  	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
>  }
>  
> -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
> -{
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->core.attr.type   == PERF_TYPE_TRACEPOINT &&
> -		    (int)evsel->core.attr.config == id)
> -			return evsel;
> -	}
> -
> -	return NULL;
> -}
> -
>  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char *name)
>  {
>  	struct evsel *evsel;
> @@ -1199,11 +1186,6 @@ int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
>  	return ret;
>  }
>  
> -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
> -{
> -	return evlist__set_tp_filter_pids(evlist, 1, &pid);
> -}
> -
>  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
>  {
>  	char *filter = asprintf__tp_filter_pids(npids, pids);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index bcc1c6984bb5..ff73908e2178 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -144,7 +144,6 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
>  	__evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(array))
>  
>  int evlist__set_tp_filter(struct evlist *evlist, const char *filter);
> -int evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
>  int evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
>  
>  int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
> @@ -152,7 +151,6 @@ int evlist__append_tp_filter(struct evlist *evlist, const char *filter);
>  int evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
>  int evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
>  
> -struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
>  struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char *name);
>  
>  int evlist__add_pollfd(struct evlist *evlist, int fd);
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> index f0332bd3a501..d97830cdbd7e 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -116,12 +116,6 @@ void event_format__fprintf(struct tep_event *event,
>  	trace_seq_destroy(&s);
>  }
>  
> -void event_format__print(struct tep_event *event,
> -			 int cpu, void *data, int size)
> -{
> -	return event_format__fprintf(event, cpu, data, size, stdout);
> -}
> -
>  /*
>   * prev_state is of size long, which is 32 bits on 32 bit architectures.
>   * As it needs to have the same bits for both 32 bit and 64 bit architectures
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index bbf8b26bc8da..0e5133f1b910 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -42,9 +42,6 @@ struct tep_event *trace_event__tp_format_id(int id);
>  void event_format__fprintf(struct tep_event *event,
>  			   int cpu, void *data, int size, FILE *fp);
>  
> -void event_format__print(struct tep_event *event,
> -			 int cpu, void *data, int size);
> -
>  int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
>  int parse_event_file(struct tep_handle *pevent,
>  		     char *buf, unsigned long size, char *sys);
> -- 
> 2.47.0
> 
