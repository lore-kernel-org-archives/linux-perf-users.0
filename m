Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14F1A01BE
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957417; cv=pass; b=eqvfRM1nQJQBVhgimfEV+n8sNP+PikL+kSF9p+zCfHDQOhj5be++6GJhNvWzD7K1cjglXViWMU6Wwe7nfDOsIBYSagybq0UDpFdQ8VyQnt++KPX5CW5z72hP5gBRm411crVPpyjJfUKbsRv2gQX1RjVP9K6YDa7OLX9Ulb78kLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957417; c=relaxed/simple;
	bh=qnX7OrOUiULxU/fUhp3juKwTS0+Ym+CaeM3Tax/cn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVtjTuZIvPndyV43V/kWK9OjaDg0aqOKhuW3OmGnskqHZN4KA/7pHduv6gH0dq6gVuD0uaKpSdO0PKzeDZYWx2NBXZXoIAsyanA3gOkqtXa0LS/p5N68nC7/t3kitt/D1fTQjbvbGPetQzRfK6dhjnUY9bZV9xNb1/CSGFZh1LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwBmSq+L; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwBmSq+L"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10ed63c0so56251cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957413; cv=none;
        d=google.com; s=arc-20260327;
        b=aEF0PNjky+hDhHwj6vOJ54jEtxh4qjSvMwZDjpi68cXwRh/NwEtovEBDvV+8bsAhZN
         3BmJAEC3MYtmHRexj03Qv2e8eP0wr1RBfRaz1KfEsUDfWcr3NeRpxWcwRAJk7+7ShPm2
         tDA7Aqfhrvrpkf39fYs2PRd1FaoQtn9dEtojTB+RzznOfifIdgdhhKCmmVo5k+Xsxt+h
         vXQRRYZNX4+nk+s/b5JsTgL8DlDg3doZA4JZ9jugj4PQ4RuyfIMoThJd4tMxRIpWwgRY
         5cmNgJJjMzVAF/u/0M0aHic7NterKxxP2V+hVLvk+0GwQJuEiL7TyrUU3/00ieSO7YfB
         +PeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCRNXU/ySX3MRIE+XcExpQKnB28P8Mf+5kbt4o1ll2E=;
        fh=fXJjSRGgfWY8VMlh1rHZL3s7j3SSBtLng7sMNL7dNcg=;
        b=N9BO90rLWPrVJXijBNewu7DkMwqGZz3ezEav8BY5rKKSXhXIvjlQvM4R5hoHdKYLGP
         q0h/zE6bPaED+MPBOMF0YZFMbHtOhyBKMvD+Q3PmSVRy4X1SjmeNa4jLVwyyZaVMrfsg
         9vqK29h3VysWiQYka2pKRuh3yM0J5391wHlTeDI1ifs53tbbLbamMa8oiI8EEAvS3Jxg
         gU6BUXAliMM7lMpekF2OjvUJypTQIHEVuU7HrbKKWUc9YVfAF18whaqY9A0utr4W8M3+
         VYrUqlCvG2BAbEBMcoFyN9usFdDlYOS/QrJRwU1grfl5xkWK1fXSynvZrN8BDYcEwmS4
         rGSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957413; x=1786562213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DCRNXU/ySX3MRIE+XcExpQKnB28P8Mf+5kbt4o1ll2E=;
        b=TwBmSq+LH4+Dzo7us92dWla4G8rsPaM7FNtB1sdC1A890+8cR9xJYhEmONHgqEpeRQ
         bw5OxhXuoFl9FPC70s5BaZUBV3bIN8pOY7+YLXha/0cby4IwTH4vEsP+OqkXtbJDO2J3
         Uo8eNwmI8KPF8R1g83wvWgIvV2Qpj6s/taQOmEKnG6oSOPW3XIui/XjOkWKV0zEIiJYf
         y01gmF1q7ClhZT0rx/9XTWdNXwBbiwklcG8mmZBLuCnz8yfgKwc6sUNBj5AptTZvynzU
         xlrMoQfFsIBBGLB+c9qib+wxp39OiXvbmsVnnwt+x5rWiwvr9Djr4JaE9MvYdIeQSxPw
         IVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957413; x=1786562213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCRNXU/ySX3MRIE+XcExpQKnB28P8Mf+5kbt4o1ll2E=;
        b=lasFJyva/BomGV5Rdba+add+OA9M/340LrPDS955CAeiU89zvuBi8C9VAkZtQ37o9b
         8cJmz/Fjk/06fgT1szdMz3r1Pei8zi8OLXFpDCHifB/XxkOxcIe6OKUl9muGYl3P4wnq
         8hW/q68jhqbQNINxvtoJpelWcqPnWw70oWOjHvYoMuL40QNFMysQOMxxKh8/ewEjkIxM
         aB+iGhcBwiF5o+SgB72luyRY99Sft5YswXIuYzDcvONOl1FSqBsojNUEUbN1WuQU9jFx
         OCFyxXD8PaFqSM/X5W/4OJPaAjB2DQh59MbiRRc6hVpMhG0uYwWTWWDz3djQ071FLmU9
         iZ2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro73YcI5ggq2xrjnFgHArxKv6SglsVhs0DEM/2bHIc4zDAHO3fzDKnAtk17P2J9eFMSn6+EeDZbeJUymdUZci1p@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kQl1UKmDFgFbKJqE/cxOfotZl+ciQh6nI3P/9Bif9o9yNw5a
	A6DvFNne7+jLyS6YYFL1+aU2jUAe4y7t2nnRsci3NpegzwWcR/mEbPG2AYHAw4fMO+Wo7yqJ6Fh
	+D9bZ4pvoFmLCQ7ygqjhIEyabK90tvp43Z3U/CatM
X-Gm-Gg: AR+sD13WpPiTzSmygCfmPCXvuTj/rpLH7G+0ZtG3yWYgxBs9vI63xAq+lcAUR1AkAX9
	km0LcZi2mkMg6ozZRMlFri6XJRol5nna2vkdJ9uvawTDngZg+BxURWwe0p0zjlhIJ9hv+DgOjbv
	q036Kq8LXuI+xbD8wvVqO79KBRQHB+btVOj/eG8bmun8q8T15Fzt5Y0zeog41mxU2R2F2VoLp5C
	MjvSNYZi2ZeKPYfkVxGUMd/zHuenazuW6Fy1t6yzVDlFHmMZ0/WmQSFW3UgW1xU9+/dKBxVA2qi
	eAt7tJX7jnkURg/Y5/v4RDMDMTEtIAuMhuv4iLKG/oQ7ig==
X-Received: by 2002:a05:622a:a948:20b0:517:6dc0:698d with SMTP id
 d75a77b69052e-52cfbb4c967mr2596951cf.0.1785957412247; Wed, 05 Aug 2026
 12:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-10-acme@kernel.org>
In-Reply-To: <20260805133013.235016-10-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:16:40 -0700
X-Gm-Features: AUfX_mw73tcdJZYS4Mw4XIjddiVCnI3QZON3z8WM4OQvHZ_wWyuoyyQKmBfraJ0
Message-ID: <CAP-5=fViJUQge4V1mVUaO37qarnsCTwpKzX2kqRZT14EvuN-Fg@mail.gmail.com>
Subject: Re: [PATCH 09/12] perf jitdump: Use dirname() return value in jit_open()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_open() calls dirname(jd->dir) but ignores the return value.  POSIX
> says dirname() may return a pointer to internal static storage =E2=80=94 =
glibc
> does this when the path has no '/', returning "." from a static buffer
> and leaving jd->dir unchanged with the original filename.
>
> Capture the return value and copy it back to jd->dir when dirname()
> returns a different pointer.
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/jitdump.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 3085091b95a517ae..02840dbf8a1fc16c 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -146,6 +146,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>         ssize_t bs, bsz =3D 0;
>         void *n, *buf =3D NULL;
>         int ret, retval =3D -1;
> +       char *dname;
>
>         nsinfo__mountns_enter(jd->nsi, &nsc);
>         jd->in =3D fopen(name, "r");
> @@ -241,7 +242,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>          */
>         strncpy(jd->dir, name, PATH_MAX - 1);
>         jd->dir[PATH_MAX - 1] =3D '\0';
> -       dirname(jd->dir);
> +       dname =3D dirname(jd->dir);
> +       if (dname !=3D jd->dir)
> +               strlcpy(jd->dir, dname, PATH_MAX);

nit: prefer "sizeof(jd->dir)" over PATH_MAX.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>         free(buf);
>
>         return 0;
> --
> 2.55.0
>
