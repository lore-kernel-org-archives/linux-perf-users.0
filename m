Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD03DAAC5
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995057; cv=none; b=CLIbKAFSH9ZzMqy88xQygwG+8ZFsh0iufkCQ9aL4Nk5Rja3J5aDqkwvWq259eDIpQQ8jS7KJjS+fWvXSK2qJ3drdBdUFCh+VrB6caQLpZORkaFeDm3XZx/sFNtwy3FaaaRPZ8ESoC6N0tnfZ6vfAvW9hAYFrFzHp2VpxBo1BWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995057; c=relaxed/simple;
	bh=ir9ywnr5km0IOS0vNEnKE7da8tBfu9wgQq3+6aKSRPY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ETiuTOEYK7+d3XNhznMqOJU76dzAXXWDkO8R6Li3yrfmEga5Cd5ouBdWjbl81xYRXh0spIgE0bCCerAdknHFHzfEwWg/6qd37oFKo5QX54d2KTEWFici66tJ21vl2RJx2Ui7KkrIoC/xpHTL7G+OZqLPvLY0HK2AEUK0BYkdfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJPXleIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJPXleIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCC31F000C4;
	Wed, 14 Oct 2026 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995055;
	bh=APiI9BFVq3ShcMbzfPIZf/DAzkOCu/OB7wxLAbwH4Hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJPXleIyhB1DXADTd/hlbsMLxnMb69UQwvc5aYUWd5Kh3q47/j1WzL22kOK8TjtiY
	 obfRJpSG1nhuzj+A4sReY9vduiyDLMUojolgXFZxp+JDHrQavYxdPlJBonrNrKrhNk
	 e14neWBa925F3xNjutPqxbBF8IExJeYCLTzvqHyeJcmCBB68aEYOt0dvXVHVUlzOkd
	 Z11GCeBTNfFQPvzFtcALaUBOhGgD+h94sc21pwOR73HljtIkwQAtK20elDPUuc0OSX
	 5aMwM3sGQt+c150AxjinzXDhZqpBG4TVoTo3sfoQuw1CCnf/AfedUybcog2JBYjOqk
	 9qoXjp//plR/w==
Message-ID: <sashiko-outbox-171524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 2/5] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014161457.373253-3-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:24:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: build failure due to unused variable 'endptr'
--

commit 8db97766d362752b2eec14b113b39acd9e702f2a
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support filtering return address comments

This commit introduces support for filtering out return address comments fr=
om
function graph trace output in perf ftrace. It adds the --filter-retaddr fl=
ag
and implements the parsing and filtering logic.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> new file mode 100644
> index 0000000000000..344d36293f5ca
> --- /dev/null
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> +bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_le=
n, u64 *offset)
> +{
> +	const char *p =3D strstr(str, "<-");
> +	const char *plus;
> +	const char *bracket;
> +	char *endptr;
> +	size_t name_len;
[ ... ]
> +	memcpy(sym_name, p, name_len);
> +	sym_name[name_len] =3D '\0';
> +
> +	*offset =3D strtoull(plus + 1, &endptr, 16);

[Severity: Low]
Will this cause a build failure due to an unused variable?

The tools/perf build system enables -Werror by default, which elevates
-Wunused-but-set-variable to a build failure. The local variable endptr
is written to by strtoull() but is never subsequently read or evaluated.

Could we pass NULL to strtoull() instead to resolve this and avoid breaking
the build?

> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161457.3732=
53-1-atomlin@atomlin.com?part=3D2
