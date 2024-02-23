Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276519B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Feb 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646545; cv=none; b=GHSDNjPvTrwQzxBmlAo7nO4QD6621jNPpXHN0zbxkznG49LSdbH37yDI27a0LBWvJVo/vIzQLRZk2HivvGetsLIzM6LKO0JpZN5GkIk0TvnxqtnhTvMXxbLOv2jHtkTXhpBAuOciWPGszihQ6qTTxJeFZ5zunSwwQMqczucE3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646545; c=relaxed/simple;
	bh=e+0tBc5rl3AsuopjGEnlgHYKkTUemBC1S0uodgi3rj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff3XXxaRwVyCI57i45mbEp74mhoBqffOqlfies3CxROCB1UPfk+aJR4lHF+eRYvDySgH6r8pm7GJvkv/RpQBSoIQzq4aAPwXbq9Jo13pqngOXPHBhM6RCmB2fF0/3ekyKgKdeSR9vmqQAdhpVbVmeAu7KdjFJ5LIcbAAZP9+C9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obHVaBWm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obHVaBWm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d5ce88b51cso36135ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Feb 2024 16:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708646543; x=1709251343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKIqei624U8pNnH0un8neNQZM9OozSHq1mh1Op7pFks=;
        b=obHVaBWmN2MUW8UVZkDATg3Eh6mC8E/svZFewFXut+0YRIgCGRAES2gnH8zfUHxUp1
         cDpVN+MICjIpv1l2xiDoVBPOMlzTI8CBTV/kK/cWR4v85gjzncbe2W7UdcmmqDfgQFt2
         nZC9YnB0aFeD47dbjoq4FMNf3VaymQHRhDoqmG//EkRP2EuHGKm3Yes8QWSar+lIQkuB
         s4dp7/p9BbFk8qrg+bYyMrh4lLJw5uAePzRv5Y7+rE8rb/oO1gBrAtP4N6xWxItSOKD+
         5eVZbcafepdjCo2lV/J5QV/E4Y4xkOyc5e9OdQQ5JsEicVC7rPeiIvvkDtLQKS2EiI8V
         SiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646543; x=1709251343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKIqei624U8pNnH0un8neNQZM9OozSHq1mh1Op7pFks=;
        b=Pp4DyOOvyqL7hJ97JPbvkvaUtbmk344bWrnGH1GdpKau81vJOmpysBRafQVjdKEQpn
         sgiegyrzCqShZNERdYbAzB/khZA+G9jjP/wVFvJ2jPaxa8IT+3r6dAUNPAP9LBjEQv2d
         mhx1K7QMbydfB/yeO68OnRHFaWIJpgZFHYQVYSjhJdzWsBC9Lc8vZPQEKUPbhp0tOc5W
         6pJfv/E2dUnhbOZcFpRu9WZaRLAQKVOAPDIS66t3IOJ5FgDT3xNff+PoUKcV5IckX2ON
         9HvlKaoiVz71lwtplnDpSkoStGc+D7ZWm001D5RMJOIXZla/ONvNZCp7zWJNsTmqEceT
         QMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWW6DD/tBTdtNRAUsD1VXV2z1HxFiQIMPtEVR90K7+EbnvPUCXtWZ3GBJY905uyQTEok9hCRwnirotJZVWfT07nKCcUPUML3ugRenDMOlDvoQ==
X-Gm-Message-State: AOJu0YwjG37NGw+ngQ4d3cN+rwAQKGWKIpikrCxhbvo/D2ruGzcbgXFz
	Vcx9JNMK4KT7KJuwgwnDAp66ZeAFVkyjQk0rvGM3MrVapg2WETrEoS7BxQ8qjxv0qn2QCi4FhDd
	NFbt2laDr3pPpGWbwRbXuUo3Uq/E+llzJyYdi
X-Google-Smtp-Source: AGHT+IER6ZkSQzG0kj2Bw1ykdDF9DFfTp86VxCrkri92YG1vjri132FLxMLOD4+5Zql5MBIoVXrxSQvCBDFa7V50Cs8=
X-Received: by 2002:a17:903:4093:b0:1d9:6949:6c88 with SMTP id
 z19-20020a170903409300b001d969496c88mr606312plc.17.1708646542627; Thu, 22 Feb
 2024 16:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdepeMsjagbf1ufD@x1>
In-Reply-To: <ZdepeMsjagbf1ufD@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Feb 2024 16:02:07 -0800
Message-ID: <CAP-5=fVkA0-JMn-Xu-typJYFod-+LfyAwdUKCKEDQdQu4V_NNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf test: Use TEST_FAIL in the TEST_ASSERT macros
 instead of -1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Just to make things clearer, return TEST_FAIL (-1) instead of an open
> coded -1.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/tests.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index dad3d7414142d1be..3aa7701ee0e939f7 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -4,11 +4,17 @@
>
>  #include <stdbool.h>
>
> +enum {
> +       TEST_OK   =3D  0,
> +       TEST_FAIL =3D -1,
> +       TEST_SKIP =3D -2,
> +};
> +
>  #define TEST_ASSERT_VAL(text, cond)                                     =
\
>  do {                                                                    =
\
>         if (!(cond)) {                                                   =
\
>                 pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); =
\
> -               return -1;                                               =
\
> +               return TEST_FAIL;                                        =
\
>         }                                                                =
\
>  } while (0)
>
> @@ -17,16 +23,10 @@ do {                                                 =
                        \
>         if (val !=3D expected) {                                         =
  \
>                 pr_debug("FAILED %s:%d %s (%d !=3D %d)\n",               =
  \
>                          __FILE__, __LINE__, text, val, expected);       =
\
> -               return -1;                                               =
\
> +               return TEST_FAIL;                                        =
        \
>         }                                                                =
\
>  } while (0)
>
> -enum {
> -       TEST_OK   =3D  0,
> -       TEST_FAIL =3D -1,
> -       TEST_SKIP =3D -2,
> -};
> -
>  struct test_suite;
>
>  typedef int (*test_fnptr)(struct test_suite *, int);
> --
> 2.43.0
>
