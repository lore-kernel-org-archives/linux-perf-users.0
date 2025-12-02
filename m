Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB23327BE5;
	Tue,  2 Dec 2025 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719847; cv=none; b=eckEDmODzt1GQV8lA9reFGeeVH4ZuZwvRbdsT4yEN85zzxZKfp8hhnZSGxHWX0Jpy6sKMga0q8tsSNxWzM9eeK2T9O/c7Tbovck8/hwNMzcrv8w6guBcauQKNUjSF3e41im4j3wipVURj3ibWXLIPFUccjT1m1BXbhS3LRPjGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719847; c=relaxed/simple;
	bh=/XSw61dSJeuyN3BJeRqKGEcNvMV3Mc8h4hSUAJiPy4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJexZ/BEwltea1QkroukOHewFWHGvhl0fRkw1OsGsgvkvdXdLvdh41oL7N0cvCa8Pxw996a4wFPcK0hc2EKQThIdigMMINKNwMZpDMajj+EWzM3YwOKco8Qu7rlwqGc0GRNs2ojt+c1lI9reULFwu6UQGY3mmGdB+ccGgMxZ/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqa51mF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqa51mF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709F0C16AAE;
	Tue,  2 Dec 2025 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764719847;
	bh=/XSw61dSJeuyN3BJeRqKGEcNvMV3Mc8h4hSUAJiPy4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aqa51mF6PfzNm9ryiTaT44ekTZek073EsGNuD4Pa+aG7OXtkjSiMwM32M+ug9rPOd
	 LWHhBVWrw5s8H609qPydW4QUN4AjzLxYcLbS562WHeqjaQcQ/12ow66rKyFrBWMOa3
	 JbnyH4VhpWiYA2AwVbmMC1XNRBbs2FejPSjbqZFJjlKp9VpJmyWZY5Y33pobs+zTkv
	 pLCoKZXShAbq0o76Tud5/pCe4mFKIHQghCPQNqPnmgxL6QnNTtKdW3t/6Jx9bZhbvQ
	 pRurcPnfBU0g6rqltkfPYy6Ep++FetVfe6OAlsZKujREB9Nd52+gwsF4FuZvW+IPE6
	 eIoocxtgPuzeA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 5/5] perf test: Add kallsyms split test
Date: Tue,  2 Dec 2025 15:57:18 -0800
Message-ID: <20251202235718.1018752-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202235718.1018752-1-namhyung@kernel.org>
References: <20251202235718.1018752-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a fake root directory for /proc/{version,modules,kallsyms} in
/tmp for testing.  The kallsyms has a bad symbol in the module and it
causes the main map splitted.  The test ensures it only has two maps -
kernel and the module and it finds the initial map after the module
without creating the split maps like [kernel].0 and so on.

  $ perf test -vv "split kallsyms"
   69: split kallsyms:
  --- start ---
  test child forked, pid 1016196
  try to create fake root directory
  create kernel maps from the fake root directory
  maps__set_modules_path_dir: cannot open /tmp/perf-test.Zrv6Sy/lib/modules/X.Y.Z dir
  Problems setting modules path maps, continuing anyway...
  Failed to open /tmp/perf-test.Zrv6Sy/proc/kcore. Note /proc/kcore requires CAP_SYS_RAWIO capability to access.
  Using /tmp/perf-test.Zrv6Sy/proc/kallsyms for symbols
  kernel map loaded - check symbol and map
  ---- end(0) ----
   69: split kallsyms                                                  : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/Build            |   1 +
 tools/perf/tests/builtin-test.c   |   1 +
 tools/perf/tests/kallsyms-split.c | 156 ++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h          |   1 +
 4 files changed, 159 insertions(+)
 create mode 100644 tools/perf/tests/kallsyms-split.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index af67f8ef74b49c58..c2a67ce459417e0f 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -69,6 +69,7 @@ perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
+perf-test-y += kallsyms-split.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 9090e8238a447826..bd6ffa8e4578431a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -140,6 +140,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__symbols,
 	&suite__util,
 	&suite__subcmd_help,
+	&suite__kallsyms_split,
 	NULL,
 };
 
diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
new file mode 100644
index 0000000000000000..bbbc66957e5d0453
--- /dev/null
+++ b/tools/perf/tests/kallsyms-split.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include "util/dso.h"
+#include "util/map.h"
+#include "util/symbol.h"
+#include "util/debug.h"
+#include "util/machine.h"
+#include "tests.h"
+
+/*
+ * This test is to check whether a bad symbol in a module won't split kallsyms maps.
+ * The main_symbol[1-3] should belong to the main [kernel.kallsyms] map even if the
+ * bad_symbol from the module is found in the middle.
+ */
+static char root_template[] = "/tmp/perf-test.XXXXXX";
+static char *root_dir;
+
+static const char proc_version[] = "Linux version X.Y.Z (just for perf test)\n";
+static const char proc_modules[] = "module 4096 1 - Live 0xffffffffcd000000\n";
+static const char proc_kallsyms[] =
+	"ffffffffab200000 T _stext\n"
+	"ffffffffab200010 T good_symbol\n"
+	"ffffffffab200020 t bad_symbol\n"
+	"ffffffffab200030 t main_symbol1\n"
+	"ffffffffab200040 t main_symbol2\n"
+	"ffffffffab200050 t main_symbol3\n"
+	"ffffffffab200060 T _etext\n"
+	"ffffffffcd000000 T start_module\t[module]\n"
+	"ffffffffab200020 u bad_symbol\t[module]\n"
+	"ffffffffcd000040 T end_module\t[module]\n";
+
+static struct {
+	const char *name;
+	const char *contents;
+	long len;
+} proc_files[] = {
+	{ "version", proc_version, sizeof(proc_version) - 1 },
+	{ "modules", proc_modules, sizeof(proc_modules) - 1 },
+	{ "kallsyms", proc_kallsyms, sizeof(proc_kallsyms) - 1 },
+};
+
+static void remove_proc_dir(int sig __maybe_unused)
+{
+	char buf[128];
+
+	if (root_dir == NULL)
+		return;
+
+	for (unsigned i = 0; i < ARRAY_SIZE(proc_files); i++) {
+		scnprintf(buf, sizeof(buf), "%s/proc/%s", root_dir, proc_files[i].name);
+		remove(buf);
+	}
+
+	scnprintf(buf, sizeof(buf), "%s/proc", root_dir);
+	rmdir(buf);
+
+	rmdir(root_dir);
+	root_dir = NULL;
+}
+
+static int create_proc_dir(void)
+{
+	char buf[128];
+
+	root_dir = mkdtemp(root_template);
+	if (root_dir == NULL)
+		return -1;
+
+	scnprintf(buf, sizeof(buf), "%s/proc", root_dir);
+	if (mkdir(buf, 0700) < 0)
+		goto err;
+
+	for (unsigned i = 0; i < ARRAY_SIZE(proc_files); i++) {
+		int fd, len;
+
+		scnprintf(buf, sizeof(buf), "%s/proc/%s", root_dir, proc_files[i].name);
+		fd = open(buf, O_RDWR | O_CREAT, 0600);
+		if (fd < 0)
+			goto err;
+
+		len = write(fd, proc_files[i].contents, proc_files[i].len);
+		close(fd);
+		if (len != proc_files[i].len)
+			goto err;
+	}
+	return 0;
+
+err:
+	remove_proc_dir(0);
+	return -1;
+}
+
+static int test__kallsyms_split(struct test_suite *test __maybe_unused,
+				int subtest __maybe_unused)
+{
+	struct machine m;
+	struct map *map = NULL;
+	int ret = TEST_FAIL;
+
+	pr_debug("try to create fake root directory\n");
+	if (create_proc_dir() < 0) {
+		pr_debug("SKIP: cannot create a fake root directory\n");
+		return TEST_SKIP;
+	}
+
+	signal(SIGINT, remove_proc_dir);
+	signal(SIGPIPE, remove_proc_dir);
+	signal(SIGSEGV, remove_proc_dir);
+	signal(SIGTERM, remove_proc_dir);
+
+	pr_debug("create kernel maps from the fake root directory\n");
+	machine__init(&m, root_dir, HOST_KERNEL_ID);
+	if (machine__create_kernel_maps(&m) < 0) {
+		pr_debug("FAIL: failed to create kernel maps\n");
+		goto out;
+	}
+
+	/* force to use /proc/kallsyms */
+	symbol_conf.ignore_vmlinux = true;
+	symbol_conf.ignore_vmlinux_buildid = true;
+	symbol_conf.allow_aliases = true;
+
+	if (map__load(machine__kernel_map(&m)) < 0) {
+		pr_debug("FAIL: failed to load kallsyms\n");
+		goto out;
+	}
+
+	pr_debug("kernel map loaded - check symbol and map\n");
+	if (maps__nr_maps(machine__kernel_maps(&m)) != 2) {
+		pr_debug("FAIL: it should have the kernel and a module, but has %u maps\n",
+			 maps__nr_maps(machine__kernel_maps(&m)));
+		goto out;
+	}
+
+	if (machine__find_kernel_symbol_by_name(&m, "main_symbol3", &map) == NULL) {
+		pr_debug("FAIL: failed to find a symbol\n");
+		goto out;
+	}
+
+	if (!RC_CHK_EQUAL(map, machine__kernel_map(&m))) {
+		pr_debug("FAIL: the symbol is not in the kernel map\n");
+		goto out;
+	}
+	ret = TEST_OK;
+
+out:
+	remove_proc_dir(0);
+	machine__exit(&m);
+	return ret;
+}
+
+DEFINE_SUITE("split kallsyms", kallsyms_split);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f5fba95b6f3ffbd3..cb67ddbd03753531 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -178,6 +178,7 @@ DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
 DECLARE_SUITE(subcmd_help);
+DECLARE_SUITE(kallsyms_split);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.52.0.158.g65b55ccf14-goog

