Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9323C4FA
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446978; cv=none; b=e87b33pILdMsuGj8mwh+wx9VUfD08vWxblFYYe7KmcLhRof2eSwW9QWRb+/NHt+KXwnzUM2hCdzFTzObhD7eT8ylCdVhwgOPVzxahUEjPNuYf7q/y7wcUUaUhHJMp4h0FO5JCnHBVRuS3WuPO2IcrKzboN8PR/6BbUxN6fbEd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446978; c=relaxed/simple;
	bh=I+P3MzWdITCc3n30az/3C4FCKcBrIibyCTkZ+rikrGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S0t1ybiqJ/a5e1d6fEehZ2r0UPuqb5TpidhZn8rKVvJfBmSGqw0bNdGcPVUCItOhZkyq+ftzfZIPXey/XxWQPOG6EMOA7iOSNRO2nKkFS1INvw4XJM5v39J/57pU+fTj2d0neIJFFY3/tLColhMFZ7BUVljXV/nVHM15L92JCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCQjveUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCQjveUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D81B1F00893;
	Wed,  3 Jun 2026 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780446976;
	bh=aiYAou1xMBnNPZgf860w9Wo6xJJwTz1VNLHkzQ5zQfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCQjveUCwy+jMqgk26YHlVg2ajLWOUPCE1RThzbqJlogbsOntBzsqlrQTW73Ck6LQ
	 6Nr5qQUBIr93pnN9vOs2KOoDVxbdbrdh6sbPoX0eugfc0/92o02voKupKcMbEk7odN
	 kWMjDgR0HNcHxpakMHJ7VH0xPe0mBX6AmkoDzEoTVsg0OMNsnxRJXbQ3HRd2S1G6rb
	 2P8GN3cwPMiEQY790sgMmFcIQBnTBbk105/ycnKBRo6xPeQmzpArWwbUqs9vnG410N
	 fFN9oMvPTTCcCoAb8XwzJ+cbFHX+8LXS/IlO83MWYR+0uBV1U8RHCsD7bQ3uJ8nBXr
	 RKn5aHfHjBKGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf timechart: Include file offset in CPU bounds
 check messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602235709.1541603-5-acme@kernel.org>
References: <20260602235709.1541603-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 00:36:16 +0000
Message-Id: <20260603003616.8D81B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read vulnerability in cpu2y() when using --topology,=
 leading to heap information leak or crash.
--

commit df9ed5394176bf63cfdd83249ffcb6787efbba52
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
perf timechart: Include file offset in CPU bounds check messages

This patch adds the perf.data file offset to the out-of-bounds CPU debug
messages in various timechart sample processing functions.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 630756bebe324..071987241a528 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -605,8 +605,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>  	u32 state  =3D perf_sample__intval(sample, "state");
>  	u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
> =20
> +	/* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted */
>  	if (cpu_id >=3D MAX_CPUS) {
> -		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %u\n",
> +			 sample->file_offset, cpu_id);

[Severity: High]
This is a pre-existing issue, but since the bounds check logic is being
modified here, does checking against MAX_CPUS adequately protect
topology_map when using --topology?

The topology_map is dynamically allocated using the number of CPUs:

tools/perf/util/svghelper.c:svg_build_topology_map() {
    ...
    topology_map =3D malloc(sizeof(int) * nr_cpus);
    ...
}

However, the untrusted CPU ID in the perf.data sample is only checked again=
st
MAX_CPUS (4096) here. Later, cpu2y() accesses this array using the CPU ID:

tools/perf/util/svghelper.c:cpu2y() {
    ...
    return cpu2slot(topology_map[cpu]) * SLOT_MULT;
}

If nr_cpus is smaller than MAX_CPUS, could a crafted perf.data with a CPU ID
between nr_cpus and 4095 cause an out-of-bounds heap read, potentially lead=
ing
to a crash or an information leak into the SVG output?

>  		return -1;
>  	}
>  	if (state =3D=3D (u32)PWR_EVENT_EXIT)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235709.1541=
603-1-acme@kernel.org?part=3D4
