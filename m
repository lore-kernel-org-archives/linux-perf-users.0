Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756842BC28;
	Mon, 10 Aug 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380426; cv=none; b=L5TUWPZ1pw7eBc3Zu/xtgNNAybPzfyYZcZv7i6eKvFE+fOHx/JgrPFDiVFLlUG512c06qlR0KqWZTA567Qdc0VAOprifTHeBjJ62G2Y1H+/SDOdKb3bVkSV59mp9u57ncVDb9Ua5MQ79viTZZsD4u+vo4AufySycXEI65uyy8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380426; c=relaxed/simple;
	bh=XwTPSqp1L7Rwrtp4t0Hcgc8WyyKNr3Em0C4DCNaz59M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgz9JRFiGUOCkvI7+2OcQhLiIi4C0J0PdlkLvToYWohXm7ejIWkWTe4lbKBTzRLB3ZjZQ7z/gVy1Ru1VJU9OCtn/KUG1Yk89hlhxdoJxUnfkA2B+Df6e/XYOkx7zjEMisCe1hIjFbk8TQU5CpAMKViSZQWmfN8xDhiXgrgR5DI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TniOiPeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TniOiPeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A41F00A3D;
	Mon, 10 Aug 2026 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786380422;
	bh=sEvl1i/8v8mimTmquA8RacZ4H8SQz2jDVrPg8tx+M6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TniOiPePfVaZodNOV9iJWd6S3f3NHKO8b4eIsiodgDfRSxvCE30G4S02fyqCaN1OG
	 VxJAY7nOSmg2EqVtc6s0ZnxyEOG1bdntN8RmJYQKS0btMkrBbWbN8QbiHr/gDCUAk7
	 OUjeZNLgB/zuhjJy6YYRGUC4uWdhGEtNo/WDTQJUXSU05gJRzEwQyoRXi7UH8fzmEa
	 8xmsTT0qlthnpTg8FZGWMsHE4sQuOM1z6WCspx0Z+l1yu4ljc97nAy7NvJXJ4r1MOH
	 GADo7DAQ30kYCIlH2jWISpwU1TdDlXWIFXpvaQPij4p1gsKQtMnw0OPZCTVOLUbKR+
	 YRQZfaaNzs5BA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	bpf@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v6 3/3] selftests/bpf: Adjust entry thresholds for ARM64 BRBE
Date: Mon, 10 Aug 2026 09:46:20 -0700
Message-ID: <20260810164622.1829843-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810164622.1829843-1-puranjay@kernel.org>
References: <20260810164622.1829843-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test bounds how many branch entries are spent reaching the snapshot
helper. The limit of 10 was calibrated on x86, which spends about 7.

arm64 spends up to 14: eight in the BPF trampoline, which makes
out-of-line calls and branches more than x86 does, and the rest in
masking exceptions before the branch buffer can be paused.

Raise the limit to 18 on arm64, leaving room for compiler and
configuration variation.

The skip threshold has to move with it. BRBE implements 8, 16, 32 or 64
records, so on a 16 record buffer the existing 'total_entries < 16'
check does not skip, but 14 wasted entries leave only 2 for the hit test
and it fails instead. Derive the minimum from the two limits it depends
on, so the arms cannot drift apart.

This leaves 8 and 16 record implementations skipped, since the required
hit count is absolute and does not scale with the buffer.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/prog_tests/get_branch_snapshot.c      | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 0394a1156d99d..e06ae6798dbec 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -108,21 +108,29 @@ void serial_test_get_branch_snapshot(void)
 
 	trigger_module_test_read(100);
 
-	if (skel->bss->total_entries < 16) {
+	/* Reaching the snapshot helper costs a few entries: about 7 on x86_64
+	 * and about 14 on arm64, whose BPF trampoline branches more. Bound it
+	 * so that a regression shows up here.
+	 *
+	 * Derive the buffer minimum from the two limits it depends on, so the
+	 * arms cannot drift apart.
+	 */
+#if defined(__aarch64__)
+#define WASTED_ENTRIES_MAX	18
+#else
+#define WASTED_ENTRIES_MAX	10
+#endif
+#define TEST1_HITS_MIN		7
+#define TOTAL_ENTRIES_MIN	(WASTED_ENTRIES_MAX - 1 + TEST1_HITS_MIN)
+
+	if (skel->bss->total_entries < TOTAL_ENTRIES_MIN) {
 		/* too few entries for the hit/waste test */
 		test__skip();
 		goto cleanup;
 	}
 
-	ASSERT_GT(skel->bss->test1_hits, 6, "find_looptest_in_lbr");
-
-	/* Given we stop LBR in software, we will waste a few entries.
-	 * But we should try to waste as few as possible entries. We are at
-	 * about 7 on x86_64 systems.
-	 * Add a check for < 10 so that we get heads-up when something
-	 * changes and wastes too many entries.
-	 */
-	ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
+	ASSERT_GT(skel->bss->test1_hits, TEST1_HITS_MIN - 1, "find_looptest_in_lbr");
+	ASSERT_LT(skel->bss->wasted_entries, WASTED_ENTRIES_MAX, "check_wasted_entries");
 
 cleanup:
 	get_branch_snapshot__destroy(skel);
-- 
2.53.0-Meta

