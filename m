Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E936F41C
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982777; cv=none; b=kR4qd6POax17ZRgNtHVOoJ3BYHygyM2sKBxNyelZhxBltEc/BfJ4zTginr24h8mHRdbkS3QPb2hCZ8P9YAgSSH0l6SWqsFAFVj6k+2T/c4JnUbFCloY+wOAdFkBjCjCJWDkLBu9734IS7A0E9LIl0rty1IeNfTgMdOsny9fr25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982777; c=relaxed/simple;
	bh=gdiYcsNhNdYISonpip4rk/2HRtA6TUDHhAyiVloCzQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P6sEh2Yp/n1wTU//qS1CcDnb8M4+6P1wDNK+FvbDPEAtxIyx8+mH2dEYnHuYuOMxrG+dOgo1+GTguLHfvNLzkCmiCV9PAEuw/PhmbKe+CryLyNVX+A48WfpWRqITbdQf1GiZu2Ep7PvcEmmjCscrULW4KB/3RCHvnaae/CSaTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNcC8RFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNcC8RFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5271F000E9;
	Thu,  6 Aug 2026 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785982776;
	bh=auwvwskQ80JJ+toc8F/ByYmhLiLpF5F0+P2GjXeSWQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNcC8RFhBE1mLrnu/Gc7CunACGVUtkfiAU0w7PfGfBtx6GgVv+i1DlbL7v3G57eUP
	 Sw21ywIHYMGvMNfBsu7HDCLwue+P87zN2fmMBrQedqIUG8gw0b4eAqrdkaRg3tk6x3
	 yGq6WgeOT3KjOgKdCaVn22RoIUo6qwQOWxGKEAYMAUpPSl1Y3cE8/KO8X9SYBkp1ga
	 SoWdI9KUBVMCGqDA58tZw/EgBjHeGUnsWMJrKdejlUjkUSGBJl4/+N8y1Op2RYpddn
	 Uz+cHcAez9YyAs4M7m0EcwaMz22liNVCR3c5IG+lKWhwSYw0evOgFWc5XsjLVkMu1n
	 bglg8SRBfDfPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf evlist: Warn when 'sleep' workload is used
 without system-wide (-a) option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806021038.2291417-1-irogers@google.com>
References: <20260806021038.2291417-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:19:35 +0000
Message-Id: <20260806021935.CC5271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The warning for using the 'sleep' workload incorrectly triggers =
for valid targeted profiling commands.
- [Low] Missing explicit POSIX `<string.h>` header inclusion for libc strin=
g functions.
--

--- Patch [1]: [PATCH v1] perf evlist: Warn when 'sleep' workload is used w=
ithout system-wide (-a) option ---
commit 2e20acd0f78b6776954ca8e2c6f58698c556aa50
Author: Ian Rogers <irogers@google.com>

perf evlist: Warn when 'sleep' workload is used without system-wide (-a) op=
tion

This commit adds a warning to evlist__prepare_workload() when the workload
executable is 'sleep' and system-wide mode is not enabled. This is intended
to catch cases where users forget the '-a' flag and unintentionally only
profile the sleep process itself.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index eb7c0d7be064e..d53f594ace86a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1562,6 +1562,20 @@ int evlist__prepare_workload(struct evlist *evlist=
, struct target *target, const
>  	int child_ready_pipe[2], go_pipe[2];
>  	char bf;
> =20
> +	if (argv && argv[0] && target && !target->system_wide) {

[Severity: Medium]
Does this warning incorrectly trigger when running a targeted profile?

If a user specifies a target (like -p <pid> or -C 0) and uses sleep as the
duration, target->system_wide is false. However, in these targeted modes,
perf correctly monitors the specified target rather than the sleep process,
making the warning spurious.

Should this check instead verify if perf has fallen back to monitoring the
workload itself (for instance, by checking target__none(target))?

> +		const char *cmd =3D strrchr(argv[0], '/');
> +
> +		if (cmd)
> +			cmd++;
> +		else
> +			cmd =3D argv[0];
> +
> +		if (!strcmp(cmd, "sleep")) {

[Severity: Low]
This isn't a bug, but should <string.h> be explicitly included in this file
to guarantee musl libc compatibility?

The perf subsystem guidelines require direct, explicit inclusion of POSIX
headers for libc functions like strcmp() and strrchr() to prevent musl
compilation failures. Relying on implicit inclusions can cause builds to
break in environments where headers strictly separate declarations.

> +			ui__warning("workload '%s' specified without the system-wide (-a) opt=
ion\n",
> +				    cmd);
> +		}
> +	}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806021038.2291=
417-1-irogers@google.com?part=3D1
