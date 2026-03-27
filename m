Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A363BE173
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594354; cv=pass; b=AMLzUatdHrp/LgUYfHDQKTT6p7CYmajpq4J6LYufn/NtBfKVs0qZMn4d0aHbI3eg89A1w2nGa7xTJ0OIC5QGYWKwjQTEJwZEpF75vr3cQa5m3XhaHIzw04exMfQ2Ix33iidHf09WuCiTgPy4wwegfQo62uIUK+C0NuHBLB1PECQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594354; c=relaxed/simple;
	bh=idLLkaWfMo2JacyBK0NOV5rUIlWlpmD28AqIihhcHms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvMaiYE0kkvWoLqeZUXcgFp41xOzQ5Mp9nBv+2hMhNbPh4MAiFwFR+oe4pOEj1FODEyD4ndtRSpYu+VFpqyeueNssEvoA3C6DfBtVgyf/FA4IQkyqmc5j8/49uSNcifbAfrrcmN+oktPFQ8A8c4qfmZ0Fpjb8ExoM0BZG4dOOMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhUksrAt; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhUksrAt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052562254so65005ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 23:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774594345; cv=none;
        d=google.com; s=arc-20240605;
        b=icRTCfWHH9VM97h5eG9V0MGToSC2a04wgkmzMExSMua5BxmOMUJMpuU9DQQUvY0ekB
         0qhHgj/vcwFAcUMUENvhdIkQW4FbgaVSVnMPHJaLXeLKOcrijGKR0ttGPMtGWStB0El2
         dkkvOQbSnV2Wy3Rgp2+N9FtreaeHTc/TOFfVA9v268zwmm2Xim+Lbxn6zQ7v731NmIWo
         drPJW+CLVPwsgdd3NNSF7lQz4/C9SSXQC4QBxWmt+Mz077vjFA+bHV5sbZr1NbKyd4/z
         xo5D7RoStsqZC6GVZjEyGfojxH9v4/IbMGF08WPr4YA0honUp/XcvOHbqB5nSudaYtC1
         MLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=759cP7FZaQCCYim248z6j3XhWP9k59fb5gpeGXx8YiA=;
        fh=sWVRWdu8a+sASeNbbZyXIg+j3i9gPun+CNzKOsTfPmo=;
        b=asyoxLF8830M65mU+Q0fVE/VgOTv7z8lr7YB/scTpMm1av+voPyzAudxqdvg66QTID
         6GR1T+yKXZHULE+T1zPjtHqlC+2aBbIlyWXU88q4SDz34PanH4n1/zk+uVPaqfoVbSm/
         8H+OegLqKUzPvxO0Jh7sK5tIdlZFmDVpykOXlrot+apwzDHzUa3xpKG4D+F+PjV2zqyY
         mW1IKRpltRc6aV8lLK24PT7mec61mfoq+1F2kWie74oBkNGfE+eEw1X3O1IfE2/4Wvvw
         P1EFx8wuoeZ1Kw3/VxZquKz+uGhkqc6SJmSbnP/TlhTv1QCn9ltujcb/QfCsEWCXFDuz
         mwJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774594345; x=1775199145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=759cP7FZaQCCYim248z6j3XhWP9k59fb5gpeGXx8YiA=;
        b=WhUksrAtDgkSzKBJrohf66xe/OKRQaZjkek/RI2TSyPLOaPqgjhf0QVqmKy8OzDVZY
         2dnlX4EwhMnTVIRMw79VcAQvqtWt6iNvl29d6fzJ8RdsD5O04U3iWtNvOVfO+yi4w6N9
         KuDrJXjMsKV7gqyK98bcL1YBywcyw6zfUFaWb3RpNVGpM9mMnIINI9splqLoF9Ig1CCd
         WZ76Cu/k1m0nyfs8VD71L8QGZNV1QsHJBXx0mdj8DMCTArJJlb/yhj3V1JIW8+kk6+hE
         2FgPjTtyI9byIMNnGcPawx+5EfCaJ9gFPzuEl5OSGB7ASK4JVVhoZ3W8wqgPSiX5Ykkx
         0bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774594345; x=1775199145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=759cP7FZaQCCYim248z6j3XhWP9k59fb5gpeGXx8YiA=;
        b=gLKSmELYLqXLu/v4XVypfTUtOA88lOSKQ+SvwaP1bnaMPcQnqG3PYuUnPHqCCe8KrI
         HB15aR+nlyiDdpSkPZ7qv6PrJsb5l+OGxcPqhwK5MiSrGCooU+E3cX0ikZ6P0b9Nhnu8
         YpdDvk+12pAR9NDvJD5smdnTNi6GbMHZbDhi4WnD8NqngR4lZKOUEipgoMU++5hZFOwK
         /mb5pVxGXVwRNCeAulm64uHtBnIxk9dSXTNnBblGqnvnGS/iZwFyEBjNkDveQJ3YYCDj
         XWtdbkIbd62Mh9fdFfwjXTmaD1bkZ9V25q9L0ANBjUMNTuIAelh1mw8XHnr/zUn2yVdE
         QAvA==
X-Forwarded-Encrypted: i=1; AJvYcCXi2mMI2SBLAMzJwkU4mbhLSZ7he7qNsTCZMEHaun5LwAZxtMxRY+plNMnuppbdFAXKWdh4so3msu53NGr7SjmR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XFUQeifqFb1qNKBBSvguVF7wMyVuFKI5xHGmOF/5Kk0Xc4on
	Vu/u8fyxwFfqb7L38nT3ZFDyAdTsW+ua1GaOTwYqlFP4Fq6Q6oos63tYR2JKsBpkdyKTlvQDtAO
	TccRFxSOJn6BIJnXsaLylV1o1L49zEg70plkPVU5v
X-Gm-Gg: ATEYQzynwr/2nqz1m+9zvQB8Yd4D/hRMU5quvl4reD5+l0rG7zZNx5vXxEgM6fySvf6
	ugee5BwykQJsc+q+brWxGVQakvZnhueXK20Kc8v3Q7OTvt2UhSaswfG0e/RY3u/KPZ/BivrJdYe
	wuyeXWrXcT3/UfPW/V4NIJs4jdv1R/mxZkLSMcAbnPPn/IUSfOgbEatw52LssjNLZcGbR8pUu7x
	7Ssn/JV+Jvh/5EfYEOUWs0Adr19o2BJxL9Z5ALTWyDb2Dm5/WQXHlLBibdCnrPKNqAyI18Mnpsb
	5qrklmFN
X-Received: by 2002:a17:903:2352:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2b0cc2f2e16mr2247435ad.20.1774594344438; Thu, 26 Mar 2026
 23:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310040607.1780971-1-xiaqinxin@huawei.com>
 <20260310040607.1780971-2-xiaqinxin@huawei.com> <abMA1UTdr7k16_IK@google.com>
 <7f333498-4bed-4784-999f-7ee96dc63fd8@huawei.com> <CAP-5=fWxRR86FuvKM7y1trmEy3sNrt-zbxkCmVN8RekXB2rcog@mail.gmail.com>
 <3ff48829-1168-4efd-84e1-dfffa99dcf98@huawei.com>
In-Reply-To: <3ff48829-1168-4efd-84e1-dfffa99dcf98@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 23:52:13 -0700
X-Gm-Features: AQROBzBd3fMXxz3YtMRxA9VmK5_1jLGQ5QybF3bkG5NRQLYdwDSUCpF-wunQb44
Message-ID: <CAP-5=fVD3z27hYAje2pZK4C_R9FbFof2oV0ATz=n-CTMzNuyrw@mail.gmail.com>
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

On Thu, Mar 26, 2026 at 11:41=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> =
wrote:
>
>
>
> On 2026/3/21 06:56:07, Ian Rogers <irogers@google.com> wrote:
> > On Thu, Mar 19, 2026 at 3:23=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >>
> >>
> >> On 2026/3/13 02:07:17, Namhyung Kim <namhyung@kernel.org> wrote:
> >>> On Tue, Mar 10, 2026 at 12:06:07PM +0800, Qinxin Xia wrote:
> >>>> This patch adds a new --pmu-filter option to perf-stat command to al=
low
> >>>> filtering events on specific PMUs. This is useful when there are
> >>>> multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cp=
a0).
> >>>>
> >>>> [root@localhost tmp]# perf stat -M cpa_p0_avg_bw
> >>>>    Performance counter stats for 'system wide':
> >>>>
> >>>>       19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.0=
0 cpa_p0_avg_bw
> >>>>                    0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
> >>>>                    0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
> >>>>                    0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
> >>>>       19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.0=
0 cpa_p0_avg_bw
> >>>>                    0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
> >>>>                    0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
> >>>>                    0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
> >>>>       19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.3=
1 cpa_p0_avg_bw
> >>>>           75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
> >>>>           18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
> >>>>                    0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
> >>>>       19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.0=
0 cpa_p0_avg_bw
> >>>>                    0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
> >>>>                    0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
> >>>>                    0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
> >>>>
> >>>>         19.417734480 seconds time elapsed
> >>>>
> >>>> [root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_=
p0_avg_bw
> >>>>    Performance counter stats for 'system wide':
> >>>>
> >>>>        6,234,093,559      cpa_cycles                       #     0.6=
0 cpa_p0_avg_bw
> >>>>           50,548,465      cpa_p0_wr_dat
> >>>>            7,552,182      cpa_p0_rd_dat_64b
> >>>>                    0      cpa_p0_rd_dat_32b
> >>>>
> >>>>          6.234139320 seconds time elapsed
> >>>
> >>> Ian, can you please take a look at this?
> >>>
> >>> Thanks,
> >>> Namhyung
> >>>
> >>>>
> >>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >
> > Sorry for the delay.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
>
> Hi Namhyung!
>
> Ian has already provided Reviewed-by. Could you please apply this
> patch if everything looks good to you? :-)
>
> --
> Thanks,
> Qinxin

Hi Qinxin,

I see it queued up on tmp.perf-tools-next:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/?h=3Dtmp.perf-tools-next
which is where patches are tested prior to landing in perf-tools-next :-)

Thanks,
Ian

> >>>> ---
> >>>>    tools/perf/Documentation/perf-stat.txt |  4 ++++
> >>>>    tools/perf/builtin-stat.c              | 19 +++++++++++++++++++
> >>>>    tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
> >>>>    tools/perf/util/parse-events.c         |  2 +-
> >>>>    4 files changed, 37 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Doc=
umentation/perf-stat.txt
> >>>> index 7cccc3a847d1..b72a29c9223c 100644
> >>>> --- a/tools/perf/Documentation/perf-stat.txt
> >>>> +++ b/tools/perf/Documentation/perf-stat.txt
> >>>> @@ -578,6 +578,10 @@ $ perf config stat.no-csv-summary=3Dtrue
> >>>>    Only enable events on applying cpu with this type for hybrid plat=
form
> >>>>    (e.g. core or atom)"
> >>>>
> >>>> +--pmu-filter::
> >>>> +Only enable events on applying pmu with specified for multiple
> >>>> +pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
> >>>> +
> >>>>    EXAMPLES
> >>>>    --------
> >>>>
> >>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>>> index 73c2ba7e3076..69c83a5beb71 100644
> >>>> --- a/tools/perf/builtin-stat.c
> >>>> +++ b/tools/perf/builtin-stat.c
> >>>> @@ -1214,6 +1214,21 @@ static int parse_cputype(const struct option =
*opt,
> >>>>       return 0;
> >>>>    }
> >>>>
> >>>> +static int parse_pmu_filter(const struct option *opt,
> >>>> +                       const char *str,
> >>>> +                       int unset __maybe_unused)
> >>>> +{
> >>>> +    struct evlist *evlist =3D *(struct evlist **)opt->value;
> >>>> +
> >>>> +    if (!list_empty(&evlist->core.entries)) {
> >>>> +            fprintf(stderr, "Must define pmu-filter before events/m=
etrics\n");
> >>>> +            return -1;
> >>>> +    }
> >>>> +
> >>>> +    parse_events_option_args.pmu_filter =3D str;
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>>    static int parse_cache_level(const struct option *opt,
> >>>>                            const char *str,
> >>>>                            int unset __maybe_unused)
> >>>> @@ -2561,6 +2576,10 @@ int cmd_stat(int argc, const char **argv)
> >>>>                       "Only enable events on applying cpu with this =
type "
> >>>>                       "for hybrid platform (e.g. core or atom)",
> >>>>                       parse_cputype),
> >>>> +            OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
> >>>> +                    "Only enable events on applying pmu with specif=
ied "
> >>>> +                    "for multiple pmus with same type(e.g. hisi_sic=
l2_cpa0 or hisi_sicl0_cpa0)",
> >>>> +                    parse_pmu_filter),
> >>>>    #ifdef HAVE_LIBPFM
> >>>>               OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
> >>>>                       "libpfm4 event selector. use 'perf list' to li=
st available events",
> >>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricg=
roup.c
> >>>> index 46bf4dfeebc8..89b83ca38483 100644
> >>>> --- a/tools/perf/util/metricgroup.c
> >>>> +++ b/tools/perf/util/metricgroup.c
> >>>> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const str=
uct pmu_metric *pm, const char *p
> >>>>                                     const char *metric_or_groups)
> >>>>    {
> >>>>       const char *pm_pmu =3D pm->pmu ?: "cpu";
> >>>> +    struct perf_pmu *perf_pmu =3D NULL;
> >>>>
> >>>> -    if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
> >>>> +    if (pm->pmu)
> >>>> +            perf_pmu =3D perf_pmus__find(pm->pmu);
> >>>> +
> >>>> +    if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
> >>>> +       (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
> >>>>               return false;
> >>>>
> >>>>       return match_metric_or_groups(pm->metric_group, metric_or_grou=
ps) ||
> >>>> @@ -1259,7 +1264,8 @@ static int build_combined_expr_ctx(const struc=
t list_head *metric_list,
> >>>>    static int parse_ids(bool metric_no_merge, bool fake_pmu,
> >>>>                    struct expr_parse_ctx *ids, const char *modifier,
> >>>>                    bool group_events, const bool tool_events[TOOL_PM=
U__EVENT_MAX],
> >>>> -                 struct evlist **out_evlist)
> >>>> +                 struct evlist **out_evlist,
> >>>> +                 const char *filter_pmu)
> >>>>    {
> >>>>       struct parse_events_error parse_error;
> >>>>       struct evlist *parsed_evlist;
> >>>> @@ -1313,7 +1319,7 @@ static int parse_ids(bool metric_no_merge, boo=
l fake_pmu,
> >>>>       }
> >>>>       pr_debug("Parsing metric events '%s'\n", events.buf);
> >>>>       parse_events_error__init(&parse_error);
> >>>> -    ret =3D __parse_events(parsed_evlist, events.buf, /*pmu_filter=
=3D*/NULL,
> >>>> +    ret =3D __parse_events(parsed_evlist, events.buf, filter_pmu,
> >>>>                            &parse_error, fake_pmu, /*warn_if_reorder=
ed=3D*/false,
> >>>>                            /*fake_tp=3D*/false);
> >>>>       if (ret) {
> >>>> @@ -1416,7 +1422,8 @@ static int parse_groups(struct evlist *perf_ev=
list,
> >>>>                                       /*modifier=3D*/NULL,
> >>>>                                       /*group_events=3D*/false,
> >>>>                                       tool_events,
> >>>> -                                    &combined_evlist);
> >>>> +                                    &combined_evlist,
> >>>> +                                    (pmu && strcmp(pmu, "all") =3D=
=3D 0) ? NULL : pmu);
> >>>>               }
> >>>>               if (combined)
> >>>>                       expr__ctx_free(combined);
> >>>> @@ -1471,7 +1478,8 @@ static int parse_groups(struct evlist *perf_ev=
list,
> >>>>               }
> >>>>               if (!metric_evlist) {
> >>>>                       ret =3D parse_ids(metric_no_merge, fake_pmu, m=
->pctx, m->modifier,
> >>>> -                                    m->group_events, tool_events, &=
m->evlist);
> >>>> +                                    m->group_events, tool_events, &=
m->evlist,
> >>>> +                                    (pmu && strcmp(pmu, "all") =3D=
=3D 0) ? NULL : pmu);
> >>>>                       if (ret)
> >>>>                               goto out;
> >>>>
> >>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-=
events.c
> >>>> index b9efb296bba5..789ff4d15e47 100644
> >>>> --- a/tools/perf/util/parse-events.c
> >>>> +++ b/tools/perf/util/parse-events.c
> >>>> @@ -429,7 +429,7 @@ bool parse_events__filter_pmu(const struct parse=
_events_state *parse_state,
> >>>>       if (parse_state->pmu_filter =3D=3D NULL)
> >>>>               return false;
> >>>>
> >>>> -    return strcmp(parse_state->pmu_filter, pmu->name) !=3D 0;
> >>>> +    return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) =
=3D=3D 0;
> >>>>    }
> >>>>
> >>>>    static int parse_events_add_pmu(struct parse_events_state *parse_=
state,
> >>>> --
> >>>> 2.33.0
> >>>>
> >>>
> >>
> >> Gentle ping.
> >> --
> >> Thanks,
> >> Qinxin
> >>
