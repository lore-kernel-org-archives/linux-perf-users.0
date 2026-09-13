Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CC377018;
	Sun, 13 Sep 2026 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266920; cv=none; b=j6wcctCA7V0TzbtBmgD3CKns0pXJkvtTCJtlNNNFfH1563fAOSLIGDmELYKWaCicj/1o2h7sAEdhxYZeRX+FNDeJQQ9QWBoSyhxOkWZ1lQm+qGrJcmWRJFKIFQOsHCb7peKQuR0ylqtK7ockUWS5XQRZyhJeN4rM7k+VAxun38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266920; c=relaxed/simple;
	bh=umCP/qgrVnxyElaKvm3al8FhdPn6/FsWKk5qdK2SIjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/DdekJ2wLOHigX+CosAqYEv3onM7RsXlZI5/9QvX+rwjlxEFKqgR0hpU6l2d/1wAWlVCoyV84SBWrshrV0KPB318FNdvXUU1MCn8/GyVMxQLrEtI8gaNpmN8D9stjoeqpU3YUIGEp55vqUGWmR1opwRUlLFe9mConiKSt8xx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuPe4v7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuPe4v7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5631F00893;
	Sun, 13 Sep 2026 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789266919;
	bh=u5GMt6vY0jglGlXzwWD2zIuvcCVQLm23wFgQR0bYX08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuPe4v7ULZ3hvzwxE01lpO7DYApktSJ8lRprbOU7Bhdr0Fbzxd0v0va/C0+bJlA4e
	 05oscKPIHjMSQziySQHU4GQg4vKI3gDL5h4Yrm9wkeKjNHIpeFlxbkFa5KYPP+QY1j
	 BbCEHrWoEoHbxIjpWwNr3sd9rOUsoHxaFDcQ0D5n/DKeNqIi1/0pJ6S9YHw/pRbmwO
	 aZFHiMbKpTfeBut7617rqbFeP9rTmpoIzSSUWXc/EizQN0YDQuwsz8AbMu313zcujj
	 Q3AW2PW+CbynMzm8DWE2FmO+JpTv6PeD0bEXbv+W8X2LcKWB9ZmbRJss2cR8RRCtul
	 e7ts5jTMBYonw==
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
Subject: [PATCH v1 3/8] perf symbol: Fall back to fetching the vmlinux by build ID
Date: Sat, 12 Sep 2026 23:34:54 -0300
Message-ID: <20260913023459.112654-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913023459.112654-1-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
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

Like the other vmlinux sources this honors --ignore-vmlinux and
--ignore-vmlinux_buildid: a fetched vmlinux is still a vmlinux, and
the fetch is keyed by the build ID, so both flags skip it, keeping
'perf record' and 'perf probe', that set ignore_vmlinux_buildid
internally, away from it.  The fetch itself follows the opt-out
controls added in the previous patch, --no-debuginfod,
core.debuginfod=false and the build-id-cache-is-off case, and can be
skipped with the 's'/'d' keys while it runs.  Build IDs that were a
miss are remembered, not queried again on every dso__load() retry.

With a profile recorded on a system running kernel 7.1.10, later
processed after it was upgraded to 7.1.13, 'perf report -s type
' went from having all 24.91% of the kernel samples as
'(unknown)' data types to resolving struct task_struct, struct rq,
struct tty_struct, struct qspinlock, etc, with the kernel DSO, keyed
by its build ID, appearing in the data type profile JSON.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b1a2684c813c5d8d..034e11e75bb94999 100644
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
@@ -2191,12 +2192,35 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
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
+static int dso__load_vmlinux_build_id(struct dso *dso, struct map *map)
+{
+	char *path = NULL;
+
+	if (!dso__has_build_id(dso))
+		return -1;
+
+	if (debuginfo__find_build_id(dso__bid(dso), &path))
+		return -1;
+
+	/* Takes ownership of 'path' even when it fails */
+	return dso__load_vmlinux(dso, map, path, true);
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
@@ -2215,6 +2239,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	 */
 	if (symbol_conf.kallsyms_name != NULL) {
 		kallsyms_filename = symbol_conf.kallsyms_name;
+		user_kallsyms = true;
 		goto do_kallsyms;
 	}
 
@@ -2257,7 +2282,18 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
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
+		err = dso__load_vmlinux_build_id(dso, map);
+	} else if (err > 0 && !dso__is_kcore(dso)) {
 		struct maps *kmaps = map__kmaps(map);
 
 		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
-- 
2.55.0

