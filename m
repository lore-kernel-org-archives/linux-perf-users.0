Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB844A40C
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114660; cv=none; b=C7Z8NdePGxmbbZR+qxPYy0WXrgGZNffxtwlbu4/10TsgGQnu8ZCs8Oz8ucvdLTWfvltjLFkX1A64SAOhqja2ER1oIgAlotz2s1gArevqs0ZZnXFtuuOROpITIrwHE+HSyucCpDKoJ8kXyApXCgc7fNfswaPgl/919/rurHax8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114660; c=relaxed/simple;
	bh=vNhi+Hgadl/O0mliIHGhYK0YpMOMiIEEk2H4G+WXHgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PNG56Tsxq4CoXW0KkNlIQVNaYc4OqxufO0d6PK1f9zpR0X70dx714uiFmHb3qFPeDos3Doh7sJpciSR1F4gT9ByOWbWy8uyYC0sRLkaS39mZq3ZMVt3YtdhdGc1SNYM6u4CAitqQKEZ2x0rijUhFUt0WhxJxHd88wCmdJBatGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmNyl2u0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmNyl2u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C8D1F000E9;
	Fri,  7 Aug 2026 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114658;
	bh=2MF4S1sj3jxWSul8yPbue0Gz+9gcUs6rZnR67Mt/E58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nmNyl2u00bKf6WuKkat9q+vdMTay1dwrgYrqNNVREMDujNE1EmoR/XD99mfuvmjdc
	 GaZyX0sqi45KC9Tw3MOFGfG8O6j7djDhnIjcYgNlXStz26KhFkgcHRiEJ2TiH9eoPF
	 VNtoGaqp12j+NsHmyCEuoDroCVii/LSkOkHP9EJ4ax8D8W/jIFqdSf/UvZVvRYGCmE
	 oLWBgdciZNXB0gy+yBS/L/aQ0PPrW3qvXSRY/bNvQ6MzlWGJrNhALICPhtfn9WuyZ9
	 dW60vO19zwGkEcRqm0IIZwLlORolyrBjEnKAF3nhJDh1ckhJO5clZFNSKMMq3LehDO
	 dLYdAZiec1Amg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 3/6] powerpc/perf: Add AUX buffer management to
 capture HTM trace data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807143734.1224-4-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
 <20260807143734.1224-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:57:37 +0000
Message-Id: <20260807145738.49C8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Applying PAGE_MASK to handle.size incorrectly truncates the availa=
ble AUX buffer size, causing an infinite loop for 1-page buffers and capaci=
ty loss.
- [High] Treating H_PARTIAL as a full success for H_HTM_OP_DUMP_DATA withou=
t adjusting the dump length causes trace data corruption.
- [Medium] The driver reads an untrusted power-of-two exponent from the hyp=
ervisor and uses it in an unbounded bitwise shift.
--

--- Patch [3]: [PATCH V5 3/6] powerpc/perf: Add AUX buffer management to ca=
pture HTM trace data ---
commit f3228c159ff40b8eb4da824d28f5361ecc14dfbf
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add AUX buffer management to capture HTM trace data

Implement support for auxiliary (AUX) ring buffers in the HTM PMU driver.
This enables high-volume trace data to be streamed directly into a perf
AUX buffer for deferred post-processing by the perf tool.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index c1ce12605014b..90d26a721616b 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
> @@ -277,6 +314,32 @@ static int htm_event_init(struct perf_event *event)
>  	list_add_tail(&target->list, &htm_active_targets_list);
>  	mutex_unlock(&htm_targets_lock);
> =20
> +	/*
> +	 * Query the hardware-allocated HTM buffer size via H_HTM_OP_STATUS.
> +	 * The status output buffer header byte 0x01 holds
> +	 * CurrentNestHtmBufferSizeInPowerOf2 (for HTM_NEST) or
> +	 * CurrentCoreHtmBufferSizeInPowerOf2 (for HTM_CORE); both types
> +	 * use the same offset (0x01) and length (1 byte).
> +	 * hw_buf_size is used in htm_dump_sample_data() to bound dump
> +	 * offsets, preventing H_HTM_OP_DUMP_DATA calls past the end of the
> +	 * hardware buffer.  On failure hw_buf_size stays 0 and the boundary
> +	 * check is skipped gracefully =E2=80=94 the contiguous-window clamp st=
ill
> +	 * applies.
> +	 */
> +	status_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (status_buf) {
> +		do {
> +			src =3D htm_hcall_wrapper(htmflags, cfg.nodeindex,
> +					cfg.nodalchipindex, cfg.coreindexonchip,
> +					cfg.htmtype, H_HTM_OP_STATUS,
> +					virt_to_phys(status_buf), PAGE_SIZE, 0);
> +			sret =3D htm_return_check(src);
> +		} while (sret =3D=3D -EBUSY && ++sretries < MAX_RETRIES);
> +		if (sret > 0)
> +			target->hw_buf_size =3D 1ULL << status_buf[0x01];

[Severity: Medium]
Can this shift result in undefined behavior? If the hypervisor returns a va=
lue
greater than or equal to 64 for status_buf[0x01], the left shift will invoke
undefined behavior. Should there be a bounds check on the exponent before
performing the shift?

> +		kfree(status_buf);
> +	}
> +
>  	event->pmu_private =3D target;
>  	event->destroy =3D reset_htm_active;
>  	return 0;

[ ... ]

> @@ -510,8 +576,308 @@ static void htm_event_del(struct perf_event *event,=
 int flags)
>  	/* pmu_private freed by event->destroy =3D reset_htm_active */
>  }
> =20
> +static ssize_t htm_dump_sample_data(struct perf_event *event)
> +{
> +	struct perf_output_handle handle;
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

[ ... ]

> +	/*
> +	 * Assess constraints regarding space remaining across the mapping
> +	 * context boundary.
> +	 * handle.size is always page-aligned: perf_aux_output_begin() computes
> +	 * it as the distance from the write pointer to the wakeup boundary,
> +	 * rounded to PAGE_SIZE.  Masking with PAGE_MASK is therefore a no-op
> +	 * but is kept to make the page-granularity contract explicit.
> +	 */
> +	chunk_size =3D handle.size;
> +	chunk_size &=3D PAGE_MASK;
> +
> +	if (chunk_size > (aux_buf->size - dump_offset))
> +		chunk_size =3D aux_buf->size - dump_offset;

[Severity: High]
Does masking with PAGE_MASK artificially truncate the available AUX buffer =
size?

When the perf core allocator prepares a 1-page AUX buffer,
perf_aux_output_begin() computes handle.size as CIRC_SPACE(), which returns=
 at
most size - 1 (e.g., 4095 for a 4096-byte page).=20

The bitwise AND with PAGE_MASK (~4095) evaluates to 0. For a 1-page buffer,
the usable capacity becomes 0, causing the driver to indefinitely return
-ENOSPC and potentially trapping userspace in an infinite loop.

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
> +		perf_aux_output_end(&handle, chunk_size);

[Severity: High]
If the hypervisor partially completes the dump, does this code advance the
offsets incorrectly?

htm_return_check() maps H_PARTIAL to a success value (1):

arch/powerpc/perf/htm-perf.c:htm_return_check() {
...
	switch (rc) {
	case H_SUCCESS:
	case H_PARTIAL:
		return 1;
...
}

Because htm_return_check() discards the actual bytes written, and this
condition assumes the entire chunk_size was written on any success code,
could uninitialized or stale memory be exposed to userspace as valid trace
records, and subsequent chunks be desynchronized?

> +		/*
> +		 * Return the number of 128-byte HTM trace records written.
> +		 * Dividing here keeps htm_event_read() free of format
> +		 * knowledge: it can simply use the returned count directly,
> +		 * regardless of which data path (AUX trace or memory config)
> +		 * produced it.
> +		 */
> +		return (ssize_t)(chunk_size / 128);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807143734.1224=
-1-atrajeev@linux.ibm.com?part=3D3
