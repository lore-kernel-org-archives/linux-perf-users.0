Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D933890F6
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080347; cv=none; b=D/+81y4FrhJa7seFwavXNiGqGwPUqcSmyDcVsyOVpxdqycgxBaWAavMj+TDgotO4AH2oUN6bDTiUXgv5iF9nnqk00zCeRfZ26QsGGTJdMnMRj8oF5NW9Se3ZVDxMP+/BwyGbVt1FNCyjvNrSsxpOrHybHKFBcinOam7ntwus5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080347; c=relaxed/simple;
	bh=NUUv5aiK/yAr80oIAk0Nrpn3RDxmiJCsnkvV6svFs04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARODQn+6GjVoogloIJpGHHvGIWneKDnh34GbhJYP1fWlG6YIrWvvbWOYQClLyQW3UYkbsaKVbQof2N3AG5WTxKtOEY+m+0EuqBgEGlvcv/UzhiSDH2hKV78FYKDJGQWrYOXIKlbuaDBkuXtejBpuNQlo8QXGWFpIly0ygMWeoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZQkleCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZQkleCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B921F000E9;
	Wed, 15 Jul 2026 01:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080337;
	bh=GA2MAcg5gpcDPf0bdzUFxwAnbp1qIogJ2mACIwyNlMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZQkleCl5uCHhst1G9eBFUzgupv7k2IfHreI7NRC/2Kld9KUWaWYuN3U7POLq/FKN
	 qSh70iRHOrlTpc9OBnuPd5LaFKulAyqUjVEYDuSZZUoSuDDYhp8hp9U/ot5wdsc7pr
	 e8kB85V2gcHzC14OkjFrQmFjExG0pU5AhNzGFGbbMigpfm6tiE+0Fvp2b8Hpeoq5j4
	 mmjBqonj8q9zRb/EsoK5RtuNlVmnaPy7aPHuEEP+wDGJFGyU+WJlpVk+CYkB+68Sai
	 7jB87qqPQiLkU30OoINWXo0mMaZvEtqqJUDd99WxPe1wJHf1ODzNvHNNy0u8fgaDKR
	 OufT2ME6rPIYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407987428.95826.3097357125404908509.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407987428.95826.3097357125404908509.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:52:16 +0000
Message-Id: <20260715015217.18B921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test script uses '!grep' without a space, causing a shell er=
ror that silently bypasses trace validation. Additionally, the check lacks =
an 'exit_fail' call.
--

--- Patch [3]: [PATCH v7 03/10] selftests: tracing: Add a basic testcase fo=
r wprobe ---
commit 430a459576b6f13049e560d4a90b2c6a987f1ad3
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
selftests: tracing: Add a basic testcase for wprobe

This commit adds a basic selftest testcase to verify adding and removing=20
wprobe dynamic events.

Link: https://lore.kernel.org/all/175859026716.374439.14852239332989324292.=
stgit@devnote2/

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wp=
robe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.=
tc
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
[ ... ]
> +# Let some time pass to trigger the breakpoint
> +sleep 1
> +
> +# Check if we got any trace output
> +if !grep -q my_wprobe trace; then
> +    echo "wprobe event was not triggered"
> +fi
> +

[Severity: Medium]
Will this check silently bypass trace validation? When the shell evaluates
"!grep", it treats it as a single command name rather than negating the grep
command, which typically results in a 'command not found' error.

Because the shell error results in a non-zero exit code, the if condition s=
ees
this as false and entirely skips the block. Furthermore, even if written
correctly as "! grep", the block misses an exit_fail call, so the test would
still pass if the event failed to trigger.

Could this be updated to add a space after the exclamation mark and an
exit_fail call?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D3
