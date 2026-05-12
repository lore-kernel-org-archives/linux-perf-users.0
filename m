Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502C37DEA4
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621845; cv=none; b=SJX8XeHPAROhyNDhl1DNuEq83+cjonrFyhEdsOy6ACqDSWJyTIpchhJv+p1ukGn+1pS6swHxzzEPa4/q+ZqXrgyyft6YTjglNEbdrH/5vQ/bK0gzzayqlj4znShRx6ZSRXDiJyoGgPwGSfP6Er0QnfxUCEbHU4WvlSZDfRqRZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621845; c=relaxed/simple;
	bh=cj6qSkyfzqy5tIZVwI/UgDX2dz+xA4Kv8AgUd4VsMCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzP0SuKEVVEKWWh9PlfdHIClPi4K77Aydk7M/INkWfxPlWCrRh/jGfj378UbV1bcN+7SdqJcyRu9SKOFm/Nsma5rBEkM/9Yn23+j8iYCyXH+YpKa9pgIgpzuJH1ypGiADfuAAppg5w4eaAsCBuqW9HKvb0QmbC4sd5CVucPZaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i57J9t1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i57J9t1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D22CC2BCB0;
	Tue, 12 May 2026 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778621845;
	bh=cj6qSkyfzqy5tIZVwI/UgDX2dz+xA4Kv8AgUd4VsMCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=i57J9t1O2qXrNCMNZGiwCzCWw2CpClSLn6eEkRYsEgHJQq8HamJp+dUzqC/wmvow1
	 v1bT1AgNCIvmKbnFt6eYyBy70gDhYjJoCUmWhbKrAP8avb7GIeNAA4Jvjb4VBSb5ih
	 gk1fTpbTZ09Cvfjpr1p/jjNVbYAWizO2C1aNDz7WbOY1d2OXgl4klbF/dL7BuAIaUk
	 5RKzAtsiTwwif8CiTqwwAEgMOZb4dOpTxQ1iEoMS6mktI7zFDTRdeRNgN9huyRkYiQ
	 5gq0jO9cGz1t0z2hUmKxPII5UCITaU970//aqS49OPqH4h3/egn9w5ajHBXgcU4JQS
	 UfZ/RIk3iuDWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/28] perf cpumap: Reject RANGE_CPUS with start_cpu >
 end_cpu
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-13-acme@kernel.org>
References: <20260510033424.255812-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 21:37:24 +0000
Message-Id: <20260512213725.1D22CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Time-of-Check to Time-of-Use (TOCTOU) Heap Buffer Overflow and Out=
-of-Bounds Read in cpumap parsing.
- [High] Pre-existing Out-of-Bounds Read in `perf_event__process_event_upda=
te` due to missing nested payload bounds checks.
--

commit fe3ac4a4fbae6a151523bf3561bfcf888589a6b9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu

cpu_map__from_range() computes nr_cpus as end_cpu - start_cpu + 1.
When a crafted perf.data has start_cpu > end_cpu, this wraps to a huge valu=
e,
causing a massive allocation attempt. This commit returns NULL when the ran=
ge
is inverted, clamps any_cpu to a boolean, and hardens cpu_map__from_mask()
to reject unsupported long_size values.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 11922e1ded844..c32db7b307d7d 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -93,9 +93,18 @@ static struct perf_cpu_map *cpu_map__from_entries(cons=
t struct perf_record_cpu_m
>  static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_=
cpu_map_data *data)
>  {
>  	DECLARE_BITMAP(local_copy, 64);
> -	int weight =3D 0, mask_nr =3D data->mask32_data.nr;
> +	int weight =3D 0, mask_nr;
> +	/* Cache validated long_size =E2=80=94 data is mmap'd and could change =
*/
> +	u16 long_size;
>  	struct perf_cpu_map *map;
> =20
> +	/* long_size must be 4 or 8; other values overflow cpus_per_i below */
> +	if (data->mask32_data.long_size !=3D 4 && data->mask32_data.long_size !=
=3D 8)
> +		return NULL;
> +
> +	long_size =3D data->mask32_data.long_size;

Can this validation check be bypassed if the file is modified concurrently?

Because perf.data files are mapped using MAP_SHARED by default, concurrent
modifications to the file are immediately visible to the perf process.

If valid data is supplied initially, could data->mask32_data.long_size be
concurrently modified after the if statement but before it is assigned to
long_size, defeating this check entirely?

[ ... ]

> @@ -129,8 +141,12 @@ static struct perf_cpu_map *cpu_map__from_range(cons=
t struct perf_record_cpu_map
>  	struct perf_cpu_map *map;
>  	unsigned int i =3D 0;
> =20
> +	if (data->range_cpu_data.end_cpu < data->range_cpu_data.start_cpu)
> +		return NULL;
> +
> +	/* any_cpu is boolean (0 or 1), not a count =E2=80=94 clamp to avoid in=
flated nr */
>  	map =3D perf_cpu_map__empty_new(data->range_cpu_data.end_cpu -
> -				data->range_cpu_data.start_cpu + 1 + data->range_cpu_data.any_cpu);
> +				data->range_cpu_data.start_cpu + 1 + !!data->range_cpu_data.any_cpu);
>  	if (!map)
>  		return NULL;
> =20

Does this section allow an out-of-bounds read or write during parsing?

Since perf_cpu_map__empty_new() relies on perf_cpu_map__alloc() defined in
another translation unit, the allocation acts as a compiler memory barrier.
This forces the compiler to reload the boundary fields from the memory-mapp=
ed
data pointer.

Could valid bounds be supplied to pass the initial checks, and then
concurrently expanded in the file before the initialization loop:

	for (int cpu =3D data->range_cpu_data.start_cpu; cpu <=3D data->range_cpu_=
data.end_cpu;
	     i++, cpu++) {

causing the loop to read and write significantly past the bounds of the
allocated heap buffer?

Is there a similar out-of-bounds read vulnerability when processing nested =
CPU
maps?

While session.c explicitly enforces payload boundary checks for standalone
PERF_RECORD_CPU_MAP events to ensure embedded size fields like nr do not
exceed the event's overall header.size, it seems this validation is missing
for nested CPU maps.

When processing PERF_RECORD_EVENT_UPDATE events of type
PERF_EVENT_UPDATE__CPUS, perf_event__process_event_update() passes the nest=
ed
cpus payload directly to cpu_map__new_data().

cpu_map__new_data() trusts the embedded size fields without verifying them
against the parent event's size.  Could a malformed perf.data file with a
minimal event header.size but a massive embedded nr value in the nested
payload force the parsing loops to read extensively past the end of the
memory-mapped file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D12
