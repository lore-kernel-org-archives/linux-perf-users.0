Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8DF1D8E01
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670937; cv=none; b=SQpGF2Y7YVuoFyZxs/87I/J38VN6MLBgRrCxizFXYTL8eEGBqegBykyFts6Y6xDATYZ9jBP8we5g8w758bT2hTGZWjThTLb6ru0BjWuERnv9jt3xSkeHf9kXWv9RhQTctf0APdMTLiQjY//Iwwhid5nrErfB/afBPWNSTJyzqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670937; c=relaxed/simple;
	bh=ho0nDnWgdzHpbGwgsDV3oqsMqJu2wH5ytJNtMDMMwWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TOsUAbDyh03zMlr84FziWfasOeoGfeBanwZTf8Eh16V7w4wgUYxLb7oRj4bUJrfMameyjizWtS+192zGETAmfeIJkc80hKKUTPxjgDVFrysrdKwLrLb8ZOAU5eO8Ziby7dObBtlOQ7v//J35Envwm1F7k4O/ZL0qfgUE5625yUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKCR4R4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKCR4R4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D9E1F000E9;
	Fri, 14 Aug 2026 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670935;
	bh=tLae4tQMx+SOgPz7lITNcP800CfjdMDxuTRp79DJKMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKCR4R4zZ6gpPg3la+yH+4ID7l6WrSMxQqwU0laA5SONibZaPS8NGp15im0cDVFYF
	 P5ll+AS+q9Vk+n4lwGo59M1BXvPiwODbPA9C1x1wcBZsSVPeiGL0LZweZY4RzsgJNj
	 BnAWN4ttLHpwE5SfeaAknoNsZpNWBrT9PDTWdKPW3O0H1DdJBA/5pJCc8dX3QsplwY
	 i3+t+kr3jDXcIfbteCXr4oBZ5WRSt66umYdbezSwNO5SnG0dtVGPldtpJRvnPFvqQz
	 BWAzQVbV8f3A/nFnKLo6mnoBjVqlqxmE4nxZVwdjn4xdRDJF/NSQeMyoc8CBKNkvzP
	 ahymzIM6gZk4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf tools: Add support for displaying weights
 in annotate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813211109.240689-4-ak@linux.intel.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-4-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:28:51 +0000
Message-Id: <20260814012855.89D9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Toggling the 'w' hotkey caches the current event's weight mask g=
lobally, corrupting weight column display for all subsequent symbols and ev=
ents.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is an out-=
of-bounds heap memory write in `symbol__annotate_zero_histogram()` when zer=
oing an event's histogram.
--

--- Patch [3]: [PATCH v2 3/4] perf tools: Add support for displaying weight=
s in annotate ---
commit 89fdbcaac6998b08ac6d1c7549a509183b024849
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add support for displaying weights in annotate

Add support for showing all the three possible per IP weights in
annotate. The weights are shown by defaults if any are non zero. This
is useful, especially with the new insn lat statistics, but also
for all the existing weights.

> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index e47a467750890..d6126a7d51e4a 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c

[ ... ]

> @@ -1091,6 +1093,15 @@ static int annotate_browser__run(struct annotate_b=
rowser *browser,
>  				symbol_conf.show_total_period =3D true;
>  			annotation__update_column_widths(notes);
>  			continue;
> +		case 'w':
> +			symbol_conf.hide_weight =3D !symbol_conf.hide_weight;
> +			symbol_conf.weight_mask_user =3D true;
> +			symbol_conf.weight_mask =3D symbol_conf.hide_weight ?
> +				0 : sym_hist__weight_mask(annotation__histogram(notes, evsel));
> +			browser->b.width =3D notes->src->widths.max_line_len +
> +					   annotation__pcnt_width(notes, evsel);
> +			ui_browser__refresh_dimensions(&browser->b);
> +			continue;

[ ... ]

> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index fa08d09b80f76..63bce7a920f32 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h

[ ... ]

> @@ -376,9 +391,22 @@ static inline int annotation__cycles_width(struct an=
notation *notes)
>  	return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH=
 : 0;
>  }
> =20
> -static inline int annotation__pcnt_width(struct annotation *notes)
> +static inline u8 annotation__weight_mask(struct annotation *notes,
> +					 const struct evsel *evsel)
> +{
> +	if (symbol_conf.weight_mask_user)
> +		return symbol_conf.weight_mask;

[Severity: Medium]
Will this globally cache the current event's dynamically generated weight m=
ask?

In annotate_browser__run(), pressing 'w' sets symbol_conf.weight_mask_user =
to
true and saves the mask. Returning that cached mask here seems to force all
subsequently viewed symbols and events to use this exact column layout.

If a different event has different weight types, or if in perf top new weig=
ht
types arrive after 'w' is pressed, would the UI incorrectly hide valid weig=
ht
columns or display empty zero-filled columns for missing weights?

> +	if (symbol_conf.hide_weight)
> +		return 0;
> +	return sym_hist__weight_mask(&notes->src->histograms[evsel->core.idx]);
> +}

[ ... ]

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index df70e95a84704..b636f54675a1e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c

[ ... ]

> @@ -1448,7 +1523,8 @@ int map_symbol__annotation_dump(struct map_symbol *=
ms, struct evsel *evsel,
>  	return err;
>  }
> =20
> -void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *e=
vsel)
> +void symbol__annotate_zero_histogram(struct symbol *sym,
> +				     struct evsel *evsel)
>  {
>  	struct annotation *notes =3D symbol__annotation(sym);
>  	struct sym_hist *h =3D annotation__histogram(notes, evsel);

[Severity: High]
This is a pre-existing issue, but does the memset in this function cause an
out-of-bounds heap memory write?

When profiling multiple events (e.g. perf top -e cycles,instructions) and
zeroing the histogram (e.g. pressing 'z'), this gets called for top->sym_ev=
sel:

void symbol__annotate_zero_histogram(...)
{
	...
	struct sym_hist *h =3D annotation__histogram(notes, evsel);

	memset(h, 0, sizeof(*notes->src->histograms) * notes->src->nr_histograms);
}

The pointer h is offset to the specific event's index, but the memset zeroes
an area equal to the size of the entire histograms array. Could this write
past the end of the heap allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813211109.2406=
89-1-ak@linux.intel.com?part=3D3
