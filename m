Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DD1B21AD
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376686; cv=none; b=sQL50peds+IhbBRCMmUvO2yyOBojfP2ZafJZMmbNkiTGkzuEhrrWUptuZegUUAJ4BZ5sMncewjHaWY03MkjV7iqB2aAGFRnPLkh5263HV2b8Q8B5PzO+Bo5Ud2delL6YdwQ4O7t3rpG+WW2GRUEJDDT+Sddthhuwfy6CseuukLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376686; c=relaxed/simple;
	bh=GVhqG056Vdq+Mz9grygtQVwiNYixaIhJsOQkOECDgcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO1IDbZxo0RvEQ3JsDWNewpwVmQwZgJpPcAYNHrHoNAKpM5mYVbXSedAeDVFmQDG3genvby3TmC8oE/HPx562ok6D9XmUTTEuZSTHvvoMgXfPSyJpi7l+7yWYMwxpeLj0HwdA0wED501NyXt02MjoiB7+x9A03f6YFHcGFzH65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pskOkgaG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pskOkgaG"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d147331fb5so182525ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739376684; x=1739981484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCQ/+n928Vn9gelcfMvT1zVQa+ndVs/P/rMELGvCBhg=;
        b=pskOkgaG8SXvBpishnZLWtCdK1H26atq9OZQoK/W+LTyPeq9XkQgZ4n+K0TjJDgkn2
         isBgQpH/vsP8m4XUevEFoXN9ozuoCEkG10jLAEN4HW48PEdA7LlUAHZm6FhAmBXN6Bnk
         lsubN7NVdj9ggg5RvaTosj3N386QY2ZRCiM2vsYtH9UBcaKe4meAQ8lr/TdgQGDWK+vu
         9aFnt2u705vAg86UONUgBfE6a5Av7BiyeHagK5YMqHKTVnX52V0IvwvXM4bJfsmP1juN
         UjcpDON6PUOkpKu8wxx8qWcOqTfWL5klXNdJOnqC69jRC9ze92wA366y4BpkXPg18nNs
         xLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376684; x=1739981484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCQ/+n928Vn9gelcfMvT1zVQa+ndVs/P/rMELGvCBhg=;
        b=H9wDlZ17LaE3ZQRRDNTemwrxLAByY8i1cH3kgxjvdoI5ffHx7zxKeHjsRMysVEQp67
         PQ3QdWsGiunx0ESHzPaBXeFBpv5M7e1pYpFdx/gv/Gd2OjaK0ECtDV2npAX8oe0EGszO
         y4G9vcpIYN541F3wMKpXjoeFgshxWJbTWxGrAUuht3dn6LXSvjLm+WVrY90BLtvL7g9O
         gdN9NJB1bgTZiKvw7U4fxIIIm3tSXTvdNo+9k4C/4X7bVUG1Qjm/1vZPKGUg0+J9b9K8
         yydrLmCV+24S/IyCgLkdEwp8KQr8e0GBJ/fbU5/pmev/koTBqL9c8a52FJndoOPW27TE
         J4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY/gtv5fodRIEDIHOlP63ZN2nmxpivUugluvusgH+G9hcXMwBb6xzeAzlkloKIdzENLhU4d2auF3g9kCEPqCTS@vger.kernel.org
X-Gm-Message-State: AOJu0YwpK8XEnHjYlBW78Kv8yiI5LwR1GZR2AH3vgEfZTcFtUF4pLECg
	Bx6TWXqmcKR68ZS+F5hhN9wHqlRo4KRDU55YdZTP5sxfn95b3imhncBn9L+qcLFmlc2tD19umcf
	4jfupj8DWeN3Hec7p4MceBAGe8QBp2uJ2eLEg
X-Gm-Gg: ASbGncu9plVUXTOp+xhFUBFLABAjNX1bfaZWG+GhL9bwdG6HX2tHqydj1RLdiOrjlT/
	WIyZ6PFfNHhTiNaiixJTrd9Wz/3WF4HvwDby/OoK3XdIuvjc30k7yp5CfMoAMZZKTVnnVqRnx+A
	QwgXzW57Mh6cxCAoEWZuEGvNSP
X-Google-Smtp-Source: AGHT+IFbq+WY9VzcU/yaimb94wProbxrL7HzQLktm4Pmb2CdI2atD7lBQuYnHsdbEEr4mZ8tSA1x+0qt0b1VDHmXxnY=
X-Received: by 2002:a92:cd8c:0:b0:3cf:c98a:ceba with SMTP id
 e9e14a558f8ab-3d17cdf6363mr3712565ab.22.1739376684010; Wed, 12 Feb 2025
 08:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <20250111190143.1029906-3-irogers@google.com>
 <Z6y1dbyF1xY1FvsB@x1>
In-Reply-To: <Z6y1dbyF1xY1FvsB@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 08:11:12 -0800
X-Gm-Features: AWEUYZmDXNPKvmaOfmRkYwGw5dkZIh-KEw8TBRIDz2ERpDrvTLeKvTz6iinFF40
Message-ID: <CAP-5=fVrB8hRc0-K6D001xBNr6M-xjYMOet+-tafei101achig@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] perf parse-events filter: Use evsel__find_pmu
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 6:51=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sat, Jan 11, 2025 at 11:01:35AM -0800, Ian Rogers wrote:
> > Rather than manually scanning PMUs, use evsel__find_pmu that can use
> > the PMU set during event parsing.
>
> Right, and then evsel__find_pmu() also does some extra checks to call
> pmu_read_sysfs() more selectively, right?

Right, but the pmu should already be initialized by parse_events so no
scanning should be necessary:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n759
You are right that the fall back to perf_pmus__find_by_type is more
selective in what it scans:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n302
First seeing if the PMU is already loaded then just loading the PMUs
relevant to the type number.

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 1e23faa364b1..f147e13a7017 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2406,9 +2406,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
> >  static int set_filter(struct evsel *evsel, const void *arg)
> >  {
> >       const char *str =3D arg;
> > -     bool found =3D false;
> >       int nr_addr_filters =3D 0;
> > -     struct perf_pmu *pmu =3D NULL;
> > +     struct perf_pmu *pmu;
> >
> >       if (evsel =3D=3D NULL) {
> >               fprintf(stderr,
> > @@ -2426,16 +2425,11 @@ static int set_filter(struct evsel *evsel, cons=
t void *arg)
> >               return 0;
> >       }
> >
> > -     while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL)
> > -             if (pmu->type =3D=3D evsel->core.attr.type) {
> > -                     found =3D true;
> > -                     break;
> > -             }
> > -
> > -     if (found)
> > +     pmu =3D evsel__find_pmu(evsel);
> > +     if (pmu) {
> >               perf_pmu__scan_file(pmu, "nr_addr_filters",
> >                                   "%d", &nr_addr_filters);
> > -
> > +     }
> >       if (!nr_addr_filters)
> >               return perf_bpf_filter__parse(&evsel->bpf_filters, str);
> >
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
