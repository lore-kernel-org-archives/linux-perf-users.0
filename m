Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C033A008;
	Fri, 30 Jan 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760760; cv=none; b=McZ5aXeIh2qRKMx72C0FjTsc9epf//s3lDF0y3cBaevYaRgZ4st3GL9io97EVy7ESYy5kQTKtNBWIvuY7etIqB8NbJs+eQP2JjvD9xuv4p9VZV63963O1/jzWyeAhhqveJtpki6Hu/f5tIWo229xRLZnWndWwnL+t+LmCLiPkiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760760; c=relaxed/simple;
	bh=SVIpyXH+J9AE9HD2uV+44XeBjo93Rh+rKl/Xx9W0N44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNDSkn9XBvTR7yhVIaDmj7QZlvHpsv7dlTUArrrzPn+oJc9wY1SDKnd0hFdq0r60KMRZ1nCI4N9IQKEmuh6Sk5dI2+8jXMb7aCQI47wv0pLRxFn21AQVFchm8wm7N8uk1SUQdbxmd0YAzk0FgCfwDCYkuf/CByE4nY30ux8Hzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnYZruIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnYZruIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF26CC4CEF7;
	Fri, 30 Jan 2026 08:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769760760;
	bh=SVIpyXH+J9AE9HD2uV+44XeBjo93Rh+rKl/Xx9W0N44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnYZruITU6BewYdgCyONA7nF16LHJ9BEiteGJ7qNmUChebq9M7KTtD0ZB/UUVzQTs
	 FgOBrBQiB+WD41cEbYIFPrcEPdlkUERaw1kVfB/mXOEWzluE1Z45katipRmpf+RRLF
	 7j8mdwlDXhQso0oynergeKBM+8a+RuGdE54lcgYUPFjlzgP8OkChtTJ1jx20SsUnrY
	 IA73dk0WxQFIqbMih7eX1asNHKjpWQGJI4V7wKQdKIC+sDsqQvZZzsUBJemzTOHLA9
	 KSpBpVP577Rv9IdNE1mGhFKszumQLeJwSykmAIJNeUbz8yI5+V+5fXSbRsILE4I1f2
	 KD6mI+MHBVqlQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for sleepable program tailcalls
Date: Fri, 30 Jan 2026 09:12:08 +0100
Message-ID: <20260130081208.1130204-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130081208.1130204-1-jolsa@kernel.org>
References: <20260130081208.1130204-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that makes sure we can't mix sleepable and non-sleepable
bpf programs in the BPF_MAP_TYPE_PROG_ARRAY map and that we can do
tail call in the sleepable program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 74 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_sleepable.c  | 43 +++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 0ab36503c3b2..7d534fde0af9 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -8,6 +8,7 @@
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
+#include "tailcall_sleepable.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1653,6 +1654,77 @@ static void test_tailcall_failure()
 	RUN_TESTS(tailcall_fail);
 }
 
+noinline void uprobe_sleepable_trigger(void)
+{
+	asm volatile ("");
+}
+
+static void test_tailcall_sleepable(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct tailcall_sleepable *skel;
+	int prog_fd, map_fd;
+	int err, key;
+
+	skel = tailcall_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_sleepable__open"))
+		return;
+
+	/*
+	 * Test that we can't load uprobe_normal and uprobe_sleepable_1,
+	 * because they share tailcall map.
+	 */
+	bpf_program__set_autoload(skel->progs.uprobe_normal, true);
+	bpf_program__set_autoload(skel->progs.uprobe_sleepable_1, true);
+
+	err = tailcall_sleepable__load(skel);
+	if (!ASSERT_ERR(err, "tailcall_sleepable__load"))
+		goto out;
+
+	tailcall_sleepable__destroy(skel);
+
+	/*
+	 * Test that we can tail call from sleepable to sleepable program.
+	 */
+	skel = tailcall_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_sleepable__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.uprobe_sleepable_1, true);
+	bpf_program__set_autoload(skel->progs.uprobe_sleepable_2, true);
+
+	err = tailcall_sleepable__load(skel);
+	if (!ASSERT_OK(err, "tailcall_sleepable__load"))
+		goto out;
+
+	/* Add sleepable uprobe_sleepable_2 to jmp_table[0]. */
+	key = 0;
+	prog_fd = bpf_program__fd(skel->progs.uprobe_sleepable_2);
+	map_fd = bpf_map__fd(skel->maps.jmp_table);
+	err = bpf_map_update_elem(map_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	skel->bss->my_pid = getpid();
+
+	/* Attach uprobe_sleepable_1 to uprobe_sleepable_trigger and hit it.  */
+	opts.func_name = "uprobe_sleepable_trigger";
+	skel->links.uprobe_sleepable_1 = bpf_program__attach_uprobe_opts(
+						skel->progs.uprobe_sleepable_1,
+						-1,
+						"/proc/self/exe",
+						0 /* offset */,
+						&opts);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_sleepable_1, "bpf_program__attach_uprobe_opts"))
+		goto out;
+
+	uprobe_sleepable_trigger();
+	ASSERT_EQ(skel->bss->executed, 1, "executed");
+
+out:
+	tailcall_sleepable__destroy(skel);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1707,4 +1779,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_freplace();
 	if (test__start_subtest("tailcall_failure"))
 		test_tailcall_failure();
+	if (test__start_subtest("tailcall_sleepable"))
+		test_tailcall_sleepable();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_sleepable.c b/tools/testing/selftests/bpf/progs/tailcall_sleepable.c
new file mode 100644
index 000000000000..d959a9eaaa9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_sleepable.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_test_utils.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps");
+
+SEC("?uprobe")
+int uprobe_normal(void *ctx)
+{
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("?uprobe.s")
+int uprobe_sleepable_1(void *ctx)
+{
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+int executed = 0;
+int my_pid = 0;
+
+SEC("?uprobe.s")
+int uprobe_sleepable_2(void *ctx)
+{
+	int pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	executed++;
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.52.0

