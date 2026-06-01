Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1D3438AA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298352; cv=none; b=c4P/cFd8hbQkaPVVJiqMNmUaVv89kbwQ9JZ7SamHnyhuIqn1KlJd5EOFxJYFn8Z+4TnXOUpTC+qv9781PzAHh/6lgjTZ4UmAqtiq0eYx2PwqsAe21rmVjjVEENd1FbuNJ+Hiz6rglM4Cuc/YFmdsV7D0jBE6l1nVdkM0zRLODB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298352; c=relaxed/simple;
	bh=J/yVW+MlN1z0zlXX39g9rbAYqqxT/UF297SzqxfIQEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uHtfTLi+9QN94ccullaeP715KVk8crAP8bnE75np9mbJZ+X1BTvU3+2jD9jaWKNvFKF6O73KMhKuWr1U1120SrcI9B31Yea1FLZfYh78BQ2tFTYl2y6/VDkesi0FuBlQSKKkXY8q/dQekkqFfHJk3gon6BtlyVeo8UOxtLKQybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4jkYinb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4jkYinb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5EC1F00893;
	Mon,  1 Jun 2026 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780298351;
	bh=gA+u7ZdB6z9Hp+kA73cjiM10GOpelginb31iASvcryM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W4jkYinboZZ9l9YyQYKUu7vJFxguQ4ElhgGKqo/WJxTBfjKRv0JJyb6y5qs8hkz7q
	 +5hwyzMwdAOaKxOg4VFefOcjLMDQ8JvxSC2i39Fkv4aG8py0Td5zNSsWWUE1+26xup
	 XcgQNjn9uzxBHuECsRVvyF0hQ48+9LwTax0OKHxs9mwXhVGdH0SFC4C0BfzaJol7mA
	 Nqo7KL6Mo6ALhE9KnmwQ0eJAvWXenBdaQjq+JxEJq7rqY2y35yjGsqP6prAHkF5541
	 f3MJ5j/4+b+dmjKGRpCTW3HR/wFbU8EXPC+kSwkwfQVl09ynjtsI3Cn8A+C/8KUUy9
	 Ae4V3Fx0P3ozQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/18] perf symbol: Add setters for bitfields
 sharing a byte to avoid concurrent update issues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-18-irogers@google.com>
References: <20260601065407.1597927-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:19:10 +0000
Message-Id: <20260601071910.DF5EC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a fatal compilation error in `builtin-top.c` d=
ue to a parameter mismatch in the `symbol__is_idle` function call.
--

commit 62331f0aa0a35ba8f2806e0464aab89357756f5f
Author: Ian Rogers <irogers@google.com>
Subject: perf symbol: Add setters for bitfields sharing a byte to avoid con=
current update issues

This commit replaces direct bitfield accesses in struct symbol with atomic
operations to prevent lost updates due to concurrency. Accessors and setters
are introduced to safely read and update the symbol flags.

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index c8474f7ac6580..35b57a8313624 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
[ ... ]
> @@ -828,7 +828,7 @@ static void perf_event__process_sample(const struct p=
erf_tool *tool,
>  		}
>  	}
> =20
> -	if (al.sym =3D=3D NULL || !al.sym->idle) {
> +	if (al.sym =3D=3D NULL || !symbol__is_idle(al.sym, al.map ? map__dso(al=
.map) : NULL, machine->env)) {

[Severity: Low]
Does this code cause a compilation error?

The function symbol__is_idle() is declared in tools/perf/util/symbol.h as
taking only a single argument, but here it is being called with three
arguments. It looks like changes from a later patch might have leaked into
this commit.

Note that this build failure is fixed later in the series by commit
68dda82c5f09 (perf symbol: Lazily compute idle).

>  		struct hists *hists =3D evsel__hists(sample->evsel);
>  		struct hist_entry_iter iter =3D {

> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 95592779eb77c..cd760f40676a9 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
[ ... ]
> @@ -92,6 +97,49 @@ struct symbol {
[ ... ]
> +bool symbol__is_idle(const struct symbol *sym);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D17
