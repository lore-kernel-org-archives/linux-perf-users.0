Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8B4E2F08;
	Thu, 17 Sep 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660548; cv=none; b=iqNYe+tw9rRGddEtpSSpGiv9kCCJHACi4Ih7HQA+iDwL36VtJQYfIdBxx68p7sR8uMadE80u4refnwMcJEFGs42DPmahrHls/9uCNQbodpLBXBn5Q4/yji22U+OKXVgp+WbeOREfMYOiascQxIgMgEFGz70xS69HCQm9sYlfRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660548; c=relaxed/simple;
	bh=Vgv5m697j2LtDwHwK/f7vJZZ5y6Op6J/VZBiDNrsd0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBfQttg1VaKOMfhuKQDsCe965FhCePdnys2sJy+SM0LmcURZFTspekx/qBz3nZuHFir9phClG9GhsuHeztSugkTfTyFPiI6QzahSpH9O3FQJTKdmcedLDfXso3zitSm58j5Zsz/5z7AWGU3q9AtYG+Evqc5oIO0DGTVl/8Y5Vvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWq+fo6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWq+fo6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F411F00893;
	Thu, 17 Sep 2026 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660546;
	bh=veEtliTXE+qi5c1dPvGcmoseCgN+WEJW4Sh9bMMveps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWq+fo6/GGIDhJCspORXUGjcMG3EBmFOFamFaQHyc+cSpNUGtF1/+WLwbQCwmtQYp
	 luGbaAFsjF7wXGRBWWDfdtBVqvHapxvDIjXbR7hB/3Bfebz0bObI9vIVNNIfkt+T0P
	 ybASAWRcsBzvFi42BUkLqYKUwmGbRrBYG7B3Mw59BKnD0RPuW31/hKhg9rcJCWtJay
	 2OgtEqAQwAZUND/k4cn0rPooFxfsvcVG6fpK73Vc8qxELkRzyzX79Jhv82xeJ/tHK+
	 ZKdhcO438p0zJLy+SsLVjzJ5FbjblziOQUUaZCp1rkf3wpXBPd5g0v4RyFzBUnMIDh
	 JkTwOVAm2+TcQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/15] perf debuginfo: Set DEBUGINFOD_URLS from /etc/debuginfod when unset
Date: Thu, 17 Sep 2026 12:55:13 -0300
Message-ID: <20260917155528.62607-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917155528.62607-1-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The debuginfod client fails when DEBUGINFOD_URLS isn't set even when
what it wants is in its local cache, and the distro setup scripts that
populate it from the files in /etc/debuginfod don't reach cron jobs,
systemd services and CI, so set it from those .urls files from
symbol__init(), before any thread that can call getenv() is started:
setenv() is not thread safe and libdebuginfod reads the variable in
every debuginfod_begin().

Install it via putenv() as a string perf owns, so that it can be
emptied in place mid-session when the user disables debuginfod, and
when debuginfod is off, with --no-debuginfod, core.debuginfod=false or
by disabling the build-id cache, set the empty string, that both
libdebuginfod and libdwfl's own client read as an opt-out, instead of
exporting the variable for libdwfl to fetch behind perf's back.  Tools
that manage DEBUGINFOD_URLS themselves are left alone.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c |   7 ++
 tools/perf/util/util.c   | 151 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/util.h   |   9 +++
 3 files changed, 161 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b1a2684c813c5d8d..fbad770cb96f8294 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2536,6 +2536,13 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
+	/*
+	 * Set DEBUGINFOD_URLS from the distro .urls files before any thread
+	 * that getenv()s it is started: setenv() is not thread safe and
+	 * libdebuginfod reads it in every debuginfod_begin().
+	 */
+	debuginfod__setup_urls_env();
+
 	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
 
 	symbol__elf_init();
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 8f7cd32f524dc10e..d502fd867f38196b 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -21,9 +21,11 @@
 #include <linux/time64.h>
 #include <linux/overflow.h>
 #include <unistd.h>
+#include "build-id.h"
 #include "cap.h"
 #include "strlist.h"
 #include "string2.h"
+#include "symbol_conf.h"
 
 /*
  * XXX We need to find a better place for these things...
@@ -431,19 +433,66 @@ char *perf_exe(char *buf, int len)
 	return strcpy(buf, "perf");
 }
 
+static bool debuginfod__urls_set_by_tool;
+
+#define DEBUGINFOD_URLS_ENV "DEBUGINFOD_URLS"
+
+/*
+ * The DEBUGINFOD_URLS string perf owns: it has to change mid-session
+ * when the user disables debuginfod, and setenv() then could race with
+ * another thread's getenv().  With the string owned by perf, disabling
+ * it is just writing a NUL over its first byte.  The string is never
+ * freed: from putenv() on it is the environment's own storage.
+ */
+static char *debuginfod_urls_env;
+
+static void debuginfod__set_urls_env(const char *urls)
+{
+	size_t len = strlen(DEBUGINFOD_URLS_ENV "=") + strlen(urls) + 1;
+	char *env = malloc(len);
+
+	if (env == NULL)
+		return;
+
+	snprintf(env, len, DEBUGINFOD_URLS_ENV "=%s", urls);
+	debuginfod_urls_env = env;
+	putenv(env);
+}
+
+/*
+ * Empty the copy of DEBUGINFOD_URLS installed by
+ * debuginfod__set_urls_env(), which both libdebuginfod and libdwfl's
+ * own client read as an opt-out.  No environ array write and no free(),
+ * so a racing getenv() sees a valid string.
+ */
+void debuginfod__disable_urls_env(void)
+{
+	if (debuginfod_urls_env != NULL)
+		debuginfod_urls_env[sizeof(DEBUGINFOD_URLS_ENV "=") - 1] = '\0';
+}
+
 void perf_debuginfod_setup(struct perf_debuginfod *di)
 {
 	/*
 	 * By default '!di->set' we clear DEBUGINFOD_URLS, so debuginfod
 	 * processing is not triggered, otherwise we set it to 'di->urls'
-	 * value. If 'di->urls' is "system" we keep DEBUGINFOD_URLS value.
+	 * value. If 'di->urls' is "system" we keep DEBUGINFOD_URLS value,
+	 * but as a copy perf owns, so that it can still be emptied
+	 * mid-session, see debuginfod__disable_urls_env().
 	 */
-	if (!di->set)
-		setenv("DEBUGINFOD_URLS", "", 1);
-	else if (di->urls && strcmp(di->urls, "system"))
-		setenv("DEBUGINFOD_URLS", di->urls, 1);
+	if (!di->set) {
+		debuginfod__set_urls_env("");
+	} else if (di->urls == NULL || !strcmp(di->urls, "system")) {
+		const char *urls = getenv(DEBUGINFOD_URLS_ENV);
+
+		if (urls != NULL)
+			debuginfod__set_urls_env(urls);
+	} else {
+		debuginfod__set_urls_env(di->urls);
+	}
 
-	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
+	debuginfod__urls_set_by_tool = true;
+	pr_debug("DEBUGINFOD_URLS=%s\n", getenv(DEBUGINFOD_URLS_ENV));
 
 #ifndef HAVE_DEBUGINFOD_SUPPORT
 	if (di->set)
@@ -451,6 +500,96 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
 #endif
 }
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+/*
+ * The debuginfod client checks its local cache only as part of the
+ * server query flow, so with no servers configured it fails even when
+ * the file is cached; the distro setup scripts that export
+ * DEBUGINFOD_URLS from /etc/debuginfod don't reach cron jobs, systemd
+ * services and CI, so do it here when the variable isn't set.  An
+ * explicitly empty DEBUGINFOD_URLS is an opt-out and is left alone.
+ *
+ * Done from symbol__init(), on the single-threaded setup: setenv() is
+ * not thread safe and libdebuginfod reads it in every
+ * debuginfod_begin().  When debuginfod is off, set the empty opt-out
+ * instead of exporting it, so that libdwfl's own client doesn't fetch.
+ * The value is a copy owned by perf, see debuginfod__set_urls_env().
+ */
+void debuginfod__setup_urls_env(void)
+{
+	const char *env_urls;
+	char *urls = NULL;
+	DIR *dir;
+	struct dirent *dent;
+
+	/*
+	 * Tools that set DEBUGINFOD_URLS themselves already made their choice,
+	 * leave it alone.
+	 */
+	if (debuginfod__urls_set_by_tool)
+		return;
+
+	if (!symbol_conf.debuginfod || !strcmp(buildid_dir, "/dev/null")) {
+		debuginfod__set_urls_env("");
+		pr_debug("DEBUGINFOD_URLS cleared, debuginfod is disabled\n");
+		return;
+	}
+
+	env_urls = getenv(DEBUGINFOD_URLS_ENV);
+	if (env_urls != NULL) {
+		/*
+		 * Take ownership of the value, so that it can be emptied mid-session
+		 * with the 'd' key.
+		 */
+		debuginfod__set_urls_env(env_urls);
+		return;
+	}
+
+	dir = opendir("/etc/debuginfod");
+	if (dir == NULL)
+		return;
+
+	while ((dent = readdir(dir)) != NULL) {
+		char *content = NULL;
+		char *new_urls;
+		char path[PATH_MAX];
+		size_t len = strlen(dent->d_name), i, size;
+		int n;
+
+		if (len < 5 || strcmp(dent->d_name + len - 5, ".urls"))
+			continue;
+
+		snprintf(path, sizeof(path), "/etc/debuginfod/%s", dent->d_name);
+		if (filename__read_str(path, &content, &size) < 0)
+			continue;
+
+		for (i = 0; i < size; i++)
+			if (content[i] == '\n' || content[i] == '\r')
+				content[i] = ' ';
+
+		if (urls == NULL) {
+			urls = strdup(content);
+		} else {
+			n = asprintf(&new_urls, "%s %s", urls, content);
+			if (n < 0) {
+				free(content);
+				continue;
+			}
+			free(urls);
+			urls = new_urls;
+		}
+		free(content);
+	}
+	closedir(dir);
+
+	if (urls != NULL) {
+		debuginfod__set_urls_env(urls);
+		pr_debug("Set DEBUGINFOD_URLS from /etc/debuginfod: %s\n", urls);
+	}
+	free(urls);
+}
+#endif /* HAVE_DEBUGINFOD_SUPPORT */
+
 /*
  * Return a new filename prepended with task's root directory if it's in
  * a chroot.  Callers should free the returned string.
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f8f1ff603c728086..42feccf18f0d163f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -81,6 +81,15 @@ struct perf_debuginfod {
 	bool		 set;
 };
 void perf_debuginfod_setup(struct perf_debuginfod *di);
+void debuginfod__disable_urls_env(void);
+
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+void debuginfod__setup_urls_env(void);
+#else
+static inline void debuginfod__setup_urls_env(void)
+{
+}
+#endif
 
 const char *perf_basename(const char *path);
 
-- 
2.55.0

