Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024F43D4F7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625260; cv=none; b=D8LaxNNN4vLNqOc1onG0UVFEAmVmxJyl7pHz962Ou+ZLu1xhuThN74in0A2TNyKNL/iwPmpw6s0UjRSHE81eklhY+CrP0bIvAHXTabwgYy6Sv8dSdVIoK1tvfv+CrQhuhebGybj1S+8mjJc2uEF0Yik9/l6qaqK15jNaeWu/Ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625260; c=relaxed/simple;
	bh=u4BZquayXJgPgUkLJVb99iI44Xlqar+NnD0a/64epDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JypalOv5tGpCMsmYwm3dRfAMCuOxfoKU7w/koDIeDvgcIXxCycqVFD9Iw5NnTIPuNzZI74/Q35JN3NWRYVcAv3+YUgrujgwggvJeDBMuz3lkW0MKDTUtejAZkoLV2xpGpjt2Hh9VsAUe6oeDJYjByz8VzHOazen6S/AfK03l9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbCPklbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbCPklbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431CA1F00A3A;
	Tue, 16 Jun 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625259;
	bh=y0TqNGYiI+YM9sNcO05DPtEWTbXenzvCvm5+gvkFhkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbCPklbofG7u6F/WqYzeVHAjwqau68gbJOPUfMC5+wVXNGv0kFN3f9lmt5/94M41J
	 0o+PITrHkrGVXx9uXqtxACWzzcBH0hKJVPSvJupzwEllDge5AC5T1t8HoXYt6zxWTs
	 49rpUdypWNoacdvl3nM0wGligyD+VLlMNidxDO9YHgkQpsMc/bVTPZO8Qrvxt0wtZ0
	 Ui6WEy96pCW6HDVEIp+0sWZyOiQ2SpWuy82RVaGaLxaIewpqEAzQz2WdWa3WLC+ia/
	 tQKqIzAQWzQggMJzjIXOLyrNH5fuy72nsbEUWoO3XO+E6FZ6uenAWCoXEErd/D5zzd
	 Efrg5US7rLwXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf cs-etm: Validate num_cpu before metadata
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616153920.6852-4-acme@kernel.org>
References: <20260616153920.6852-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:54:18 +0000
Message-Id: <20260616155419.431CA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added bounds check only guarantees one 64-bit word per C=
PU, but the subsequent metadata extraction loop consumes variable-length bl=
ocks without enforcing bounds, leading to arbitrary out-of-bounds reads.
--

commit 1a99258ab7b1aa2bd3fbb2be661ac8c232d38a5d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Validate num_cpu before metadata allocation

This commit addresses a potential integer overflow and out-of-bounds write =
in
cs_etm__process_auxtrace_info_full(). It fixes the issue by computing priv_=
size
early and bounding num_cpu so that it cannot exceed the total number of u64
entries in the event's private data area.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0927b0b9c06b1..d121c8f22028d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3431,6 +3431,18 @@ int cs_etm__process_auxtrace_info_full(union perf_=
event *event,
>  	/* First the global part */
>  	ptr =3D (u64 *) auxtrace_info->priv;
>  	num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> +
> +	/*
> +	 * Bound num_cpu by the event size: the global header consumes
> +	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
> +	 * metadata entry after that.
> +	 */
> +	priv_size =3D total_size - event_header_size - INFO_HEADER_SIZE -
> +		    CS_ETM_HEADER_SIZE;
> +	if (num_cpu <=3D 0 || priv_size <=3D 0 ||
> +	    num_cpu > priv_size / (int)sizeof(u64))
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does the newly added bounds check guarant=
ee
that subsequent accesses in the parsing loop remain within bounds?

The added check only guarantees one 64-bit word per CPU, but each CPU's
metadata block can have a variable length. During the parsing loop:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
    for (int j =3D 0; j < num_cpu; j++) {
        if (ptr[i] =3D=3D __perf_cs_etmv3_magic) {
            metadata[j] =3D cs_etm__create_meta_blk(ptr, &i, ...);
    ...
}

The cs_etm__create_meta_blk() function consumes a variable number of elemen=
ts
without validating bounds against priv_size:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk() {
    ...
    nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS];
    ...
    *info_read =3D i + nr_cmn_params + nr_in_params;
    ...
}

Could this allow a crafted perf.data file to set a large nr_in_params,
causing the shared index i to be incremented past the buffer bounds? On the
next iteration of the loop in cs_etm__process_auxtrace_info_full(), ptr[i]
would then be read out-of-bounds.

The final size validation (i * 8 !=3D priv_size) occurs after the parsing l=
oop
completes, which appears too late to prevent these out-of-bounds reads.

>  	metadata =3D zalloc(sizeof(*metadata) * num_cpu);
>  	if (!metadata)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153920.6852=
-1-acme@kernel.org?part=3D3
