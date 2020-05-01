From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 5/8] perf evlist: Allow reusing the side band thread for
 more purposes
Date: Fri, 1 May 2020 13:25:52 +0200
Message-ID: <20200501112552.GC1789042@krava>
References: <20200429131106.27974-1-acme@kernel.org>
 <20200429131106.27974-6-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200429131106.27974-6-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 29, 2020 at 10:11:03AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> I.e. so far we had just one event in that side band thread, a dummy one
> with attr.bpf_event set, so that 'perf record' can go ahead and ask the
> kernel for further information about BPF programs being loaded.
> 
> Allow for more than one event to be there, so that we can use it as
> well for the upcoming --switch-output-event feature.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Link: http://lore.kernel.org/lkml/20200427211935.25789-7-acme@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/evlist.c | 22 ++++++++++++++++++++++
>  tools/perf/util/evlist.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1d0d36da223b..849058766757 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void *arg)
>  	return NULL;
>  }
>  
> +void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		evsel->core.attr.sample_id_all	  = 1;
> +		evsel->core.attr.watermark	  = 1;
> +		evsel->core.attr.wakeup_watermark = 1;
> +		evsel->side_band.cb   = cb;
> +		evsel->side_band.data = data;
> +	}
> +}
> +
>  int perf_evlist__start_sb_thread(struct evlist *evlist,
>  				 struct target *target)
>  {
> @@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
>  	if (perf_evlist__create_maps(evlist, target))
>  		goto out_delete_evlist;
>  
> +	if (evlist->core.nr_entries > 1) {
> +		bool can_sample_identifier = perf_can_sample_identifier();

I just found this breaks python, because perf_can_sample_identifier
is defined in util/record.c

	19: 'import perf' in python                               :
	--- start ---
	test child forked, pid 1808205
	Traceback (most recent call last):
	  File "<stdin>", line 1, in <module>
	ImportError: python/perf.so: undefined symbol: perf_can_sample_identifier
	test child finished with -1
	---- end ----
	'import perf' in python: FAILED!

jirka
