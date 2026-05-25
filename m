Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D48258EE0
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673208; cv=none; b=Bnvhx99tvAXoD07xWplUvjtnsn5PqPjnNQQ/gCpIR/SyEFin5/epND1kt/43DE/FwR1v7aMx+7tLXhhPAVEgSSinCTpiiDGXL3wy/nuPK+imJi4cir1KdPzcK4i+OEyY5NEvA9eyWAtTFn3bGdRCUYKmsHKwZ0YtEuLMA95OB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673208; c=relaxed/simple;
	bh=UYvC17n49B+sBXGO58MvyFogJYDdX91kf7Xp53rWwy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTpcJileRQ+n7aOnkPei32SK7K6RE5xJ8t4mlHsP56mjeLxs3LX0anAUk+DCCJD4SnxhV96URku/RVJzdhxcR0xtW/wG1RyeM+DcnIXOhnrAdFAg/Qfzcw3BC5/vqOtocMsN5QrmD4NuIcEJ8K8KFeu7nOMJVwh+Mt1/v5b2lFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foISkxlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foISkxlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF71F000E9;
	Mon, 25 May 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779673206;
	bh=Gt7ZqU+7Q0aREe13bQ6GUvwiB8YAcFavepFHYOCJFO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=foISkxlmwOFaVbwchGv6Bmw0XMFL+IuuY+yJYLbftq91N2GCkyXAI2ZH4hxF+/lyd
	 x1TCYc2PxmocwVEtfOzdtprzjAsWc85xy7xfcIITuDT57yNo27vfIZTsWhBMvyDhHn
	 Ec4TBhATysNgYlzci8y/IZsbInYvv6XKC6LpQ8Kex7xoyIk+ianY+vjFsKRSbT7Ubt
	 LQNCAO+n3XHSeo8gf2R0XH8wm0K36+0CqIC+dc+PzjDQzQ/9iZtt860NuDLLsGgsj9
	 k01QSrP92QCGJh3tk2wN9xpMRCFvs/4XRjbzH9bzDHYtDAAKD+aO+b68zFufKqwUd8
	 HWTEB8sYBN4ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/29] perf cpumap: Reject RANGE_CPUS with start_cpu >
 end_cpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-14-acme@kernel.org>
References: <20260525010550.1100375-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:40:05 +0000
Message-Id: <20260525014006.6DDF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Cross-file TOCTOU vulnerability in cpu_map__from_entries() and cpu=
_map__from_mask() leads to out-of-bounds read.
- [High] TOCTOU double-read in cpu_map__from_mask() results in uninitialize=
d array elements and downstream out-of-bounds accesses.
--

commit 9fea5c7d4c9b27133ef761a257813e84f9929191
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu

This commit fixes a huge allocation attempt in perf_cpu_map__empty_new()
by returning NULL when start_cpu > end_cpu. It also clamps any_cpu to a
boolean, rejects unsupported long_size values, and snapshots mmap'd
fields using READ_ONCE() to prevent TOCTOU re-reads.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
[ ... ]
> @@ -64,24 +66,27 @@ static void perf_record_cpu_map_data__read_one_mask(c=
onst struct perf_record_cpu
>  }
>  static struct perf_cpu_map *cpu_map__from_entries(const struct perf_reco=
rd_cpu_map_data *data)
>  {
> +	/* Snapshot nr =E2=80=94 data is mmap'd and could change between reads =
*/
> +	u16 nr =3D READ_ONCE(data->cpus_data.nr);

[Severity: High]
This is a pre-existing issue, but does this snapshot fully resolve the TOCT=
OU
vulnerability if the length isn't validated against the event payload bound=
s?

While READ_ONCE() captures the value safely, if a FUSE filesystem inflates
the length between the check in session.c and the read here in cpumap.c, the
subsequent loop might still read past the end of the event buffer or mmap
region.

Could this result in an out-of-bounds read and crash the tool?

>  	struct perf_cpu_map *map;
> =20
> -	map =3D perf_cpu_map__empty_new(data->cpus_data.nr);
> +	map =3D perf_cpu_map__empty_new(nr);
>  	if (!map)
>  		return NULL;
[ ... ]
> @@ -106,11 +121,14 @@ static struct perf_cpu_map *cpu_map__from_mask(cons=
t struct perf_record_cpu_map_
>  		return NULL;
> =20
>  	for (int i =3D 0, j =3D 0; i < mask_nr; i++) {
> -		int cpus_per_i =3D (i * data->mask32_data.long_size  * BITS_PER_BYTE);
> +		int cpus_per_i =3D (i * long_size * BITS_PER_BYTE);
>  		int cpu;
> =20
> -		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
> +		perf_record_cpu_map_data__read_one_mask(data, i, local_copy, long_size=
);
>  		for_each_set_bit(cpu, local_copy, 64) {
> +			/* Guard against more set bits than the first pass counted */
> +			if (j >=3D weight)
> +				break;

[Severity: High]
This isn't a bug introduced by this patch, but how does this code handle the
case where the second pass over the mmap'd mask array yields fewer set bits
than the first pass?

If the memory is altered between passes, the trailing elements of the
allocated map would retain their -1 initialization from
perf_cpu_map__empty_new(). Downstream consumers expect valid CPUs.

Could this cause perf_cpu_map__max() to return -1 and trigger 0-byte
allocations, or cause negative out-of-bounds reads in downstream arrays like
cpunode_map?

>  			if (cpu + cpus_per_i < INT16_MAX) {
>  				RC_CHK_ACCESS(map)->map[j++].cpu =3D cpu + cpus_per_i;
>  			} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D13
