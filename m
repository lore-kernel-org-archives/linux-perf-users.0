Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C591684A4
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061503; cv=pass; b=kppSaGiTTcy5kuuKmx7DUfn5rt9Nv+EYH1FIYUFd9hIwX+8VzP91KpMdy1hv9RXcshi8nVyu4MHVERbRYAXCgmYUr9IHLbvcLEVxrgo9PtDxsiWFb3u5Xsr4MjIIYMjp33q34NtibpeTZC+e0tK/mpdBsAwty6fnprUx4UvKeVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061503; c=relaxed/simple;
	bh=9kL7EZoOV4JDgyIA/bx6IhyWvwezSoNhdNl38fo2OI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=T34V1Gz3Zy1iJLLiAXW1cc07xTxGpSdLDBEpvpNUFgRyBfvynGUOFJqbmvZKvBkw3raTbX0bTGJMhztFe8/PyuJ1GjHOkoEd6TZPelBFUMQYHst9a1cykPdh5rf/LgvQFawtSAUCn1OUpB3KqDaBb6TIqPjOqoomJIwOQR1TY1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzR5UrjX; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzR5UrjX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b052ec7176so33145ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774061502; cv=none;
        d=google.com; s=arc-20240605;
        b=V8fYaDughA55oWLRUUoGOWYfI5tb4EdwIz0cfwgPBhrZ3O5CsN9g22Q0pLII4eHImS
         hBdUFrAglBIanuRH1N0IcUkC/VG/eNW1i6FALtcHmA7oYnc3f/ASSwUL+xyCNhBsJPL5
         0SUPhvJaNHIk8NzxkPUCLSnkJgLa0lkcmnwVEV07UnAC9gpoqrqBHQ0TMIl7H6jf2erD
         hTIGezBxXEVZpEAP+HEiFPOx5wo6U9ljk/XdwXlUXyWuFOqaNFjlp4gx0mIdhdQiOH8W
         tzcL4gRV+NfHThubmd39QrU8BeADxvGgGKDJlstcRJc8ylOMxLkgDXnVKynWKZgpkvBY
         yV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xPWm/5DMxJNmVsQwpRhDLjL2H1b1gwZV0mXshohuqE=;
        fh=JqHiFz2p9CLr74RBttz78OwMk/4kuKm5REn3AapsMhE=;
        b=VRYSEtBqU5kjL7c/rhaYouSBEtU/Rd2KY3NWnaGOSzJBaUS/Vp+MllOg77V9rURFEY
         XJV/3FRPzbYmusDagtVRv373KcmVzLjmVwgIAH+vvMNvTufFjjUpvJvjUtVcZ8VJX/yN
         ywdhHeIHr1ZtTQHoQ37EvJEcqsjRx/+JY2nrB1/jDaGjVheW7j0X978gYE5RBdQTg5y1
         5qTUyQA42bY5OM5YIYPNxBvT6OqNuIhkoepiNscM3qIRel3u4LeqvpDle80AB16RcaEE
         ivSAe3ZILmQ5I+Ds3BHfa8ppPYDbH0e5/vw+tEBCwY4eL7KZYUaZo9rgipjKjd7i/d1i
         CxIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774061502; x=1774666302; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xPWm/5DMxJNmVsQwpRhDLjL2H1b1gwZV0mXshohuqE=;
        b=SzR5UrjXan02wE7sB5BO3au24X/eIfWXNWsI2k2Oxj2f618ViH2kOH7grL+6H+kPO5
         kId6ZGe0sVUkAzqXjlpykmDQFVWOnPN43tc9+I6Vrq6W8RvXloP8pyIAaHgjfhZJ0q2e
         6RmmNSrY2uLspiFkMT0kdoX7lI6SH4E2J3TOFGK5qa6lQkqF03YkrT7B5KeeE62O+SQe
         8HUtqSxMrcxhgW1H+1lK2pLLwzH/5rjzsRNvxSnbgTN/PcMYRmE2+DVg6SC06Eeu9QKJ
         +yi62dlK2SRj+XmHXPuKEAJkknbXcupm8u30BfrkL/cLfFKm8J6lElMqWjzolEcSlAxR
         1uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774061502; x=1774666302;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xPWm/5DMxJNmVsQwpRhDLjL2H1b1gwZV0mXshohuqE=;
        b=guDJ6R0xqot7nntwTk7+6CR8/epVKWRP+hlVFlA2Al4WGT4MIwO98TsfhTmbPpVF8f
         0b4wcoFzicnxYkDKR2R1wePW0uabD6AubWNa7U95XXq+E1KndB/ehsPsfN6/8gJ/398i
         M29oTTWCXasUzu0fNqh/Wp4rS2T8IKoSaVrRGpKUlI+CqZKEDkvpnvgOKwYx29S0ob5Y
         nx/gqm+I3KnfxkomqvIs2aoixJsrYeY2L2fbFI6kQIS2yFDTlw9xWXtFzZXiM2bC2wki
         e2wTyoqVAQgfLu2fqt3KrRjGgLfpZ7lDerdTKu7PdcEB5TfA4kBE2HkGTiMVq681vz0s
         fHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJYfIQzSFe/kAVn8qlpKiCavnbtjqypiYcRNu9qts8PqMJcwGthyZfGnocyUHIWzOfJBEGE2EV3G+WZPcOQdHE@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhHng6RKpgVgBu6JCp/Q5fvTluzR62EdFTggxc1jg7CNQYbTy
	94JbUMp5EN0jpBds39949EB3Ev0bjS5jyiH+v+ce9PlI8bG1K4DFxCPfCbrUXyJCuTs/o+ntwa5
	1o7f1VIcc1CDNFghroNKJ9Z2BWR5+FTobHhUm0my6
X-Gm-Gg: ATEYQzyDuUwgfasyuwwGN5aKI09IblExWVR1MpGw2gPIfYMpZQ0skYcmEPexz9LtBpD
	aX+SsfMmSe5IyneRaZTIClMuwRRA999+4/TCotC7EuT+8boAhEfksTYBXOjv7fM+X9iVlqEv5+S
	dgbXPL4gr7mRlq+jMA1jFuSUHJj1bAIq8Fg+skiBqNqSJ3q+GDSveIsUz1qM0DMx8UiaL8KvcM9
	oaomV6EYXFqTbEJqHyrdXm7zkbXn2WqlwXQHFElv2cmiGuWiOwa8n9dJAqxNvJljNC+i/r6vjVA
	BspkXkURFGvR73Z6GJ4=
X-Received: by 2002:a17:902:e801:b0:2ae:6432:8f77 with SMTP id
 d9443c01a7336-2b08c441876mr1011325ad.17.1774061501553; Fri, 20 Mar 2026
 19:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306191614.2064618-1-irogers@google.com>
In-Reply-To: <20260306191614.2064618-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Mar 2026 19:51:30 -0700
X-Gm-Features: AaiRm51oxLYi8NN81skb42_XMsgL0RlTB5MVefd7qyrvlJqjKGBl_135VJ5DS9c
Message-ID: <CAP-5=fUqj3DF+m1S4MvWY2Tg4Kb8=92Kr8N7MukwTnNUSn_j9w@mail.gmail.com>
Subject: Re: [PATCH v1] perf disasm: Fix potential use-after-free on fileloc
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:16=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The fileloc is a copy of a pointer to a string but in places like
> symbol_disassemble__llvm this string appears to be freed setting up
> potential use-after-frees:
>
> llvm.c:
> ```
>                 dl =3D disasm_line__new(args);
>                 if (dl =3D=3D NULL)
>                         goto err;
>
>                 annotation_line__add(&dl->al, &notes->src->source);
>
>                 free(args->fileloc);
> ```
> disasm.c:
> ```
> static void annotation_line__init(struct annotation_line *al,
>                                   struct annotate_args *args,
>                                   int nr)
> {
>         al->offset =3D args->offset;
>         al->line =3D strdup(args->line);
>         al->line_nr =3D args->line_nr;
>         al->fileloc =3D args->fileloc;
>         al->data_nr =3D nr;
> }
>
> struct disasm_line *disasm_line__new(struct annotate_args *args)
> {
>         struct disasm_line *dl =3D NULL;
>         struct annotation *notes =3D symbol__annotation(args->ms->sym);
>         int nr =3D notes->src->nr_events;
>
>         dl =3D zalloc(disasm_line_size(nr));
>         if (!dl)
>                 return NULL;
>
>         annotation_line__init(&dl->al, args, nr);
> ```
>
> Fix this by making the fileloc a copy of the underlying string in its
> init/exit.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/util/disasm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index ddcc488f2e5f..b83bc14f82e1 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -908,13 +908,14 @@ static void annotation_line__init(struct annotation=
_line *al,
>         al->offset =3D args->offset;
>         al->line =3D strdup(args->line);
>         al->line_nr =3D args->line_nr;
> -       al->fileloc =3D args->fileloc;
> +       al->fileloc =3D args->fileloc ? strdup(args->fileloc) : NULL;
>         al->data_nr =3D nr;
>  }
>
>  static void annotation_line__exit(struct annotation_line *al)
>  {
>         zfree_srcline(&al->path);
> +       zfree(&al->fileloc);
>         zfree(&al->line);
>         zfree(&al->cycles);
>         zfree(&al->br_cntr);
> --
> 2.53.0.473.g4a7958ca14-goog
>
