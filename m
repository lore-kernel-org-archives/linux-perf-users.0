From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/34] perf test: Handle properly readdir DT_UNKNOWN
Date: Thu, 14 Dec 2017 14:42:26 -0300
Message-ID: <20171214174247.16841-14-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Some system can return DT_UNKNOWN in readdir's struct dirent::d_type and
we must handle it properly. In this case we can directly check if the
entity we found is directory and skip it.

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171206174535.25380-1-jolsa@kernel.org
[ Split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 766573e236e4..fafa014240cd 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -411,9 +411,9 @@ static const char *shell_test__description(char *description, size_t size,
 	return description ? trim(description + 1) : NULL;
 }
 
-#define for_each_shell_test(dir, ent)		\
+#define for_each_shell_test(dir, base, ent)	\
 	while ((ent = readdir(dir)) != NULL)	\
-		if (ent->d_type == DT_REG && ent->d_name[0] != '.')
+		if (!is_directory(base, ent))
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
@@ -452,7 +452,7 @@ static int shell_tests__max_desc_width(void)
 	if (!dir)
 		return -1;
 
-	for_each_shell_test(dir, ent) {
+	for_each_shell_test(dir, path, ent) {
 		char bf[256];
 		const char *desc = shell_test__description(bf, sizeof(bf), path, ent->d_name);
 
@@ -504,7 +504,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 	if (!dir)
 		return -1;
 
-	for_each_shell_test(dir, ent) {
+	for_each_shell_test(dir, st.dir, ent) {
 		int curr = i++;
 		char desc[256];
 		struct test test = {
@@ -614,7 +614,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 	if (!dir)
 		return -1;
 
-	for_each_shell_test(dir, ent) {
+	for_each_shell_test(dir, path, ent) {
 		int curr = i++;
 		char bf[256];
 		struct test t = {
-- 
2.13.6
