Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F92C3768
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841981; cv=pass; b=gwGomABipSf3ucYDWASmRbBV/kt92x4dcI4RkmfqPKPwLBkK+XhFdLawGLb7sKusgKXobvTALjza0PiPoMcNTLRbJHU4xvA2bZELNlCAOepXw09q387nz7GB7ZvrXuY4yTuGjSyQtWw0Q4oyhO2AxXRnuF78GKFri3WPZBktfW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841981; c=relaxed/simple;
	bh=+m4ZBdotMUSKmqKLmogc7IfuZS7nj6qS7eFUrB6XmnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdSmTMqLvSLnZ6o1FAME2CXLyRjHbNiTpZS9Af5x/fFp8UYh/kx0OYyvm5Pe6xwGs6+rA3JpAK9Q5iZO2n9M6Yyn3+61WHS3VZdaCoezKucqeOCaJgrG9TvuN9BWxKl7ztxdDqZtzLHXGMPLiybUAE3jHBsFJgRb+MrS8/uFIfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JblO7gB7; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JblO7gB7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53584e7c349so562731cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841978; cv=none;
        d=google.com; s=arc-20260327;
        b=bNE9tfkjcPgomY1byVGywR1DtfAEJVZ/dEThfAh3+0ZnhuwGVuD5tWTVJBLCUoWsVc
         iATtyTlNwdrdtIv0e7841ZSsPO2+4rZHY4E6n61dWJOF45LOup+aoUtpdmymhlLHtH8I
         z4fKWThvNvJXGFb+OZjVXHfpiNJC0XZDOftYVdPhYfMPv87Ceo4yBXIwb7d2SgVhDKRH
         p7Fa0+oojKAaYprmIekXJ2el1PAfKlgD/DSCz3GASPJzeBsPcAjvv+Y15yoBVPZf0FHv
         /N0EIVGefL6AsWGKLxRXGGB/KkECkOI5E2/Jv8NaTqdkDXGDOnqqOF0iKhIE01yjki22
         ZrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=im/gThKmBHzXcSbSs0s0PybtI1TA+tD6SJs96QN0Goo=;
        fh=J0lUKXl/a6dHbR1n8R7OMTDPmliwCBrdl0FxV/3GQIo=;
        b=ixJB/ym9zTzcpCqNBq+yJ+ad8z3N8OY8jnA7ZTobylN4wQffPjPpNFT+cklOx1VE+4
         Z8DYyl3m3/MUUpR6+DDak8mTVftOWeC3jvaQm0uf6lLM60ET+JIoNRvTBehNOPWZiFxN
         r00WBcCgHYktuizt9kLeAfOG2k+QLZ8H6XxbLqbCegkz62IcZaSM0q+YzaX8foyxd+gv
         dOckQh+31gOpzMKnLBLdgFoz9KJbqVnNG35dZUdcAyhQFnJtcKnqeISM746aFhqE4bQN
         xnVR0o0rYNCy5Fm0cZD0m3z7p4h5h+RC3pfcZgpDVUGfxAN5tnbDhMvjq1oIvxh7n6nu
         4H1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791841978; x=1792446778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=im/gThKmBHzXcSbSs0s0PybtI1TA+tD6SJs96QN0Goo=;
        b=JblO7gB7VN8zQztJPp5ER3V6gozhmXuDF33y8omJcsnlVSbJ3wESaOCOGz2sWXNCAk
         51nvHBYNjNpcYUro2nNJbTrdUIGKknprCXd/LQ5/U6q9FW16Au/IvnUm0V8Z87hBzUpN
         tW785xneJDlGNqglTfLePC51ocGYbvFMXsHNtdIDJuEmdCzEOnJGCNjjbCp2Hh8+UXZI
         P/Jbxnssb1YCLI70WicWIfJEnzfXcdK45pMG4XSHKt4xaQw6vPkJSzJvwERys0KPCkSg
         QWai4/rL6mEuL9cqH+F4lEgttxRJ6mccirkloSFHL8jm8n1dFBZW6v6vQRysgN9MmXDQ
         Z1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841978; x=1792446778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=im/gThKmBHzXcSbSs0s0PybtI1TA+tD6SJs96QN0Goo=;
        b=eQVb1vPGuJYDNwK9Z+E3DlfmLZCxAZaxe/ICqhqMounCfCKJc12US0HINMff2OzNri
         KmRRTpM5Fqk32zvb7RuyavbpjLe/qfnnNkkWuF3PhgOugLNL2CExQP49XZhgrAh3rhIu
         RRFDt75bMADl5t/OqG57I6avPzaAAldI/dEZWnv5XqmkOjbsxbdPG4CDFtbWnapRLMbI
         pMZvxJBsYiRbLVLqu5KDV72/T5kE6X4C3E1Xx87422qYxOJ9SVrDPFUznnxB+dAtz0wW
         4NsgARneJc5JEt7ikJX9bWKqtSdRl6WDFWuP+HEL0VM5oEID1Wz3o1Oylr8OIKnidkrV
         ezhg==
X-Forwarded-Encrypted: i=1; AKwUvBxUJXbnx5DtDwRqblkdrre4RUqKombgg+xxppHHDDvG3FDBOHhscXkKNaIUvMRa1xX9rKNzLuqy6RIRRKkI+Mgg@vger.kernel.org
X-Gm-Message-State: AFq9FYIh+Z51dic829TbbmsD0v3N4gl0/8tnO1JSbxH50TN9Hk7QoEh0
	NJ7t1alrm8+GCSNkWsGDVR8p/8rT23DysAB5l2GhmskMQdniBbYu9U7s8Ge/DJaPH03ota59zZX
	xrcpDBt8Vq75ufzOJNqi3xzxaX143eOJddVPSN8Bw
X-Gm-Gg: AYBFou2IRcpuapcoSsyiYdPsugXBgNrbvAMGxOcmJc89NVdpIpJ9nUsGLL6Koo9RqiQ
	p8zy29c8BnKEdxn2JW3hk8LnRBRbQ1/iDeh30MncigOGzS47Hr3T5+HeXVVzXAhwqxYxviIj3uA
	7+Bi5MR61aOuiE7VKNXgYW8ij2kZ97RxNCbq9xQ7kvOkwtWRoVG7pg6SGQtVIDdXDL8p2UFLw67
	notrbWkncktmnsy6CiHCqx2hCktQN8FhmwaUlYxo60jcIDIIaL7hEBu4cHCkcHelU+kJ9m9XTgN
	x6h5DHEEmDOAxxjFqmw6o8NMWVBWyGiYH9JaewIQYihl4I20DmiQWUpcYkgYBnyOMmF/ajgkyuy
	ClS2u2XA7Ew==
X-Received: by 2002:a05:622a:180d:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-535b320372fmr38054141cf.4.1791841977467; Mon, 12 Oct 2026
 14:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012053013.14378-1-namhyung@kernel.org>
In-Reply-To: <20261012053013.14378-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:52:44 -0700
X-Gm-Features: AclHuK9GIcDDu7m2aY1N0pJVCrUWg_SSeJzS9Uh8FwFp_eHcRQ5Z4QcHRhA07OM
Message-ID: <CAP-5=fVztdzY2MVwM+9fAW0HoDBKA=KbAzN_fBBHi4M8i8eZMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf symbol: Fix symbol loading from libbfd
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 10:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The dso__load() should return a positive number (number of symbols
> loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> only returns 0 and it's hard to check if it actually loaded symbols or
> not.  Let's return the value of dso__has_symbol() and check it in
> dso__load() so that it can return 1 for success.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table wit=
h libbfd")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/pe-file-parsing.c | 2 +-
>  tools/perf/util/libbfd.c           | 2 +-
>  tools/perf/util/symbol.c           | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 30c7da79e109b480..3979f38bf127c218 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -59,7 +59,7 @@ static int run_dir(const char *d)
>         TEST_ASSERT_VAL("Failed to get dso", dso);
>
>         ret =3D dso__load_bfd_symbols(dso, debugfile);
> -       TEST_ASSERT_VAL("Failed to load symbols", ret =3D=3D 0);
> +       TEST_ASSERT_VAL("Failed to load symbols", ret > 0);
>
>         dso__sort_by_name(dso);
>         sym =3D dso__find_symbol_by_name(dso, "main", &idx);
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index a907d7c1ac948808..a4dcb406c79e9cee 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -463,7 +463,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char=
 *debugfile)
>         symbols__fixup_duplicate(dso__symbols(dso));
>         dso__set_adjust_symbols(dso, true);
>
> -       err =3D 0;
> +       err =3D dso__has_symbols(dso);
>  out_free:
>         free(symbols);
>  out_close:
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5d98888d068c741a..a394e742f9b18812 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1930,8 +1930,8 @@ int dso__load(struct dso *dso, struct map *map)
>                 if (nsexit)
>                         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>
> -               if (bfdrc =3D=3D 0) {
> -                       ret =3D 0;
> +               if (bfdrc > 0) {
> +                       ret =3D 1;
>                         break;
>                 }
>
> --
> 2.55.0
>
