Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48248035B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629891; cv=none; b=WZ0cv8C6+2fONgUS7T/TDMOxffE7a2UE1z9uEQ0JSpBU42NSq/7KppPu4bmDZpKenGc2P9idjllQwBR8v9ZypAynW1c9FvAqldTLCGGAr8CEduYxCWV6gdiQNrDxeqPQzGvEQV/lul4ryktILEr2FrgSsJZaTY9QMJuhOx0SsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629891; c=relaxed/simple;
	bh=OFzoLosrm4xBY0ULTxOxkaCtPOC3Mxt6tzAbxpNNKiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rYOHmafZfOlDPXXQ9s2a8RDAxC99dlBkJRj32oO1nhri+3dGjlayZYJTCaFDANP0o6Twx8LeaszTrlRs0CDotNU2fJV4ud2GjhHvL4/dOykFE25NIDovJp7IFg76ijoK277AiLhOhFUdc3SlcMW4ivFGwTrViO16gh+rCgPWkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6BxyEwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6BxyEwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031231F00A3A;
	Thu, 13 Aug 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629890;
	bh=qeg+6Fe1qjnoXoIKQ+T5tR3Jt0A1pM/cRTcmE0Kk8lM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6BxyEwtP+qnHcoNyaHnn3jIzseo/9BVNnEPpMMupfFWLK6hFYJ1N0n7vojohyraO
	 Bk9+Kmo0Jbne7Mak9O624xLqxLMZnmazcBx78z1xf+mKyxu6Ikm87v1QRy6R61qUs0
	 NmcgpaIlbCM5NK36G8YItkSXi+FUpCA/CZkvpyglOSTdYt9Ux100sRVMTbm1y33bMy
	 NfamOLf8zKF4Kyny9FYsMo7AW0xi7YcGMTIYZi1N2DJhCke67g4t/V/fjwpSOrPl+E
	 9wbIbvQowW/E1GJ9elb4jP2jila+rpZ44NlD2bc8PsycDH47y6UUdxfoiyoIv/2jEf
	 Li+uN4kRdHMKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] perf tools: Add support for displaying weights
 in annotate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813132907.50738-3-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
 <20260813132907.50738-3-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:04:49 +0000
Message-Id: <20260813140450.031231F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Variable shadowing by `for_each_weight` macro in `annotation_lin=
e__print` causes either premature loop termination or an infinite loop.
- [Medium] Asynchronous global modification of `symbol_conf.weight_mask` by=
 the background thread in `perf top` causes data races and defeats the user=
's hotkey toggle.
--

--- Patch [3]: [PATCH v1 3/4] perf tools: Add support for displaying weight=
s in annotate ---
commit 7947c9d694355b6721ccd7944dc41891a9968db4
Author: Andi Kleen <ak@linux.intel.com>
Date:   Thu Aug 13 13:29:06 2026 +0000

    perf tools: Add support for displaying weights in annotate
   =20
    Add support for showing all the three possible per IP weights in
    annotate. The weights are shown by defaults if any are non zero. This
    is useful, especially with the new insn lat statistics, but also
    for all the existing weights.

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 2888ac3b7b926..32bd6e23f6fdd 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -827,6 +827,7 @@ static void perf_event__process_sample(const struct p=
erf_tool *tool,
>  			top->vmlinux_warned =3D true;
>  		}
>  	}
> +	symbol_conf__set_weight_mode(&symbol_conf, sample);
> =20
>  	if (al.sym =3D=3D NULL ||
>  	    !symbol__is_idle(al.sym, al.map ? map__dso(al.map) : NULL, machine-=
>env)) {

[ ... ]

> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index e47a467750890..dada5fa6d29f2 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c

[ ... ]

> @@ -1091,6 +1092,14 @@ static int annotate_browser__run(struct annotate_b=
rowser *browser,
>  				symbol_conf.show_total_period =3D true;
>  			annotation__update_column_widths(notes);
>  			continue;
> +		case 'w':
> +			symbol_conf.hide_weight =3D !symbol_conf.hide_weight;
> +			symbol_conf.weight_mask =3D symbol_conf.hide_weight ? 0 :
> +				annotation__histogram(notes, evsel)->weight_mask;
> +			browser->b.width =3D notes->src->widths.max_line_len +
> +				annotation__pcnt_width(notes);
> +			ui_browser__refresh_dimensions(&browser->b);
> +			continue;

[ ... ]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 94f9c8faeddab..4b04320e35ecb 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -2763,3 +2763,14 @@ char *dso__demangle_sym(struct dso *dso, int kmodu=
le, const char *elf_name)
> =20
>  	return java_demangle_sym(elf_name, JAVA_DEMANGLE_NORET);
>  }
> +
> +void symbol_conf__set_weight_mode(struct symbol_conf *c,
> +				  struct perf_sample *sample)
> +{
> +	if (sample->weight)
> +		c->weight_mask |=3D BIT(WEIGHT_WEIGHT);
> +	if (sample->ins_lat)
> +		c->weight_mask |=3D BIT(WEIGHT_INSNLAT);
> +	if (sample->weight3)
> +		c->weight_mask |=3D BIT(WEIGHT_WEIGHT3);
> +}

[Severity: Medium]
In perf top, event processing runs in a background thread while the UI
runs in the foreground. When a user presses the 'w' hotkey, it sets
symbol_conf.weight_mask to 0.

However, the background thread constantly calls symbol_conf__set_weight_mod=
e()
for new samples, which unconditionally modifies symbol_conf.weight_mask
without checking if symbol_conf.hide_weight is set.

Could this data race cause the TUI to tear or miscalculate column widths,
effectively defeating the user's attempt to hide the weight columns?

[ ... ]

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index df70e95a84704..6be6ec47f298b 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c

[ ... ]

> @@ -845,6 +892,12 @@ annotation_line__print(struct annotation_line *al, s=
truct annotation_print_data
>  					      data->he.nr_samples);
>  			else
>  				color_fprintf(stdout, color, " %7.2f", percent);
> +			for_each_weight(i) {
> +				if (symbol_conf.weight_mask & BIT(i))
> +					color_fprintf(stdout, color, " %7" PRIu64,
> +							data->he.weight_num[i] ?
> +							data->he.weight_sum[i] / data->he.weight_num[i] : 0);
> +			}
>  		}

[Severity: Medium]
Will this for_each_weight(i) macro silently shadow and corrupt the outer
loop's iterator variable 'i'?

The outer loop in annotation_line__print() uses 'i' to iterate up to nr_per=
cent:

    for (i =3D 0; i < nr_percent; i++) {
        struct annotation_data *data =3D &al->data[i];
        ...
        for_each_weight(i) {
            ...
        }
    }

Since for_each_weight() expands to a for loop that reuses and resets 'i'
from WEIGHT_WEIGHT to WEIGHT_WEIGHT3, won't this cause either premature loop
termination (if nr_percent <=3D 5) or an infinite loop (if nr_percent > 5)
when processing event groups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813132907.5073=
8-1-ak@linux.intel.com?part=3D3
