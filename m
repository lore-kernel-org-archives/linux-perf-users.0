Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B123126D0
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966287; cv=pass; b=FRigiNIVmZTXFEOKWxt0mYEW98ftsY5hhF9DWbIQrg4164Za3RFpnV4cIaKHoNDoFl++GZic1IQoH2SxajDNY+CDvFGAodeNjQfCI9oAS6mUHnuMa9Tdm7G3u1sCwBTALj5zHEjMIPenY5PN2drNn9tDV0FciwX0HpQS2oolo14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966287; c=relaxed/simple;
	bh=tU2wetNuFXrySycDfpJGAm3Xu//gTJGwS6mzX1Yj9GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzc+/9bvmqW4LtdFMVpIRHvUzpC6LLn2Rt4M14EzPLchO2nCwoE4sMMwifY4u+nZVMxXJ5h441tQ7TMi+aDh8QKSSSXcrYvjrcLOxReBW2iSjtZQ+LUkR510RaDmuOyaSJonqAK+B8FdvEihtvq3neJ0IEwYzfrr3EEeUebsHMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SE2D1MmZ; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SE2D1MmZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d06cfa93so31975ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 19:31:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768966273; cv=none;
        d=google.com; s=arc-20240605;
        b=aTViz2ch5/zWW2JciOkt5hlOLzC0RLIbtdCwe7YlRgaZzFMImKb58MoNo9v6thFFAM
         T5Woa8Myr51rdijgx9D8ik8uQfbcA5HeGXqFUJ2PUpd/hfjM+zQBUO/uTJeBRSKDBMAa
         3eE5m6wM4hOrFPITuaCYV6q8iTrhca5nVgIDg/oT1K57DjbxKBDHPTmTH28camyFg3Wt
         ZELyCjj7L4sN6QN2pzLN71KFW0oSG291b/LqPSdc+A5K408ROzlE8Nfg23S36wrPo4o/
         HX2Gza82oT06ZdsZSgf3B70GWAZGcKsjJ0vuAy1PNeZLm3nxJJ4MN1EStcs9ycIRS5c0
         I9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X80m1RntJbUUGHxvxGJOEe8uR7U4pBpm1/TaZEJoJTc=;
        fh=xuPUNXHXpOQsRNp8QVtv38vI6XsZgASxWAXpMLj6K/8=;
        b=YNBOoRLLvGdG2tQJF0f48FRKkqe2vtIg8uCXsuimfNIq/yGX/+6ZdcgDtz7qyyF0PC
         t0/kkXqDcXMFG5qnCcA/iQS2rWTaCjl+nMRX99KBZtmJRrMTQnGd0VOvI1M9pNFwz2GL
         nBTpMfd43mOKyH2pgHD4UAJJ0wCT2bLMgvyXfo5j09rrodBtkBHrDIJCEXi2JeEReXVT
         f4NkmR/3jR9JGNSNCKuFH04rZmZKVBPwn8cyKgvpPhVRWFAYl/MhAhF7igfxcySCV2Hm
         Yk6PnX6yOEZnJ75zOrDNCqeAwDWMFkdgcnj10cyyF1lwx+zZA2VNXhXRrGlSnwDyg/Jq
         40bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768966273; x=1769571073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X80m1RntJbUUGHxvxGJOEe8uR7U4pBpm1/TaZEJoJTc=;
        b=SE2D1MmZmqiW+ok6sze8pTfMWRmwh7swvRK0R/dmYJz/UCSfF3W6y+uyu7Ie2Lk1J8
         NPizdYZSPN8NRAt+H2mHXPq5NiW/7ZLdyZbL98kuQUcWFNfHW0FvbHrYwRfv9fyRyB9Q
         PWIVlIN0hPNoUD/jEJehxvKsreuE0K0hVFmLvioNGZy+AhVZNJqWy8ee3LBpgj2apS+L
         Zf+t8S5YmK1wEpGJi7XSvTS8hCdbFwJru8BMYNrlFUUjusermhA3/aRHeHAiRcQe5dhq
         66EmjSnBJX3IvsxhdWMvbQfiicHdkFKOHM89gvgRi2+0qE4I6CdnW9iR5F7a23A+LGui
         kTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768966273; x=1769571073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X80m1RntJbUUGHxvxGJOEe8uR7U4pBpm1/TaZEJoJTc=;
        b=buZ3l8sEK9HfdMjxiV4chYTJtx7YYS9wwEZ+Xw1ucEUQn5awNZP0uoqZdFs3CfnypW
         Cj7juqLchDv7uwaA+4CjwxLbO8Pak9Q5z264lm1gmQIcVkb7wieRCifC2orn1b5v+dYG
         mTE96ZMyZqVWYqp2E0Mux177Z9uIApR00Y/7XmYQlRLJMPIgfvQCkLv82Ap85WPe5las
         H3bU7M4ROzT5zcWI3ffbFpQPSXuwYU8/v1VfYeBuG0QjhVsHV819S7UbRJhjWxArnYbL
         0a31GC73uPVttJBWCyuETMoP+Nn4gz11FxtbuBaBMQAS0L8UD1LV/iY9qt1KL4XeJANr
         tpSw==
X-Forwarded-Encrypted: i=1; AJvYcCUcoTmFGZYljM6WYu0CEgIoCaJxv5XwaYTYnlrJo/pjlaNHPYyVGZlZTNFXsUH3eebF+Xmw4J53bDAvy6+a48lO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9noCig4UbtTUCC48qR/k+Givc/K698kOO2DDViLYOXlElb2lS
	fIF2DIpWzoxke0PD6ZjWlnc222o8iCfYz5GLn5bC+qShT2PboTBmPozqseZksvOz2N864D+H+R5
	UG1P5crrnHv9hmebUpSOeYtjvvYmXZro4vNaW7tAT
X-Gm-Gg: AZuq6aIgQvghnBZomtyEIUEMZ3VcyuVzANuuTdO2aCBVl3UjYCbGjLRde78T/EzMNhv
	GTbU2l/TyOgELNbofphVlNyD9JUGSnOWDxrzPoLgQqXn/9/zNmQ3AiQzn0eMJ35cTyRwhNRHgJ/
	InKVvXqgoPpSL7rS9OFmRC1T+9KM5wrNclIUUMLGzL+wJ1q1r2OYnW7KEI9UcdVHHq7dVxQS2Jl
	hENGfkPooyMHNuTgO+LDB8GnzgSQNJF7bIAg6SyH4aLgaRcHsofvXTt+V46GGSE6c7N6LTT
X-Received: by 2002:a17:902:d2d2:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-2a7a243e2b7mr1096765ad.7.1768966273210; Tue, 20 Jan 2026
 19:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120095058.2778834-1-xiaqinxin@huawei.com>
 <CAP-5=fVHMeWP3Ct_uOwYw4XKNdK7-eR=tbbUOFHwTdCVwBCZVg@mail.gmail.com> <b53c62a5-a752-436a-b039-cdc82b055fdd@huawei.com>
In-Reply-To: <b53c62a5-a752-436a-b039-cdc82b055fdd@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 19:31:01 -0800
X-Gm-Features: AZwV_Qg3JSDX_fl_47e5ghYvBXf6o3LykIWtUcjluyjkTE4yoJlIwpn_B5nDBPA
Message-ID: <CAP-5=fWdOv4TYHHm18-jKYP9++gEEBvTtA=5H=H3qG3iT6S8yg@mail.gmail.com>
Subject: Re: [RFC PATCH] perf: Add --uncorepmu option for filtering uncore PMUs
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, wangyushan12@huawei.com, hejunhao3@h-partners.com, 
	jonathan.cameron@huawei.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 7:15=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2026/1/21 04:55:30, Ian Rogers <irogers@google.com> wrote:
> > On Tue, Jan 20, 2026 at 1:51=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >>
> >> This patch adds a new --uncorepmu option to perf-stat command to allow
> >> filtering events on specific uncore PMUs. This is useful when there ar=
e
> >> multiple uncore PMUs with the same type (e.g. hisi_sicl2_cpa0 and
> >> hisi_sicl0_cpa0).
> >>
> >> eg:
> >> [root@localhost tmp]# ./perf stat -M cpa_p0_avg_bw
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
> >> [root@localhost tmp]# ./perf stat --uncorepmu hisi_sicl2_cpa0 -M cpa_p=
0_avg_bw
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
> > So normally for this case the -A/--no-merge will give you a per-PMU
> > breakdown. It isn't restricted to a single PMU like the output here,
> > but we similarly don't have options to restrict per-socket, per-dir,
> > per-cluster and per-core. There is an option with --per-cache but that
> > looks like a way to avoid having many --per-cache options rather than
> > taking a value for a particular cache to only dump.
> >
> > I did deliberate make the --cputype code generic so it could be used
> > in ways like this, but it'd be nice to glob match the names for
> > consistency with event parsing:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/pmu.c#n2647
> > I needed to have --cputype as Intel's early hybrid patches had added
> > it before I cleaned things up to be more PMU oriented.
> >
> Hello, Ian!
>
> For core-related events and metric, we usually care about which core it
> happens on, so we can filter it with -C.
>
> Such as:
>
> [root@localhost ~]# perf stat -C 0 -e L1-dcache-loads sleep 3
>
>   Performance counter stats for 'CPU(s) 0':
>
>             136,578      L1-dcache-loads
>
>
>         3.099147550 seconds time elapsed
>
> [root@localhost tool]# ./perf stat -C 0 -M l1d_miss_rate sleep 3
>
>   Performance counter stats for 'CPU(s) 0':
>
>              18,708      L1-dcache-load-misses            #      3.6 %
> l1d_miss_rate
>             513,038      L1-dcache-loads
>
>
>         3.004649800 seconds time elapsed
>
> For core-independent events and metrics such as ddrc, smmu, and cpa, we
> care about which hardware module they occur. (The example provided in
> commit info is sicl.) so we want to filter it by pmu, for events I can
> filter it with'cputype' (This is a little strange because sicl does not
> belong to any cputype.). However, metric does not support this mode.
>
> [root@localhost ~]# perf stat --cputype hisi_sicl0_cpa0 -e cpa_cycles
> sleep 3
>
>   Performance counter stats for 'system wide':
>
>       3,003,492,731      cpa_cycles
>
>
>         3.003484270 seconds time elapsed
>
>
> [root@localhost ~]# perf stat --cputype hisi_sicl0_cpa0 -M
> cpa_p0_wr_dat sleep 3
>
> Cannot find metric or group `cpa_p0_wr_dat'
>
> This patch supports the metric scenario through '--uncorepmu'.
>
> > So I can see the purpose of this patch in being low overhead compared
> > to -A, I'm just not sure whether this is a PMU or an aggregation
> > option. I also think the term "uncore" is kind of confusing and so
> > have tried to keep it away from command line options. Why isn't is it
> > just a pmu filter?
> >
> > Thanks,
> > Ian
> >
> Perhaps we could make cputype a little more generic so that it could
> also include pmu-filter functionality.

Yeah, that'd been my intention quite a while ago. I wanted to hide the
cputype flag and replace it with something like --pmu-filter. Looks
like I never got around to writing the patch though :-) I agree the -C
filtering is similar to this and similarly different to how the
aggregation code is working. Could we rename --uncorepmu to
--pmu-filter then?

Thanks,
Ian

> >> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >> ---
> >>   tools/perf/Documentation/perf-stat.txt |  4 ++++
> >>   tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++=
++
> >>   tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
> >>   3 files changed, 43 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Docum=
entation/perf-stat.txt
> >> index 1a766d4a2233..9c0952b43a57 100644
> >> --- a/tools/perf/Documentation/perf-stat.txt
> >> +++ b/tools/perf/Documentation/perf-stat.txt
> >> @@ -573,6 +573,10 @@ $ perf config stat.no-csv-summary=3Dtrue
> >>   Only enable events on applying cpu with this type for hybrid platfor=
m
> >>   (e.g. core or atom)"
> >>
> >> +--uncorepmu::
> >> +Only enable events on applying uncore pmu with specified for multiple
> >> +uncore pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
> >> +
> >>   EXAMPLES
> >>   --------
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index ab40d85fb125..3f34bfc79179 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -1235,6 +1235,28 @@ static int parse_cputype(const struct option *o=
pt,
> >>          return 0;
> >>   }
> >>
> >> +static int parse_uncorepmu(const struct option *opt,
> >> +                          const char *str,
> >> +                          int unset __maybe_unused)
> >> +{
> >> +       const struct perf_pmu *pmu;
> >> +       struct evlist *evlist =3D *(struct evlist **)opt->value;
> >> +
> >> +       if (!list_empty(&evlist->core.entries)) {
> >> +               fprintf(stderr, "Must define uncorepmu before events/m=
etrics\n");
> >> +               return -1;
> >> +       }
> >> +
> >> +       pmu =3D perf_pmus__pmu_for_pmu_filter(str);
> >> +       if (!pmu || pmu->is_core) {
> >> +               fprintf(stderr, "--uncorepmu %s is not supported!\n", =
str);
> >> +               return -1;
> >> +       }
> >> +       parse_events_option_args.pmu_filter =3D pmu->name;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int parse_cache_level(const struct option *opt,
> >>                               const char *str,
> >>                               int unset __maybe_unused)
> >> @@ -2579,6 +2601,10 @@ int cmd_stat(int argc, const char **argv)
> >>                          "Only enable events on applying cpu with this=
 type "
> >>                          "for hybrid platform (e.g. core or atom)",
> >>                          parse_cputype),
> >> +               OPT_CALLBACK(0, "uncorepmu", &evsel_list, "uncore pmu"=
,
> >> +                       "Only enable events on applying uncore pmu wit=
h specified "
> >> +                       "for multiple uncore pmus with same type(e.g. =
hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
> >> +                       parse_uncorepmu),
> >>   #ifdef HAVE_LIBPFM
> >>                  OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
> >>                          "libpfm4 event selector. use 'perf list' to l=
ist available events",
> >> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgro=
up.c
> >> index 25c75fdbfc52..59ef71df20bd 100644
> >> --- a/tools/perf/util/metricgroup.c
> >> +++ b/tools/perf/util/metricgroup.c
> >> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struc=
t pmu_metric *pm, const char *p
> >>                                        const char *metric_or_groups)
> >>   {
> >>          const char *pm_pmu =3D pm->pmu ?: "cpu";
> >> +       struct perf_pmu *perf_pmu =3D NULL;
> >>
> >> -       if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
> >> +       if (pm->pmu)
> >> +               perf_pmu =3D perf_pmus__find(pm->pmu);
> >> +
> >> +       if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
> >> +          (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu))=
)
> >>                  return false;
> >>
> >>          return match_metric_or_groups(pm->metric_group, metric_or_gro=
ups) ||
> >> @@ -1260,7 +1265,8 @@ static int build_combined_expr_ctx(const struct =
list_head *metric_list,
> >>   static int parse_ids(bool metric_no_merge, bool fake_pmu,
> >>                       struct expr_parse_ctx *ids, const char *modifier=
,
> >>                       bool group_events, const bool tool_events[TOOL_P=
MU__EVENT_MAX],
> >> -                    struct evlist **out_evlist)
> >> +                    struct evlist **out_evlist,
> >> +                    const char *filter_pmu)
> >>   {
> >>          struct parse_events_error parse_error;
> >>          struct evlist *parsed_evlist;
> >> @@ -1314,7 +1320,7 @@ static int parse_ids(bool metric_no_merge, bool =
fake_pmu,
> >>          }
> >>          pr_debug("Parsing metric events '%s'\n", events.buf);
> >>          parse_events_error__init(&parse_error);
> >> -       ret =3D __parse_events(parsed_evlist, events.buf, /*pmu_filter=
=3D*/NULL,
> >> +       ret =3D __parse_events(parsed_evlist, events.buf, filter_pmu,
> >>                               &parse_error, fake_pmu, /*warn_if_reorde=
red=3D*/false,
> >>                               /*fake_tp=3D*/false);
> >>          if (ret) {
> >> @@ -1417,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evli=
st,
> >>                                          /*modifier=3D*/NULL,
> >>                                          /*group_events=3D*/false,
> >>                                          tool_events,
> >> -                                       &combined_evlist);
> >> +                                       &combined_evlist,
> >> +                                       (pmu && strcmp(pmu, "all") =3D=
=3D 0) ? NULL : pmu);
> >>                  }
> >>                  if (combined)
> >>                          expr__ctx_free(combined);
> >> @@ -1472,7 +1479,8 @@ static int parse_groups(struct evlist *perf_evli=
st,
> >>                  }
> >>                  if (!metric_evlist) {
> >>                          ret =3D parse_ids(metric_no_merge, fake_pmu, =
m->pctx, m->modifier,
> >> -                                       m->group_events, tool_events, =
&m->evlist);
> >> +                                       m->group_events, tool_events, =
&m->evlist,
> >> +                                       (pmu && strcmp(pmu, "all") =3D=
=3D 0) ? NULL : pmu);
> >>                          if (ret)
> >>                                  goto out;
> >>
> >> --
> >> 2.33.0
> >>
>
> --
> Thanks,
> Qinxin
>
