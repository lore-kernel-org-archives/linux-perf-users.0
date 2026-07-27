Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231A26B764
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170087; cv=none; b=i91JRU7lruZkAunc96wP2+F4p7DlCKsXhDTg3TDAORqKw9Ro2NfFTs8OdPxhhMoc/kh59LX0AxyHLM/aGYoq7/gXJcyXNfvTZU66jeE+zW8yzzfhy4/47YTtf/hVN+PRbu5cz1GvzAXGSvgcj2Lia2i7Juii9IVYAjVVUc+ymj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170087; c=relaxed/simple;
	bh=P0tPWidf3VSw5v0AWuszRYIVu5V7mBblLA+8k09fGdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZSXFcNsbqa2KnmUSkwvE9QltRnZOE+MbraV3tQO2/jsu8gBwrbSKqt6nomJdmJ4eC0sChtxGds9zU6FSJwJi71Q/gETGWzDfaiYonzYfFwGnekIINGedTathhxlFeuW1Hvfl6tQgB0w9A/9E4zL+VjUl5sxHnnwWQreEoTcopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff0qb4yT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff0qb4yT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFC61F000E9;
	Mon, 27 Jul 2026 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785170085;
	bh=yQbzo4BZ6+cIunQXqH0a0pcy1Wi6JSwQHO5+hJGWo8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ff0qb4yTWWxglkfZrFjkd/zb3/LzFrrKBpctvYUJdgmsfuznLy5whyUOT/12PeoZz
	 zwhcJ9EFw7IhaWZZ5LcZhffgD3tgq8/brcQFmxVK+mL+W/Zft1sIIhq/WK6jmJEaQV
	 J0nsG0K83RPS9WPzILHAwKo+xmp/G+FXnQQ6rdfE2txHHnfqEBECVaeMjdqiCUo+7u
	 g59DsW6ydjlSqFjzK5Z7jaXZ3amax2/VWc3SZZoG+Od21nH56eKHu8mCDaZDhtUusn
	 aS3/om0NXww4yV1IqKbsdH5he5yeo+bDxu5qclEJ9xxdHTynPgmEG4w1dpvoroM10S
	 u8Zcp+JL66jTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf intel-bts: Fix off-by-one in auxtrace_info
 minimum size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260727161705.64807-5-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:34:45 +0000
Message-Id: <20260727163445.BEFC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Off-by-one minimum size check in powerpc_vpadtl_process_auxtrace_i=
nfo allows out-of-bounds read.
- [High] Missing NULL pointer check before dereferencing session->itrace_sy=
nth_opts leads to deterministic crash.
- [High] Overwriting session->auxtrace unconditionally without cleanup caus=
es memory leaks.
- [High] Out-of-bounds read in arm_spe__alloc_metadata when bypassing the v=
ersion 1 size check.
--

--- Patch [4]: [PATCH 4/5] perf intel-bts: Fix off-by-one in auxtrace_info =
minimum size check ---
commit 0ac93f3d0cb5566f1e0f79a1c4a2f73b3281434a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
   =20
Same pattern as the Intel PT fix: min_sz is set to
sizeof(u64) * INTEL_BTS_SNAPSHOT_MODE, but the code accesses
auxtrace_info->priv[INTEL_BTS_SNAPSHOT_MODE], which requires at least
INTEL_BTS_SNAPSHOT_MODE + 1 elements.

> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 0b18ebd13f7c8..02df3e4604891 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -830,7 +830,7 @@ int intel_bts_process_auxtrace_info(union perf_event =
*event,
>  				    struct perf_session *session)
>  {
>  	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> -	size_t min_sz =3D sizeof(u64) * INTEL_BTS_SNAPSHOT_MODE;
> +	size_t min_sz =3D sizeof(u64) * (INTEL_BTS_SNAPSHOT_MODE + 1);

[Severity: High]
This isn't a bug introduced by this patch, but the exact same pattern seems
to exist in tools/perf/util/powerpc-vpadtl.c.

In powerpc_vpadtl_process_auxtrace_info():

    size_t min_sz =3D sizeof(u64) * POWERPC_VPADTL_TYPE;
    ...
    vpa->pmu_type =3D auxtrace_info->priv[POWERPC_VPADTL_TYPE];

POWERPC_VPADTL_TYPE evaluates to 0, which makes min_sz =3D 0, failing to
protect the subsequent access to auxtrace_info->priv[0]. Should that be fix=
ed
similarly to prevent an out-of-bounds read?

>  	struct intel_bts *bts;
>  	int err;

[Severity: High]
This is a pre-existing issue, but since we are looking at
intel_bts_process_auxtrace_info(), I noticed that session->auxtrace is
unconditionally overwritten later in this function without checking for or
freeing a previously active context:

    session->auxtrace =3D &bts->auxtrace;

If a maliciously crafted perf.data file contains multiple=20
PERF_RECORD_AUXTRACE_INFO events, each event would sequentially overwrite=20
session->auxtrace without calling the appropriate .free() callback. Does th=
is=20
lead to a memory leak of the dynamically allocated auxtrace context?

I noticed the same behavior in intel_pt_process_auxtrace_info() and
cs_etm__process_auxtrace_info_full().

[Severity: High]
This is another pre-existing issue, but further down in
intel_bts_process_auxtrace_info(), the code does:

    if (session->itrace_synth_opts->set) {

Is it possible for session->itrace_synth_opts to be NULL? If a subcommand
like perf data convert --to-json processes PERF_RECORD_AUXTRACE_INFO
events but does not allocate session->itrace_synth_opts, could this lead to
a NULL pointer dereference?

This pattern is also present in intel_pt_process_auxtrace_info() and
cs_etm__process_auxtrace_info_full().

[Severity: High]
This is a pre-existing issue in another auxtrace file, but looking at how
auxtrace info is processed, I noticed a potential out-of-bounds read in
tools/perf/util/arm-spe.c:arm_spe__alloc_metadata().

If metadata_size is 24 bytes, the version 1 strict equality check
(metadata_size =3D=3D 16) is bypassed, falling through to the version 2 par=
sing
which does:

    *nr_cpu =3D ptr[ARM_SPE_CPUS_NUM];

Since ARM_SPE_CPUS_NUM is 3, this requires at least 32 bytes. If the payload
only has 24 bytes, does this read past the end of the event payload and use
a garbage value for the allocation size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161705.6480=
7-1-acme@kernel.org?part=3D4
