From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/63] perf probe: Fix to probe an inline function which has no entry pc
Date: Thu,  7 Nov 2019 15:59:29 -0300
Message-ID: <20191107190011.23924-22-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix perf probe to probe an inlne function which has no entry pc
or low pc but only has ranges attribute.

This seems very rare case, but I could find a few examples, as
same as probe_point_search_cb(), use die_entrypc() to get the
entry address in probe_point_inline_cb() too.

Without this patch:

  # perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.

With this patch:

  # perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints amd_put_event_constraints+43

Committer testing:

Before:

  [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints _text+33789
  [root@quaco ~]#

Fixes: 4ea42b181434 ("perf: Add perf probe subcommand, a kprobe-event setup helper")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157199320336.8075.16189530425277588587.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 71633f55f045..2fa932bcf960 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -930,7 +930,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 		ret = find_probe_point_lazy(in_die, pf);
 	else {
 		/* Get probe address */
-		if (dwarf_entrypc(in_die, &addr) != 0) {
+		if (die_entrypc(in_die, &addr) != 0) {
 			pr_warning("Failed to get entry address of %s.\n",
 				   dwarf_diename(in_die));
 			return -ENOENT;
-- 
2.21.0
