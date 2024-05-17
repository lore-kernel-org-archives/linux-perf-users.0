Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF671A2C24
	for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957590; cv=none; b=UBZNY/9cKhybwlzCh4cKgipLkw8Pu371FHOQW4xJe+qYlWNt2oBDN9M97xsZ8Bbowuxb73n4lytPdTdopQfoY8njoMZJiLrrSRkoJwfhlpqjY39GB3wo2undO53vTWEAnXqiyVFRDldnrRTTGi63qUjIAI/d7BNT+f+0GNsp6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957590; c=relaxed/simple;
	bh=hD7Js7fBPmWXFc/aKxb0FtlBOgYC1Bgag5yDVzV8HxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTtUinOCv5vOpCr9Vallo6agyQB+ztfvoTVAQpRiJTqpTDDDZQdLU04r9K/JScj+DQC4G8ZLEgatikRKTa8Yf3Srn5FZdzCDUSez+hbbJdFgpjq9CZsvhPuwN3Zy+EBe0ziCG1TJec++3Zj1l14cOvNz6fgbYd9kmtwpkMWfhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yddje5Wk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yddje5Wk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso117615ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 May 2024 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715957588; x=1716562388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9yEPEdR0yXbjHGQafZygTyo16CLvwcifYer1hkc9ds=;
        b=yddje5WkABXqisFafWAaJm24PWsTZQo2A1jUk7Hcl1HsybEJ46jUuNzuf/0jS/ZEK5
         YG6LeYpxHi9Pzo3S/GUv6VX7/zqMpUWTvZ/8SdvYu9JxRuV7A0Wpuqf7Xo6yQ3uFIpWz
         qtu5IH27kwTx93MBwX4eidGuHDgaFswH28EurB7YHT7gkROJJw3nMa+wi7jM5h/4dlBV
         jc5JUcqXbVPffSyf88Xg5AEOZJ3TG+s8xpRvKuqSooz0at9IRcd6RbDjp9ctioMAXsv9
         Lc0SuP1ca3FNq+5DUGJC+PYGC1/oleYxMkabE4T64Bzr0vb0oGTLxI7DSONCfsqwG6mP
         5E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957588; x=1716562388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9yEPEdR0yXbjHGQafZygTyo16CLvwcifYer1hkc9ds=;
        b=uNn0GMRojsgLAFg959ydRXp1Vj5SxZsXy1M943QVKbo+RAQhrX+5FaXu9dYx9boSmb
         aQOYL+oUeqnqK7HY9avnV8pfvHMciGXR/4VnI4XbpCfFdqeVM0agXDidOG/lSTpYmv7a
         K1RqIx41WMoSZ3vPfY6bUl1FPG7slo1VVy2vy5v9xvj5oMEVe9OoxTMveBh92DY/ysmm
         1BJI0I57yABKDoqfTIPgGau435o4eKGn5bhVMxSh9QfGy0BrV/OOBcGXH3cU2UKAoCH0
         KfxSi7iO6zT7t+qklbVU8xN4V+FsXIgg5XySVpEtzMvPmngrXiBNGxLKTealdiST1lcU
         k3GA==
X-Forwarded-Encrypted: i=1; AJvYcCUJij1qYCN0/4BtaTWnKVitqKdf7InB4v+BTZOvetAGPoDuy3Rqwp5lZeESNMfbgGyCtJmwAiY+wsEMtCp/090KkjmBa3KnAGg+vb6eZ4KpHQ==
X-Gm-Message-State: AOJu0YyVVgYkrKzIRzrCnsStEgX46kw2Yl4NrXdq4+KPDqpDXPu+9Iw6
	ua/bo0xnEhFoszz23LXg4yeaz47Xz63wCqGvM1BuTcpBNuDoWF+dVYJtDO90y+WNJcDyC+698aH
	yW90g+ZQs9Pzcs7wacIA9Z9Xcgcn1VdcKn+ga
X-Google-Smtp-Source: AGHT+IF+/u2t53nDO6K/rA8Xe7gJaCE3VNU49gFdYsvsDWLEBS847TpdyGT3nwc+jPtWDJVK6rNrJ9QPz6Rm8D91qv8=
X-Received: by 2002:a17:902:eec6:b0:1e9:4b4:907b with SMTP id
 d9443c01a7336-1f2e04a8fd9mr2374155ad.6.1715957588299; Fri, 17 May 2024
 07:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517141427.1905691-1-leitao@debian.org>
In-Reply-To: <20240517141427.1905691-1-leitao@debian.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 May 2024 07:52:47 -0700
Message-ID: <CAP-5=fX__BCcvxoykxz1b8LB5tuVzO+JjX8+xpiO4vfcdArUuQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf list: Fix the --no-desc option
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 7:14=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Currently, the --no-desc option in perf list isn't functioning as
> intended.
>
> This issue arises from the overwriting of struct option->desc with the
> opposite value of struct option->long_desc. Consequently, whatever
> parse_options() returns at struct option->desc gets overridden later,
> rendering the --desc or --no-desc arguments ineffective.
>
> To resolve this, set ->desc as true by default and allow parse_options()
> to adjust it accordingly. This adjustment will fix the --no-desc
> option while preserving the functionality of the other parameters.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changelog:
>
> v4:
>         * Revert the change in json_print_event() from v3.
> v3:
>         * Applied the same logic to default_print_metric() and
>           json_print_event() functions, as identified by Ian Rogers.
> v2:
>         * Do not print desc if long_desc is being printed, as identified
>           by Ian Rogers.
> ---
>  tools/perf/builtin-list.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 02bf608d585e..24a136ea015e 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -149,7 +149,11 @@ static void default_print_event(void *ps, const char=
 *pmu_name, const char *topi
>         } else
>                 fputc('\n', fp);
>
> -       if (desc && print_state->desc) {
> +       if (long_desc && print_state->long_desc) {
> +               fprintf(fp, "%*s", 8, "[");
> +               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> +               fprintf(fp, "]\n");
> +       } else if (desc && print_state->desc) {
>                 char *desc_with_unit =3D NULL;
>                 int desc_len =3D -1;
>
> @@ -165,12 +169,6 @@ static void default_print_event(void *ps, const char=
 *pmu_name, const char *topi
>                 fprintf(fp, "]\n");
>                 free(desc_with_unit);
>         }
> -       long_desc =3D long_desc ?: desc;
> -       if (long_desc && print_state->long_desc) {
> -               fprintf(fp, "%*s", 8, "[");
> -               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> -               fprintf(fp, "]\n");
> -       }
>
>         if (print_state->detailed && encoding_desc) {
>                 fprintf(fp, "%*s", 8, "");
> @@ -243,15 +241,14 @@ static void default_print_metric(void *ps,
>         }
>         fprintf(fp, "  %s\n", name);
>
> -       if (desc && print_state->desc) {
> -               fprintf(fp, "%*s", 8, "[");
> -               wordwrap(fp, desc, 8, pager_get_columns(), 0);
> -               fprintf(fp, "]\n");
> -       }
>         if (long_desc && print_state->long_desc) {
>                 fprintf(fp, "%*s", 8, "[");
>                 wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
>                 fprintf(fp, "]\n");
> +       } else if (desc && print_state->desc) {
> +               fprintf(fp, "%*s", 8, "[");
> +               wordwrap(fp, desc, 8, pager_get_columns(), 0);
> +               fprintf(fp, "]\n");
>         }
>         if (expr && print_state->detailed) {
>                 fprintf(fp, "%*s", 8, "[");
> @@ -491,6 +488,7 @@ int cmd_list(int argc, const char **argv)
>         int i, ret =3D 0;
>         struct print_state default_ps =3D {
>                 .fp =3D stdout,
> +               .desc =3D true,
>         };
>         struct print_state json_ps =3D {
>                 .fp =3D stdout,
> @@ -563,7 +561,6 @@ int cmd_list(int argc, const char **argv)
>                 };
>                 ps =3D &json_ps;
>         } else {
> -               default_ps.desc =3D !default_ps.long_desc;
>                 default_ps.last_topic =3D strdup("");
>                 assert(default_ps.last_topic);
>                 default_ps.visited_metrics =3D strlist__new(NULL, NULL);
> --
> 2.43.0
>
