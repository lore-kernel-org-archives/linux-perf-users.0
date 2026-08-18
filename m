Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CED2AE7A
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094938; cv=none; b=TmUVPFyjNKlmdqq8qFfDibqMgkUjUcGIivYo30sxIKxAHTQ83kxE+ib0e+QxKsBxSqlVnRYeh4k22KWiFYoUdOPlfzMOKCzZMwla00KgMCTL6ER1Tj5/0rzdsrRPWyeA/a1SP42ViXor3JrCe8C8PohLRp6hmfLHU8OlKK+zUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094938; c=relaxed/simple;
	bh=hP+dUqn20J5SMOPZHmQqfdr89vn1ipmLCDhB7qZYVtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=knXeSxsbaG+6BXauS1mPDtC9UU8hyG8ANCtdthFx7SzAWSdGQ2207aw8rIJgEmTjPtzWXeUQhgy/mQecAi+REg4PfOmHlCNR1jTitKEgvXXiUKjBn+7OHJLmjLce7X6vw0akI7bMo1Yx3DzyYaTQGVwJ2aVueI0yed4QAJguWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOWgG2lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOWgG2lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7761F000E9;
	Tue, 18 Aug 2026 23:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787094936;
	bh=U2LRnkeYxDYkSepcBeWckv+LaI6sWg7YxhleaaZF1TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOWgG2lqSW4aeuUkqHbMT0LuLEJTHmrvJCnoLfYcj2RtUNA5e++HP/HjltIwKJZDa
	 shD/2he2h8ZLqAAnxtxkt+bd/MQ3kRUB+lIVHIxhDr7ORlX7ZvWbSZ37ubFkBJ1iWo
	 gQwsPRg3y5K1Qymu7UCXu8C6BCsb2lpLA6FM0rk2UM+6TL9ctfeXuVyE4skiznNkIi
	 nJHdW9DZSVDE6TfRB+mqkmgDsyxynEI/vmIvfBtNBc39s/MLGU1GdJWktmzAFApdP0
	 88DUjAH2UPYc78I8WVgwnEvEtBAzEN2Yc8Y15LMz8yszCFCqkwGgqb+3H8KzhCk9s6
	 PYZUbH7KP0JuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] perf tools: Add support for displaying weights
 in annotate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818230229.1491871-4-ak@linux.intel.com>
References: <20260818230229.1491871-1-ak@linux.intel.com>
 <20260818230229.1491871-4-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 23:15:36 +0000
Message-Id: <20260818231536.6E7761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The TUI browser width calculation omits cycle and branch counter=
 widths, leading to visual truncation.
- [Medium] Toggling weight columns globally freezes the weight mask for all=
 symbols, breaking accurate display.
- [Medium] Use of compile-time host architecture macros breaks cross-platfo=
rm analysis for weight modes.
- [Low] Typographical error in the `--weights` command-line option descript=
ion.
--

--- Patch [3]: [PATCH v4 3/4] perf tools: Add support for displaying weight=
s in annotate ---
commit 9eb5862996d191c9f87138b1476aa94808cc5008
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add support for displaying weights in annotate

Add support for showing all the three possible per IP weights in
annotate. The weights are shown by defaults if any are non zero. This
is useful, especially with the new insn lat statistics, but also
for all the existing weights.

Add a hotkey to the interactive browser to turn them off (w), as well
as a perf annotate command line option.

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 69cb72b2082a6..998f472152e2f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
[ ... ]
> @@ -719,6 +719,8 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
>  #endif
>  	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
> +	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
> +		    "Hide or hide weight columns in annotation. Default show if non ze=
ro."),

[Severity: Low]
This isn't a bug, but there is a typo in the help text here. "Hide or hide"
should probably be "Show or hide" to match the identical option added to
builtin-report.c.

> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index e47a467750890..16713d85db7c5 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
[ ... ]
> @@ -1091,6 +1093,15 @@ static int annotate_browser__run(struct annotate_b=
rowser *browser,
>  				symbol_conf.show_total_period =3D true;
>  			annotation__update_column_widths(notes);
>  			continue;
> +		case 'w':
> +			symbol_conf.annotate_weight =3D !symbol_conf.annotate_weight;
> +			symbol_conf.weight_mask_user =3D true;
> +			symbol_conf.weight_mask =3D !symbol_conf.annotate_weight ?
> +				0 : sym_hist__weight_mask(annotation__histogram(notes, evsel));

[Severity: Medium]
Does toggling weight columns globally freeze the weight mask for all symbol=
s?

Because symbol_conf is global, when the 'w' hotkey sets
symbol_conf.weight_mask_user to true, all subsequently viewed symbols will
use the frozen mask from this current symbol.

If a newly opened symbol has different weights (for example, WEIGHT_INSNLAT
instead of WEIGHT_WEIGHT), those relevant columns might incorrectly remain
hidden.

[ ... ]
> @@ -1228,7 +1239,7 @@ int __hist_entry__tui_annotate(struct hist_entry *h=
e, struct map_symbol *ms,
>  	browser.b.width =3D notes->src->widths.max_line_len;
>  	browser.b.nr_entries =3D notes->src->nr_entries;
>  	browser.b.entries =3D &notes->src->source;
> -	browser.b.width +=3D 18; /* Percentage */
> +	browser.b.width +=3D annotation__pcnt_width(notes, evsel);

[Severity: Medium]
Could this width calculation result in visual truncation of the TUI browser?

By replacing the hardcoded 18 with annotation__pcnt_width() in
__hist_entry__tui_annotate(), the browser width calculation remains strictly
bound to the percentage and weight columns. It doesn't appear to make any
allowance for the IPC, cycles, or branch counters that might be displayed.

If no weights are present, the padding drops significantly, which might set
the horizontal scroll limit too narrow to show the full annotated line.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index df70e95a84704..d4886e18275ef 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -778,6 +797,47 @@ static bool needs_type_info(struct annotated_data_ty=
pe *data_type)
>  	return (data_type !=3D &stackop_type) && (data_type !=3D &canary_type);
>  }
> =20
> +static const char *annotation__weight_mode_str(enum symbol__weight_mode =
mode)
> +{
> +	switch (mode) {
> +	case WEIGHT_NONE:
> +		return "";
> +	case WEIGHT_WEIGHT:
> +		return "Weight";
> +	case WEIGHT_INSNLAT:
> +		return "InsnLat";
> +	case WEIGHT_WEIGHT3:
> +#ifdef __powerpc__
> +		return "PCycleLat";
> +#elif defined(__x86_64__)
> +		return "RetireLat";
> +#else
> +		return "Weight3";
> +#endif

[Severity: Medium]
Does using compile-time host architecture macros break cross-platform
analysis for weight modes?

If an ARM64 host machine analyzes an x86_64 perf.data file, it will
incorrectly display "Weight3" instead of "RetireLat".

Would it be better to dynamically inspect the ELF machine constant
(e_machine) via the evsel or session structures instead of relying on host
compile-time macros?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818230229.1491=
871-1-ak@linux.intel.com?part=3D3
