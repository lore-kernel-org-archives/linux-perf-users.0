From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/26] perf dsos: Remove unused dsos__find() method
Date: Fri, 22 Nov 2019 11:56:49 -0300
Message-ID: <20191122145711.3171-5-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Not used anywhere, nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-teqz0eqcw43mnt7i3me44esw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c | 9 ---------
 tools/perf/util/dsos.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index ecf8d7346685..1d38d6ac6e5a 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -159,15 +159,6 @@ struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	return __dsos__findnew_by_longname(&dsos->root, name);
 }
 
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
-{
-	struct dso *dso;
-	down_read(&dsos->lock);
-	dso = __dsos__find(dsos, name, cmp_short);
-	up_read(&dsos->lock);
-	return dso;
-}
-
 static void dso__set_basename(struct dso *dso)
 {
 	char *base, *lname;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 32f1fbee0feb..fd7ba51fc965 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -24,7 +24,6 @@ void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 struct dso *__dsos__findnew(struct dsos *dsos, const char *name);
 struct dso *dsos__findnew(struct dsos *dsos, const char *name);
 
-- 
2.21.0
