Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25339098C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895860; cv=none; b=dT4aWe+xkwlfjFOTtvVNvp5rGGvTTM+QpktoWlFxzP0m94Foca28H8SkDdgzHDkOBD0POs/TXm2nC/wvj1HlBDCEHv4xrybpzIcN+ERMl4DgPCeeHXL8TGQEijdSH3Gd3MpZhKwJoxdbElwyVama5zO32/5YBuOvQH9r5QiYrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895860; c=relaxed/simple;
	bh=7PtOzlIIFBSPQ1qHriC3fLFZb5lu1/telrdWxXoCqRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpU2Mq5iT2uIXr949N5hXQK16Pq2cWRG9yBsoHrawqjnQpDakFDbxPeMsFeY4+J8ToowwnSWo1aL6XnV/7qGGu4KkvXAzcf4jXg0YREG7LbkYMXTIH0hJhy1RvVuGyBaAeg1PpVtWbqWqrHF0ghyIGd9DPtmgzu4LARIL4WbWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSTauDFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSTauDFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC851F000E9;
	Wed,  1 Jul 2026 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782895859;
	bh=mmRccjpjR39tfqeu70UQ85Evno1BT/zu1zaIdgxRbxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSTauDFjL5kN2bpD+2Z0SPetlR/TxNBtroQ6nkNkza8a9xk+U+GByu3byboCGE8ED
	 9DzV1jKy0mxEk6z5qfEG5f3jO+CFh7M1H+MuG9Lzs/PDZI1xNmsYYyvXDgINZ6ZkJV
	 t30r0sfC/bqYduyJG5e0Oxdv9FvD35fShOrKtG4aqqRRyPpp4E6EyeKlYg5esL4YXt
	 +3o7s1B4HNQjy+CPYavMGI8F6GRd8KitDijA7/GC8fhLW5a8mvUWkIBKqLaKhzpakI
	 O7vfDA8cmDhRmziLeSt3cOqEHpMkoZvgotDaZzGGOX55sPQKwaOE+sBXTpxEvaXHbT
	 Pw7PhhzJImZvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] powerpc/htm: Add support to setup and free aux
 buffer for capturing HTM data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701083806.79358-3-atrajeev@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
 <20260701083806.79358-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:50:57 +0000
Message-Id: <20260701085058.DEC851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The driver violates the perf AUX ring buffer API by writing trace =
data to independent offsets, ignoring the core perf ring buffer head.
- [Medium] Signed integer overflow when calculating the AUX buffer size lea=
ds to a massive 64-bit value.
--

commit 10ce4df3e9571041276c72fea1e10e3955d5eea1
Author: Athira Rajeev <atrajeev@linux.ibm.com>
Subject: powerpc/htm: Add support to setup and free aux buffer for capturin=
g HTM data

This commit adds PMU callbacks for setup_aux and free_aux to enable=20
capturing HTM trace data into a perf auxiliary buffer. It allocates=20
memory and records trace data directly into the provided pages for=20
later post-processing.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index e22a7fdce2f5d..ae7f469b6840d 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> @@ -126,6 +143,74 @@ static ssize_t htm_return_check(int rc)
>  	return -EINVAL;
>  }
> =20
> +static int htm_dump_sample_data(struct perf_event *event)
> +{
[ ... ]
> +	/*
> +	 * Invoke H_HTM call with:
> +	 * - operation as htm dump (H_HTM_OP_DUMP_DATA)
> +	 * - last three values are address, size and offset
> +	 */
> +	if (aux_buf->collect_htm_trace) {
> +		do {
> +			rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreind=
exonchip,
> +				htmtype, H_HTM_OP_DUMP_DATA, virt_to_phys(aux_buf->base),
> +				(aux_buf->nr_pages * PAGE_SIZE), aux_buf->head);
> +			ret =3D htm_return_check(rc);
> +		} while (ret =3D=3D -EBUSY && ++retries < 100);
> +
> +		if (ret > 0) {
> +			aux_buf->head +=3D (aux_buf->nr_pages * PAGE_SIZE);
> +			perf_aux_output_end(&htm_ctx->handle, (aux_buf->nr_pages * PAGE_SIZE)=
);

[Severity: High]
Does this code write trace data to independent offsets, ignoring the core=20
perf ring buffer head?

If the user does not consume data fast enough, perf_aux_output_end() will=20
truncate the write to the available space. Because the driver ignores=20
htm_ctx->handle.head (the true write offset within the ring buffer) and=20
tracks its own offsets via aux_buf->base and aux_buf->head, could any=20
truncation desynchronize the driver from the perf core?

This could lead to subsequent writes going to the wrong offset while=20
userspace is told the data is at a different offset, resulting in silent=20
corruption of the perf AUX trace data.

> +		} else {
> +			aux_buf->collect_htm_trace =3D 0;
> +			perf_aux_output_end(&htm_ctx->handle, 0);
> +		}
> +	}
> +
> +	return ret;
> +}
[ ... ]
> +static void *htm_setup_aux(struct perf_event *event, void **pages,
> +		int nr_pages, bool snapshot)
> +{
> +	int cpu =3D event->cpu;
> +	struct htm_pmu_buf *buf;
> +
> +	/* We need at least one page for this to work. */
> +	if (!nr_pages)
> +		return NULL;
> +
> +	if (cpu =3D=3D -1)
> +		cpu =3D raw_smp_processor_id();
> +
> +	buf =3D kzalloc_node(sizeof(*buf), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!buf)
> +		return NULL;
> +
> +	buf->base =3D pages[0];
> +
> +	if (!buf->base) {
> +		kfree(buf);
> +		return NULL;
> +	}
> +
> +	buf->nr_pages =3D nr_pages;
> +	buf->snapshot =3D false;
> +	buf->size =3D nr_pages << PAGE_SHIFT;

[Severity: Medium]
Can the size calculation overflow for large values of nr_pages?

Since both nr_pages and PAGE_SHIFT evaluate as 32-bit signed integers,=20
a large AUX buffer allocation (e.g., nr_pages =3D 32768) could overflow int=
o=20
the sign bit. When assigned to the u64 size field, this would sign-extend=20
to a massive 64-bit value.=20

Could this result in bypassing internal bounds checks when the size is=20
later returned to the perf subsystem?

> +	buf->head =3D 0;
> +	buf->head_size =3D 0;
> +	buf->htm_stopped =3D 0;
> +	buf->collect_htm_trace =3D 1;
> +	return buf;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701083806.7935=
8-1-atrajeev@linux.ibm.com?part=3D2
