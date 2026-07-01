Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00D3F0779
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896552; cv=none; b=eyptmqH8vFMPVoR+Bu9lsrcpwPzPhoIQQ15AKaOdouol53wMOAF+hKami+GiRcDf9elfjoijsSDByldl9te7iOiQL08WZNW721mJDr/WGTRET5/aUkQ2lKV19qXBGIwojYAko1UnIVATP0CU4lFmSCdfPVu0hgciHyojYaJn7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896552; c=relaxed/simple;
	bh=qFYSBGZa4cNly5YLWAchgZ9p8xGICXUNAu/g2VHsYOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sni1EX6ISAFV2VVnEGaOTKry655vMz1XRVjmGLG+mdF0gPmObWMs4dQdKeFwhuBXCFhg2K6Vp2PtP9NhkYyonhDt8sH4NqcwlaquW7MpdWeZCujVzEq/XmhMx1Fq6iVUWJVsttXOjRNfIuovatilNwRZVnjXfpC2D4p++0suwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idbkm+fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idbkm+fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184B91F000E9;
	Wed,  1 Jul 2026 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896551;
	bh=ndmWAJ6tIEfy2qKgFJ7H6CHXrJG/J3W58A9hioM/9LM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idbkm+fsOH3XMPkCeey+hQs+VRWuA/UMHF0oPPn1a0kwWSTYwK23hM322brjsc7ej
	 fOMyBfGLHaV5VHWx5JBSn59qTUIaSWsV2x+bSId9Mwt6Lv0Q13kUJRgYAYbVSZTwem
	 YvYkeitUlTc7gdFxceStZ/G0EVul8qtZpQcCbCsbFJM/IgWvPxlxjii06MKnaDAVbg
	 1xYEjSoWwolPBT3uzpwcCWKpRMQXM+wwNktwYkm151XoLW19UN+7jBAJIbWRW8ksF0
	 D2Zqyp2PqarO/lasMW0FkLBoovhLuGj/J7G4tJSTlQUPUIJ+67jsMvpDKwVUHupnRW
	 enLVVyWf7K/Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] powerpc/perf: Capture the HTM memory configuration
 as part of perf data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701083806.79358-4-atrajeev@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
 <20260701083806.79358-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:02:30 +0000
Message-Id: <20260701090231.184B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Missing bounds check on the hypervisor-provided `num_entries` allo=
ws `to_copy` to exceed `PAGE_SIZE`, leading to an out-of-bounds read from `=
htm_mem_buf`.
- [High] The PMU driver assumes the AUX buffer pages are virtually contiguo=
us and uses `memcpy` to write sequentially into them, causing an out-of-bou=
nds write that corrupts kernel memory.
- [High] Chunks of memory configuration data are permanently lost if there =
is insufficient space in the buffer (`to_copy > space_to_end`).
- [Medium] The implementation fails to write the starting `PERF_SAMPLE_RAW`=
 record and exports incorrect size data in the ending record, violating the=
 documented API contract.
- [Medium] When wrapping the memory map trace data at the 50% threshold, th=
e remaining padding space in the buffer is left uninitialized but committed=
 to userspace.

Pre-existing issues:
- [Critical] Pre-existing logic in `htm_dump_sample_data()` passes a non-co=
ntiguous physical address base to the hypervisor, causing massive physical =
memory corruption during the trace dump.
--

commit 651e2e981cb409f60d68fe643ec0cd48a6edd6e7
Author: Athira Rajeev <atrajeev@linux.ibm.com>
Subject: powerpc/perf: Capture the HTM memory configuration as part of perf=
 data

This commit modifies the HTM PMU driver to capture system memory configurat=
ion
data in the perf AUX buffer. It uses the H_HTM_OP_DUMP_SYSMEM_CONF hypervis=
or
call to retrieve the data and demarcates it using PERF_SAMPLE_RAW records.

>  When monitoring the HTM pmu, auxiliary buffer captures
>  the "trace" data and SystemMemory Configuration. This
>  will be post processed later using perf. The size of memory
>  mapping data captured depends on how large is the system
>  and how much memory is allocated. To help with relating
>  and identifying the start of memory mapping data in the
>  auxiliary buffer, insert two PERF_SAMPLE_RAW records in the
>  ring buffer. First PERF_SAMPLE_RAW record will mark the
>  beginning of system memory mapping data in aux buffer. And second
>  PERF_SAMPLE_RAW record will be written at the end to make the
>  end of the data in aux buffer and also contains the total size
>  of the memory map data. These sample raw records
>  will be used during post processing in perf report.

[Severity: Medium]
Is the start PERF_SAMPLE_RAW record missing entirely from the code, contrary
to this commit message?

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> index ae7f469b6840d..fe458bc3ec05d 100644
> --- a/arch/powerpc/perf/htm-perf.c
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> @@ -143,6 +147,86 @@ static ssize_t htm_return_check(int rc)
>  	return -EINVAL;
>  }
> =20
> +static int htm_collect_memory_config(struct perf_event *event,
> +					struct htm_pmu_buf *aux_buf)
> +{
> +	struct perf_sample_data data;
> +	struct perf_raw_record raw;
> +	struct pt_regs regs;
> +	u64 *num_entries;
> +	u64 to_copy =3D 0;
> +	int htm_val;
> +	long rc;
> +	int ret;
> +	int retries =3D 0;
> +	size_t size;
> +	size_t space_to_end =3D aux_buf->size - aux_buf->mem_head;
> +
> +	/* Capture HTM system memory configuration in aux buffer */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, 0, 0, 0,
> +				0, H_HTM_OP_DUMP_SYSMEM_CONF, virt_to_phys(aux_buf->htm_mem_buf),
> +				PAGE_SIZE, aux_buf->mem_start);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < 100);
> +
> +	/* Return once there is no more data in HTM buffer */
> +	if (ret <=3D 0) {
> +		perf_sample_data_init(&data, 0, event->hw.last_period);
> +		memset(&raw, 0, sizeof(raw));
> +		memset(&regs, 0, sizeof(regs));
> +
> +		htm_val =3D (aux_buf->head/((aux_buf->nr_pages * PAGE_SIZE)));
> +		raw.frag.data =3D &htm_val;
> +		raw.frag.size =3D sizeof(htm_val);

[Severity: Medium]
Does this export the buffer wrap count instead of the total size of the
memory map data in the end record?

> +
> +		aux_buf->collect_htm_mem =3D 0;
> +		perf_sample_save_raw_data(&data, event, &raw);
> +		perf_event_overflow(event, &data, &regs);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Find how much data to copy to aux buffer
> +	 * If hcall returned H_PARTIAL, set mem_start to
> +	 * indicate next offset of memory to read from
> +	 */
> +	num_entries =3D aux_buf->htm_mem_buf + 0x10;
> +	aux_buf->mem_start =3D be64_to_cpu(*(u64 *)(aux_buf->htm_mem_buf + 0x8)=
);

[Severity: High]
Are chunks of memory configuration data permanently lost here?

aux_buf->mem_start is unconditionally advanced before checking if to_copy
fits in space_to_end.

If the else branch is taken at the end of this function, does the next PMU
interrupt fetch data from the already-advanced offset, dropping the current
chunk?

> +
> +	to_copy =3D 32 + (be64_to_cpu(*num_entries) * 32);
> +
> +	if (to_copy <=3D space_to_end) {

[Severity: High]
Does this code allow an out-of-bounds read of aux_buf->htm_mem_buf?

Since to_copy is calculated from the hypervisor-provided num_entries, if the
hypervisor returns a large value, could to_copy exceed the PAGE_SIZE
allocation of aux_buf->htm_mem_buf when it is passed to memcpy() later?

> +		if ((to_copy + aux_buf->mem_head) >=3D ((aux_buf->nr_pages * PAGE_SIZE=
)/2)) {
> +			/*
> +			 * Crossing 50% threshold - flush and wrap.
> +			 * Write current chunk, then pad to end of buffer.
> +			 * This ensures next write starts at beginning with
> +			 * perf head also at beginning (synchronized).
> +			 */
> +			memcpy(aux_buf->base + aux_buf->mem_head, aux_buf->htm_mem_buf, to_co=
py);
> +			aux_buf->mem_head =3D 0;
> +
> +			/*
> +			 * Return space_to_end to include padding.
> +			 * Perf will advance head to end (wrapping to 0),
> +			 * matching our mem_head position.
> +			 */
> +			size =3D space_to_end;

[Severity: Medium]
Does this leak uninitialized padding to userspace?

When returning space_to_end, perf will advance the ring buffer head to the
end, but the gap of space_to_end - to_copy bytes is not zeroed out before
being committed.

> +		} else {
> +			/* Normal case - chunk fits without crossing threshold */
> +			memcpy(aux_buf->base + aux_buf->mem_head, aux_buf->htm_mem_buf, to_co=
py);

[Severity: High]
Does this memcpy() write out of bounds?

Since aux_buf->base is only initialized to the first page in htm_setup_aux(=
),
the AUX buffer pages may not be contiguous in virtual memory.

Could this write past the end of the first page?

> +			aux_buf->mem_head +=3D to_copy;
> +			size =3D to_copy;
> +		}
> +	} else {
> +		return 0;
> +	}
> +
> +	/* Return non-zero to indicate that one record is written to aux buffer=
 */
> +	return size;
> +}
[ ... ]
> @@ -202,12 +286,17 @@ static int htm_dump_sample_data(struct perf_event *=
event)

[Severity: Critical]
This is a pre-existing issue, but does the htm_hcall_wrapper() call just
above this corrupt physical memory?

Because aux_buf->base is just pages[0] from rb_alloc_aux(), the memory is
only physically contiguous for the length of that single allocation chunk.
Passing virt_to_phys(aux_buf->base) with the full
aux_buf->nr_pages * PAGE_SIZE size could cause the hypervisor to write past
the allocated chunk into adjacent physical frames.

>  		if (ret > 0) {
>  			aux_buf->head +=3D (aux_buf->nr_pages * PAGE_SIZE);
>  			perf_aux_output_end(&htm_ctx->handle, (aux_buf->nr_pages * PAGE_SIZE)=
);
> +			return ret;
>  		} else {
>  			aux_buf->collect_htm_trace =3D 0;
> -			perf_aux_output_end(&htm_ctx->handle, 0);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701083806.7935=
8-1-atrajeev@linux.ibm.com?part=3D3
