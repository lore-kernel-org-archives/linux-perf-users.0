Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCE3D75A1;
	Wed,  8 Apr 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669570; cv=none; b=h5H+djFiZjDknyNOmneaZ+OKPg1MBVmfudQuQZKowZdKu4tWf0gplXlKXGl/YAf1xgjyj+z8n6xlOxndoCNeDzgs6ohA7YCwFshRv3rlIhOpSIv2HreNMQWdRfYilXVgm4stnwf/ieMnf+z9GdMUoHaIy0jpuycgEROkFnHNfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669570; c=relaxed/simple;
	bh=IqrRyXkqBak8OIM3m25gc+YRTHUcPtmiNBZO0n9k2Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFkqlH9rDY5bSkywj899DV/3FPNSV9WOqhmGCBNYpt59PuCKiaf914p87gUeutOlBF7bEwYdDZJxIERGIZmviM1Pv4j1PapB38CQ6P8VAoZVhQJxEsFkTufgoYsaWJUITG/M5uxoekf0kuoxv/wIhuMn2NCgt6VJx6kihmpfLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr5AVzRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr5AVzRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BBBC2BC9E;
	Wed,  8 Apr 2026 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669570;
	bh=IqrRyXkqBak8OIM3m25gc+YRTHUcPtmiNBZO0n9k2Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gr5AVzRSCo7sz2XSuXXffQQYo9oKWgujP0wsZxK2sXXSEj8DGqsAPoLDZcK34O0D9
	 gO7UV8slxm6JJH/AAkvJLZLCXKbHRpElQezWjmhscVoKvpZy26wAS+fXzZF2ktanho
	 k6MKCUoo2shD5Ob+AB1clfadm5J51pwzxzeRGY8DGrqxFPZBtcBCmjEi/ah4HegV+U
	 dJKTRCt+VgIQuPFy8I9M5X1KWViLupwRpsxi45jISXugpz9r09KOBdsQDUzp3kMicR
	 rh4OP7FKmX2gRqyn59socQYN27b5w5PQTxz4snway6xV1yXCc+ajvoBw9gS8G6xi8i
	 UZm/2X/PFpZpA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 8/8] perf tools: Replace basename() calls with perf_basename()
Date: Wed,  8 Apr 2026 14:32:03 -0300
Message-ID: <20260408173203.96700-9-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408173203.96700-1-acme@kernel.org>
References: <20260408173203.96700-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As noticed in a sashiko review for a patch adding a missing libgen.h
in a file using basename():

  https://sashiko.dev/#/patchset/20260402001740.2220481-1-acme%40kernel.org

So avoid these subtleties and instead reuse the gnu_basename() function
we had in srcline.c, renaming it to perf_basename() and replace
basename() calls with it, simplifying several cases by removing now
needless strdups.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-daemon.c         |  4 ++--
 tools/perf/util/annotate.c          |  3 +--
 tools/perf/util/data-convert-json.c |  4 ++--
 tools/perf/util/dsos.c              | 32 ++++++++---------------------
 tools/perf/util/probe-event.c       |  3 +--
 tools/perf/util/srcline.c           | 11 ++--------
 tools/perf/util/symbol.h            | 16 ++++-----------
 tools/perf/util/util.c              |  8 ++++++++
 tools/perf/util/util.h              |  2 ++
 9 files changed, 31 insertions(+), 52 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 33473e071392601e..c4632577d1296350 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1016,7 +1016,7 @@ static int setup_config_changes(struct daemon *daemon)
 {
 	char *basen = strdup(daemon->config_real);
 	char *dirn  = strdup(daemon->config_real);
-	char *base, *dir;
+	const char *base, *dir;
 	int fd, wd = -1;
 
 	if (!dirn || !basen)
@@ -1029,7 +1029,7 @@ static int setup_config_changes(struct daemon *daemon)
 	}
 
 	dir = dirname(dirn);
-	base = basename(basen);
+	base = perf_basename(basen);
 	pr_debug("config file: %s, dir: %s\n", base, dir);
 
 	wd = inotify_add_watch(fd, dir, IN_CLOSE_WRITE);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 63f0ee9d4c03ce4e..e745f3034a0e1c52 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -8,7 +8,6 @@
 
 #include <errno.h>
 #include <inttypes.h>
-#include <libgen.h>
 #include <stdlib.h>
 #include "util.h" // hex_width()
 #include "ui/ui.h"
@@ -1245,7 +1244,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	if (opts->full_path)
 		d_filename = filename;
 	else
-		d_filename = basename(filename);
+		d_filename = perf_basename(filename);
 
 	if (evsel__is_group_event(evsel)) {
 		evsel__group_desc(evsel, buf, sizeof(buf));
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 4b1b2f7bed251691..d526c91312ed8b93 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -326,7 +326,7 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_format(out, false, 2, "]");
 }
 
-int bt_convert__perf2json(const char *input_name, const char *output_name,
+int bt_convert__perf2json(const char *_input_name, const char *output_name,
 		struct perf_data_convert_opts *opts __maybe_unused)
 {
 	struct perf_session *session;
@@ -342,7 +342,7 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
-		.path = input_name,
+		.path = _input_name,
 		.force = opts->force,
 	};
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 5cf8c878bab2a4a4..e927e707abace9c6 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -6,7 +6,6 @@
 #include "vdso.h"
 #include "namespaces.h"
 #include <errno.h>
-#include <libgen.h>
 #include <stdlib.h>
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
@@ -297,34 +296,21 @@ struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 
 static void dso__set_basename(struct dso *dso)
 {
-	char *base, *lname;
+	bool allocated = false;
+	const char *base;
 	int tid;
 
 	if (perf_pid_map_tid(dso__long_name(dso), &tid)) {
-		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
-			return;
-	} else {
-	      /*
-	       * basename() may modify path buffer, so we must pass
-               * a copy.
-               */
-		lname = strdup(dso__long_name(dso));
-		if (!lname)
-			return;
-
-		/*
-		 * basename() may return a pointer to internal
-		 * storage which is reused in subsequent calls
-		 * so copy the result.
-		 */
-		base = strdup(basename(lname));
+		char *jitname;
 
-		free(lname);
-
-		if (!base)
+		if (asprintf(&jitname, "[JIT] tid %d", tid) < 0)
 			return;
+		allocated = true;
+		base = jitname;
+	} else {
+		base = perf_basename(dso__long_name(dso));
 	}
-	dso__set_short_name(dso, base, true);
+	dso__set_short_name(dso, base, allocated);
 }
 
 static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index f37a783ea7723197..34b4badd2c14ade0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -11,7 +11,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <libgen.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -229,7 +228,7 @@ static int convert_exec_to_group(const char *exec, char **result)
 	if (!exec_copy)
 		return -ENOMEM;
 
-	ptr1 = basename(exec_copy);
+	ptr1 = (char *)perf_basename(exec_copy);
 	if (!ptr1) {
 		ret = -EINVAL;
 		goto out;
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index b58710624eadfe1b..db164d25816347ac 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -8,6 +8,7 @@
 #include "symbol.h"
 #include "libdw.h"
 #include "debug.h"
+#include "util.h"
 
 #include <inttypes.h>
 #include <string.h>
@@ -74,14 +75,6 @@ int inline_list__append_tail(struct symbol *symbol, char *srcline, struct inline
 	return 0;
 }
 
-/* basename version that takes a const input string */
-static const char *gnu_basename(const char *path)
-{
-	const char *base = strrchr(path, '/');
-
-	return base ? base + 1 : path;
-}
-
 char *srcline_from_fileline(const char *file, unsigned int line)
 {
 	char *srcline;
@@ -90,7 +83,7 @@ char *srcline_from_fileline(const char *file, unsigned int line)
 		return NULL;
 
 	if (!srcline_full_filename)
-		file = gnu_basename(file);
+		file = perf_basename(file);
 
 	if (asprintf(&srcline, "%s:%u", file, line) < 0)
 		return NULL;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c67814d6d6d6f64a..bd6eb90c86683762 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -14,6 +14,7 @@
 #include "path.h"
 #include "symbol_conf.h"
 #include "spark.h"
+#include "util.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 #include <libelf.h>
@@ -97,18 +98,9 @@ struct intlist;
 
 static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 {
-	if (symbol_conf.symfs_layout_flat) {
-		char *path_copy = strdup(path);
-		char *base;
-		int ret;
-
-		if (!path_copy)
-			return -ENOMEM;
-		base = basename(path_copy);
-		ret = path__join(bf, size, symbol_conf.symfs, base);
-		free(path_copy);
-		return ret;
-	}
+	if (symbol_conf.symfs_layout_flat)
+		return path__join(bf, size, symbol_conf.symfs, perf_basename(path));
+
 	return path__join(bf, size, symbol_conf.symfs, path);
 }
 
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index c5fee8e394805544..25849434f0a4e5fd 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -545,3 +545,11 @@ int scandirat(int dirfd, const char *dirp,
 	return err;
 }
 #endif
+
+/* basename version that takes a const input string */
+const char *perf_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index e935438451b81fda..87a0818a8c765c45 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -86,6 +86,8 @@ struct perf_debuginfod {
 };
 void perf_debuginfod_setup(struct perf_debuginfod *di);
 
+const char *perf_basename(const char *path);
+
 char *filename_with_chroot(int pid, const char *filename);
 
 int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x,
-- 
2.53.0

