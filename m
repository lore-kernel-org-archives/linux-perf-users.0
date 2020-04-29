From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/8] perf record: Move sb_evlist to 'struct record'
Date: Wed, 29 Apr 2020 10:10:59 -0300
Message-ID: <20200429131106.27974-2-acme@kernel.org>
References: <20200429131106.27974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200429131106.27974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Where state related to a 'perf record' session is grouped.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200427211935.25789-2-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2e8011f179f2..2348c4205e59 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -86,6 +86,7 @@ struct record {
 	struct auxtrace_record	*itr;
 	struct evlist	*evlist;
 	struct perf_session	*session;
+	struct evlist		*sb_evlist;
 	int			realtime_prio;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -1446,7 +1447,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
-	struct evlist *sb_evlist = NULL;
 	int fd;
 	float ratio = 0;
 
@@ -1581,9 +1581,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	if (!opts->no_bpf_event)
-		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
+		bpf_event__add_sb_event(&rec->sb_evlist, &session->header.env);
 
-	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
+	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
 	}
@@ -1857,7 +1857,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	perf_session__delete(session);
 
 	if (!opts->no_bpf_event)
-		perf_evlist__stop_sb_thread(sb_evlist);
+		perf_evlist__stop_sb_thread(rec->sb_evlist);
 	return status;
 }
 
-- 
2.21.1
