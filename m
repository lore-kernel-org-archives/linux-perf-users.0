Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B63D091B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545804; cv=none; b=Wzm8nZvafnjyy1FGwUH54u1rNWG2ioEADOskwdEAIjZUr8deSV5N2vq5lw7JnC0H0DgF0t+Q8S1Hh9pXWVzWk03OBoVIwKXldxJsnX7/czpAyZlQMQdEP/C+Om4G3vaGOP4gUm5CTc9kjLL29u/dVQvLoJniC0LPAdFD1RDnf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545804; c=relaxed/simple;
	bh=vBbV4Eo7m+UHc7VsPRBFlZwv5IDAEvhU+BskRKEyRME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lSX/jbtq2wZVZBxyZ1vlKnQGPRXcz1KkjLXlnkiNMyomI2m8udAzSNYL4nFNLQ+vV3nidwjs/+71O9s6leLNpAb9CqEzxTI5D+Uagym0MeL43lf+gQxqKYQV6G16LVNnhibLdSOZr51/BIji6B9yg0Vz77F54gqkQkDzMC50R6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL7GJCd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL7GJCd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D80D1F00A3A;
	Mon, 20 Jul 2026 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784545803;
	bh=T/sB4t6BgbjCca+pfJZqYTXKUU6mQmWHXcvGtEpufxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mL7GJCd1+QLfEkpf0xY8U/WsWZI6ZR11Z8HvvJnBr2l/3OajDg7dwja3ZKQXmGYNU
	 Miif3oeLq+QrJ5VDgoL78dzgP+Svf8IBlsaZJiyKnDTFHrNs9khzi+f0z5Xd9BVaVr
	 efHF4dYO7KCjWGH6CnUt2uEPC8qty2GbZMxflayvo/wh6oXDYLybbfE6suaaNwdYRa
	 EwhHCQGNNIZGXkYE2A3kPJU4fa2A4eAa+Pr1R667zAtQl4ZAQg82RaLuDW6MmSKzQv
	 x/VbTbrJuiDBXHzltUmqerAgGM4ODxv6CSwl2sz9bCMBj2G+alV+Y4dQYr/z93oL+7
	 lVJVCRVdGUSDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/6] powerpc/perf: Add AUX buffer management to
 capture HTM trace data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720104447.11843-4-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:10:03 +0000
Message-Id: <20260720111003.6D80D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Reentrancy corruption of the per-CPU perf_output_handle leads to U=
se-After-Free.
- [High] Transient conditions permanently disable trace collection and fals=
ely signal EOF.
--

--- Patch [3]: [PATCH V2 3/6] powerpc/perf: Add AUX buffer management to ca=
pture HTM trace data ---
commit edd04ff363591ec700b1e3d07e1003b1787ccb4a
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add AUX buffer management to capture HTM trace data
   =20
This commit adds support for auxiliary (AUX) ring buffers in the HTM PMU
driver. It implements the core lifecycle hooks and dynamically checks for
physical continuity before dumping data to prevent memory corruption.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index a188a40287044..b4020a6e8f30b 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> +struct htm_pmu_ctx {
> +	struct perf_output_handle handle;
> +};
> +
> +static DEFINE_PER_CPU(struct htm_pmu_ctx, htm_pmu_ctx);
> +
[ ... ]
> +static int htm_dump_sample_data(struct perf_event *event)
> +{
> +	struct htm_pmu_ctx *htm_ctx =3D this_cpu_ptr(&htm_pmu_ctx);
[ ... ]
> +	/* Start AUX transaction session framework */
> +	aux_buf =3D perf_aux_output_begin(&htm_ctx->handle, event);

[Severity: High]
What happens to the perf_output_handle if this is re-entered from an NMI
context?

htm_event_read() initiates a synchronous AUX output transaction using a
per-CPU struct perf_output_handle. Since this can be called from process
context (for instance, userspace reading the perf event fd), an NMI
interrupting this could trigger a BPF program that calls
bpf_perf_event_read() on the same CPU.

Would this overwrite the per-CPU handle, causing the interrupted outer
call to use a corrupted handle when it resumes, leading to underflowing
reference counts and a use-after-free of the AUX pages? Could the
handle be allocated on the stack instead to prevent this?

> +	if (!aux_buf)
> +		return 0;
[ ... ]
> +	/*
> +	 * Assess constraints regarding space remaining across the mapping
> +	 * context boundary
> +	 */
> +	chunk_size =3D htm_ctx->handle.size;
> +	chunk_size &=3D PAGE_MASK;
> +
> +	if (chunk_size > (aux_buf->size - dump_offset))
> +		chunk_size =3D aux_buf->size - dump_offset;
[ ... ]
> +	/* Bound transfer length tightly within the validated contiguous window=
 */
> +	if (chunk_size > max_contiguous_bytes)
> +		chunk_size =3D max_contiguous_bytes;
> +
> +	if (!chunk_size) {
> +		aux_buf->collect_htm_trace =3D 0;

[Severity: High]
Does this permanently disable trace collection during a transient buffer fu=
ll
condition?

If the remaining space in the user-space perf ring buffer is temporarily
less than PAGE_SIZE, chunk_size will evaluate to 0. This sets
collect_htm_trace to 0, which prevents any future trace collection for the
lifetime of the buffer.

> +		perf_aux_output_end(&htm_ctx->handle, 0);
> +		return 0;
> +	}
> +
[ ... ]
> +	do {
> +		/*
> +		 * Invoke H_HTM call with:
> +		 * - operation as htm dump (H_HTM_OP_DUMP_DATA)
> +		 * - last three values are address, size and offset
> +		 */
> +		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> +				cfg.coreindexonchip, cfg.htmtype, H_HTM_OP_DUMP_DATA,
> +				hypervisor_target_phys, chunk_size, aux_buf->head);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
> +
> +	if (ret > 0) {
> +		aux_buf->head +=3D chunk_size;
> +		aux_buf->trace_records++;
> +		perf_aux_output_end(&htm_ctx->handle, chunk_size);
> +		return ret;
> +	}
> +
> +	aux_buf->collect_htm_trace =3D 0;

[Severity: High]
If the hypervisor returns a transient long-busy status (like
H_LONG_BUSY_ORDER_1_MSEC), htm_return_check() returns -EAGAIN.

Will the loop exit and fall through to this block, permanently disabling
tracing for this buffer session?

> +	perf_aux_output_end(&htm_ctx->handle, 0);
> +	return ret;
> +}
> +
> +static void htm_event_read(struct perf_event *event)
> +{
> +	int ret;
> +
> +	/*
> +	 * Update event->count as a binary indicator:
> +	 * 1 if data was dumped into the
> +	 * AUX buffer, 0 otherwise. Actual trace record
> +	 * decoding is left to userspace.
> +	 */
> +	ret =3D htm_dump_sample_data(event);
> +	if (ret <=3D 0)
> +		local64_set(&event->count, 0);

[Severity: High]
Since the transient buffer full condition or hypervisor busy state causes
htm_dump_sample_data() to return 0 or -EAGAIN, does this falsely signal
an EOF to userspace by setting event->count to 0?

> +	else
> +		local64_set(&event->count, 1);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720104447.1184=
3-1-atrajeev@linux.ibm.com?part=3D3
