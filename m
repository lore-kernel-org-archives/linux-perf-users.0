Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5B31E84B
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578128; cv=none; b=kqUkVcCkm8m4wuHcmxAhdHUaYLqLnf4YdMZ0DR3MwRtFvGAY0wKMkoDBCEPYr93rMpg+OuNF2i00bJvZ5sk0n9d2gUtMyFNfJib1CFWD11NZsuWiB9FvMASYvbdhSt1P6n+guWPf7ovc/sO/gRq7mRJSKAg+2zp1z0t8ZxOaeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578128; c=relaxed/simple;
	bh=SCyC7JBHGeeK71nv1tiqvRS5ZySgYVu841LpJlR3uoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSFehZAOG8cBNdXJ0WsY82hvOchi9fyG7z5hZoKHrAuxw9jAqQXLbx6F2lueCtvS8RZDhEtpwFSyiWNKIQck0Gnsda2FbCaxwCiaWpdgj8fJJTieoHfH6XI719MvN50O0MNrSXe3kS4ZhLJqw8+zSm0FsZA4UlH4jwkVC+48oPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojIDdk+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojIDdk+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E51F000E9;
	Tue, 16 Jun 2026 02:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578127;
	bh=RSy2T9DHjtlZeMvey3/jAg1nCt0JEJ8x2KPJFTIY7Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojIDdk+4fG7i2lNiGi5QENahMOLYVJCnEq0z5WhfQctGhMUaKKhMWCIcBht8YVUut
	 /hLiJxcmfDcBGuTxxVkqlB2UXnL2doZ2c1Zmq+a9YaapeMCwIfSqFs4BtgvP/1ACYC
	 KamhxRFWfs2pm67OinyxfyunA/i2oAyQtA6wMfmlWki7uZHm0lWvgg99n6CqDg0G93
	 HacJdM3DcvXCYHp3pb8+kDW88uY5cnqs9YWuxCIWfXv6IiHxYedEYMRISeSjq+jSzg
	 blkjXTHXP9XKX8kCkFA136DOsQgzht4WDTYrh92+ZRWdFdXUaO1aPSBOzh2Hkgb1wb
	 FPVuEbjiC8XMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf cs-etm: Bounds-check CPU in
 cs_etm__get_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-6-acme@kernel.org>
References: <20260616022715.5739-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:48:46 +0000
Message-Id: <20260616024846.E97E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in auxtrace_queues__queue_buffer() leads to out-o=
f-bounds memory access.
- [Medium] Null pointer dereference in cs_etm__dump_event() when processing=
 a crafted perf.data file.
- [Medium] Out-of-bounds read in cs_etm__create_meta_blk() when parsing CPU=
 metadata blocks.
--

commit 6ff616c3e2c2577ec55eda8099842f63dcc43ed7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Bounds-check CPU in cs_etm__get_queue()

cs_etm__get_queue() indexes etm->queues.queue_array[cpu] without
validating that cpu is within nr_queues.  When processing
AUX_OUTPUT_HW_ID events, the cpu value comes from untrusted perf.data
trace payload and flows through cs_etm__process_trace_id_v0_1() and
cs_etm__queue_aux_fragment() without bounds checking, allowing an
out-of-bounds read with a crafted file.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d121c8f22028d..5d0664ff73b79 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -318,6 +324,9 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxt=
race *etm, u8 trace_chan_id
>  		int ret;
> =20
>  		etmq =3D etm->queues.queue_array[i].priv;
> +		if (!etmq)
> +			continue;
> +

[Severity: Medium]
This is a pre-existing issue, but since we are adding NULL checks for
zero-initialized queues here, could this also cause a null pointer
dereference in cs_etm__dump_event()?

If dump_trace is enabled, cs_etm__process_auxtrace_event() and
dump_queued_data() can pass the new queue's priv pointer directly:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_event() {
    ...
    cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
    ...
}

And cs_etm__dump_event() unconditionally dereferences it:

tools/perf/util/cs-etm.c:cs_etm__dump_event() {
    ...
    cs_etm_decoder__get_name(etmq->decoder)
    ...
}

Should cs_etm__dump_event() also have a NULL check for etmq?

[ ... ]
> @@ -3144,6 +3162,9 @@ static int cs_etm__queue_aux_fragment(struct perf_s=
ession *session, off_t file_o
>  	    aux_offset + aux_size <=3D auxtrace_event->offset + auxtrace_event-=
>size) {
>  		struct cs_etm_queue *etmq =3D cs_etm__get_queue(etm, auxtrace_event->c=
pu);
> =20
> +		if (!etmq)
> +			return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but I noticed a potential integer overflow in
auxtrace_queues__queue_buffer() that could lead to out-of-bounds memory acc=
ess.

When processing an untrusted perf.data file, if the idx field of a
PERF_RECORD_AUXTRACE event is UINT_MAX, does the idx + 1 calculation
overflow to 0?

tools/perf/util/auxtrace.c:auxtrace_queues__queue_buffer() {
    ...
	if (idx >=3D queues->nr_queues) {
		err =3D auxtrace_queues__grow(queues, idx + 1);
		if (err)
			return err;
	}

	queue =3D &queues->queue_array[idx];
    ...
}

Since auxtrace_queues__grow() evaluates nr_queues < new_nr_queues as false
when new_nr_queues is 0, it returns without growing the array. Does this
cause the subsequent array access at queues->queue_array[UINT_MAX] to
write out of bounds?

[Severity: Medium]
This is a pre-existing issue, but there appears to be a potential out-of-bo=
unds
read in cs_etm__create_meta_blk() when parsing CPU metadata blocks.

When parsing a PERF_RECORD_AUXTRACE_INFO event, does
cs_etm__process_auxtrace_info_full() validate that the payload contains
enough bytes before calling cs_etm__create_meta_blk()?

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
		metadata[j] =3D
			cs_etm__create_meta_blk(ptr, &i,
						CS_ETMV4_PRIV_MAX,
						CS_ETMV4_NR_TRC_PARAMS_V0);
    ...
}

A crafted file with a large num_cpu and small auxtrace_info.header.size
might bypass the num_cpu > priv_size / 8 check. cs_etm__create_meta_blk()
then unconditionally reads up to CS_ETMV4_NR_TRC_PARAMS_V0 elements:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk() {
    ...
    metadata[k + 1] =3D buff_in[i + k];
    ...
}

Since the length validation (i * 8 !=3D priv_size) only happens after the
loop finishes, can this cause a heap buffer over-read of buff_in?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D5
