From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Date: Wed, 3 Apr 2019 11:53:53 -0300
Message-ID: <20190403145353.GE32553@kernel.org>
References: <20190403143738.GB32001@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403143738.GB32001@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
> hi,
> perf script --call-trace stop working for me recently,
> and displays only user space functions
> 
> I bisected that to:
>   7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
> 
> data from following comands will display user space functions only:
>   # perf-with-kcore record pt -e intel_pt// -- ls
>   # perf-with-kcore script pt --call-trace
> 
> when I disable the bpf synthesizing (patch below), kernel functions are back
> 
> I guess the new events mess up with intel_pt decoder somehow

And also that synthesizing should't take place when we use 

  perf record --no-bpf-event

I.e. I'm adding the patch below to my perf/urgent branch.

The --no-bpf-event option was put in place exactly for that for
explicitely disabling it if one thinks it is messing with something,
like seems to be the case here.

- Arnaldo

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4e2d953d4bc5..17d772f192ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
-						machine, opts);
-	if (err < 0)
-		pr_warning("Couldn't synthesize bpf events.\n");
+	if (!opts->no_bpf_event) {
+		err = perf_event__synthesize_bpf_events(session, process_synthesized_event, machine, opts);
+		if (err < 0)
+			pr_warning("Couldn't synthesize bpf events.\n");
+	}
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,

 
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4e2d953d4bc5..3daa78bc6549 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec, bool tail)
>  		return err;
>  	}
>  
> +#if 0
>  	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
>  						machine, opts);
>  	if (err < 0)
>  		pr_warning("Couldn't synthesize bpf events.\n");
> +#endif
>  
>  	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
>  					    process_synthesized_event, opts->sample_address,

-- 

- Arnaldo
