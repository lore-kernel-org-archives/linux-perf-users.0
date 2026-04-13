Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4A39150D;
	Mon, 13 Apr 2026 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106723; cv=none; b=aVrfs9JA08hj4cBMTmo0fV6Hn8tpnvgzBMi0oT9BjgvfU2WfZSPFXugXhG4MrUBCkusCu/0OHd/wJ3rc3cOocr7SZmfkcG4FxRovr5c22KB4m6LgHO71yFiIUQKalmy77h/xEajmvDAz2TcISLc9v4JAjBzzBdQVhak+m0L+8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106723; c=relaxed/simple;
	bh=x0FufSkSBt0JmK3zAYZJMpJPG4N7AJq2hUvuGYHPtHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKAOtD0x4N8wqPVivNbBT9rdxvb1fRBgJEWrJHpSqt4Wty4Zg5DTnEgERJZiP6lxFcxcMDIMHWy/okq21jw5qrUy+DYZtU5SDg425tHiUm0cv5exymBXD5mmm9VUkokxVMm0wtA/rpLuI1wItrDr/ntz0m1mJutWdbMDLCHGkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOrNAGGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOrNAGGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7DEC2BCAF;
	Mon, 13 Apr 2026 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106723;
	bh=x0FufSkSBt0JmK3zAYZJMpJPG4N7AJq2hUvuGYHPtHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOrNAGGi3PB4uFo4u00SGeTHTJjiJ+KbmpiDpXapCjf8Hw2J36+vBxqQLreLRvxKI
	 rUiq4vyy3kxR7DD+c0uis7k7+A2RsFpUg5uLtT9yl8N5wGwnwhz4y1jv+joA+62hWU
	 2EI17S/kgnyprLCJXsJCT4aiVnWuadAlRfay9aU/AWcf9w6+iDPanf14ZNYI4lqOWi
	 KUDtYMks4Nd6OWmefO8IHkO4kb3ahvGKTDX3lT/atWa5FGH5hQ+1WM4y6cLzl4Z3Vp
	 hqgh6nZ5tYJV1s+QpsJeSk4vki3nqGY2pJ3VZSWyAIH7CoxlOF+zpLWRaqZVNJ5Nx0
	 2qZx2hKoMTJPA==
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
Subject: [PATCH v3 4/4] selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
Date: Mon, 13 Apr 2026 11:57:23 -0700
Message-ID: <20260413185740.3286146-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413185740.3286146-1-puranjay@kernel.org>
References: <20260413185740.3286146-1-puranjay@kernel.org>
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
2.52.0

