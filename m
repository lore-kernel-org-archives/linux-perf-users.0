From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/83] perf annotate: Add annotation_line__add function
Date: Fri, 17 Nov 2017 17:14:51 -0300
Message-ID: <20171117201601.24110-14-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965761AbdKQURB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:01 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Rename disasm__add() into annotation_line__add() to make it work over a
generic struct annotation_line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e7da88d7bb27..11c7743203a0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -937,9 +937,9 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 	return ins__scnprintf(&dl->ins, bf, size, &dl->ops);
 }
 
-static void disasm__add(struct list_head *head, struct disasm_line *line)
+static void annotation_line__add(struct annotation_line *al, struct list_head *head)
 {
-	list_add_tail(&line->al.node, head);
+	list_add_tail(&al->node, head);
 }
 
 struct annotation_line *
@@ -1301,7 +1301,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 			dl->ops.target.name = strdup(target.sym->name);
 	}
 
-	disasm__add(&notes->src->source, dl);
+	annotation_line__add(&dl->al, &notes->src->source);
 
 	return 0;
 }
-- 
2.13.6
