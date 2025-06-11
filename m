Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABB20322
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666652; cv=none; b=Je2LX7gTOKpe/iCUZzdAtCg5qHpk8tfgeM2dsR1AgeMRKs21qLDAk4OzGXEqb2EdBTjtlmtQhx6JgEiRUMspWxliR1wELym/urazUM+2M+jL/4FjlntI1Kb5915G1Hi1rkngisODmfeaTfDj+rDwViJu2CDZ3IK8tgYPMnMm2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666652; c=relaxed/simple;
	bh=zkvhFn1dvwpij2C+2+79I7Odk3udbvUK4Cuuv6jZ/sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pft1TggoND9ScICSvPWKl0Ahe1yxW2nGt2kp27ICBdWbpr2bP7MXlS6lAiXFRFoIYVIYqv3CQKp8qShA66zdPo3/6e2jAn9TuNYYJZ6GkWVtAHAGurVR6ws4OM5ZtKYf9pBSWDA7QCQ0nuWd+sojzPD/H2IE9XBw3NyMSl2YsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xzMDeO2/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xzMDeO2/"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so20755ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749666650; x=1750271450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUlFrf885uk7hWniA9ruK8KO9M4PebPn0BtPXR5B7Mc=;
        b=xzMDeO2/D4dTBsAcah5vgkV5oyyA519exYMspKhDMC5MMz9Mx+J6TvXYWYEXk5saok
         BDjfG61hiqLmNscLJny2igziXcpwgNDNDSJWD+7PnPIouYCmTf7EYLRmURkCbouS/u4s
         lFkFJLoHKkMAFly3Hzd11xK6K3tEoSUND68UsLa2eKBrhDGhGhae62y2zXjYAQQLVZWa
         Tsh7bvvRMpV4bAfOOk0dgQnWphN10+/ve2tOp0z0+V6NYaBe1Ca7DL+KHMLXYWCRzTFN
         zZuYYpZUrL4LOl0TTwVVQBZaPWPT9EuQkQmjai8naJssWTJEngQ9Vl7uj0IOZGnE4zJI
         sviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666650; x=1750271450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUlFrf885uk7hWniA9ruK8KO9M4PebPn0BtPXR5B7Mc=;
        b=VAk8GuqDWzzc+Qr0/n6Oe9lOR6yYM9FP6GYr/djHiBKa3E9yycX7heFyqd9phSiLEA
         rHQJ2xX4f2dLlTCGv+oRJB9G2LF7xq2m1sSegx7M3lPwADXTjsoikTtyyuMmdAhHb9Bd
         Zpo3MwbzBQq0pagE5WveXfbyUFy16q6OMaNrxA+GkN9XtJgqGiDBkWL3YoO3sOc4eMmJ
         H/MVv6Ef0Kbc+zdS5ythbwkhHnk2+0CpnF0B8Ft3OUqmyOJeeC5/defMx1UnZ8DzD0oK
         6xKoXRvnmj8ydHAzvutilYwnzo/9LRTpA/V6XVEUj1Nc8ZJarE22ZR/oDafY8DT9/eF+
         092w==
X-Forwarded-Encrypted: i=1; AJvYcCVxtkdPrFbWotvVf0K0PZlsiIPjC0ponq4sgDIZarFpnWl4Afi3SRntFNvjZuMLlMh2gJfONkzWOsi268+e6rej@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4PZamaebwRsyySWpkP48DfGip/CnhM07sBH/3Vg1T00AeMgM
	i5+zzqyoAdUmvs1tCkRcScc1qbQCSVK1J7c8PtEKMBaHA2ZjvjYpZhvCOEBW5s9J+KDmaYbXSXn
	r9ls4J3tVgk6L3X6YdTRrcnoAZ1ETp9G8LZgK0nSC
X-Gm-Gg: ASbGncvi5VwIvBIMicTJw2LlDh2xmXaNHLwEAbEi27B/H/B0lD45yZcgwvOUne4l9cm
	gdaLhenTWwVzZBEufAtJ+nqVhMfwr/ndGmFKY6aqLOX2O3ez82D4D4ZHxuib1UcZzjDEXKRB4bN
	nUDSgqFmOmtTG1sBERba2HxCBWhL6Mkrtcn6lYzO+K3n6IqHPTu9/P3ds6A65lpOqlI6nA0fRT
X-Google-Smtp-Source: AGHT+IH/+QRsmw4yQlHvwXqxi/8a6kcY01H0TF3efMaj9RHNRIXHnvBFBU8jO4rnfXVJeDoBihVcBun5bRzKCqyEcDQ=
X-Received: by 2002:a05:6e02:2292:b0:3da:7c33:509c with SMTP id
 e9e14a558f8ab-3ddfb312ed9mr130645ab.11.1749666649497; Wed, 11 Jun 2025
 11:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513231813.13846-1-thomas.falcon@intel.com>
 <20250513231813.13846-2-thomas.falcon@intel.com> <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
 <aEiTrRNyeqFsYwR6@google.com> <94612a9d92f4d3820e8c293b0e184ab11971bf36.camel@intel.com>
In-Reply-To: <94612a9d92f4d3820e8c293b0e184ab11971bf36.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Jun 2025 11:30:38 -0700
X-Gm-Features: AX0GCFtxRWButhz0X3DrX8soJFOSdnNuhj7TZWYTYYJcovCHYvEqaVc2ZT0qW24
Message-ID: <CAP-5=fU9fz8-91eRH72r9GQYXOOoSQ9DZB9sJPZu5ZZOeu4QnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in perf_env
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "namhyung@kernel.org" <namhyung@kernel.org>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:18=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Tue, 2025-06-10 at 13:21 -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Jun 09, 2025 at 04:21:39PM +0000, Falcon, Thomas wrote:
> > > Ping?
> >
> > Sorry for the delay, I'll process the series as it's reviewed by Ian.
> > Ian, it may clash with your perf_env cleanup though.

Ack. Thanks Namhyung, I figured that would happen, Kan pointed out
similar hence wanting the perf_env cleanup, I'll resolve the
differences as and when.

Thanks,
Ian

> > Also note that please don't mix patch versions.  The 1/2 is v1 and 2/2
> > v3 - it makes b4 confused.
> >
> > Thanks,
> > Namhyung
>
> Thanks!
>
> Tom
>
> >
> > >
> > > On Tue, 2025-05-13 at 18:18 -0500, Thomas Falcon wrote:
> > > > Calling perf top with branch filters enabled on Intel CPU's
> > > > with branch counters logging (A.K.A LBR event logging [1]) support
> > > > results in a segfault.
> > > >
> > > > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> > > > [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> > > > perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0, w=
idth=3D0x7fffafff62c0) at util/env.c:653
> > > > 653                       *width =3D env->cpu_pmu_caps ? env->br_cn=
tr_width :
> > > > (gdb) bt
> > > >  #0  perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0=
x0, width=3D0x7fffafff62c0) at util/env.c:653
> > > >  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=3D0x7fff=
cc3db580, evsel=3D0xfea2d0, offset=3D12, br_cntr=3D8) at util/annotate.c:34=
5
> > > >  #2  0x00000000005b17fb in symbol__account_cycles (addr=3D5658172, =
start=3D5658160, sym=3D0x7fffcc0ee420, cycles=3D539, evsel=3D0xfea2d0, br_c=
ntr=3D8) at util/annotate.c:389
> > > >  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=3D0=
x7fffcd7b01d0, start=3D0x7fffcd7b02b0, cycles=3D539, evsel=3D0xfea2d0, br_c=
ntr=3D8) at util/annotate.c:422
> > > >  #4  0x000000000068d57f in hist__account_cycles (bs=3D0x110d288, al=
=3D0x7fffafff6540, sample=3D0x7fffafff6760, nonany_branch_mode=3Dfalse, tot=
al_cycles=3D0x0, evsel=3D0xfea2d0) at util/hist.c:2850
> > > >  #5  0x0000000000446216 in hist_iter__top_callback (iter=3D0x7fffaf=
ff6590, al=3D0x7fffafff6540, single=3Dtrue, arg=3D0x7fffffff9e00) at builti=
n-top.c:737
> > > >  #6  0x0000000000689787 in hist_entry_iter__add (iter=3D0x7fffafff6=
590, al=3D0x7fffafff6540, max_stack_depth=3D127, arg=3D0x7fffffff9e00) at u=
til/hist.c:1359
> > > >  #7  0x0000000000446710 in perf_event__process_sample (tool=3D0x7ff=
fffff9e00, event=3D0x110d250, evsel=3D0xfea2d0, sample=3D0x7fffafff6760, ma=
chine=3D0x108c968) at builtin-top.c:845
> > > >  #8  0x0000000000447735 in deliver_event (qe=3D0x7fffffffa120, qeve=
nt=3D0x10fc200) at builtin-top.c:1211
> > > >  #9  0x000000000064ccae in do_flush (oe=3D0x7fffffffa120, show_prog=
ress=3Dfalse) at util/ordered-events.c:245
> > > >  #10 0x000000000064d005 in __ordered_events__flush (oe=3D0x7fffffff=
a120, how=3DOE_FLUSH__TOP, timestamp=3D0) at util/ordered-events.c:324
> > > >  #11 0x000000000064d0ef in ordered_events__flush (oe=3D0x7fffffffa1=
20, how=3DOE_FLUSH__TOP) at util/ordered-events.c:342
> > > >  #12 0x00000000004472a9 in process_thread (arg=3D0x7fffffff9e00) at=
 builtin-top.c:1120
> > > >  #13 0x00007ffff6e7dba8 in start_thread (arg=3D<optimized out>) at =
pthread_create.c:448
> > > >  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv=
/linux/x86_64/clone3.S:78
> > > >
> > > > The cause is that perf_env__find_br_cntr_info tries to access a
> > > > null pointer pmu_caps in the perf_env struct. A similar issue exist=
s
> > > > for homogeneous core systems which use the cpu_pmu_caps structure.
> > > >
> > > > Fix this by populating cpu_pmu_caps and pmu_caps structures with
> > > > values from sysfs when calling perf top with branch stack sampling
> > > > enabled.
> > > >
> > > > [1], LBR event logging introduced here:
> > > > https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linu=
x.intel.com/
> > > >
> > > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > > > ---
> > > > v3: constify struct perf_pmu *pmu in __perf_env__read_core_pmu_caps=
()
> > > >     use perf_pmus__find_core_pmu() instead of perf_pmus__scan_core(=
NULL)
> > > >
> > > > v2: update commit message with more meaningful stack trace from
> > > >     gdb and indicate that affected systems are limited to CPU's
> > > >     with LBR event logging support and that both hybrid and
> > > >     non-hybrid core systems are affected.
> > > > ---
> > > >  tools/perf/builtin-top.c |   8 +++
> > > >  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++=
++++
> > > >  tools/perf/util/env.h    |   1 +
> > > >  3 files changed, 123 insertions(+)
> > > >
> > > > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > > > index f9f31391bddb..c9d679410591 100644
> > > > --- a/tools/perf/builtin-top.c
> > > > +++ b/tools/perf/builtin-top.c
> > > > @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
> > > >   if (opts->branch_stack && callchain_param.enabled)
> > > >           symbol_conf.show_branchflag_count =3D true;
> > > >
> > > > + if (opts->branch_stack) {
> > > > +         status =3D perf_env__read_core_pmu_caps(&perf_env);
> > > > +         if (status) {
> > > > +                 pr_err("PMU capability data is not available\n");
> > > > +                 goto out_delete_evlist;
> > > > +         }
> > > > + }
> > > > +
> > > >   sort__mode =3D SORT_MODE__TOP;
> > > >   /* display thread wants entries to be collapsed in a different tr=
ee */
> > > >   perf_hpp_list.need_collapse =3D 1;
> > > > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > > > index 36411749e007..6735786a1d22 100644
> > > > --- a/tools/perf/util/env.c
> > > > +++ b/tools/perf/util/env.c
> > > > @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struc=
t perf_env *env)
> > > >   return env->nr_cpus_avail ? 0 : -ENOENT;
> > > >  }
> > > >
> > > > +static int __perf_env__read_core_pmu_caps(const struct perf_pmu *p=
mu,
> > > > +                                   int *nr_caps, char ***caps,
> > > > +                                   unsigned int *max_branches,
> > > > +                                   unsigned int *br_cntr_nr,
> > > > +                                   unsigned int *br_cntr_width)
> > > > +{
> > > > + struct perf_pmu_caps *pcaps =3D NULL;
> > > > + char *ptr, **tmp;
> > > > + int ret =3D 0;
> > > > +
> > > > + *nr_caps =3D 0;
> > > > + *caps =3D NULL;
> > > > +
> > > > + if (!pmu->nr_caps)
> > > > +         return 0;
> > > > +
> > > > + *caps =3D zalloc(sizeof(char *) * pmu->nr_caps);
> > > > + if (!*caps)
> > > > +         return -ENOMEM;
> > > > +
> > > > + tmp =3D *caps;
> > > > + list_for_each_entry(pcaps, &pmu->caps, list) {
> > > > +
> > > > +         if (asprintf(&ptr, "%s=3D%s", pcaps->name, pcaps->value) =
< 0) {
> > > > +                 ret =3D -ENOMEM;
> > > > +                 goto error;
> > > > +         }
> > > > +
> > > > +         *tmp++ =3D ptr;
> > > > +
> > > > +         if (!strcmp(pcaps->name, "branches"))
> > > > +                 *max_branches =3D atoi(pcaps->value);
> > > > +
> > > > +         if (!strcmp(pcaps->name, "branch_counter_nr"))
> > > > +                 *br_cntr_nr =3D atoi(pcaps->value);
> > > > +
> > > > +         if (!strcmp(pcaps->name, "branch_counter_width"))
> > > > +                 *br_cntr_width =3D atoi(pcaps->value);
> > > > + }
> > > > + *nr_caps =3D pmu->nr_caps;
> > > > + return 0;
> > > > +error:
> > > > + while (tmp-- !=3D *caps)
> > > > +         free(*tmp);
> > > > + free(*caps);
> > > > + *caps =3D NULL;
> > > > + *nr_caps =3D 0;
> > > > + return ret;
> > > > +}
> > > > +
> > > > +int perf_env__read_core_pmu_caps(struct perf_env *env)
> > > > +{
> > > > + struct perf_pmu *pmu =3D NULL;
> > > > + struct pmu_caps *pmu_caps;
> > > > + int nr_pmu =3D 0, i =3D 0, j;
> > > > + int ret;
> > > > +
> > > > + nr_pmu =3D perf_pmus__num_core_pmus();
> > > > +
> > > > + if (!nr_pmu)
> > > > +         return -ENODEV;
> > > > +
> > > > + if (nr_pmu =3D=3D 1) {
> > > > +         pmu =3D perf_pmus__find_core_pmu();
> > > > +         if (!pmu)
> > > > +                 return -ENODEV;
> > > > +         ret =3D perf_pmu__caps_parse(pmu);
> > > > +         if (ret < 0)
> > > > +                 return ret;
> > > > +         return __perf_env__read_core_pmu_caps(pmu, &env->nr_cpu_p=
mu_caps,
> > > > +                                               &env->cpu_pmu_caps,
> > > > +                                               &env->max_branches,
> > > > +                                               &env->br_cntr_nr,
> > > > +                                               &env->br_cntr_width=
);
> > > > + }
> > > > +
> > > > + pmu_caps =3D zalloc(sizeof(*pmu_caps) * nr_pmu);
> > > > + if (!pmu_caps)
> > > > +         return -ENOMEM;
> > > > +
> > > > + while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > > > +         if (perf_pmu__caps_parse(pmu) <=3D 0)
> > > > +                 continue;
> > > > +         ret =3D __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].=
nr_caps,
> > > > +                                              &pmu_caps[i].caps,
> > > > +                                              &pmu_caps[i].max_bra=
nches,
> > > > +                                              &pmu_caps[i].br_cntr=
_nr,
> > > > +                                              &pmu_caps[i].br_cntr=
_width);
> > > > +         if (ret)
> > > > +                 goto error;
> > > > +
> > > > +         pmu_caps[i].pmu_name =3D strdup(pmu->name);
> > > > +         if (!pmu_caps[i].pmu_name) {
> > > > +                 ret =3D -ENOMEM;
> > > > +                 goto error;
> > > > +         }
> > > > +         i++;
> > > > + }
> > > > +
> > > > + env->nr_pmus_with_caps =3D nr_pmu;
> > > > + env->pmu_caps =3D pmu_caps;
> > > > +
> > > > + return 0;
> > > > +error:
> > > > + for (i =3D 0; i < nr_pmu; i++) {
> > > > +         for (j =3D 0; j < pmu_caps[i].nr_caps; j++)
> > > > +                 free(pmu_caps[i].caps[j]);
> > > > +         free(pmu_caps[i].caps);
> > > > +         free(pmu_caps[i].pmu_name);
> > > > + }
> > > > + free(pmu_caps);
> > > > + return ret;
> > > > +}
> > > > +
> > > >  const char *perf_env__raw_arch(struct perf_env *env)
> > > >  {
> > > >   return env && !perf_env__read_arch(env) ? env->arch : "unknown";
> > > > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > > > index d90e343cf1fa..135a1f714905 100644
> > > > --- a/tools/perf/util/env.h
> > > > +++ b/tools/perf/util/env.h
> > > > @@ -152,6 +152,7 @@ struct btf_node;
> > > >
> > > >  extern struct perf_env perf_env;
> > > >
> > > > +int perf_env__read_core_pmu_caps(struct perf_env *env);
> > > >  void perf_env__exit(struct perf_env *env);
> > > >
> > > >  int perf_env__kernel_is_64_bit(struct perf_env *env);
> > >
>
