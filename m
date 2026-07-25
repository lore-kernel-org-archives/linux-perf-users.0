Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072543164D8
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965509; cv=none; b=Adc2ebyYbnI1qcmeX4Tz3ZSH8krdbDuiT9At+am4D2sComHnhv783Ox2IxuRYTf/Fc6dXdGz80GCyO15i+ZjmPrlFGSG6hy7wc2aVJfByEDmWQFJS8akFz7w1WWljNxkysrlFN3Av8bbzj8h+rUxSyaAwNOISPU0uqRjbQ4knl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965509; c=relaxed/simple;
	bh=zsTS/TTcvyaxPYqvNl9SF4taXVsGjM1HnCUuxzrwxGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q63D5MEAqYUwzUENG7nG/DM1cDXxUJBs0Cgt2qcsXxTrJgQ/86OFG0gKXyuI8bXLA8QPu6ZsOy0uQ4Ex8cZixfBAoxXr4fKrcQD0SrOIY0bPzmWWUjW1QsHeYqB16il4Pa7p7Qj21tfI5n8W2cOcHx+hpF0ygVvj1OqegD2bSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RopPi4hU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RopPi4hU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7301F000E9;
	Sat, 25 Jul 2026 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784965507;
	bh=rsXgdsHncXTEhbdIa4LL5MWPsylastVyc+MZeqyWpE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RopPi4hUst8SGXeSQm1q9IH6DCKjYidXVR+rEeaL082he+bJdTejRQ2ciG6493Fxo
	 FhpV7frnDDrgu8P2Jfx8zVCci41Y4+raTMWRNOUW4ZMRy6DBTaW6csDAEVruMVC9/B
	 Wcjmggvkhfu0UNGmPmppramID4RxeDVyS91CrjIIkGzLHGSloyls4M03tpwuTqDaep
	 WWtOAlE3ciJfhEnf6si5LNUfj7JdtpKyu3GAiMEvr8bG3Z309Qfc4k2jjM/Cq6IPuy
	 DdsVqW1bRpRGyvsXpXvpoU6FCZTJQpRCbJr7QU6BSCb+xNagJsH1JZCOwWnK5MX3Bq
	 XBeEDHe/HxdQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/6] powerpc/perf: Add AUX buffer management to
 capture HTM trace data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725065942.78839-4-atrajeev@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
 <20260725065942.78839-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:45:06 +0000
Message-Id: <20260725074507.5C7301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Using a shared per-CPU `perf_output_handle` causes a NULL poin=
ter dereference on reentrancy between process and NMI contexts.
- [High] Stale AUX buffer state (`collect_htm_trace`) permanently prevents =
dumping trace data for subsequent tracing sessions.
- [Medium] The PMU driver fails to reject snapshot (overwrite) mode, leadin=
g to an infinite `-ENOSPC` drain loop in userspace.
--

--- Patch [3]: [PATCH V3 3/6] powerpc/perf: Add AUX buffer management to ca=
pture HTM trace data ---
commit 35468a18c6f5ab02b21271ca4f3e9ece1b6d7df7
Author: Athira Rajeev <atrajeev@linux.ibm.com>
powerpc/perf: Add AUX buffer management to capture HTM trace data

This commit implements support for auxiliary (AUX) ring buffers in the HTM =
PMU
driver. It enables high-volume trace data to be streamed directly into a pe=
rf
AUX buffer for deferred post-processing.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index 84a5601ee7f73..f880a5fc88330 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> @@ -415,8 +431,237 @@ static void htm_event_del(struct perf_event *event,=
 int flags)
>  	/* pmu_private freed by event->destroy =3D reset_htm_active */
>  }
> =20
> +static ssize_t htm_dump_sample_data(struct perf_event *event)
> +{
> +	struct htm_pmu_ctx *htm_ctx =3D this_cpu_ptr(&htm_pmu_ctx);
> +	struct htm_target_id *target =3D event->pmu_private;
> +	struct htm_pmu_buf *aux_buf;
> +	struct htm_config cfg =3D target->cfg;
> +	u64 chunk_size, dump_offset, page_index, page_offset;
> +	u64 max_contiguous_bytes, expected_phys, scan_index, actual_phys;
> +	u64 hypervisor_target_phys;
> +	void *target_page_virt;
> +	ssize_t ret =3D 0;
> +	int retries =3D 0;
> +	long rc;
> +
> +	/* Start AUX transaction session framework */
> +	aux_buf =3D perf_aux_output_begin(&htm_ctx->handle, event);

[Severity: Critical]
Does using a shared per-CPU perf_output_handle here risk a NULL pointer
dereference on reentrancy?

If a process context read is interrupted by an NMI on the same CPU, and that
NMI also calls perf_pmu_read() on the HTM event, perf_aux_output_begin() wi=
ll
detect the nesting, clear handle->event to NULL, and exit.

When the NMI returns to the process context, could the outer
perf_aux_output_end() call subsequently dereference the NULL handle->event?

> +	if (!aux_buf)
> +		return 0;
> +
> +	if (!aux_buf->collect_htm_trace) {

[Severity: High]
Can stale AUX buffer state prevent dumping trace data for subsequent sessio=
ns?

If a trace is stopped and drained, aux_buf->collect_htm_trace is set to 0.=
=20
If the event is restarted, htm_event_start() doesn't appear to reset this=20
flag.

Would this early bailout then cause trace data for all subsequent sessions =
to
be permanently dropped?

> +		perf_aux_output_end(&htm_ctx->handle, 0);
> +		return 0;
> +	}
[ ... ]
> +/*
> + * Set up pmu-private data structures for an AUX area
> + * **pages contains the aux buffer allocated for this event
> + * for the corresponding cpu. rb_alloc_aux uses "alloc_pages_node"
> + * and returns pointer to each page address.
> + * PMU capabilities: PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LA=
RGE
> + * to try get closest possible physically contiguous page blocks.
> + *
> + * The aux private data structure ie, "struct htm_pmu_buf" mainly
> + * saves
> + * - buf->base: aux buffer base address
> + * - buf->head: offset from base address where data will be written to.
> + * - buf->size: Size of allocated memory
> + */
> +static void *htm_setup_aux(struct perf_event *event, void **pages,
> +		int nr_pages, bool snapshot)
> +{
> +	int cpu =3D event->cpu;
> +	struct htm_pmu_buf *buf;
> +
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
> +	buf->nr_pages =3D nr_pages;
> +	buf->snapshot =3D snapshot;

[Severity: Medium]
Does the driver need to validate and reject snapshot (overwrite) mode?

When in snapshot mode, perf_aux_output_begin() leaves handle.size =3D 0.
This would cause htm_dump_sample_data() to interpret chunk_size as 0, fallb=
ack
to returning -ENOSPC, and cause htm_event_read() to set event->count =3D 1.

Could this result in the userspace perf tool spinning in an infinite retry
loop waiting for space that will never become available?

> +	buf->size =3D (u64)nr_pages << PAGE_SHIFT;
> +	buf->pages =3D pages;
> +
> +	buf->base =3D pages[0];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725065942.7883=
9-1-atrajeev@linux.ibm.com?part=3D3
