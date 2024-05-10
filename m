Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7C13B59F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376455; cv=none; b=UrZCIGlcWv9UpujpZEiuHeMcuggs5h5pH0DXlWvgx6OUCcjFaTRDb6XbySwnFObh/ZRuRks0MM6fkF8riA+9FftZSTU15GnMg9ZzbL2MKyDQCNdtVMZXR4JzInQHq/lbWrlHIAgpo32eq7Ax6j10Irp/v+CVK7G7AmdrzdbiC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376455; c=relaxed/simple;
	bh=lvG54KOtblTtm/Gtue2giqL/wNiwZJbkby5y11Swbwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZZaIqzosv94zq6YIRxqZV8vkgWpqbYZ86rWGg8IMCQUS/P9rmpnKso7YcxAmx2JoUKbrx87Dp/pq5GGgC0oAPl6JlgasdnmG/7Wnit+Ya+qTwTOP8so2zzygm/F0tehFO1yE10hKBQMKhuG42Z2d51JgxurKITv6EYVv0J4wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc5KTpO+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc5KTpO+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfe020675so136691cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715376452; x=1715981252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMIqC4lMOuMBFP7thYu5aGC3mPK/U3Jb/uL/qezic2U=;
        b=Oc5KTpO+6mFg4e3qHbMvYCx6B9xrS+E7ZMZa6yHBBDWE65wC67Afhck6rTPCfwhwhX
         VauIMizFvB546lrSAhlZQa2n83l1R7Yim4FRsv4cDzBI1POhjgGAcHq8Bg055FwPgd+D
         8B2jpBy9YYUOPqYJWkHD7EU8bMWkAT7WLyEx0hivOYJ5MKo6zse3ciFRaXp34QVfqg4o
         FySmBubx7AREjWDQVuYoCJMkvVQm91VYxv1hhwzNfxHiJBHlKpAZLkF32eXSenqRcIVB
         BvfJRzgBxwH7Gi22XB4hgqf8hCR2poprS9OVkKdskavUdBip/C8R36PDbReBdnmRuZbg
         ViVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376452; x=1715981252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMIqC4lMOuMBFP7thYu5aGC3mPK/U3Jb/uL/qezic2U=;
        b=jyoSc9vpH3Nv+E3pp16NpdsMFEjFUfruG7vuFlxLNk9/u+EAen56DK/N1ld8JA7MNF
         iKY2mZNEKYOhfBC8GyxET3ayN3KPlgzuAuWSQyFQ/9JkKFwdlXraAkGxbj+o0E056/tj
         p1SNM1wFRx5TKZOvLphOXgdhUl9dKbP+MCB07CpCjmd4tCjTWnJbbnE8KvYjroUgPDot
         oZ82NsEb9H0KJNuYnVKbG19CmcBEsx+V8m/bdn4cMtSk2ZuarP0MVKrPJA4l43NmZNBx
         DaviiBtm3d4KqPYfa3zp1URWa5xk6MsD3k3k4dlUigq9c3Enz61r0YqyIv5SdHWfW7/c
         UCkw==
X-Forwarded-Encrypted: i=1; AJvYcCW5GahMk9hOtZvEBvXYNNeD1ivYt7Q6msvYtUvAh6Zjd/xMcTEJnyJKmTVp5nwvMI+tlKTvm7ZJGoPxRmWJ2opD4E+38TepDd/vvqklw+3ukg==
X-Gm-Message-State: AOJu0YzkkZ2N/7FvE69BZSuWxBeWWsKE80fs1Gg2wRIXgeCa49rE6unW
	CBSR/HMzB1HzntnEAah2kEkmBhmEVm8PZf/6lza8m/9QcSXHdQigskd9nbmKvQNBqnsGrrWxq45
	IIuL366sC3in3eFMfOefh0Bf/R8WUzSbYAb3s
X-Google-Smtp-Source: AGHT+IEjb0okTB4Al5CD9PyKlA38q7krTdd+xmQxhBlLYBzsV/NL2v4IqQlh601MgcnDJfiufJcxMBxLXl3KVVIDFHI=
X-Received: by 2002:a05:622a:4184:b0:43d:e294:3075 with SMTP id
 d75a77b69052e-43e0a21da9cmr206801cf.7.1715376452341; Fri, 10 May 2024
 14:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
 <20240510210452.2449944-1-namhyung@kernel.org>
In-Reply-To: <20240510210452.2449944-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 14:27:20 -0700
Message-ID: <CAP-5=fUXPP1eu2dsDjFaZY62yZitNj7y=RfGDinQYx4uqDic6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf annotate: Fix segfault on sample histogram
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
> A symbol can have no samples, then accessing annotated_source->samples
> hashmap will get a segfault.
>
> Fixes: a3f7768bcf48 ("perf annotate: Fix memory leak in annotated_source"=
)
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 541988cf6e19..1451caf25e77 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -113,10 +113,11 @@ static __maybe_unused void annotated_source__delete=
(struct annotated_source *src
>         if (src =3D=3D NULL)
>                 return;
>
> -       hashmap__for_each_entry(src->samples, cur, bkt)
> -               zfree(&cur->pvalue);
> -
> -       hashmap__free(src->samples);
> +       if (src->samples) {
> +               hashmap__for_each_entry(src->samples, cur, bkt)
> +                       zfree(&cur->pvalue);
> +               hashmap__free(src->samples);
> +       }
>         zfree(&src->histograms);
>         free(src);
>  }
> --
> 2.45.0.118.g7fe29c98d7-goog
>
