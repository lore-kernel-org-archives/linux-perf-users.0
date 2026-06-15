Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC33A7F7C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564081; cv=none; b=oc1fLHsEYedtaxhaeB1u9/FUtBYogtFQ8gKQnYdoIzxDrZKQrkjaZfxpDJ6Q9enbNQ5Ce/FKtG3cdlGHuv5HPjbXxbZIygf89ucl5cI4kKS2YFcMOHzYG8/ATQoE3vpDpV4/P5ealqAPLq4O/q8Jl/NBCx7+xF846I0+u2eav0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564081; c=relaxed/simple;
	bh=l4V4cOmvC0/q5w5nAoUbH0w+zPJfBpBTvBlqdK+bLFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HBvJY6Rhy9F9obbIlteBUmxwqD6u++xWyUIqHpm5386SGNHwj1HqzAaqy4w4J37YPxHFaX8a+YvZEHOhowBanvcL3dVeI7oSp4/IxgpiS5T0aE0JMlxxXLg7p8KeGI94FeaQ/7TByTXG0r9UDKil2OCOAFEZg9NWCTBEwdn33CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNWTNXJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNWTNXJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5CE1F000E9;
	Mon, 15 Jun 2026 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564080;
	bh=0c7qPz43QQ3hijr5uajmvuqtZzKAls6fZnejsLg6ehs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNWTNXJU1Wa8Bo5u+bq9/i2ng1fonvMhAo9/5IVnNuWGaJBQkDtsJxwLqv+SICVi8
	 nDsqdyZywVGMlPgbTajNo+9tpVVR5DjlS9gSo0p2AWa4+59dUm5Ep87eyrHhy1XXL5
	 ZEngZ1wo+Fn6Px7UhIcs3EcQF65rfTJRenSkvOOoI3CmJSmplwRbCZCwfc6MTbnjo9
	 D4jsWVTAjrvteSYcQ8WI3V4PmN1WZxvCgKgrlSwdLx97rJ6JIHwKpg7XDFJV7FT7m+
	 ozr8cT359p7xlod4O7stOAHqWfAIQBkMmwgoIgGHpXt4ymmxYXGo2R7xLDiQwyrbL9
	 o18crGQxEG+lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf cs-etm: Bounds-check CPU in
 cs_etm__get_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223249.36598-6-acme@kernel.org>
References: <20260615223249.36598-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:54:39 +0000
Message-Id: <20260615225439.EF5CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL checks on `etmq` and `etmq->decoder` lead to segmenta=
tion faults on malformed or out-of-bounds auxtrace queues.
--

commit 97b84b25fe94e957ad4cb91dac4d3e8d49fe5b1d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Bounds-check CPU in cs_etm__get_queue()

cs_etm__get_queue() indexes etm->queues.queue_array[cpu] without
validating that cpu is within nr_queues. When processing
AUX_OUTPUT_HW_ID events, the cpu value comes from untrusted perf.data
trace payload and flows through cs_etm__process_trace_id_v0_1() and
cs_etm__queue_aux_fragment() without bounds checking, allowing an
out-of-bounds read with a crafted file. Add a bounds check in
cs_etm__get_queue() and NULL checks in all callers.

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

[Severity: High]
This is a pre-existing issue, but since we are adding NULL checks for the p=
riv
field here because auxtrace_queues__grow() zero-initializes new entries, are
there other places that might still be vulnerable to this?

For example, in cs_etm__process_auxtrace_event(), we index into the queue a=
rray
and pass the priv field directly to cs_etm__dump_event():

	err =3D auxtrace_queues__add_event(&etm->queues, session,
					 event, data_offset, &buffer);
	if (err)
		return err;

	if (dump_trace)
		if (auxtrace_buffer__get_data(buffer, fd)) {
			cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);
			auxtrace_buffer__put_data(buffer);
		}

Then cs_etm__dump_event() unconditionally dereferences etmq->decoder, which
causes a segmentation fault if etmq is NULL:

static void cs_etm__dump_event(struct cs_etm_queue *etmq,
			       struct auxtrace_buffer *buffer)
{
	...
	color_fprintf(stdout, color,
		     ". ... CoreSight %s Trace data: size %#zx bytes\n",
		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);

Additionally, if the queue is empty during decoder creation, etmq->decoder =
can
be NULL. Later in cs_etm__decode_data_block(), etmq->decoder is passed with=
out
a NULL check:

	ret =3D cs_etm_decoder__process_data_block(etmq->decoder,
						 etmq->offset,

Could this be triggered by a malformed or out-of-bounds auxtrace index,
resulting in a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223249.3659=
8-1-acme@kernel.org?part=3D5
