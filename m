Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63D3FE660;
	Wed, 27 May 2026 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883971; cv=none; b=eGOO+77m+LGXW+bMx2+EhGjyM1RIUUhOCoO//+olG84tXPWN3cy4pFO66mTsFs0eO5KqQ4ccUpYzdv7xe+RbB1caKtEAFFwEMAyDCltuFvH8fxs60UtLhgAhwrPgSwP3S90ts0lBhg5BKF+x5eQSU4qrIwa5RbXupbtk4J5PeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883971; c=relaxed/simple;
	bh=xGU+zthPArmUciFE3I4/MTbw9lB8zAY6DEuEIIvSCT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXQgZ7f/Fyp4hk11osOfaPqeKPaQ9C1xTOHlFu9QOMvCdeAQXd7OYL8fLeDv5i582udG3Q64qV3oSU4jkMYUcpsU1RkbMWhyw9oPxwUE8gZP0qB18OZ5xo7NuT753hIP0LJ1mWeDF9IqqfSnyXLStQa1KLB36Ja6cJ40ciqLdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDnomG9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDnomG9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C511F000E9;
	Wed, 27 May 2026 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883970;
	bh=2I29sVWPGLqUjIDyjNAdYt3UxHapRuSjOGldiuvjnFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDnomG9T/2ke5Rv5/HWio2Pv40kda1zsQ4ipmwuz1tZU2N6mznX/nEB1PIRxVejpm
	 8MjwhVuv3sZafyTNpSVtn5o283JlpvGkKVt+T+w/bwjaC1kpKaUr8ZtLFNGONEQnhP
	 y83MWM+EwN4ovMGJjCuc4rvIGDZCAfEwHOyDOZz16Qv44uQ3f+gudgHHQqV7cz7xib
	 6Y2sgglGn272YMw5arS+W1mOnnAM/gWtFXT6O1CEBRogZtTdzdlGWvMB67WlaOwwKk
	 y4azC2jo+CqXj3t3MN2whp0jecPR8xQxiQh6xxRI7/XLrypTkynAirbPivYfTBnGwA
	 SwD0CwaSZUtMQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: [PATCH v4 4/4] selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
Date: Wed, 27 May 2026 05:12:00 -0700
Message-ID: <20260527121207.2312181-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527121207.2312181-1-puranjay@kernel.org>
References: <20260527121207.2312181-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_branch_snapshot test checks that bpf_get_branch_snapshot()
doesn't waste too many branch entries on infrastructure overhead. The
threshold of < 10 was calibrated for x86 where about 7 entries are
wasted.

On ARM64, the BPF trampoline generates more branches than x86,
resulting in about 13 wasted entries. The overhead comes from the BPF
trampoline calling __bpf_prog_enter_recur which on ARM64 makes
out-of-line calls to __rcu_read_lock and generates more conditional
branches than x86:

 [#12] bpf_testmod_loop_test+0x40    -> bpf_trampoline_...+0x48
 [#11] bpf_trampoline_...+0x68       -> __bpf_prog_enter_recur+0x0
 [#10] __bpf_prog_enter_recur+0x20   -> __bpf_prog_enter_recur+0x118
 [#09] __bpf_prog_enter_recur+0x154  -> __bpf_prog_enter_recur+0x160
 [#08] __bpf_prog_enter_recur+0x164  -> __bpf_prog_enter_recur+0x2c
 [#07] __bpf_prog_enter_recur+0x2c   -> __rcu_read_lock+0x0
 [#06] __rcu_read_lock+0x18          -> __bpf_prog_enter_recur+0x30
 [#05] __bpf_prog_enter_recur+0x9c   -> __bpf_prog_enter_recur+0xf0
 [#04] __bpf_prog_enter_recur+0xf4   -> __bpf_prog_enter_recur+0xa8
 [#03] __bpf_prog_enter_recur+0xb8   -> __bpf_prog_enter_recur+0x100
 [#02] __bpf_prog_enter_recur+0x114  -> bpf_trampoline_...+0x6c
 [#01] bpf_trampoline_...+0x78       -> bpf_prog_...test1+0x0
 [#00] bpf_prog_...test1+0x58        -> arm_brbe_snapshot_branch_stack+0x0

Use an architecture-specific threshold of < 14 for ARM64 to accommodate
this overhead while still detecting regressions.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/get_branch_snapshot.c  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 0394a1156d99..8d1a3480767f 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -116,13 +116,18 @@ void serial_test_get_branch_snapshot(void)
 
 	ASSERT_GT(skel->bss->test1_hits, 6, "find_looptest_in_lbr");
 
-	/* Given we stop LBR in software, we will waste a few entries.
+	/* Given we stop LBR/BRBE in software, we will waste a few entries.
 	 * But we should try to waste as few as possible entries. We are at
-	 * about 7 on x86_64 systems.
-	 * Add a check for < 10 so that we get heads-up when something
-	 * changes and wastes too many entries.
+	 * about 7 on x86_64 and about 13 on arm64 systems (the arm64 BPF
+	 * trampoline generates more branches than x86_64).
+	 * Add a check so that we get heads-up when something changes and
+	 * wastes too many entries.
 	 */
+#if defined(__aarch64__)
+	ASSERT_LT(skel->bss->wasted_entries, 14, "check_wasted_entries");
+#else
 	ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
+#endif
 
 cleanup:
 	get_branch_snapshot__destroy(skel);
-- 
2.53.0-Meta

