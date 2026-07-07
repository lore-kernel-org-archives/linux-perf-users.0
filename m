Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365503191C8
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396714; cv=none; b=Cip+PJZlW+KDWpzhNKSs/pVzD0/voDpHffRw1kukzN+4lJyqhXDcpY8lPbJkCmxBDa+WST0LxijxSOGwfCIXHkcVajMhdbS0gLG5saTAAtxnLacQ/Tv35rAnLFfqC54aZKvY1ABzwhaVMszZrq/7ufbMZ2CzsE1oG+zz6sig6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396714; c=relaxed/simple;
	bh=0gTTft1YCkpHh095hjtouOk2qACCnVkx4COGlC9XuQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bQPVTmHGnYZjfC99VzY+6uMOVY5d+qPHn+Oi1lQoFsheZzMVxVT6iHjaP+KdOJFccPLHlVIBe5BWaofqdX4VMAML7Bfy1ACKy6m5+NCgl82N4FjEt6ca/E29zOkHNeBbXpxY/yzhV0syvYPcsffVB7GSC4Q2NgHfcD+aMAm+1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0GPKoxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0GPKoxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0941F000E9;
	Tue,  7 Jul 2026 03:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783396712;
	bh=Wk1a9B7mjNt6uT6GE6A/RegNFqA7GtWrpAz+y89v8FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0GPKoxLpcDDHkUwwQZjuaJ42Cx8U7bRH+mVKYvPNaIeNbOH0vogpgkPiudcUT0d4
	 5xdl14Pf3fNsUneNGLotFC2pqVric2bpqaTElMyzxDYiCWSHeS6GQJj9y0iGaRay+O
	 uEnV4lCBj6I07koxlIMR1VNEDieA06Z4wFNU+Wqn8O9fe1onc6hsNGomRWkc3NorZv
	 yDBzRN+1p7so87NbO3fBxKHn1VJutkkvjna7MeKGkyeFajaCjfLDN/Rz4SOcq2d6ft
	 FCRNCOlygCugFmRb3UEmnFSmjyGSmoPzlgc6tXiYddz1ZYJFJqm4Z3sKjUBQy/vfq8
	 /C5OQBBe8tM/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] perf jevents: Add more components to the metric
 sorting order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260707034019.241762-2-irogers@google.com>
References: <20260707034019.241762-1-irogers@google.com>
 <20260707034019.241762-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 03:58:31 +0000
Message-Id: <20260707035832.6F0941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional access of `j.metric_expr.ToPerfJson()` can raise `Att=
ributeError: 'NoneType' object has no attribute 'ToPerfJson'` in `jevents.p=
y`, causing a build failure.
--

--- Patch [1]: [PATCH v1 1/3] perf jevents: Add more components to the metr=
ic sorting order ---
commit ef069542148ff8d19abeda05cc13982058eb11d7
Author: Ian Rogers <irogers@google.com>

perf jevents: Add more components to the metric sorting order

This commit modifies the sorting order for metrics in the jevents.py script
by including expressions and descriptions. The goal is to prevent
non-deterministic builds that were occurring when metrics were sorted only
by name.

Closes: https://lore.kernel.org/linux-perf-users/20260706175624.692736-1-na=
zar.kazakov@codethink.co.uk/

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 376dc2d241621..3c6cfeefbd5dc 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -570,13 +570,14 @@ static const struct pmu_table_entry {_pending_event=
s_tblname}[] =3D {{
>  def print_pending_metrics() -> None:
>    """Optionally close metrics table."""
> =20
> -  def metric_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
> +  def metric_cmp_key(j: JsonEvent) -> Tuple[str, str, str, str]:
>      def fix_none(s: Optional[str]) -> str:
>        if s is None:
>          return ''
>        return s
> =20
> -    return (j.desc is not None, fix_none(j.pmu), fix_none(j.metric_name))
> +    return (fix_none(j.pmu), fix_none(j.metric_name), j.metric_expr.ToPe=
rfJson(),
> +            fix_none(j.desc))

[Severity: Low]
Will this crash with an AttributeError if an event lacks a metric expressio=
n?

If a parsed JSON event specifies a MetricName but omits MetricExpr,
j.metric_expr will be None. Calling j.metric_expr.ToPerfJson() in this case
would cause the build script to fail.

Would it be safer to check if j.metric_expr is None before calling
ToPerfJson()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707034019.2417=
62-1-irogers@google.com?part=3D1
