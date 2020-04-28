From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 7/7] perf record: Introduce --switch-output-event
Date: Tue, 28 Apr 2020 15:05:18 -0300
Message-ID: <20200428180518.GF5460@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-8-acme@kernel.org>
 <20200428094839.GD1476763@krava>
 <20200428121601.GB2245@kernel.org>
 <20200428132257.GH1476763@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428132257.GH1476763@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Apr 28, 2020 at 03:22:57PM +0200, Jiri Olsa escreveu:
> On Tue, Apr 28, 2020 at 09:16:01AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > > +				pr_err("Couldn't create side band evlist.\n.");
> > > > +				goto out_child;
> > > > +			}
> > > >  		}

> > > >  		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {

> > > it's getting bigger, I wonder we should put all the sb_* setup in
> > > separated functions like sb_start/sb_stop

> > Well, the rec->thread_id = pthread_self(); part is just for reusing a
> > 'perf record' specific mechanism, what to do when the event appears in
> > the side band thread ring buffer, the evlist__set_cb() also is related
> > to that, moving thread_id to evlist seems too much at this time.

> hum, I meant record specific static functions sb_start/sb_stop,
> not inside evlist.. just to have it separated

Ok, so I have the patch below on top of that series, and its all
available in my perf/switch-output-event, that is on top of more patches
collected today, all going well, this perf/switch-output-event will turn
into perf/core ang go upstream soon, then I have to loo at Adrian's
kernel+tooling patchkit,

- Arnaldo

commit a25516b4db23ba8f956b990d37ec6728e5221718
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Apr 28 14:58:29 2020 -0300

    perf record: Move side band evlist setup to separate routine
    
    It is quite big by now, move that code to a separate
    record__setup_sb_evlist() routine.
    
    Suggested-by: Jiri Olsa <jolsa@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Song Liu <songliubraving@fb.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7a6a89972691..bb3d30616bf3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1445,6 +1445,44 @@ static int record__process_signal_event(union perf_event *event __maybe_unused,
 	return 0;
 }
 
+static int record__setup_sb_evlist(struct record *rec)
+{
+	struct record_opts *opts = &rec->opts;
+
+	if (rec->sb_evlist != NULL) {
+		/*
+		 * We get here if --switch-output-event populated the
+		 * sb_evlist, so associate a callback that will send a SIGUSR2
+		 * to the main thread.
+		 */
+		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
+		rec->thread_id = pthread_self();
+	}
+
+	if (!opts->no_bpf_event) {
+		if (rec->sb_evlist == NULL) {
+			rec->sb_evlist = evlist__new();
+
+			if (rec->sb_evlist == NULL) {
+				pr_err("Couldn't create side band evlist.\n.");
+				return -1;
+			}
+		}
+
+		if (evlist__add_bpf_sb_event(rec->sb_evlist, &rec->session->header.env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			return -1;
+		}
+	}
+
+	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1589,36 +1627,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	if (rec->sb_evlist != NULL) {
-		/*
-		 * We get here if --switch-output-event populated the
-		 * sb_evlist, so associate a callback that will send a SIGUSR2
-		 * to the main thread.
-		 */
-		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
-		rec->thread_id = pthread_self();
-	}
-
-	if (!opts->no_bpf_event) {
-		if (rec->sb_evlist == NULL) {
-			rec->sb_evlist = evlist__new();
-
-			if (rec->sb_evlist == NULL) {
-				pr_err("Couldn't create side band evlist.\n.");
-				goto out_child;
-			}
-		}
-
-		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
-			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
-			goto out_child;
-		}
-	}
-
-	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
-		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
-		opts->no_bpf_event = true;
-	}
+	err = record__setup_sb_evlist(rec);
+	if (err)
+		goto out_child;
 
 	err = record__synthesize(rec, false);
 	if (err < 0)
