Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C21DF980
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216743; cv=none; b=n1HGlKO76XTInnzuiHm9nLx08W8BqbXxuqz48mLbKA6t00YE5Be5abLHhDkzGNQ/GDIOh7bPdfOLW70Cgg0AIGJCumrDxDBU5lCDAWD91jqQTVBG4AKl8wGWyhZOMSP7bz7Ge7nxt4qJdR9NO2EE47L9OW0p8g2wf+3t/K4+440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216743; c=relaxed/simple;
	bh=DZGVSK+ysb8SLFCwSXOM4LfYcRnK4F9tBCCbxymUUi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mhXRD7R4lvWkO1CtzIYqLAGi60bECysYYJsHNXihZVB0gb3PTyCaUZn6QijXI/yB9E6USj65wWk8AWR6Gbhoa92Ib168BhqWNBKhyoKikWP5+XPgCqQhsg2Jpz8BOSRjScybN1FWDDfyaSdOGpAa3GIm6K5xpkqXeGX5yIGcOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDLd5ClW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDLd5ClW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55961F00893;
	Sun, 31 May 2026 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216737;
	bh=tLCYGF4qyt4GFVYOKnTxokdJ6BxKkdFM3AupE0f4LEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDLd5ClWmtmgZ8z3LRC+GvdfaY8SrpOiBDkMxxfBWnXtjFraLkalyxlKpJXPUTWbk
	 Tt7mcu09siupnJCpQ6GNJurUkrAYU274sZdx14zQqWAPHxpHPGu3FkEXKKCtW2hltO
	 0om8iUs5Z8kClk5gUf03MsZi8BoCANXcZe3ocYPd6b6ijzr/cbpbzKXHVNHPLtPkpi
	 rQZU0cJhHS1QZhuM+MUbaW7cU7NNAdxC7KCOOJmvn1SXSPRCLa0woLWLqCG27Aj86q
	 +FoYCGiyCds2In4SgFx3zkWOcQ4P7yAziEElz0YWS0rzSLsOg35R2rO5jCNkuaaX6E
	 2YAna2kGw+xzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/15] perf test: Remove /usr/bin/cc dependency from
 Intel PT shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-16-irogers@google.com>
References: <20260531082235.940833-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:38:57 +0000
Message-Id: <20260531083857.C55961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `jitdump` workload directly calls `gettid()` without a fallback=
 wrapper, breaking compilation on systems with glibc < 2.30.
--

commit f141af2f5d5b51f3502b379b7b18fe4506f565d2
Author: Ian Rogers <irogers@google.com>

perf test: Remove /usr/bin/cc dependency from Intel PT shell test

This commit introduces a built-in 'jitdump' workload to replace the runtime
compilation step using /usr/bin/cc in the Intel PT shell test. The workload
features multi-architecture support to dynamically encode opcodes without=20
requiring external compiler dependencies.

> diff --git a/tools/perf/tests/workloads/jitdump.c b/tools/perf/tests/work=
loads/jitdump.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/tests/workloads/jitdump.c

[ ... ]

> +static int write_jitdump(FILE *f, void *addr, const void *dat, size_t sz=
, uint64_t *idx)
> +{
> +	struct jr_code_load rec =3D {
> +		.p.id =3D JIT_CODE_LOAD,
> +		.p.total_size =3D sizeof(rec) + sz,
> +		.p.timestamp =3D get_timestamp(),
> +		.pid =3D getpid(),
> +		.tid =3D gettid(),

[Severity: Low]
Will this direct gettid() call break the build on systems with glibc < 2.30?

The gettid() function is not declared in <unistd.h> on older glibc versions=
=20
(like those found in CentOS 7 or Ubuntu 18.04). Since the perf build system=
=20
treats implicit function declarations as errors, this will unconditionally =
fail=20
the build in those environments.

Other parts of the codebase, such as builtin-record.c or jvmti/jvmti_agent.=
c,=20
use a fallback definition using syscall(__NR_gettid). Could a similar fallb=
ack=20
be used here?

> +		.vma =3D (unsigned long)addr,
> +		.code_addr =3D (unsigned long)addr,
> +		.code_size =3D sz,
> +		.code_index =3D ++*idx,
> +	};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D15
