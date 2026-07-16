Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F44341650
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171543; cv=none; b=uSfItTGok6MBon3XYNGUt3WfU4DTJaeCWafdr4Gh99wsoluz3AFA7Pq9/qXyfwyPirqQC3TLhz3Ywhqax2ZxKj0/VsCaXhLOeXMM9Dz6aJpM7Y1hmbFtJBVe2gAYp8pXl61fkJH1bR/Toc1hKu1OG0m4drvmXwH+hnqCLbp3Q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171543; c=relaxed/simple;
	bh=osdlP8fRTmDlri6Xp8ao4snWGd/hojSgNbhOchXZ0GI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oBZXn1niDsaIks6uti8/bjdU2RJr0NKG8wOKn4NY0iIBBYeyq6RuoKH3XO0prQWQz0HEVZyc6dbukd30pMwqeGQeHSHUGd0/cW09Zzt3gI5+7eBEvTa+w1IO5+DtpCBURdrJdQ/hXEwiCiOEtGgbHtriAz5xobrwjMrhphysxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLJ48lCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLJ48lCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569981F000E9;
	Thu, 16 Jul 2026 03:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171541;
	bh=osdlP8fRTmDlri6Xp8ao4snWGd/hojSgNbhOchXZ0GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLJ48lCHUks6sn1lwp4QMchtKWccfUE4O/a4CkqT9dMPEgYs47/rxVnL+NHJKeZyK
	 5O//Mw7t6rwM8Nu7MO4dsH9ROipg00drH0OlYcC5Y+fdVI4sy01u1skZVmC89vADRR
	 rYo1UQJDfhupePqvVk40+Bc2FC/xD3HZRciw47tj1qYfOi63b+zYguBkeiPRd0z8z1
	 SEJOUFKOFinrvBbpm51LIN/1QbUMLzYBEiilTfEApFq/dV9bny5Nr1X3uATa6er9be
	 R0aN/VhgFXT7uqBWJMzB9OOgF9itOC6ISfFAU5q7YgNIpDiH4tWNf7WP34OLi2RJTP
	 NPk8H+BI2uqiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 9/9] selftests: ftrace: Add wprobe trigger testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178417043960.209165.373192587945789724.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
 <178417043960.209165.373192587945789724.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:12:20 +0000
Message-Id: <20260716031221.569981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest incorrectly assumes that unlinking a file (`rm`) wi=
ll synchronously trigger `dentry_kill()`. This only works on filesystems th=
at do not cache negative dentries (like `tmpfs`). On standard disk filesyst=
ems (like `ext4`), the test will fail.
--

--- Patch [9]: [PATCH v8 9/9] selftests: ftrace: Add wprobe trigger testcas=
e ---
commit 02c2b6c1500ba6cce360f9d5447d679e62801d61
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: ftrace: Add wprobe trigger testcase

This commit adds a testcase for checking wprobe triggers. It sets set_wprobe
and clear_wprobe triggers on fprobe events to watch dentry access.

> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe=
.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> new file mode 100644
> index 0000000000000..5ffe43f886d1a
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
[ ... ]
> +:;: "Start test workload" ;:
> +echo 1 >> tracing_on
> +
> +echo aaa > $TMPDIR/hoge
> +echo bbb > $TMPDIR/hoge
> +echo ccc > $TMPDIR/hoge
> +rm $TMPDIR/hoge
> +
> +:;: "Check trace results" ;:
> +cat trace | grep watch
> +
> +:;: "Ensure wprobe becomes disabled again" ;:
> +cat events/wprobes/watch/enable | grep 0

[Severity: Medium]
Will this regression cause the test to fail when $TMPDIR is on a standard d=
isk
filesystem?

This selftest appears to rely on rm synchronously triggering dentry_kill() =
to
fire the clear_wprobe trigger.

While this works on memory-backed filesystems like tmpfs that do not cache
negative dentries (their d_delete operation immediately leads to dentry_kil=
l()),
standard disk filesystems like ext4, xfs, or btrfs cache negative dentries =
to
optimize subsequent lookups.=20

On those filesystems, unlinking the file leaves the dentry hashed on the dc=
ache
LRU list, deferring dentry_kill() until memory pressure or a manual eviction
occurs. This would cause the test to fail when checking if the wprobe is
disabled.

Does this need to trigger a manual cache eviction or ensure the test runs o=
n a
tmpfs mount to avoid failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178417033089.209165=
.16717079876036408877.stgit@devnote2?part=3D9
