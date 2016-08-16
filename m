From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2] perf: Fix off-by-one buffer overflow while using strtok_r
Date: Tue, 16 Aug 2016 13:30:28 +0200
Message-ID: <20160816113028.18708-1-milian.wolff@kdab.com>
References: <20160816110149.10829-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:47912 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbcHPLad (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 07:30:33 -0400
In-Reply-To: <20160816110149.10829-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Milian Wolff <milian.wolff@kdab.com>

The string passed to strtok_r in parse_ftrace_printk must be null-
delimited, otherwise we run into the following issue reported by
valgrind:

valgrind --track-origins=yes perf report
==7962== Invalid read of size 1
==7962==    at 0x25CEBB: __strtok_r_1c (string2.h:200)
==7962==    by 0x25CEBB: parse_ftrace_printk (trace-event-parse.c:158)
==7962==    by 0x268242: read_ftrace_printk (trace-event-read.c:204)
==7962==    by 0x268242: trace_report (trace-event-read.c:423)
==7962==    by 0x23E751: process_tracing_data (header.c:1571)
==7962==    by 0x244911: perf_file_section__process (header.c:2683)
==7962==    by 0x244911: perf_header__process_sections (header.c:2466)
==7962==    by 0x244911: perf_session__read_header (header.c:2901)
==7962==    by 0x2571CA: perf_session__open (session.c:32)
==7962==    by 0x2571CA: perf_session__new (session.c:139)
==7962==    by 0x1D153D: cmd_inject (builtin-inject.c:919)
==7962==    by 0x207E6E: run_builtin (perf.c:357)
==7962==    by 0x19E58D: handle_internal_command (perf.c:419)
==7962==    by 0x19E58D: run_argv (perf.c:465)
==7962==    by 0x19E58D: main (perf.c:609)
==7962==  Address 0x81fc59e is 0 bytes after a block of size 1,998 alloc'd
==7962==    at 0x4C29BBE: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==7962==    by 0x268219: read_ftrace_printk (trace-event-read.c:195)
==7962==    by 0x268219: trace_report (trace-event-read.c:423)
==7962==    by 0x23E751: process_tracing_data (header.c:1571)
==7962==    by 0x244911: perf_file_section__process (header.c:2683)
==7962==    by 0x244911: perf_header__process_sections (header.c:2466)
==7962==    by 0x244911: perf_session__read_header (header.c:2901)
==7962==    by 0x2571CA: perf_session__open (session.c:32)
==7962==    by 0x2571CA: perf_session__new (session.c:139)
==7962==    by 0x1D153D: cmd_inject (builtin-inject.c:919)
==7962==    by 0x207E6E: run_builtin (perf.c:357)
==7962==    by 0x19E58D: handle_internal_command (perf.c:419)
==7962==    by 0x19E58D: run_argv (perf.c:465)
==7962==    by 0x19E58D: main (perf.c:609)

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/trace-event-read.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index b67a0cc..f2564e1 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -192,9 +192,10 @@ static int read_ftrace_printk(struct pevent *pevent)
 	if (!size)
 		return 0;
 
-	buf = malloc(size);
+	buf = malloc(size + 1);
 	if (buf == NULL)
 		return -1;
+	buf[size] = 0;
 
 	if (do_read(buf, size) < 0) {
 		free(buf);
-- 
2.9.3
