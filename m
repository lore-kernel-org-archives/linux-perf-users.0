Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572E36BCED
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011836; cv=pass; b=X/5iE5RSspl8uQF99/gJgVTaAnDoyflf55JwqTBxH0uw2j1EOaSxj0sO8C44CRIbT83NgAwgUuliudYF7DP/tZyp+1Y70jFQf8dzyRnehkJ0J/Rr0OJRb0X9qg0drNxc2oUTxsPHxA3CMvMePlc45ZojcTn0egSTnLja5B29cmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011836; c=relaxed/simple;
	bh=+N4TyOpk6OjtO3aVhfd+KaWfqvmnkMh9n+1ySaFToUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uuq9ThMKiQJudS7y2gCtF8q3l+g6xCkfc0/0IJ8fmh7KkYg379+t1uo35QPLnqkmd42jcyC9Ixwu2y41oSHogiJuonKOnQnPT+79LQd743HbgMwDe6S0LtbKPY/GnISg13B01cjxEBIMqbJ4vSDkBuLMDy8+cZBeLFiXG6iSd0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPd3/bnX; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPd3/bnX"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so691911cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 14:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792011834; cv=none;
        d=google.com; s=arc-20260327;
        b=RyM2hE/e9aFVXfR02qClOuyLJ0fUc++oKFRSgg8Pe0Tqv7v9AXKMoGcdXcHAZ5Njlk
         9skpFKJTIUqFF8nwp+E79I59m/jl1+6JV4XtpnP3N86PoC4qRXg/B9OCozC9bDqPpt9/
         +U01xR1en6j+Kq+7735bkAOPsSYqOKMmN58o45Z/IxoZahqq8y0cpn60RgIiwFCZUWOj
         NNbOH9I5gxuAdJ6EoUE/I+NYbCk5BXjZ7UMQFj+ilAavOgNYtYfG/Dlk0J9sU67sV1ZD
         65p/dM5GZHAJsgq8kF0dmFKPe1lqiliszVlqVfwohaFl7Qnm1aR+2V4KU6LZA8SJKeet
         Rmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mxyz86H6TMMGtX9yyjeKonm2O61SvjPIdjz2IY2AyDw=;
        fh=S5VrdHzgQ4ggvMJS9aocnb+urLNTifb7YzAVFzpMRto=;
        b=cbvExQOTtHBIjYthaRTE5hyfoGlAhn55hClv/wf67dAZRYOBvSgW8+HsFkAA26BB5I
         yvKyis2+zegobNZ8hfxmQirvBWpHMh5p5o6qJVNomjD957JSjYdfb9KnAG71CUzSoTdq
         UXjhdezs0Rq/h1SwtAUo55gaAQeYs8ZjK99FFuxCshL//5tNOaxSJ4oFdfrZVFEcwD+7
         7HJ8hts+HFaJ3eYcLlULWDL0QazqkTbooKJ7948I/HpvShK7hl1M2PO3SxrPcYppSFjH
         cZ2XRZrZeTwCHjIuhC3tkKOGSmKfIAwxsABiQvvqbV9hyQEV95mpLf/0YKQIxWQilmPT
         HFVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792011834; x=1792616634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mxyz86H6TMMGtX9yyjeKonm2O61SvjPIdjz2IY2AyDw=;
        b=PPd3/bnXF2yiKN00l47JVM1UumEWV4siuVPQFALlITnJZvgcSTYFgtJf0V9rkgAv3d
         O7mzumP/XgDSynuSrh8wJRB2mEjMhrG+dq+BR9uEPq281j7qlpgUc3YYOBtSqyQ8VlvE
         9ecICbNnS2DH1BGkH48j9L5g9O+37aYKppvIxa0jPkxMYGLH6IX28e+K85EF4Un5hPO3
         6ROeaed0F7Db3EFczkxdQlz6LdDDeOuLkCRgfgG61mK2vVDiNXGvLZfvHJdiHY1HCvwu
         6IaolXVst7RgPTvJDz53sW2CJbF5VB1AesGMGlnZnrv+o1vQ/66RibQoVz3omoP57OYf
         oHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792011834; x=1792616634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mxyz86H6TMMGtX9yyjeKonm2O61SvjPIdjz2IY2AyDw=;
        b=G5qCOdyR/in/kuEnTntLKTGwDfFortAerI0U/K4Ly4Vn5XPOS7yGBV1XciS4/vbtK9
         lpMRyzHfSgVdg5RLA0n//rIdhtavrQ3ANZhe/yNJit0TdIwfsjeH/TPmBEvFYULV867s
         fuknjAGn5goaJJbZaQjY/bVwsXxnZCaU0rzqq+HisMSkdNYfocsGBjPNQ29569bQotnO
         4yU4GX7FJdRsUAONdnSNhSFH9b4pbzvMfLNPVh7Dk3vlFs5cbKRJ+ECZvuzdGcM9cmV/
         I5jdSXYDsZNH7ne6gT5kxHMJ8biE6namNwwvjLOvkugUWPOFa5y8zAwebkrzGLU8iihX
         0kwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYDKfK9nmo6viz5UrjxRt1apwp/3C515QZ+M9QQRYIl0qSwuha4AsXDR/djIggDRGye7PaDFzujgxIHwNHObvD@vger.kernel.org
X-Gm-Message-State: AFq9FYL6rZyiMXI77OKByxBk2uE69E66cTIgQ83dZRvWZyfZ5JJfM3R6
	FStOEnvIjC5yqIEnIsBwq72k4nionY+CoW38nMn8A2+SsUuTu6KZnfv415E/rVY/2YOBQxT/D/W
	C0xYh4lhJ+JVZ2oEVwsEk+o46KvzHiX6MeGCqI6MP
X-Gm-Gg: AYBFou3T4K7aYzSmLQ2g3Uyn73ZGXrVmJvKc5zI3RbuCwPUKNlzrBvLhIzs+PRGeeXY
	5fiayLWRk8zLznMf5Y+8ZmiDIoJqALyihw03zeEuZ0C4KA/JHGFBiqwESNx6BS9EOzCLScwQ5RN
	X3jWjEnr88u8SvSBcvb52EMgAh9OrneuXkVRHqSe0eUhDTGFwpAp7OoyuG5d0hjKN7W0++xx0Jc
	Zp/SywHS1dyvAypcXwAoIFffQk3PbU8F0XoH6EeI0egrl+DJBiUblWvf4lZKoGXmWwzCHNdNlxT
	OjF5V4NAzY+dzDFdF0I1ApvEVpG34afrSkuZxbe12FDjB7zM6RWI6tRv6vxb1rhnonH08FuBvoN
	JU0R+pLUPYQ==
X-Received: by 2002:a05:622a:4019:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-536161386camr525391cf.0.1792011833044; Wed, 14 Oct 2026
 14:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014151326.4142140-1-thepacketgeek@gmail.com>
In-Reply-To: <20261014151326.4142140-1-thepacketgeek@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 14:03:40 -0700
X-Gm-Features: AclHuK9gTJfGJVM2K8qZN8FxeTus_TXC4iuYsvQ-4FcRysqXiGbnxGrJtCFgToY
Message-ID: <CAP-5=fXtuEX9zJ0U-a62REgfAXG2z05XCi1f6HB4hhUEfT969w@mail.gmail.com>
Subject: Re: [PATCH v1] perf machine: Don't unwind the arm64 leaf frame caller
 without symbols
To: Matthew Wood <thepacketgeek@gmail.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:13=E2=80=AFAM Matthew Wood <thepacketgeek@gmail.c=
om> wrote:
>
> On arm64, 'perf record --call-graph fp' also samples LR so that
> thread__resolve_callchain_sample() can recover the leaf function's
> caller, which is missing from the frame pointer chain. It does so via
> get_leaf_frame_caller_aarch64(), which runs a DWARF unwind. The
> unwinder looks up the symbol of every frame it visits, so the first
> lookup in a DSO loads its full symbol table and demangles every symbol
> in it.
>
> Commit 02b2705017d2 ("perf callchain: Allow symbols to be optional when
> resolving a callchain") added the symbols argument so that callers which
> only need maps can avoid loading symbols, and passed it down to every
> add_callchain_ip() call. The leaf frame unwind was missed and still runs
> for symbols=3Dfalse, so 'perf inject' on arm64 has been loading symbols i=
t
> doesn't need ever since.
>
> Commit 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> compounded the issue: process_buildids() now walks the callchain of
> every sample at the end of 'perf record' to mark DSOs hit. With -a, that
> loads and demangles the symbol tables of every user binary sampled on
> the system. This can send things into exponential time and memory
> (over 1GB of heap growth in 5 seconds), so
>
>   perf record -a -e cycles:u --call-graph fp -- sleep 2
>
> never finishes writing perf.data after the workload exits.
>
> Callers that pass symbols=3Dfalse only want the maps that callchain IPs
> fall in, and add_callchain_ip() already honours that by using
> thread__find_map() instead of thread__find_symbol(). Skip the leaf
> frame unwind for them as well. The leaf frame caller is almost always
> in the same DSO as the sampled IP or the next frame in the chain, so
> build-id marking loses nothing in practice.
>
> Fixes: 02b2705017d2 ("perf callchain: Allow symbols to be optional when r=
esolving a callchain")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  tools/perf/util/machine.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f86b3b7df742..51597cddd239 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2989,7 +2989,13 @@ static int thread__resolve_callchain_sample(struct=
 thread *thread,
>
>                 usr_idx =3D callchain_param.order =3D=3D ORDER_CALLEE ? j=
-2 : j-1;
>
> -               if (usr_idx >=3D 0 && chain->ips[usr_idx] =3D=3D PERF_CON=
TEXT_USER) {
> +               /*
> +                * Finding the leaf frame caller needs a DWARF unwind, an=
d the
> +                * unwinder looks up the symbol of every frame it visits.=
 Skip
> +                * it when the caller asked for maps only, as for build-i=
d
> +                * marking, so that no symbol tables are loaded.
> +                */
> +               if (symbols && usr_idx >=3D 0 && chain->ips[usr_idx] =3D=
=3D PERF_CONTEXT_USER) {

Hi Matthew, I'm not sure if this is a serious patch or a bug report
about the slowness of DSO marking. Broadly DSO marking is known to be
slow and many perf tests run with -B and -N for this reason. I believe
the intent behind DSO marking as a default is to ensure that perf
provides the best profiling experience. This comes at a cost, but this
fix looks like it will break things because IPs will be lost.

Trying to look a little more at the ARM64 performance problem, I see
that we're trying to unwind 2 frames:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/arm64-frame-pointer-unwind-support.c?h=3Dperf-tools-=
next#n70
but often just 1 is read. For libunwind the 1 frame case has a special case=
:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/unwind-libunwind.c?h=3Dperf-tools-next#n671
I wonder if we could replicate the 1 frame case with libdw to avoid
processing the DSO, and update the caller to be:
```
ret =3D unwind__get_entries(add_entry, &entries, thread, sample,
callchain_param.order =3D=3D ORDER_CALLER ? 1 : 2, true);
```

Thanks,
Ian

>
>                         leaf_frame_caller =3D get_leaf_frame_caller(sampl=
e, thread, usr_idx);
>
> --
> 2.53.0-Meta
