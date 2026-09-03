Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310124AEBC8
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442796; cv=none; b=VlBVO5IqAOcMkwEHKMMeCCsUndbXNjP1BKvV0eGprmdO3ETHmJDoL4QbZkIzfbcTtPAeGVVrJxOKuopIgBSzlYNbk+SaNhz16eOm0/Px0+LsdCUw+mGZDWequPSQx2LmjqE11Xhyyraw7Cl4gyz8nrqwsfFitJoCN2jeg7PKPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442796; c=relaxed/simple;
	bh=2sgAtVNpr2uwwClwPXiYvmrlfrZodaU0LhrykNmiP0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePtdkKMWpJ+hz1e8nTFO3JsNVH/gdLOCPM8NeoYDSL4X3ln19o1FDp0u1Cx4mOcT9pfychqB0MPiruPrZAkAVnX5pDARvDArXcNjCi/LU6IKPiNE5Sn12ARcSQf0Qiuh9TjnEH0mcQlL13c+0v6xl39RtBrbQFtoakl349O/rvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2HOgIJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2HOgIJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFB21F00A3F;
	Thu,  3 Sep 2026 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442781;
	bh=ie28k+5JzgC32Fk8f5HXbW2WUPguFuFs49zUDQYxQyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2HOgIJ44q9zvgb5LbzB36J2Q5vgKd/P6ijTJ36TPcfhpnseLY+l3r2QI2avzUtQH
	 WyLXyOLlXlwBDzqHZhXQfEErKE0CUV/JuajC85s0ugSPvdRG0fRekVLrTURdwN0z15
	 1N5UPWXgLCsqtpT+tu+ihDhQywpSdljL6/Q3YJk8NiQEO6WfpBTjqVPUuLJvsLq4v/
	 mgS1mY7d7muLIYVMcsM41aAYbnY6h3dD3jVEQHy+BgGqjvxn7SBZGI3Ig8wrnnz6f2
	 xIQruzN11BY/LKmaq6IW5Pxqh9K1Aa1bspTSXtS5EJI0dyVZhyRxPI3v3FOco+cHHu
	 db00I2mM+eboQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf jitdump: Free unwinding data even when
 eh_frame_hdr_size is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903132251.237029-4-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
 <20260903132251.237029-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:39:41 +0000
Message-Id: <20260903133941.9AFB21F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe open() call in jit_emit_elf allows arbitrary file overwrite=
 via symlink attack.
- [Medium] Stale unwinding and debug data persist on malformed JIT records =
due to ignored return values and missing cleanup on early returns.
--

commit 57898e6821f20c63014ed2610a5c18278ca4444d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero

This commit modifies jit_repipe_code_load() to unconditionally free
the unwinding data if it is present. Previously, it only freed the data
if eh_frame_hdr_size was also non-zero, which caused unwinding sections
to be duplicated and mmap2 lengths to be inflated.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index e0d5cc9a82818..efb40d93e33ae 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -530,7 +530,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  		jd->nr_debug_entries =3D 0;
>  	}
> =20
> -	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
> +	if (jd->unwinding_data) {
>  		zfree(&jd->unwinding_data);
>  		jd->eh_frame_hdr_size =3D 0;
>  		jd->unwinding_mapped_size =3D 0;

[Severity: Medium]
This isn't a bug introduced by this patch, but earlier in
jit_repipe_code_load() we return without cleaning up state:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
	if (jr->load.p.total_size < sizeof(jr->load) ||
	    jr->load.code_size > jr->load.p.total_size - sizeof(jr->load) ||
	    jr->load.code_size > INT_MAX) {
		pr_warning("jitdump: invalid code_size %" PRIu64 " (total_size=3D%u) in c=
ode_load record\n",
			   (uint64_t)jr->load.code_size, jr->load.p.total_size);
		return -1;
	}
    ...
}

If a malformed code load record triggers this early error return, the
pending unwinding and debug data aren't freed or cleared.

Is it expected that jit_process_dump() continues parsing when this happens?

tools/perf/util/jitdump.c:jit_process_dump() {
    ...
	while ((jr =3D jit_get_next_entry(jd))) {
		switch(jr->prefix.id) {
		case JIT_CODE_LOAD:
			ret =3D jit_repipe_code_load(jd, jr);
			break;
    ...
}

Because the return value is captured but not evaluated for loop termination,
can this stale unwinding and debug data be erroneously applied to subsequent
valid events?

Could an attacker supply a crafted perf.data file with malformed records
to trigger this state corruption?

[Severity: High]
This is a pre-existing issue, but does this open() call allow an arbitrary
file overwrite?

tools/perf/util/jitdump.c:jit_emit_elf() {
    ...
	nsinfo__mountns_enter(jd->nsi, &nsc);
	fd =3D open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0644);
	saved_errno =3D errno;
	nsinfo__mountns_exit(&nsc);
    ...
}

Since the filename path is predictable and based on the attacker-controlled
mmap path, the missing O_EXCL and O_NOFOLLOW flags appear to leave this
vulnerable to a symlink attack.

If a local attacker creates a symlink at the predictable output path in a
shared directory pointing to a sensitive file, will a privileged user runni=
ng
perf inject silently follow the symlink and overwrite the target file
with an attacker-controlled ELF payload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903132251.2370=
29-1-acme@kernel.org?part=3D3
