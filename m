Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7E3DAC02;
	Fri, 13 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425066; cv=none; b=lHxX2Fweh/ccb0w5WDptFaFEpFKLenMCbFZmXn/Xgpy1y5VLJUWsu9BLiZ0GRl7o0hA8OGbF52FkJhB23VZHGHMk793l6vGM4j6qZaoKuswRE17V1TacyP/I3Q0pSHd24vSVX5YesKsLJBNhjfC5GXOisiDybVgxjgErP6+b+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425066; c=relaxed/simple;
	bh=/hJzZqLtW90/z2cs76iSHZO9bAMYHyE+DmDY/xzj7dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIeL0k8lmvhBtAFjtuWOS2CrBGJXElupRmu/p0XVLvGm5xkzalb7dnXVVUPDqgc8lN4gvNUFSdFufFmKofAVtaMEgXyASJI86adkDc3uU2GKD4s0yZnTvSnqP0ePFW4w0SWouGDcfZKX3Mn/RwV3Hc7ekMy0P6BcGrmqEGZPWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrLB9pUH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrLB9pUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4C5C19424;
	Fri, 13 Mar 2026 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773425065;
	bh=/hJzZqLtW90/z2cs76iSHZO9bAMYHyE+DmDY/xzj7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrLB9pUHNrt7KrF2ESCD69HTOOsFnghTyF3hfod84m2fJzISUaRXcJMj8j0gCj87T
	 /FbVMfiQ1z4mScDvxuzJ3Qd1BJZRn6t/FtTevOpNUzDX+EA43gN1h5zbJVnEUZYewn
	 aLg6VnPMouUcvQ9ZUfTgVpZlxubVFx5BEqv2imL01qr+WG4DSRM+c/wlFs9OpyTE8I
	 0kxS3JAqrVNL/PW2793MrCCGVQUISPb0zs5TGFWrJQmcplYXdqCxf1FxP0bOoq3KxN
	 05JgN2KmGnU4oLRxa8wyustIsQZWr+hGXkj/AWw/sTAQFEV3pktW0ddJfXxFutCe5A
	 aFaqWB7BeTLeg==
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
Subject: [PATCH bpf 3/3] selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
Date: Fri, 13 Mar 2026 11:03:34 -0700
Message-ID: <20260313180352.3800358-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313180352.3800358-1-puranjay@kernel.org>
References: <20260313180352.3800358-1-puranjay@kernel.org>
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
resulting in about 13 wasted entries. The overhead comes from
__bpf_prog_exit_recur which on ARM64 makes out-of-line calls to
__rcu_read_unlock and generates more conditional branches than x86:

  [#24] dump_bpf_prog+0x118d0       ->  __bpf_prog_exit_recur+0x0
  [#23] __bpf_prog_exit_recur+0x78  ->  __bpf_prog_exit_recur+0xf4
  [#22] __bpf_prog_exit_recur+0xf8  ->  __bpf_prog_exit_recur+0x80
  [#21] __bpf_prog_exit_recur+0x80  ->  __rcu_read_unlock+0x0
  [#20] __rcu_read_unlock+0x24      ->  __bpf_prog_exit_recur+0x84
  [#19] __bpf_prog_exit_recur+0xe0  ->  __bpf_prog_exit_recur+0x11c
  [#18] __bpf_prog_exit_recur+0x120 ->  __bpf_prog_exit_recur+0xe8
  [#17] __bpf_prog_exit_recur+0xf0  ->  dump_bpf_prog+0x118d4

Increase the threshold to < 16 to accommodate ARM64.

The test passes after the change:

 [root@(none) bpf]# ./test_progs -t get_branch_snapshot
 #136     get_branch_snapshot:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/get_branch_snapshot.c       | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 0394a1156d99..dcb0ba3d6285 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -116,13 +116,14 @@ void serial_test_get_branch_snapshot(void)
 
 	ASSERT_GT(skel->bss->test1_hits, 6, "find_looptest_in_lbr");
 
-	/* Given we stop LBR in software, we will waste a few entries.
+	/* Given we stop LBR/BRBE in software, we will waste a few entries.
 	 * But we should try to waste as few as possible entries. We are at
-	 * about 7 on x86_64 systems.
-	 * Add a check for < 10 so that we get heads-up when something
+	 * about 7 on x86_64 and about 13 on arm64 systems (the arm64 BPF
+	 * trampoline generates more branches than x86_64).
+	 * Add a check for < 16 so that we get heads-up when something
 	 * changes and wastes too many entries.
 	 */
-	ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
+	ASSERT_LT(skel->bss->wasted_entries, 16, "check_wasted_entries");
 
 cleanup:
 	get_branch_snapshot__destroy(skel);
-- 
2.52.0

