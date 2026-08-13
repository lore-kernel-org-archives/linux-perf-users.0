Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECA481FAF
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630736; cv=none; b=OHorfxFpEIUR4WksBNLJ/WEOx6sOQZKSu/YCnZDZSbEzSGUZUrvWp8XkHTrq53H4k0/RymHaiT964cjM2TnOC0h/secc+QPEwYSeg2R/diJWTrLO1U2YIdZxqi6FVYmRSOGoj0sl66/b0HMHfGxhaQhlE+6D1SAHyBTl6lcd8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630736; c=relaxed/simple;
	bh=w/Gevw3a0yvKVZs7ny88eF2tIq2TbSgBWBpVPzlEgHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W1bFWoJUKlmDtaIXS6++PMwfqrRbIg1iJubREPLXMAqk1p3j7xFhtS+M1qaM7sZ3FyYoumADB+cTUGl6H3766OfDY61b0z7xSxt0jdZ3lczzyY9LeHmPNILWUdkufdd1FSkdfKOD1G6D0DJiLLhsHamv93NLafHbLpUJNZPNYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcYiCzdn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcYiCzdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463931F000E9;
	Thu, 13 Aug 2026 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630734;
	bh=2mSDHM6YqCpeB0oJPiVgRfCl6CiTNzF8VW4JsyEhp8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcYiCzdnTEsbEqQLK+yUF5tQlCs3B1I8WCs3/16ahBQfZgUW/gidHyUIANrgXrmX7
	 P19cUpldx0Fs0v3wB7nL9am4kGtiBZoRSk4dr1+tMCVYqobPjjUR3kJjalH0HN7w8i
	 D5G4LMBE6Wa8O+srDhOVszbKsp7iozk8F+Er8cfVzzAAo5DU8V8WdoQnRtNGDXwa2s
	 BgQzvLm0sB/VMG2cHOWcHS29XID+rgTKj/qffm694Nx8UZHyYx1L2SJ3W2nJCsXPrE
	 RmhZNjGXaU8/VSoMIK0bdrCkClzYuGb/RtDzGeAYYlSNl/SkYqKFwPf8QEIEbPZvaS
	 9aMK5yOz6RtsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] perf tools: Add test for weight annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813132907.50738-4-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
 <20260813132907.50738-4-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:18:53 +0000
Message-Id: <20260813141854.463931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Background thread in perf top continually overwrites the TUI use=
r preference for displaying weight columns due to an unprotected data race.
--

--- Patch [4]: [PATCH v1 4/4] perf tools: Add test for weight annotation ---
commit 7947c9d694355b6721ccd7944dc41891a9968db4
Author: Andi Kleen <ak@linux.intel.com>

perf tools: Add support for displaying weights in annotate

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

[Severity: Medium]
Will this background sample processing thread concurrently overwrite the TUI
user preference for displaying weight columns?

The TUI thread modifies the global symbol_conf structure when the user atte=
mpts
to hide the weight columns. If the background thread is continually calling
symbol_conf__set_weight_mode() on every sample without locking, it appears =
the
user's preference could get immediately overridden, causing the TUI to flic=
ker
or misalign columns.

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

[Severity: Medium]
Could this unprotected update to the global symbol_conf.weight_mask race wi=
th
the background thread's read-modify-write operations?

[ ... ]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 94f9c8faeddab..4b04320e35ecb 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> +void symbol_conf__set_weight_mode(struct symbol_conf *c,
> +				  struct perf_sample *sample)
> +{
> +	if (sample->weight)
> +		c->weight_mask |=3D BIT(WEIGHT_WEIGHT);

[Severity: Medium]
Does this unprotected read-modify-write on the global symbol_conf structure
corrupt the state when called concurrently with the TUI thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813132907.5073=
8-1-ak@linux.intel.com?part=3D4
