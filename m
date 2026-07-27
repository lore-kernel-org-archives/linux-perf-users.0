Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965E41A55A
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169944; cv=none; b=ZyELFIcuC3wcR1+A3LQdp5yHgCVCA1B9igp5S64KnJfeafh7pU9L259J5k4F3rE7V2uViDxl33CpTnisTDMZCVEE9JLfx6pgBLtrqlbLaUwqpsMUJ9S9eCHFJ0EcnNAIu6yV8minYDEQBo0Wzugs4DacUyeTDfMekGRjtYQjSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169944; c=relaxed/simple;
	bh=qP9Kp/3ypNwYPzxdqDnQ2wXe/k/gf67SMqu5GKRQljQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ls2kZzBeeBAQdDLHcx442ieONZQEV6qNvB8eniIyKVHiEL8jJGFFZrSWIPYGxA6E3wuvRrBcvdSe+zNDUQG0j3Dhvtu95QHHcPURDwmsMqgzHEzkKAoktVfZf89jTIeWd3gmUWuT6QIU+s/ccTCQSKDlMl85po+9shC3qjijA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ2FL0S+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ2FL0S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5141F000E9;
	Mon, 27 Jul 2026 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169941;
	bh=iK1ml+b3iTvtYpieo+6yAqNSQX0sT+nlGpNhY9fx/yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZ2FL0S+qRmB7FHk7CdKvFl44yXQOGMB6dcJPJTZ4PbCmfcorJJEGnlWgpxqXRgis
	 PiD6LS6irQ2fXrUdm2eksODBZESWofMa1hilOWIebbx7EELE+NJp52EwuLkxlzCYvy
	 TsIzwNDD4TjL3mxYe8hgbT30Q/r75tOdcsxS/4zn6npSYkUUx9OUuaBLJ112ns5i20
	 MI0EYrB164PhIgfD2mJ0wrf/X/7+RYKP4arlR2INRTZNeGKi4X7y4KNc3imfeAPdj4
	 YaYqrkA36aaObhBJvVZiYLSpKMfKMAk3BXQKiyQvGbNSkUMcmDOhIuNAmAsXb+PXZI
	 NdAfHjDMV8Fpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf arm-spe: Reject zero nr_cpu in metadata to
 prevent division by zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260727161705.64807-6-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:32:21 +0000
Message-Id: <20260727163221.AF5141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `arm_spe_print_info` uses unvalidated, attacker-controlled fie=
lds to index into static format string arrays, leading to arbitrary memory =
dereferences and format string vulnerabilities.
- [High] Missing bounds check on user-controlled `hdr_sz` allows `ptr` to a=
dvance out of bounds and causes integer underflow in the `per_cpu_sz` calcu=
lation, leading to arbitrary heap out-of-bounds reads.
- [High] Missing minimum size validation on `per_cpu_sz` allows crafted inp=
uts to cause heap out-of-bounds reads in downstream functions.
- [High] Missing payload size validation before accessing V2 metadata field=
s leads to an out-of-bounds read.
- [High] Bypassing the metadata allocation error check via a crafted V1 ver=
sion flag causes an unhandled NULL pointer dereference in `arm_spe__is_homo=
geneous`.
--

--- Patch [5]: [PATCH 5/5] perf arm-spe: Reject zero nr_cpu in metadata to =
prevent division by zero ---
commit cdd9c13905fbd08524e5237d0ba280b139dcb3bc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf arm-spe: Reject zero nr_cpu in metadata to prevent division b=
y zero

This patch adds a check to reject nr_cpu <=3D 0 in arm_spe__alloc_metadata()
before performing a division by nr_cpu. This prevents a division by zero
when a crafted perf.data file provides a zero value for the CPU count.

> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 552f063f126e6..401aab529309c 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1604,8 +1604,12 @@ static u64 **arm_spe__alloc_metadata(struct perf_r=
ecord_auxtrace_info *info,
>  	*ver =3D ptr[ARM_SPE_HEADER_VERSION];
>  	hdr_sz =3D ptr[ARM_SPE_HEADER_SIZE];
>  	*nr_cpu =3D ptr[ARM_SPE_CPUS_NUM];

[Severity: High]
This isn't a bug introduced by this patch, but does this read out of bounds
if the payload is exactly 24 bytes?

In arm_spe_process_auxtrace_info(), the payload is only validated against a
minimum size of 16 bytes for V1 metadata. If a crafted perf.data provides a
payload size of exactly 24 bytes (and is not V1), accessing ptr at index 3
(ARM_SPE_CPUS_NUM) attempts to read 32 bytes into the payload, which goes
beyond the verified payload bounds.

> =20
> +	/* nr_cpu is used as a divisor below */
> +	if (*nr_cpu <=3D 0)
> +		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does returning NULL here
trigger a NULL pointer dereference in arm_spe__is_homogeneous() if the
attacker sets the version to 1?

If a crafted file sets ARM_SPE_HEADER_VERSION to 1, and the
arm_spe__alloc_metadata() function returns NULL due to an allocation failure
or a negative nr_cpu, the error check in arm_spe_process_auxtrace_info() is
bypassed:

tools/perf/util/arm-spe.c:arm_spe_process_auxtrace_info() {
    ...
	metadata =3D arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
					   &nr_cpu);
	if (!metadata && metadata_ver !=3D 1) {
		pr_err("Failed to parse Arm SPE metadata.\n");
		return -EINVAL;
	}
    ...
	spe->metadata_nr_cpu =3D nr_cpu;
	spe->is_homogeneous =3D arm_spe__is_homogeneous(metadata, nr_cpu);
    ...
}

Because metadata_ver =3D=3D 1, execution proceeds and passes the NULL metad=
ata
pointer to arm_spe__is_homogeneous(), where it dereferences metadata[i]
without checking if metadata itself is NULL.

> =20
>  	metadata =3D calloc(*nr_cpu, sizeof(*metadata));
>  	if (!metadata)
>  		return NULL;
>=20
>  	/* Locate the start address of per CPU metadata */
>  	ptr +=3D hdr_sz;
>  	per_cpu_sz =3D (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);

[Severity: High]
This is a pre-existing issue, but does this allow ptr to advance out of
bounds if hdr_sz is larger than metadata_size?

Since hdr_sz is controlled by the input and lacks a bounds check against
metadata_size, a large hdr_sz could advance ptr past the payload bounds and
cause an integer underflow in the per_cpu_sz calculation.

[Severity: High]
This is a pre-existing issue, but is there a missing minimum size validation
on per_cpu_sz?

If per_cpu_sz is too small (e.g. 8 bytes), arm_spe__alloc_per_cpu_metadata()
allocates an undersized buffer. Later, arm_spe__is_homogeneous()
unconditionally accesses fields at fixed indices like ARM_SPE_CPU_MIDR,
which would result in out-of-bounds heap reads:

tools/perf/util/arm-spe.c:arm_spe__is_homogeneous() {
    ...
		if (i =3D=3D 0) {
			midr =3D metadata[i][ARM_SPE_CPU_MIDR];
			continue;
		}

		if (midr !=3D metadata[i][ARM_SPE_CPU_MIDR])
			return false;
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does arm_spe_print_info() use the
unvalidated hdr_size to index into static format string arrays?

If a crafted file provides a large hdr_size or cpu_size, these unchecked
values are used as loop bounds, leading to out-of-bounds reads of format
string pointers which are then passed to fprintf():

tools/perf/util/arm-spe.c:arm_spe_print_info() {
    ...
	for (i =3D 0; i < hdr_size; i++)
		fprintf(stdout, hdr_fmts[i], arr[i]);
    ...
		cpu_size =3D (ARM_SPE_CPU_NR_PARAMS + 1) + arr[ARM_SPE_CPU_NR_PARAMS];
		for (i =3D 0; i < cpu_size; i++)
			fprintf(stdout, metadata_per_cpu_fmts[i], arr[i]);
    ...
}

Could this lead to an arbitrary memory read or format string vulnerability
when running perf report with dump_trace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161705.6480=
7-1-acme@kernel.org?part=3D5
