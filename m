Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9DD26D
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602966; cv=none; b=Ft7TQiz8YwksWQjaOlUnjtVQiWgJqusz2tTlHyZag/Jh9rKjpSlDp2VQajKxE+kzlcddpOICHRLN00VD7UzqGlxsF3z60bnoQ0Un5ZhXoWsRlKej5ovCyRbmqxnrTlqmwAum03plG85pLPLFYONaCuMuHDw0rDBMHN5+muLMewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602966; c=relaxed/simple;
	bh=YYS8QGeRMThJRa40rT5kCbNOphhU4zs0eXwwEkUjwks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k52c1w4hv+W1ixWxmjBc3wdN/yZQkLfbRlFaygaSn9hu/dYJA80QQcVi2wPScsllFDAtxCnsWNqvSI3ETRX/cLLawUwZNChxXPMUAvFUA1A0xRE7v51mWcRjGV+hAntAN2DSJdjCLjrJvaHkTrFCYtHgJLe6zt4SrC337mWGW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eX7mTPZC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eX7mTPZC"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44024f5271dso335001cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jun 2024 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717602963; x=1718207763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btX61AmWCkAjCf2u5FJWL0PRbMFY2MMfWVQ+6vK0gD4=;
        b=eX7mTPZCLEk+SjiUv9yF44GY1EgAmYutpP0VLTxTm/XBuyNhyNUXXS/NQHyfObu5rQ
         /GbRJJORvBROOD9tBgwSnTrTV6+m3Qd7tjFx/vFG2P+ALDqIk7q8lpajAl5H2hMFluSk
         XUPfXkCXBZhFi+eoTMxgldNjSaaJW2fUso7jHizGcyCpbC6wDd6Bt8oO3VXxNEr0mzt3
         2V2MIcwMJU3BWj6O5mfi21Jp0XYgd4IQz348lFQbr1TYIwrSygIQSwR+sSX18KWLQmD6
         fqJYqavG0q+rhH4A29zGMTCif1izVuWG5ThCyu/SanPXKZQmUBg/ou2WFO4wbB06oH1b
         guCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602963; x=1718207763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btX61AmWCkAjCf2u5FJWL0PRbMFY2MMfWVQ+6vK0gD4=;
        b=ZVT9MbuRFbbXwmASkJBMrk+JjayEcbhkHb4yc0Ci7k361MEF0mj0kOs4SxxaaPBrUE
         3MI8QmN0Ckg7RicipS28mryRxBagkAq7hJYNvm8/ZhB/Mx4u0XFFh7lB4x3IeLF+yUEM
         mjMv99HkG5L1kLtM53c6HbUcVZG6qtbbB5fukkqgnHUmFV7C2MP6c6Tkr42qeSJ/khDz
         4aZeY85NolP0CYuUJs+wL+1eqdkjRfxEfhXPwAdZn8gWaIM3IijSIUeMmtvDW7bx2iRp
         cs4z0z7JjMgLy9E//AcgoG8lyd7aPgg8447AzDTpg+Ob4NBPUAbR/Vi+170onlJ3Kg1W
         sJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxFplgodKjUy4EGtam8P22K377HYkKQYTVxqVO4QmpFfFLDQGu6e7BL2up0HW/MKX6l4FebkgIyh13Zcej6VF7yWFtDjItshODJKvOCAbPAQ==
X-Gm-Message-State: AOJu0Yy2m7t4rzlaX+pRVV/SuhidqutpvfzfDT4cxGW1OBjkltMUSc96
	12d4Wm9bk/wvwb1t14UWlKGKWw1yeVlexgWnjj0LK/duMyxbhHUDXmuLR/qbkVdbE8fbovq/yY6
	4ocLpJkhkIL3eCjzE+QLMuhBkgeuTwv5w3Zh4
X-Google-Smtp-Source: AGHT+IF2ituGclZUQVgZyjra1vetAEU5cqIpN/7SgKa+p4y3RiJpbtzwgqR3s1PICs8l9kRHLP9lqRhGy/Vxf0GGYCw=
X-Received: by 2002:a05:622a:418a:b0:43f:d9b6:a93d with SMTP id
 d75a77b69052e-4402b66cd50mr4385761cf.20.1717602963385; Wed, 05 Jun 2024
 08:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605140453.614862-1-clement.legoffic@foss.st.com>
In-Reply-To: <20240605140453.614862-1-clement.legoffic@foss.st.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 08:55:51 -0700
Message-ID: <CAP-5=fUW6UWw=0iRe+r4JxrxZ3Yqnpd0_ZhrQx0SidfRDf5YgA@mail.gmail.com>
Subject: Re: [RFC PATCH] perf: parse-events: Fix compilation error while
 defining DEBUG_PARSER
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:06=E2=80=AFAM Cl=C3=A9ment Le Goffic
<clement.legoffic@foss.st.com> wrote:
>
> Compiling perf tool with 'DEBUG_PARSER=3D1' leads to errors:
>
> $> make -C tools/perf PARSER_DEBUG=3D1 NO_LIBTRACEEVENT=3D1
> ...
>   CC      util/expr-flex.o
>   CC      util/expr.o
> util/parse-events.c:33:12: error: redundant redeclaration of =E2=80=98par=
se_events_debug=E2=80=99 [-Werror=3Dredundant-decls]
>    33 | extern int parse_events_debug;
>       |            ^~~~~~~~~~~~~~~~~~
> In file included from util/parse-events.c:18:
> util/parse-events-bison.h:43:12: note: previous declaration of =E2=80=98p=
arse_events_debug=E2=80=99 with type =E2=80=98int=E2=80=99
>    43 | extern int parse_events_debug;
>       |            ^~~~~~~~~~~~~~~~~~
> util/expr.c:27:12: error: redundant redeclaration of =E2=80=98expr_debug=
=E2=80=99 [-Werror=3Dredundant-decls]
>    27 | extern int expr_debug;
>       |            ^~~~~~~~~~
> In file included from util/expr.c:11:
> util/expr-bison.h:43:12: note: previous declaration of =E2=80=98expr_debu=
g=E2=80=99 with type =E2=80=98int=E2=80=99
>    43 | extern int expr_debug;
>       |            ^~~~~~~~~~
> cc-1: all warnings being treated as errors
>
> Remove extern declaration from the parse-envents.c file as there is a
> conflict with the ones generated using bison and yacc tools from the file
> parse-events.[ly].

I encounter the same problem and routinely just do a local change to
comment out the declaration. The definition comes from the original
patch adding debug support, Commit 82ba1f2f6148 ("perf tools: Add
support for displaying event parser debug info") and so I believe
older flex/yacc tools needed the declaration. I think the right thing
to do is to remove them.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
> ---
> I don't know how bison and yacc work together.
> To me if those symbols are already generated (I don't know how), we
> should get rid of them in the source file `parse-events.c`.
> For my knowledge, if someone has the explanation of how they are
> generated, I am interested as I didn't find any link to some part of
> parse-events.[yl] files.
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: "Liang, Kan" <kan.liang@linux.intel.com>
> To: John Garry <john.g.garry@oracle.com>
> To: James Clark <james.clark@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/expr.c         | 4 ----
>  tools/perf/util/parse-events.c | 3 ---
>  2 files changed, 7 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index b8875aac8f87..b2536a59c44e 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -25,10 +25,6 @@
>  #include <math.h>
>  #include "pmu.h"
>
> -#ifdef PARSER_DEBUG
> -extern int expr_debug;
> -#endif
> -
>  struct expr_id_data {
>         union {
>                 struct {
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 6ed0f9c5581d..8d5fb05f20c2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -31,9 +31,6 @@
>
>  #define MAX_NAME_LEN 100
>
> -#ifdef PARSER_DEBUG
> -extern int parse_events_debug;
> -#endif
>  static int get_config_terms(const struct parse_events_terms *head_config=
,
>                             struct list_head *head_terms);
>  static int parse_events_terms__copy(const struct parse_events_terms *src=
,
>
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> --
> 2.34.1
>
