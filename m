Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E89314D37
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639242; cv=none; b=f44vgYJaKayjw7f+9E9BNZza66DqFHiH7aYSTWu+kZOXNt9PfLDpz8kA6ojUjO0af0t58+DM8WFavb5t8DeRCLaJVdBX7FXOoVdkOGKzqpzD/vQs7jAGNObAh/3UKJ2QJ14ow+MOpgokxobRfOMIEX/ceqpwz5atJ6iqRiIfg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639242; c=relaxed/simple;
	bh=WfwhCk3B4K0Vf96+5wlRxUBbIHNKAJ5CqK58cCGN1yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DMl2gZFDO9FYpepIDHZOFZpko7CFidep0T9YUySKrhLuIWBM22IzJlmiY7192zWRgLg6fwzXYF/rcli8F/9QfnrEbrHAb7RPBCfDaow8EgUQ7AD0STYisqt4zvStWSgwmhV864IVBDEwX57eksUtI1VT6BHS0OvrX67C5UmzauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqR58022; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqR58022"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5281F000E9;
	Tue, 16 Jun 2026 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639241;
	bh=cd38XD5U9pNl5UGLvCyzuUKn0JhWt4dNDxOYL01Bn+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqR58022q42UmBdzz1QUAWoTWCeGzOMmTrUwxaeDC856de6T2gtktMSf9dMkkkElW
	 CnY8lGhuk9QrNExg0/kdzR4poteY2bOuaV+xyIUGd0hxA+cSxK+nD+yJGCjeLuyzdE
	 frXr1fISoanW122hCy0MXJ2yJMBXi1J6swr5zjU2KAhCX1hq+U8UDD190K494PPRvm
	 TBOGvFJybUbcK6vpUFtGnLKTiT2XCEcdvGFPcKac6Ji0gb0+ojAsldmBHE5S8p7QxF
	 wb9nbQU/OkCrjyylvOko5nVwAPpSP4qI4k6AI9y4BLJ95Nqsc7GFm1+jNiGI9pqq9k
	 umHOfvfNSV2PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf cs-etm: Bounds-check CPU in
 cs_etm__get_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-6-acme@kernel.org>
References: <20260616193033.10035-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:47:20 +0000
Message-Id: <20260616194721.2D5281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes NULL pointer dereferences for dynamically grown qu=
eues in ID mapping functions, but misses identical vulnerabilities in `cs_e=
tm__create_decoders()` and `cs_etm__dump_event()` callers.
- [High] The old `queue_array` is unconditionally leaked when dynamically r=
esizing in `auxtrace_queues__grow()`.
--

commit 6d207e2a691cccf4b079e5ecdc5b0aa1cd4cc3b0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Bounds-check CPU in cs_etm__get_queue()

This commit adds bounds checking for the CPU value against nr_queues in
cs_etm__get_queue(). It also introduces NULL checks for the queue's private
data across several functions to safely handle untrusted perf.data events.

>     perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
>    =20
>     cs_etm__get_queue() indexes etm->queues.queue_array[cpu] without
>     validating that cpu is within nr_queues.  When processing
>     AUX_OUTPUT_HW_ID events, the cpu value comes from untrusted perf.data
>     trace payload and flows through cs_etm__process_trace_id_v0_1() and
>     cs_etm__queue_aux_fragment() without bounds checking, allowing an
>     out-of-bounds read with a crafted file.
>    =20
>     Add a bounds check in cs_etm__get_queue() and NULL checks in all
>     callers.
>    =20
>     Also add NULL checks for queue_array[i].priv in the queue iteration
>     loops in cs_etm__map_trace_id_v0() and cs_etm__process_trace_id_v0_1()
>     =E2=80=94 after auxtrace_queues__grow() new entries are zero-initiali=
zed so
>     .priv can be NULL.  Add a get_cpu_data() NULL check in
>     cs_etm__process_trace_id_v0_1(), matching the existing check in
>     cs_etm__process_trace_id_v0().

[Severity: High]
This isn't a bug introduced by this patch, but while handling the
zero-initialized entries from auxtrace_queues__grow(), does
auxtrace_queues__grow() itself have a memory leak?

When it reallocates the queue array, the old queues->queue_array pointer
seems to be overwritten without being freed:

tools/perf/util/auxtrace.c:auxtrace_queues__grow() {
    ...
    queues->nr_queues =3D nr_queues;
    queues->queue_array =3D queue_array;

    return 0;
}

Could a crafted perf.data file providing events with successively increasing
indices trigger repeated reallocations and leak the old arrays each time?

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
>  		ret =3D cs_etm__insert_trace_id_node(etmq, trace_chan_id,
>  						   cpu_metadata);

[Severity: High]
This is a pre-existing issue, but since we are adding NULL checks for etmq
here, are similar checks missing in other functions that iterate over the
queues or process them?

In cs_etm__create_decoders():

tools/perf/util/cs-etm.c:cs_etm__create_decoders() {
    ...
    assert(empty || etmq->format !=3D UNSET);
    if (empty)
        continue;

    ret =3D cs_etm__create_queue_decoders(etmq);
    ...
}

If auxtrace_queues__add_event() adds buffers to a newly grown queue, empty
would be false, but etmq could still be NULL. Could this lead to a NULL
pointer dereference on etmq->format?

Similarly, in dump_queued_data() and cs_etm__process_auxtrace_event(), the
uninitialized priv pointer is passed directly to cs_etm__dump_event() when
iterating over nr_queues:

tools/perf/util/cs-etm.c:dump_queued_data() {
    ...
    for (i =3D 0; i < etm->queues.nr_queues; ++i)
        list_for_each_entry(buf, &etm->queues.queue_array[i].head, list)
            if (buf->reference =3D=3D event->reference)
                cs_etm__dump_event(etm->queues.queue_array[i].priv, buf);
}

Inside cs_etm__dump_event(), etmq->decoder is unconditionally dereferenced:

tools/perf/util/cs-etm.c:cs_etm__dump_event() {
    ...
    color_fprintf(stdout, color,
                 ". ... CoreSight %s Trace data: size %#zx bytes\n",
                 cs_etm_decoder__get_name(etmq->decoder), buffer->size);
    ...
}

Could this cause a crash if dump_trace is active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D5
