From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/66] libtraceevent: Round up in tep_print_event() time precision
Date: Wed, 25 Sep 2019 21:31:45 -0300
Message-ID: <20190926003244.13962-8-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, linux trace devel <linux-trace-devel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When testing the output of the old trace-cmd compared to the one that
uses the updated tep_print_event() logic, it was different in that the
time stamp precision in the old format would round up to the nearest
precision, where as the new logic truncates. Bring back the old method
of rounding up.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: linux trace devel <linux-trace-devel@vger.kernel.org>
Link: http://lore.kernel.org/lkml/20190919165119.5efa5de6@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 6f842af4550b..d948475585ce 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5527,8 +5527,10 @@ static void print_event_time(struct tep_handle *tep, struct trace_seq *s,
 	if (divstr && isdigit(*(divstr + 1)))
 		div = atoi(divstr + 1);
 	time = record->ts;
-	if (div)
+	if (div) {
+		time += div / 2;
 		time /= div;
+	}
 	pr = prec;
 	while (pr--)
 		p10 *= 10;
-- 
2.21.0
