Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2216FC5
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841850; cv=none; b=mhsKNn8RqtGD3TRw9heVv/ZXyKOn3Ar8rYejepFrWh9zMSwvhePyLyEGuB2fkd29AM+nQxOJmV5YwkutBTlpbRWzlnKObW3XdxW7FSJxDdoq7D544MkBpY7Ojhi6kjyFHphoCpIMH4wOQS5Dh7LlY6c45k0IghTyJgFbIM5JH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841850; c=relaxed/simple;
	bh=wPV8YEoYLGqTx9bO1llFaMyCiCsTU5XfDU4kupMd/c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu6q2iCIBZ0PWM1JjO1wN/a70Zz+WNh7kQ60NSaCoPLH7l85jJsvxzWB+/3+8sHplnqGnKY7Ol8RpVPXIf8Qg5xPjk1eW983nKR/0yT7P0GDmpFWwJhGSCOKJ/5hDf+yNLKua/qKepYbKe1GAbjYvTZP4JIFftO4xDLwTSXhTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TW78uOL3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TW78uOL3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2056aa5cefcso266055ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Sep 2024 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725841848; x=1726446648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJjhNLbpnc53C/tv3mczouRD8+CJs7f+bOzNSZ5DZtA=;
        b=TW78uOL3GeTLI+Hxjui4q3GiWM5unwxfp0CbM7cgFCkzqhf5JVL3rk9eQOTHCF47Y5
         NXEzcMmUX6rfCV38Iv0lVQOeOGFY3CuH/DfT+SaSNS81+r2eTEtsx9+ArPSPduWSJwWC
         SVFumkZzfhudHieEDWSsH4z+uL9+g4Q6JYsav6LylfpBIa/nqtyB+w+n57UG3COrypw+
         jMCSstM5n9bHDMozwIC5suAmmaAHUU+KJ6+HO0sQ43X2eq0KtzULt3D+yr2Ap0HVfPWC
         qi3XnU4GpfluU0Iyk7ANcPNjNhx5+AHH2/rGSY7kz4/l59klmDBMqpguFGSMU9gz27l7
         cK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725841848; x=1726446648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJjhNLbpnc53C/tv3mczouRD8+CJs7f+bOzNSZ5DZtA=;
        b=mNWHSv48u8fqjcBXi0uIGzjYx+nqV0es/3ZYRToyYrYGdAbxeisRkf+kBZdJdP3ZSy
         lUEB02in3Dut/desYlsG6prmLOgR3Gdf6veOnp4DDzgUQ8xDrQWlbrlC479Eywe2PCus
         kwtXK3mLgIK1ZBq7pHVHYMYA0uHbggalCIAN3V+dfr12qm1/EbZJi3SA0iGuIf4YCclN
         wqYS3PPfU7pHt3uXaB/DDkBNZyE3oIfRyZ3Y5fwA+Z5PTh3AdgldMaxfW+W239M9T7+V
         HeEavKHe3fArogN1kORbtMOwuNlbvDklel36Hf3IdNOeYP1qTe9AMxikLYr5w/CEYox4
         sQTA==
X-Forwarded-Encrypted: i=1; AJvYcCXIR/PN3HmkJT5CPY3FIJDeGFlTmNpqxYy6waJkrmShYJv6mqoBO6JdXeHQIR9XRo4/GE5oQnlXQvvfOhUwuQdv@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYGuTsZZxX6JpbSbdVKTDR0aaDjzYhjMbtmCw+Jd+bzaRZe5T
	V5HFVWiFqW3oxb2zvAzNeTwfKJwKAaJy+Rm23zcrDmq09YMHzjkcWJ8XFnp6xwZK8UcX1vsY4ZO
	tCidf+2rNiIfgM5jNgozJzGVII4d9W5ZFvsGqz++Dh4kTPxQxBA==
X-Google-Smtp-Source: AGHT+IGowZzSEmTKRevgtTKEx/JN1+vLY4SrQ8bcDLX5CnwXX5QhslEZ/rC448FW8Ec5061Ba82Z65wAVG0P2JfReNo=
X-Received: by 2002:a17:902:c401:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-2070a839333mr3341795ad.12.1725841847501; Sun, 08 Sep 2024
 17:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907131006.18510-1-algonell@gmail.com>
In-Reply-To: <20240907131006.18510-1-algonell@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 8 Sep 2024 17:30:36 -0700
Message-ID: <CAP-5=fUW1z++JdFHke8X8Ou-grBRK_8rYPgd+CNjVLB9iZ5csA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix a typo
To: Andrew Kreimer <algonell@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 6:10=E2=80=AFAM Andrew Kreimer <algonell@gmail.com> =
wrote:
>
> Fix a typo in comments.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> index b2a368ae295a..0854d3cd9f6a 100644
> --- a/tools/perf/builtin-help.c
> +++ b/tools/perf/builtin-help.c
> @@ -417,7 +417,7 @@ static void open_html(const char *path)
>  static int show_html_page(const char *perf_cmd)
>  {
>         const char *page =3D cmd_to_page(perf_cmd);
> -       char *page_path; /* it leaks but we exec bellow */
> +       char *page_path; /* it leaks but we exec below */
>
>         if (get_html_page_path(&page_path, page) < 0)
>                 return -1;
> --
> 2.46.0
>
