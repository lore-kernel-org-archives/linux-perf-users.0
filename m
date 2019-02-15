From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/43] tools feature: Undef _GNU_SOURCE at the end of feature tests
Date: Thu, 14 Feb 2019 21:45:09 -0300
Message-ID: <20190215004539.23571-14-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we get all the tests in a single .c file for a first test,
tools/build/feature/test-all.c, if individual tests set that define and
fail to undef it at its end, then it the test-all.c build will fail due
to defining _GNU_SOURCE multiple times, getting us to the slow path,
so undef it at the end in tests that define it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w6s00jfo1xabgphzczadl59b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-get_current_dir_name.c | 1 +
 tools/build/feature/test-libpython.c            | 1 +
 tools/build/feature/test-setns.c                | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
index 573000f93212..c3c201691b4f 100644
--- a/tools/build/feature/test-get_current_dir_name.c
+++ b/tools/build/feature/test-get_current_dir_name.c
@@ -8,3 +8,4 @@ int main(void)
 	free(get_current_dir_name());
 	return 0;
 }
+#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-libpython.c b/tools/build/feature/test-libpython.c
index 0c1641b0d9a7..371c9113e49d 100644
--- a/tools/build/feature/test-libpython.c
+++ b/tools/build/feature/test-libpython.c
@@ -7,3 +7,4 @@ int main(void)
 
 	return 0;
 }
+#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 1f714d2a658b..4a1581ae7a55 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -5,3 +5,4 @@ int main(void)
 {
 	return setns(0, 0);
 }
+#undef _GNU_SOURCE
-- 
2.19.1
