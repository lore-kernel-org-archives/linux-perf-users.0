From: Jiri Olsa <jolsa@redhat.com>
Subject: [BUG] perf: intel_pt won't display kernel function
Date: Wed, 3 Apr 2019 16:37:38 +0200
Message-ID: <20190403143738.GB32001@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

hi,
perf script --call-trace stop working for me recently,
and displays only user space functions

I bisected that to:
  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs

data from following comands will display user space functions only:
  # perf-with-kcore record pt -e intel_pt// -- ls
  # perf-with-kcore script pt --call-trace

when I disable the bpf synthesizing (patch below), kernel functions are back

I guess the new events mess up with intel_pt decoder somehow


thanks,
jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4e2d953d4bc5..3daa78bc6549 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
+#if 0
 	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
+#endif
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
