Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BD434E48
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329506; cv=none; b=Sb1Nv91hjg7UkvE79zzR+5ryfnO390fqOE52gqVzs/rpIas9iTeIinrckhiRbo7yx/9vwWHajUq4Fqt35GzN/2haA+oElFxkG7g3K5J1RcvwmyhslGsZUEPbXlD1ekZraaejYzfl2MIk8wZ8ZoKTyNlCPPIgnxvKLuMZURQ3LCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329506; c=relaxed/simple;
	bh=DkOHR0Wm4QxtlTNJis1AuJQBbFScAQnIky8zDCnng34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nPSrR3rveHeozAFUNUnjC/Uk2NakjUgx07dbfIwEsiKiUCi8H8spcEh8JxsbcOl1474c+aig3WPPMB2+BJ1NktpHf9lHJ4OsQ409HOe+kqK2dcC6STa6WYNF0QptBOwLRsbO0225fpU+Oc0zKu3OLFm+6CAamaukHvKnrH4rNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzavAjc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzavAjc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0673D1F00A3A;
	Wed, 29 Jul 2026 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329505;
	bh=3R1QUmg5yba4cKEjLqmBfly4MZx9JnSb/94lDPSmaDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KzavAjc1nKZNy+rOon+fictgczAg5rlNE28Cy9gFRYW/0gqcC8J/Mmt9ea+MwT71j
	 yj/m50aC26NvjvPqtlCeFT2n6lcdE8B9CWWPv103ixLqapJiAOoRvwaW3ZrqJZLi1r
	 /MBCA3xMcJaX7KnuepK1MzsgekF+RWdxtmhw62Kzw82K7fxX2dt5ZP7mT0LbzQj6Bu
	 W3BXiXSfQhKNpJUkYrjfaKq5QHxVLJL96o0bLfnzQnT1AT1BhqNF6GcdNGS9d/ovm6
	 ECcyHx+B+k/dnN/Qj/k9YJC3wA3VG8oJXF7tPr4OJHNXdUl54zJzxXFgy0uir7tPtX
	 XfojwlENIBFIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 3/6] powerpc/perf: Add AUX buffer management to
 capture HTM trace data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729123752.63010-4-atrajeev@linux.ibm.com>
References: <20260729123752.63010-1-atrajeev@linux.ibm.com>
 <20260729123752.63010-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:51:44 +0000
Message-Id: <20260729125145.0673D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Nested calls to `perf_aux_output_begin` from NMI context corrupt t=
he outer context's shared per-CPU `struct perf_output_handle`.
- [High] `htm_dump_sample_data()` permanently stops the hardware trace buff=
er during a read without restarting it, breaking continuous streaming.
- [High] Applying `PAGE_MASK` to `chunk_size` zeroes the size when availabl=
e ring buffer space is under `PAGE_SIZE`, causing a permanent stall and 100=
% CPU hog in userspace.
--

--- Patch [3]: [PATCH V4 3/6] powerpc/perf: Add AUX buffer management to ca=
pture HTM trace data ---
commit 8304e887ab454be629979799f609224f8a64f9ec
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add AUX buffer management to capture HTM trace data

This patch implements support for auxiliary (AUX) ring buffers in the HTM
PMU driver. It introduces core lifecycle hooks and data structures to stream
trace data into perf AUX buffers.

>     htm_pmu_ctx embeds a struct perf_output_handle as a per-CPU variable,
>     following the established upstream pattern.  Reentrancy is handled by
>     perf_aux_output_begin() itself via rb->aux_nest: when a nested caller
>     (e.g. from NMI context) detects that aux_nest is already non-zero, it
>     falls through to the err path, which sets the *nested* handle->event =
to
>     NULL and returns NULL to the nested caller.  The outer handle is never
>     touched; its handle->event remains valid throughout the outer
>     perf_aux_output_end() call.

[Severity: High]
Is this description accurate regarding the outer handle?

Since htm_pmu_ctx is defined as a static per-CPU variable, the nested conte=
xt
uses the exact same perf_output_handle object as the outer context. When the
nested perf_aux_output_begin() call hits the error path, it clears handle->=
event
on that shared object.

Would this clear the event pointer of the interrupted outer transaction, ca=
using
the outer perf_aux_output_end() to return early without decrementing rb->au=
x_nest?

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index 1879125bc4102..0b954a7ed4dd9 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c

[ ... ]

> @@ -95,6 +95,22 @@ static inline void parse_htm_config(u64 config, struct=
 htm_config *cfg)
>  	cfg->coreindexonchip =3D (config >> 20) & 0xff;
>  }
> =20
> +struct htm_pmu_buf {
> +	int     nr_pages;
> +	bool    snapshot;
> +	void    *base;
> +	void	**pages;
> +	u64	head;
> +	u64     size;
> +	int     collect_htm_trace;
> +};
> +
> +struct htm_pmu_ctx {
> +	struct perf_output_handle handle;
> +};
> +
> +static DEFINE_PER_CPU(struct htm_pmu_ctx, htm_pmu_ctx);

[Severity: High]
Is it safe to share a single perf_output_handle per-CPU?

If an NMI interrupts an active AUX transaction on the same CPU, the nested
execution passes this exact same handle pointer to perf_aux_output_begin().
Could we define the handle as a stack variable in htm_dump_sample_data() and
htm_event_start() instead to prevent reentrancy corruption?

[ ... ]

> @@ -465,8 +504,254 @@ static void htm_event_del(struct perf_event *event,=
 int flags)
>  	/* pmu_private freed by event->destroy =3D reset_htm_active */
>  }
> =20
> +static ssize_t htm_dump_sample_data(struct perf_event *event)
> +{
> +	struct htm_pmu_ctx *htm_ctx =3D this_cpu_ptr(&htm_pmu_ctx);

[ ... ]

> +	if (target->tracing_active =3D=3D HTM_TRACING_ACTIVE) {
> +		htm_event_stop(event, 0);
> +		if (target->tracing_active =3D=3D HTM_TRACING_ACTIVE) {
> +			/*
> +			 * H_HTM_OP_STOP failed.
> +			 * Cannot dump data while the trace is still running.
> +			 * Return -EIO to signal a non-retriable hardware failure;
> +			 * htm_event_read() will set event->count=3D0 and the drain
> +			 * loop will stop cleanly.
> +			 */
> +			perf_aux_output_end(&htm_ctx->handle, 0);
> +			return -EIO;
> +		}
> +	}

[Severity: High]
Does this permanently halt tracing when data is read?

When htm_dump_sample_data() is called (via pmu->read), it calls htm_event_s=
top()
to halt the hardware trace before dumping. After the dump finishes, the tra=
ce
is never restarted. Will this cause the hardware trace to silently stop
collecting further data the first time userspace reads from the event?

[ ... ]

> +	/*
> +	 * Assess constraints regarding space remaining across the mapping
> +	 * context boundary
> +	 */
> +	chunk_size =3D htm_ctx->handle.size;
> +	chunk_size &=3D PAGE_MASK;

[Severity: High]
Can this truncation cause a permanent stall in userspace?

If the available free space (handle.size) is less than a full page, this ap=
plies
PAGE_MASK and truncates chunk_size to 0.

Later in this function:

	if (!chunk_size) {
		/* ... */
		perf_aux_output_end(&htm_ctx->handle, 0);
		return -ENOSPC;
	}

Returning -ENOSPC sets event->count =3D 1, signaling userspace to drain the
buffer and retry. However, because 0 bytes were written, userspace has noth=
ing
new to drain, the free space remains < PAGE_SIZE, and the next read will ag=
ain
truncate to 0 and return -ENOSPC. Does this create an infinite retry loop
consuming 100% CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729123752.6301=
0-1-atrajeev@linux.ibm.com?part=3D3
