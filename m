Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B8474267
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629441; cv=none; b=NbAESIQglDZNGnRbvbhBIiwb7aMiqVEsdfr1v0G5Hb8rCS3qjR23QcSQ+g1Zz22mN60HV7kobfI7bjs06wFRAxlxiLfiuhAcodVhdgcfd3HXnN4nTO6iB3TUowQFg6DiRWoXdQYJ6/lQ9hsT60GF2DlsgSk6BjJEAVqGpWIR5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629441; c=relaxed/simple;
	bh=q0Nwng/Y33bDcBTgMl3COJwEBCPNhZg2kxhF4i0BXvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvvKO7gYB2JjIF9iJG2KSU1zp1frhl/qNpX4Hz3bK5RiMeF8Qn6BP9crcaglNxNoEL7jyd/bCyoZTIy4aabNvAtIMm8+ZSnF356Q7yXLqgiTBa9d679co5Oq0AH3tnbja60/v8x8dbHIf8cdi4tjL0QTRePwkBpGBSxXUJXiUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8S6K7Ml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8S6K7Ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799271F000E9;
	Thu, 13 Aug 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629440;
	bh=4O0c+OjgJ+TpMjimp+5xCAbHRE/ee9NCziYUILVSJc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8S6K7MlKOAqpfaFDB3TLjxGNHzdpXwNb/appxDglBc+pxOFT+OZQudN6OPsi0fbn
	 XwuZ2Bc6+hUBJzqn4KmO6mTkcM7D8MoHKqyG/F82oc31rB+/E+/ER/mcYjxnBKeqpV
	 2spiDf8oCHsHv1tVO7+toriicgrKgtfDyb5pUZ+ukT+zZX6t7sPjrnXcn5owrPH8h/
	 6YSrKYmH2aWa1KSf6E30dletobCFIxzf3wkp1NmJeltceLcQ/F0DBEkLfWQvwSY5cR
	 rK2IMHTEntWQNWhm+i62SIghh9ttUV9SO4OTULrws4G4h8Abp9pU9o0emTaORGlgMZ
	 66V6tqn6tkFFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813132519.4099508-1-andi@firstfloor.org>
References: <20260813132519.4099508-1-andi@firstfloor.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:57:20 +0000
Message-Id: <20260813135720.799271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect `total_period` calculation in `hist_entry__get_percent=
_limit` for hybrid merged entries artificially inflates symbol percentages =
and breaks the `--percent-limit` filter.
- [Medium] Dummy events are improperly added to the hybrid merged event gro=
up, resulting in unwanted empty columns in the perf top display.
--

--- Patch [1]: [PATCH v1] perf top: Merge hybrid common events ---
commit 49ec7e29ca8d51aba244d3542196da5fbe98b440
Author: Andi Kleen <ak@kernel.org>

    perf top: Merge hybrid common events
   =20
    This patch automatically merges the two PMUs when the event is present
    in both PMUs for simple TYPE_HARDWARE cases, like cycles. The behavior
    can be disabled with --no-hybrid-merge.

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1211401616ee3..19dec094683b3 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
[ ... ]
> @@ -1334,6 +1334,19 @@ static int __cmd_top(struct perf_top *top)
>  	 */
>          if (!target__none(&opts->target))
>  		evlist__enable(top->evlist);
> +	if (top->hybrid_merge && !symbol_conf.report_hierarchy &&
> +	    evlist__can_merge_hybrid(top->evlist)) {
> +		struct evsel *leader =3D evlist__first(top->evlist);
> +
> +		/*
> +		 * Merged events are not true groups, but can use
> +		 * the existing group display code to display them
> +		 * anyways.
> +		 */
> +		__perf_evlist__set_leader(&top->evlist->core.entries, &leader->core);

[Severity: Medium]
Does __perf_evlist__set_leader() unconditionally force all events in the
evlist, including dummy events, into the merged group?

While evlist__can_merge_hybrid() correctly skips dummy events, this assignm=
ent
appears to include them anyway. This results in the dummy events improperly
being added to the group, creating unwanted empty columns in the perf top
display.

> +		evsel__hists(leader)->merge_entries =3D true;
> +		symbol_conf.event_group =3D true;
> +	}
> =20
>  	ret =3D -1;
>  	if (pthread_create(&thread_process, NULL, process_thread, top)) {
[ ... ]
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index b830cbe7f95bf..a9dd423ded5e1 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
[ ... ]
> @@ -435,14 +436,26 @@ int hists__unlink(struct hists *hists);
> =20
>  static inline float hist_entry__get_percent_limit(struct hist_entry *he)
>  {
> +	struct hist_entry *pair;
>  	u64 period =3D he->stat.period;
>  	u64 total_period =3D hists__total_period(he->hists);
> =20
> +	if (he->hists->merge_entries) {
> +		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
> +			period +=3D pair->stat.period;
> +			total_period +=3D hists__total_period(pair->hists);
> +		}
> +	}
> +

[Severity: Medium]
Does this loop conditionally sum total_period based on the existence of a
paired entry, thereby under-calculating the global denominator for symbols
that were not hit on all PMUs?

If the denominator shrinks dynamically for asymmetric hits, it would
artificially inflate symbol percentages and break the --percent-limit filte=
r.

>  	if (unlikely(total_period =3D=3D 0))
>  		return 0;
> =20
> -	if (symbol_conf.cumulate_callchain)
> +	if (symbol_conf.cumulate_callchain) {
>  		period =3D he->stat_acc->period;
> +		if (he->hists->merge_entries)
> +			list_for_each_entry(pair, &he->pairs.head, pairs.node)
> +				period +=3D pair->stat_acc->period;
> +	}
> =20
>  	return period * 100.0 / total_period;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813132519.4099=
508-1-andi@firstfloor.org?part=3D1
