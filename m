From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2 13/14] perf util: do not consider empty files as valid srclines
Date: Sun,  6 Aug 2017 23:24:45 +0200
Message-ID: <20170806212446.24925-14-milian.wolff@kdab.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806212446.24925-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

Sometimes we get a non-null, but empty, string for the filename from
bfd. This then results in srclines of the form ":0", which is
different from the canonical SRCLINE_UNKNOWN in the form "??:0".
Set the file to NULL if it is empty to fix this.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/srcline.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 0c5ee741c515..7bf38b78a1ba 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -168,6 +168,9 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
 	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
 					   &a2l->filename, &a2l->funcname,
 					   &a2l->line);
+
+	if (a2l->filename && !strlen(a2l->filename))
+		a2l->filename = NULL;
 }
 
 static struct a2l_data *addr2line_init(const char *path)
@@ -297,6 +300,9 @@ static int addr2line(const char *dso_name, u64 addr,
 					     &a2l->funcname, &a2l->line) &&
 		       cnt++ < MAX_INLINE_NEST) {
 
+			if (a2l->filename && !strlen(a2l->filename))
+				a2l->filename = NULL;
+
 			if (node != NULL) {
 				if (inline_list__append_dso_a2l(dso, node, sym))
 					return 0;
-- 
2.13.3
