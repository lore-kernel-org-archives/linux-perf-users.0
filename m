Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51A26D4C3
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720490; cv=none; b=uWlVM+0zsoSnkDpHD5nxYqNjLRE7KkkTH/1PsUdjW9L4aldZ/Ie8u/AD4/HiYVavnRtIBVZGJQ6/Mp7CMdGTLlBUuEEx94qgK2WI91TNzv/NX+ciMz2NhnvTk6tVGulZVQAfPRJSzt8c30iGaUTBDctYw/EfQjRUGjUGNakA5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720490; c=relaxed/simple;
	bh=lNUXYIrXkSFJQEjEiGkcGgFJY5TPcp+/3WB92Ob9PxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hxD1crSagnWXigCk3PHhnLQJQHiYLdwS/ZmGykkO9vh1a8xV/tRHE2Xt1NO687952XbO+AK1YBAUsYCX1YeUdYQ9zhKPNpTvJOtP0+vZfid7LGqpMFXsWHBn5hAONKBsh0Yuy77wcEfwoV2irrfDksVQ1KR7gobQ8QbuQwzRmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csE0eeh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csE0eeh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F7C1F000E9;
	Mon,  3 Aug 2026 01:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785720488;
	bh=pLe0MdCkdQHGkWzz82VI44AgGxUIOIBK/4EZhdcXSWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csE0eeh0CnwEPpqmUqlHsyneZMW3amH635+PBbqJaNoQJ3g5Pg7qskWfn1S5M7mA5
	 y4jPAMJ1Rr3uyIjsk2WAbVjAUJVrdxhnqYtzdxzvfhCPSTtPnyijGKTwTxo2f6Y/+q
	 XBI+1QvBxR77EsZE1vJfQfn2yf9TiQyr0+xPih+294buP2HvHvCxuEzO+b2nasDQB+
	 dgEm7v0ofmPYmah9JmBoG6Kv97yyG1wVr3jUG8P1zsDvVcIUCCDPgB8+tN4e7fIHJj
	 h3K7wYMYWUI5eqZUGUJX5M9sfyPuzDxcP0hNwEy7yiQ6K3okE+IxCScB57YpGdrr6k
	 hvsoH87LuNoMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked
 caller errors in hpp_list__parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803011140.179943-2-acme@kernel.org>
References: <20260803011140.179943-1-acme@kernel.org>
 <20260803011140.179943-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 01:28:08 +0000
Message-Id: <20260803012808.51F7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added error handling `if (ret) goto out;` is bypassed =
because the `PARSE_LIST` macro silently masks non-terminal errors (like OOM=
) from individual tokens, undermining the commit's intended fix.

Pre-existing issues:
- [Low] Missing explicit POSIX standard header inclusions for libc function=
s.
--

--- Patch [1]: [PATCH 1/2] perf c2c: Fix error masking, OOM, and unchecked =
caller errors in hpp_list__parse() ---
commit 840153db94480f61d734e3e7494d6e8309bb2f8f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__=
parse()
   =20
This commit addresses error handling bugs in hpp_list__parse() where output
parsing errors were silently overwritten and OOM conditions for strdup() we=
re
ignored. It also fixes unhandled return values from c2c_hists__reinit() and
hists__iterate_cb() in the calling functions.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77a..df07e97155df2 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2093,8 +2093,18 @@ static int hpp_list__parse(struct perf_hpp_list *h=
pp_list,
>  	char *sort   =3D sort_   ? strdup(sort_) : NULL;
>  	int ret;
> =20
> +	/* strdup() returns NULL on OOM, don't silently treat as empty */
> +	if ((output_ && !output) || (sort_ && !sort)) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}

[Severity: Low]
This is a pre-existing issue, but does this file correctly include the POSIX
standard headers for the libc functions it uses? Functions like strdup() and
free() require <string.h> and <stdlib.h>. Relying on implicit inclusion
can cause build failures on musl libc systems.

>  	PARSE_LIST(output, c2c_hists__init_output);
> +	if (ret)
> +		goto out;

[Severity: Medium]
Will this properly catch all errors from the parsing callback? Looking at
the PARSE_LIST macro definition:

	ret =3D _fn(hpp_list, tok, env);
	if (ret =3D=3D -EINVAL) {
		pr_err("Invalid --fields key: '%s'", tok);
		break;
	} else if (ret =3D=3D -ESRCH) {
		pr_err("Unknown --fields key: '%s'", tok);
		break;
	}

If the callback returns an error like -1 due to an allocation failure on a
token that isn't the last in the list, the loop won't break. Does this mean
subsequent iterations could succeed and overwrite ret to 0, causing the new=
ly
added if (ret) goto out; check to be bypassed?

>  	PARSE_LIST(sort,   c2c_hists__init_sort);
> +	if (ret)
> +		goto out;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803011140.1799=
43-1-acme@kernel.org?part=3D1
