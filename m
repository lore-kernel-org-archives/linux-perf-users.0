Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A13A9623
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671818; cv=none; b=bhwhRCup01PZPEhohgkPz8IA/qxc4jJSeBa/EDUoiX8zCR14RP5tVJIJlq9r8pkMuzWU0dAT0YIyt2yDSAZ1KHPUAmUQad+2eXFEy0FOsiLThLfI7+1NH16SIIur0pbTGl2WNcuC+LCUAiyRaBmp6zJo1AxahLyeZhbTmDxjHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671818; c=relaxed/simple;
	bh=2LNmx9hKR68H49oTxvtAquj/G9h5IqO8ryCooUKncec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HWt/+VfERDQBbdaZB+FkznkkeN/VeKMLRdHNYR/kP2sc6sDCazM27RAk7G1KhgHuEpM2z/VEOQTOhNaYI3Urzs+zrIWEIlvLNG6rH0OUEV8VjkPTXFI8UYh/iMUFmPVTL2ylTGMKhKid7a2RpleYYyy7IawSaazfiI5hHxCpd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiRPMUqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiRPMUqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8717A1F000E9;
	Fri, 14 Aug 2026 01:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786671816;
	bh=KfZgYtmBHnKeDmWUGTAXCn465GCVqRJVsNDw/TPzlWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aiRPMUqkgDlDpQw4nud8TGSxu5I/GtIxuQlcpB2Tqjxl/oPjbgHs9jUUIjF+yK179
	 feSbNePLCKR86Z7dY90P1szQssUNhH+qn4tXfltx4eXGC8FVod6BnlgQSOupz3b64w
	 67+kh19qhom/rfUP+/OQQ0bzNZOuNwrVu2sAtZf3anpW0vP0pb0VgqRWyhu08jA1y9
	 d5oHce7YMCRrj2cXzM1tCTBz46HnKOIvkHZpdIWo1sz9zKdBJSqcsZvvTTRcK1a7Co
	 HX0L9y+NNGvhFBU1qEXBnS0ajUMrk4ytjc2+XVwLfAgjmUTQJmfIhTcoUPEJDmWWYz
	 sxOQaaaWoFTpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf tools: Add support for displaying weights
 in annotate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813214143.253418-4-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
 <20260813214143.253418-4-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:43:31 +0000
Message-Id: <20260814014336.8717A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 'w' hotkey caches the active event's weight mask into a glob=
al configuration variable, corrupting the display of weight columns for any=
 subsequently viewed events.
--

--- Patch [3]: [PATCH v3 3/4] perf tools: Add support for displaying weight=
s in annotate ---
commit 4886f581054e1fcacbf3f1649fad566092ced17b
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add support for displaying weights in annotate

This commit adds support for showing all three possible per-IP weights in
the annotation view, enabled by default if any are non-zero. It also
introduces a hotkey ('w') and a command line option to toggle these weight
columns.

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

[Severity: Medium]
Will caching the active event's weight mask into the global symbol_conf
corrupt the display for subsequently viewed events?

If the user toggles weights with 'w', symbol_conf.weight_mask_user is set
to true and the current event's mask is saved to the global
symbol_conf.weight_mask. If the user then opens an annotation for a
different event, it seems this stale global state will persist and
override the dynamic column visibility for the new event.

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
Because symbol_conf is a global variable, does applying it uniformly here
break the dynamic weight mask calculation for other events once the user
has triggered the hotkey?

> +	if (symbol_conf.hide_weight)
> +		return 0;
> +	return sym_hist__weight_mask(&notes->src->histograms[evsel->core.idx]);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813214143.2534=
18-1-ak@linux.intel.com?part=3D3
