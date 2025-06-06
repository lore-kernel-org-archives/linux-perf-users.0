Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0822370C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Jun 2025 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253827; cv=none; b=BbHCNi6n7Ub1bttSzKKzZdwzeIlIlEWChdeCWuFsjTPAiPLSYsZ4y+4f2QXiwfFfuzPSFSqEH2NPB4iIjaArMg7JekR5I1TkT8lh5Ju6HgrcR92ijlQoFe67n1wmtXgmt1SmPzaAbw36RqjoGOUcS1FgU+3KwdJqL33z6rs0KCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253827; c=relaxed/simple;
	bh=qgLVzVHqwMZZp0/6vIV+4twi+QsbO9Ln1ejEYkOJn0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0H8gM+FrHgSxc1PwwvuFlSei5NqmJoqgVhmn+2Ip8RbfYYg0sBVrNmQvC4AtoaKf4etUl/kwi7g5hV6CjMvZij9ODg+kVNBzZyfaTfYHev2gLt8dsFfOY7kcoex/arAuxQHlAa55g2zIrdW7DW/lLfqkJHHpQYyIeze5/bqrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4N3/QKeC; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4N3/QKeC"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so32505ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749253825; x=1749858625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NrKuPVOAgVlDradO2tZCYPdZ7gLvHH91CefMR0KcV4=;
        b=4N3/QKeCeLdMXSwrmopxM0brGJoMchHSlwkEt7K/eXOD4uQP19HlCEimeNsBmqNdWX
         NWAypMpFStGeWmT951VUScN0Z0Sko0IFeQkTiorbfQn7uzdSdQQRMSb5F99EEGqIpJ6b
         XWjkw0qyhmvt5H0HDC8KWBS6zys6pxUv7PZNfkqDtIp1cMPi+rBIM+2WVXLW/cSS5lkX
         678hJqwMXvOajiYu4qBV9VphRY0u5et16quLSFLo41/tFi8A/vdon6YfMm5ZhlF9F913
         MrZmqh3FHExqFeLX1WUYR9AcN1ZOsgBCr45N9slw20ZPdag0tk1N8jrwpCQPAFJ7KKN8
         yFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253825; x=1749858625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NrKuPVOAgVlDradO2tZCYPdZ7gLvHH91CefMR0KcV4=;
        b=t6biW9l2rdTHBjW1XZPzMhEAP7KqAQcP9GmfYHcWhgAmEAnVGwggZzJgar+pB2ybwl
         kssnxVcGl6PfJ1wzFgrJ7UrdwQxKU5TsbfdPxUDtUsNmCCGQtPyptKR0QSgjz3cYvxcs
         crXGrX6App9LeJP8NTSOkNeUW6Y12N945zn6ePNefzC4pcd9nCBB+Dgkbj8gk2eV/BVm
         iLAt7sFLt910it2OQc16XQDd5XYUiy2f1qFDnWbimKj4g016FnZbbk9Gqg3ODWyXPl1r
         D0BehJSNprl4nlAWlWKPqSjOgBAYxOFjnFDcfh7qutHLC7Tf0+Ytr3uI2Nw8aiJTU3wm
         NXMA==
X-Forwarded-Encrypted: i=1; AJvYcCUYPiLDlMFan89MVuOSy/9YmvhGTjDAvELj86vD3bvrObwIdflRvRJSx9FmcsP0qMsXvgte15OyX1LRXILb5cXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyiImVFZxIGaQgPz1qPm0aCA0kGO8dFw9glj56kATyN12LsVEBV
	/7UrW9XFGPDD5awiFAXSi1vFXLLP1M7o04Aurn749Mg0RMdKgN1BWCW99fLPVyjtTHMrYi8JFxF
	Km3PQJt1j88fUZ39K32/bBy79cTLkY2RSusQneE7e
X-Gm-Gg: ASbGncu+PFtSar0PCdee2TfK3SlDVU8h7DKLZi5MH2HGd8Q+nqDDIY+FdUJS0oZKNup
	zE8v/nZ88v5jRIa4CtR8SSWqlnA87c4LfKxuddIZUo3mOLcLkj7hTL2PCVMa+uEVALR9Mdv95+t
	IM9UtHp8J8EKJXGfnBOg8dcU7P7gbzuDNLtLkcUO+CW4SrHsHcsHKct3Y=
X-Google-Smtp-Source: AGHT+IFP6IB3jawCekdQQp1ibv14IA5iNzo+g/QJdK28PhCsvpxw9LCEU6L/zsYtwWIygyUyaWMQaHGajBo4rmrvNCM=
X-Received: by 2002:a05:6e02:148d:b0:3dd:d66d:2a01 with SMTP id
 e9e14a558f8ab-3ddd801dd3dmr586025ab.27.1749253824983; Fri, 06 Jun 2025
 16:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606225431.2109754-1-namhyung@kernel.org>
In-Reply-To: <20250606225431.2109754-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Jun 2025 16:50:13 -0700
X-Gm-Features: AX0GCFt-m-xrnXtELZf5a27xbr7rP2J2mf_kQ1Ii4QJVbXy9Z_Ea8kbS8tH6AZQ
Message-ID: <CAP-5=fVoQXwFFdqY7ne0ZLJk+aTzm9knHqgVbvhJtb44doqe-g@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Set default GH modifier properly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Commit 7b100989b4f6bce7 ("perf evlist: Remove __evlist__add_default")
> changed to use "cycles:P" as a default event.  But the problem is it
> cannot set other default modifiers correctly.
>
> perf kvm needs to set attr.exclude_host by default but it didn't work
> because of the logic in the parse_events__modifier_list().  Also the
> exclude_GH_default was applied only if ":u" modifier was specified -
> which is strange.  Move it out after handling the ":GH" and check
> perf_host and perf_guest properly.
>
> Before:
>   $ ./perf kvm record -vv true |& grep exclude
>   (nothing)
>
> But specifying an event (without a modifier) works:
>
>   $ ./perf kvm record -vv -e cycles true |& grep exclude
>     exclude_host                     1
>
> After:
> It now works for the both cases:
>
>   $ ./perf kvm record -vv true |& grep exclude
>     exclude_host                     1
>
>   $ ./perf kvm record -vv -e cycles true |& grep exclude
>     exclude_host                     1
>
> Fixes: 35c8d21371e9b342 ("perf tools: Don't set attr.exclude_guest by def=
ault")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Code is more understandable than before and reads as correct.

Reviewed-by: Ian Rogers <irogers@google.com>

Perhaps consider adding test coverage in tools/perf/tests/parse-events.c ?

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 7f34e602fc080881..d1965a7b97ed6b97 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1830,13 +1830,11 @@ static int parse_events__modifier_list(struct par=
se_events_state *parse_state,
>                 int eH =3D group ? evsel->core.attr.exclude_host : 0;
>                 int eG =3D group ? evsel->core.attr.exclude_guest : 0;
>                 int exclude =3D eu | ek | eh;
> -               int exclude_GH =3D group ? evsel->exclude_GH : 0;
> +               int exclude_GH =3D eG | eH;
>
>                 if (mod.user) {
>                         if (!exclude)
>                                 exclude =3D eu =3D ek =3D eh =3D 1;
> -                       if (!exclude_GH && !perf_guest && exclude_GH_defa=
ult)
> -                               eG =3D 1;
>                         eu =3D 0;
>                 }
>                 if (mod.kernel) {
> @@ -1859,6 +1857,13 @@ static int parse_events__modifier_list(struct pars=
e_events_state *parse_state,
>                                 exclude_GH =3D eG =3D eH =3D 1;
>                         eH =3D 0;
>                 }
> +               if (!exclude_GH && exclude_GH_default) {
> +                       if (perf_host)
> +                               eG =3D 1;
> +                       else if (perf_guest)
> +                               eH =3D 1;
> +               }
> +
>                 evsel->core.attr.exclude_user   =3D eu;
>                 evsel->core.attr.exclude_kernel =3D ek;
>                 evsel->core.attr.exclude_hv     =3D eh;
> --
> 2.50.0.rc0.604.gd4ff7b7c86-goog
>
