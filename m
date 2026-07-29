Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166F486E45
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329913; cv=none; b=HF+GgLmbK9laTV3eJe3QlpY9sIokTz0J4YrBZSqA+ahoHuK48+h6vZMT9wWsWqfkomFsb/WBkh5p+T6drpLssi4yv+TnZkPCC5ll8EwglQHKksAurxcaOTamp2Bf3f+9ZxdqmeReB6cHbI09XXWh94TI+6FdYxj0j+oImrIh68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329913; c=relaxed/simple;
	bh=X50zz+riKI1ZlMvx4FyNauZiErq7Rbakmj4HcNUsEE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b7nQ5RN2gROCT1K1i6h6k+6qRmLvmkSFqzHQ0XKay3kLpH3DHhngGkfiXbti6GvsZbFqvx2j4DDeke5WYsYctDpal0NVr+f5dXaIpBukqrWepWkjuEutP8Oq3432h0x2n4iQ0c8LcNtHef7VyLI4W1yc21L5UDshBc7OrXNs9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEZkDGpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEZkDGpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A11F00A3D;
	Wed, 29 Jul 2026 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329908;
	bh=2sQIxLL1SUbRlbqkfkmpEpJx8Gh50fUOlbdrSBQn0cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEZkDGpUH1HgkAukpSdmA0/SqlEBIBClg/tAPlpHcdrn93pjYzNnzzh/wXg/Jaf7R
	 oAXSlwGGYw0I5fx1M8RnD1+QkWJpp/eQYsssESdjMu++hhXZsS37oXAnTi93ZpxtbL
	 fzZB9XqOPAMyfq4e81dVpi+km4y0zcDzAYsYs5L5hXoeJx4eB+I4KvYTKojdOYOvX2
	 88ZYaxe/Ye2GVtCyChk/Jfe7bF/AcctL3vcV+CLQMFcme4kJo8GCH2BBJGF3GEzX7r
	 7sNNDjZWHqj2wy81JFhO89WmIngjbdy6co3w42vzmZi5q3NcNPQkOexy5XnKVv+Hpu
	 p75G0ldtM6K/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/6] powerpc/perf: Capture the HTM memory
 configuration as part of perf data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729123752.63010-5-atrajeev@linux.ibm.com>
References: <20260729123752.63010-1-atrajeev@linux.ibm.com>
 <20260729123752.63010-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:58:28 +0000
Message-Id: <20260729125828.A77A11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The HTM_MEM_BUF_SIZE (65440 bytes) combined with dynamic sample ty=
pes causes perf_event_header.size to overflow its 16-bit limit, leading to =
severe ring buffer corruption.
- [High] BPF programs running in NMI context can concurrently invoke the dr=
iver's .read callback, causing unprotected state mutations and hardware des=
ynchronization.
- [High] Uninitialized `struct pt_regs regs` in `htm_collect_memory_config(=
)` leaks kernel stack memory to userspace via `PERF_SAMPLE_CALLCHAIN` and B=
PF attachments.
- [Medium] The memory configuration dump is prematurely aborted if the AUX =
ring buffer is full.
- [Medium] Silent loss of HTM memory configuration data on main ring buffer=
 pressure due to incorrectly advancing the hypervisor iterator.
--

--- Patch [4]: [PATCH V4 4/6] powerpc/perf: Capture the HTM memory configur=
ation as part of perf data ---
commit 2c90eb9bba9472cb2bbddbb6b37c3d4c8154e12b
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Capture the HTM memory configuration as part of perf data

This commit introduces functionality to capture the hypervisor's memory
configuration during an HTM trace. It handles emitting the configuration as
a raw perf sample data record after the AUX trace dump completes. A
dedicated buffer is tracked per AUX session to stage the hcall payload.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index 0b954a7ed4dd9..093d54d803ce9 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> +static ssize_t htm_collect_memory_config(struct perf_event *event,
> +					 struct htm_pmu_buf *aux_buf)
> +{
> +	struct perf_sample_data data;
> +	struct perf_raw_record raw;
> +	struct pt_regs regs;
[ ... ]
> +	/*
> +	 * Initialise regs to the current caller context.  perf_event_overflow()
> +	 * may sample register state into the ring buffer. Use
> +	 * perf_fetch_caller_regs() to capture a safe, deterministic snapshot
> +	 * of the current CPU state =E2=80=94 the same pattern used by tracepoi=
nts and
> +	 * BPF perf-event helpers for synthetic sample emission.
> +	 */
> +	perf_fetch_caller_regs(&regs);

[Severity: High]
Does this leak uninitialized stack memory?

perf_fetch_caller_regs() on PowerPC only initializes a few fields (result,
nip, gpr[1], msr) in the pt_regs structure. The rest of the stack-allocated
regs structure remains uninitialized.

If the event is opened with PERF_SAMPLE_CALLCHAIN, perf_callchain_kernel()
can read from regs->link and write the uninitialized stack bytes to the ring
buffer. Is it necessary to zero the structure before fetching the regs?

> +
> +	/* Issue one hcall with the current iterator position */
[ ... ]
> +	perf_sample_data_init(&data, 0, event->hw.last_period);
> +	memset(&raw, 0, sizeof(raw));
> +	raw.frag.data =3D htm_mem_buf;
> +	raw.frag.size =3D to_copy;
> +	perf_sample_save_raw_data(&data, event, &raw);

[Severity: High]
Can the calculated size overflow perf_event_header.size?

The HTM_MEM_BUF_SIZE is 65440 bytes. With 92 bytes of fixed overhead, this
leaves very little room before overflowing the 65535-byte limit of the u16
header size.

If dynamic sample types like PERF_SAMPLE_CALLCHAIN or PERF_SAMPLE_STACK_USER
are configured (since they are not rejected in htm_event_init()), dyn_size
will increase and the total size will exceed 65535, truncating the header
size and causing ring buffer corruption. Should dynamic sample sizes be
restricted for this event?

> +
> +	if (perf_event_overflow(event, &data, &regs)) {
> +		/*
> +		 * Event throttled: overflow_handler ran unconditionally before
> +		 * returning, so the sample WAS written to the ring buffer.
> +		 * Advance mem_start so the same block is not emitted again.
> +		 * Return -ENOSPC so htm_event_read() sets event->count=3D1,
> +		 * keeping the drain loop alive to emit the next block once
> +		 * the event is unthrottled.
> +		 */
> +		aux_buf->mem_start =3D next_start;
> +		if (!next_start)
> +			aux_buf->collect_htm_mem =3D 0;
> +		return -ENOSPC;
> +	}
> +
> +	/* Record emitted successfully: advance the iterator */
> +	aux_buf->mem_start =3D next_start;

[Severity: Medium]
Does this unconditionally advance the hypervisor iterator even if the sample
is dropped?

If the main ring buffer is full, perf_output_begin() fails and the sample is
dropped. However, perf_event_overflow() still returns 0 (it only returns
non-zero if the event is throttled).

Since the return value is 0, the code falls through and advances
aux_buf->mem_start =3D next_start. Could this cause silent data loss of the
memory configuration records?

> +	if (!next_start)
> +		aux_buf->collect_htm_mem =3D 0;
> +
> +	/*
> +	 * Return the number of 32-byte entries emitted.  Dividing here keeps
> +	 * htm_event_read() free of format knowledge, consistent with the AUX
> +	 * trace path returning chunk_size / 128.
> +	 */
> +	return (ssize_t)(to_copy / 32);
> +}
[ ... ]
> @@ -523,7 +674,7 @@ static ssize_t htm_dump_sample_data(struct perf_event=
 *event)
[ ... ]
>  	/* Start AUX transaction session framework */
>  	aux_buf =3D perf_aux_output_begin(&htm_ctx->handle, event);
>  	if (!aux_buf)
>  		return 0;

[Severity: Medium]
Does returning 0 here prematurely abort the memory configuration dump?

If the AUX ring buffer is full, perf_aux_output_begin() returns NULL.
Returning 0 signals EOF to userspace, preventing htm_collect_memory_config()
from being called. Does this prevent userspace from receiving the required
configuration data to decode the trace?

> =20
> -	if (!aux_buf->collect_htm_trace) {
> +	if (!aux_buf->collect_htm_trace && !aux_buf->collect_htm_mem) {
>  		/*
>  		 * collect_htm_trace is cleared on hcall error and reset to 1
>  		 * in htm_event_start() when tracing restarts.  If it is still
[ ... ]
>  	if (target->tracing_active =3D=3D HTM_TRACING_ACTIVE) {
>  		htm_event_stop(event, 0);

[Severity: High]
Can this lockless evaluation race with a BPF program running in NMI context?

If a BPF program attached to an NMI event calls bpf_perf_event_read_value()
on the HTM event, it invokes htm_event_read() -> htm_dump_sample_data()
locklessly.

If this interrupts htm_event_start() between a successful start hcall and
setting target->tracing_active =3D HTM_TRACING_ACTIVE, this read will see
HTM_TRACING_INACTIVE and incorrectly issue H_HTM_OP_DUMP_DATA while the
hardware is actively running, leading to hardware desynchronization.

>  		if (target->tracing_active =3D=3D HTM_TRACING_ACTIVE) {
>  			/*
>  			 * H_HTM_OP_STOP failed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729123752.6301=
0-1-atrajeev@linux.ibm.com?part=3D4
