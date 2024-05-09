Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C8149C63
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232887; cv=none; b=sq/PIj/+6nGMwvjyCokYScdDopNoQUuDUJbB0swOqcHATMp473GMZMMoC31tv/W6aiBwaeaThFCYd0ar86F1UL1E6Mx/98kxv9Zf8TK9JTumvaRxOF5v1UErhbliTUgVx0h4+xlXbsCqNgqG5dyVnqtUhaDR5NNqrnYDTM2j44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232887; c=relaxed/simple;
	bh=Yu/FlxoSX005QeAc+0Wxq9eAC3c4jYlWWcvVDh/Q3xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rzx3KNudKUpDnw3sNAkjdNdcfVC+E78D4U3qlviLyuePAV/WfW+jhIWzDA6IAmVhkkOaBjHLSqCoadJ28t4ETww9YipD92xDqdRtO2Kmyx73dI0DZBzELIOKHhy1swC6Ffgk7HgThV99yDvbFKpIp9AA7W0XgDbEhzhLFBCrQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TF00JlCf; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TF00JlCf"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-439b1c72676so206911cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 22:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232885; x=1715837685; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBu2+kmhThCqDtxFPgm069ky4hbWhjdpfaVsKApxqFU=;
        b=TF00JlCfbTYkykR5n5zK6Y83QnzGSlMMvq9SnwPlDtdq1HwG+KumRzV/KdMUVksVKP
         3VAyI6+KHJ84dbSsXQYm97Z2Wm3qsrjiRmNoPFAU/DrxpzxyRDgl2xgDUxmebrhPC/ZI
         J20a6B4SCdivE3YGzsnM0WZcm01CQXZZZCkHfnwEC8FjuTYhXHPdOE8JOoczIU3FXkzW
         vr9DuQ02n5Jmjmwf3yTHfNvgmLT76gdZrTHtB/E8NkdPOKI40gEPXIEqKrbPDWRbVizl
         L1M/Updb5NxdU9yZOQvJVXVlCLbQ3F6ZrJ/YBlWILUHBm6U3nyYK2l23AcPK57FWiRiB
         sRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232885; x=1715837685;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBu2+kmhThCqDtxFPgm069ky4hbWhjdpfaVsKApxqFU=;
        b=Dgn+hdx+GU3e49JYXB4femRJ1jeIN4Dk+e6ALW2rKTqvscGhOfLxcElc+kGPY2V+ho
         BgYx/CmzAegRujjXUHveXObPEhAwCShj55IWtEk16B1HG/FHRGMNM8XLIHXQGY6vjiJi
         6IlyncRMYeIerVMgtTNb4nIkjk17BPSGD+CTNlt7JUD3BeQL9pEJl8wheFE228OPvMAD
         b1ZAmTGRfksD1DuGnUjjcw3kj3Xir73W+Ea/dfOTnMKv2eOp3qMGqz7V3wY41FUcIXrv
         Zd6q3+I3kTqCmOCd7UQJqVS/He9Nv3AMsTis8D5fl55LTnQDlqDh2BcGpq8T/1x4Blys
         vIgw==
X-Forwarded-Encrypted: i=1; AJvYcCXmVvpQxIt17wnsm9eiKPdwx734i3Iolbhl5K74rWbQiL/4D2A+Xcab6F6jCiuROTWhyApAxrRz/r4L0skXuEf8GEKMSw6JYM6nf+b94t403g==
X-Gm-Message-State: AOJu0YxMsxsDckmlRfP801PBgUHzgEx5L/Q+ohJLBBRqukreCQdZ0hxx
	rQNx+YjxOvepnVMAGA/q8EITiEdIQE1GPoYb/ubpiL5qWxAMtXmrysOYsWN6V80rz0+6+ezdjga
	Q7Y/oVemtKebthUIbctF+FGLI+82s3DLAK3tm
X-Google-Smtp-Source: AGHT+IGaK7Rirp/cZH/CG/NQkJa3l//MoK0bZoUqv56E8q8HA0NLz3QmbZgxTBXtvlKFnxFS6uOdeXp85bNMcb8psmM=
X-Received: by 2002:a05:622a:1c18:b0:43d:f69d:cf3a with SMTP id
 d75a77b69052e-43df69dd298mr568601cf.8.1715232884994; Wed, 08 May 2024
 22:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509052015.1914670-1-irogers@google.com>
In-Reply-To: <20240509052015.1914670-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 22:34:33 -0700
Message-ID: <CAP-5=fW=qV=ZdU5qpfXE_E0+tU_kmcVeGC6M38nbm+Px=2aWPw@mail.gmail.com>
Subject: Re: [PATCH v1] libsubcmd: Fix parse-options memory leak
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> If a usage string is built in parse_options_subcommand, also free it.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sorry, belated:
Fixes: 901421a5bdf6 ("perf tools: Remove subcmd dependencies on strbuf")

Thanks,
Ian

> ---
>  tools/lib/subcmd/parse-options.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-op=
tions.c
> index 9fa75943f2ed..d943d78b787e 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -633,11 +633,10 @@ int parse_options_subcommand(int argc, const char *=
*argv, const struct option *o
>                         const char *const subcommands[], const char *usag=
estr[], int flags)
>  {
>         struct parse_opt_ctx_t ctx;
> +       char *buf =3D NULL;
>
>         /* build usage string if it's not provided */
>         if (subcommands && !usagestr[0]) {
> -               char *buf =3D NULL;
> -
>                 astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_=
name, argv[0]);
>
>                 for (int i =3D 0; subcommands[i]; i++) {
> @@ -679,7 +678,10 @@ int parse_options_subcommand(int argc, const char **=
argv, const struct option *o
>                         astrcatf(&error_buf, "unknown switch `%c'", *ctx.=
opt);
>                 usage_with_options(usagestr, options);
>         }
> -
> +       if (buf) {
> +               usagestr[0] =3D NULL;
> +               free(buf);
> +       }
>         return parse_options_end(&ctx);
>  }
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
