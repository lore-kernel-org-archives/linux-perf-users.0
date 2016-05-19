From: Chris Ryder <chris.ryder@arm.com>
Subject: [PATCH 2/7] perf annotate: Sort list of recognised instructions
Date: Thu, 19 May 2016 17:59:46 +0100
Message-ID: <4268febaf32f47f322c166fb2fe98cfec7041e11.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
In-Reply-To: <cover.1463676839.git.chris.ryder@arm.com>
References: <cover.1463676839.git.chris.ryder@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ryder <chris.ryder@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Currently the list of instructions recognised by perf annotate
has to be explicitly written in sorted order. This makes it easy
to make mistakes when adding new instructions. Sort the list of
instructions on first access.

Signed-off-by: Chris Ryder <chris.ryder@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 tools/perf/util/annotate.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d197571..619bc27 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -354,9 +354,6 @@ static struct ins_ops nop_ops = {
 	.scnprintf = nop__scnprintf,
 };
 
-/*
- * Must be sorted by name!
- */
 static struct ins instructions[] = {
 	{ .name = "add",   .ops  = &mov_ops, },
 	{ .name = "addl",  .ops  = &mov_ops, },
@@ -449,18 +446,39 @@ static struct ins instructions[] = {
 	{ .name = "xbeginq", .ops  = &jump_ops, },
 };
 
-static int ins__cmp(const void *name, const void *insp)
+static int ins__key_cmp(const void *name, const void *insp)
 {
 	const struct ins *ins = insp;
 
 	return strcmp(name, ins->name);
 }
 
+static int ins__cmp(const void *a, const void *b)
+{
+	const struct ins *ia = a;
+	const struct ins *ib = b;
+
+	return strcmp(ia->name, ib->name);
+}
+
+static void ins__sort(void)
+{
+	const int nmemb = ARRAY_SIZE(instructions);
+
+	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
+}
+
 static struct ins *ins__find(const char *name)
 {
 	const int nmemb = ARRAY_SIZE(instructions);
+	static bool sorted;
+
+	if (!sorted) {
+		ins__sort();
+		sorted = true;
+	}
 
-	return bsearch(name, instructions, nmemb, sizeof(struct ins), ins__cmp);
+	return bsearch(name, instructions, nmemb, sizeof(struct ins), ins__key_cmp);
 }
 
 int symbol__annotate_init(struct map *map __maybe_unused, struct symbol *sym)
-- 
2.1.4
