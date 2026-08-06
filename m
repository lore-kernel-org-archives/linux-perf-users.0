Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749A2F8E8E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021596; cv=none; b=Hd1iFI0GbnytiX3wntT80invfTTv1BMiYkqnPWWnly4prnBkvgohzDDRU4q/92YcnG51cqN8IGyDlxkgrM4YUVAYMPuI+gS14eTrwjJ1j1abqI0feoVJBgwi+ghofGRSf/NttzIAuRtxRByppETYHLphupz+QEh5LPz6Uf1LvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021596; c=relaxed/simple;
	bh=ipsrTi9hkTY1YKt4JLIC/COQ4rtj9ycy3tdU4ZIyows=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jD6on81wTjGSKM+WzyltpMo2ob0WnXOBAZcwDQ3sQ9TK55dGD14d+fm89OMZBT/BnkjnX/F2bkbwArQUZmkBPxyBctWrcPSGmxWdl1/33TyjQcdjjHiS9kUrc70YZvY7AQq8z4kIGicr+jFA0p4I2pZ0MqMh1sxNimskjyrWGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+LO1fcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+LO1fcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B0A1F000E9;
	Thu,  6 Aug 2026 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021593;
	bh=KSQ9vcfaKLLD9lKS43KitXM2+VpZ74jWHy5viYNyaoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+LO1fcshgF+qKkKrVBx0wpml7tyml0IVoLm3Fh2ssVgyqN8sf3n6v0/mIcwDIe2m
	 gx7nYNY3XeFNwQchPEfxDpjNcgy/62WDUlSvpMC0ALEv1lIleYTmF40A5bmuTr5HNW
	 VBohys9hIT1oKLabZ4VQrdT7EncTV4/nELGhq4sUW7JNP9h35EnsCBn0aqaaYUYR8o
	 oMWJ/MYo1Ilpnmq79eEfMQ0wmT8yOAf8dcIlpb9vWcEt3L+Z+6nRRwFKBSslivz1ca
	 TQ44DuTEEJ/M/wUpovUNLO2QsPhe79T+Gao5QSWLid0jLk1tOq+IZNDxF4ZPJUNDnC
	 hV+IUmdMqJN6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] perf jitdump: Validate unwinding sizes against
 record payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-13-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:06:32 +0000
Message-Id: <20260806130632.E7B0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds heap read and information leak in `jit_repipe_code_m=
ove()` due to undersized event allocation.
- [High] Memory/state leak and mapping corruption when `eh_frame_hdr_size` =
is 0.
--

--- Patch [12]: [PATCH 12/12] perf jitdump: Validate unwinding sizes agains=
t record payload ---
commit e53fcebef8f0cf9ec357ae7d5ca199498a47b1da
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate unwinding sizes against record payload

Validate that unwinding_size fits within the record payload and that
eh_frame_hdr_size does not exceed unwinding_size before allocating or
storing the values, so a bogus record cannot force a large allocation
that is then discarded. mapped_size is likewise taken from the record
and was narrowed into an int. Use uint64_t for usize so the value
cannot truncate.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 5898a7d8eb962..d25a9fe9b020c 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
[ ... ]
> @@ -543,7 +544,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
> =20
>  	event->mmap2.pgoff =3D GEN_ELF_TEXT_OFFSET;
>  	event->mmap2.start =3D addr;
> -	event->mmap2.len   =3D usize ? ALIGN_8(csize) + usize : csize;
> +	event->mmap2.len   =3D usize ? ALIGN_8((uint64_t)csize) + usize : (uint=
64_t)csize;

[Severity: High]
This is a pre-existing issue, but is it possible for the unwinding state
to be leaked and corrupt subsequent event lengths?

Looking at jit_repipe_code_load() just above this assignment, we only
clean up the unwinding state if eh_frame_hdr_size is non-zero:

	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
		zfree(&jd->unwinding_data);
		jd->eh_frame_hdr_size =3D 0;
		jd->unwinding_mapped_size =3D 0;
		jd->unwinding_size =3D 0;
	}

If a JIT runtime emits a record with eh_frame_hdr_size =3D=3D 0, this check
fails. As a result, unwinding_mapped_size is not reset.

When processing the next JIT code load record, the stale unwinding_mapped_s=
ize
is pulled into the usize variable and added to event->mmap2.len here.

Could this inflate the mapping size and cause collisions in the perf mapping
tree, corrupting the stack trace unwinding process?

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
>  	u16 idr_size;

[Severity: High]
This is a pre-existing issue, but does the event allocation in
jit_repipe_code_move() leave room for a buffer over-read?

The event buffer is allocated with a hardcoded +16 padding:

	event =3D calloc(1, sizeof(*event) + 16);

However, later in the same function, the header size incorporates idr_size:

	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);

If idr_size (derived from the PERF_SAMPLE_* format) is greater than 16 byte=
s,
header.size could exceed the allocated chunk size.

If perf_data__write() later reads header.size bytes, could this cause an
out-of-bounds heap read and leak uninitialized heap memory into the output
perf.data file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D12
