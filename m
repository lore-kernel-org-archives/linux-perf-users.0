From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/52] perf tools: Use kallsyms__is_function()
Date: Wed,  2 May 2018 12:19:19 -0300
Message-ID: <20180502151942.20542-30-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Replacing equivalent, the equivalent and longer variation:

	 symbol__is_a(type, MAP__FUNCTION);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9t3dqogher54owfl9o2mir52@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c   | 4 ++--
 tools/perf/util/event.c      | 2 +-
 tools/perf/util/symbol-elf.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eaf1e10ae755..d056447520a2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1679,7 +1679,7 @@ struct sym_args {
 static bool kern_sym_match(struct sym_args *args, const char *name, char type)
 {
 	/* A function with the same name, and global or the n'th found or any */
-	return symbol_type__is_a(type, MAP__FUNCTION) &&
+	return kallsyms__is_function(type) &&
 	       !strcmp(name, args->name) &&
 	       ((args->global && isupper(type)) ||
 		(args->selected && ++(args->cnt) == args->idx) ||
@@ -1784,7 +1784,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 {
 	struct sym_args *args = arg;
 
-	if (!symbol_type__is_a(type, MAP__FUNCTION))
+	if (!kallsyms__is_function(type))
 		return 0;
 
 	if (!args->started) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index a8739cd0d8ca..241d3c827fae 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -868,7 +868,7 @@ static int find_symbol_cb(void *arg, const char *name, char type,
 	 * Must be a function or at least an alias, as in PARISC64, where "_text" is
 	 * an 'A' to the same address as "_stext".
 	 */
-	if (!(symbol_type__is_a(type, MAP__FUNCTION) ||
+	if (!(kallsyms__is_function(type) ||
 	      type == 'A') || strcmp(name, args->name))
 		return 0;
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 75f578f3ed8e..b6be6062cae0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1413,7 +1413,7 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 {
 	struct kcore_copy_info *kci = arg;
 
-	if (!symbol_type__is_a(type, MAP__FUNCTION))
+	if (!kallsyms__is_function(type))
 		return 0;
 
 	if (strchr(name, '[')) {
-- 
2.14.3
