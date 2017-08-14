From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/19] perf srcline: Do not consider empty files as valid srclines
Date: Mon, 14 Aug 2017 13:27:38 -0300
Message-ID: <20170814162741.6101-17-acme@kernel.org>
References: <20170814162741.6101-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

Sometimes we get a non-null, but empty, string for the filename from
bfd. This then results in srclines of the form ":0", which is different
from the canonical SRCLINE_UNKNOWN in the form "??:0".  Set the file to
NULL if it is empty to fix this.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20170806212446.24925-14-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index ebc88a74e67b..ed8e8d2de942 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -155,6 +155,9 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
 	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
 					   &a2l->filename, &a2l->funcname,
 					   &a2l->line);
+
+	if (a2l->filename && !strlen(a2l->filename))
+		a2l->filename = NULL;
 }
 
 static struct a2l_data *addr2line_init(const char *path)
@@ -248,6 +251,9 @@ static int addr2line(const char *dso_name, u64 addr,
 					     &a2l->funcname, &a2l->line) &&
 		       cnt++ < MAX_INLINE_NEST) {
 
+			if (a2l->filename && !strlen(a2l->filename))
+				a2l->filename = NULL;
+
 			if (node != NULL) {
 				if (inline_list__append_dso_a2l(dso, node))
 					return 0;
-- 
2.13.4
