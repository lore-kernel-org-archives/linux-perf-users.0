Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C84E8E0D
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534430; cv=none; b=C/ArbgIRrCTIRLEL5WsxhrYOeEYMZ1+DFnVJtFVHMZE80bAh5rUv1jkm1nxxLM92j2ku1etRZd/gmskU+1N/4djl14uDL2PgCdbZEty2ffuHDd4pNrsV+vwrnMxx8CwBrR43Nrhpz03jpycgRB+USow8UCSfp3IHX1vayaaGTyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534430; c=relaxed/simple;
	bh=PAJuAm3jtQ0CYyLQHJU+WKnrJBK1W4ra2tbvrYAV1u4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6e435XTTDeHwSaS7aOgc59lZrWLImWK3peOfLkHDM4UpCg9dLSqtoHMkWtxcEYd46Zp7EtYmB1WdbNP83qP0en9T/nbznDK2+1HJ+2IMwAHlBzbmpSud5/AkKRahUK39x5IGDGSagriNF/PTpda40i2NSnGswHV43B3CHhqco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHJARrlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHJARrlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E351F00A3D;
	Fri,  4 Sep 2026 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534425;
	bh=6qmK6e2K4XTfHn9ehDDf+z2se0ANcidIgaIbXHXoscU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHJARrlIzAWw++glxaI/6Lx5gVW8hRBpzekoUQSbwSIrOE7fg4y1Oc1k83Imed0MQ
	 x1PDHWY9ZlNwWGpzgDYbE6GjLLUVWf0acI+aYA1YiyYvtOeUyIGE1HCuvGD8iBEcUX
	 GC1yWezQVBdCZsZnnmVWcPx6WrTQNb9mr0dHMc9pGbJI1fQ75x4jvJOvpYOmdhgnMo
	 m9vjWX6rtS4r2ml2fFUgYWKwH2BWqrIWO7rJeEu0OSu8XHjf4270XbUMFmQwPfHoN/
	 3mPir3WZs+77oIHqQK56Y5Kxy3yiheMZ1J06a37YQPyLWl9ZkZ4DWYmpsB98i3KEKX
	 GfmdZMyJtWiWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf jitdump: Write sample id fields in the order
 used by evsel__id_hdr_size()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904144058.3341-5-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
 <20260904144058.3341-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:07:04 +0000
Message-Id: <20260904150704.E9E351F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious or artificially constructed perf.data file can trigger=
 a 16-byte heap buffer overflow in jit_repipe_code_load and jit_repipe_code=
_move when sample_id_all is unset.
--

commit 899175dbae0b3cbabf63f3a42932d8de3e4aaf9e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Write sample id fields in the order used by evsel__id_hdr_siz=
e()

This commit modifies jit_repipe_code_load() and jit_repipe_code_move() to
write sample ID fields sequentially based on the requested sample_type bits,
resolving out-of-bounds writes that occurred when PERF_SAMPLE_TID was unset
but PERF_SAMPLE_TIME was present.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index efb40d93e33ae..f8b937a95fe84 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
[ ... ]
> @@ -561,13 +559,27 @@ static int jit_repipe_code_load(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  	event->mmap2.flags =3D MAP_SHARED;
>  	event->mmap2.ino_generation =3D 1;
> =20
> -	id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_si=
ze);
> +	/*
> +	 * The sample id fields are appended in the order accounted for by
> +	 * evsel__id_hdr_size(), skipping the ones not requested in
> +	 * sample_type, so they cannot be written through a fixed struct:
> +	 * with PERF_SAMPLE_TID unset, PERF_SAMPLE_TIME starts at offset 0
> +	 * and idr_size is 8, so storing it at offset 8 runs past the end of
> +	 * the event allocation.
> +	 */
> +	id =3D (unsigned long)event + event->mmap.header.size - idr_size;
>  	if (jd->sample_type & PERF_SAMPLE_TID) {
> -		id->pid  =3D pid;
> -		id->tid  =3D tid;
> +		struct { u32 pid, tid; } *id_tid =3D (void *)id;
> +
> +		id_tid->pid =3D pid;
> +		id_tid->tid =3D tid;
> +		id +=3D sizeof(u64);
> +	}
> +	if (jd->sample_type & PERF_SAMPLE_TIME) {
> +		timestamp =3D convert_timestamp(jd, jr->load.p.timestamp);
> +		*(u64 *)id =3D timestamp;
> +		id +=3D sizeof(u64);
>  	}

[Severity: High]
This is a pre-existing issue in jit_repipe_code_load, but could a malicious
or artificially constructed perf.data file trigger a 16-byte heap buffer
overflow here when sample_id_all is unset?

If an attacker provides a maliciously crafted perf.data file where
sample_id_all is unset (causing idr_size =3D=3D 0) but PERF_SAMPLE_TID and
PERF_SAMPLE_TIME bits are set in sample_type, and provides a jitdump file
with a deeply nested path such that the formatted filename length reaches
PATH_MAX, the mmap2 record size consumes the entire union perf_event
allocation.

Since the allocation is determined by idr_size earlier in the function:

    idr_size =3D jd->machine->id_hdr_size;
    event =3D calloc(1, sizeof(*event) + idr_size);

The code then unconditionally writes up to 16 bytes of sample ID fields past
the end of the calloc buffer. This issue leaves jit_repipe_code_load and
jit_repipe_code_move (where it is introduced by a follow-up patch) vulnerab=
le
to memory corruption via untrusted input.

Could we add validation to ensure idr_size correctly accounts for the requi=
red
fields before we perform these writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144058.3341=
-1-acme@kernel.org?part=3D4
