Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762333A8F7
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080844; cv=none; b=rTq3hnXU/nMeKAAjf8uGXCBaWfg8MGrwo8Xq2McgV9sKF96AexQiOZ4KDGxsu5tsCXDsjz8E60uWkVIzYpGwa44NNk6ca55EJcWZmsq393kkCTncdv5MwMOwCtWrEssg3WodBpfvw+A8xnHtfVLwsPNoCrywz2TAIQVj6bI5wwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080844; c=relaxed/simple;
	bh=1bK4xceYoYByA357PhD5sXsN2tk1OdTR+AgPIwVcXpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe/95YVScFWFLfJDmzkpHZRb0yHlA87eyNe5mtrhf/ssNgQSOBLixHHcDn6yY7iY89D20cK1h5xWm9t8Xx/utoY9Mh2S1yZ2GzUfWtXtr07RXEknUmewTGrJi9bm/HcLNLAAiDBLKtqU2ScFQFJTOcksKIiG6uUQwFlxvQX+J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3bQQ+fx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3bQQ+fx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd7509397bso115425ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080843; x=1724685643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wan00FM1q7yOGmogFWpSW4HP+41EQLUX4AG8ksduSUk=;
        b=l3bQQ+fx/XqgPTKAakOg3XcFdT882v4TkJoUQu3JlMUqAM0cA3NJC0o5ewnXTnXE5Q
         zM1MVfjlfNnGKHZjxz6Xec2Fw72QMophA6P99yVcZjTHm8k8EWh28fgg8RrHO7FX8ppR
         Q9gPs78sSra0wZIpVTvAYHNJ0SuZuGggcww/Tcl/O6UNM08WEoBgvP6nSlFcDbxBeVqf
         cBeeXo9RqL4l2SnRdYCeD/v6Wg2B4xx/iRGRafMIOSh1p3QkFjMd4nNOWfsrNnJ5uTgn
         TXUWhdVKQ2IhcJ1JYURbwCIhkoRSnvZxgxCqtkPzX8NekqEdfWWu9UwBpjICWk2Ytb29
         YcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080843; x=1724685643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wan00FM1q7yOGmogFWpSW4HP+41EQLUX4AG8ksduSUk=;
        b=bgFupYru6qdixFN0KvwDWB7g3825tE/hjy0uG+R0bMJ+xdnzEmsUkSnZMAJ9qQjCdE
         alQAuEtl3IKDkdD0OjYqoNvTBaQk1UCejanY3TEMhTnJaLLeRgX9hCUpofr1rSEkSPPr
         OR4atMMxqd1Ir095xVKVQoq/icnY+zLa4f3/fc5PYhGxz2Yx8BC3uwuKzqKDaoXwthhA
         yYOpVZVdKYw5DhCoxqBP5jQD2VY684xpQgYW4hMl9rv2GUtGaDlnfHcglQCt19Vq2bbr
         Bk8HOVdOd4SaIpgsw0DSWDI5Il0FJqBiKoRrpyLZxVhfLohtJwWem1eY8zG6ZYNOKH/M
         LSLw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4sDJ9QEJE2CrwN1SjvBqOvAQm/DDZ1iYl82ak/00JYJnQNFcJ/smo4TCL6cCfz4dfT0y+RuF+/Y4S279TYQ2vRY89MqMlVVwo/w+7Wd8xA==
X-Gm-Message-State: AOJu0Yx7PAzvZ7nO7GWzBCE0btDdOv9MvhcRFCR/BEUCh+Wi7eAbUUvL
	UZFR3r7KcAV6JdNXqaYyPwHQHiOOnfcpyP/pVp0whTdUJxCl8yWY+i9XHtpyxonFOersmYlWoHp
	Xx8taV/Zuor+/oa6hsvbBxU5f7tlMm7q4PrYpfHuqcom+yZnqzLqG
X-Google-Smtp-Source: AGHT+IEZHzB9pUM2FcW3IkCN+BmfTDKeS0sZncGmvIDoF7gO9yxCXw9YIlavVEHQIq+PSRGpZ08FXlxJ0owu80KxiHU=
X-Received: by 2002:a17:903:228e:b0:1fd:67c2:f982 with SMTP id
 d9443c01a7336-2021a42cda1mr1709875ad.2.1724080842256; Mon, 19 Aug 2024
 08:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818212948.2873156-1-namhyung@kernel.org>
In-Reply-To: <20240818212948.2873156-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Aug 2024 08:20:26 -0700
Message-ID: <CAP-5=fU52ZcPUM1QMgAQ59GOouCCJyUZOQs2H7Gt8zB32+0C1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf record: Fix sample cgroup & namespace tracking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 2:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The recent change in perf_tool constification broke the cgroup and/or
> namespace tracking by resetting tool fields.  It should set the values
> after perf_tool__init().
>
> Fixes: cecb1cf154b30 ("perf record: Use perf_tool__init()")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 39367709fd99..adbaf80b398c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2374,13 +2374,8 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>         signal(SIGTERM, sig_handler);
>         signal(SIGSEGV, sigsegv_handler);
>
> -       if (rec->opts.record_namespaces)
> -               tool->namespace_events =3D true;
> -
>         if (rec->opts.record_cgroup) {
> -#ifdef HAVE_FILE_HANDLE
> -               tool->cgroup_events =3D true;
> -#else
> +#ifndef HAVE_FILE_HANDLE
>                 pr_err("cgroup tracking is not supported\n");
>                 return -1;
>  #endif
> @@ -2406,6 +2401,8 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>         tool->mmap2             =3D build_id__process_mmap2;
>         tool->itrace_start      =3D process_timestamp_boundary;
>         tool->aux               =3D process_timestamp_boundary;
> +       tool->namespace_events  =3D rec->opts.record_namespaces;
> +       tool->cgroup_events     =3D rec->opts.record_cgroup;
>         session =3D perf_session__new(data, tool);
>         if (IS_ERR(session)) {
>                 pr_err("Perf session creation failed.\n");
> --
> 2.46.0.184.g6999bdac58-goog
>
