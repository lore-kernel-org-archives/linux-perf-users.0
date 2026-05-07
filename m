Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E43ACF10
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170689; cv=pass; b=KbZhP3I4MpqjxEPDjZ2Jwhmdhknry37srHGHpLdFzl9/iyLJbIPbDIhi4g0Z8PjOjFdiU7aykPQKGyAW84GqUeXkjwvGA52mnlMWRnwWAu2bcZJaI1RZ3ldAWTuDRbVx6okEtbQInS33W78CDaeQuXmjOJEJZikGR4I+scHEHX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170689; c=relaxed/simple;
	bh=wHWWHJfVvarkHhgVDYYXhx5xBJCAIQvtZjDT64IqMHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3Rouw/L/Zwk/7nw1ccMpz0rtM5+SLyAy6wyaJptveYbgr89fphjWUzDUihp2pyGihsJd9qOmkVaQKEWp/oXVhhkzgPrKJTPauQFFXPKSlEbjy+tQ3C0Ir+GXmT/ik5+7bvSZTqWccwIaCg7X34RAXrRjjMMU4blgrBhJeBw4/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZ+dQa4v; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZ+dQa4v"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso109775ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 09:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778170682; cv=none;
        d=google.com; s=arc-20240605;
        b=RHIytfsi6eM0QK8jzjDWZRfTMN3GBzcEoa89fNqTdNDbpsTwgtQwjVQfTd0aRIpzRS
         s+khRYh9OZhd6uub3INPyndw81+Th4qsUs3wZ7R93yfik+3OgUbkQDDi9hlRCShHmPfh
         +MZVYe1ADcyGZGaELr7R1IBDKEYTgGXJdQUUAW31cYE2gd+oh2SK9at/8mlehKa4CvFW
         PryaGxIHXfYJF/kX1iLv58U4IcbgDH0J2aWAlvjvDnd85XJs5z/tTHhGgchshdrab3JX
         1fqdV2AU8MXHBjwNNXKQAmqcBSdZDo024Yb9cQE1GzQf/PomsDQKYCozgFdAUE98T8QI
         ayxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2whKJlQ6ucWiTbs5bN7bxCBSR/cUesXgVrhn1UZxtIk=;
        fh=deu2LRCBskQzJ9Dy0YdDwfXNEI5Gm1W1wq4jRCLPwsk=;
        b=CGHiYizVJzSuTkE7JoxyZ2573ys/t/J6l8KtJ3QsO/prfBjenxFgJorsQww92Oroow
         b6Zsil8Tp/kKQPtDmahbGy6daKTGjHePkesXnExc29kxlVmOUrQzBGqIoBOEU5dbJ4iD
         e20tTc7uHW4jV8gl+MBIPnfvS9dgzFV5L+cvr65HVzSr2+pKswCBd5c0Bm2TTHMMMLfT
         oHohPfotcTdPPn+jfFocVwdcGqopOT0bHBMJuDTvWeNelALsAq3rdMiv++tIHkjCR0jg
         vOYmw3kAAvJvx758djL9lbWwJ4q9A1ljFj4aDfiNuFytCnvUVujUPo7dB3GnICGzDtMF
         ZVwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778170682; x=1778775482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2whKJlQ6ucWiTbs5bN7bxCBSR/cUesXgVrhn1UZxtIk=;
        b=WZ+dQa4viDWv2zcSTMIDBAXZUvzDrFDbJ1Wm/r18H6c5S8/5qst4Bk1ORIAh/wzNbD
         iCrW0x5AvZeedvAqe+n6v9FnJjNTEyWirRiRh0m3KDxIGnbthf/4vlSA6GQ3ybCpEIyK
         vxdHspPPWcfX3rhSudHvZPQ9cDi8WTPLIjTG5mwi3EpspKUtoUBartmau9n2CvRRkN9y
         /afnfOKmpkwQYC52sNWEKiItC8gwiOFsM3OY5mFxjzNXGmzM2H+nn1m7UkuAYU1bi8Sz
         L9+MZGm0I4fBi17ZzYsnZnDhy2k8ntt73vd+YdmN5AILJiZnmFAfKEUNRdARw6eze0ZP
         l3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170682; x=1778775482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2whKJlQ6ucWiTbs5bN7bxCBSR/cUesXgVrhn1UZxtIk=;
        b=cwWoWfpRwbh3gl/QyDcyoUJoMEJxkrpnjdDpTHN71+JrmxnpomTfD5QYxJLZJCK+HO
         U2FyCX7Jo/IS+DB1vBqoDtyC8RLqgfAtIP0CAcDAO2gq38rxyZiEImHJ+NQ30rcMCAcy
         NlC80IdY46J1Ug3rp6SkSmicAJHnR3+4TbS4hE2QtEWIhBu9VZUr7186eIWRXcpk9hNb
         /lSUlkbFg0JlGJpBpty1xpU52d5AQlQNzkI9kCVW3h+lYpAzYVpK6qQK71cw9PUi95Ri
         8gX02y/v0towCMQU1CLENMK5mA1BA/e/IyhPOwhY4xsgYZC1/IutNb/MfQXFQZZOpzx+
         5KuA==
X-Forwarded-Encrypted: i=1; AFNElJ+QgWmd7TEtu8zWAynH3m3NyYV+xptV26rDSf8SYLF9i2ftIG2rELr0TRgK9nxp8vRKVyB5GBb6Q8etj4CGxy0T@vger.kernel.org
X-Gm-Message-State: AOJu0YwMshoNl11x6TarzdIHaeztbpWDaAns0EPbEr0qP1VbAxjKZQRE
	w4vJAzw/4TvuhmOffYZq42IhyrtqraPxzL+F1Sgvv/rZvv+N/Lpt/qVnSBIePWl7o7IKLgf+9Ok
	feZZWGLMoK1vN7946MFFvYVTHpXXAL3whtfNvbW+t
X-Gm-Gg: Acq92OE4+dccjp/yt0ypFWvQuhQ3MPufXgQyeRXXdzbKvtaTXzKsZTIuUyW8V5V+Ds7
	qjFQ0mD/J8KaoE5gt1SP0tUzErIAz4fxgB4HSSLQU6EJeG8vbYGl4XHhQoy6pASbGPGb+uq4OWO
	kgeAEVp2ygzWDKBAiP8GZi744iyR8GIRc+A0XuP3ly1wEIveg3VnmxhvMLIdMspV+0KLMdUISlI
	gbdC/PRjEy9Ii9ayPJGuGAuz1254uxMww4evkj+JfD0OQESX4ESr8NEiYbZmQ853u7tfuvv2bo0
	bpRkHSV4WjQBpmQ5xOlF/K1vH8/djE2l6XsWMmxN39wTnmvy
X-Received: by 2002:a17:902:d485:b0:2b4:60e6:44bc with SMTP id
 d9443c01a7336-2bae5af396cmr428665ad.13.1778170681845; Thu, 07 May 2026
 09:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507063737.3542950-1-wangyushan12@huawei.com> <20260507063737.3542950-7-wangyushan12@huawei.com>
In-Reply-To: <20260507063737.3542950-7-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 09:17:50 -0700
X-Gm-Features: AVHnY4Lae1gVba_Mnp03LYU57lnp9dlmOIhz1NHsyGbgwg6zHDnudZjlWYxnk8s
Message-ID: <CAP-5=fX1ECS9ECh0WYXDr6DHSwSvqwZBKkAETxQGtwAWcpphfg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 6/7] perf-iostat: Make x86 iostat compatible with
 new iostat framework
To: Yushan Wang <wangyushan12@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@arm.com, 
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org, leo.yan@linux.dev, 
	robin.murphy@arm.com, linuxarm@huawei.com, hejunhao3@huawei.com, 
	prime.zeng@hisilicon.com, fanghao11@huawei.com, wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:37=E2=80=AFPM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Change the original x86 iio iostat supporter to be compatible with the
> set of iostat frameworks.
>
> The matching function of x86 iio may not be correct.
>
> Signed-off-by: Shiju Jose  <shiju.jose@huawei.com>
> Co-developed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
> ---
>  tools/perf/util/iostat.c     | 26 +++++++--------
>  tools/perf/util/x86-iostat.c | 62 ++++++++++++++++++++++++++----------
>  2 files changed, 59 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
> index 90607d1cf3fa..6c51f4a521af 100644
> --- a/tools/perf/util/iostat.c
> +++ b/tools/perf/util/iostat.c
> @@ -13,7 +13,7 @@ static struct iostat_pmu *iostat_pmu;
>
>  enum iostat_mode_t iostat_mode =3D IOSTAT_NONE;
>
> -__weak int iostat_prepare(struct evlist *evlist, struct perf_stat_config=
 *config)
> +int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)

Less "weak", beautiful!

>  {
>         if (!iostat_pmu)
>                 return -1;
> @@ -21,7 +21,7 @@ __weak int iostat_prepare(struct evlist *evlist, struct=
 perf_stat_config *config
>         return iostat_pmu->prepare(evlist, config);
>  }
>
> -__weak int iostat_parse(const struct option *opt, const char *str, int u=
nset)
> +int iostat_parse(const struct option *opt, const char *str, int unset)
>  {
>         if (!iostat_pmu)
>                 return -1;
> @@ -29,33 +29,33 @@ __weak int iostat_parse(const struct option *opt, con=
st char *str, int unset)
>         return iostat_pmu->parse(opt, str, unset);
>  }
>
> -__weak void iostat_list(struct evlist *evlist, struct perf_stat_config *=
config)
> +void iostat_list(struct evlist *evlist, struct perf_stat_config *config)
>  {
>         iostat_pmu->list(evlist, config);
>  }
>
> -__weak void iostat_release(struct evlist *evlist)
> +void iostat_release(struct evlist *evlist)
>  {
>         iostat_pmu->release(evlist);
>  }
>
> -__weak void iostat_print_header_prefix(struct perf_stat_config *config)
> +void iostat_print_header_prefix(struct perf_stat_config *config)
>  {
>         iostat_pmu->print_header_prefix(config);
>  }
>
> -__weak void iostat_print_metric(struct perf_stat_config *config,
> -                               struct evsel *evsel,
> -                               struct perf_stat_output_ctx *out)
> +void iostat_print_metric(struct perf_stat_config *config,
> +                        struct evsel *evsel,
> +                        struct perf_stat_output_ctx *out)
>  {
>         iostat_pmu->print_metric(config, evsel, out);
>  }
>
> -__weak void iostat_print_counters(struct evlist *evlist,
> -                                 struct perf_stat_config *config,
> -                                 struct timespec *ts, char *prefix,
> -                                 iostat_print_counter_t print_cnt_cb,
> -                                 void *arg)
> +void iostat_print_counters(struct evlist *evlist,
> +                          struct perf_stat_config *config,
> +                          struct timespec *ts, char *prefix,
> +                          iostat_print_counter_t print_cnt_cb,
> +                          void *arg)
>  {
>         iostat_pmu->print_counters(evlist, config, ts, prefix,
>                                    print_cnt_cb, arg);
> diff --git a/tools/perf/util/x86-iostat.c b/tools/perf/util/x86-iostat.c
> index f8d4c9718594..778655cbc2a0 100644
> --- a/tools/perf/util/x86-iostat.c
> +++ b/tools/perf/util/x86-iostat.c
> @@ -332,9 +332,9 @@ static int iostat_event_group(struct evlist *evl,
>         return ret;
>  }
>
> -static void iostat_prefix(struct evlist *evlist,
> -                         struct perf_stat_config *config,
> -                         char *prefix, struct timespec *ts)
> +static void iio_iostat_prefix(struct evlist *evlist,
> +                             struct perf_stat_config *config,
> +                             char *prefix, struct timespec *ts)
>  {
>         struct iio_root_port *rp =3D evlist->selected->priv;
>
> @@ -354,7 +354,7 @@ static void iostat_prefix(struct evlist *evlist,
>         }
>  }
>
> -int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)
> +static int iio_iostat_prepare(struct evlist *evlist, struct perf_stat_co=
nfig *config)
>  {
>         if (evlist->core.nr_entries > 0) {
>                 pr_warning("The -e and -M options are not supported."
> @@ -371,8 +371,8 @@ int iostat_prepare(struct evlist *evlist, struct perf=
_stat_config *config)
>         return iostat_event_group(evlist, root_ports);
>  }
>
> -int iostat_parse(const struct option *opt, const char *str,
> -                int unset __maybe_unused)
> +static int iio_iostat_parse(const struct option *opt, const char *str,
> +                           int unset __maybe_unused)
>  {
>         int ret;
>         struct perf_stat_config *config =3D (struct perf_stat_config *)op=
t->data;
> @@ -392,7 +392,7 @@ int iostat_parse(const struct option *opt, const char=
 *str,
>         return ret;
>  }
>
> -void iostat_list(struct evlist *evlist, struct perf_stat_config *config)
> +static void iio_iostat_list(struct evlist *evlist, struct perf_stat_conf=
ig *config)
>  {
>         struct evsel *evsel;
>         struct iio_root_port *rp =3D NULL;
> @@ -405,7 +405,7 @@ void iostat_list(struct evlist *evlist, struct perf_s=
tat_config *config)
>         }
>  }
>
> -void iostat_release(struct evlist *evlist)
> +static void iio_iostat_release(struct evlist *evlist)
>  {
>         struct evsel *evsel;
>         struct iio_root_port *rp =3D NULL;
> @@ -418,7 +418,7 @@ void iostat_release(struct evlist *evlist)
>         }
>  }
>
> -void iostat_print_header_prefix(struct perf_stat_config *config)
> +static void iio_iostat_print_header_prefix(struct perf_stat_config *conf=
ig)
>  {
>         if (config->csv_output)
>                 fputs("port,", config->output);
> @@ -428,8 +428,8 @@ void iostat_print_header_prefix(struct perf_stat_conf=
ig *config)
>                 fprintf(config->output, "   port         ");
>  }
>
> -void iostat_print_metric(struct perf_stat_config *config, struct evsel *=
evsel,
> -                        struct perf_stat_output_ctx *out)
> +static void iio_iostat_print_metric(struct perf_stat_config *config, str=
uct evsel *evsel,
> +                                   struct perf_stat_output_ctx *out)
>  {
>         double iostat_value =3D 0;
>         u64 prev_count_val =3D 0;
> @@ -452,24 +452,54 @@ void iostat_print_metric(struct perf_stat_config *c=
onfig, struct evsel *evsel,
>                           iostat_value / (256 * 1024));
>  }
>
> -void iostat_print_counters(struct evlist *evlist,
> -                          struct perf_stat_config *config, struct timesp=
ec *ts,
> -                          char *prefix, iostat_print_counter_t print_cnt=
_cb, void *arg)
> +static void iio_iostat_print_counters(struct evlist *evlist,
> +                                     struct perf_stat_config *config, st=
ruct timespec *ts,
> +                                     char *prefix, iostat_print_counter_=
t print_cnt_cb, void *arg)
>  {
>         void *perf_device =3D NULL;
>         struct evsel *counter =3D evlist__first(evlist);
>
>         evlist__set_selected(evlist, counter);
> -       iostat_prefix(evlist, config, prefix, ts);
> +       iio_iostat_prefix(evlist, config, prefix, ts);
>         fprintf(config->output, "%s", prefix);
>         evlist__for_each_entry(evlist, counter) {
>                 perf_device =3D evlist->selected->priv;
>                 if (perf_device && perf_device !=3D counter->priv) {
>                         evlist__set_selected(evlist, counter);
> -                       iostat_prefix(evlist, config, prefix, ts);
> +                       iio_iostat_prefix(evlist, config, prefix, ts);
>                         fprintf(config->output, "\n%s", prefix);
>                 }
>                 print_cnt_cb(config, counter, arg);
>         }
>         fputc('\n', config->output);
>  }
> +
> +/*
> + * FIXME: pmu name prefix match might not work for x86 iio.
> + */
> +static bool iio_iostat_probe(struct iostat_pmu *iostat_pmu)
> +{
> +       return perf_pmus__scan_matching_wildcard(NULL, iostat_pmu->pmu_na=
me_wildcard);

It feels more readable to me as:
```
  return perf_pmus__scan_matching_wildcard(NULL, "uncore_iio") !=3D NULL;
```


> +}
> +
> +static struct iostat_pmu x86_iio_iostat_pmu_list[]  =3D {
> +       {
> +               .pmu_name_wildcard =3D "uncore_iio*",
> +               .match =3D iio_iostat_probe,
> +               .prepare =3D iio_iostat_prepare,
> +               .parse =3D iio_iostat_parse,
> +               .list =3D iio_iostat_list,
> +               .print_header_prefix =3D iio_iostat_print_header_prefix,
> +               .print_metric =3D iio_iostat_print_metric,

Is there scope to push the metric printing into json? For example, you
can have PMUs with json:
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
```
    {
       "BriefDescription": "Uncore frequency per die [GHZ]",
       "MetricExpr": "tma_info_system_socket_clks / #num_dies /
duration_time / 1e9",
       "MetricGroup": "SoC",
       "MetricName": "UNCORE_FREQ",
       "Unit": "cpu_core"
   },
```
and do uncore type things:
tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
```
  {
   "MetricName": "umc_activate_cmd_rate",
   "BriefDescription": "Memory controller ACTIVATE command rate.",
   "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
   "MetricGroup": "memory_controller",
   "PerPkg": "1",
   "ScaleUnit": "1per_memclk"
 },
```

> +               .print_counters =3D iio_iostat_print_counters,
> +               .release =3D iio_iostat_release,
> +       },
> +};
> +
> +static void __attribute__((constructor)) x86_iio_iostat_pmu_init(void)

I don't believe these attributes are what we normally do.

Thanks,
Ian


> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(x86_iio_iostat_pmu_list); i++)
> +               register_iostat_pmu(&x86_iio_iostat_pmu_list[i]);
> +}
> --
> 2.33.0
>
