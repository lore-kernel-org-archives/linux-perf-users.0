Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B535F18B
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181977; cv=none; b=dY04XC5zZ9Su5y/QB7U+J033HB+Bnlw5MQNWfuKqpbim3iiaNCWlo0b6uHq8lZ0uyGLLcTxrLhtd2lDl54T86W2XQAtM8rEnx5bB4bf1g3J9l/jCaLPfl6aVbqcTda4cjqDieMV7ajmOY/9f/yrjNGzLxSa+Gqt+1Ppl2HKujbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181977; c=relaxed/simple;
	bh=ePkUE6a7KPA79g9tq0rY4S7SFcKDgZ33OxP2Wu5PdFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/T0Hlu95TCqGQ+9X+DdlFu427BiTk3tfbvkEfMXFjeEGOff2lFoKGsRff9mM7hzqMFTF92LWjhxxehtAWLbfu/ud20VtxGOxDZtvuZFxPTEmUi6eu4hloVl9BwlWyacSYnDKSpkkSGjh8psf0mH9zMDsuGtPfbdcmLb6lnvJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lii6BPYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lii6BPYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D311F00893;
	Wed, 23 Sep 2026 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181969;
	bh=cn79cbjGjOx26NfbUqBjo9b4EOJeUVvu82SR1tGC5CQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lii6BPYTjnMgXGGZsegDsY78LeMPnWdpPAaF3BQyJ3jJHH8ALf4UF0r5+WtZTWrbc
	 CMqkhoOn0QtYWs3ZQnWS/JXloycVr01s+chiqe9gBVl3tCW7jTrTdruCHPZ/Tapx3I
	 2gv07g2jDeDmBzkhWsr3uimwJA+oFYt0S44gNYsEuBWZXkRIp/3izaVsMjk4/+SUHo
	 HmoNHQfRmUAytHhhMcHrUw3Fk6TVwQsTgNennJ9KjjHOHZcMgzWv+sqlU/+SrnC//3
	 /fx/Css3JpZAwiOiax0zglOUyujiLOfLJRcDktV2f7drVLE/HMaNemHJhXZde24cU7
	 Xh4LeCW0MkX4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] perf tests: Check CoreSight syscall entry and
 exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-12-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-12-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:46:08 +0000
Message-Id: <20260923164608.D9D311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: spurious test failure via masked skip code
--

commit 9f0a06a503d95652f0f88ac67977ecbfd36fc578
Author: Leo Yan <leo.yan@arm.com>

perf tests: Check CoreSight syscall entry and exit

Record the existing callchain workload, which issues gettid() through
SVC. The test requires syscall/sysret pairs to advance the PC by four
bytes.

> diff --git a/tools/perf/tests/shell/coresight/syscall_entry_exit.sh b/too=
ls/perf/tests/shell/coresight/syscall_entry_exit.sh
> new file mode 100755
> index 0000000000000..bf61b1fdf6f15
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/syscall_entry_exit.sh
> @@ -0,0 +1,21 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# CoreSight syscall entry and exit (exclusive)
> +
> +# shellcheck source=3D../lib/coresight_exception.sh
> +. "$(dirname "$0")/../lib/coresight_exception.sh"
> +
> +test_syscall_entry_exit()
> +{
> +	# callchain() invokes gettid() through SVC, which returns to PC + 4.
> +	if ! record_trace callchain; then
> +		cat "$tmpdir/record.log"
> +		echo "Failed to record the callchain workload"
> +		return 1
> +	fi
> +	decode_trace || return 1
> +	check_exception_pairs "syscall" "sysret" 4 || return 1

[Severity: Medium]
When check_exception_pairs() returns 2 (SKIP) due to trace gaps eliminating=
 all
complete entry/exit pairs, does this statement incorrectly translate that r=
eturn
code into a hard failure?

Since the test workload recognizes this as a non-fatal condition, using
|| return 1 here triggers the short-circuit fallback because 2 is non-zero.
This forces a return status of 1 (FAIL), causing legitimate trace gaps under
load to produce test failures instead of graceful skips.

Additionally, returning FAIL here causes the cleanup() trap to leak tempora=
ry
directory artifacts into /tmp.

> +}
> +
> +setup_exception_test || exit $?
> +test_syscall_entry_exit

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D12
