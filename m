Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AE375AD0
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122356; cv=none; b=lTDSbzPRNax1WPGkwYpCSqOGqHxOQPt2v1TAc0KB9clZ40tsk1bsXe4frE3M2DNSOpbvm0KeGJoBbFAo5sW7Hqspdces9A3IdRy/zPZHt3d83v8yEfBkBnWRes7aIqC+NErVqv6/XSEcbr6xPxmHzLAWgVZRq81Jk+TkXoHf1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122356; c=relaxed/simple;
	bh=Gx7BqacT6HeuOpEwNFbim+TTPOfwCG7iowTuUoDd7VU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ku7ymdIrnZL80f8iv0FFAHp/IJQVr5XHOFv4pnlm+wCeGZlIwxpY/Bc3wDG5gAwuriY3C+4pocca85/lyLtqHNrRBya+POybNL0+WGQ5hyT1PeQhIXVa5shTrxws3ds0npp3tjcbsXI8cTqx/y2Pn+EYJF474OzdSXKno/VynMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx1n7aEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx1n7aEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B73A1F00898;
	Wed, 10 Jun 2026 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122349;
	bh=jZESELqKpFNf4+PwpHH0ixjCiaUOj4Jb1EBvDA7FViM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bx1n7aEqnrh4dLYqtlStkTjM0WkaWC7dHdJA7qQBMwh4IuwIkIC3cKV39yCsM4vDA
	 SAWRLRHbLNYSOrirX0XZYH0bsxOQuU4sXk2g8ufnLkqGbFJeWHlkDnp8dwb7j7/1V4
	 1AwTj4YAprXqPS2XTW4H+fntoI6ifbw6Fnd1J0/6JRcDG8MqNrUItAKSg+Ey2lnepe
	 0pJfpYBjzxBulKTCxS6wddPPQ0oCErWvCUGvuCu26TH++yWQE4bX3ca3mD/sJwYzZu
	 7QM0zhA074zuY7cILInQZ46Nv3sokH1qTo2dVWVw5BodKsnmMWREule/gmngzk4lJf
	 cL/xzjaXDltOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/23] perf bpf: Fix map data leak in
 bpf_metadata_create() on alloc failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610195157.2091137-21-acme@kernel.org>
References: <20260610195157.2091137-21-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:12:28 +0000
Message-Id: <20260610201229.6B73A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer truncation of `event_size` causes a heap buffer overflow i=
n `synthesize_perf_record_bpf_metadata()`.
--

commit a9860d8e0d78f30cfefe9a3589bea7fb77d053aa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Fix map data leak in bpf_metadata_create() on alloc failure

This patch fixes a memory leak in bpf_metadata_create() where map.btf
and map.rodata were leaked. It addresses this by calling
bpf_metadata_free_map_data() before continuing if bpf_metadata_alloc()
fails.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index fe01551dc3e6c..b65ad28cd950f 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -395,8 +395,10 @@ static struct bpf_metadata *bpf_metadata_create(stru=
ct bpf_prog_info *info)
>  			continue;
> =20
>  		metadata =3D bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
[Severity: High]
This is a pre-existing issue, but this allocation can lead to a heap buffer
overflow due to integer truncation.

In bpf_metadata_alloc(), the calculated event_size is stored into a __u16:

    event_size =3D sizeof(metadata->event->bpf_metadata) +
        nr_variables * sizeof(metadata->event->bpf_metadata.entries[0]);
    ...
    metadata->event->bpf_metadata =3D (struct perf_record_bpf_metadata) {
        .header =3D {
            .type =3D PERF_RECORD_BPF_METADATA,
            .size =3D event_size,
        },

If a BPF program contains 204 or more .rodata variables prefixed with
"bpf_metadata_", event_size exceeds 65535 and silently truncates (e.g.,
65808 becomes 272).

Later, synthesize_perf_record_bpf_metadata() allocates a buffer using
this truncated size:

    const size_t event_size =3D metadata->event->header.size;
    ...
    event =3D zalloc(event_size + machine->id_hdr_size);

It then copies 512 bytes (BPF_PROG_NAME_LEN), overflowing the truncated
heap allocation:

    memcpy(event->bpf_metadata.prog_name,
           metadata->prog_names[index], BPF_PROG_NAME_LEN);

Could we add bounds checking for map.num_vars or validate event_size before
truncation?

> -		if (!metadata)
> +		if (!metadata) {
> +			bpf_metadata_free_map_data(&map);
>  			continue;
> +		}
> =20
>  		bpf_metadata_fill_event(&map, &metadata->event->bpf_metadata);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610195157.2091=
137-1-acme@kernel.org?part=3D20
