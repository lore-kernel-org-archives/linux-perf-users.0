Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615537;
	b=T0ebhMj9Zd2Hvu29HRcvvaxMBD+aFzQrZJ4Lu4NYTjnwvNKcdkEz+LE7JPcxm90yrDBY
	 JLwzvkMngM5zn4Belk3E+8S7nyT1BMTX0JOp7RilKsEss1wm6x0CNLIYnCpwdPHp/s/NQ
	 XsYFNvdhguBuLN/UF7YyX0she01aEfyv2H6vp09Crrq4mTwlSbJDQeChYc3JexfTrwenG
	 AkVPGHJryXE2ll31ShuUUpdqioQcX3Lh4vSnqP716ll0glgVnRSeGDAlsRB0B2HEKEsrj
	 hngNlTcFVtU5IAj9xqlK94d6hs8uEVcu51inuSVHFpvxBcRlXPoull7ns4fcK7I6yOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uRzzNp8+l9gRwXTNApOrbQ44C8yLgFZjz1n5Da+b05s=;
	b=seZgpRuq0y9HCyN/ahMS9th3X94GgcOxMzBF7bX3GFqnAmusdBFqACgfB5r6s59ZNnTL
	 VEsgbrQ/3KwFcLUavbYV4lj9OJMSGkURmhd+J+UewtQoWoS/wXsPvQZq87jrAI4XVNJTW
	 HX2982Em1IpZ4G/thCI0pnIQuXqcY2f8iM1S9mocCEWctWzL/9oViw2nFyPGrzFM8/pT5
	 nGJ4S4otHVs+58sb9HocKuvWsNNG88xhs5tOoqFNN5XqNPJ/s1u7kDB3/ZFHHxluLC5IH
	 HHMIr0f1XDBWh34Ke3IVO4HLcoFXzHXARfo7SasPRFbRo9glsgExfidZRgsyLJ3srCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkW4NSW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF41606A32D;
	Sat, 14 Nov 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkW4NSW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C81F000C6;
	Sat, 14 Nov 2026 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615537;
	bh=uRzzNp8+l9gRwXTNApOrbQ44C8yLgFZjz1n5Da+b05s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkW4NSW9WlPAokFObd2LOJFvrs6xixuSNhcOIx/2/HjhvN/u0LTsSPZbHANtp+4gA
	 lWXKwDDMpvXyVo9WzDQuiq8dqiV7ep/lixs6vit1E2wr0AjX6FRg9krMJsgv+HDPQK
	 s+frX6kSsHcqARBHa0THR6HF3sFBLlHNt2ZvIx6HEX64WwRF61cl0K5H5+x60G61bN
	 x8lUBrzE8MMgGQwvYKYCrn/14J9MRtXSCVwLGDP0BxUHMyIhfEW0dD3ud1nu5GYi2S
	 BcDVpl27uAKYA54X9oJGpSOLhAr4YvaGtvC3XvLVx+8dbwUQNfNxgiES+MZN+sfvK9
	 B/XJKYG6yjPow==
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Run stacktrace_ips raw_tp, tp and fentry tests on arm64
Date: Fri, 13 Nov 2026 16:18:46 -0800
Message-ID: <20261114001846.873499-4-andrii@kernel.org>
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

The raw_tp, tp and fentry subtests check stacks unwound from
perf_fetch_caller_regs() regs, which arm64 reported with the caller
twice until perf_arch_fetch_caller_regs() was fixed. Run them on arm64
as well, where kernel stacks are always unwound through frame records.

Leave the kprobe and fexit subtests x86-only: on arm64, kprobes at
function entry miss the probed function's caller, and fexit stacks
have an extra entry for the traced function (kretprobe subtests pass,
but don't use these regs).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c     | 15 +++++++++++----
 .../testing/selftests/bpf/progs/stacktrace_ips.c  |  5 +++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index a03d4c10c469..aee46543f390 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include "stacktrace_ips.skel.h"
 
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 static int check_stacktrace_ips(int fd, __u32 key, int cnt, ...)
 {
 	__u64 ips[PERF_MAX_STACK_DEPTH];
@@ -47,6 +47,12 @@ static int check_stacktrace_ips(int fd, __u32 key, int cnt, ...)
 	return err;
 }
 
+/* arm64 always unwinds kernel stacks through frame records */
+static bool unwinder_ok(struct stacktrace_ips *skel)
+{
+	return skel->kconfig->CONFIG_UNWINDER_ORC || skel->kconfig->CONFIG_ARM64;
+}
+
 static void test_stacktrace_ips_kprobe_multi(bool retprobe)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
@@ -106,7 +112,7 @@ static void test_stacktrace_ips_raw_tp(void)
 	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
 		return;
 
-	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+	if (!unwinder_ok(skel)) {
 		test__skip();
 		goto cleanup;
 	}
@@ -149,7 +155,7 @@ static void test_stacktrace_ips_tp(void)
 	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
 		return;
 
-	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+	if (!unwinder_ok(skel)) {
 		test__skip();
 		goto cleanup;
 	}
@@ -244,7 +250,8 @@ static void test_stacktrace_ips_trampoline(bool retprobe)
 	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
 		return;
 
-	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+	/* on arm64, fexit stacks also have a frame for the traced function */
+	if ((retprobe && !skel->kconfig->CONFIG_UNWINDER_ORC) || !unwinder_ok(skel)) {
 		test__skip();
 		goto cleanup;
 	}
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_ips.c b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
index df10ef3cb14d..11dfebd4ddb2 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -19,14 +19,15 @@ struct {
 } stackmap SEC(".maps");
 
 extern bool CONFIG_UNWINDER_ORC __kconfig __weak;
+extern bool CONFIG_ARM64 __kconfig __weak;
 
 /*
- * This function is here to have CONFIG_UNWINDER_ORC
+ * This function is here to have CONFIG_UNWINDER_ORC and CONFIG_ARM64
  * used and added to object BTF.
  */
 int unused(void)
 {
-	return CONFIG_UNWINDER_ORC ? 0 : 1;
+	return CONFIG_UNWINDER_ORC || CONFIG_ARM64 ? 0 : 1;
 }
 
 __u32 stack_key;
-- 
2.53.1-Meta

