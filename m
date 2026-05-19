Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A82F8E90;
	Tue, 19 May 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218640; cv=none; b=UZqIuD6JZ+foO57jqGuHoQYcgPGe6HcZ3e9SPXlHqaycWUIQIeSqOVbFBCR0QsbKScgvWfIO0lB95ZAK974Ya0xax17Jg9zwlx1GNH3gx68Og1VQSBZqxNkPpHdjsMzgf952TjmFAH4WDFtoFEbd6OhFuAbv4DAhZ/cJBEb4yE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218640; c=relaxed/simple;
	bh=lFjdbMw+j91pvfAlw9yJ2BZZfDgHmaa652F8B2FGJjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTCo1YXes/8MIiXxVgeUlhPYmMGdKn0HXXEPHOoXCuhOh67/ieC+VMAsggzTGt/qL8dzgnqu/IR4dcIpN5oOlIXbFZOW4unzwOu2R4K3PYfPIVsra1KZ7XN9V3ql1zJw5J5taIyciuSuNyxxWqmR764zsVVS6YX1edNLxcICYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktNJXRbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktNJXRbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44B31F00894;
	Tue, 19 May 2026 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779218638;
	bh=jyBQ3cmJxykIgAoQvvMmHQCbRsXK9xpKOQmJf8X3OkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktNJXRbNFrTUV2z0ZXBnadHe7wmO2Yf5ukX3yekfkE4IHSAm6A+knuUJQUKh81kYo
	 OU8zV31SghuSSN1UqkWlSOVpqqcYLrmFbsPd/K/4FKFvT0+02MLIE1mnTiHq+EhfCY
	 Pg+qDy0rfhAv+pOS7CJIPCTpndgTzGQ+sA5Jp/ZRXFxemRUML5H74r00xredLg4pfF
	 E42dr2ppuGRlTT2ADgb0d14ikhKkgTyxpVftid66BSzPIq9GK4VWLWQ1nhfI/iD8pS
	 kHbtv6BQeGiuiK8NFY4Y9TrIX5GM+tm+Wss4TgT8ZgTwU7wFVAuqvmg5WghS4o2Ac2
	 xvcrOJTVWGtfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.1 1/3] perf build: Conditionally define NDEBUG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260519185154.2987285-2-florian.fainelli@broadcom.com>
References: <20260519185154.2987285-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 19:23:58 +0000
Message-Id: <20260519192358.A44B31F00894@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Defining NDEBUG removes the side-effecting `bfd_check_format()` =
call inside `assert()`, leaving the `bfd` object uninitialized.
- [Medium] Compiling out assert() removes critical runtime validation, lead=
ing to deadlocks and NULL pointer dereferences.
- [Low] Defining NDEBUG causes variables only used in assert() to trigger u=
nused-but-set build failures.
--

commit 34a3ad3c8a3c7ed93c69e4b84492292fae1cb400
Author: Ian Rogers <irogers@google.com>

perf build: Conditionally define NDEBUG

When a build is done without DEBUG=3D1 then define NDEBUG. This will
compile out asserts and other debug code.

Link: https://lore.kernel.org/r/20230330183827.1412303-1-irogers@google.com

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 898226ea8cadc..45708084fd3d6 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -228,6 +228,7 @@ ifndef DEBUG
>  endif
> =20
>  ifeq ($(DEBUG),0)
> +CORE_CFLAGS +=3D -DNDEBUG=3D1

[Severity: Medium]
Will this cause a regression in tools/perf/util/annotate.c? The function
bfd_check_format() is called directly inside an assert() macro there.=20

Since this function has side effects (identifying the binary format and
initializing the architecture and machine state), compiling it out will lea=
ve
the bfd structure uninitialized.=20

Subsequent calls like bfd_get_arch(bfdf) operate on uninitialized bfdf stat=
e,
leading to NULL pointer dereferences and crashes during perf annotate.

[Severity: Low]
Will this also cause build regressions due to unused variables? Variables s=
uch
as old in tools/perf/util/block-range.c are initialized and assigned values=
 but
are only read inside assert() macros.=20

Compiling out assert() leaves these variables assigned but never read, which
triggers unused-but-set build failures because the perf build uses -Werror.

[Severity: Medium]
Does compiling out assert() remove required runtime validation elsewhere? T=
he
codebase currently relies on assert() for handling expected runtime failure=
s.

For example, in bench_sched_pipe() (tools/perf/bench/sched-pipe.c),
assert(pid >=3D 0) checks for fork() failures. Without it, a fork failure c=
auses
the parent to execute the child's logic, reading from an empty pipe and
deadlocking indefinitely.

Similarly, in tools/perf/builtin-timechart.c (assert(cursor !=3D NULL)) and
tools/perf/builtin-top.c (evlist__id2evsel), allocation and lookup failures
proceed without aborting, leading to immediate NULL pointer dereferences on
subsequent lines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519185154.2987=
285-1-florian.fainelli@broadcom.com?part=3D1
