Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AF3F44C0
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652363; cv=none; b=TJ6jZsO+Ecuww+dmHYAdqTgx2SmHFXLGNtEMDrl+peQmBKOlglVIyaTss1ZxTBdTBlCDz4TCIKH78cxUAmVD2Jknf79nZZxjXQBljShlvCVYJR9dKJsYpRcfB4H/WZmd8f/FEyTuEYJxTpihAnDMAbd8rS6i0GfCzFFBE5hdtOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652363; c=relaxed/simple;
	bh=PHCPxzKcfJJRH0g0J0plZNqHlObGlb3JH2CeFzrgZKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=blpyksma0ZlW657FuQsN37PbwPVboguD02C7FYwcYHOVeJckx+wmYuUIqML/i2EWQcAls4qtoh4NmUAKZEbZclPQ+PQU/+E3sXzwNAt4Yos8EEhbtzE5izEJb4d52BOUe48e4odvlpeh+PC5nD765Uy1p+S1hw6YxziiFVpU4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1XUhQ8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1XUhQ8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2441F00A3E;
	Tue, 25 Aug 2026 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787652362;
	bh=shaGPA74+O6V4E0nGv4G+wDZOg7BByJFfA82x6Kk+W4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1XUhQ8XFgPDT0kpfxPfJPDbhEgrAjAu+kMqvWX8d5k2/pyaw7AHX1V3p7ri39l0H
	 EaZoQ9wxX27xFPeaDBqm/TAEa6m1/FbOYeXwoOlXnELFes0/5Z/G36KCQ6EIxjWkwk
	 +gXQBBvk6okLWLk2P6NeTIlbAIL3zoJnAq8nnraies6kfja8PgL4dlUH6bv8EQtmCt
	 uQBax3yaWPsOxjCEPuweR3L4OLEX1zv5rm1DkBpMF1zXgABZZbEA0gELEeytRyzAa4
	 X0U7XtsGj7dknyas+fBaTHerWnHk01D7Cql26UfTPIDTq+3SXPSrCMoPo9nhHiLNA/
	 bqTS+cY8n7K5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix raw_size of DTL samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yan" <wangyan01@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260825094733.1031566-1-wangyan01@kylinos.cn>
References: <20260825094733.1031566-1-wangyan01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:06:01 +0000
Message-Id: <20260825100601.DE2441F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check in perf_sample__fprintf_synth_vpadtl allows o=
ut-of-bounds reads and array overflows.
- [High] Integer underflow and out-of-bounds read in powerpc_vpadtl_decode_=
all leading to infinite loop and memory leak.
--

--- Patch [1]: [PATCH] perf powerpc-vpadtl: Fix raw_size of DTL samples ---
commit 757f0f4d0a4831a576dcdc38cfd2b1f9262aa2e3
Author: Wang Yan <wangyan01@kylinos.cn>
Subject: perf powerpc-vpadtl: Fix raw_size of DTL samples

This commit fixes an issue where raw_size of DTL samples was incorrectly set
to the pointer size rather than the record size. This caused consumers to
only copy the first 8 bytes of each entry instead of the full record. The
fix uses sizeof(*record) so that raw_size reflects the actual length.

> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-v=
padtl.c
> index 710f3093f3f90..af6783cfdb53d 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -196,7 +196,7 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadt=
l_entry *record,
>  	sample.cpumode =3D PERF_RECORD_MISC_KERNEL;
>  	sample.time =3D save;
>  	sample.raw_data =3D record;
> -	sample.raw_size =3D sizeof(record);
> +	sample.raw_size =3D sizeof(*record);

[Severity: High]
This is a pre-existing issue, but could this lead to out-of-bounds array
reads when processing older or malformed perf.data files?

If an older file was recorded before this patch (where raw_size is 8),
could perf_sample__fprintf_synth_vpadtl() read beyond the provided raw_data
when accessing fields like timebase?

Additionally, if the dispatch_reason or preempt_reason values from an
untrusted file are not validated, could they cause out-of-bounds reads on
the dispatch_reasons and preempt_reasons arrays?

tools/perf/builtin-script.c:perf_sample__fprintf_synth_vpadtl() {
	...
	len =3D fprintf(fp, "timebase: %" PRIu64 " dispatch_reason:%s, preempt_rea=
son:%s,\n"
			"enqueue_to_dispatch_time:%d, ready_to_enqueue_time:%d,"
			"waiting_to_ready_time:%d, processor_id: %d",
			get_unaligned_be64(&dtl->timebase),
			dispatch_reasons[dtl->dispatch_reason],
			preempt_reasons[dtl->preempt_reason],
	...
}

[Severity: High]
This is a pre-existing issue, but could a small auxtrace buffer trigger an
integer underflow and an infinite loop?

If an auxtrace buffer is provided that is smaller than 48 bytes, it appears
buf_len will be initialized to 0 here:

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_get_buffer() {
	...
	vpaq->buf_len =3D buffer->size;

	if (buffer->size % dtl_entry_size)
		vpaq->buf_len =3D buffer->size - (buffer->size % dtl_entry_size);
	...
}

Then later, if the timebase is positive, powerpc_vpadtl_decode_all() will
subtract dtl_entry_size (48) from buf_len without checking if it is 0:

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_decode_all() {
	...
	if (vpaq->buffer) {
		buf =3D vpaq->buffer->data;
		buf +=3D vpaq->pkt_len;
		vpaq->dtl =3D (struct powerpc_vpadtl_entry *)buf;
		if ((long long)be64_to_cpu(vpaq->dtl->timebase) <=3D 0) {
			...
		}
		vpaq->pkt_len +=3D dtl_entry_size;
		vpaq->buf_len -=3D dtl_entry_size;
	...
}

Could this underflow buf_len, bypass the buffer reload logic, and result in
an infinite loop that sequentially reads out-of-bounds heap memory?

>  	event.sample.header.type =3D PERF_RECORD_SAMPLE;
>  	event.sample.header.misc =3D sample.cpumode;
>  	event.sample.header.size =3D sizeof(struct perf_event_header);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825094733.1031=
566-1-wangyan01@kylinos.cn?part=3D1
