Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DFB316199
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833001; cv=none; b=eMcSK0g6rM1aaIlasMsCHuU2JdAz5ISzayeMpIfoS5aNFZJSEYWjrnjtejEC6YNBok8z0e/Z1/Tyhqso7vOYrtA8/JrOkaSXKilvxIeB4R/zaVNoQXOJ9NblEPnQSg57Ie1KB81k9DumGVY0oWKJ/igCVoSg2L2Jjv/Eqq0CMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833001; c=relaxed/simple;
	bh=jqaxdUK05kgQ0MX8/ZkN4oNLLspDXl7MyCJ4DZfJd0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fL5Dy12X8KNXdME23CRM4CuKOFrNb7xU1faXK1y6DERrmCdIv/I947v57ALFE3oKr5RvWgS6+8ZuTz+NUqiMCfdzk8udlLPKWADB8eDA11xaWwY0eqQGNZHMo/CRSlKOAQwTepxYehMIUqTuTeavogFHfEffDDHGQTIzJSw2JCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8k7hhxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8k7hhxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238FB1F000E9;
	Tue, 26 May 2026 22:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779833000;
	bh=YX9dMzBNbslxeciu2ptHDEZgNQP76PDxB73b3wGxVoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8k7hhxmrJTASKW3iUAm8ddY0jaH5QInPykG53b8pDzDzxOOA5wWPDq6BiHwKsjiZ
	 Rw7LUXOK+kmo7nZpvxmbP8Wy7ZpPdL6AT+4ebmrO1uNJoHbvdLA9c/+/opKXCVz/A9
	 1UeFhx8dlB+ULMKutoJ3PncMoyhzRJ0QgssZVOqArbREgnpXonq+0ZV1T3Umz8EehJ
	 pmqObLv5e2D8kaxMXvFCBPYmiNykRvviNqknqXPXeNrrpU44y8hDUjp9Tp//Ys1a5H
	 Rw27Z/jBvaGCiI1SaNiMRjGsMB/7Qfy2v2cMO6xEuqPaVJmY1Z3CMQBt80eEXjY9s7
	 O4Oyhe2ra8JBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/29] perf cpumap: Reject RANGE_CPUS with start_cpu >
 end_cpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-14-acme@kernel.org>
References: <20260526211806.1193848-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:03:19 +0000
Message-Id: <20260526220320.238FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to prevent TOCTOU re-reads of mmap'd fields usi=
ng `READ_ONCE()`, but it fails to close the critical time window between pa=
yload size validation in `session.c` and usage in `cpumap.c`. An attacker c=
an mutate fields like `nr` or `mask_nr` in a FUSE-backed file after they ar=
e bounds-checked in `session.c`, causing `cpumap.c` to snapshot and use unv=
alidated malicious bounds, leading to severe out-of-bounds memory reads.
- [High] On 32-bit big-endian architectures, `perf_record_cpu_map_data__rea=
d_one_mask()` incorrectly swaps the upper and lower 32 bits of a 64-bit mas=
k, inverting the logical CPU IDs.
- [High] A double-read of mmap'd bitmasks in `cpu_map__from_mask` can resul=
t in partially initialized CPU maps with unsorted entries, breaking map inv=
ariants.
--

commit 5918f47b5e37275ddfd5dce5525f764061776724
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu

This commit addresses potential issues with malformed perf.data files
by rejecting inverted CPU ranges, clamping the any_cpu flag, and adding
READ_ONCE() snapshots to prevent TOCTOU vulnerabilities on mmap'd data.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 11922e1ded844..b1e5c29c6e3ec 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
[ ... ]
> @@ -40,15 +41,16 @@ bool perf_record_cpu_map_data__test_bit(int i,
> =20
>  /* Read ith mask value from data into the given 64-bit sized bitmap */
>  static void perf_record_cpu_map_data__read_one_mask(const struct perf_re=
cord_cpu_map_data *data,
> -						    int i, unsigned long *bitmap)
> +						    int i, unsigned long *bitmap,
> +						    u16 long_size)
>  {
>  #if __SIZEOF_LONG__ =3D=3D 8
[ ... ]
>  #else
> -	if (data->mask32_data.long_size =3D=3D 4) {
> +	if (long_size =3D=3D 4) {
>  		bitmap[0] =3D data->mask32_data.mask[i];
>  		bitmap[1] =3D 0;
>  	} else {
>  #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
>  		bitmap[0] =3D (unsigned long)(data->mask64_data.mask[i] >> 32);
>  		bitmap[1] =3D (unsigned long)data->mask64_data.mask[i];

[Severity: High]
This is a pre-existing issue, but does this mapping reverse the logical CPU
IDs on 32-bit big-endian systems?

The native u64 mask stores CPU k at bit k. When mapping this into the Linux
bitops unsigned long array on 32-bit machines, for_each_set_bit() evaluates
bit indices based strictly on array position. This means bitmap[0] logically
needs to contain bits 0-31 and bitmap[1] needs to contain bits 32-63,
regardless of host endianness.

By placing the upper 32 bits into bitmap[0] and the lower 32 bits into
bitmap[1], are we mapping CPUs 0-31 to bits 32-63, and CPUs 32-63 to
bits 0-31?

>  #else
>  		bitmap[0] =3D (unsigned long)data->mask64_data.mask[i];
>  		bitmap[1] =3D (unsigned long)(data->mask64_data.mask[i] >> 32);
>  #endif
>  	}
>  #endif
>  }
>  static struct perf_cpu_map *cpu_map__from_entries(const struct perf_reco=
rd_cpu_map_data *data)
>  {
> +	/* Snapshot nr =E2=80=94 data is mmap'd and could change between reads =
*/
> +	u16 nr =3D READ_ONCE(data->cpus_data.nr);
>  	struct perf_cpu_map *map;

[Severity: High]
This isn't a bug introduced by this patch, but does this snapshot actually
close the TOCTOU window?

If the bounds validation against the event payload size occurs earlier in
perf_session__process_user_event() without snapshotting the value, couldn't
an attacker supply a small, valid nr value to pass the check there, and
then mutate the FUSE-backed memory to a large value (like 65535) before
we reach this READ_ONCE()?

If so, wouldn't this late snapshot just capture the unvalidated malicious
value, resulting in a massive allocation and out-of-bounds reads from
the perf.data mapping?

> =20
> -	map =3D perf_cpu_map__empty_new(data->cpus_data.nr);
> +	map =3D perf_cpu_map__empty_new(nr);
>  	if (!map)
>  		return NULL;
[ ... ]
> @@ -93,11 +98,21 @@ static struct perf_cpu_map *cpu_map__from_entries(con=
st struct perf_record_cpu_m
>  static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_=
cpu_map_data *data)
>  {
>  	DECLARE_BITMAP(local_copy, 64);
> -	int weight =3D 0, mask_nr =3D data->mask32_data.nr;
> +	int weight =3D 0, mask_nr;
[ ... ]
>  	for (int i =3D 0; i < mask_nr; i++) {
> -		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
> +		perf_record_cpu_map_data__read_one_mask(data, i, local_copy, long_size=
);
>  		weight +=3D bitmap_weight(local_copy, 64);
>  	}
> =20
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
This is a pre-existing issue, but can the double-read of the bitmask
result in an incorrectly sorted map?

The code reads the mask array twice: first to calculate the weight, and
second to populate the map. Since perf_record_cpu_map_data__read_one_mask()
reads directly from mmap'd memory without READ_ONCE(), the underlying data
could mutate between passes.

If the data changes so that fewer bits are set during the second pass,
the map is only partially populated. Because perf_cpu_map__empty_new()
initializes all slots to -1 (representing 'any CPU'), wouldn't those -1
values remain at the end of the array?

Since downstream logic relies on strict monotonic sorting (e.g.
perf_cpu_map__max() assumes the last element is the maximum CPU), could
returning -1 here lead to 0-sized allocations later and subsequent
out-of-bounds writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D13
