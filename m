Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046474;
	b=CW5+fFFb0bxHzyobJlAhbzWre2BeiAPI7yBbqUEui+sP+BRpq8wQwj558lczcuD5i7Pl
	 0cZNvnPHB3HYIXrxVbtSrvJUgPuEj+xDcDEBAhJG4CCaJPNurA6j1AShh2ha1oaAh081S
	 jPxTdqB5XQdC7I6ML1Q2ueICS4ypmWUGc8owAdleDqnQoXn+qzukxTvWUc2/mUEgYVZb6
	 ELp/t/nvuadZe/zlfvq5h8jM2lK757mJgivM68MhQSi7XYAkdnfsfs3uvZ3OJUjBshsy8
	 tuR7I0p5tEoHMBL+vNFjB9yEzfFSECPIuAZdMfDbmIGeVrT2ojc6tW4QZGAgXex93Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QlaFXh2FSXbQ/e8h1gUNCb/cTAUZrL7gz15TDUrTHDo=;
	b=bJklXrkHTW3SU8HHPoPc7KsQfw/esTtzjfKgqf3SsCqFRTN6sd0Tg4Z/8Lm5Zf0OMCvI
	 90ijBd+tZaN8P/lIqGv8UfkLMGVWb1VV+7GXIV5LR+kI+Ff2nZ6j9I/w3GxmfJkGht2Sg
	 Vx+3XEGQCRL4FZGOBDg/nYiRjwLrShZyj/FBLpqn4LMx+fZCpAeNot1s1iUlFrgOViKdQ
	 Ts87mEoQ9hfwvGG4Yu4WF59ojrHhDj/iBkIUmIzuikilh1l6/cZdOHMrfIsd44vhEwnKP
	 ALpRIMv4iJkv59WIcqjKTkXA6LXCIxkG1YpBHAiyITnx+hoagblp7Y+B2IZF2Ln15wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0twXbQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A7606A31C;
	Thu, 19 Nov 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0twXbQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B931F000C4;
	Thu, 19 Nov 2026 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046474;
	bh=QlaFXh2FSXbQ/e8h1gUNCb/cTAUZrL7gz15TDUrTHDo=;
	h=From:To:Cc:Subject:Date;
	b=S0twXbQr4u2IJOiRn5N+OC9gyAeUuO0PL6Pt1+zVwnEV8sL6rMWgtoqxuWIuduG9e
	 5SbOnLg3KBXCzfSD9UbYIi1lprqaaw8QnWhGzPgC2YZo8tlefEuai3vx+wjJu5Cf7d
	 Qgutj122XMIYlRgY65CMe5Ka6y55/xrq/wBT7EheqI9S9fIX4qHdIvm9qiTZhJM9Fj
	 JL/j7J34GNIlpgOCoGmK/IeyE9aO4qYOpn+xdDq/hzeJO0ChyWPylMhlpFI1Tqhd0d
	 kaJrafb9uCWzoMbQKbY+6oqUF7M+w0b6llOHlmvzrkUHQZg+6pldFPdLu6dXUp/acV
	 /Xe3h9SbcVlnA==
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
Subject: [PATCH bpf-next v2 0/3] Fix duplicate caller frame in arm64 stack traces
Date: Wed, 18 Nov 2026 16:01:09 -0800
Message-ID: <20261119000112.2377949-1-andrii@kernel.org>
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

v1->v2:
  - keep __builtin_frame_address(0) in perf_arch_fetch_caller_regs(), mark
    these regs with PSR_MODE_EL1t instead, and have perf_callchain_kernel()
    skip the duplicate leaf regs->pc for them, like x86 does with
    perf_hw_regs() (Will);

v1: https://lore.kernel.org/bpf/20261114001846.873499-1-andrii@kernel.org/

Andrii Nakryiko (3):
  arm64: perf: Don't report the caller twice in caller-regs callchains
  selftests/bpf: Add stacktrace_ips test for tracepoint
  selftests/bpf: Run stacktrace_ips raw_tp, tp and fentry tests on arm64

 arch/arm64/include/asm/perf_event.h           |  2 +-
 arch/arm64/kernel/perf_callchain.c            | 33 ++++++++-
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 67 ++++++++++++++++++-
 .../selftests/bpf/progs/stacktrace_ips.c      | 18 ++++-
 4 files changed, 113 insertions(+), 7 deletions(-)

-- 
2.53.1-Meta

