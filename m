Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249ED1F0991
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965382; cv=none; b=u2hc1iMpEJjFIILOX3kjSl1Dil/d6eyTwLFz1Fsjq8phUUkk2NJVJWa4pR9mXbKDe1fsH9p/b0UvPjBXzUzot2r2QVWsDJYi6YzHKU1xyjVxD2ojgM1hDBmRMFx+DKj0a6R9n4IjzRoPyUd74XMQBL0aXbFelbQo1lUmEWR50s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965382; c=relaxed/simple;
	bh=KEPNauGxQfyMes/wPGCEDgnkgYjcJEmKybjx/LRKud8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P55aammoSRk/wK6F5gXjgvOupcCw/4xL8VqkVgcbLz4fPNq4SUTUgbNMCGWn2ncV7KkJl5InV+m86dC+yfDUSigY2QxbsCkB2yPmGptzYR/KXQ5jAh9QTHYeQns2MHESyI3plxNFJhYii78rP8YFW9hUH+FbZWQ3XlkhrlMPSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQmSVJGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQmSVJGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D145E1F000E9;
	Sat, 25 Jul 2026 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784965381;
	bh=y9kkg3yxQXVLHmnQbrSFS4LN2ONj6OqE0yH/nV5SZdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQmSVJGgZnCM1YVeWs3AKWH0lSD/XEqGeaT3qyfmDbxqhl6Hi7jGgoVgH+TuDKaoq
	 GiLM6vn60fDkPDHJU6THu+hpSlxaOe8Xoy3PPmsLinRwf3PA8sK9mgS79qRb9bbrwr
	 S3OSSRrrbo5gM/r3HwZ4jf+70sMRz+VmUaZi/RDGmdnraEcsuo9XIHpK8CPtryjSHG
	 RN6ec4SSflj1WLMoY/Oc5oZHH/nFkhf9/TKMkWQ1Nqi1jy/9xrW9fXC/ajYAhWNgrE
	 AUW+RUwt7h7gjRtlhvzLjcS8qR8Ek4V2SZ70fXHVBrT/Akj0PFiE/KpkF7eXw4Rayb
	 cng8ZuSUf7PtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/6] powerpc/perf: Capture the HTM memory
 configuration as part of perf data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725065942.78839-5-atrajeev@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
 <20260725065942.78839-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:43:00 +0000
Message-Id: <20260725074300.D145E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] HTM_MEM_BUF_SIZE (65440 bytes) leaves insufficient headroom for dy=
namic perf sample fields, causing perf_event_header.size to overflow its u1=
6 limit and corrupt the ring buffer.
- [High] Uninitialized kernel stack memory in struct pt_regs is leaked to u=
serspace when the event is configured with PERF_SAMPLE_REGS_INTR.
- [High] Misinterpretation of perf_event_overflow() return value causes sil=
ent data loss when the ring buffer is full, and data duplication when the e=
vent is throttled.
- [High] htm_mem_buf is allocated with kmalloc_node instead of kzalloc_node=
, potentially leaking uninitialized kernel heap memory to userspace.
- [Medium] htm_collect_memory_config fails to accumulate the emitted entry =
counts across its loop iterations, resulting in metric under-reporting.
--

--- Patch [4]: [PATCH V3 4/6] powerpc/perf: Capture the HTM memory configur=
ation as part of perf data ---
commit ace2c86ce33c6759f7015fdf1bd6da0f6b6ecba3
Author: Athira Rajeev <atrajeev@linux.ibm.com>
Subject: powerpc/perf: Capture the HTM memory configuration as part of perf=
 data

This commit captures HTM system memory configuration records by dumping them
into the AUX buffer and emitting them as raw perf samples. It introduces
buffers for the hypervisor dump, handles layout sizing, and iterates through
memory config batches using H_HTM_OP_DUMP_SYSMEM_CONF.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index f880a5fc88330..af9a8412ff20f 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c

[ ... ]

> +/*
> + * HTM_MEM_BUF_SIZE is the allocation size for the hcall staging buffer.
[ ... ]
> + * 65440 =3D 32 + 2043 * 32 is the largest multiple of 32 satisfying all
> + * three constraints:
> + *   - covers 64480 with 960 bytes headroom
> + *   - total record: 65440 + 92 =3D 65532 < 65535 (3-byte u16 margin)
> + *
> + * HTM_MEM_MAX_ENTRIES is derived from HTM_MEM_BUF_SIZE =E2=80=94 not th=
e other
> + * way around =E2=80=94 so the hcall is always given the true buffer siz=
e and
> + * the WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE) guard is a genuine
> + * impossibility check rather than a post-overflow assertion.
> + */
> +#define HTM_MEM_BUF_SIZE	65440U

[Severity: High]
Could the buffer size calculation cause an overflow if dynamic sample
attributes are used?

The commit message states the fixed overhead is 92 bytes, which leaves
(65535 - 92 =3D 65443) bytes for the payload. However, if the event is
configured with PERF_SAMPLE_REGS_INTR, the size of struct pt_regs (which is
over 300 bytes on PowerPC) is added to the sample size.

Does this cause perf_sample_data_size() to return a value greater than 6553=
5,
which would wrap around when assigned to the __u16 header.size in
perf_prepare_header(), potentially leading to ring buffer corruption?

> +#define HTM_MEM_MAX_ENTRIES	((HTM_MEM_BUF_SIZE - 32) / 32)	/* 2043 */

[ ... ]

> +static ssize_t htm_collect_memory_config(struct perf_event *event,
> +					 struct htm_pmu_buf *aux_buf)
> +{
> +	struct perf_sample_data data;
> +	struct perf_raw_record raw;
> +	struct pt_regs regs;

[Severity: High]
Is it possible for this uninitialized stack variable to leak kernel memory?

The regs structure is partially initialized by perf_fetch_caller_regs(),
which on PowerPC only sets nip, gpr[1], result, and msr:

perf_arch_fetch_caller_regs(regs, CALLER_ADDR0) {
    ...
}

If the event uses PERF_SAMPLE_REGS_INTR, will perf_output_sample() write the
uninitialized portions of this pt_regs structure into the perf ring buffer,
exposing stale kernel stack contents to userspace? Should this be initializ=
ed
with an empty initialization?

> +	u8 *htm_mem_buf =3D aux_buf->htm_mem_buf;
> +	__be64 *num_entries;

[ ... ]

> +		perf_sample_data_init(&data, 0, event->hw.last_period);
> +		memset(&raw, 0, sizeof(raw));
> +		raw.frag.data =3D emit_buf;
> +		raw.frag.size =3D to_copy;
> +		perf_sample_save_raw_data(&data, event, &raw);
> +
> +		if (perf_event_overflow(event, &data, &regs)) {

[Severity: High]
Does this logic misinterpret the return value of perf_event_overflow()?

Looking at __perf_event_overflow(), it returns non-zero (1) only when an
event is throttled. If it returns 1, the current sample was already
successfully written before the throttle triggered. However, the driver
assumes failure here, skips advancing mem_start, and emits the exact same
block again on the next pass.

Conversely, if the ring buffer fills up, the core drops the sample but
__perf_event_overflow() still returns 0. When it returns 0, the driver
assumes success, advances mem_start, and silently loses configuration data.

Is this behavior intended, or should it be adjusted to avoid silent data
loss and duplication?

> +			/*
> +			 * Event throttled: the record was not written to the
> +			 * ring buffer.  Do NOT advance mem_start =E2=80=94 the same
> +			 * block will be retried on the next htm_event_read()
> +			 * call once the event is unthrottled.  Leave
> +			 * collect_htm_mem set so the retry path is entered.
> +			 * Return -ENOSPC so htm_event_read() sets event->count=3D1,
> +			 * keeping the drain loop alive until the ring buffer
> +			 * consumer catches up.
> +			 */
> +			ret =3D -ENOSPC;
> +			break;
> +		}
> +
> +		/* Record written successfully: advance the iterator */
> +		aux_buf->mem_start =3D next_start;
> +
> +		/*
> +		 * Return the number of 32-byte memory configuration entries
> +		 * in this batch (to_copy / 32).  Dividing here keeps
> +		 * htm_event_read() free of format knowledge, consistent with
> +		 * the AUX trace path returning chunk_size / 128.
> +		 */
> +		ret =3D (ssize_t)(to_copy / 32);

[Severity: Medium]
Does this assignment under-report the emitted entry counts?

Since this is inside a while (true) loop, multiple chunks of memory
configuration data might be processed. By directly overwriting ret instead
of accumulating it (e.g., ret +=3D to_copy / 32), the function seems to ret=
urn
only the count from the last chunk processed.

Will this permanently drop the counts of all records emitted in prior loop
iterations during the same session?

> +
> +		if (!next_start) {
> +			aux_buf->collect_htm_mem =3D 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}

[ ... ]

> +static void *htm_setup_aux(struct perf_event *event, void **pages,
> +		int nr_pages, bool snapshot)
> +{

[ ... ]

> +	/*
> +	 * htm_mem_buf is the staging area passed directly to the
> +	 * H_HTM_OP_DUMP_SYSMEM_CONF hcall.  The hypervisor is told the
> +	 * buffer length is HTM_MEM_BUF_SIZE (65440 bytes); allocate exactly
> +	 * that amount.  See the HTM_MEM_BUF_SIZE comment for the derivation.
> +	 */
> +	buf->htm_mem_buf =3D kmalloc_node(HTM_MEM_BUF_SIZE, GFP_KERNEL, cpu_to_=
node(cpu));

[Severity: High]
Could allocating this buffer with kmalloc_node() lead to an information lea=
k?

This buffer is passed to the hypervisor and subsequently copied to userspace
via the perf ring buffer:

htm_collect_memory_config() {
    ...
    memcpy(emit_buf, aux_buf->htm_mem_buf, to_copy);
    ...
}

If the hypervisor successfully returns but writes fewer entries than it
claims, leaves reserved fields untouched, or inserts padding bytes, will the
uninitialized kernel heap memory be exposed to userspace? Should this use
kzalloc_node() instead to defensively zero-initialize the memory?

> +	if (!buf->htm_mem_buf) {
> +		kfree(buf);
> +		return NULL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725065942.7883=
9-1-atrajeev@linux.ibm.com?part=3D4
