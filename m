Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916B7E772
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237010; cv=none; b=qA/K7Qu8I/dYpAbVEvC+n30PsE5rBYpTA7p1DdvY619+uOLvdq+xfRIQlfPS8+qtnYb1oTtXZ16bkC6diWcD+9B6LAriCRtm0YLU8qbApPyWb4OU7EwMQh/6+/0GoCiivjKm8EV8TNlDU+yN7GHmZNim47DGwzGMEn44lePy9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237010; c=relaxed/simple;
	bh=/g14F37mirIOBKpZB7OIDBv6ttQWhutX0fPcpDZNFYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDcjqDUcvkRLRitVXJ7I/FRPDjnHzVvLOOewMI8qVyCNO+TIIpCcBE/D3kt6edne/X3TkCX0uJ4GqVni1RAYimBmCE22xKEaiT96PzOc4fE/YdOV3t0NS9osWQsYgF5KHgpnVeIwC/cYly0rtP60dEVuATFGRIT3qEwZxZLx/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5vao0v+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5vao0v+"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43ae23431fbso136971cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715237007; x=1715841807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfpm2g40k/3k+p/MIEAhjjOe3D3qfwBHw4FyzeD3fNs=;
        b=W5vao0v+PFFJIUhTvJbBFx2EBc114KA9sro3DSmWhKwvg7TKnrPHz+f1TWESQrygpz
         lKRZmkBdb8us/lDCihFMbxKdIFLRGyt0A7LfmERc3fwxn14PDYDxhK5dZqQBjUSMjk0B
         BxGNZwnRtxJE1NVMeTTvyQvFlQejbLM4WEAexDS2kypl7sDQK5qpqXvz9WmV7+8khMGj
         Q1MTwuzffnQIRC5iUNPiY0jHUjnf8pBQf44kgdjT/3xTUez8pHjldEedH6bYtG+aheZa
         fyxlXtZpldc/HAlkdfH02YBYDWbxV0f9hwTDhDTJPUY1UQTwX9PWe+BJ6O0v5gcEjJ+7
         VFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237007; x=1715841807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfpm2g40k/3k+p/MIEAhjjOe3D3qfwBHw4FyzeD3fNs=;
        b=g1Qwjjp2DEP4qCDK8uj6sTJmpYE5uktsWDPlDSgoLcJpHRfeukwJjgf+NbgMHn2CfU
         dzhENGjMgt1a5qrtJ0dq3FMuCzGXD+mAWYMs7YP45db/nEI+BvwUwMcuRWK8R5158KsY
         B29CbIBaGzRP9nr82meKBOT5YkkQrK2kEUgOXOgxkWyZdEe2MfNfsd+51tm3Hp4tI0Yh
         iKuCvKVu3z4M/ViGGX97MNJRCaE+viskLGcsix74DWCA/F2XvqAN2HNZe4VC5pWi5dr/
         p41zcaso3Q9Kdluza4p0z37Ua4wfNCRBjRH376yOu2B1SdabxZ8Nk/ioXX0Fp56a9Kzk
         QikQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU4JqevM13Oz0qJvPkzo18WUCBQkqRLe+1PQyABHoe9DjJjO8jrDD8NPrZX2VLjRztVsFyljfOZSZlAz0H6Hj38mvCbiBM8UmJRrDP3M4vgA==
X-Gm-Message-State: AOJu0YwBzzkJqNtveoST8mx6cUcIzJ55rynXfYbmZmPIIjRTBL42OICL
	OgBUMmof4M0a5Nrk8c6mjAmPWe/8t+8sCbYIonuRJXF65iD+foH3NhLVqooSPClfp0khZkFDt0p
	oLWhHzLIjIFREx1m1E0saiLTCZVmWat4t3FUY
X-Google-Smtp-Source: AGHT+IGsUj70NyQXF2GEHvVoFbL0ZskwScPPIR/RezSyT5OTXl14Rd1FF+kOEXGundYuUuqa/z6LaxOUxKhBAp7MLTo=
X-Received: by 2002:ac8:6f1b:0:b0:43d:e001:69bc with SMTP id
 d75a77b69052e-43df44f9033mr1699781cf.17.1715237006642; Wed, 08 May 2024
 23:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjpBnkL2wO3QJa5W@x1>
In-Reply-To: <ZjpBnkL2wO3QJa5W@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 23:43:15 -0700
Message-ID: <CAP-5=fX3c60v=7dt+Nryd5KqvKMU8EXz-jJAvJ=p=S_N6hJjUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf probe: Use zfree() to avoid possibly accessing
 dangling pointers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> When freeing a->b it is good practice to set a->b to NULL using
> zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
> pointer is kept somewhere, we can more quickly cause a segfault if some
> code tries to use a->b.
>
> Convert one such case in the 'perf probe' codebase.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 019fef8da6a8e60f..003a3bcebfdfc2d1 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -325,7 +325,7 @@ static void cleanup_params(void)
>         for (i =3D 0; i < params->nevents; i++)
>                 clear_perf_probe_event(params->events + i);
>         line_range__clear(&params->line_range);
> -       free(params->target);
> +       zfree(&params->target);
>         strfilter__delete(params->filter);
>         nsinfo__put(params->nsi);
>         zfree(&params);

The change is fine but params is freed here, so the potential to read
"->target" is small.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.44.0
>
