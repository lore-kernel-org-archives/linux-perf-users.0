From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/37] perf probe: Set pev->nargs to zero after freeing pev->args entries
Date: Mon, 22 Jul 2019 14:38:37 -0300
Message-ID: <20190722173839.22898-36-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that, when perf_add_probe_events() fails, like in:

  # perf probe icmp_rcv:64 "type=icmph->type"
  Failed to find 'icmph' in this function.
    Error: Failed to add events.
  Segmentation fault (core dumped)
  #

We don't segfault.

clear_perf_probe_event() was zeroing the whole pev, and since the switch
to zfree() for the members in the pev, that memset() was removed, which
left nargs with its original value, in the above case 1.

With the memset the same pev could be passed to clear_perf_probe_event()
multiple times, since all it would have would be zeroes, and free()
accepts zero, the loop would not happen and we would just memset it
again to zeroes.

Without it we got that segfault, so zero nargs to keep it like it was,
next cset will avoid calling clear_perf_probe_event() for the same pevs
in case of failure.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
Link: https://lkml.kernel.org/n/tip-802f2jypnwqsvyavvivs8464@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0c3b55d0617d..4acd3457d39d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2219,6 +2219,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 			field = next;
 		}
 	}
+	pev->nargs = 0;
 	zfree(&pev->args);
 }
 
-- 
2.21.0
