Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797145348A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625511; cv=none; b=Pwl3OG3dl8enGee9AqZfRqxhQA9h2JTQBrw3cv6y5ImNIFISowIevipsNX2WOf2uH2bu8SFXDfEYlI1ol0QoLPcRCIOIfSZn0NZoZUUmKML7t1wPcbt1BDsdA/g9uSEtIRsfS39+xN6h94EQMmqlSMyb2QcJeTlQ0hMnLkKXbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625511; c=relaxed/simple;
	bh=vEGUqBfhE3sTut2vSAMqJ5MiEKGYNScOQD6G/9V7Bs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5BQiw/jHFUdIZ0Ok4ME4HCKWeRH+mGx8OKSKiTny9s3aqK9T5//z1FAsIdyOJlCjqQGC6lAXODl6LqUeuKORqrQ4bUdq9b+avk5JydkBB4lvLiq7Ot7O6E33/mW46Lj1hD/qU3pZOqZLlvRuVyV1r5RlfSJFXSSUiw/DOOkq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjZj98Fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjZj98Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257071F000E9;
	Tue, 16 Jun 2026 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625510;
	bh=c/lDA8XccfsthKK9a9eSM7K6JHyz/kgYBiKS8sbitac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjZj98FlCwRtAIubl+CjU8rRXqWdDNQO8kGr7muYKsO4v9XvjUZ0qEmfcTyeFBjCO
	 xkCdzIKRoegoZ8dGX8h6lx2bvctMJ5tyYInAYvzxsbATwoB065J4E1DW8m1DjjutQR
	 L6eVfBuQwDEqn82URocaxQnYe47R8DtR69k2z36xezRgKLS4QNOoscUByi9bcQ0i2Y
	 89BSkHbBX5SnoGSiswPCmavBjZqizcGswd9EVQQ4914jSf7wEt8R1ZrLKTeMOM5HmT
	 4sd7M1bAmXL+gh4abEct2h0RrP6U3Czj+AfSlLVR4Hurk2EPtPLWuOScJkCYC6+q9m
	 W9sRbDFZVsNew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf cs-etm: Bounds-check CPU in
 cs_etm__get_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616153920.6852-6-acme@kernel.org>
References: <20260616153920.6852-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:58:29 +0000
Message-Id: <20260616155830.257071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] A maliciously crafted perf.data file can trigger a NULL pointer =
dereference in cs_etm__dump_event() during `perf script -D` or `perf report=
 -D`.
--

commit a18d25957a3039eeaa7db185b7ad88150efe2056
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Bounds-check CPU in cs_etm__get_queue()

This commit adds bounds checking for CPU indexes in cs_etm__get_queue()
to prevent out-of-bounds reads from untrusted perf.data payloads. It also
adds NULL checks for queue array elements which can be zero-initialized
after array growth.

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
This is a pre-existing issue, but since we are handling cases where
queue_array[i].priv can be NULL after auxtrace_queues__grow(), could
this same condition cause a NULL pointer dereference elsewhere?

In tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_event(), the untrusted
idx from the payload can trigger array growth, passing NULL directly:

    cs_etm__dump_event(etm->queues.queue_array[idx].priv, buffer);

A similar queue iteration happens in dump_queued_data():

    cs_etm__dump_event(etm->queues.queue_array[i].priv, buf);

Since cs_etm__dump_event() accesses etmq->decoder without verifying if
etmq is NULL:

    cs_etm_decoder__get_name(etmq->decoder)

Could this cause a crash when processing a crafted perf.data file with
the dump trace option like perf script -D or perf report -D?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153920.6852=
-1-acme@kernel.org?part=3D5
