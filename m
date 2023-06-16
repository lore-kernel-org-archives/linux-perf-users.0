Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FFFEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 16:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjFPQ23 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjFPQ21 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 12:28:27 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C030E7
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 09:28:25 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so178375ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686932905; x=1689524905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt/odpIENS5F3tOg3HM+m3wYhBUO+XK9zkF22VpEHPI=;
        b=s8bMj2o/2aozmhk32XrGlusvPbTLZ2AlLWxn8a/VDxNlMeAi7mMBJDByQrwXkEX2Sm
         5YR42CiwrjBW6hgMdhQgwUTHLvIEKo8zmrBiwCedkuz1o5Pt0C0llnyEO3k82a+2IERI
         dcPZbJYXzk0M0kuiiwyb8gjYprkBXjth7vlp/iJGzQk/kTDabeJECBpsXC/VWrgh6UUN
         cOLBghOLHSPMP2+j3e2ySfOZ0ERFZoxykQrSojCwA6XiWEkc1EuhlsPjjtGV+CExwSlr
         H6dbPIpDR1X29iuTbewUY8v+tMo+ymEiBXHAGZTs2+CjD+QGQSJr/Pavp2fcqiDmOKA1
         tgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686932905; x=1689524905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt/odpIENS5F3tOg3HM+m3wYhBUO+XK9zkF22VpEHPI=;
        b=TgFZbyZNYkJ49XD0k3MU+F00MGnGDO/bfhkJb/vASetqXnOqc3UNLyXjlMo7g7alz1
         g9U3PW6VsCfShvtVucZmtTg56C6l2lLI8tXoKFfVLSPfOsffZPZI/QsIuFNI8c6Igw+R
         f7fHk7xmxqhh39HWAsRcvOjjWJ0fNII398KqoKxaHIGW4VCL5C0Qwei2M2p2L6aGtkNF
         jipS0BN84hlH30twvZhz5HxMx6jWrcKjaUvwlSkcU6Ehdb4vTmkiK7Ogtz5Y8YxjYOcS
         S8dmaTkI6LnRF8M0nAdQMUWORgTNs63h+58Xi0cWn7SztCa4FjD80Rq4E4B/C1Fb3E1K
         RY1w==
X-Gm-Message-State: AC+VfDwvmv1c3XPiI6JIgRHjPV5pPfW8faKUTzjbVKbaeV/lEerlMsZ1
        MlvXltlDRg+XELOtDQ8sGgeZDPK2LCbksZiU0mMZMg==
X-Google-Smtp-Source: ACHHUZ6+/eAbL01JGsVjhwttbReXd3RRuh1/g3aj7z8882zuqimUMjWl8mVshpa9kryTWdreCg/c5PkHYhQ86QueXpE=
X-Received: by 2002:a05:6e02:156c:b0:33b:4a8c:2147 with SMTP id
 k12-20020a056e02156c00b0033b4a8c2147mr474661ilu.8.1686932904775; Fri, 16 Jun
 2023 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com> <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
 <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com> <ZIshkbmQR7oOFiHu@kernel.org>
 <CAP-5=fVYy6jMd9Nw7iqqsm_G-qW__Lo8kFeCocJ0W2no4XTbpg@mail.gmail.com>
 <ZIxza13x+AwApbQb@kernel.org> <ZIx1Y9mWc13huQt2@kernel.org>
In-Reply-To: <ZIx1Y9mWc13huQt2@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 16 Jun 2023 09:28:12 -0700
Message-ID: <CAP-5=fVpU6Bm1REcANEu2qsE5eQH2VOx2uz+X0VSoH76r_d7uQ@mail.gmail.com>
Subject: Re: Hybrid PMU issues on aarch64. was: Re: perf test failures in
 linux-next on s390
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 16, 2023 at 7:44=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 16, 2023 at 11:36:27AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > > > I noticed this on an arm64 board:
> >
> > > > acme@roc-rk3399-pc:~/git/perf-tools-next$ perf stat -e cycles:u,ins=
tructions:u ls
> > > > COPYING  CREDITS  Documentation  Kbuild  Kconfig  LICENSES  MAINTAI=
NERS  Makefile  README  arch  block  certs  crypto  drivers  fs  include  i=
nit  io_uring  ipc  kernel  lib  mm  net  perf.data  rust  samples  scripts=
  security  sound  tools  usr  virt
> >
> > > >  Performance counter stats for 'ls':
> >
> > > >    <not supported>      armv8_cortex_a72/cycles:u/
> > > >    <not supported>      armv8_cortex_a53/cycles:u/
> > > >    <not supported>      armv8_cortex_a72/instructions:u/
> > > >    <not supported>      armv8_cortex_a53/instructions:u/
> >
> > > I tested on a raspberry pi and perf-tools-next is working there. I
> > > suspect the issue here is the heterogeneous PMU. The cycles event is
> > > converted into a perf_event_attr with type 0 and config 0. When there
> > > are heterogeneous PMUs then we try to use the extended type to say we
> > > want armv8_cortex_a72 and armv8_cortex_a53 cycles events. Let's say
> > > the type number of armv8_cortex_a72 and armv8_cortex_a53 PMUs are 9
> > > and 10 respectively. With heterogeneous encodings the type in the
> >
> > The numbers are 8 and 7, PERF_TYPE_HW (thus zero, thus not printed):
> >
> > root@roc-rk3399-pc:~# perf stat -vv -e cycles sleep 1
> > Using CPUID 0x00000000410fd080
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   size                             136
> >   config                           0x800000000
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 13885  cpu -1  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -2
> > Warning:
> > cycles event is not supported by the kernel.
> > ------------------------------------------------------------
> > perf_event_attr:
> >   size                             136
> >   config                           0x700000000
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 13885  cpu -1  group_fd -1  flags 0x8
> > sys_perf_event_open failed, error -2
> > Warning:
> > cycles event is not supported by the kernel.
> > failed to read counter cycles
> > failed to read counter cycles
> >
> >  Performance counter stats for 'sleep 1':
> >
> >    <not supported>      armv8_cortex_a72/cycles/
> >    <not supported>      armv8_cortex_a53/cycles/
> >
> >        1.011406938 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.010886000 seconds sys
> >
> >
> > root@roc-rk3399-pc:~#
> >
> > > perf_event_attr remains as 0 and the config becomes 9 << 32 and 10 <<
> > > 32. I suspect your kernel is seeing the extended type information and
> > > not handling it, hence the error.
> >
> > looks this is the case indeed
> >
> > > We add in the extended type for hardware and legacy cache events in
> > > the parse events code:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/parse-events.c?h=3Dperf-tools-next#n435
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/parse-events.c?h=3Dperf-tools-next#n1239
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/parse-events.c?h=3Dperf-tools-next#n1478
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/parse-events.c?h=3Dperf-tools-next#n1511
> > >
> > > The addition of the extended type happens if
> > > perf_pmus__supports_extended_type() returns true, its implementation
> > > is:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/pmus.c?h=3Dperf-tools-next#n480
> > > bool perf_pmus__supports_extended_type(void)
> > > {
> > >   return perf_pmus__num_core_pmus() > 1;
> > > }
> > >
> > > Previously on heterogeneous ARM the extended type wouldn't be encoded
> > > and I believe the event was opened on the PMU of the current CPU only=
.
> >
> > I think that is the case, haven't checked so far tho.
> >
> > > This is a bug because you will not count events on all PMUs. We can
> > > make perf_pmus__supports_extended_type return false on ARM which
> > > should bring back the previous behavior - or do some kind of dynamic
> >
> > simplest first step, trying it.
>
> Spot on:
>
> acme@roc-rk3399-pc:~/git/perf-tools-next$ perf stat ls
> COPYING  CREDITS  Documentation  Kbuild  Kconfig  LICENSES  MAINTAINERS  =
Makefile  README  arch  block  certs  crypto  drivers  fs  include  init  i=
o_uring  ipc  kernel  lib  mm  net  rust  samples  scripts  security  sound=
  tools  usr  virt
>
>  Performance counter stats for 'ls':
>
>               9.01 msec task-clock:u                     #    0.401 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 84      page-faults:u                    #    9.320 K/sec
>            1188641      cycles:u                         #    0.132 GHz
>             601132      instructions:u                   #    0.51  insn =
per cycle
>              64768      branches:u                       #    7.186 M/sec
>              11680      branch-misses:u                  #   18.03% of al=
l branches
>
>        0.022502514 seconds time elapsed
>
>        0.000000000 seconds user
>        0.022946000 seconds sys
>
>
> acme@roc-rk3399-pc:~/git/perf-tools-next$
> acme@roc-rk3399-pc:~/git/perf-tools-next$ perf record ls
> COPYING  CREDITS  Documentation  Kbuild  Kconfig  LICENSES  MAINTAINERS  =
Makefile  README  arch  block  certs  crypto  drivers  fs  include  init  i=
o_uring  ipc  kernel  lib  mm  net  perf.data  rust  samples  scripts  secu=
rity  sound  tools  usr  virt
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.003 MB perf.data (18 samples) ]
> acme@roc-rk3399-pc:~/git/perf-tools-next$ perf evlist
> cycles:Pu
> dummy:HGu
> acme@roc-rk3399-pc:~/git/perf-tools-next$ ldd ~/bin/perf | grep asan
>         libasan.so.6 =3D> /lib/aarch64-linux-gnu/libasan.so.6 (0x0000ffff=
a5a00000)
> acme@roc-rk3399-pc:~/git/perf-tools-next$
>
> With the following patch. Do you want to submit it or may I add it as is
> using an edited discussion in this thread as the commit log message?
>
> Thanks!
>
> - Arnaldo

Hi Arnaldo,

presumably with the #ifdef you just get 1 PMU - shame. I think rather
than do an #ifdef we can do something like call is_event_supported:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/print-events.c?h=3Dperf-tools-next#n232
so:
bool perf_pmus__supports_extended_type(void)
  struct perf_pmu *pmu =3D NULL;
  if (perf_pmus__num_core_pmus() <=3D 1)
     return false;
  while((pmu =3D perf_pmus__scan_core(pmu) !=3D NULL) {
    return is_event_supported(PERF_TYPE_HARDWARE,
PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
 }
return false;
}
We probably don't want to do this for each call of
perf_pmus__supports_extended_type so you could use a static and
pthread_once, etc.

This would mean if this regression is introduced elsewhere than ARM it
will self heal. It will also mean that when ARM support extended types
in the kernel, they will get the normal heterogeneous behavior.

Thanks,
Ian

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index a2032c1b7644..9af961105a64 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -494,7 +494,13 @@ int perf_pmus__num_core_pmus(void)
>
>  bool perf_pmus__supports_extended_type(void)
>  {
> +#if defined(__aarch64__)
> +       // We can't use the extended type information where the PMU numbe=
r
> +       // is encoded in the upper perf_event_attr::type bits. (<< 32).
> +       return false;
> +#else
>         return perf_pmus__num_core_pmus() > 1;
> +#endif
>  }
>
>  struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
