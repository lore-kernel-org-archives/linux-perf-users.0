Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698603A0E99
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956472; cv=pass; b=iIyGJdfiwSeL/JFeYRIUTg16UQa6eP9KrB2B5MWr7qtH9HgjHNTb8Y4Xa0SSurmkmYh5m/TOKj2uMBl+2SmgyKA+5Hz0s5x955lmOwgGZtPukA5fW0pe+56nyEt90alYwzGjn5CF2R0EVBSxwWSfDIgPjg4Z9pcjzLk1w3yh4u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956472; c=relaxed/simple;
	bh=jIY5prE5aOoLzhIe9EMEEwaFNFcBg/xyXNYT+Smc+3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwdyquAHXjvTSJauASXwM8J84zEbFbgboa43XuUlghy6ZvUzomGsFdXwnwNHbtLo4T0VHOl200ucJqmXXjCBvFeYqNyMctzjFe1Tcrw3mHyEBRDI8rzV2P5321Bsedxxc+eliaKdSKgmaCHtJy6u8C7eT5Lo8nLG8RZw66NY/tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hX8ZJoxH; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hX8ZJoxH"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c15a5b265so55721cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956470; cv=none;
        d=google.com; s=arc-20260327;
        b=CckT81aVx/EjSFzcZgdlnLNi7Oa/G/ktZJvU2wdOJGpnGYvFazNC4owk+QO7bLP1I/
         GRz7g+Z0zeUs2azIqqBHu82DUqndYNMZPMGHf38J7AOmSaS0W4xCzE6Gyw4W1HgP15gu
         i4F+piP66pMXzALEIgNmi7JWutj6myDzqwm446zf6WH0bV8Bw0x++7o4n5V78yQ4bAHU
         uHDovuYrn5uXRggNLgbpzMC37U2Hf1wCwqFpU8FZU+92vNU0hyn+Ku6D7Z1HfCOB2M9l
         +48nv4cnGWHHO4l1ajyo/8jPRoKGmF76tgRIvihbS/Sw1YRVdrItBIDmn36ZIyywll6g
         njQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z35khEO4rTND3hGqXgfKgJsVckzbmvAVDuboOcg/mK8=;
        fh=f9aGID7iLthDMMUp0jVQkzqa0U9S5gGNUMuUuaHFHzE=;
        b=AGNvD+eoo7zoQJFKl1AjqQyGgjUuqAodsl78gwysYyHIiH/zrCHfkeHWTiZasdVJ4r
         uSDf2OKQhQXHSGlBdoDTgQg8vbFNlChcLizkpXLzltTDK2OgtXnzZSIJejdQSfTL+GsN
         BYe2wTodxleGnV3h0269G5zXN/EjgUkkV817AzsdSM1FrHrFUb4zl8xBW7TcCU2ZSNQK
         YcW0tJXvEKugX/vPu9lMNa/AOr8v6A5J6TPu////07/v3kk61R98BWr7fhGaKZaASeax
         E3jKhjzH7L8nMl6Ck3mcA3PE3NYOYks/D65PA25jTE6mMDcnA5NyknDI1tzbYboOsQt6
         8oow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785956470; x=1786561270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z35khEO4rTND3hGqXgfKgJsVckzbmvAVDuboOcg/mK8=;
        b=hX8ZJoxHAOCBlC97vDaqjukfXU3dh20/53CL+HpjZyGpa9qDCuFIQ93IvI8xQg88hh
         VL2MJmVczE1jlkOyLAFKJqPILYR3NtfFC2gTZlMv/4QrXm1xKpdxLSIZ/CIR44jEiVxa
         bTTZ30CY5qT2uy2FfDRBYeMg6O6V0u6AooV2zcT3s3F4M2u2+Sm2/9XdqDkaXHLYOVG0
         H0bYQILK3KGWUqgTII7Jc4PgPmhYpABA2iRQHOVSbFgcIUSp6sCbwwGRMk5qNrDTr7c9
         4wgiUHPpCWjZud+l0fmODE5gSt83eBNnGu2umnsN6PXOzhrbreZEU1vbvhmtByLJbV37
         kuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956470; x=1786561270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z35khEO4rTND3hGqXgfKgJsVckzbmvAVDuboOcg/mK8=;
        b=U2dloCAjFQGnARx8nSKY0EbxA6pPL5GeZt2dH0+5jSCbehYTdXCIdo/nTr8O4YkUHZ
         eI2OUZ/MFOZZbO+F3X0HEpa9Q84dwxw7MTPFVIMtKqSdjDRlIvOnzhbQz+qYpCdSgZeA
         cIBJi9F9H16WvO83juZ9TJDBl28CGyN035R6PuN8pcxK3lKxTKFC/Q225EAFcNLWvYkU
         uTtn7y7BYtoBtRXaKJBX2+zlFt8653SD3a0fwAbqFc4pTeYAl0iDV9jwFHGut5PgxyFl
         Ae3LEYp80yTrl7Ux0ez3GOKOd2ZqfdDv7Cnl8yIa/ZlRlTDvuYb8f6gLg36fDufbdIZq
         XrSw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2lvxtZXuj99Habfd+ikKDjegwaDA0AFn6ttGRpDC+S+Dw4F9qVa60GNhxGmbPdpIKaR25ROuHf+/7JO/bCdeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqRFcrUgp9JGHEDeZ6gHR7kncvlEZwCNmdI/D8QywcWrabrwG
	AmUKlp1exVbkPbNWzvhcSQcxGQ1vQJ6zCwVUHRhcBVbUwFya5Qe7BVlodscGCcyHWXCTBefFLNJ
	m5JQ59IiQGTHKF82UZyAyOJCVMC8xeoTmB+pWGFKS
X-Gm-Gg: AR+sD11xB/OqO3uH0JLPQR9IhPQr1Ay8GAYoLV6HHBOhwTJFheUP2pRpU3YDDxmQAZw
	bc/9e21Fj1hVbEDJTD3DE2pWZGi+/txBuk3KWmEJeiUkcyEQOtXAeiZvkT+Lf9gb0KkECTAPxaT
	39GdObiTHIMHdxK0jKXpLDXQlM904lfLGL3e9PvFAh2M6bZ8HZz5dHziafSZn9t67u5GdWquqWe
	Xa7u0UlVWUy9Qicpkfk8Q34STeMfB19qJzv9LuOKaPqP4ZGiiwXlLqxLT4L6bFwYol0z+cxyY4E
	IUihx/au26XyDrD19kJcpCh4XLK05u8HWL0UnBA+6066sw==
X-Received: by 2002:a05:622a:a18:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-52cfbf2991bmr2329231cf.8.1785956469719; Wed, 05 Aug 2026
 12:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-5-acme@kernel.org>
In-Reply-To: <20260805133013.235016-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:00:58 -0700
X-Gm-Features: AUfX_mxSVEk9HVltm7ngIpx2TjI2TRO9yN4LroAi6ikPa5KaYkMthvCJmatXi9U
Message-ID: <CAP-5=fXZja6D99Fv0=aJ-W27RJbR2=vr8YqV4sf4qGh1KH6SAw@mail.gmail.com>
Subject: Re: [PATCH 04/12] perf jitdump: Bounds-check debug entry byte-swap loop
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The byte-swap loop for JIT_CODE_DEBUG_INFO uses array indexing
> (jr->info.entries[n]) to iterate debug entries.  struct debug_entry has
> a flexible array member name[], so each entry has a different size.
> Array indexing computes offsets assuming fixed-size elements, landing
> inside variable-length name strings after the first entry and
> byte-swapping garbage.
>
> Additionally, nr_entry is read from untrusted jitdump input without
> validation against total_size, so a crafted value causes OOB reads.
>
> Replace the array indexing with debug_entry_next() pointer arithmetic
> (which correctly accounts for the variable-length name) and
> bounds-check each entry against the record's total_size before
> byte-swapping.
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 787f8a03dae87908..078d3304d2b7ebce 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -318,14 +318,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
>         switch(id) {
>         case JIT_CODE_DEBUG_INFO:
>                 if (jd->needs_bswap) {
> +                       void *end =3D (void *)jr + jr->prefix.total_size;
> +                       struct debug_entry *ent;
>                         uint64_t n;
> +
>                         jr->info.code_addr =3D bswap_64(jr->info.code_add=
r);
>                         jr->info.nr_entry  =3D bswap_64(jr->info.nr_entry=
);
> -                       for (n =3D 0 ; n < jr->info.nr_entry; n++) {
> -                               jr->info.entries[n].addr    =3D bswap_64(=
jr->info.entries[n].addr);
> -                               jr->info.entries[n].lineno  =3D bswap_32(=
jr->info.entries[n].lineno);
> -                               jr->info.entries[n].discrim =3D bswap_32(=
jr->info.entries[n].discrim);
> +
> +                       /*
> +                        * debug_entry has a variable-length name[], so a=
rray
> +                        * indexing would compute wrong offsets =E2=80=94=
 use
> +                        * debug_entry_next() and bounds-check each entry=
.
> +                        */
> +                       ent =3D &jr->info.entries[0];
> +                       for (n =3D 0; n < jr->info.nr_entry; n++) {
> +                               if ((void *)ent + sizeof(*ent) > end)
> +                                       break;
> +                               /* name must be NUL-terminated within the=
 record */
> +                               if (!memchr(ent->name, '\0', (char *)end =
- ent->name))
> +                                       break;
> +                               ent->addr    =3D bswap_64(ent->addr);
> +                               ent->lineno  =3D bswap_32(ent->lineno);
> +                               ent->discrim =3D bswap_32(ent->discrim);
> +                               ent =3D debug_entry_next(ent);
>                         }
> +                       /* clamp so downstream consumers don't overrun */
> +                       jr->info.nr_entry =3D n;
>                 }
>                 break;
>         case JIT_CODE_UNWINDING_INFO:
> --
> 2.55.0
>
