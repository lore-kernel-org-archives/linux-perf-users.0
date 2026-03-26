Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DE41C72
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560074; cv=pass; b=DpmgNxl0sQ3z5GuUSl+ZRcxq7jBghXCZXj2k7ah7yTkiotVYidZ59F9otPgmpd6gV/Z9UT66OhMyeXNY9LfAHMHzLtqxEf/qvluGrrSeRWi9KX8ygplDeeCPl7qEIogw3vvKBXpqaUC5EzJJEyVFHfE9PRSMc55MwP5GoeH59ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560074; c=relaxed/simple;
	bh=UMudcgpidgR/B4EPp4TDX4vK6rzSNJOcuEchVw4H1S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtUc1iiJTfy1E0LaHmdwUiPBgUoeOcJYps4cftRdN4dYWYye/b1AsuiiQqpND7dydAhEc042Aj4oDuCGmWglHeTuqV4AZfF7fjtBFXESvHLLmZ/wNuJqhRx68gI+udnm/b+fwgbUFa2iOaTxHQqCZ+d9W5DHMYCgGcfcwGAZdv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eshS2YXS; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eshS2YXS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b052562254so31945ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 14:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560072; cv=none;
        d=google.com; s=arc-20240605;
        b=PTCpw+DE8RjyHksLXrkCZmsEAKXnhwKTryioO3MTkgyRx5f6KKYvHUYI2e0XAmmM8e
         QFiF+zRnQLO06s+vklJfMvN4qXjqZkwkuhC091ezUL0720k4/XbifwKkyfZwD5p+we3z
         6nEE2DszJO1esMvZQM2QpnI/DXKvmqRRTY2095gD5abB4EK+8Zhn7mXplwFCnkjc40iQ
         zeu4ToCfQ/tgZtcs7OZaNCqAGgwvc4gSc1w/c/g9huzgv8MsHPFzLbAvRRiiHF+TSZ3s
         i0nd4shzYggyTAX2YmzT3jw4d7E0AWIZ0iPmJq8IlRLGWrt+zCPB3wq+OMhcr80p2Rwd
         jw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/24fMqVg46/TETKatrMWaUGK+Z5Aw0S1FLkXVQgfK8o=;
        fh=+QwFXimtmJ04QyXixSMMKBmOlQKZ5LLtO5ZfoOEpg/M=;
        b=KjXXYhBgZPjQAoBDg1a0RHLX+fp5l1RwhovsWLC5vGEYsm54n2PIuLL+jkakqETd8d
         dyXFTLWeB7+mi4IaNMRJLPoLrWPuLePs6kAoaR22Cmx9wSkOYwmkHHmx34aGgDJvhEMB
         ivbhkep1d49aCqw1f8EUlKvbN3J7rpCkem8YSCWfGhFHKMb2QOcU3mFXkvDFIQbH2ms8
         4oaULRcleRThzElJtskR/HLFE2zVHrITWe3ggCe21hjw2x8P7KYECojuIzpG0sB6+59h
         7wS3sCT4l4IClDv1T2g1u/PqdhnpiAhLS3S4Y6LJJyPtSOJh7/GX3BVh68YDxfXjSs6R
         qF+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560072; x=1775164872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/24fMqVg46/TETKatrMWaUGK+Z5Aw0S1FLkXVQgfK8o=;
        b=eshS2YXSJYMIIft52yhZvM3zuM++Mz2q+a6ByLLrfaiPruS8zUofWwC+s8ZDhgzr4Z
         ndE02Wc2ECsJX2lmbqlf9eAQN5OHZMvKUhvXroAdDOr2VYDtkHaXnNDFAMqBhv6u8Me0
         NU3M2aIX0lGKcwFrePU6gonTbREpalx6+DkoLGMLoe4ZYWxCOFcSzpoxperdO/tXYy+p
         AeuRK8EQE8OSiXDSbDfC6oPU2nw99K94ZcvrcVv05E8EFrWp+ZE1MpF4endSveJU9hmi
         D7HajXnemZ+CSv3nzTrJqFU63DOR/0Lf8jcnjAswFvNuWSz8TUID3wSK5s0HTz4iq1OU
         LqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560072; x=1775164872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/24fMqVg46/TETKatrMWaUGK+Z5Aw0S1FLkXVQgfK8o=;
        b=P5Kmk9fq2PnbXuzj2FoDjVXJcw1RsdY9wQcmzQAOuTVXgr4NxXLRb8QxOqB51cXae/
         I9JGEwXQOLg1JtIXtW5itXsOM8OXJq2bZZ8XcBDnmeVuTnL1wnK0HG4XwkwqoefVfpH5
         SFXG4jg77Fy1MUM/8Mq6pEPZVfizFM6weEb3+JmDviyxvxq6c3PaIgPEvRdXaM4Gss7F
         SuGq8YP+WjAI460iCH8m1go+qduy5bpXYnxT/Nxs4sdumAtWH4ZrMqxSkXTPGsB2XqXl
         Ozf5fCdcVZNtUyZI3qB4SnJwLO6qodem8E+g7cmZ3wf/5Vhn2Q8kELeN/mtXfElphyVj
         fokA==
X-Forwarded-Encrypted: i=1; AJvYcCX9lnk8/i3LL1E74EwiBMAZTwST9MOK8F1OG80iXhrE7ZHSDruquZ+QLXrXraexrnatvmQ/fqUVjeEUTUlhbYAQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6bDQNbz01+3rGCxXltsqryVzZTQow+BpM4JIonYpM/WEJhRJ
	MSOQlfwc4mo/cfFqCvdmQbWFWD25XAbXTrX+6jx7CeSGRacv/23c/d1JEAWzs+oVxtIwfRgxnWE
	RcWAI+gAJbeCOF1HZjA2FMdTuD9y9v7H0L+cQY0YF
X-Gm-Gg: ATEYQzzF21IC7hLzF6fjhesO9Yk4IaaQNUiTyULkSFbRs5l8ZdHaVK/azwr6Alrx+PE
	sYyJSqGtEbm6bQWcRXYPakhiO5ocUSivyhBtnw8NmAv9hAflsaIzsMCrvOJGZFHIuh/mDoamap4
	0Tead+PdNFltQbkZNWVCr6RK3/daO/vVCiUteO+ZJ3hHeO1nd2uYTpI40Cp8ddwpFcla+vf0tux
	qC9y2QWSR7PJO8XIehEWtoBUrperoqCqFrJLMX//iVv1QIiPdq1G+lcZR3EI6vcXXe02dYTB4t9
	Q6Uqa8ltkB7oYNe9iEQ7hOJODkIvKO4K8LTK
X-Received: by 2002:a17:902:fc50:b0:2b0:5628:b975 with SMTP id
 d9443c01a7336-2b0cd278aeamr305175ad.3.1774560071585; Thu, 26 Mar 2026
 14:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
 <20260325205914.GA356832@e132581.arm.com> <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
 <20260326163926.GB356832@e132581.arm.com>
In-Reply-To: <20260326163926.GB356832@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 14:21:00 -0700
X-Gm-Features: AQROBzCSUcEO-qMEPG-y7Gr7m_lOUShcNQHbqayDdBe6o4I8GDlT0hm9KgG1VZ0
Message-ID: <CAP-5=fUy8Y1cQUC=HzrSpAKcYyxDOjq=JZk1kdgKH9udWA+R=g@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
To: Leo Yan <leo.yan@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:39=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Mar 25, 2026 at 03:27:05PM -0700, Ian Rogers wrote:
>
> [...]
>
> > > As Arnaldo mentioned in v1, I also found Segmentation fault when
> > > testing this patch:
> > >
> > >  Program received signal SIGSEGV, Segmentation fault.
> > >  metricgroup__copy_metric_events (evlist=3D0xaaaaab037750, cgrp=3D0x0=
, new_metric_events=3D0xaaaaab038210, old_metric_events=3D0xaaaaab038d20) a=
t util/metricgroup.c:1662
> > >  1662                    evsel =3D evlist__find_evsel(evlist, old_me-=
>evsel->core.idx);
> > >  (gdb) bt
> > >  #0  metricgroup__copy_metric_events (evlist=3D0xaaaaab037750, cgrp=
=3D0x0, new_metric_events=3D0xaaaaab038210, old_metric_events=3D0xaaaaab038=
d20) at util/metricgroup.c:1662
> > >  #1  0x0000aaaaaab05870 in add_default_events () at builtin-stat.c:21=
10
> > >  #2  0x0000aaaaaab08300 in cmd_stat (argc=3D0, argv=3D0xfffffffffaa0)=
 at builtin-stat.c:2838
> > >  #3  0x0000aaaaaab40998 in run_builtin (p=3D0xaaaaaaf9d428 <commands+=
360>, argc=3D4, argv=3D0xfffffffffaa0) at perf.c:348
> > >  #4  0x0000aaaaaab40c14 in handle_internal_command (argc=3D4, argv=3D=
0xfffffffffaa0) at perf.c:398
> > >  #5  0x0000aaaaaab40ddc in run_argv (argcp=3D0xfffffffff8bc, argv=3D0=
xfffffffff8b0) at perf.c:442
> > >  #6  0x0000aaaaaab41110 in main (argc=3D4, argv=3D0xfffffffffaa0) at =
perf.c:549
> > >
> > > Last week I tested v1 and confirmed the issue was gone with the chang=
e,
> > > I will dig a bit in tomorrow and share back if any finding.
> > >
> > > Apologies for my lazy, as I should double check once Arnaldo
> > > pointed out in v1.
> >
> >
> > From the stack trace I don't see anything that should allow this.
> > Either the list of metrics is broken, or the struct metric_event's
> > evsel is NULL. But that should never happen as we wouldn't have a
> > metric at that point. The sorting shouldn't affect that. If you can
> > reproduce the issue, verbose logs may help.
>
> I believe I encountered a different issue, which is irrelevant to this
> patch.  So Breno's patch is fine for me.
>
> On one of my board, I can see the log:
>
>   Events in 'frontend_bound' fully contained within 'retiring'
>   Events in 'bad_speculation' fully contained within 'retiring'
>   Events in 'backend_bound' fully contained within 'retiring'

I looked at nvidia/t410/metrics.json but I'm not clear on where the
issue is coming from.

>
> Then, in parse_groups(), it selects fully contained list:
>
>   list_for_each_entry(n, &metric_list, nd) {
>       ...
>       if (expr__subset_of_ids(n->pctx, m->pctx)) {
>           metric_evlist =3D n->evlist;
>           break;
>       }
>   }
>
>   // As metric_evlist has been set, so below does not run
>   if (!metric_evlist) {
>         ret =3D parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier=
,
>                         m->group_events, tool_events, &m->evlist);
>         if (ret)
>                 goto out;
>
>         metric_evlist =3D m->evlist;
>   }
>
> The problem is it skips to call parse_ids() and m->pctx is not
> initialized.  This leads to pick_display_evsel() returns NULL and
> pass NULL pointer to metricgroup__lookup().   In the end, the NULL
> pointer is consumed in metricgroup__copy_metric_events().
>
> How about below change ?  I tested it which can dismiss the issue.
>
> Subject: [PATCH] perf metricgroup: Fix segment fault in
>  metricgroup__copy_metric_events()
>
> In parse_groups(), when find a event is fully contained by a previous
> event, it skips to call parse_ids(), as a result, m->pctx->ids is not
> initialized.  Then, setup_metric_events() returns an empty metric
> events, pick_display_evsel() consumes the returned metric_events and
> feeds to metricgroup__lookup() with passing "evsel =3D NULL".

Fully contained groups exist on x86, why isn't this problem breaking
whenever this happens? Stepping through "contained" examples, I see
that the ids aren't initialized. I think something else must be
happening.

> metricgroup__copy_metric_events() access old_me->evsel->core.idx, due
> to the evsel is set to NULL in metricgroup__lookup(), it causes
> segment fault.
>
> This commit corrects the fully contained case to allow it to parse IDs,
> thus this can effectively avoid setup NULL pointer in
> metricgroup__lookup().
>
> Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/metricgroup.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 7e39d469111b..528a6462876b 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1431,7 +1431,7 @@ static int parse_groups(struct evlist *perf_evlist,
>         list_for_each_entry(m, &metric_list, nd) {
>                 struct metric_event *me;
>                 struct evsel **metric_events;
> -               struct evlist *metric_evlist =3D NULL;
> +               struct evlist *metric_evlist =3D NULL, *contained =3D NUL=
L;
>                 struct metric *n;
>                 struct metric_expr *expr;
>
> @@ -1463,19 +1463,18 @@ static int parse_groups(struct evlist *perf_evlis=
t,
>                                 if (expr__subset_of_ids(n->pctx, m->pctx)=
) {
>                                         pr_debug("Events in '%s' fully co=
ntained within '%s'\n",
>                                                  m->metric_name, n->metri=
c_name);
> -                                       metric_evlist =3D n->evlist;
> +                                       contained =3D n->evlist;
>                                         break;
>                                 }
> -
>                         }
>                 }
>                 if (!metric_evlist) {
> +                       metric_evlist =3D contained ? contained : m->evli=
st;
> +
>                         ret =3D parse_ids(metric_no_merge, fake_pmu, m->p=
ctx, m->modifier,
> -                                       m->group_events, tool_events, &m-=
>evlist);
> +                                       m->group_events, tool_events, &me=
tric_evlist);

Won't this match the behavior of metric_no_merge/--metric-no-merge,
since for every metric the events for that metric are being appended
to the evlist?

Thanks,
Ian


>                         if (ret)
>                                 goto out;
> -
> -                       metric_evlist =3D m->evlist;
>                 }
>                 ret =3D setup_metric_events(fake_pmu ? "all" : m->pmu, m-=
>pctx->ids,
>                                           metric_evlist, &metric_events);
> --
> 2.34.1
