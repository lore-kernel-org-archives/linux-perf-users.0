Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485653AC
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Oct 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434945; cv=none; b=MOuFVud03ZwVtb+977OXAf4wDdpRp205AgAHPACl8m4I/8R0OYTSi3oqWlKCKi42GFQAsHkgzGHAZ3Z4+w+q1DsViInLYFQ33Y2Pjp0F4I3PHZ95m0pjMnIwnlmQE6N4RSJNW2+VSkvifCVk4TmCJwD2ZBcO6peuFLLZi24+RmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434945; c=relaxed/simple;
	bh=Cpx7rXkTSx8ps5kFdq5cHdGaqq6HdXgYYm9h5SAMX88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/wBf05omBx7QHrLhm2SHQBclVdahdJmNZIKalffsmCH8RCIt6rIeNpbmPzE3HqByTa4Xej/GMOEO7uMxnptNoMZ7Rqe73HMJlN1mwq1uObasoBr0BlfHb/QTnFMyUqmE0ZTm7h0d+eGTbQutfOS+6h6msllEv/lXXfswJAuQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bx3FeZnd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bx3FeZnd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c5b628b7cso79165ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Oct 2024 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728434943; x=1729039743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWn47q1YdrUk3zjrW3LLzHqPpTNHpFHGg0Pnci7sCN0=;
        b=bx3FeZnd6FbVD84wfCluFoJXzxhh/c7r4Dy8QyLsdESc9/ZOXZGMgpxNRZ8Kn6SFPG
         sz3x8nNxad6WLhv7BbLfIqopJf55/qRAa8AWpRuIzw8Ib/01FleJAr5A2v5QxlXkZ+/0
         O4ElJ2tzrHjBO1dE3cvGd99JJYPsoh852UAva65cQtbb1xT4oExGWZ3IvtResCxHJWpS
         PhG6zHdG3yc0ndUJeolpy6DZBBPgwE4UO0italYSBdK3WH4fg2wqH38mqYqEXjmVwIZ9
         sbbDDmSTPaRL1Uzwo+WxX1o73xmkZjVtUfC2mBpRFSfo6fmBmKiSOXjOWP9a0YXYFNJN
         L1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728434943; x=1729039743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWn47q1YdrUk3zjrW3LLzHqPpTNHpFHGg0Pnci7sCN0=;
        b=mpHwhRvw83Qn4gn5Rb3yq4pGebTAJNCrC+bfj/s9fhfoJEoDzKI1z0JtgONfTRQHk2
         7O4J+YDn8csR6DWgKWxdaNn6Za+sf4R5jSpuXF5AWXXMTMTiyY6Q4cpfKl2Khrn28a1Y
         aVI4b78caNg10fWKmEmDk5FvBA/kSTNhOSL4nJVkxE79tzm9RInRGpkQcyxcIXdxZI8k
         Fepv2syxwVEtCgiONj6CbXp7UduzWN3YNAqMG8McbtPG1Bw0TImkP/+VjVrZNrNNeBOZ
         4jaz/48siAFlRypH1NC9IL+00O9nV4Sfc2fdIoCqb9Y0Nhtb4axLUG3Sy9mk1CB07do3
         Tqsw==
X-Forwarded-Encrypted: i=1; AJvYcCXDjknkJzq8Ui8OCKQM0rrd5Qq4Jroz65VQR1b/xPQkkr+QQHaWmpw2Q2k1CmGcQf6Km0OJvWgGfeFo1LVDd8p5@vger.kernel.org
X-Gm-Message-State: AOJu0YyKx8mMrgzzTft8dBWgAEteY6qz95oyBvD+cVChDsm49Shlptv6
	6YwdkJIPI2pzTw3DP1KGJc9/liAUagKN6HOam1duOgVRaknsc6sMega+PBK/4HsPWBWjj+RAubd
	nQNC5WmvS1tG1UuATARLuC67CtMUajsYsYnq9
X-Google-Smtp-Source: AGHT+IGfkP1c7PwtfYyG1Mr3DQyh9f2R69qD+cgCgsoIan/75MTWGHIzdiSEzFhxx0fR3MEzmxETjFf/tHN9LfiuL0g=
X-Received: by 2002:a17:902:e552:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-20c64b74322mr713885ad.5.1728434942876; Tue, 08 Oct 2024
 17:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009003938.254936-1-linux@treblig.org>
In-Reply-To: <20241009003938.254936-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 17:48:49 -0700
Message-ID: <CAP-5=fVNcMq7xjPHFE-f=LddSDz4G2cWxUGDjSuFtafVAtY6bg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove unused color_fwrite_lines
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:39=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> color_fwrite_lines() was added by 2009's commit
> 8fc0321f1ad0 ("perf_counter tools: Add color terminal output support")
>
> but has never been used.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/color.c | 28 ----------------------------
>  tools/perf/util/color.h |  1 -
>  2 files changed, 29 deletions(-)
>
> diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
> index bffbdd216a6a..e51f0a676a22 100644
> --- a/tools/perf/util/color.c
> +++ b/tools/perf/util/color.c
> @@ -93,34 +93,6 @@ int color_fprintf(FILE *fp, const char *color, const c=
har *fmt, ...)
>         return r;
>  }
>
> -/*
> - * This function splits the buffer by newlines and colors the lines indi=
vidually.
> - *
> - * Returns 0 on success.
> - */
> -int color_fwrite_lines(FILE *fp, const char *color,
> -               size_t count, const char *buf)
> -{
> -       if (!*color)
> -               return fwrite(buf, count, 1, fp) !=3D 1;
> -
> -       while (count) {
> -               char *p =3D memchr(buf, '\n', count);
> -
> -               if (p !=3D buf && (fputs(color, fp) < 0 ||
> -                               fwrite(buf, p ? (size_t)(p - buf) : count=
, 1, fp) !=3D 1 ||
> -                               fputs(PERF_COLOR_RESET, fp) < 0))
> -                       return -1;
> -               if (!p)
> -                       return 0;
> -               if (fputc('\n', fp) < 0)
> -                       return -1;
> -               count -=3D p + 1 - buf;
> -               buf =3D p + 1;
> -       }
> -       return 0;
> -}
> -
>  const char *get_percent_color(double percent)
>  {
>         const char *color =3D PERF_COLOR_NORMAL;
> diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
> index 01f7bed21c9b..aecf56dae73f 100644
> --- a/tools/perf/util/color.h
> +++ b/tools/perf/util/color.h
> @@ -39,7 +39,6 @@ int color_vsnprintf(char *bf, size_t size, const char *=
color,
>  int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list=
 args);
>  int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
>  int color_snprintf(char *bf, size_t size, const char *color, const char =
*fmt, ...);
> -int color_fwrite_lines(FILE *fp, const char *color, size_t count, const =
char *buf);
>  int value_color_snprintf(char *bf, size_t size, const char *fmt, double =
value);
>  int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...);
>  int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, .=
..);
> --
> 2.46.2
>
