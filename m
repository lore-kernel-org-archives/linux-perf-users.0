Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3B208A9
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062579; cv=none; b=TBuxFpd7yTEOEyUeNqYAUlv0bQcqWx1aQHxu66n+j/J0J2V5HurTBRvOYBL2bzpnmZPWsyCyQ06UaJazSzseJSE90MQv+CRwXFXjEH3sR+4Rvu+PcEBrM8ExSV9ReWez7qIK3CNK/1hPxfV+aQfkxH2AwZ+z/7YqV4B9Hw1p6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062579; c=relaxed/simple;
	bh=b8bjZwB6QeTPAtY832jHAfoqjJVRh8eguL+Cmdzqh6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTmc7IDfciR6z1sDWoSsQf91BaVHQqOwjJ7Lp36d/BvspKtrsEvpds4CQGwHUrr2hGBBDL4XkO8cjrGyfheu86MWPkx7IGAZyEYW0gEuAjY9uxX56IWFfamyiG4lY3zdt3UJf1KxJmda0WnPtNFIvDO3tmImZ1M5HsK/lP1a/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZYkCHbX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZYkCHbX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44e534a1fbeso7001cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721062576; x=1721667376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02jBTyIYbhiBgb/Yu2ftb/npqvSP6Ka1Kr7RVDqcuYI=;
        b=vZYkCHbXVguwl/U+Tbh98FyJaESZx5ABa0Eq60htOKSZk4QoeAp+7p+JOlY141xfbd
         N5UtaPtHdIYNTZFxCqT8WEYjK8gHyGt6D8g5EfaJwbM0+1h0sLWPZ3TBuVnhkbROVNEi
         ebbZLnqPZc1jLX/mKKEP5/8erTShg8jpgkRtmTmDm7Yk1B+FU5w+LweVyJiQQ7JCe8dy
         xmuwT6I0ElNtWUIXBR+vD48tET2VqibHEwBxGo72OjZD4z3FwySP4yFZ0U/Uc9EpqHmJ
         pdgUbvNYrA7vVDdld/Z6K9jUtucbQGue1b8hXraRAptbwhsr6sAQRz//85BOqVChZfrK
         /arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062576; x=1721667376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02jBTyIYbhiBgb/Yu2ftb/npqvSP6Ka1Kr7RVDqcuYI=;
        b=J+NHAiSdJ4cRGO312Ln/lC/4x0gAVmjdl99Qf1+vZ4yfVSut6biEbUdseYmVUzJZ2m
         reSEb18djG4rCRIqS+MFVfD0HJj6OEB3DIGxtVrLGIJYPVcppvv6oBirDPyIgPP4njT9
         G5F3zUsNtLTvfN1YwypLykfbmjau+uAlXoaebwE8CVMj/Crxw95p9sRktrqpU1aLT3B9
         3bhuSWn0bgg1g8ufkyBmzjBaO65XBBzO5ktRPLCh9Ov0NseRX98jkHkjYunkGxBHSQL5
         JUacFUM03c6fmK+LxwLdgr+CxMyM0Ak56aP2u0e0rxiZbqjKC0XXXAX9nJdt/NWq3MKN
         16qA==
X-Gm-Message-State: AOJu0Yxk+9rtgdVwitlwC1yiVvIKYeq22eFAWxQV33AlMZqWOdADPP66
	9GG7zcUTyabBsGbijtwjbl9VkF9B0RVBtcCxkKMtFu6tRFEyqfejSbZ546ig6AfoOOgi6n6+ApY
	K33ltJ45TFluOuXICN0bewnMoeruYuCrIuUMC
X-Google-Smtp-Source: AGHT+IGga64Ehsgh34xHpgbxZ4XkIMmBA3oeSeXSOSPWRrkTmDK1WjXya3JOHlljMiiiEhUtI9zjO9VfED8ibiHkp3s=
X-Received: by 2002:a05:622a:548f:b0:444:97b7:e3b1 with SMTP id
 d75a77b69052e-44f5ac8ec0amr5581261cf.13.1721062575590; Mon, 15 Jul 2024
 09:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715094715.3914813-1-james.clark@linaro.org>
In-Reply-To: <20240715094715.3914813-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 09:56:04 -0700
Message-ID: <CAP-5=fXug1ht3dVDpuG6hvzEYdexT9eH80E3B2NUraONXcCS=w@mail.gmail.com>
Subject: Re: [PATCH] perf dso: Fix build when libunwind is enabled
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>, 
	Yunseong Kim <yskelg@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:48=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Now that symsrc_filename is always accessed through an accessor, we also
> need a free() function for it to avoid the following compilation error:
>
>   util/unwind-libunwind-local.c:416:12: error: lvalue required as unary
>     =E2=80=98&=E2=80=99 operand
>   416 |      zfree(&dso__symsrc_filename(dso));
>
> Fixes: 1553419c3c10 ("perf dso: Fix address sanitizer build")
> Signed-off-by: James Clark <james.clark@linaro.org>

And I wonder how this ever built..

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/dso.c                    | 2 +-
>  tools/perf/util/dso.h                    | 5 +++++
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2340c4f6d0c2..67414944f245 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1501,7 +1501,7 @@ void dso__delete(struct dso *dso)
>         auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
>         dso_cache__free(dso);
>         dso__free_a2l(dso);
> -       zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
> +       dso__free_symsrc_filename(dso);
>         nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
>         mutex_destroy(dso__lock(dso));
>         RC_CHK_FREE(dso);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 878c1f441868..ed0068251c65 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -602,6 +602,11 @@ static inline void dso__set_symsrc_filename(struct d=
so *dso, char *val)
>         RC_CHK_ACCESS(dso)->symsrc_filename =3D val;
>  }
>
> +static inline void dso__free_symsrc_filename(struct dso *dso)
> +{
> +       zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
> +}
> +
>  static inline enum dso_binary_type dso__symtab_type(const struct dso *ds=
o)
>  {
>         return RC_CHK_ACCESS(dso)->symtab_type;
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/u=
nwind-libunwind-local.c
> index f6a6f6a91030..16c2b03831f3 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -413,7 +413,7 @@ static int read_unwind_spec_debug_frame(struct dso *d=
so,
>                                                         __func__,
>                                                         dso__symsrc_filen=
ame(dso),
>                                                         debuglink);
> -                                       zfree(&dso__symsrc_filename(dso))=
;
> +                                       dso__free_symsrc_filename(dso);
>                                 }
>                                 dso__set_symsrc_filename(dso, debuglink);
>                         } else {
> --
> 2.34.1
>
