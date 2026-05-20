Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35023F39EE
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301738; cv=none; b=aCfjZLoEkPaJJMJDNBp7yR0AcT+Su2j6BFbyaO36RQo4RVYVw24umB76W+60h667JrAS1ZysrlzjAvsLrOC8M7/hHDB0D0xw9eZ4ddRbbe4Jf5lwnM3Wdp7he5d051GwPPjMjKtiWy6laQIIGSB2PBt0YkXpD3okQ4hd+uqgBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301738; c=relaxed/simple;
	bh=FXtUHursAjX+uUSaK2K5KhCMCJJDsfVOX5IKIOKE0q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sLuPBNJ0ng4hjCO1XNVA/rvJbkBtvcf0zQEiSXwP820GM9ioz2mwL4fTHTTyXpJ5Or18pQkDpfvM6r0uLOpkVRExFUD9rR6yWfZYQKv3QOns5SE2iNMrTE7lEOUB9QkV8uwywdVYFYRyJ9024300EmNwuT3Sb7K9hk3sfZ6vTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvfKqDEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvfKqDEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B91F00893;
	Wed, 20 May 2026 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301736;
	bh=DLRcX6RgXWKKG6kC15E2Umv65wKad0daSZym0zVilWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvfKqDEOWnNDVX8C/BCtjNht2/B2fN4W6IRVWAS3+Ob1cUCzeFhFnzDxlyqazEa22
	 FsXEWKTog6PbPG3NMQTyLBBdbRS2Cjh4kjBEGXWJsKJiMSggUciYlP40DWEaNPn6bn
	 yQZg6y3i0qoJxzenu4PTYwDpA8cFmHtfD1+f98y62OT2QdUoALS5OtufIn47vstupE
	 GnLp0oy68qVuU0u4y5n0fn9g4MxX8WEy69NikZ8XEHmxrO75P9b1DwrI00OwsUyI7e
	 DIE/Tqy5cIU8Ow04SNyLUweWxC5P2vMxcDegN/g7CFv1WVOLpK+voT7iYG2/qf8zCf
	 wlGitde8iIg/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf stat: Add aggr_nr metric parser support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520180032.3045144-2-ctshao@google.com>
References: <20260520180032.3045144-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 18:28:55 +0000
Message-Id: <20260520182856.544B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect `aggr_nr` evaluation when an event fails to run (`aggr=
->counts.run =3D=3D 0`).
--

commit 7b8eacc795788823a2f1b5c16d96f2fc07c9fe23
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Add aggr_nr metric parser support

This commit introduces the aggr_nr function to the metric expression parser
to allow metric formulas to dynamically utilize the number of aggregated
targets. It updates the lexer, parser, and expression context helpers to
store and provide the aggregation count.

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -53,6 +53,7 @@ static int prepare_metric(struct perf_stat_config *conf=
ig,
> =20
>  	for (i =3D 0; metric_events[i]; i++) {
>  		int source_count =3D 0, tool_aggr_idx;
> +		int aggr_nr =3D 1;
>  		bool is_tool_time =3D
>  			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
>  		struct perf_stat_evsel *ps =3D metric_events[i]->stats;

[ ... ]

>  		} else {
>  			struct perf_stat_aggr *aggr =3D
>  				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
> =20
>  			if (aggr->counts.run =3D=3D 0) {
>  				val =3D NAN;
>  				source_count =3D 0;

[Severity: Medium]
Does this leave aggr_nr at its default initialized value of 1 when an event
fails to run?

When aggr->counts.run =3D=3D 0, source_count is explicitly set to 0. Since
aggr_nr skips evaluation in this branch, any metric expression utilizing
the aggr_nr function on an event that failed to run will evaluate to 1
instead of the correct aggregation topology size.

Should aggr_nr be set to 0 here to mirror source_count, or unconditionally
populated with aggr->nr?

>  			} else {
>  				val =3D aggr->counts.val;
>  				if (is_tool_time) {
>  					/* Convert time event nanoseconds to seconds. */
>  					val *=3D 1e-9;
>  				}
>  				if (!source_count)
>  					source_count =3D evsel__source_count(metric_events[i]);
> +				aggr_nr =3D aggr->nr ?: 1;
>  			}
>  		}
>  		n =3D strdup(evsel__metric_id(metric_events[i]));
>  		if (!n)
>  			return -ENOMEM;
> =20
> -		expr__add_id_val_source_count(pctx, n, val, source_count);
> +		expr__add_id_val_source_count_aggr_nr(pctx, n, val, source_count, aggr=
_nr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520180032.3045=
144-1-ctshao@google.com?part=3D1
