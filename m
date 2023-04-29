Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84156C77B60
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 06:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjD2Guf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 02:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjD2Gue (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 02:50:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9372696
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 23:50:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5144043d9d1so411472a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 23:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1682751031; x=1685343031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UhLj8G0RcQUtsKhKUXfnhL7zuYYyQ7vxUKRWYdX3To=;
        b=kl5IGW/Q3ziJZox5rl+u6Pls+orvxgrZh7dIcOOMrHC3T+7UehfcLxH/5OXNGM61OK
         LeNapk1MFK9ZdPD+3yGP8whyGPsLJvuM/JdqjpVdy3soAh0+inT2wfUcCbvKGF/byerP
         uViGf7E40KXqnWzIXzvuPPnVBhiSor/hPtMoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682751031; x=1685343031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UhLj8G0RcQUtsKhKUXfnhL7zuYYyQ7vxUKRWYdX3To=;
        b=M0CvA0X/XOhN3hHVm8yHH403PJnKAN6Z1HqFNryeWL59iHk/n/cIfn5NAIXz9dXq+y
         YomYtJdIGc1MOfHs1LIIug/XHKxrUUqoknJM2sLQvWXHhA86uWlVcd3gAGN1Ksz/zhHZ
         R2jPbnmUNtLZh8NByQSUhYFnA2AV/Rmf54yQn4gwQ9wYtlUECWvfrsMRF7vIfi4Cht9f
         u7XtF2UCbgbJPM/nWikTsgqlrk7FB1Ccq76LHEZTAmlVbEfdP2IBAw7nL87nRh3UZ2SZ
         88g1YHl+9qjTD2auuf2Tc8f/zPCyOAlGDaEzdbTp2hPwYn99yR4I0j0cejL4XSmCC8Nu
         OgtA==
X-Gm-Message-State: AC+VfDxsHNi3R9+Gefvm47p80yOukPOSg3NOJi3tyb0LlIzzYfzPZ9od
        Ynol6vdipCsHfQujN/39w7Z64OQxmXeX9n6gfDMl
X-Google-Smtp-Source: ACHHUZ696dIE7IrwvV8BtWc5TacXtKoiSXfv7kuAMvB8aDSVSFFnBuVQsWCP5AhdIJRoTLbNGit9a3My/X0+KaY2+2g=
X-Received: by 2002:a05:6a21:1706:b0:ef:a31b:af8e with SMTP id
 nv6-20020a056a21170600b000efa31baf8emr8535949pzb.25.1682751031206; Fri, 28
 Apr 2023 23:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-5-alexghiti@rivosinc.com> <kwvrls2m6swp443brn27jwcsdhovtc4kxrkqustxpqgf7zqltw@xlhsrndkf4om>
 <CAHVXubh_y9Uw2xsgsQrVZEcb9bCLBLUCo74GOm-czsSawHxk4g@mail.gmail.com>
 <3bwxedsrovutzhlmlnozeuvz4zqnr32kuef2mdzmnbniajh6vb@we6jzlwkfuof> <CAOnJCU+xL1qP0zj9rD0d9nix-tSd-yfQnToDXCdHveTKQN_rUA@mail.gmail.com>
In-Reply-To: <CAOnJCU+xL1qP0zj9rD0d9nix-tSd-yfQnToDXCdHveTKQN_rUA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 29 Apr 2023 12:20:19 +0530
Message-ID: <CAOnJCUK+cXPDMiA=x7sCTt=K7rCjr7q_6aj04VR8fZUUKbrkPA@mail.gmail.com>
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

On Sat, Apr 29, 2023 at 11:49=E2=80=AFAM Atish Patra <atishp@atishpatra.org=
> wrote:
>
> On Wed, Apr 26, 2023 at 6:55=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Wed, Apr 26, 2023 at 03:17:01PM +0200, Alexandre Ghiti wrote:
> > > On Wed, Apr 26, 2023 at 2:57=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > >
> > > > On Thu, Apr 13, 2023 at 06:17:25PM +0200, Alexandre Ghiti wrote:
> > > > > We used to unconditionnally expose the cycle and instret csrs to
> > > > > userspace, which gives rise to security concerns.
> > > > >
> > > > > So only allow access to hw counters from userspace through the pe=
rf
> > > > > framework which will handle context switchs, per-task events...et=
c. But
> > > > > as we cannot break userspace, we give the user the choice to go b=
ack to
> > > > > the previous behaviour by setting the sysctl perf_user_access.
> > > > >
> > > > > We also introduce a means to directly map the hardware counters t=
o
> > > > > userspace, thus avoiding the need for syscalls whenever an applic=
ation
> > > > > wants to access counters values.
> > > > >
> > > > > Note that arch_perf_update_userpage is a copy of arm64 code.
> > > > >
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > ---
> > > > >  Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
> > > > >  arch/riscv/include/asm/perf_event.h         |   3 +
> > > > >  arch/riscv/kernel/Makefile                  |   2 +-
> > > > >  arch/riscv/kernel/perf_event.c              |  65 +++++++++++
> > > > >  drivers/perf/riscv_pmu.c                    |  42 ++++++++
> > > > >  drivers/perf/riscv_pmu_legacy.c             |  17 +++
> > > > >  drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++=
++++--
> > > > >  include/linux/perf/riscv_pmu.h              |   3 +
> > > > >  tools/lib/perf/mmap.c                       |  65 +++++++++++
> > > > >  9 files changed, 322 insertions(+), 11 deletions(-)
> > > > >  create mode 100644 arch/riscv/kernel/perf_event.c
> > > > >
> > > > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Docume=
ntation/admin-guide/sysctl/kernel.rst
> > > > > index 4b7bfea28cd7..02b2a40a3647 100644
> > > > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > > > @@ -941,16 +941,31 @@ enabled, otherwise writing to this file wil=
l return ``-EBUSY``.
> > > > >  The default value is 8.
> > > > >
> > > > >
> > > > > -perf_user_access (arm64 only)
> > > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +perf_user_access (arm64 and riscv only)
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +Controls user space access for reading perf event counters.
> > > > >
> > > > > -Controls user space access for reading perf event counters. When=
 set to 1,
> > > > > -user space can read performance monitor counter registers direct=
ly.
> > > > > +arm64
> > > > > +=3D=3D=3D=3D=3D
> > > > >
> > > > >  The default value is 0 (access disabled).
> > > > > +When set to 1, user space can read performance monitor counter r=
egisters
> > > > > +directly.
> > > > >
> > > > >  See Documentation/arm64/perf.rst for more information.
> > > > >
> > > > > +riscv
> > > > > +=3D=3D=3D=3D=3D
> > > > > +
> > > > > +When set to 0, user access is disabled.
> > > > > +
> > > > > +When set to 1, user space can read performance monitor counter r=
egisters
> > > > > +directly only through perf, any direct access without perf inter=
vention will
> > > > > +trigger an illegal instruction.
> > > > > +
> > > > > +The default value is 2, it enables the legacy mode, that is user=
 space has
> > > > > +direct access to cycle, time and insret CSRs only.
> > > >
> > > > I think this default value should be a Kconfig symbol, allowing ker=
nels to
> > > > be built with a secure default.
> > >
> > > Actually I was more in favor of having the default to 1 (ie the secur=
e
> > > option) and let the distros deal with the legacy mode (via a sysctl
> > > parameter on the command line) as long as user-space has not been
> > > fixed: does that make sense?
> >
> > Yes, I'd prefer that too. I assumed the default was 2 in this patch
> > because we couldn't set it to 1 for some reason.
> >
>
> I would prefer that too. However, it was set to 2 because it would break
> the user space application depending on the legacy behavior as soon as th=
e
> patches are upstream. That is the reason
> palmer suggested keeping the default value to 2 in order to avoid that.
>
> +distro folks (cc'd)
> If the distro maintainer can confirm that this would be a non-issue, I am=
 okay
> with setting the default to 1.
>

@David Abdurachmanov reminds me of ARM64 code where it is set to zero.
The upstream kernel doesn't even enable userspace via perf. The
default in x86 is 1 though.

+Rob Herring (who enabled the ARM64 support[1])
@Rob: If you can shed some light on the reasoning behind setting to
disabled, that would help
us make a more informed decision.

https://github.com/torvalds/linux/commit/e2012600810c9ded81f6f63a8d04781be3=
c300ad

>
> > Thanks,
> > drew
>
>
>
> --
> Regards,
> Atish



--=20
Regards,
Atish
