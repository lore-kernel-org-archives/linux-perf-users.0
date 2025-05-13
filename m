Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5631D5CDE
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157269; cv=none; b=EgH7jrabin3nZ4aTRkw9tJB+PWp652pP2Ml+ZlZVz2j1Suz3FcomeVE1wumurO3OxOm+5HqDY+unvzBZJKm/0Yaysi6LdXWCR5yd+NvdRTsRz+tK/TjSVvl+VgIw1PsOxehJ9iaYKVxz9KWNnNXPfu/yYMU/I1pXb0FdqQeCnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157269; c=relaxed/simple;
	bh=Exu5LPRDrF9GPsvFUHg86uGON/SziE1Wv94sTJI6drE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVJSZjflOI21HFeMnDkNea1eYJWoXvSo7ZtJLVkAwuZAV03o5uXs5wAZ57Xv2esY8dn0g84JzpB4tWOE0gIEgKzgrTtuzxqLYHS18jjXIhBLAkgSSqOJlNZPwSjsFIJIsk06mNolI86o1cDc4Em+8UAkw9jKSw8Rv+RJTQzwXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wedbrfON; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wedbrfON"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e39fbad5fso11515ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747157266; x=1747762066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIBSjAwDF5t1nNXPsQyXyqyW/fbAdYhx5iacZFg6vR0=;
        b=wedbrfONJh5ujexa0Mlo7SGzlX25k4KXDRYQYglZhDrnpdg4MBX2krkb3z4cZAKcXE
         TQSmTxy+wIEzfIjfykPTVrff7i/qrIRFwJ1Rdg/yEyussZSZxA49XaZFNBK5UYq3JcT0
         uC88iHVpHtJOt/9Y2p7ZLFFqGnlUqNwLJrVNuCtVwjHQw1+wZ/k6nbyykDFmaYd0m4XP
         ls7ebyIYyjv5/q51Q3RvyR225uE6MNEQ5PgBym+j7/7khFbqny9TnbSAIbdLTKhMTmkd
         A+AYokQuS1jKr5RtQSBrEjjjgS/jKSuhhKsRAixuUWkPhNa/z5KNw1nZwqazQY4bGJrw
         FY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157266; x=1747762066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIBSjAwDF5t1nNXPsQyXyqyW/fbAdYhx5iacZFg6vR0=;
        b=xLKObknSJZNtIkv9NoQWTika0KUmD7ASnqz/tZjDbz1W1jW/ZUaDAaK9LQdYAvPBBS
         WId5tnWeeeEWpUU95OMESqg+D6/X1ZTF02q9GpL7NzA+I4hDN6m+f4IuDf9KTERp1G1m
         z1DXs1DdkVa7DH/gx/xggY/QVW90+/NO4VxPh28oOB1f1gJ61wGPRr4pGPdWNZp16N3B
         yRx9C/cELKHYHICXH07Oo3v4Ij5EJBn6pKebcQXakwrbKtl+Z0Xy32gOJrXGMLAEkg5y
         FDQZ4dPNS4kugVmupbjXjisWQaZOho7Q3PF2QcfYrrMQzx9a4OFOGaaqyPji7diAw5b/
         BySg==
X-Forwarded-Encrypted: i=1; AJvYcCX8AZc8oV634OzWA2U4h5D71v+LX8eL6VA8ZOAxXiNNhLHDKb9qWToQlocVPCAMasQ4D961eY4rp31MI7yqIng7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QD9iqcf7c/jWdM/zL2JO1w91QDwDae++FrsBWeGJ3mVlonk8
	Psbs+F3UDmKvAPZL6uRFa4+2HxixEViKHLy0he0NpnRGBry594qfWydrA9yIkMuBYBpXJXfa4+B
	UujJ04uw8jJYnARBdrSXDZZBeAQbK7m6xFmi5uKd3
X-Gm-Gg: ASbGncuA3BBlgS+eZ/dIgUsMD6tr3sx8I5dcAzyls2annRg7ncriGevJMEKGgPxZKNa
	h6JGMKuLJr6C+coyfDDOb3Ou0H8B7M6Br3j7lCIJyNFO5xjoKWOPZxwRD3AvGiyEGcrOE4RjPY9
	n5xbgLRPYMv+r5S6Y+aKflT+vRCqa+Re42CwB9Qi66xgXDK7y45gMnOa9IJVgVmQ==
X-Google-Smtp-Source: AGHT+IGVUzw2P0BwYqRkKzacyTgyWkVtZx3xr2gBNrhQGTALIijCMhmH1LGQ+5rJ7M6GeM4wwGj/qVRIjqVKD5G7oTQ=
X-Received: by 2002:a17:903:2445:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-231804055e9mr2789555ad.29.1747157266226; Tue, 13 May 2025
 10:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508163127.726660-1-thomas.falcon@intel.com>
 <CAP-5=fVJWSyymbbk30Cx6Dhk-nTQJUUM-oOTrBCJuS6Q5az9Ag@mail.gmail.com> <6ffd38b54e57709ca980087abe2582f1ae89250c.camel@intel.com>
In-Reply-To: <6ffd38b54e57709ca980087abe2582f1ae89250c.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 10:27:33 -0700
X-Gm-Features: AX0GCFuXGojRR0m70VSVeriQ0Pz4e5YufP-2wgrTpOE3IlAmB-NP_aujBkOqsvM
Message-ID: <CAP-5=fVYLHY8Stz557sWHmFv7nMs+uHGHGPLiCOE7H5===XWSA@mail.gmail.com>
Subject: Re: [PATCH v2] perf top: populate PMU capabilities data in perf_env
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:17=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Tue, 2025-05-13 at 08:40 -0700, Ian Rogers wrote:
> > On Thu, May 8, 2025 at 9:31=E2=80=AFAM Thomas Falcon <thomas.falcon@int=
el.com> wrote:
> > >
> > > Calling perf top with branch filters enabled on Intel CPU's
> > > with branch counters logging (A.K.A LBR event logging [1]) support
> > > results in a segfault.
> >
>
> Hi Ian, thanks for reviewing!
>
> > At some point we should add a `perf top` shell test and include
> > regression tests for cases like this.
>
> Good point, I will look into creating a test for this.
>
> >
> > > Thread 27 "perf" received signal SIGSEGV, Segmentation fault.
> > > [Switching to Thread 0x7fffafff76c0 (LWP 949003)]
> > > perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0, wid=
th=3D0x7fffafff62c0) at util/env.c:653
> > > 653                     *width =3D env->cpu_pmu_caps ? env->br_cntr_w=
idth :
> > > (gdb) bt
> > >  #0  perf_env__find_br_cntr_info (env=3D0xf66dc0 <perf_env>, nr=3D0x0=
, width=3D0x7fffafff62c0) at util/env.c:653
> > >  #1  0x00000000005b1599 in symbol__account_br_cntr (branch=3D0x7fffcc=
3db580, evsel=3D0xfea2d0, offset=3D12, br_cntr=3D8) at util/annotate.c:345
> > >  #2  0x00000000005b17fb in symbol__account_cycles (addr=3D5658172, st=
art=3D5658160, sym=3D0x7fffcc0ee420, cycles=3D539, evsel=3D0xfea2d0, br_cnt=
r=3D8) at util/annotate.c:389
> > >  #3  0x00000000005b1976 in addr_map_symbol__account_cycles (ams=3D0x7=
fffcd7b01d0, start=3D0x7fffcd7b02b0, cycles=3D539, evsel=3D0xfea2d0, br_cnt=
r=3D8) at util/annotate.c:422
> > >  #4  0x000000000068d57f in hist__account_cycles (bs=3D0x110d288, al=
=3D0x7fffafff6540, sample=3D0x7fffafff6760, nonany_branch_mode=3Dfalse, tot=
al_cycles=3D0x0, evsel=3D0xfea2d0) at util/hist.c:2850
> > >  #5  0x0000000000446216 in hist_iter__top_callback (iter=3D0x7fffafff=
6590, al=3D0x7fffafff6540, single=3Dtrue, arg=3D0x7fffffff9e00) at builtin-=
top.c:737
> > >  #6  0x0000000000689787 in hist_entry_iter__add (iter=3D0x7fffafff659=
0, al=3D0x7fffafff6540, max_stack_depth=3D127, arg=3D0x7fffffff9e00) at uti=
l/hist.c:1359
> > >  #7  0x0000000000446710 in perf_event__process_sample (tool=3D0x7ffff=
fff9e00, event=3D0x110d250, evsel=3D0xfea2d0, sample=3D0x7fffafff6760, mach=
ine=3D0x108c968) at builtin-top.c:845
> > >  #8  0x0000000000447735 in deliver_event (qe=3D0x7fffffffa120, qevent=
=3D0x10fc200) at builtin-top.c:1211
> > >  #9  0x000000000064ccae in do_flush (oe=3D0x7fffffffa120, show_progre=
ss=3Dfalse) at util/ordered-events.c:245
> > >  #10 0x000000000064d005 in __ordered_events__flush (oe=3D0x7fffffffa1=
20, how=3DOE_FLUSH__TOP, timestamp=3D0) at util/ordered-events.c:324
> > >  #11 0x000000000064d0ef in ordered_events__flush (oe=3D0x7fffffffa120=
, how=3DOE_FLUSH__TOP) at util/ordered-events.c:342
> > >  #12 0x00000000004472a9 in process_thread (arg=3D0x7fffffff9e00) at b=
uiltin-top.c:1120
> > >  #13 0x00007ffff6e7dba8 in start_thread (arg=3D<optimized out>) at pt=
hread_create.c:448
> > >  #14 0x00007ffff6f01b8c in __GI___clone3 () at ../sysdeps/unix/sysv/l=
inux/x86_64/clone3.S:78
> > >
> > > The cause is that perf_env__find_br_cntr_info tries to access a
> > > null pointer pmu_caps in the perf_env struct. A similar issue exists
> > > for homogeneous core systems which use the cpu_pmu_caps structure.
> > >
> > > Fix this by populating cpu_pmu_caps and pmu_caps structures with
> > > values from sysfs when calling perf top with branch stack sampling
> > > enabled.
> > >
> > > [1], LBR event logging introduced here:
> > > https://lore.kernel.org/all/20231025201626.3000228-5-kan.liang@linux.=
intel.com/
> > >
> > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > > ---
> > > v2: update commit message with more meaningful stack trace from
> > >     gdb and indicate that affected systems are limited to CPU's
> > >     with LBR event logging support and that both hybrid and
> > >     non-hybrid core systems are affected.
> > > ---
> > >  tools/perf/builtin-top.c |   8 +++
> > >  tools/perf/util/env.c    | 114 +++++++++++++++++++++++++++++++++++++=
++
> > >  tools/perf/util/env.h    |   1 +
> > >  3 files changed, 123 insertions(+)
> > >
> > > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > > index 1061f4eebc3f..c2688e4ef3c4 100644
> > > --- a/tools/perf/builtin-top.c
> > > +++ b/tools/perf/builtin-top.c
> > > @@ -1729,6 +1729,14 @@ int cmd_top(int argc, const char **argv)
> > >         if (opts->branch_stack && callchain_param.enabled)
> > >                 symbol_conf.show_branchflag_count =3D true;
> > >
> > > +       if (opts->branch_stack) {
> > > +               status =3D perf_env__read_core_pmu_caps(&perf_env);
> > > +               if (status) {
> > > +                       pr_err("PMU capability data is not available\=
n");
> > > +                       goto out_delete_evlist;
> > > +               }
> > > +       }
> > > +
> > >         sort__mode =3D SORT_MODE__TOP;
> > >         /* display thread wants entries to be collapsed in a differen=
t tree */
> > >         perf_hpp_list.need_collapse =3D 1;
> > > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > > index 36411749e007..37ed6dc52cf3 100644
> > > --- a/tools/perf/util/env.c
> > > +++ b/tools/perf/util/env.c
> > > @@ -416,6 +416,120 @@ static int perf_env__read_nr_cpus_avail(struct =
perf_env *env)
> > >         return env->nr_cpus_avail ? 0 : -ENOENT;
> > >  }
> > >
> > > +static int __perf_env__read_core_pmu_caps(struct perf_pmu *pmu,
> >
> > Prefer "const struct perf_pmu *pmu" to show that it doesn't change with=
in.
>
> Ok, I will change that in a new version.
>
> >
> > > +                                         int *nr_caps, char ***caps,
> > > +                                         unsigned int *max_branches,
> > > +                                         unsigned int *br_cntr_nr,
> > > +                                         unsigned int *br_cntr_width=
)
> > > +{
> > > +       struct perf_pmu_caps *pcaps =3D NULL;
> > > +       char *ptr, **tmp;
> > > +       int ret =3D 0;
> > > +
> > > +       *nr_caps =3D 0;
> > > +       *caps =3D NULL;
> > > +
> > > +       if (!pmu->nr_caps)
> > > +               return 0;
> > > +
> > > +       *caps =3D zalloc(sizeof(char *) * pmu->nr_caps);
> > > +       if (!*caps)
> > > +               return -ENOMEM;
> > > +
> > > +       tmp =3D *caps;
> > > +       list_for_each_entry(pcaps, &pmu->caps, list) {
> > > +
> > > +               if (asprintf(&ptr, "%s=3D%s", pcaps->name, pcaps->val=
ue) < 0) {
> > > +                       ret =3D -ENOMEM;
> > > +                       goto error;
> > > +               }
> > > +
> > > +               *tmp++ =3D ptr;
> > > +
> > > +               if (!strcmp(pcaps->name, "branches"))
> > > +                       *max_branches =3D atoi(pcaps->value);
> > > +
> > > +               if (!strcmp(pcaps->name, "branch_counter_nr"))
> > > +                       *br_cntr_nr =3D atoi(pcaps->value);
> > > +
> > > +               if (!strcmp(pcaps->name, "branch_counter_width"))
> > > +                       *br_cntr_width =3D atoi(pcaps->value);
> > > +       }
> > > +       *nr_caps =3D pmu->nr_caps;
> > > +       return 0;
> > > +error:
> > > +       while (tmp-- !=3D *caps)
> > > +               free(*tmp);
> > > +       free(*caps);
> > > +       *caps =3D NULL;
> > > +       *nr_caps =3D 0;
> > > +       return ret;
> > > +}
> > > +
> > > +int perf_env__read_core_pmu_caps(struct perf_env *env)
> > > +{
> > > +       struct perf_pmu *pmu =3D NULL;
> > > +       struct pmu_caps *pmu_caps;
> > > +       int nr_pmu =3D 0, i =3D 0, j;
> > > +       int ret;
> > > +
> > > +       nr_pmu =3D perf_pmus__num_core_pmus();
> > > +
> > > +       if (!nr_pmu)
> > > +               return -ENODEV;
> > > +
> > > +       if (nr_pmu =3D=3D 1) {
> > > +               pmu =3D perf_pmus__scan_core(NULL);
> >
> > There is perf_pmus__find_core_pmu for this, not sure why this is in
> > pmu.h rather than pmus.h though.
>
> Thanks, I will use perf_pmus__find_core_pmu() for this then. Should I inc=
lude another patch moving
> the prototype to pmus.h?

That would be good, thanks!
Ian

> Tom
> >
> > Thanks,
> > Ian
> >
> > > +               if (!pmu)
> > > +                       return -ENODEV;
> > > +               ret =3D perf_pmu__caps_parse(pmu);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +               return __perf_env__read_core_pmu_caps(pmu, &env->nr_c=
pu_pmu_caps,
> > > +                                                     &env->cpu_pmu_c=
aps,
> > > +                                                     &env->max_branc=
hes,
> > > +                                                     &env->br_cntr_n=
r,
> > > +                                                     &env->br_cntr_w=
idth);
> > > +       }
> > > +
> > > +       pmu_caps =3D zalloc(sizeof(*pmu_caps) * nr_pmu);
> > > +       if (!pmu_caps)
> > > +               return -ENOMEM;
> > > +
> > > +       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > > +               if (perf_pmu__caps_parse(pmu) <=3D 0)
> > > +                       continue;
> > > +               ret =3D __perf_env__read_core_pmu_caps(pmu, &pmu_caps=
[i].nr_caps,
> > > +                                                    &pmu_caps[i].cap=
s,
> > > +                                                    &pmu_caps[i].max=
_branches,
> > > +                                                    &pmu_caps[i].br_=
cntr_nr,
> > > +                                                    &pmu_caps[i].br_=
cntr_width);
> > > +               if (ret)
> > > +                       goto error;
> > > +
> > > +               pmu_caps[i].pmu_name =3D strdup(pmu->name);
> > > +               if (!pmu_caps[i].pmu_name) {
> > > +                       ret =3D -ENOMEM;
> > > +                       goto error;
> > > +               }
> > > +               i++;
> > > +       }
> > > +
> > > +       env->nr_pmus_with_caps =3D nr_pmu;
> > > +       env->pmu_caps =3D pmu_caps;
> > > +
> > > +       return 0;
> > > +error:
> > > +       for (i =3D 0; i < nr_pmu; i++) {
> > > +               for (j =3D 0; j < pmu_caps[i].nr_caps; j++)
> > > +                       free(pmu_caps[i].caps[j]);
> > > +               free(pmu_caps[i].caps);
> > > +               free(pmu_caps[i].pmu_name);
> > > +       }
> > > +       free(pmu_caps);
> > > +       return ret;
> > > +}
> > > +
> > >  const char *perf_env__raw_arch(struct perf_env *env)
> > >  {
> > >         return env && !perf_env__read_arch(env) ? env->arch : "unknow=
n";
> > > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > > index d90e343cf1fa..135a1f714905 100644
> > > --- a/tools/perf/util/env.h
> > > +++ b/tools/perf/util/env.h
> > > @@ -152,6 +152,7 @@ struct btf_node;
> > >
> > >  extern struct perf_env perf_env;
> > >
> > > +int perf_env__read_core_pmu_caps(struct perf_env *env);
> > >  void perf_env__exit(struct perf_env *env);
> > >
> > >  int perf_env__kernel_is_64_bit(struct perf_env *env);
> > > --
> > > 2.49.0
> > >
> >
>
