Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C437AA86
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047381; cv=pass; b=eKUCFjLXTbr9qYYpZNTErNL9sxWbcQ2b/ryCi5C/j79a7TSJHhhL2WUYYIBFx8zFRUaqmCuNmwdzOibv4oEV51lMDF2jdynyWKo0nFHAHYSZLOl3cMESWYGT0jn/Hg2NzRTdDL+Hz0Gr+LwleWH3ZRoJj0/lKTRk4is+49PSwus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047381; c=relaxed/simple;
	bh=KGtUa5FrlwpPca3BiUMFnbkBO4v5YkdY+dx0t5fQ2F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiUKteNfCKRsJt5sREL2Hu2tmOmNgJPBHo+Dx0U+N5tjDSrn7cmn5xNY0JoYKHcigaUlblo7xcUU3xwPq6A7ESunER0YO19eSosaceTWhd1+WlQtPpnxbs+yiDe4h3smURgJa20YOSTfF70vbqIhi8TaXVWvjjY58xnrRkkTjJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjTmsuZE; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjTmsuZE"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1270fc2bdf2so3663c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774047379; cv=none;
        d=google.com; s=arc-20240605;
        b=Rd3INGDIa+1CeK1IBwU1OZ1A0+tWYruFy4B0+BlmPzA9qtsgmShiKT4XAQ8+Y+5Tkf
         vieJ8sFaQHSdyhSJBk7TlL15Sm4Au478ABFolWKuWyO9PFtVV4IOsa2eIOb1lVme4Cmm
         FSJXoc8C7nrYI6ThCxkVzY5VrRQAvX6R8fb4cak78gpq18QUFifdj+CVUSfyfgh5Wlkw
         D/caV7KLWViOtiNUnd7CcOkKv+8LHjTCEjXK487zKUUdOQSRwF5U97O6MqUlcK6fU0GX
         Jo8qcakXA48FYu2Q9TH5gRlU8pZji4sAjtvHY+sB4rj/zpU1D2CrUW62nMOkOw/74xlU
         7tRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wDIoK4iIe/AFn4cBCPuvqEDfv0HRtnfvjzHNaqr9EPQ=;
        fh=sIYCdiZm/JuJd0hgKZFhnGiRC6Lui2iQOREdc8he9YI=;
        b=ca0XjbRkbzuRKJC9u1hn9lISFFsC7lOG+DTE95IIk66LzniPkQRaD0somLWfNwicLC
         TTnJYPp6JrqVoBt/JpLK+/PSod+Ln2B6feyFI6S4CmMAXJPUtYclIy4ZEGzYq4zrq2BV
         M3li3GkDTU2zTleyzn2JCSvSviU6LNO4IgLRMXiu/+CQVMHg/ShBJO96vLMIqQOWI3sk
         VO09AZYfEszKhlPMNtlzmpFbVIYVCBdAl6tQz7RN4dKgpaYAFruPDObCxIIT+CRDh5vB
         3X0q6m9ZbRQ35O/3G/AxiWeyqxruZUJwESi2cExVl+djWXYvV9ax3PmweLXWQN+ifGAt
         oPmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774047379; x=1774652179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDIoK4iIe/AFn4cBCPuvqEDfv0HRtnfvjzHNaqr9EPQ=;
        b=ZjTmsuZEV0fgmo8aBkgIzNtJEBTk+yGAA8c1H4e3Zk8H8C1gAf1roFSO+ZOKThfrgq
         r8V8H3G+vMRRNCgBbixYzkiRbEnqz0B/FjEsc1lR67fNsTPTTBbt7aneFwHLzwu0pqcx
         QsCc77MP0zJuRA7k68apuoXZOp768NHGnd+9L7HmWNyammZZB0SaT47mBIruM8mDhVxh
         uvbRRKQVWoD7BwV/k7MBfnnm/K2oWx3JStIQxVy5Y7htLWyC5dUzRWot7lrbE/GaYxPQ
         Gy0/HQACYMNBNziGdm96C5THbXbXnlbe/afqH3ncGyZKklMaUCMlZNpJeTangBNfDt3k
         6tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047379; x=1774652179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDIoK4iIe/AFn4cBCPuvqEDfv0HRtnfvjzHNaqr9EPQ=;
        b=g2QadsU62MkP+xSxHaiVKUkkDpEx1ztUYs+F8jaDn0dKEV23afaSwXghFy0lNmic1D
         /3CwFqJdhWPnR3Mz+kkPTyAAEjOMvHFkOU2aU6Hk+erQekzLdarieh9apA2nw/7WWG5D
         9zDojt5a8HXvw9DyfjOSFp0hsb2zK82ZU8kQrRc1jMRKj9gqBV6j7lGvVJ+0eDAmq31V
         rrgxAEv62tzYB/N7kY+3Lc5PHwnFPDWh/YdN0SRH7Jm0HWQOsyUJJDESvlJ3zHnPI15t
         IYop4SE/hMu7QtFSNx/PjfGk5NU7uQVSDbuOjVYoCOdU2ss7UwCtht4h8HeTb5mKhD42
         4dhw==
X-Forwarded-Encrypted: i=1; AJvYcCXyFEaUsi4fd0jbRm5+PWjzLYCBUnhMmCw+7JGUeDJ4p7nVtdsQDUY63fgzCWAkfGH0UP2J6GcO9+hCpVv4ft8t@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfQPfWLaOQLo8G7XbiDpE8mer9AI7goFBUh3nUzGqAin7TM+T
	zdsOndBLxMvRbrg2Jc+jvHd9LTH+Fmlc3nnhRmpooeBnGnToAXipN0ZPyqjPDW8Bb2x4RbJEH3s
	45SPD3I+wRPPuO/7ktpYQ/1xOhgsY1cpvdcq66OP3
X-Gm-Gg: ATEYQzyCHYeTxjtissjPsIb8+8N3quvlFQKvJLSHxSpQJwEjnmCGg9bSyP+CNRviqQY
	GLti+TdRLxjBLmmUvczUsWtg6F33TC4X/IVGQtOda9Bf0TU4U8neXaeXHsn7drPv+bcc0HpPwVu
	tMq7xDJa2g8rmfwO8AnU5IumP8AjFf1SJBwNOb1DJY6jAawfqesSQGLxaT6KMeQ5eoFDU4yQXu7
	mjWXu07h1vCg086vfIqMIgAgPLRSsZUWZm+Cbi8btyS16DrhJ+VV9a7n+A3L+1OjEhZyz1WICl3
	aYvwWfHJ
X-Received: by 2002:a05:7022:e2a:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-12a7b04f48cmr41476c88.12.1774047378785; Fri, 20 Mar 2026
 15:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310040607.1780971-1-xiaqinxin@huawei.com>
 <20260310040607.1780971-2-xiaqinxin@huawei.com> <abMA1UTdr7k16_IK@google.com> <7f333498-4bed-4784-999f-7ee96dc63fd8@huawei.com>
In-Reply-To: <7f333498-4bed-4784-999f-7ee96dc63fd8@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Mar 2026 15:56:07 -0700
X-Gm-Features: AaiRm53gxEoECPAxCdsoLOCnv_TxxJQxqiScQKdSLAeYN-YwNO-cNkfoF_kz670
Message-ID: <CAP-5=fWxRR86FuvKM7y1trmEy3sNrt-zbxkCmVN8RekXB2rcog@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] perf: Add --pmu-filter option for filtering PMUs
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, wangyushan12@huawei.com, hejunhao3@h-partners.com, 
	jonathan.cameron@huawei.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 3:23=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
> On 2026/3/13 02:07:17, Namhyung Kim <namhyung@kernel.org> wrote:
> > On Tue, Mar 10, 2026 at 12:06:07PM +0800, Qinxin Xia wrote:
> >> This patch adds a new --pmu-filter option to perf-stat command to allo=
w
> >> filtering events on specific PMUs. This is useful when there are
> >> multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0=
).
> >>
> >> [root@localhost tmp]# perf stat -M cpa_p0_avg_bw
> >>   Performance counter stats for 'system wide':
> >>
> >>      19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 c=
pa_p0_avg_bw
> >>                   0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
> >>                   0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
> >>                   0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
> >>      19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 c=
pa_p0_avg_bw
> >>                   0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
> >>                   0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
> >>                   0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
> >>      19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 c=
pa_p0_avg_bw
> >>          75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
> >>          18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
> >>                   0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
> >>      19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 c=
pa_p0_avg_bw
> >>                   0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
> >>                   0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
> >>                   0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
> >>
> >>        19.417734480 seconds time elapsed
> >>
> >> [root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0=
_avg_bw
> >>   Performance counter stats for 'system wide':
> >>
> >>       6,234,093,559      cpa_cycles                       #     0.60 c=
pa_p0_avg_bw
> >>          50,548,465      cpa_p0_wr_dat
> >>           7,552,182      cpa_p0_rd_dat_64b
> >>                   0      cpa_p0_rd_dat_32b
> >>
> >>         6.234139320 seconds time elapsed
> >
> > Ian, can you please take a look at this?
> >
> > Thanks,
> > Namhyung
> >
> >>
> >> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Sorry for the delay.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >> ---
> >>   tools/perf/Documentation/perf-stat.txt |  4 ++++
> >>   tools/perf/builtin-stat.c              | 19 +++++++++++++++++++
> >>   tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
> >>   tools/perf/util/parse-events.c         |  2 +-
> >>   4 files changed, 37 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Docum=
entation/perf-stat.txt
> >> index 7cccc3a847d1..b72a29c9223c 100644
> >> --- a/tools/perf/Documentation/perf-stat.txt
> >> +++ b/tools/perf/Documentation/perf-stat.txt
> >> @@ -578,6 +578,10 @@ $ perf config stat.no-csv-summary=3Dtrue
> >>   Only enable events on applying cpu with this type for hybrid platfor=
m
> >>   (e.g. core or atom)"
> >>
> >> +--pmu-filter::
> >> +Only enable events on applying pmu with specified for multiple
> >> +pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
> >> +
> >>   EXAMPLES
> >>   --------
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 73c2ba7e3076..69c83a5beb71 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -1214,6 +1214,21 @@ static int parse_cputype(const struct option *o=
pt,
> >>      return 0;
> >>   }
> >>
> >> +static int parse_pmu_filter(const struct option *opt,
> >> +                       const char *str,
> >> +                       int unset __maybe_unused)
> >> +{
> >> +    struct evlist *evlist =3D *(struct evlist **)opt->value;
> >> +
> >> +    if (!list_empty(&evlist->core.entries)) {
> >> +            fprintf(stderr, "Must define pmu-filter before events/met=
rics\n");
> >> +            return -1;
> >> +    }
> >> +
> >> +    parse_events_option_args.pmu_filter =3D str;
> >> +    return 0;
> >> +}
> >> +
> >>   static int parse_cache_level(const struct option *opt,
> >>                           const char *str,
> >>                           int unset __maybe_unused)
> >> @@ -2561,6 +2576,10 @@ int cmd_stat(int argc, const char **argv)
> >>                      "Only enable events on applying cpu with this typ=
e "
> >>                      "for hybrid platform (e.g. core or atom)",
> >>                      parse_cputype),
> >> +            OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
> >> +                    "Only enable events on applying pmu with specifie=
d "
> >> +                    "for multiple pmus with same type(e.g. hisi_sicl2=
_cpa0 or hisi_sicl0_cpa0)",
> >> +                    parse_pmu_filter),
> >>   #ifdef HAVE_LIBPFM
> >>              OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
> >>                      "libpfm4 event selector. use 'perf list' to list =
available events",
> >> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgro=
up.c
> >> index 46bf4dfeebc8..89b83ca38483 100644
> >> --- a/tools/perf/util/metricgroup.c
> >> +++ b/tools/perf/util/metricgroup.c
> >> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struc=
t pmu_metric *pm, const char *p
> >>                                    const char *metric_or_groups)
> >>   {
> >>      const char *pm_pmu =3D pm->pmu ?: "cpu";
> >> +    struct perf_pmu *perf_pmu =3D NULL;
> >>
> >> -    if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
> >> +    if (pm->pmu)
> >> +            perf_pmu =3D perf_pmus__find(pm->pmu);
> >> +
> >> +    if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
> >> +       (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
> >>              return false;
> >>
> >>      return match_metric_or_groups(pm->metric_group, metric_or_groups)=
 ||
> >> @@ -1259,7 +1264,8 @@ static int build_combined_expr_ctx(const struct =
list_head *metric_list,
> >>   static int parse_ids(bool metric_no_merge, bool fake_pmu,
> >>                   struct expr_parse_ctx *ids, const char *modifier,
> >>                   bool group_events, const bool tool_events[TOOL_PMU__=
EVENT_MAX],
> >> -                 struct evlist **out_evlist)
> >> +                 struct evlist **out_evlist,
> >> +                 const char *filter_pmu)
> >>   {
> >>      struct parse_events_error parse_error;
> >>      struct evlist *parsed_evlist;
> >> @@ -1313,7 +1319,7 @@ static int parse_ids(bool metric_no_merge, bool =
fake_pmu,
> >>      }
> >>      pr_debug("Parsing metric events '%s'\n", events.buf);
> >>      parse_events_error__init(&parse_error);
> >> -    ret =3D __parse_events(parsed_evlist, events.buf, /*pmu_filter=3D=
*/NULL,
> >> +    ret =3D __parse_events(parsed_evlist, events.buf, filter_pmu,
> >>                           &parse_error, fake_pmu, /*warn_if_reordered=
=3D*/false,
> >>                           /*fake_tp=3D*/false);
> >>      if (ret) {
> >> @@ -1416,7 +1422,8 @@ static int parse_groups(struct evlist *perf_evli=
st,
> >>                                      /*modifier=3D*/NULL,
> >>                                      /*group_events=3D*/false,
> >>                                      tool_events,
> >> -                                    &combined_evlist);
> >> +                                    &combined_evlist,
> >> +                                    (pmu && strcmp(pmu, "all") =3D=3D=
 0) ? NULL : pmu);
> >>              }
> >>              if (combined)
> >>                      expr__ctx_free(combined);
> >> @@ -1471,7 +1478,8 @@ static int parse_groups(struct evlist *perf_evli=
st,
> >>              }
> >>              if (!metric_evlist) {
> >>                      ret =3D parse_ids(metric_no_merge, fake_pmu, m->p=
ctx, m->modifier,
> >> -                                    m->group_events, tool_events, &m-=
>evlist);
> >> +                                    m->group_events, tool_events, &m-=
>evlist,
> >> +                                    (pmu && strcmp(pmu, "all") =3D=3D=
 0) ? NULL : pmu);
> >>                      if (ret)
> >>                              goto out;
> >>
> >> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-ev=
ents.c
> >> index b9efb296bba5..789ff4d15e47 100644
> >> --- a/tools/perf/util/parse-events.c
> >> +++ b/tools/perf/util/parse-events.c
> >> @@ -429,7 +429,7 @@ bool parse_events__filter_pmu(const struct parse_e=
vents_state *parse_state,
> >>      if (parse_state->pmu_filter =3D=3D NULL)
> >>              return false;
> >>
> >> -    return strcmp(parse_state->pmu_filter, pmu->name) !=3D 0;
> >> +    return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) =3D=
=3D 0;
> >>   }
> >>
> >>   static int parse_events_add_pmu(struct parse_events_state *parse_sta=
te,
> >> --
> >> 2.33.0
> >>
> >
>
> Gentle ping.
> --
> Thanks,
> Qinxin
>
