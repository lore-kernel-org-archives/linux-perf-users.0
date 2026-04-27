Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8D35C184
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283380; cv=none; b=JwWcOzIbGnAzczUkqs/tBlrSiPnRMGFfMkRNUwo23sd1JwqHC0WYtolyclyUVu5aT1DBY8yR0rgasAZUJOCTXwa5C7wP/0L7pAFv9fRjbJH3tLuciUNWQKtnW4GNwtnhKuLwWmV1WKMcZpkdZQNYAbAi6eMVzzWEsSeOJNK5JPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283380; c=relaxed/simple;
	bh=Pvb+YaOjS8e2+GhtzSZvxsYrnzrQiI+OVShp5ll4xT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=in8wJ6Ohn1ADomWej/dfqmitbjiMX7XdvsrvVLFFsYSr0ZofdnndgBuU4P33CRkR9gou6MHzjeXMtq3sAI806YRu40Bux/7IVA3wOjgFsZUxpnMdUVTS01FvcUnDWy+29eUiUIG4BJf+eH0hV7VK73H917DJDedVmMZDJhbIvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN191FK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN191FK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB8EC19425;
	Mon, 27 Apr 2026 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283379;
	bh=Pvb+YaOjS8e2+GhtzSZvxsYrnzrQiI+OVShp5ll4xT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iN191FK5apd/L2fcK+0RH3lHytWPpXeYi+4WIQnOHuPqbFP78bVb7nnmLOsrHmI1D
	 s+ZPG+kmZTywjjY6yaZtdJthDltSVwwttI2Xus8x5iATeL+HKZi9vwdfKRpD2Xeh9H
	 B/3azYENFh5ljfgmVhbnJ9b7SJT2lLRJfSCcs3qZ0ow/czdP3Hpu0uSFvwGOoYc5pz
	 +VqqE+ti6hMI5gpx9bskTAWOY/d3QsTPlIXGW5fqGsFDzURJiG76cTJOtQGCHfaV0h
	 DL7vYVODjjtdT12bNnw89EPHoioDW5Tr6oi6B2MFS24swNn1T+1+5PpVipXAKuOD55
	 nYKwMN2FA338A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf test: fix sys_enter_openat event test for musl
Reply-To: sashiko@lists.linux.dev
To: "Martin Kaiser" <martin@kaiser.cx>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260427090225.794482-3-martin@kaiser.cx>
References: <20260427090225.794482-3-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 09:49:37 +0000
Message-Id: <20260427094939.4FB8EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The updated bitwise check `(tp_flags & flags) !=3D flags` fails =
to verify the `O_RDONLY` access mode and permits arbitrary unrelated flags,=
 severely weakening the test.
--

commit 0700122c98ba7f263a329cd8f9fbeef95b67603e
Author: Martin Kaiser <martin@kaiser.cx>

perf test: fix sys_enter_openat event test for musl

This commit updates the sys_enter_openat test to allow additional flags in =
the
captured event. It replaces the strict equality check with a bitwise mask c=
heck
to accommodate the O_LARGEFILE flag implicitly added by musl libc.

> diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tes=
ts/openat-syscall-tp-fields.c
> --- a/tools/perf/tests/openat-syscall-tp-fields.c
> +++ b/tools/perf/tests/openat-syscall-tp-fields.c

[ ... ]

> @@ -120,7 +120,8 @@ static int test__syscall_openat_tp_fields(struct test=
_suite *test __maybe_unused
> =20
>  				tp_flags =3D evsel__intval(evsel, &sample, "flags");
>  				perf_sample__exit(&sample);
> -				if (flags !=3D tp_flags) {
> +				/* C library wrapper may set additional flags */
> +				if ((tp_flags & flags) !=3D flags) {

Does this check still verify the O_RDONLY access mode?

Since O_RDONLY is defined as 0, the flags variable evaluates to exactly
O_DIRECTORY. This means the condition functionally becomes
(tp_flags & O_DIRECTORY) !=3D O_DIRECTORY.

Does this unintentionally permit other access modes like O_WRONLY or O_RDWR,
and ignore other unrelated flags as long as O_DIRECTORY is set?

>  					pr_debug("%s: Expected flags=3D%#x, got %#x\n",
>  						 __func__, flags, tp_flags);
>  					goto out_delete_evlist;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427090225.7944=
82-1-martin@kaiser.cx?part=3D2
