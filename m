Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB63CB8EB
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966836; cv=none; b=gk/7ThiYgO5nqDljs90098ELTKnPblvv/jXIoJrluSb9d6q6hexbw9UellXqB58e0Wc3d+3FFZDv15Feh5l4/pYRlM2AhBMXnBzkNqwll+EDXKw9XY857P5oShw4Fw7r7sGu6RpUd81sAGPKLo+SMUXYfyRZFDmsKwA8GpE2btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966836; c=relaxed/simple;
	bh=L6u0TxYa95t1J5oTx5fbnWgJPkruZGXM00qI5QcPDxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1DYL/PKwfOZZlxlw+sMjGrl/tS/Ynn+ytxa9naBUCfeTpAFTSr6NxlHopxn8vGDlKtXAjxtD+qq3RKJvC6AI7xNqAyc5NWuouR+YPmWPWf9ZPHLmZhotDoZnMGlvbJELnqFPXTFBfmUGbhtJoReKXYuSuN4Hp1NF0yqL6itv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLH8Skat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLH8Skat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7021F000E9;
	Wed,  5 Aug 2026 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966834;
	bh=FfKuCSamlfnp3cx4kYRHwa1hOyEp/3YuZfhPdyim1Ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLH8SkatyYsL9mFPuOS6Ebregu41bQbcNX2SA92XidiOUA8Xf42GAWzMO1AZD/7fa
	 IyuUxhNqA+L3nlKw3zRsEoul/oQZAIqmkDSPl0a+Q6e/T6gQaJYruejLHF8Ywgs22f
	 ktozFZGqM3Qr60eJdCHrTZbQsaGtTu8DLW0bznE4sfXLrNar3RzvwX/pTruB64k3JX
	 hXiy9zKaa1ArFB8BXoF7+HDXxKiARcCFYVIB93pWmpalEQtUX0Q6vp53G2/wYnMrq+
	 mnIACet1rv1gOu2gRW/mvrhUX2O37zytXebCEbcXp39Y1Fq0Yfc6dPv8hf0k6BFCvg
	 V+jFxxrw1oqhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] perf jitdump: Validate unwinding sizes against
 record payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-13-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:53:53 +0000
Message-Id: <20260805215354.5A7021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] State leakage of unwinding data due to flawed conditional cleanup,=
 corrupting subsequent JIT loads.
- [High] Heap buffer overflow in `jit_repipe_code_move` due to undersized p=
adding for the `event` buffer.
--

--- Patch [12]: [PATCH 12/12] perf jitdump: Validate unwinding sizes agains=
t record payload ---
commit 6a41da3e449813b67858843724cc900be799f924
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate unwinding sizes against record payload

This commit validates unwinding sizes against the record payload to
prevent an out-of-bounds heap read in libelf. It also changes the type
of mapped_size to uint64_t to prevent truncation.

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
> @@ -543,7 +544,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
> =20
>  	event->mmap2.pgoff =3D GEN_ELF_TEXT_OFFSET;
>  	event->mmap2.start =3D addr;
> -	event->mmap2.len   =3D usize ? ALIGN_8(csize) + usize : csize;
> +	event->mmap2.len   =3D usize ? ALIGN_8((uint64_t)csize) + usize : (uint=
64_t)csize;

[Severity: High]
This is a pre-existing issue, but is it possible for stale unwinding state =
to
persist and corrupt subsequent JIT code loads?

Looking earlier in jit_repipe_code_load(), the cleanup logic requires
eh_frame_hdr_size to be non-zero:

	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
		zfree(&jd->unwinding_data);
		jd->eh_frame_hdr_size =3D 0;
		jd->unwinding_mapped_size =3D 0;
		jd->unwinding_size =3D 0;
	}

If a JIT_CODE_UNWINDING_INFO record provides unwinding data without an EH
frame header (where eh_frame_hdr_size =3D=3D 0), this cleanup is bypassed.
The stale unwinding_data and unwinding_mapped_size would then remain in the
context descriptor (jd) and incorrectly apply to subsequent JIT_CODE_LOAD
events.

>  	event->mmap2.pid   =3D pid;
>  	event->mmap2.tid   =3D tid;
>  	event->mmap2.ino   =3D st.st_ino;

[ ... ]

> @@ -612,7 +613,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	char *filename;
>  	size_t size;
>  	struct stat st;
> -	int usize;
> +	uint64_t usize;

[Severity: High]
This is also a pre-existing issue, but could this undersized padding cause a
heap buffer overflow when copying sample IDs?

Looking further down in jit_repipe_code_move(), the event buffer is allocat=
ed
with a hardcoded 16-byte padding:

	/*
	 * +16 to account for sample_id_all (hack)
	 */
	event =3D calloc(1, sizeof(*event) + 16);

However, the mmap2 event size is calculated using the machine's idr_size:

	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);

And the sample ID data is written based on that dynamically sized offset:

	id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_size);

If idr_size exceeds 16 bytes and the output filename is near PATH_MAX, the
calculated size could exceed the allocated space, causing the program to
write the pid, tid, and time out of bounds, followed by an out-of-bounds re=
ad
during output.

>  	u16 idr_size;
>  	int ret;
>  	pid_t nspid, pid, tid;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D12
