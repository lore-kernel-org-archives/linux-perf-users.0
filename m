Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A63876C1
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665489; cv=none; b=kj9swIb7VHzUnD2MuxoF/NIhbQQm5FAT+7/XkoIK7FIVl3tB+w5eAt1q5O/RcKFeDjCdDqkxuztxcvIqVkb8chdcc94Pu+5gcnTNMbncsQeXKyhfRXQFeL1IiZGf9GCwJiAO9aYe42tuKEsBZY2klZZ7QtGzpzogjMDlmmLCnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665489; c=relaxed/simple;
	bh=k3+bZ+DBIeErkqD8w6TuJKIzsH3uzi+RDl19O4jzf8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LlLOpZHcxLfHsH0x97BCOs8GB6x3zjqlAw6+hG+pHS32vPfArg07ms+WuM7+6/c7KCNL2d3k7mWXRkPw2gVb+v6/G7uSSOg4F/jpi70I7f2SDv3v7KxhQ0xWruIXpUb1Z9VxGwJ/lH6ScWl97OwM0knLWzsGm+tN1aI8PgNAV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1nX6X4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1nX6X4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737D71F00893;
	Tue, 29 Sep 2026 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665487;
	bh=f5lwWmRPR007UWbRb5FxaO8SI00D/MMV5FUibp3d4wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1nX6X4SeBak2+7ZXDKRQoWvaG34WV5rNEuqOBLZUwPNnx7MFuY18Tc92Jh1f1dAR
	 N7RRrQ/23xSAR1bsMUIFC3qlcvtRi6w81oxzV/fquVwjpTtuJW0xQGkHATiW2O+4R/
	 PwTyzvuqZLOWS/v741BfYSqRGCw5N+fMIGHNFr/npDhAk6ddz5uzuskc/UrevjT2G4
	 CwIqRtwSmo1kTiMedlNIXATfdG613JgTa5seMtxf9ZTeD868atmppMLzb5lM9u/jG3
	 EEkIolR1vDyyacZxxrbdQCWyy6NLx088QRLPhU6Tx05ET49Wjh2kQsEt2TEbeht1xd
	 Hti/slf03T3pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] perf test: Reduce overhead and contention in
 Python shell tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-7-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:04:47 +0000
Message-Id: <20260929070447.737D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When all Python shell tests run concurrently during 'perf test' under
> heavy load:
> 1. Unfiltered 'perf list' initializes all hardware PMUs and metrics in
>    each test process; use 'perf list tracepoint' when checking for
>    tracepoint events.
> 2. Running 'perf record' without '-B -N --no-bpf-event' synthesizes BPF
>    events across the system and caches build-ids into ~/.debug; add
>    '-B -N --no-bpf-event' to all Python shell test recordings.
> 3. Drop '-a' in test_check_perf_trace_python.sh,
>    test_rw_by_file_python.sh, test_rw_by_pid_python.sh,
>    test_rwtop_python.sh, and test_syscall_counts_by_pid_python.sh where
>    only a single child workload ('dd' or 'sleep') is tested, avoiding
>    system-wide /proc synthesis and ringbuffer contention.
> 4. Add '-W 1' to 'ping -c 1' in test_net_dropmonitor_python.sh and
>    test_netdev_times_python.sh, and narrow 'compaction:*' to
>    'compaction:mm_compaction_begin,compaction:mm_compaction_end' in
>    test_compaction_times_python.sh.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D6

