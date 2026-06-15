Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5436EA8E
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560475; cv=none; b=W4S6pPlbOD2KnZ8INPCNxmdkfclkUxAXNJI2TRmAQnAExfLEkCgUac7F++X1w/JuitWM2V1y2WpRl83zL8GXwOAl9kBOpolXMqtk7h2adR201TX5VO/0hW7FawaS5WP2XQ3/r1vSTo7KMHOMMO5O9J0GdFmFwAkaCBP3NYV+5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560475; c=relaxed/simple;
	bh=EPJ5vEprjFOV9j9lRl7uB1N6iwlw8gxCIuSG1PUtPvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AWGQOFRnhehT4QkalyKaqa0RiYXQdV0ssGwZJIrq4+JLpAV3EnTPJdiJMiBH4r9Jocrcj399996EaWC4Wollb/EfuTNl5tMj1VWpX5ISe85OgnDF1je8nvXNIwOF220J6fcVFUucp1wHtFwYTIF8GOj2wP+iokI6t0IG70G/ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiw42br5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiw42br5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028051F000E9;
	Mon, 15 Jun 2026 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560474;
	bh=LeaNNxXgu6/8mFD7cNW+ttMsPYGAFYWa4XePXJdLj24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eiw42br5B08IXE4S0vQV/qSxe4/0VJkjpC6GTD9RSgMLSUpANp/0z8ZYcssMd3zVG
	 Tx1zA3rTqoFTZVap0Iw3dGrmlaUCnrgOWFRn9ecA4wJ1r+Wwqb8DFDMObTGKy9OcN9
	 4rgf3MIdu9RFvZcpyP3QCd2aKAnHbnYVb3CH4hUf/wC6NaCZ+Dx1azSRVFZBhLfMHj
	 sM85jyNXWm4lGx16xqHmwDjcmOojth+YZB3+/NZ5i4o9R4Jw0Ok0ZRFfWcrhRfWGcG
	 OYoxLnIoFBhECavEY2q1zxTzNNk5kcNTKvAyqv9xmQ2BxvZQ7QPpzuj/QWmX6lgY1c
	 lmJgDqAHUvZfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf cs-etm: Bounds-check CPU in
 cs_etm__get_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615213657.35776-6-acme@kernel.org>
References: <20260615213657.35776-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 21:54:33 +0000
Message-Id: <20260615215434.028051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL pointer checks for dynamically expanded queue `.priv`=
 fields allows malicious perf.data to crash the perf tool.
- [High] Integer overflow in `idx` validation bypasses queue array growth, =
leading to a massive out-of-bounds heap write.
- [Medium] Error path in `cs_etm__process_auxtrace_info_full()` leaks dynam=
ically allocated `cs_etm_queue` contexts.
- [Medium] `auxtrace_queues__grow()` permanently leaks the old `queue_array=
` memory when expanding the queue.
--

commit a1dea01e7aeb4b8a5c1245018dd3bd55a6dc9d91
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Bounds-check CPU in cs_etm__get_queue()

cs_etm__get_queue() indexes etm->queues.queue_array[cpu] without
validating that cpu is within nr_queues. This patch adds bounds checking
and NULL checks to prevent out-of-bounds reads when processing untrusted
perf.data files.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
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

[Severity: High]
This isn't a bug introduced by this patch, but since we are adding NULL=20
checks for dynamically expanded queue .priv fields here, do we also need=20
them in other functions?

auxtrace_queues__add_event() dynamically expands the queue_array if an=20
untrusted perf.data file provides a large idx.

The newly allocated queues are zero-initialized, leaving their .priv pointe=
rs=20
NULL.

A subsequent iteration in cs_etm__create_decoders() checks if the new=20
queue is empty. Since a buffer was appended, it is not empty, and the code=
=20
dereferences etmq->format unconditionally.

Additionally, if dump_trace is active, cs_etm__process_auxtrace_event()=20
and cs_etm__dump_event() unconditionally dereference the NULL priv pointer.

Does this allow an untrusted file to cause memory corruption or a crash?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the integer overflow in idx=20
validation bypass queue array growth, leading to an out-of-bounds heap writ=
e?

If untrusted perf.data input provides idx =3D 0xFFFFFFFF, the condition=20
idx >=3D queues->nr_queues is met, but auxtrace_queues__grow(queues, idx + =
1)
wraps idx + 1 to 0.

tools/perf/util/auxtrace.c:auxtrace_queues__grow() {
    ...
    if (nr_queues < queues->nr_queues || nr_queues < new_nr_queues)
        return -EINVAL;
    ...
}

Because new_nr_queues is 0, the validation passes and the function falsely
indicates success.

Then auxtrace_queues__queue_buffer() accesses:

    queue =3D &queues->queue_array[0xFFFFFFFF]

and modifies memory via queue->set =3D true and=20
list_add_tail(&buffer->list, &queue->head).

Could this cause a massive out-of-bounds heap write?

[Severity: Medium]
This is a pre-existing issue, but does the error path in=20
cs_etm__process_auxtrace_info_full() leak dynamically allocated=20
cs_etm_queue contexts?

If a subsequent operation fails, the code jumps to the err_free_queues labe=
l:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
err_free_queues:
    auxtrace_queues__free(&etm->queues);
    ...
}

auxtrace_queues__free() clears the array without releasing the nested priv=
=20
pointers:

tools/perf/util/auxtrace.c:auxtrace_queues__free() {
    ...
    zfree(&queues->queue_array);
    queues->nr_queues =3D 0;
    ...
}

Does this leak num_cpu * sizeof(struct cs_etm_queue) bytes on the error pat=
h?

[Severity: Medium]
This isn't a bug introduced by this patch, but does auxtrace_queues__grow()=
=20
permanently leak the old queue_array memory when expanding the queue?

tools/perf/util/auxtrace.c:auxtrace_queues__grow() {
    ...
    queues->queue_array =3D queue_array;
    return 0;
    ...
}

The old queues->queue_array pointer is overwritten with the new one without=
=20
ever being freed via free() or zfree().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615213657.3577=
6-1-acme@kernel.org?part=3D5
