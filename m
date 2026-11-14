Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615528;
	b=dui84y8NwbYxg2Hd8PW2Qe2Cf/ogA5OZvUqe2z2hLZf5uohe1pLoNTBx04WtvbQR/DYH
	 U+Bhvswi0goPjzt53ydWfMtS7Lci4L6O3HCT3lM3IJu6RYPfa8FQOv9jfj3+ZXHvEgITt
	 SEf30WAuImJt4e81ogonSPnlvhoFpu3oevcmE207PrLMG0mcQZFCFB8SlMQHrjo5RIyw4
	 R6kKr35CCn2D8xLrPW41AnjnJN+moEP5saalyRHRA/LTgzpVRHMOuSyl0h8tShUiL9LMj
	 aWkQr4qDfntHWY2p7gO3BdZ0iIKIiHDf2/DB+GYL4SoWCwvCt41ZNlobVTLuFG6VVkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6y9QE6jrL4hwSU15y6udJxlINtEcQ9mhA2x1WVNSoNo=;
	b=FBr4ez+eupeQSWBGHlG2m8VNi6JIhZOLhYVvtfr/KWxOzFf6QIQdza6J8RGz8daXDeFq
	 dp7BABP7kTxgvFFp90UKX2RBZTIHo2dZuLIOOe0XJj8oDVzp6iS/a7uiqgXEIm2LDdRIX
	 AW3gqB10DAjzvyEqWWIj0OP9gGwI3ddh6qzjsRdC41W6jwowMRGMyjcdG6PYP6uhuMQQP
	 AADuiX9IU46lHMESv00GlKCRsi/8mPyqpXoTAnKIwNzKKgVZM/IGSz9g4Y9jg1URLy+yI
	 pab545UDsG9gvx7bZbNFf1o7USwpzDamJ9bcoa84iD51TIl2YxCs5qi5s2dPMLhQn4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iBH/HQl+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13280606A334;
	Sat, 14 Nov 2026 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBH/HQl+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815B91F000C4;
	Sat, 14 Nov 2026 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615527;
	bh=6y9QE6jrL4hwSU15y6udJxlINtEcQ9mhA2x1WVNSoNo=;
	h=From:To:Cc:Subject:Date;
	b=iBH/HQl+hnAa1Q0SwQNKcQJ2kuRKBwgvwknCObI4/plivGobr6wfJnHn7jX01FEHq
	 mU8ZVgjRL3ZED9xj7PPuMfjXS9ldB1wm7opTb2bTeVtGTZA/FQy4VjAPWtqrjmoYUk
	 aFSZRjQA/YkVTXl8nzKSyvSIDZ0gKdPjAxR217hFQXBkW7MeldjLIXdKSNdqvO9CW9
	 3yrA8gnDVxjweP6tLFQ7n0YQppG7OIuJjX940V8X1CUqfEzpP4zCp+4O4DlMhO8ttG
	 x+yNN5VfTZe+jE/rasvYofrSWwcRQN1IGqizPzSv6KSQBFvmkpKpUCn+EQgJI6VRNn
	 2uDaq/QX1GSng==
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
Subject: [PATCH bpf-next 0/3] Fix duplicate caller frame in arm64 stack traces
Date: Fri, 13 Nov 2026 16:18:43 -0800
Message-ID: <20261114001846.873499-1-andrii@kernel.org>
X-Mailer: git-send-email 2.53.1
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

On arm64 the caller is reported twice when the kernel builds a callchain for
the current task from regs filled by perf_fetch_caller_regs(), instead of regs
saved by a real exception. There was a similar problem on x86-64, but it was
since fixed. Now it's time for arm64.

Patch 1 has the fix, patches 2-3 add BPF selftests for this.

I'm targeting bpf-next because of BPF selftests and to have BPF CI test
everything. Patch 1 doesn't have to go through bpf-next, but it's simple enough,
so if arm64 folks are ok with that, please ack and then we'll land everything
in one go into bpf-next.

Andrii Nakryiko (3):
  arm64: perf: Don't report the caller twice in caller-regs callchains
  selftests/bpf: Add stacktrace_ips test for tracepoint
  selftests/bpf: Run stacktrace_ips raw_tp, tp and fentry tests on arm64

 arch/arm64/include/asm/perf_event.h           |  2 +-
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 67 ++++++++++++++++++-
 .../selftests/bpf/progs/stacktrace_ips.c      | 18 ++++-
 3 files changed, 81 insertions(+), 6 deletions(-)

-- 
2.53.1-Meta

