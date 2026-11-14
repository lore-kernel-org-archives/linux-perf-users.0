Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615534;
	b=uOtNF2Z+id7NuLSHEqgkqm8CrYM3h5qI1k57wZ7eumCibkNDkztTFFZVe4mzOSmGtIMp
	 DxriXte9j2mPReeZjwtV0jiteu9oAVWrFn+GCxzj8Tdncxh4qiuNyCc5vJ5BpY0ZjsqCg
	 4X0TkxRAlLmerOV3DvQD6Fszx0MTbrQAp58aPgylnl4yyQsGxoZD3jfssHWzpm97OttQN
	 xw48vOVtlcqkJXX9DBTcucZU9oFqAGZJorSB+AxW92KdphHXQkhJ2h13KahpNPvokfAi/
	 Pn4Rsj85LsUC59Zgt39tSnEFG3I4963AKYBFYpqDtGbB8yjVgVv2r/5YrF0IH1+j5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EL9gN+j85p/bUq8NOP88n+8iwVVIzyUDQlbjaBLzbvs=;
	b=gE75pzRoLLbLLBkY4t3jkKxQlmxLlbxJsegK0551t/UXF+ebgbqmIWWan5/qa00eM28V
	 n6U+fpopg334Q86LetwZpZjbBtHMgb8l16k4+6btsCgXCqceplaCZM5nESwg35hD5OETN
	 em+DyIoKfij/K4dgQWh4bMRwOeRVdphil7+o7PeTfgQxwaZLCUxJLIACplflDXN90hzPe
	 19bfd7/KRig1Zhh14rao2YSSEnERD02LjliuBlMiUIX/C+8sUEm06dHvBa1DbWx5XFB52
	 PwCZG6a2Fa7AYz/7rduj8rNB/lEaIBQ1mWkNlagINTkbJ6Yq06XStjlmF2XKTDWxMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmnEL4xB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A34606A33A;
	Sat, 14 Nov 2026 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmnEL4xB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B701F000C5;
	Sat, 14 Nov 2026 00:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615533;
	bh=EL9gN+j85p/bUq8NOP88n+8iwVVIzyUDQlbjaBLzbvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmnEL4xBtnSs9MrvKX4I3L2wcgnhU+EVL3BbLD2acZ2pStzfSUAZeCXj4lMd9qBep
	 wCQO7HuLIVgHsvQZu9xTWrryw3VVb+vFIBhnhynRPNb5Ue/Ve1I7tO8HmSEoihQemc
	 D9u26kFfr3+7fRMBG4M6BpOCLE9+7RHuWp/w4Zr7lr4XepUr4C2QuXpJVhcExMwXRv
	 2NELQjdE0E9rLOjDSXezLDfRFsuF6GXS7xn2sFYWYPzX9vR2bkR7LEfOAATY8Xmw6A
	 6rgnqJX23GbORci1QfWZZUKj6IHewx6JUKgcccBpm5CuTYeUeJR3APaK2o0/FOpNBc
	 /PYq7pNncFMww==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	peterz@infradead.org,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add stacktrace_ips test for tracepoint
Date: Fri, 13 Nov 2026 16:18:45 -0800
Message-ID: <20261114001846.873499-3-andrii@kernel.org>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261114001846.873499-1-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tp subtest that checks the stack captured by bpf_get_stack()
from a tracepoint program, recorded only for the test's own process.
Depending on static calls and inlining, the stack may or may not have
__traceiter_bpf_testmod_test_read in front of bpf_testmod_test_read,
so accept both. Also check that the entry after it differs: kernels
without commit 6d08340d1e35 ("Revert "perf/x86: Always store regs->ip
in perf_callchain_kernel()"") report the tracepoint's caller twice.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 54 +++++++++++++++++++
 .../selftests/bpf/progs/stacktrace_ips.c      | 13 +++++
 2 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index da42b00e3d1f..a03d4c10c469 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -137,6 +137,58 @@ static void test_stacktrace_ips_raw_tp(void)
 	stacktrace_ips__destroy(skel);
 }
 
+static void test_stacktrace_ips_tp(void)
+{
+	__u64 traceiter_addr, read_addr, *ips;
+	struct stacktrace_ips *skel;
+	struct ksyms *ksyms = NULL;
+	struct ksym *ksym;
+	int i;
+
+	skel = stacktrace_ips__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
+		return;
+
+	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+		test__skip();
+		goto cleanup;
+	}
+
+	skel->bss->my_pid = getpid();
+
+	skel->links.tp_test = bpf_program__attach(skel->progs.tp_test);
+	if (!ASSERT_OK_PTR(skel->links.tp_test, "bpf_program__attach"))
+		goto cleanup;
+
+	trigger_module_test_read(1);
+
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
+		goto cleanup;
+	traceiter_addr = ksym_get_addr_local(ksyms, "__traceiter_bpf_testmod_test_read");
+	read_addr = ksym_get_addr_local(ksyms, "bpf_testmod_test_read");
+
+	/*
+	 * Depending on static calls and inlining, __traceiter_bpf_testmod_test_read
+	 * may or may not be in front of bpf_testmod_test_read.
+	 */
+	ips = skel->bss->tp_ips;
+	ksym = ksym_search_local(ksyms, ips[0]);
+	if (!ASSERT_OK_PTR(ksym, "ksym_search_local"))
+		goto cleanup;
+	i = ksym->addr == traceiter_addr ? 1 : 0;
+
+	ksym = ksym_search_local(ksyms, ips[i]);
+	if (!ASSERT_OK_PTR(ksym, "ksym_search_local"))
+		goto cleanup;
+	ASSERT_EQ(ksym->addr, read_addr, "stack_cmp");
+	ASSERT_NEQ(ips[i], ips[i + 1], "stack_dup");
+
+cleanup:
+	free_kallsyms_local(ksyms);
+	stacktrace_ips__destroy(skel);
+}
+
 static void test_stacktrace_ips_kprobe(bool retprobe)
 {
 	LIBBPF_OPTS(bpf_kprobe_opts, opts,
@@ -238,6 +290,8 @@ static void __test_stacktrace_ips(void)
 		test_stacktrace_ips_kprobe_multi(true);
 	if (test__start_subtest("raw_tp"))
 		test_stacktrace_ips_raw_tp();
+	if (test__start_subtest("tp"))
+		test_stacktrace_ips_tp();
 	if (test__start_subtest("kprobe"))
 		test_stacktrace_ips_kprobe(false);
 	if (test__start_subtest("kretprobe"))
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_ips.c b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
index 6830f2978613..df10ef3cb14d 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -53,6 +53,19 @@ int rawtp_test(void *ctx)
 	return 0;
 }
 
+__u64 tp_ips[128];
+int my_pid;
+
+SEC("tp/bpf_testmod/bpf_testmod_test_read")
+int tp_test(void *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != my_pid)
+		return 0;
+
+	bpf_get_stack(ctx, tp_ips, sizeof(tp_ips), 0);
+	return 0;
+}
+
 SEC("fentry/bpf_testmod_stacktrace_test")
 int fentry_test(struct pt_regs *ctx)
 {
-- 
2.53.1-Meta

