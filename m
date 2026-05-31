Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6C26299
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206391; cv=none; b=ABZZZRvnJ9J8pkH8uM9DqlB0YVjX1xwEiO3ac8cQdm0MFpzeuGu13cIlw4fNXON2SexqspkMgDiNKSderdJ3XJp9l9I9KsrdTKlmoxI3mWKF4KTJYt3dVzOfqgP6zbGEgqcrJnsvn9oAWDeKee4WJVMaDMM7lYG4cheBMWPrxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206391; c=relaxed/simple;
	bh=ODL5fgQpLDx1u7KjkvTEpO8Dgn5lE6e0rxh+pnvgNh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UG/AVBfnmfNCmHuCFJx10t7ApliuyTfKwj4upo50xArlXA/a4xSaB+VkrcWGPQVce/MqwfcQ81VzU7p551/JUzsBmNvGLpVvn9C/7jmO82gvB2kaNzFJs8pY4nUwgBWPi/J1us+/5X8XfgYedbgzl5xeZxKi+JAz/84a5SiN060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZq55sZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZq55sZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863481F00893;
	Sun, 31 May 2026 05:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780206389;
	bh=Lq/7A8eWCoPmvEQcQMBKy2EFnyW1fiW4/rLAuoncT9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZq55sZ5ATKanCkDIvlXhwV/TOJKmdAS4HXcnAyBRuhrSi1W+9wcfoHXpWGT5alnb
	 E+GolURQKh4exGqH48HscGGKzqOrJ76LzOllkJ3GbBGYmJaqwjXVyFDltOyv5Ob6jp
	 j4tpLt1E2CgJVPePqhofxd5M8z49AgN6l6aGBC5Qot99oYRexp/pbJoJfA6Viw/AgR
	 /JODDyXmvMFqUoGgHi0FdUGM06eNdKaHWxrYnZuDiSHuzkqNE8uX6KCVUk1cQFSCya
	 p9l7CJksePqjiovs4nsi+bBjOZfexOyZqDZTMlrGOyheHIlOUpbaON0WFre0EFjRRL
	 RyRvrHb5tMQcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] perf test: Skip shebang and SPDX comments in
 shell test descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-11-irogers@google.com>
References: <20260531052740.796087-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:46:29 +0000
Message-Id: <20260531054629.863481F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Buffer overflow vulnerability when resolving the script file p=
ath using readlink.
--

commit a792fd72a2438df9a3c43c3e30f07536ee6c563d
Author: Ian Rogers <irogers@google.com>

perf test: Skip shebang and SPDX comments in shell test descriptions

The parser incorrectly read SPDX tags or shebangs as shell test description=
s.
This refactors shell_test__description to use io__getline to correctly skip
them, preventing test description extraction breakage. This allows shell
tests to include standard SPDX headers without issues.

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8f..48a2624da6438 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing I noticed a
potential buffer overflow in append_script().

tools/perf/tests/tests-scripts.c:append_script() {
    ...
	char filename[PATH_MAX], link[128];
    ...
	len =3D readlink(link, filename, sizeof(filename));
	if (len < 0) {
		pr_err("Failed to readlink %s", link);
		return;
	}
	filename[len++] =3D '/';
	strcpy(&filename[len], name);
    ...
}

If readlink() fills the buffer and returns PATH_MAX, does writing a slash at
filename[len++] write out of bounds on the stack?

Furthermore, if the combined length of the symlink target, the slash, and t=
he
name string exceeds PATH_MAX, could strcpy() blindly write past the end of
the filename array and corrupt the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D10
