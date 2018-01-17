From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/32] tools lib traceevent: Print value of unknown symbolic fields
Date: Wed, 17 Jan 2018 13:12:00 -0300
Message-ID: <20180117161222.15611-11-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Aligns trace-cmd with the behavior of the kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/e60c889f-55e7-4ee8-0e50-151e435ffd8c@siemens.com
Link: http://lkml.kernel.org/r/20180112004822.118332436@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 96c9c0b33423..87757eabbb08 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3985,6 +3985,8 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 				break;
 			}
 		}
+		if (!flag)
+			trace_seq_printf(s, "0x%llx", val);
 		break;
 	case PRINT_HEX:
 	case PRINT_HEX_STR:
-- 
2.14.3
