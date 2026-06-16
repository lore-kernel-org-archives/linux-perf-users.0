Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508F44CAF9
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625425; cv=none; b=HN1y7v5WZuGz9trfixtePa/aIa5HHxu40wL7U/406FbH9i7PDTAYDrWgOAJoR1WsztUpHDqvWn+tqAgUkaHnaE1zZ4PJdKzQ/0WJ8JrgeYodlpwW9BQzzjdq65x6D+Z+U26lVvFieGzrvar43+g8rYPLU9ZWz/7pJexDU17gdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625425; c=relaxed/simple;
	bh=6Q97g+HHuaT4/Mo29uc9KJIhLLiev5fW+MYEwg0HFX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=te0sOMyhV+IPlZruTrgYCennGhdJnjI1XqtBRII+jhsKuZCm3YShfk4mQTo4Tpvj8iWFM42lxo2E+SDrbI6t8OkRi/+lr8KW7keFfT8OBi1UWinEFRQhRiUIju0mlD9Ky9NXcPNUYW4GQMFcdydc1w7WBkH3hKJm679IhvH8EVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlMudrKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlMudrKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20F1F00A3A;
	Tue, 16 Jun 2026 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625423;
	bh=bqjBikjlgB106MXZm4BQAkaL2Y8MNNDHF+7tqplb3dM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlMudrKZkQGsCwR2WHM6AVXC9TkSr2cvv5UCfGPX2uG9BQgEDDxCF/FXZVd9IWUWo
	 Gl9ZHI7aiJpd87A+/jXEfwxBaeLoNJULCXoxVqb+eRDOS1jSyMoX/zu7WiBSQX9BTW
	 MuI1P/bZbabxaN+ZqeqPMQI5OONNSxp67t/1bA4DsaONwLokk9dLiWnj+mmImbZLJp
	 TuO2NRDYJ3wS3xJYDb8uOGRYRIePo5jc5MpdGQmW5arl72RlWnTVpHXKFzp9fUptIS
	 gb2+355o5r7AqMjnyHdlKaXSOkalRDt1uZ/l/9/LwPoVQTKnfe4mm70Pzrb4TflUt7
	 CF1VAP2eeK5ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] perf cs-etm: Require full global header in
 auxtrace_info size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616153920.6852-5-acme@kernel.org>
References: <20260616153920.6852-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:57:03 +0000
Message-Id: <20260616155703.BC20F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checks when parsing variable-length per-CPU metadat=
a in CS-ETM auxtrace_info allows out-of-bounds reads.
- [High] Missing size validations in auxtrace info processing for Intel PT,=
 Intel BTS, and PowerPC VPADTL allow out-of-bounds memory reads from the ev=
ent payload.
- [High] Insufficient bounds checking and untrusted input usage in Arm SPE =
auxtrace info processing lead to division by zero and out-of-bounds memory =
accesses.
--

commit 6aff40a5f5a82fdada5b1248defc410025292df0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Require full global header in auxtrace_info size check

This commit updates cs_etm__process_auxtrace_info() to include
CS_ETM_HEADER_SIZE in the minimum size check. This ensures that the global
header entries fit within the event, fixing an out-of-bounds read issue
with crafted auxtrace_info events.

> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
> index 4abe416e3febd..aebef71d3a0a1 100644
> --- a/tools/perf/util/cs-etm-base.c
> +++ b/tools/perf/util/cs-etm-base.c
> @@ -170,7 +170,9 @@ int cs_etm__process_auxtrace_info(union perf_event *e=
vent,
>  	u64 *ptr =3D NULL;
>  	u64 hdr_version;
> =20
> -	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE))
> +	/* Ensure priv[] is large enough for the global header entries */
> +	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE +
> +					  CS_ETM_HEADER_SIZE))
>  		return -EINVAL;
> =20
>  	/* First the global part */

[Severity: High]
This isn't a bug introduced by this patch, but the patch attempts to fix a
related out-of-bounds read by validating the global header size. Is the fix
incomplete?

The per-CPU metadata is still read dynamically without verifying that the
event payload (auxtrace_info->header.size) is large enough to contain it.

In cs_etm__process_auxtrace_info(), if dump_trace is true,
cs_etm__print_auxtrace_info() reads at least 7 64-bit words per CPU without
checking the buffer bounds, leading to an out-of-bounds read and exposing h=
eap
memory contents to standard output:

tools/perf/util/cs-etm-base.c:cs_etm__print_cpu_metadata_v1() {
    ...
    total_params =3D val[i + CS_ETM_NR_TRC_PARAMS] + CS_ETM_COMMON_BLK_MAX_=
V1;
    ...
}

Similarly, cs_etm__process_auxtrace_info_full() validates that there is at
least 1 word per CPU, but cs_etm__create_meta_blk() iterates and reads mult=
iple
words per CPU based on CS_ETM_NR_TRC_PARAMS, causing out-of-bounds heap rea=
ds:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk() {
    ...
    for (k =3D CS_ETM_MAGIC; k < nr_out_params; k++)
        metadata[k] =3D buff_in[i + k];
    ...
}

And later validates the total number of words read only after the out-of-bo=
unds
memory accesses have already occurred:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
    if (i * 8 !=3D priv_size) {
    ...
}

Could a crafted trace file with insufficient per-CPU metadata size crash the
perf tool or leak memory?

[Severity: High]
This is a pre-existing issue, but it exists in similar auxtrace decoders for
Intel PT, Intel BTS, and PowerPC VPADTL. Do these decoders also miss size
validations, allowing out-of-bounds memory reads from the event payload?

In intel_pt_process_auxtrace_info(), min_sz is calculated as sizeof(u64) *
INTEL_PT_PER_CPU_MMAPS (which is sizeof(u64) * 9). This guarantees the payl=
oad
has space for indices 0 to 8. The code then reads index 9, which accesses 8
bytes strictly beyond the validated boundary if the size is exactly min_sz:

tools/perf/util/intel-pt.c:intel_pt_process_auxtrace_info() {
    ...
    pt->per_cpu_mmaps =3D auxtrace_info->priv[INTEL_PT_PER_CPU_MMAPS];
    ...
}

The exact same off-by-one enum indexing pattern causes out-of-bounds reads =
in
intel_bts_process_auxtrace_info(), which validates up to
INTEL_BTS_SNAPSHOT_MODE but accesses index 5:

tools/perf/util/intel-bts.c:intel_bts_process_auxtrace_info() {
    ...
    bts->snapshot_mode =3D auxtrace_info->priv[INTEL_BTS_SNAPSHOT_MODE];
    ...
}

And in powerpc_vpadtl_process_auxtrace_info(), which validates up to
POWERPC_VPADTL_TYPE (0 bytes) but reads index 0:

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_process_auxtrace_info() {
    ...
    vpa->pmu_type =3D auxtrace_info->priv[POWERPC_VPADTL_TYPE];
    ...
}

Can parsing a crafted perf.data file trigger out-of-bounds heap reads and
potential segmentation faults in these decoders?

[Severity: High]
This is a pre-existing issue, but it also exists in the Arm SPE auxtrace
decoder. Are there insufficient bounds checks and untrusted input usage in
arm_spe_process_auxtrace_info() that lead to division by zero and
out-of-bounds memory accesses?

The event size is only verified to be at least ARM_SPE_AUXTRACE_V1_PRIV_SIZE
(16 bytes). If the size is 17 bytes, it skips the V1 branch and reads index=
 3
(offset 24) from the payload, causing an immediate out-of-bounds read:

tools/perf/util/arm-spe.c:arm_spe__alloc_metadata() {
    ...
    *nr_cpu =3D ptr[ARM_SPE_CPUS_NUM];
    ...
}

Furthermore, *nr_cpu is taken directly from the untrusted payload without
checking for zero, and allows unsigned wraparound if hdr_sz is larger than
metadata_size:

tools/perf/util/arm-spe.c:arm_spe__alloc_metadata() {
    ...
    per_cpu_sz =3D (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
    ...
}

This could result in a huge per_cpu_sz value passed to memcpy(), leading to=
 a
massive out-of-bounds heap read and segmentation fault:

tools/perf/util/arm-spe.c:arm_spe__alloc_per_cpu_metadata() {
    ...
    memcpy(metadata, buf, per_cpu_size);
    ...
}

Can a crafted perf.data file with nr_cpu =3D=3D 0 cause a SIGFPE and crash =
the
perf tool?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153920.6852=
-1-acme@kernel.org?part=3D4
