Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0B3E7BB0
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554420; cv=none; b=VSftTshJpCEhvnX+/T6XonOukc8EW2CHrzZ/DPC8RcjpMnzjOP3FdHYmwke1aYpVyzvyR3qVmTcZQUGW564cumbB34/6vkZ5ejZAl1iCpPaxXfSiUqxn0zPXbJRPmWW8m2xio2Rflzqj6nIWalcYNEru8hpSrE/75L8TjRO0L5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554420; c=relaxed/simple;
	bh=0R/OPlxGbKOvKuISeim8Y+JtNeAAsk5zB/AflKXG5eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F1D3NxSeKejl1xz2sJzc5wbZ9XmRPa0XI7kEUOTU5aeBWAd6pEZ4kgqHhUftpw39VjPWG5oZdE6xWeIP8B8jbm8gFHZkl54ByZr3HyiOOGtGnT9GBHIHlYSicgCdVIP7nqy6qdxMFnECnAskxrtubhyLi9snJWo98RAkAJHsWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ4eY7rI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ4eY7rI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985AA1F00A3D;
	Mon, 24 Aug 2026 06:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554418;
	bh=qTcI3WTocTNtASwnjeX/o1Etzjrmol5SB78ukx3G13k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQ4eY7rI44Wq80hem5EbXN3Z9FDeBc+jarW/7PBJzG4MitaIR/cTsqR+Al4x9ltK1
	 smreZlUNB8Mf8WTqnTmsXeRO+N9WzFseG5DsHNlCnxIYRp7BhqPVMs1oIPxp0dzKlf
	 o0glXR5cNInS7chS8vmqlI/BrwmMzPP1UYSpuzs/W5xEZmHfhWC0fh4GOiRTLDagdf
	 LfEcs4evFhVTVBriiBwGcD40RJtgiDUs4IS9c5cjxg67ormI+tKOG7QxLL5gkBATD0
	 7eoBaf11k/n6bDjDQq69S4oYt6xM6P30AJ4qmI1OIi6dttvmGKRlF8a5U/tXMqS4S+
	 2cYyCfV5v8BGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] perf ui hist: Format group headers iteratively
 based on proportional visual allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-7-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:53:38 +0000
Message-Id: <20260824065338.985AA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Truncation of the `buf` array causes severe visual misalignment =
of columns when printing group event headers.
--

--- Patch [6]: [PATCH v1 6/7] perf ui hist: Format group headers iterativel=
y based on proportional visual allocations ---
commit fb91b42310113a183352643a9b299c122e218ea8
Author: Ian Rogers <irogers@google.com>

perf ui hist: Format group headers iteratively based on proportional visual=
 allocations

Forcefully calculate proportional visual allocations only natively for
the 'Total' merge target header instead of uniformly ballooning array
spacings. Unpack strings directly into the primary column width fn.

> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 09f0baa808e0a..02c188100b098 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c

[ ... ]

> @@ -421,8 +458,25 @@ static int hpp__header_fn(struct perf_hpp_fmt *fmt, =
struct perf_hpp *hpp,
>  	int len =3D hpp__width_fn(fmt, hpp, hists);
>  	const char *hdr =3D "";
> =20
> -	if (line =3D=3D hists->hpp_list->nr_header_lines - 1)
> +	if (line =3D=3D hists->hpp_list->nr_header_lines - 1) {
>  		hdr =3D fmt->name;
> +		if (hists->merge_entries && &fmt->list =3D=3D hists->hpp_list->fields.=
next) {
> +			char buf[1024];
> +			int w =3D 0;
> +			int f_len =3D fmt->user_len ?: fmt->len;
> +			struct evsel *pos, *evsel =3D hists_to_evsel(hists);
> +
> +			w +=3D scnprintf(buf + w, sizeof(buf) - w, "%*.*s", f_len, f_len, fmt=
->name);
> +			for_each_group_evsel(pos, evsel) {
> +				if (symbol_conf.skip_empty &&
> +			    evsel__hists(pos)->stats.nr_samples =3D=3D 0)
> +					continue;
> +				w +=3D scnprintf(buf + w, sizeof(buf) - w, " %*.*s",
> +					       f_len - 1, f_len - 1, evsel__name(pos));
> +			}
> +			return scnprintf(hpp->buf, hpp->size, "%*s", len, buf);

[Severity: Medium]
If the event group has many members (e.g., from a hybrid merge), can the
concatenated header string exceed the 1024 byte limit of buf array?

If the array truncates the string, but len is calculated from the total wid=
th
of all members, won't this cause the %*s specifier to right-justify the
truncated string within the larger len field?

Could this result in padding the string with leading spaces and cause severe
visual misalignment of columns in the UI output?

> +		}
> +	}
> =20
>  	return scnprintf(hpp->buf, hpp->size, "%*s", len, hdr);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D6
