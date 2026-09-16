Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC164EBAE7;
	Wed, 16 Sep 2026 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559312; cv=none; b=u+GWOmk58Rqy+cZIIySbSjtduwhwhCndanr3sVyA5Frs2KYCYYlR/2GfnTcmxHnOqtHuLNQfK/sD3zERbVi40gtVj4sempqWAul4a6UMeFfLxi9zsP2G517Ym4wsQaHSbeB0joM8OaQojMXoYEyyjVkRlMwTEznt31k39kROmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559312; c=relaxed/simple;
	bh=9yG9UCvGLJMeQJaPLuwaNe6pWS5tJTWmZs/l+csudjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQbbUX560MUvu/qU5Q95xGOI+j+9s9JLVNl6GvZNmlrvb/3wirhVw2mbVg2DLn9uJeI+yUSrX++m3tNXH/CqAe1RBJ8K7fGpnTFawdBmTY8ltAzjj3GtbDWmcHIDoJ5HoVMaO4LEe6qzx3/nper7KA7Cv7LzvyRQtUGFvJO6PIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy2MGQKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy2MGQKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF971F00898;
	Wed, 16 Sep 2026 11:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559298;
	bh=iwBDReQ5ISqfz8GhEPPK3EQLZ/TY7NnAFMvEKO6Jubc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gy2MGQKNPPUql3JeqhOSPpjZFlgmNatIPda6vJuibDkjJ4/d08ex1L/tV8V7ddSmI
	 3+nOoHXanOsvLwrdnH8b2/HjjFFwp+1KYsJX0byojzpnIFXDiaekdIdobXPTsDKxy/
	 bphK7Dc2dZKhY539N2mF6umb3Xann2Zs33UYRpM0/+UVtNnssCR+F6t4GwLx3Q4zHY
	 UXr6FrbZqXXTvgrCHuuwvULl73rrSGxFy0J0hBIEWgnxjd4rfeh7ZLkruANh5cum6x
	 CF4yY2Yp/5HsD4r6iPbpv+OTrsgzoxmHthxtYKjOzW1TcACVrOSsNvzxFunXLpaPEj
	 vBu4ihh/pfdlg==
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
Subject: [PATCH 06/12] perf symbol: Fall back to fetching the vmlinux by build ID
Date: Wed, 16 Sep 2026 08:47:33 -0300
Message-ID: <20260916114740.48230-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916114740.48230-1-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A profile recorded on a kernel that is no longer installed, be it
because the machine was rebooted into a new kernel or because the
profile is being processed on another machine, can't have its kernel
symbols resolved: /proc/kallsyms matches the running kernel, not the
one in the profile, and is refused when restricted, e.g. with
kernel.perf_event_paranoid > 1, while the build-id cache may carry
just a kallsyms copy with zeroed addresses.  With no kernel symbols
the kernel samples can't be annotated, so they all end up in the
'(unknown)' data type and the kernel is missing from the data type
profile JSON "dsos" entry.

As a last resort, when the kernel symbols can't be found locally and
the user didn't specify a kallsyms file, fetch the vmlinux keyed by
the kernel build ID recorded in the perf.data file using the
debuginfod client and use it for symbols, which also provides the
DWARF debuginfo needed for data type profiling.

The fetch is made with dso->lock dropped, the same way dso__debuginfo()
does it for the debuginfo of a DSO, and the fetched file is loaded with
the lock held again, only if another thread didn't get the symbols in
the meantime, checked with dso__has_symbols(): dso__loaded() is set by
dso__load() even for an attempt that failed, and would make a successful
fetch throw the file away.

Like the other vmlinux sources this honors --ignore-vmlinux and
--ignore-vmlinux_buildid: a fetched vmlinux is still a vmlinux, and
the fetch is keyed by the build ID, so both flags skip it.  'perf
record' sets ignore_vmlinux_buildid internally, and so does 'perf
probe' for the commands other than --list, --del and --add when given
an offline vmlinux, keeping those away from the fetch as well.  A
'perf probe' that doesn't set it, e.g. --funcs or --add without
--vmlinux on a system with a restricted /proc/kallsyms, can have the
kernel debuginfo fetched, like the other tools.  The fetch itself
follows the opt-out controls added in the previous patch,
--no-debuginfod, core.debuginfod=false and the build-id-cache-is-off
case, and can be skipped with the 's'/'d' keys while it runs.  Build
IDs that were a miss are remembered, not queried again on every
dso__load() retry.

With a profile recorded on a system running kernel 7.1.10, later
processed after it was upgraded to 7.1.13, 'perf report -s type
' went from having all 24.91% of the kernel samples as
'(unknown)' data types to resolving struct task_struct, struct rq,
struct tty_struct, struct qspinlock, etc, with the kernel DSO, keyed
by its build ID, appearing in the data type profile JSON.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1d70c43bb24ee279..ccb6217119416dec 100644
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
@@ -2191,12 +2192,33 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	return strdup(path);
 }
 
+/*
+ * Last resort when the symbols for the kernel the profile was recorded
+ * on can't be found locally: fetch the vmlinux keyed by the build ID
+ * recorded in the perf.data file using the debuginfod client, which
+ * checks its local cache first, e.g. when processing the profile on
+ * another machine or after the kernel and its debuginfo package got
+ * upgraded in between.
+ */
+/*
+ * The fetch itself, that dso__load_kernel_sym() calls with dso->lock
+ * dropped, see the comment there.
+ */
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
@@ -2215,6 +2237,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	 */
 	if (symbol_conf.kallsyms_name != NULL) {
 		kallsyms_filename = symbol_conf.kallsyms_name;
+		user_kallsyms = true;
 		goto do_kallsyms;
 	}
 
@@ -2257,7 +2280,53 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	free(kallsyms_allocated_filename);
 
-	if (err > 0 && !dso__is_kcore(dso)) {
+	/*
+	 * The kallsyms may be unavailable or restricted, e.g.
+	 * /proc/kallsyms with kernel.perf_event_paranoid > 1, try to fetch
+	 * the vmlinux keyed by the build ID using debuginfod as a last
+	 * resort, honoring --ignore-vmlinux and --ignore-vmlinux_buildid
+	 * like the other vmlinux sources above.
+	 */
+	if (err <= 0 && !user_kallsyms &&
+	    !symbol_conf.ignore_vmlinux &&
+	    !symbol_conf.ignore_vmlinux_buildid) {
+		char *fetched_path = NULL;
+
+		/*
+		 * dso__load() holds dso->lock while it calls us, and the
+		 * fetch below can take a long time, blocked on the network
+		 * or on the terminal, waiting for the user: do it with the
+		 * lock dropped, as dso__debuginfo() does for the debuginfo
+		 * of a DSO, so that the threads that need this dso don't get
+		 * stuck behind a server round trip.  Nothing of the dso is
+		 * touched by the fetch, the symbols are loaded with the lock
+		 * held again, and only if the fetch brought a file back.
+		 */
+		mutex_unlock(dso__lock(dso));
+		err = dso__fetch_vmlinux_build_id(dso, &fetched_path);
+		mutex_lock(dso__lock(dso));
+
+		if (err) {
+			zfree(&fetched_path);
+		} else if (dso__has_symbols(dso)) {
+			/*
+			 * Somebody else got the symbols for this dso while
+			 * the lock was dropped for the fetch, use those
+			 * instead of loading the file that came back a
+			 * second time.  dso__has_symbols() and not
+			 * dso__loaded(): dso__load() sets the latter even
+			 * when it fails, so an attempt that failed would
+			 * have us throw a file that came back away.
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

