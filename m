From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf tools: Add machine pointer to struct hists
Date: Tue, 28 Jan 2020 11:02:54 +0100
Message-ID: <20200128100254.GD1209308@krava>
References: <20200127143443.89060-1-namhyung@kernel.org>
 <20200128004213.106098-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200128004213.106098-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 28, 2020 at 09:42:13AM +0900, Namhyung Kim wrote:

SNIP

> +struct perf_session;
>  
>  static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
>  {
> @@ -145,32 +146,43 @@ void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>  				struct perf_counts_values *count);
>  
>  int perf_evsel__object_config(size_t object_size,
> -			      int (*init)(struct evsel *evsel),
> -			      void (*fini)(struct evsel *evsel));
> +			      int (*init)(struct evsel *evsel,
> +					  struct perf_session *session),
> +			      void (*fini)(struct evsel *evsel,
> +					   struct perf_session *session));
>  
> -struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
> +struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx,
> +				  struct perf_session *session);
>  
>  static inline struct evsel *evsel__new(struct perf_event_attr *attr)
>  {
> -	return perf_evsel__new_idx(attr, 0);
> +	return perf_evsel__new_idx(attr, 0, NULL);
>  }
>  
> -struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx);
> +static inline struct evsel *evsel__new2(struct perf_event_attr *attr,
> +					struct perf_session *session)
> +{
> +	return perf_evsel__new_idx(attr, 0, session);
> +}

I'm not sure about perf_session as an argument to get machine,
it seems ok but not for the case in perf_event__process_attr
where you call evsel__new and have no way to get perf_sesion
I think... and I think you need to set it up in there for
the pipe workflow to work with your new sort fields

maybe we could be find with just perf_env pointer there?
but perf_session makes more sense to me.. maybe we could
change event_attr_op to pass it as an argument..

jirka
