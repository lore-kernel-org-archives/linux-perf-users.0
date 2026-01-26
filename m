Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11F28CF49
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462165; cv=pass; b=kfrrUXpVySeR1/IPw7j2x6xNgpBZ7pOfG6wMnOqTplukrGvmdLz2cuIsk0KX+H9tTabgeln+f1dl4fjXPkh7PSAGgZ2S2IideYUS1gVldUCr4+6buHhBWKbJsDaHnkQN/JSwBcvc5w92zZCEyS85Z7i+x/EqGrdL3SfxymB+FsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462165; c=relaxed/simple;
	bh=ZTNi3GiUl+7Y1ponx1HbvnBvuEQ/jQ5xft9CZQ+VJOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kphg86uK7H1IjyC7WOh0P3n4cadZdfsX/fBHk6MPO3CAcX8CBxj1pP9Tv9QSdYcGMXLkli9P1d0YI+VyHdrNqhEwMo9QcMI2Xug2Pw8AkkTzJtEy3h32ZX72rw7xKbv3+jo5SP+JHK5i2FSq4w0X8hH1Dv/NN04Ci1QXIdX4xCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yf//41Hy; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yf//41Hy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06cfa93so5295ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 13:16:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769462163; cv=none;
        d=google.com; s=arc-20240605;
        b=HUMDW+T42II6dZaI/gp8DQOg+vMQd0MfUDj/3s22w1HwLs8P8futDxFP5ZNz9oqfai
         uBr1TZ71X5CG+kr+a6LaeklaMlpqlbRaMURaMul/s2mw+2wyxfSCTxU0XmXIrB1mUtpy
         VGQQSkVN1UnqdETzjC2gllyoGFZ6lt97lZHSOZmOa9o1OS3CzK39Lnyroxn9UkvW3cqP
         M1Hj0h6hJnagGOymWD5RNZD9uL1vAohHJvcqtz5MSDV1iH+Cjf5FpWgP+KK6/uLUoQvd
         qSi50z219fVHvhThQHLW82w2mq28XqZF2pdLGeGvG4HOn/4dz1EJrN3hChALyy8SA5gG
         BGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHpO0OKLKkRT50mpuDRbrQIaNZHpeE7fFo+wyzARoyg=;
        fh=VDA9n80Gw1DYmAoLDOrh6aKcobegC+MWWmOzfhzNz54=;
        b=hLHAwaCP+Be6cThOMmojOvDvx+ou0VM0xYHZ6YsbuOPTPf3Vf7XL+PHvMOfK9axfzf
         DU85OT+0+mgXIL+XwtSLe3AzBMyTGchpmYAXhKFyRCx4XVVc8Ub7eTcO2YjJVoyGgeQ3
         MPnMom4zSIPr8MO4c+Iyg5cB9J1ppbnyWbJjCNgtXNSGn/kw4IRxGuYwFvk2gJrURfxh
         FrH6K1YVnACwmmAOsyK2prwEu4d3Qq2M0BefyjC+9D7dn7BB/Pk26iXfwPPL9Z9pXpGe
         gstJIJRZrvMfo+CIpWyNdoUrulZIbhvRpE1L06tbaxHng3MH0/HnxHQuoLS4UunI8EFd
         QHfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769462163; x=1770066963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHpO0OKLKkRT50mpuDRbrQIaNZHpeE7fFo+wyzARoyg=;
        b=Yf//41HyH2QJnN11i7s1t4kzvximnL4hra3fjmBrXrnOzd/BEWJhMKXNU7ETIZpOzl
         7JTiIDUdSOdLY02gFxz1ZFXq/Dv+BVfzZ6hjfGNOsw3PTDd97eyiTZEMN7TPmPaax5jb
         WXybWlHesO9pOLDGmRiaxxp4Py9EhmMgTTFtAsYk93g4Gmxig0x3ODebN2+dXjWtqC7Z
         +0kQHvIb18RSOpalNt6Zhzy5L6PZhvxdzfZEx9jU3m7vjrPPcaJtCUJzvXpWifW1tPrx
         zJx4wDbgjIhttVBlkybiJPExvJ+b1QCDkg6PAddGD8aib/iWZ7ssGBarBIAQ1dj3IDcr
         aS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769462163; x=1770066963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHpO0OKLKkRT50mpuDRbrQIaNZHpeE7fFo+wyzARoyg=;
        b=B3W4uMRfOhEx2KW9zGeBw50UOUK+YQ1VaMtiSE+w9VybYdlTNBJ9q9fXyxjiCZL6Qh
         LFDzqMjWYDKvAcSWP5ehudhYLqSpn84KXD23w4ECDOTWHoe9ZcIUBykvQJAtHIJ+alPh
         +utovjKfFSQtC3dJYEFj3vkLIN2e04NL3pKilcBbiDOrt3AN6cEwL0dcMJKWIVMsMnoH
         vY/UC3ok5rZ9L5N7HCbshU5kZmR+DK72VbL5bU+tzmeCDmB99IuCQy3wo/V+ER1cIWEB
         3nTinXWGauQZftA5QciFOWtyE4K0WV+7dIwMfZV+PivWErzWlIVSM4isKMaLsG0al9ae
         znuA==
X-Forwarded-Encrypted: i=1; AJvYcCVtShevH98fiMHygyhMcp8gGzBYzTviLwl77QAB7Cetcb9W/084EnDLIKudEe27AlK9utAbH02G0NOASPnKbz23@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9T1Pwr+ayi8u+ZYwk89JecBJqR4OY4jP644VIAt2qy7dcbPPR
	4zRBpOAOOhIRsLneWfBaG2I7LDz6FLn9kLuuVKLH0pV0Q5oGRAmDXnrZpUxl/Oyu6vH1fW8SM7H
	haBP8aVxZupfsldy7TH8U9mu92d9KG/ZXyWUBLbi+
X-Gm-Gg: AZuq6aJIGC8vAs5Sf2lutNxJU4ozMUVG740gOj6W+ArXwcPZ+dJlj/kdSvZeocWUjNp
	MV8jJRaMxLCjKFKm4GtZTaVW3CmK6nFLzcQL+3EGpk3jswjXGeq62kNPjcLIXSPhVjH3UaGrJfC
	xAtEggkCeFRbUojolpx13laUgWckBvg4qDEjycCDzndvnqG2YNkI6kjdoribvXqEe+LIpocDpJx
	QuUIcpN/nUuNKd4JKtoTbzYDjR0MP8GXViZlq+tEfQ3S6Ul0tFCfF/geB4jVRQ1ZhxspxEODQqx
	/4hXRkphF/aWKCeIJB3TY967yw==
X-Received: by 2002:a17:903:3bc8:b0:2a3:2844:98cd with SMTP id
 d9443c01a7336-2a844b09e26mr2637735ad.8.1769462162869; Mon, 26 Jan 2026
 13:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aXfPTjbtnG7fXR8b@x1>
In-Reply-To: <aXfPTjbtnG7fXR8b@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 13:15:51 -0800
X-Gm-Features: AZwV_Qh7AkbnKEN8qg2XVB3dvvRf_rpnYK6w6LJbhwHVy679xaxgK8GNnvWUe6M
Message-ID: <CAP-5=fVEfYNzzTwQ4k0UUQ5xQ+U+G9UJo+qr6tPkXDcWOZsC9Q@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] perf annotate: Fix BUILD_NONDISTRO=1 missing
 args->ms conversions to pointer
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 12:32=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Fix a few missing conversions to pointer in the usage of 'struct
> annotate_args' 'ms' member in symbol__disassemble_bpf_libbfd().
>
> Fixes: 00419892bac28bf1 ("perf annotate: Fix args leak of map_symbol")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/libbfd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 79f4528234a9d6d5..63ea3fb53e77d5fb 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -501,7 +501,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym=
 __maybe_unused,
>         struct bpf_prog_info_node *info_node;
>         int len =3D sym->end - sym->start;
>         disassembler_ftype disassemble;
> -       struct map *map =3D args->ms.map;
> +       struct map *map =3D args->ms->map;
>         struct perf_bpil *info_linear;
>         struct disassemble_info info;
>         struct dso *dso =3D map__dso(map);
> @@ -612,7 +612,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym=
 __maybe_unused,
>                         args->line =3D strdup(srcline);
>                         args->line_nr =3D 0;
>                         args->fileloc =3D NULL;
> -                       args->ms.sym  =3D sym;
> +                       args->ms->sym =3D sym;
>                         dl =3D disasm_line__new(args);
>                         if (dl) {
>                                 annotation_line__add(&dl->al,
> @@ -624,7 +624,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym=
 __maybe_unused,
>                 args->line =3D buf + prev_buf_size;
>                 args->line_nr =3D 0;
>                 args->fileloc =3D NULL;
> -               args->ms.sym  =3D sym;
> +               args->ms->sym =3D sym;
>                 dl =3D disasm_line__new(args);
>                 if (dl)
>                         annotation_line__add(&dl->al, &notes->src->source=
);
> --
> 2.52.0
>
