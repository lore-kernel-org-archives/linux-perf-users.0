From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Date: Wed, 3 Apr 2019 12:15:48 -0300
Message-ID: <20190403151548.GF32553@kernel.org>
References: <20190403143738.GB32001@krava>
 <20190403145353.GE32553@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403145353.GE32553@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
> > hi,
> > perf script --call-trace stop working for me recently,
> > and displays only user space functions
> > 
> > I bisected that to:
> >   7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
> > 
> > data from following comands will display user space functions only:
> >   # perf-with-kcore record pt -e intel_pt// -- ls
> >   # perf-with-kcore script pt --call-trace
> > 
> > when I disable the bpf synthesizing (patch below), kernel functions are back
> > 
> > I guess the new events mess up with intel_pt decoder somehow
> 
> I.e. I'm adding the patch below to my perf/urgent branch.

Song, that is what I have, can I have your Acked-by and please consider
taking a look at the bug Jiri reported,

Thanks,

- Arnaldo

commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Apr 3 12:05:15 2019 -0300

    perf record: Do not synthesize BPF records when --no-bpf-event is used
    
    By default we synthesize and ask the kernel for BPF events, having a
    --no-bpf-event option to disable that, which can be useful, for
    instance, if there are still bugs in that code, which seems to be the
    case as reported by Jiri Olsa in:
    
      "[BUG] perf: intel_pt won't display kernel function"
      https://lore.kernel.org/lkml/20190403143738.GB32001@krava
    
    So add the check for record_opts.no_bpf_event when considering
    synthesizing BPF events for pre-existing BPF programs in 'perf record'.
    
    The reported bug needs further analysis and is a separate matter.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Martin KaFai Lau <kafai@fb.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Yonghong Song <yhs@fb.com>
    Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
    Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

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
