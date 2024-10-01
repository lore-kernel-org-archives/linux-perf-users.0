Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41E1CBEAA
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804532; cv=none; b=XoEo2T++HZx+pgwXa0Bd/SK18Z4ZDGI2yKLgQKI/XIENnaj3o3vFbLxZ3KpaGzJmPKtuOiAyM64hD6td26SICD21vjbmotVCTf6J7+o8bjmOG8dGrvK5q7g17cNnILNuABUKJWzGA1CUHLv/s5ZxnAsPIPZF9p58BNkXnJ8k4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804532; c=relaxed/simple;
	bh=zW5KV8ZRwmjfWWswWoMCjQ0afxU/ksOKQ/4mdv7ZxL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TL6qHwvbgwlQtZidPPh0w9gXSjSBUX6glhrVRY30LC76oqH588cAP9MFMNWyFKjntipeK4VvdyD/bOB0xa+hVkcsTE2/p/ZR13BPyx/Yr1dQxTBp+6rkBmK2GWgBrBdJbOLoHd++bgtBudlMKH/++5nAwxI/qs/2smsA6HX2WbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxy2F251; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxy2F251"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b061b7299so13165ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727804530; x=1728409330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jj30EJtZ5WxgXrHQ/WJ4/hPDyRIandsUeefNdO7SQM=;
        b=kxy2F251C76xzzHxkF0dnnLv2p7RvDfb40RhOCCyxdC3gnBjuLL/bFDkOk6RQ77qaD
         /b4yOvRJgWoqftlUs4TU1NegrRvBZ1rKBi9Ion+LyvLiM7GoPVyxYvltY1nJHXnngdq6
         GzvHzFXS06puW8WdPtsdMONhpqYrzlLP9q1B/T/H4IJ33w5UBlp0LB4A7W7sNSEQB5OT
         F/YhBEF+TzitjLMt7R5TUnL7wCgntsW+RfP4oFrshYLHKCJvLC8R+e34QNHJSTA2cba5
         m7YwLv1ZmuomCQYCGT+33z9xp7EJMtIEiXNmaCgizjMtF//yu1cwG5jLl32pR0fE4a/t
         Qp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804530; x=1728409330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Jj30EJtZ5WxgXrHQ/WJ4/hPDyRIandsUeefNdO7SQM=;
        b=bmkSJVXhuR6urw8aDRVxpAa+ePq3BaTICX+2inDAovnTVvLoj113ynqiutkghAVFQp
         JnwmGk2OHPLgjFmQaOXI5jgsJ/mlvXDLRnEvwRy04TTgg0CWPrzfW6iuXVvB4Vdgzo7T
         HcbCBUA3BtQ0Lre3+VxsGNZKIDofl60kSPxwz1no/OxhcoM+hTdu3Sl4FsLrNdexNM+5
         ynEkOYNt3+lt4ZUoSzksmXgbYjywRRcYgu+BH+wc7wbKyYaE8Kz+oUHamjsb55OwsXHM
         tLgCO4SuA80ZaUrBVr5elFv9f7lYROB/09wKVEsFeRqJy5MF4riFXXmKXHvOPmtBSDeV
         5ysg==
X-Forwarded-Encrypted: i=1; AJvYcCVLqD9rRvRagk/y8r/7983yqyx4bbepw0TWQlhCtv2zmkZc7tPHQoPy/gxQzOw9sW2Xli1SUXHugEWRAkM4j/wG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g4JkmCOwDlusucsgUrrnFYTZiGdusCRUuY5vcoimzNaUNvI4
	/jxV4q9y8oKYvYT9pF1aUj0s07C48JdHxJNiJJrXXvYFjCgZevtlJx9aSpdlNaHNmRoYvTshWPb
	p7tqLD+cd9VBf97Rjcsh2nIzUfxkkDyAX4Lf0
X-Google-Smtp-Source: AGHT+IG5ORqB0lYAZbuxHAuQKXbl7IkWQxu+L+QOqPVZTLw7LHJWx3rPs3pXlvXyhp4JfYFYA3h2SoddLOPJm+tCf+Q=
X-Received: by 2002:a17:903:120d:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-20bb07eb0d9mr2916195ad.7.1727804528347; Tue, 01 Oct 2024
 10:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-2-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:41:54 -0700
Message-ID: <CAP-5=fXiaHAEGc4GsBXQBPjKsQnj4iT5eod6nY1_Qw1gHMhi4Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf tools: Add fallback for exclude_guest
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> changed to parse "cycles:P" event instead of creating a new cycles
> event for perf record.  But it also changed the way how modifiers are
> handled so it doesn't set the exclude_guest bit by default.
>
> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
> if not.  Let's add a fallback so that it can work with default events.
>
> Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 18 +++++++++++++++---
>  tools/perf/util/evsel.c   | 21 +++++++++++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1521b6df26065ccf..fd9ea15f6b1c0809 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>          * (behavior changed with commit b0a873e).
>          */
>         if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
> -           errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
> -           errno =3D=3D ENXIO) {
> +           errno =3D=3D ENOENT || errno =3D=3D ENXIO) {
>                 if (verbose > 0)
>                         ui__warning("%s event is not supported by the ker=
nel.\n",
>                                     evsel__name(counter));
> @@ -658,7 +657,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>                 if (verbose > 0)
>                         ui__warning("%s\n", msg);
>                 return COUNTER_RETRY;
> -       } else if (target__has_per_thread(&target) &&
> +       } else if (target__has_per_thread(&target) && errno !=3D EOPNOTSU=
PP &&
>                    evsel_list->core.threads &&
>                    evsel_list->core.threads->err_thread !=3D -1) {
>                 /*
> @@ -679,6 +678,19 @@ static enum counter_recovery stat_handle_error(struc=
t evsel *counter)
>                 return COUNTER_SKIP;
>         }
>
> +       if (errno =3D=3D EOPNOTSUPP) {
> +               if (verbose > 0) {
> +                       ui__warning("%s event is not supported by the ker=
nel.\n",
> +                                   evsel__name(counter));
> +               }
> +               counter->supported =3D false;
> +               counter->errored =3D true;
> +
> +               if ((evsel__leader(counter) !=3D counter) ||
> +                   !(counter->core.leader->nr_members > 1))
> +                       return COUNTER_SKIP;
> +       }
> +
>         evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
>         ui__error("%s\n", msg);
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index da0bada62140d9b0..0ddd77c139e89a2e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3259,6 +3259,27 @@ bool evsel__fallback(struct evsel *evsel, struct t=
arget *target, int err,
>                 evsel->core.attr.exclude_kernel =3D 1;
>                 evsel->core.attr.exclude_hv     =3D 1;
>
> +               return true;
> +       } else if (err =3D=3D EOPNOTSUPP && !evsel->core.attr.exclude_gue=
st &&
> +                  !evsel->exclude_GH) {
> +               const char *name =3D evsel__name(evsel);
> +               char *new_name;
> +               const char *sep =3D ":";
> +
> +               /* Is there already the separator in the name. */
> +               if (strchr(name, '/') ||
> +                   (strchr(name, ':') && !evsel->is_libpfm_event))
> +                       sep =3D "";
> +
> +               if (asprintf(&new_name, "%s%sH", name, sep) < 0)
> +                       return false;
> +
> +               free(evsel->name);
> +               evsel->name =3D new_name;
> +               /* Apple M1 requires exclude_guest */
> +               scnprintf(msg, msgsize, "trying to fall back to excluding=
 guest samples");
> +               evsel->core.attr.exclude_guest =3D 1;
> +
>                 return true;
>         }
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>
