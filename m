Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AF1A5B9E
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731496; cv=none; b=A/Hbfn3ksmDnU0HL1WDudXiR3EXll3l48AniGb69LRbAbcM2QbJlKVquWDncmkAHUUGIJ9qa29am8AYCxaAE5/qTY38w0LzoWFp904d8brExj+v7MDBfiXY+ffCdO5uPujxaoLzF2JvwGTxB5fiOdCO7HsCE6tCS8BL/ExLIu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731496; c=relaxed/simple;
	bh=OcON2o9DgLlFaTOicA2FpdLoMHMS4B8rNHrPwa+zDR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mfAilZb9NanatyZMD0qEKuA8Mad1WYipYR5g1ruJQ8KmkLG9FVTPtnc9K1rIynS51k+vTvLxPPyH9p2O/vYA45NDAeWb5iwsAxeO5J/83SBBGnt+gK5e77+Yc1GCH2kGWHfOGqhVxJTIxk3FjfYHuQqGcn3BoNpq3m1rzLzUs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1Crje4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1Crje4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078171F00893;
	Sat,  6 Jun 2026 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780731495;
	bh=d26Yy4xli2lom7bMOOP2OAE+A82SM/J/jKNeXEKYhV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1Crje4DqjhOvhfBlm9wNVfIhwe2S0cp6bkw68M/6vu1W0tOS0PbMRfaV4qrEvmxG
	 1MvuDGGJX1eWMHq4U3+IZfA8wgMj/RJVEOFkzQLrRW0iOH+7DgzigiQXWpd41Hb9oP
	 Lu+BoJPClT/WPuECDywzr4pA3r2XiS8DGgGsSVVQruAbQyTpjwBP939bjBq4C1Tcc/
	 PPiIt7cOnR1kvcsj43qTiO4bz+csS3HnYudaMKVjArbkV4qN2MDI1lD70CzydOHbBb
	 Wvst4jybRR6Y+QmpiNrSdJtSNSO2mdogqNXYStT113NWsO3/7b7HM49qhvi/dXvlag
	 EZ6WB6Lc7zGgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606072125.2786845-3-irogers@google.com>
References: <20260606072125.2786845-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 07:38:14 +0000
Message-Id: <20260606073815.078171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unvalidated writes to `config1` and `config2` in `perf_event__repi=
pe_attr` cause a heap buffer overflow for older ABI events.
- [High] Asymmetric computation for kernel mappings without an associated D=
SO causes massive address overflows on lookup.
--

commit 493cc968b1147b3f20e3102e4ae64844207831a1
Author: Ian Rogers <irogers@google.com>
perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

This patch adds an ASLR tool to perf inject, allowing it to remap virtual
addresses or drop sensitive data to prevent leaking a machine's ASLR layout
when sharing perf.data files. It implements core ASLR remapping and tracking
for metadata events like MMAP, FORK, and KSYMBOL. Sample events are
currently delegated without remapping.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 75ffe31d03fea..6ac6e6fb3b47e 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -242,8 +245,35 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  	if (!inject->output.is_pipe)
>  		return 0;
> =20
> -	if (!inject->itrace_synth_opts.set)
> +	if (!inject->itrace_synth_opts.set) {
> +		if (inject->aslr) {
> +			union perf_event *stripped_event =3D malloc(event->header.size);
> +			int err;
> +
> +			if (!stripped_event)
> +				return -ENOMEM;
> +			memcpy(stripped_event, event, event->header.size);
> +			stripped_event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +
> +			if (stripped_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT) {
> +				stripped_event->attr.attr.bp_addr =3D 0;
> +			} else if (stripped_event->attr.attr.type >=3D PERF_TYPE_MAX) {
> +				struct perf_pmu *pmu;
> +
> +				pmu =3D perf_pmus__find_by_type(stripped_event->attr.attr.type);
> +				if (pmu && (!strcmp(pmu->name, "kprobe") ||
> +					    !strcmp(pmu->name, "uprobe"))) {
> +					stripped_event->attr.attr.config1 =3D 0;
> +					stripped_event->attr.attr.config2 =3D 0;
> +				}
> +			}
> +
> +			err =3D perf_event__repipe_synth(tool, stripped_event);
> +			free(stripped_event);
> +			return err;
> +		}

[Severity: High]
Does this code risk a heap buffer overflow for older ABI events?

In perf_event__repipe_attr(), the stripped_event buffer is allocated with
event->header.size. For older ABI0 perf.data files, this size can be as sma=
ll
as 72 bytes.

The code here unconditionally writes to bp_addr (at offset 88), config1
(offset 88), and config2 (offset 96) for relevant events, without verifying=
 if
event->header.size is large enough to contain these fields. Could this write
up to 32 bytes past the end of the stripped_event heap allocation?

[ ... ]
> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..16537e0e1bbb4
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -0,0 +1,718 @@
[ ... ]
> +static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
> +				      struct thread *aslr_thread,
> +				      u8 cpumode, u64 start,
> +				      u64 len, u64 pgoff)
> +{
[ ... ]
> +	if (hashmap__find(&aslr->remap_addresses, &remap_key, &remapped_invaria=
nt_ptr)) {
> +		/* Mmap already exists. */
> +		u64 calculated_max;
> +
> +		if (al.map) {
> +			remap_addr =3D *remapped_invariant_ptr + map__pgoff(al.map) +
> +				     (start - map__start(al.map));
> +		} else {
> +			remap_addr =3D *remapped_invariant_ptr + pgoff;
> +		}

[Severity: High]
Does this lookup path correctly handle the invariant when al.map is NULL?

If al.map is NULL, remap_addr is computed as *remapped_invariant_ptr + pgof=
f.

[ ... ]

> +	/* Create rmeapping entry. */
> +	new_remap_key =3D malloc(sizeof(*new_remap_key));
> +	new_remap_val =3D malloc(sizeof(u64));
> +	if (!new_remap_key || !new_remap_val) {
> +		err =3D -ENOMEM;
> +	} else {
> +		*new_remap_key =3D remap_key;
> +		new_remap_key->dso =3D dso__get(remap_key.dso);
> +		if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL ||
> +		    cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) {
> +			if (al.map) {
> +				*new_remap_val =3D remap_addr -
> +						 (start - map__start(al.map)) -
> +						 map__pgoff(al.map);
> +			} else {
> +				*new_remap_val =3D remap_addr;
> +			}

[Severity: High]
Is it possible this logic creates an asymmetric computation for kernel
mappings without an associated DSO?

When al.map is NULL during insert, this stores remap_addr directly into
*new_remap_val without subtracting pgoff. However, as seen in the lookup pa=
th
above, it unconditionally adds pgoff to the cached value when al.map is NUL=
L.

For anonymous kernel maps, the kernel sets pgoff to the original virtual
address in bytes. This asymmetric addition seems like it would cause a mass=
ive
overflow by adding a 64-bit kernel address to the already high remap_addr,
drastically corrupting the returned remapped address on lookups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606072125.2786=
845-1-irogers@google.com?part=3D2
