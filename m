Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D9472F71
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183321; cv=none; b=lWbjh/Zvx9FMHYF6E98qQ17rlFJXj0nGMH0jHxZVGd2qoSF0SsDh6+sEGBoyEzvOLoJxjPD5GdGyHmnimPo7cECPL/WUBKeBrsOsYfX17PVOf5ljV+R/KXq4y8p81oideHnztqC/gkCvIPm6zPTR3aNzBpIsVPH1PMlbGEDXsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183321; c=relaxed/simple;
	bh=ImO+Soxwe6y5Yppflg1EIJMh4FyOaiAKJK37u11vKH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AlVYluULxJgJPBdM6/cD0RtCwgu3Q22VM024gT6KTOKo/aDZZ/rtdqeVYdtfQylbxBU1WDe1NjgmTMzzVZ9Pi1c9IlE0AY42Up0maWRRfJ5EvQr5jNrnNF4+HOml/KANssLyeelCrFmLe/f+wtsnehKPIZp63fyhaw88Fhaa8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1ePycDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1ePycDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66CE1F00A3D;
	Mon, 31 Aug 2026 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183319;
	bh=ARQlbGqtXpjvjHg2goVa02/h11H/XRsI0DWZvvwX+GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1ePycDl8lhzGPrLv+7xaZfN84MuvxAcqSg/zJldywONrneIeqA951tJvTMep2whz
	 J/dOg9/fPKiMaEwUWeRGFFD9gLMq0qyyGoRQl/vCPbXS6bTQdc1eMSBZ4QkQf9/IWy
	 pwGRxcjoW/9Hpy7vxPmA52TE7r0LWW4Ia2kiB9uxBblLwbhAv4Lm7cRdKtGA8YjOxl
	 ij7vO24zdBKkk/dsxVlnKhs6ksORgWfwpo+wp8bJFVyrKMNzne3PB0epfpuXT+pEaP
	 f0uq8JADIZjYOxK1R3r2td0DQbOZRb5eJzB6NesAQdYltCcW/w/vpZTRjnotSD5KYY
	 ZZdOKxf8k8vdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] perf jitdump: Validate unwinding sizes against
 record payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-13-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:35:19 +0000
Message-Id: <20260831133519.A66CE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stale unwinding data leak and corruption in subsequent JIT ELF fil=
es due to missing cleanup when `eh_frame_hdr_size` is zero.
- [High] Missing bounds check in `jit_repipe_code_move` leaks uninitialized=
 heap memory into `perf.data`.
--

commit 606a51d613d656e670cf8772d98c0b537c8eb055
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate unwinding sizes against record payload

This commit validates unwinding sizes against the record payload to prevent
out-of-bounds heap reads when eh_frame_hdr_size exceeds unwinding_size. It
also updates mapped_size to use a uint64_t to avoid mmap2 length truncation.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 5898a7d8eb962..d25a9fe9b020c 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -462,7 +462,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	u16 idr_size;
>  	const char *sym;
>  	uint64_t count;
> -	int ret, csize, usize;
> +	int ret, csize;
> +	uint64_t usize;
>  	pid_t nspid, pid, tid;
>  	struct {
>  		u32 pid, tid;
>  		u64 time;
>  	} *id;

[Severity: High]
This is a pre-existing issue, but does jit_repipe_code_load() leak stale
unwinding data to subsequent JIT ELF files if eh_frame_hdr_size is zero?

A JIT dump can contain an unwinding record with unwinding_size > 0 but
eh_frame_hdr_size =3D=3D 0, which is valid and permitted by the new size
validation.=20

When processing the subsequent code_load event, it correctly uses this
unwinding data, but appears to skip the cleanup block because
jd->eh_frame_hdr_size is zero:

	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
		zfree(&jd->unwinding_data);
		jd->eh_frame_hdr_size =3D 0;
		...
	}

Could this cause all subsequent code_load events to erroneously embed the
same stale unwinding table, corrupting the generated ELF files for unrelated
JIT methods?

[ ... ]

> @@ -612,7 +613,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	char *filename;
>  	size_t size;
>  	struct stat st;
> -	int usize;
> +	uint64_t usize;
>  	u16 idr_size;
>  	int ret;
>  	pid_t nspid, pid, tid;

[Severity: High]
This is a pre-existing issue, but does jit_repipe_code_move() lack bounds
checking for the record payload?

A malformed JIT dump could provide a JIT_CODE_MOVE record with a total_size
smaller than sizeof(struct jr_code_move). jit_get_next_entry() reallocates
the buffer to exactly total_size bytes, but jit_repipe_code_move() doesn't
validate total_size before unconditionally accessing fields past the fixed
record prefix:

	nspid =3D jr->load.pid;
	...
	event->mmap2.start =3D jr->move.new_code_addr;
	event->mmap2.len   =3D usize ? ALIGN_8(jr->move.code_size) + usize
				   : jr->move.code_size;

Could this result in uninitialized out-of-bounds heap memory being assigned
to event fields that are subsequently written to the output perf.data strea=
m?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D12
