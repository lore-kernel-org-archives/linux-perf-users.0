Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF3AFCFF
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887775; cv=none; b=HpXDCrgvhdY+7m8/kRPNcQKzNDhpPmbIzTCP1eDmIGViu15ODzcFVMpQac40NMfmgBmtoZCiXxopsTZE+RUvhynN5+A1FGmncxffjVXjog8HoVXGVyj0WhkOEjesaibkLlhrBtzkCLp24xGfLKdE28xAQVmj5ouTiSCers+a8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887775; c=relaxed/simple;
	bh=xNbwP1Bpq87cubxahqkeUvI97FQ5gz+s3HImi0RrA8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Swyp9JZFjqJAfKvJ7eH3tNURyfP17CuYwZzzbOspv4TZ3YvxYw5sx5/h6y66Sn53c6qwMazNOdrIon/VRn9w/8VIV6sXUicDFvFVIErOA5EtotxP78KQxi/TnK/PE75Et9tSZjCw5oirFIBm9CRmIEZXm9/YK4qmyo154RDReDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv4fVy6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv4fVy6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67671F000E9;
	Fri, 24 Jul 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887774;
	bh=m97HWWgo3aOxw1u1jp1iJl7ffxAMd5T2zkvLIsj3ZuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rv4fVy6AppiFUa+FnTCTKHjSB4XDfTi6muHqztFI8cR0yJY9vdrNRd7cQ2xdTttzJ
	 qGvJ6waobSlH/DnnGFwj7xs15j2WAUo4Gn+LfsQKuohCuyAtp1eCoYMPDMTLgg2C4Y
	 v/B9YEk4LIO8dsJ3fn9zhe7I2BvG4HjCNJPW4TIsfvXiFG1As7QXh5wBCEjAd5VtQk
	 5bQcqqMhnkBKd/b+C5apIm7a3k+OCHbbhqSlw2HMt+if7HGHn+atPbZ40D7aYS3bbO
	 4zEjiLXGcULZ+Dr4klxrcVl6qsqDnjj7OIsCKj4J6cczmU7mobN+btZhjRAWDBOR+F
	 heQyVWxmsDJLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] perf c2c: add column rendering for function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724095842.995920-4-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
 <20260724095842.995920-4-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:09:33 +0000
Message-Id: <20260724100933.C67671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The minimum column width logic (`cl_min`) is incorrectly guarded=
 by an upper-bound check (`width > SYMBOL_WIDTH`), causing silent truncatio=
n of cacheline addresses when level-1 function names are short.
--

--- Patch [3]: [PATCH v4 3/9] perf c2c: add column rendering for function v=
iew ---
commit 93e94f0dd4e849fd17843f49f904f0cf603d364c
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add column rendering for function view

This commit adds the column renderers for the perf c2c function view,
including Cycles %, Store count, and the single indented identity column
for functions and cachelines. It also adds helpers for width and header
calculations, and the estimated-cycles computation.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 3f6822f616004..4eda97894d1d4 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +static int symbol_width(struct hists *hists, struct sort_entry *se)
> +{
> +	int width =3D hists__col_len(hists, se->se_width_idx);
> +
> +	/*
> +	 * Cap long symbol names as the cacheline view does, but never below
> +	 * what a level-3 cacheline address needs (deepest indent + folded sign
> +	 * + "0x" + 16 hex digits), so the address is not truncated when the
> +	 * level-1 function names happen to be short.
> +	 */
> +	if (!c2c.symbol_full && width > SYMBOL_WIDTH) {
> +		int cl_min =3D 2 * C2C_FUNC_INDENT + C2C_FUNC_FOLD_WIDTH + 2 + 16;
> +
> +		width =3D max(SYMBOL_WIDTH, cl_min);
> +	}
> +
> +	return width;
> +}

[Severity: Medium]
Does this logic unintentionally skip the minimum bound calculation when the
symbol width is short?=20

The comment states that the width should be "never below what a level-3
cacheline address needs", but the calculation for cl_min is nested inside t=
he
upper-bound check (width > SYMBOL_WIDTH). If the longest level-1 function
name is short, this block is skipped entirely, leaving the width too small
to fit the cacheline address.

[ ... ]

> +static int
> +symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +		  struct hist_entry *he)
> +{

[ ... ]

> +	if (hist_entry__is_cacheline(he)) {
> +		/* Level 3: the shared cacheline address. */
> +		u64 addr =3D he->mem_info ?
> +			cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl) : 0;
> +		char symbuf[32];
> +
> +		scnprintf(symbuf, sizeof(symbuf), "0x%" PRIx64, addr);
> +		ret +=3D scnprintf(hpp->buf + ret, hpp->size - ret, "%-*.*s",
> +				 text_width, text_width, symbuf);

[Severity: Medium]
Will this actively truncate the cacheline address when the logic in
symbol_width() leaves text_width undersized?

Because the minimum width check fails to apply for short function names,
text_width will be too small to fit the 18-character cacheline address,
causing it to be silently truncated on display.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724095842.9959=
20-1-jiebin.sun@intel.com?part=3D3
