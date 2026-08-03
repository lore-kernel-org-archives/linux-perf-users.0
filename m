Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D432AABD
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769351; cv=none; b=aFag85uAg6lLyqFvVscEOQtn4CSPLeUCpQOrQ/UfPwowfN+/Q2XcpZ9vtjYoELx5m11AcotZQh4MqCmglVfIQ2uMKR4rIac6rtFK1z8kcJt2ogOHGr0MuO3MUP6d6HD+sjhah6ahix9jBjAEZBH46ZiWDsGpZ6Ag7XzhvaIxSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769351; c=relaxed/simple;
	bh=A159jkiJhMX/tr3qLwetqw4uq7ZVnzUPgr/4p+c9gw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nMuSKzhqNX4jXfKRZM/5kpR8jZH2H4P9OF9PYtb8NIE8JDBG/GhB8pmxPaWPEq4otChPWWcbDLMA9MzJOIkVZeOSxhbUf65mYJsm+6817lL1yJHZrVEvZYDd28USVpCe8cd+c/1UGjeNmpbuPwvl0WZk+MRbnNM4qqZqrju3AQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8e7EadA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8e7EadA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB731F000E9;
	Mon,  3 Aug 2026 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769350;
	bh=yRYEurtSEOqkYr+MqmkdoLuT5xPlzwvFKznLi/A4nPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8e7EadA6Ik/wKLskjY71RYXkb6Lah8oUJ5eQFI4f/hjrqE3hb25UmoAGomfHuWq2
	 RTO6XMpRA+pJMS8rz65g5wX4iy444W3u0ZxmGLLv0JB6HrlC+NXNgwVy6/L0+SMTYI
	 JGZ06AY3mq3+H8D+MN3FiwkNRStz9Up0xklHZ8Ofdx6ZIN/foDkn8zUJlXY5nRJrSz
	 AUI7it7SBbEMtyE9ovFUGHOsWber/Oo6DD8PLAI8vI0D3Popk1VnZPx34B6M/lKnxh
	 bl2dfpIVd6hicw8Q3jeRxKgYV0m/s7i9etKao2HdNdWxFoZYXkumJIKl7+jsGweI/9
	 GzXQSlsOEbHTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803144119.185637-2-acme@kernel.org>
References: <20260803144119.185637-1-acme@kernel.org>
 <20260803144119.185637-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:02:29 +0000
Message-Id: <20260803150230.0AB731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `%m` format specifier is used in `__hpp_list__parse` to log =
generic callback errors, which can result in incorrect or stale error messa=
ges.
--

--- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked =
caller errors in hpp_list__parse() ---
commit 318c268818f1c0f5bf8bb06a4099029b27a33ee1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__=
parse()

This commit addresses multiple bugs in hpp_list__parse(). It ensures that e=
rrors
from output and sort parsing are not silently masked, handles OOM conditions
from strdup() correctly, and properly propagates failures out of the strtok=
 loop
and up the call chain.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..b0f2ba8318304 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[ ... ]
> @@ -2063,26 +2065,34 @@ static int c2c_hists__init_sort(struct perf_hpp_l=
ist *hpp_list, char *name, stru
[ ... ]
> +static int __hpp_list__parse(struct perf_hpp_list *hpp_list, char *_list=
, struct perf_env *env,
> +			     int (*_fn)(struct perf_hpp_list *hpp_list, char *name, struct pe=
rf_env *env))
> +{
> +	char *tmp, *tok;
> +	int ret =3D 0;
> +
> +	if (!_list)
> +		return 0;
> +
> +	for (tok =3D strtok_r(_list, ", ", &tmp); tok; tok =3D strtok_r(NULL, "=
, ", &tmp)) {
> +		ret =3D _fn(hpp_list, tok, env);
> +		switch (ret) {
> +		case 0:
> +			continue;
> +		case -EINVAL:
> +			pr_err("Invalid --fields key: `%s'", tok);
> +			goto out;
> +		case -ESRCH:
> +			pr_err("Unknown --fields key: `%s'", tok);
> +			goto out;
> +		default:
> +			pr_err("%m for --fields key: `%s'", tok);

[Severity: Medium]
Will %m print the correct error message here?

The _fn callback returns a negative error code in ret (such as -ENOMEM), bu=
t it
does not necessarily set errno.

Even if it did, if the callback or its callees log anything, functions call=
ed
internally by pr_err() (like fprintf or localtime_r) can clobber errno even=
 on
success. This could cause %m to print a stale or incorrect error string (e.=
g.,
"No such file or directory" instead of "Cannot allocate memory").

Could we format the string using the actual error code available in ret ins=
tead
of relying on the implicit global errno variable?

> +			goto out;
> +		}
> +	}
> +out:
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803144119.1856=
37-1-acme@kernel.org?part=3D1
