Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9E4C10F6;
	Thu, 17 Sep 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660566; cv=none; b=nQdqnPM6Vy8ae3/OhBqe2FdjpN+dN0ldWY8JKhIjJU7tC7PeyRxBWG5lrcoMq8TaXgxcXsOd6Zr4t/ysyj0AmksMmttegrIH4ws2i7xhV5lkELa+EO8/jp9W11XBOmL7Izn7WPJA9Rn+lGHlDiZJdw8R3Bo17QczhcRhRORaA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660566; c=relaxed/simple;
	bh=NRkWhoThg/1YMiSC8JAjOIJcJIDl81K4OIG6pDn95lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOYJlD4ZOrZsp4NO8eIIslaTCLviM4OAAEUVFEoyeymp6WJ97v+NdRduNtYM2o4CWHG57YbbZykZd5y/OSlSKskkneN8s7rw6Cuy8xIms2ZlRHzkX8KfVyAWiwENmJmdhKCJoUIS9pRVI37o+lwV8Bv5iLGEWluSt6450xw0rY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2XiU9CB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2XiU9CB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26A01F00893;
	Thu, 17 Sep 2026 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660564;
	bh=ENMlp3U8o8HPaksuZXdnV+kA24oe4O+hYit9U0xWJVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2XiU9CBFhjuuZHgPOu6yIoSJ/+bb69Mfenf1ho8zA4JBCOO7d4wPcV5GZg3fX/p6
	 av2rGBfKu+mwntJpC6+v41fs3SViEZ0lNYBtNRAk8ZRCEooZ21SH9UUVQzGmv10VmK
	 YLAJYiCLFz+luUVyfTpfwgKW/9YWXLrB2x6pIV3pmNc9naC5N/AxlQG7zjm3ekQtZ0
	 3vwIlPYPbX9cnhH0/yHtFvDr8cgFe2VXI8/z2Fon/51oNS5OL7eHR3E5hGkhgDra/w
	 ridj2lDionKBAX8mPqa7DyJDN0gar1O6X4Nn9XC19Un7uinr4qFUfg0HaNcHhL56CB
	 NwPHvfKtqw6PQ==
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
Subject: [PATCH 06/15] perf symbol: Fall back to fetching the vmlinux by build ID
Date: Thu, 17 Sep 2026 12:55:17 -0300
Message-ID: <20260917155528.62607-7-acme@kernel.org>
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

A profile recorded on a kernel that is no longer installed, e.g. one
processed on another machine or after a kernel upgrade, cannot have its
kernel symbols resolved: /proc/kallsyms does not match it and the
build-id cache may carry only a kallsyms copy with zeroed addresses.
Fetch the vmlinux keyed by the build ID recorded in perf.data, using
debuginfod, as a last resort when no local source was found, honoring
symbol_conf.ignore_vmlinux and ignore_vmlinux_buildid like the other
vmlinux sources.

The fetch runs with dso->lock dropped, like dso__debuginfo(), and the
file is loaded with the lock held again, only if no other thread got the
symbols meanwhile (dso__has_symbols(), not dso__loaded(): the latter is
set even for failed attempts).  With the lock dropped two threads can
map the x86-64 entry trampolines at once, so that mapping is now
idempotent.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 11 ++++++--
 tools/perf/util/symbol.c  | 55 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a1288fbed8330a23..8aa9f5f12d3ea4bf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1139,12 +1139,19 @@ static int machine__map_x86_64_entry_trampolines_cb(struct map *map, void *data)
 	if (!kmap || !is_entry_trampoline(kmap->name))
 		return 0;
 
+	args->found = true;
+
+	/*
+	 * pgoff is a virtual address when the trampoline maps are created and
+	 * a vmlinux offset once mapped, so a second pass, e.g. a concurrent
+	 * dso__load() of the kernel dso, finds no map and has nothing to
+	 * translate: leave the map alone, never dereference a NULL dest_map.
+	 */
 	dest_map = maps__find(args->kmaps, map__pgoff(map));
-	if (RC_CHK_ACCESS(dest_map) != RC_CHK_ACCESS(map))
+	if (dest_map != NULL && RC_CHK_ACCESS(dest_map) != RC_CHK_ACCESS(map))
 		map__set_pgoff(map, map__map_ip(dest_map, map__pgoff(map)));
 
 	map__put(dest_map);
-	args->found = true;
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fbad770cb96f8294..7a84dc8420975ab6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -20,6 +20,7 @@
 #include "cap.h"
 #include "cpumap.h"
 #include "debug.h"
+#include "debuginfo.h"
 #include "demangle-cxx.h"
 #include "demangle-java.h"
 #include "demangle-ocaml.h"
@@ -2191,12 +2192,28 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	return strdup(path);
 }
 
+/*
+ * Last resort when the symbols for the kernel the profile was recorded
+ * on can't be found locally: fetch the vmlinux keyed by the build ID
+ * recorded in perf.data, e.g. when processing the profile on another
+ * machine or after the kernel got upgraded in between.
+ */
+/* Called by dso__load_kernel_sym() with dso->lock dropped, see there. */
+static int dso__fetch_vmlinux_build_id(struct dso *dso, char **path)
+{
+	if (!dso__has_build_id(dso))
+		return -1;
+
+	return debuginfo__find_build_id(dso__bid(dso), path);
+}
+
 static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
 	char *kallsyms_allocated_filename = NULL;
 	char *filename = NULL;
+	bool user_kallsyms = false;
 
 	/*
 	 * Step 1: if the user specified a kallsyms or vmlinux filename, use
@@ -2215,6 +2232,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	 */
 	if (symbol_conf.kallsyms_name != NULL) {
 		kallsyms_filename = symbol_conf.kallsyms_name;
+		user_kallsyms = true;
 		goto do_kallsyms;
 	}
 
@@ -2257,7 +2275,42 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	free(kallsyms_allocated_filename);
 
-	if (err > 0 && !dso__is_kcore(dso)) {
+	/*
+	 * The kallsyms may be unavailable or restricted, try to fetch the
+	 * vmlinux keyed by the build ID using debuginfod as a last resort,
+	 * honoring ignore_vmlinux/ignore_vmlinux_buildid like the sources above.
+	 */
+	if (err <= 0 && !user_kallsyms &&
+	    !symbol_conf.ignore_vmlinux &&
+	    !symbol_conf.ignore_vmlinux_buildid) {
+		char *fetched_path = NULL;
+
+		/*
+		 * dso__load() holds dso->lock while it calls us, and the fetch below
+		 * can block for a long time: do it with the lock dropped, like
+		 * dso__debuginfo(), and load the symbols with the lock held again.
+		 */
+		mutex_unlock(dso__lock(dso));
+		err = dso__fetch_vmlinux_build_id(dso, &fetched_path);
+		mutex_lock(dso__lock(dso));
+
+		if (err) {
+			zfree(&fetched_path);
+		} else if (dso__has_symbols(dso)) {
+			/*
+			 * Somebody else got the symbols while the lock was dropped for the
+			 * fetch, use those instead.  dso__has_symbols() and not dso__loaded():
+			 * the latter is set even for failed attempts.
+			 */
+			pr_debug("%s got its symbols while its vmlinux was being fetched, using them\n",
+				 dso__name(dso));
+			zfree(&fetched_path);
+			err = 1;
+		} else {
+			/* Takes ownership of 'fetched_path' even when it fails */
+			err = dso__load_vmlinux(dso, map, fetched_path, true);
+		}
+	} else if (err > 0 && !dso__is_kcore(dso)) {
 		struct maps *kmaps = map__kmaps(map);
 
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
-- 
2.55.0

