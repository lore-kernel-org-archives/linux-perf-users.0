Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1D13B591
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376470; cv=none; b=oqWeqB8RJePUcbOON4rJlymrV6Tb54C8w4unL4fWmPB9vOunBA5FZ/gt4ogHVgdHnkAK9gw2wWbi7GIK21RsUYS+pWpKNTyS5OMG0xuZF1MgHCO4x70hGmxmVeE31PvjeKgqeofkYomhAxMbzKiVEOxYiSvYYIIqJNjU1tb0T/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376470; c=relaxed/simple;
	bh=hb8r21bsZDeQ6IILpMa8J4jpgSC0HQY1iW+OfrfCDS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1yAKXkHyFUJZMlyA9ske6rBSYz+a8WDPXDMXwD+Ko8JfH5xfD3pJP6//oJyEFRVeVFWOR+GJXXl00KMKwIvGuSGxOFiAibeOAlgHJ4l0u+TLyTcBWL7MuVAoTo9Sc7PHnRs11t0ch9ALpYbn+6/8Ci9HdkpjTnB+SeNDQjplvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNvAbBlx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNvAbBlx"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so136921cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715376468; x=1715981268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mKJDhvKiTqgTK80eZzW3APk5Ua5WfNa0sYKeeiCXcs=;
        b=TNvAbBlxuTRKLa5wrg92RENelGxOmZ2QjrOZPDxhz3fc2lEQr1LwKnd9Ev3Ctwmike
         VOnXtJiOUZ0fjctYqB95Ie2lw7DPsDtvQ3/3CNpGP9e+0AcyobVGTo/y+aYciTOKHfR9
         jO+Cp2AeCcWMKllpLfQl1weSDsRK8aM3lKAMDl7rxTj+LpEuOAl6rjfyFJ1YnL0IN4iH
         vTr7vTDl9Sq9iEWB28C8qu5ltvMlKDIS6jOCluKnq0vrzofR6ecI/IHS5Gc1AoEyAQQx
         ayK7f5Z2E6xINU0b6sgMfWzfReDEkYkTBia6AqkFBW8GLWXX46EJJJwf9HULiQqOSKpl
         m1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376468; x=1715981268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mKJDhvKiTqgTK80eZzW3APk5Ua5WfNa0sYKeeiCXcs=;
        b=wRvgr4avLCyuK0gpL6XzGf/fPuJlesaCbTIwTOYRM0jU41D2gPvilp8NaKmyJzJr6v
         3oi/cVMi7CqxKjxD7Ct2rZwDZdbXJhYcnYTTRwLDuurJrDKgnjNRfB6xaYh4xJVsQCzs
         Czsg7tJ92o0hCn3GccRKS7GwmtTe7qhoaPoq/N6Zod7cJ6uLK4knTSO0OkEwCXjfwfRU
         K3DQijKwh0DS6bCCXuqn7YcxU/6DAgRvp9YGJlWyFDBuIJ35j9v8bSjO0FUvEcyN4pqS
         JVu6IwgnW3VrUoGKeDTT3Y5rEElvW71UvX+/ihTp+QGZrnLlV6NEbalIjPKZ8h5RDT68
         UZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrOwCFqWNh9WqOIalonxzCT+DfhMhxiEwR0vsaUZrE99t9Rkptk+M+Z0iv4iRGtdd5AO7ZU3kZdGPTjIbHoGQRRnDW2wZRQAXIFMzLgpYLYA==
X-Gm-Message-State: AOJu0YwEogvuQZ6gBlrKc74Up8K8/Akl7UD5DQfsjytanccIXsZ6IYoY
	TgfySVi8OM4EQ08ToUaBWYvMyuGKo/KckRZ/nC5JjG9ivYkRM0PVRh2I3yVrhI3HlIfaOly74ZX
	ocK8et7pMpCIajfwiQeJ7MVIU7dn9Y7kphvEj
X-Google-Smtp-Source: AGHT+IE3CmyCzNILFPd5LbQ1jqo8ih0ankzGWd6poIZZlX7bANdM4aQvLdCinf2ho8htV4sOnWDnh8nTLSto4kIBGV0=
X-Received: by 2002:a05:622a:4286:b0:439:ef72:75fb with SMTP id
 d75a77b69052e-43e0a21e3c8mr133981cf.1.1715376467681; Fri, 10 May 2024
 14:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
 <20240510210452.2449944-1-namhyung@kernel.org> <20240510210452.2449944-2-namhyung@kernel.org>
In-Reply-To: <20240510210452.2449944-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 14:27:36 -0700
Message-ID: <CAP-5=fUBQ=GdeQdB25GNtS_ijRxu42W+uz4p6kuykG-8iC1DdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf annotate-data: Ensure the number of type histograms
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Arnaldo reported that there is a case where nr_histograms and histograms
> don't agree each other.  It ended up in a segfault trying to access NULL
> histograms array.  Let's make sure to update the nr_histograms when the
> histograms array is changed.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate-data.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 57e7d4b3550b..965da6c0b542 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1800,7 +1800,6 @@ static int alloc_data_type_histograms(struct annota=
ted_data_type *adt, int nr_en
>         sz +=3D sizeof(struct type_hist_entry) * adt->self.size;
>
>         /* Allocate a table of pointers for each event */
> -       adt->nr_histograms =3D nr_entries;
>         adt->histograms =3D calloc(nr_entries, sizeof(*adt->histograms));
>         if (adt->histograms =3D=3D NULL)
>                 return -ENOMEM;
> @@ -1814,6 +1813,8 @@ static int alloc_data_type_histograms(struct annota=
ted_data_type *adt, int nr_en
>                 if (adt->histograms[i] =3D=3D NULL)
>                         goto err;
>         }
> +
> +       adt->nr_histograms =3D nr_entries;
>         return 0;
>
>  err:
> @@ -1827,7 +1828,9 @@ static void delete_data_type_histograms(struct anno=
tated_data_type *adt)
>  {
>         for (int i =3D 0; i < adt->nr_histograms; i++)
>                 zfree(&(adt->histograms[i]));
> +
>         zfree(&adt->histograms);
> +       adt->nr_histograms =3D 0;
>  }
>
>  void annotated_data_type__tree_delete(struct rb_root *root)
> --
> 2.45.0.118.g7fe29c98d7-goog
>
