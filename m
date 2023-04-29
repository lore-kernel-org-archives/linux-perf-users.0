Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D0C7618E
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 06:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjD2GTt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 02:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjD2GTs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 02:19:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4452122
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 23:19:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-246fa478d45so692933a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1682749185; x=1685341185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTMjDk3SOgiCPjxuLxhArxtC95/xlU4WSt6SJxU0e7Y=;
        b=XyLmSLRRw5vhwFunIep9bCU9Ptv8zJooq6+MLDBGrovDSvagRv6kBI6twD+YR78KiG
         BeEetk1c26wanqo2urmTL/brQ9DSTPDvQi403y65gx4fJSSvfG/Xk14q2glr2oRKHS/T
         h2ievV6hgV6lbgRlb6Vj2FQy/RghnjYGNW+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682749185; x=1685341185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTMjDk3SOgiCPjxuLxhArxtC95/xlU4WSt6SJxU0e7Y=;
        b=haKcmnfS34kni2VAxyj9F5fpKdBUiEiHXb8J/jD8y4StYrNDJ3zoFjY4XI+J81Xi/3
         ZeaitUpZ4WXmgoNEkKj42q5S6NhFxbz8AfMoNEW5DZZGIPdhFxr5RMjdTUYLcw3z/X7c
         uoFsqQs3gUjbOgbDINO0dgICvtJexwKGpQpaz0por1s+eQW0sZJn89+P1BffxEvMcZS1
         2/REFKNXZ50Kpj0hqDEJu+aSLaWV0mrJwUMM4t8hIUoV7ng6H5G159z5BnGHqBBdTgiF
         te+wCAgGyrtVMJzOodWGcnB8jrWeVOim+OOT6WKJkSA0xTnn5LPg2tspqVHNBIzqG5ai
         OuXw==
X-Gm-Message-State: AC+VfDyfg1dntKP+kc+AF6bZrgfRhH8PiQ/eDEP/GH2I2qvXxCHembvf
        32eYIPLdKYlebb0viCDeEEzlsEGEcbX8mGKLg3HK
X-Google-Smtp-Source: ACHHUZ4LhwwR0e1B330AbEkd5AimnCzdBqVUhs/POzba4tZ0rYglv0TK7U3GChiM2m5G/Kut356agp6Sgo1hYtHMuJk=
X-Received: by 2002:a17:90b:1b03:b0:246:681c:71fd with SMTP id
 nu3-20020a17090b1b0300b00246681c71fdmr7622447pjb.6.1682749184993; Fri, 28 Apr
 2023 23:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-5-alexghiti@rivosinc.com> <kwvrls2m6swp443brn27jwcsdhovtc4kxrkqustxpqgf7zqltw@xlhsrndkf4om>
 <CAHVXubh_y9Uw2xsgsQrVZEcb9bCLBLUCo74GOm-czsSawHxk4g@mail.gmail.com> <3bwxedsrovutzhlmlnozeuvz4zqnr32kuef2mdzmnbniajh6vb@we6jzlwkfuof>
In-Reply-To: <3bwxedsrovutzhlmlnozeuvz4zqnr32kuef2mdzmnbniajh6vb@we6jzlwkfuof>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 29 Apr 2023 11:49:33 +0530
Message-ID: <CAOnJCU+xL1qP0zj9rD0d9nix-tSd-yfQnToDXCdHveTKQN_rUA@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through perf
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        David Abdurachmanov <davidlt@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Andreas Schwab <schwab@suse.de>, mafm@debian.org,
        aurel32@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 26, 2023 at 6:55=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Apr 26, 2023 at 03:17:01PM +0200, Alexandre Ghiti wrote:
> > On Wed, Apr 26, 2023 at 2:57=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Thu, Apr 13, 2023 at 06:17:25PM +0200, Alexandre Ghiti wrote:
> > > > We used to unconditionnally expose the cycle and instret csrs to
> > > > userspace, which gives rise to security concerns.
> > > >
> > > > So only allow access to hw counters from userspace through the perf
> > > > framework which will handle context switchs, per-task events...etc.=
 But
> > > > as we cannot break userspace, we give the user the choice to go bac=
k to
> > > > the previous behaviour by setting the sysctl perf_user_access.
> > > >
> > > > We also introduce a means to directly map the hardware counters to
> > > > userspace, thus avoiding the need for syscalls whenever an applicat=
ion
> > > > wants to access counters values.
> > > >
> > > > Note that arch_perf_update_userpage is a copy of arm64 code.
> > > >
> > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >  Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
> > > >  arch/riscv/include/asm/perf_event.h         |   3 +
> > > >  arch/riscv/kernel/Makefile                  |   2 +-
> > > >  arch/riscv/kernel/perf_event.c              |  65 +++++++++++
> > > >  drivers/perf/riscv_pmu.c                    |  42 ++++++++
> > > >  drivers/perf/riscv_pmu_legacy.c             |  17 +++
> > > >  drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++++=
++--
> > > >  include/linux/perf/riscv_pmu.h              |   3 +
> > > >  tools/lib/perf/mmap.c                       |  65 +++++++++++
> > > >  9 files changed, 322 insertions(+), 11 deletions(-)
> > > >  create mode 100644 arch/riscv/kernel/perf_event.c
> > > >
> > > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Document=
ation/admin-guide/sysctl/kernel.rst
> > > > index 4b7bfea28cd7..02b2a40a3647 100644
> > > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > > @@ -941,16 +941,31 @@ enabled, otherwise writing to this file will =
return ``-EBUSY``.
> > > >  The default value is 8.
> > > >
> > > >
> > > > -perf_user_access (arm64 only)
> > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +perf_user_access (arm64 and riscv only)
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Controls user space access for reading perf event counters.
> > > >
> > > > -Controls user space access for reading perf event counters. When s=
et to 1,
> > > > -user space can read performance monitor counter registers directly=
.
> > > > +arm64
> > > > +=3D=3D=3D=3D=3D
> > > >
> > > >  The default value is 0 (access disabled).
> > > > +When set to 1, user space can read performance monitor counter reg=
isters
> > > > +directly.
> > > >
> > > >  See Documentation/arm64/perf.rst for more information.
> > > >
> > > > +riscv
> > > > +=3D=3D=3D=3D=3D
> > > > +
> > > > +When set to 0, user access is disabled.
> > > > +
> > > > +When set to 1, user space can read performance monitor counter reg=
isters
> > > > +directly only through perf, any direct access without perf interve=
ntion will
> > > > +trigger an illegal instruction.
> > > > +
> > > > +The default value is 2, it enables the legacy mode, that is user s=
pace has
> > > > +direct access to cycle, time and insret CSRs only.
> > >
> > > I think this default value should be a Kconfig symbol, allowing kerne=
ls to
> > > be built with a secure default.
> >
> > Actually I was more in favor of having the default to 1 (ie the secure
> > option) and let the distros deal with the legacy mode (via a sysctl
> > parameter on the command line) as long as user-space has not been
> > fixed: does that make sense?
>
> Yes, I'd prefer that too. I assumed the default was 2 in this patch
> because we couldn't set it to 1 for some reason.
>

I would prefer that too. However, it was set to 2 because it would break
the user space application depending on the legacy behavior as soon as the
patches are upstream. That is the reason
palmer suggested keeping the default value to 2 in order to avoid that.

+distro folks (cc'd)
If the distro maintainer can confirm that this would be a non-issue, I am o=
kay
with setting the default to 1.


> Thanks,
> drew



--=20
Regards,
Atish
