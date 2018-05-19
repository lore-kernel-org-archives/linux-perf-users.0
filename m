From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/18] perf config: Call perf_config__init() lazily
Date: Sat, 19 May 2018 07:54:50 -0300
Message-ID: <20180519105507.16450-2-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We check what perf_config__init() does at each perf_config() call,
namely if the static perf_config instance was created, so instead of
bailing out in that case, try to allocate it, bailing if it fails.

Now to get the perf_config() call out of the start of perf's main()
function, doing it also lazily.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4bo45k6ivsmbxpfpdte4orsg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c        |  1 -
 tools/perf/util/config.c | 16 +++++++++-------
 tools/perf/util/config.h |  1 -
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 20a08cb32332..cd6ea55d4b0c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -458,7 +458,6 @@ int main(int argc, const char **argv)
 
 	srandom(time(NULL));
 
-	perf_config__init();
 	err = perf_config(perf_default_config, NULL);
 	if (err)
 		return err;
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 84eb9393c7db..5ac157056cdf 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -707,6 +707,14 @@ struct perf_config_set *perf_config_set__new(void)
 	return set;
 }
 
+static int perf_config__init(void)
+{
+	if (config_set == NULL)
+		config_set = perf_config_set__new();
+
+	return config_set == NULL;
+}
+
 int perf_config(config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -714,7 +722,7 @@ int perf_config(config_fn_t fn, void *data)
 	struct perf_config_section *section;
 	struct perf_config_item *item;
 
-	if (config_set == NULL)
+	if (config_set == NULL && perf_config__init())
 		return -1;
 
 	perf_config_set__for_each_entry(config_set, section, item) {
@@ -735,12 +743,6 @@ int perf_config(config_fn_t fn, void *data)
 	return ret;
 }
 
-void perf_config__init(void)
-{
-	if (config_set == NULL)
-		config_set = perf_config_set__new();
-}
-
 void perf_config__exit(void)
 {
 	perf_config_set__delete(config_set);
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index baf82bf227ac..bd0a5897c76a 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -38,7 +38,6 @@ struct perf_config_set *perf_config_set__new(void);
 void perf_config_set__delete(struct perf_config_set *set);
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value);
-void perf_config__init(void);
 void perf_config__exit(void);
 void perf_config__refresh(void);
 
-- 
2.14.3
