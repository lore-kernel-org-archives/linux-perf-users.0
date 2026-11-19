Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046484;
	b=TqGRtKhiMUSt+kZn7aKlPtohOFegg9iWsurdy8jB18qJgkTmhpsFIYDYVELjfuFVSoMX
	 9+mwT6nFbPW37mTdc4fsXfrAtZx9kN7EKK/jWVobNHRl9U4VGDTeymWBWk635kyYjvxTj
	 tOWsiSuuyAge2rrmIB7x8wDm2490JGV2N953Q4/a1htUtYjh9yOdXNnB3cavoHWVaYG7a
	 cct2dwknG+ICkCwa58GkawQSYU60gl/TIsyQeLA8tMUrrlxVVxn7DZcumyYQihpeuvQ3R
	 P85tlWYofy7ALG5eFbWfsYye7GxM0L4ruyJ6TclnyWAieeDfNxf8xxTeZClm3D1LiIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046484;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BDgkQRI+JQ6/3Xe6aC3pArUDoRD90RfmWAAnosSnIDI=;
	b=jHXmX1XfT6c7sI6zih314RB9Ho4YJmEFfOwjsMnm6+kNrm00d2Tou66htnQkJVIuJV9p
	 i75OYhJ0bk2scVmJpmAkScofGcjAbXKNukpDsomBsrKg4U73RKDkgom+x8lc/JZPAKtib
	 h9Dnyp4o3SWMQYsGxXcmvVTA44kknb3QyxgnKOYZRsR41PODRpzaY8TEw8rMJL24gIwyW
	 iWK88Dd/yoKo9W/UqF5VVBQFdEbYNy36O6a++DyM+LzxvCHwgiEksvRYPGgqWByfXouHn
	 T0Gd7HCDyLZKVn6bEB7QNwSiYssgAzeSvd3MhgyQhAF/HgarPp7WZv0XFDQDWT2fpuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoI86i7F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F65606A325;
	Thu, 19 Nov 2026 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoI86i7F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994211F000CA;
	Thu, 19 Nov 2026 00:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046483;
	bh=BDgkQRI+JQ6/3Xe6aC3pArUDoRD90RfmWAAnosSnIDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AoI86i7F3japdZ6N18MULTKUyPichZVZ9seADer6xMnKtKWcfV6b+aXpsjF9KHXef
	 px/Md5PhzmjK9mLUrxSBYsGSdG+tDR1/jO0xR+MX4GB6DvlnO2OUwPMlVskg01+oQl
	 3cGiTLzmN67ZJ33oeyKuN/qNsEnGNuDRw7u2eO7qNjaBerPs/feoN3tOFqCfEY0GdQ
	 /bepLjtBVt22Av95Pcheiq0Qg5uM/yU0eKLm05cbSjlXg17bFWXwNugpb1X1YAtEll
	 bPgscaUx8x7wPpaCQrsbN+8ieYlTZdxRKTtOSinfGSTVgaOgTus0POiP7c/ZVBbGDs
	 LRaPXgGc396tA==
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Run stacktrace_ips raw_tp, tp and fentry tests on arm64
Date: Wed, 18 Nov 2026 16:01:12 -0800
Message-ID: <20261119000112.2377949-4-andrii@kernel.org>
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

The raw_tp, tp and fentry subtests check stacks unwound from
perf_fetch_caller_regs() regs. Now that arm64 perf_callchain_kernel()
skips regs->pc of such regs and no longer reports the caller twice,
run these subtests on arm64 as well, where kernel stacks are always
unwound through frame records.

Leave the kprobe, kretprobe, kprobe_multi, kretprobe_multi and fexit
subtests x86-only: on arm64, kprobes at function entry miss the probed
function's caller, and fexit stacks have an extra entry for the traced
function. The kretprobe subtests pass on arm64, but don't use
perf_fetch_caller_regs() regs.

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

