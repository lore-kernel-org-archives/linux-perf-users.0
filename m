Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046480;
	b=sUKRwEnVyvbU7BwDRIKY1mkXUEouXK1CBPLaUkWfhdhpq3pHVGftX8MG58ZiqaHEsEcQ
	 kQIYd1oa7pzkpdNE51GF0anVA9AyS7Xes2QJQNj8HdXqpDQPG/mY76xzD1VczmhjeJPdQ
	 dt07I2A2GTsMkdhNhxYep8pO+49Y4B7fzkpfyGpopYUeS1CqX0eNt68PiMP+uwkXi9tuB
	 dpGLvWixKfN1IvFWGITwINOclMPFD8IBhuS857wD9JOSC26Lrrq7K8SqkkigYhuZ40Hiz
	 0zPp6KlFfbGnBC54I4CeNShVjrkPzVcmp1zhEEEKJ65AJFmB9QJt8wAoF4Q4GqSp9VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vBa2LoiHOC2KUzAPtZVR+UUBl+9h4HXK3vbl3+RRPeU=;
	b=EkOgaMEJVApf8RM2honYR2CI61zYglloACraIjgb+duyaViomyVfamJmFewkm+BIiA83
	 1+xpRRXmtG1OYL1uAWKH4qicg7JdfnHKinVOTVAs7kLs07AKpf45cTufar+lelrENDqXK
	 1YDKrktMjH6i0pSeZFbdhCTRLxJid7L7vUpbcD9C9wLz2T5qDnspaLCxUTOUp+X8yzjVO
	 AtFNKnMkbqFLbnTvcxgUn5jwRdUNEiIs+4oM6hQE+vX3i/TNFsBxocQHjqDCZKqr+mae2
	 NWHG5YqbGPn9kIbcqLU5GmBu/1Ts3HeIvAJb+GRKOgXd+J78aVOsMriIgIzpf78CC1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eNI/M99B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A95606A32A;
	Thu, 19 Nov 2026 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNI/M99B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B471F000C5;
	Thu, 19 Nov 2026 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046480;
	bh=vBa2LoiHOC2KUzAPtZVR+UUBl+9h4HXK3vbl3+RRPeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eNI/M99BIDIlUC75PAQYCdwl/XP4M6UBNmL7WYoAfeZMFLAegILP/AQw0JzM1T3ua
	 VpSrYS3wuipAiNH1vr53/K3VJjqVHEv0WSlBxJroT50I0VXyRHzw2w6bZoVHsqvDdS
	 r88sH9kUDmGNYLzsUZLMfgKR/JY3M7bsGdjDJNnccvShl1W2HSWC6iTylRgeL6ROE4
	 iFwbfdzkg/hNhj24JKd4L04oYvxsHO3GIBA5OK7VQse/lYXOAzICDI9xiKjt5UqkVK
	 KVcH6/9lbiYn8YwBge2CilqUg2ew54HjJMmqd/QtMbJcd9t2cVQSR/YRRqM17LTGm2
	 sRWUZy2Bkh1UQ==
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
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Add stacktrace_ips test for tracepoint
Date: Wed, 18 Nov 2026 16:01:11 -0800
Message-ID: <20261119000112.2377949-3-andrii@kernel.org>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119000112.2377949-1-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org>
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
so accept both. Also check that the entry after it differs: x86
kernels without commit 6d08340d1e35 ("Revert "perf/x86: Always store
regs->ip in perf_callchain_kernel()"") report the tracepoint's caller
twice.

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

