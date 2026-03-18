Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC52FDC30;
	Wed, 18 Mar 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854262; cv=none; b=Ivpt0rskhH8UrWQb7FfH0MaHC3Hhz5YyyytwqAlSr9uf/5Nx7Duyna7chhBLPT91AddIY5gc7u+eVnBg0gvCTu7fIPxl/LF4Af3bkZsQ7/fDT5+fIPCKAlB2giPfIr50+er7Oe85gpRqe7ydCxhAk7xsLcpnQ+NLAOjIALbcePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854262; c=relaxed/simple;
	bh=x0FufSkSBt0JmK3zAYZJMpJPG4N7AJq2hUvuGYHPtHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0lCYeIOvMsDd7LRz+3TEYjlrLYp90SWYSHN/6eJJaG7f1OwGfCQqUkNy3CUNx0GogzOp8Z8uMsJvoAzgJHDHCAem4VO1mu8uvAX+vJ6iQNyNPXMLBdAyAeQqtaiWnjnL885ZLFO3W+j/uQt/LfJyfo0NpokJaCk4B/qIRsGZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPxqoIT5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPxqoIT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7FBC2BC87;
	Wed, 18 Mar 2026 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854262;
	bh=x0FufSkSBt0JmK3zAYZJMpJPG4N7AJq2hUvuGYHPtHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPxqoIT5TDspXYcqICCKpgMu1Nw/4KOwE3bz5m/m9yfeq7xoGn50BfHv2CWmFvAo/
	 FVu33vM2BUbegWV4B2Jev+ljb3HMULAZ2OHPuMykTfJnyIQhqMTokhiOIB967lPTj+
	 +fSwDA+GO7k9nghutUdIQCD64o+qbLr9ULwN1EKPQ8zM4JdlBunn52CkOFyRxq5Bpq
	 P6JuEYT0yXOmYDzg5sv3dntEUjqUYJ7Uhvv+dQaQozre79tjqpkicKUYt/Nmahtx0r
	 eoegWVlVBcwwpAfjhGPWwQMvtoPPvG/53Mci2Th7y1T9hWbhhfC7gzlkPwJgyUuKLU
	 Rn/oXzYra6QBQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 4/4] selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
Date: Wed, 18 Mar 2026 10:16:58 -0700
Message-ID: <20260318171706.2840512-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318171706.2840512-1-puranjay@kernel.org>
References: <20260318171706.2840512-1-puranjay@kernel.org>
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

