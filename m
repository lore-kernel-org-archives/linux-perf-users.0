Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B659AC6FD18
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 09:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjDSJWB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjDSJV7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 05:21:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6827EF5
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 02:21:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f17fdb520dso3826375e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681896116; x=1684488116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAmu28kxLfR9NTfen8lHbOqBR0jDTxdhWjN1lCSkxww=;
        b=qWvcZD73Z6cOha96J3xLud8w5LQTe6iScTpVZFAPXvGLo0CnNN2dehEAXwaBIO3eok
         XIc6PcDg9XXobUFHr9efZeKcYdlrg8srbqjND0jGsJlJAZ4dTtcIVFXTFuhz7AIBQvEg
         ZZVGkOudvVLfFTdXxb2Jd9XiDTdVZ5nVIteGKUuUYdpCgCNj8LS8NISEpRcnoW47g8Kr
         QCLnR0ufv7AaHwPv8mIHoKK8U+FeW68U43gohfAdwa905Q+NgPfEUn9v8z4Rpoc2GeZl
         VY8USDNsGy2k+wd7tEhTYxE08TvDrwrrIXfwlmNRDIG8cp5hWe1J/AaFMuAToObpTndD
         b6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896116; x=1684488116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAmu28kxLfR9NTfen8lHbOqBR0jDTxdhWjN1lCSkxww=;
        b=MvWv3L/g4cVTIjCx/TXRBhmT6C8t0g5D1GdQItLBFNLM5UGBi7fDy/sseBrn/gWihE
         1ncx23NzY5Q1PsMbFcaICNeTh59fCuQ7K3QmzKimVgVVbXaSkEDW353JFmZkb2MRsoU6
         B/gT79pKM+YKwtMISgnMzJKm/JRz2i82/Pblphz5RKh29tzBuEFftrPyWqG1UpESwG5Z
         dXTwIB5dTQckZO5eUJWRVyPpThqi65KmfPRc/5nmMhoPiZiA60WI9MXJl6UQZbvLFDkl
         JyOkYDSP9OP8cVDIxkyqJPVX/rwwrJgymoZ6hv8o+8znf5NIwen6y8lKwcngovD+WgeP
         chUw==
X-Gm-Message-State: AAQBX9eMW2sOv+e+Yui7sfJSMWGHOmPY/qd1Q+t0DIvsmxedxKNHdv5y
        1xy+UHbejnQO1IrCL/MGkpD1XzHj9toeR/GWK5+zOQ==
X-Google-Smtp-Source: AKy350b9MkaNChMF/AjQaCfRI1fZFovklEGmb+podkO111Slr+0lmRQslEdedi7oC6DvmLa1dCn56Gj7l/AUZ4rU7zQ=
X-Received: by 2002:a5d:4811:0:b0:2f8:2d4:74ef with SMTP id
 l17-20020a5d4811000000b002f802d474efmr4221973wrq.43.1681896116610; Wed, 19
 Apr 2023 02:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
 <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com> <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
 <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com> <CAOnJCULJfSN79MzAwhCrbVzG1rYyrPB3OraFmoZFBxuRCwq01w@mail.gmail.com>
In-Reply-To: <CAOnJCULJfSN79MzAwhCrbVzG1rYyrPB3OraFmoZFBxuRCwq01w@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 19 Apr 2023 11:21:45 +0200
Message-ID: <CAHVXubjhORBEDok_Zhq5p_Yv4Ty4Hct84dWJZXzo48+40N=CGg@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Ian Rogers <irogers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        paranlee <p4ranlee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Tue, Apr 18, 2023 at 10:30=E2=80=AFPM Atish Patra <atishp@atishpatra.org=
> wrote:
>
> On Tue, Apr 18, 2023 at 11:46=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Atish Patra <atishp@atishpatra.=
org> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 2:40=E2=80=AFAM David Laight <David.Laight@ac=
ulab.com> wrote:
> > > >
> > > > From: Atish Patra
> > > > > Sent: 13 April 2023 20:18
> > > > >
> > > > > On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > > >
> > > > > > riscv used to allow direct access to cycle/time/instret counter=
s,
> > > > > > bypassing the perf framework, this patchset intends to allow th=
e user to
> > > > > > mmap any counter when accessed through perf. But we can't break=
 the
> > > > > > existing behaviour so we introduce a sysctl perf_user_access li=
ke arm64
> > > > > > does, which defaults to the legacy mode described above.
> > > > > >
> > > > >
> > > > > It would be good provide additional direction for user space pack=
ages:
> > > > >
> > > > > The legacy behavior is supported for now in order to avoid breaki=
ng
> > > > > existing software.
> > > > > However, reading counters directly without perf interaction may
> > > > > provide incorrect values which
> > > > > the userspace software must avoid. We are hoping that the user sp=
ace
> > > > > packages which
> > > > > read the cycle/instret directly, will move to the proper interfac=
e
> > > > > eventually if they actually need it.
> > > > > Most of the users are supposed to read "time" instead of "cycle" =
if
> > > > > they intend to read timestamps.
> > > >
> > > > If you are trying to measure the performance of short code
> > > > fragments then you need pretty much raw access directly to
> > > > the cycle/clock count register.
> > > >
> > > > I've done this on x86 to compare the actual cycle times
> > > > of different implementations of the IP checksum loop
> > > > (and compare them to the theoretical limit).
> > > > The perf framework just added far too much latency,
> > > > only directly reading the cpu registers gave anything
> > > > like reliable (and consistent) answers.
> > > >
> > >
> > > This series allows direct access to the counters once configured
> > > through the perf.
> > > Earlier the cycle/instret counters are directly exposed to the
> > > userspace without kernel/perf frameworking knowing
> > > when/which user space application is reading it. That has security im=
plications.
> > >
> > > With this series applied, the user space application just needs to
> > > configure the event (cycle/instret) through perf syscall.
> > > Once configured, the userspace application can find out the counter
> > > information from the mmap & directly
> > > read the counter. There is no latency while reading the counters.
> > >
> > > This mechanism allows stop/clear the counters when the requesting tas=
k
> > > is not running. It also takes care of context switching
> > > which may result in invalid values as you mentioned below. This is
> > > nothing new and all other arch (x86, ARM64) allow user space
> > > counter read through the same mechanism.
> > >
> > > Here is the relevant upstream discussion:
> > > https://lore.kernel.org/lkml/Y7wLa7I2hlz3rKw%2F@hirez.programming.kic=
ks-ass.net/T/
> > >
> > > ARM64:
> > > https://docs.kernel.org/arm64/perf.html?highlight=3Dperf_user_access#=
perf-userspace-pmu-hardware-counter-access
> > >
> > > example usage in x86:
> > > https://github.com/andikleen/pmu-tools/blob/master/jevents/rdpmc.c
> >
> > The canonical implementation of this should be:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/lib/perf/mmap.c#n400
>
> Thanks for sharing the libperf implementation.
>
> > which is updated in these patches but the tests are not:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/tests/mmap-basic.c#n287
> > Which appears to be an oversight. The tests display some differences
>
> Yes. It's an oversight. We should make sure that perf mmap tests pass
> for RISC-V as well.

Yes, that's an oversight, I had a local test adapted from this one but
forgot to update it afterwards, I'll do that in the next version.

Thanks for your quick feedbacks and sorry for being late,

Alex


>
>
> > between x86 and aarch64 that have assumed userspace hardware counter
> > access, and everything else that it is assumed don't.
> >
> > Thanks,
> > Ian
> >
> > > > Clearly process switches (especially cpu migrations) cause
> > > > problems, but they are obviously invalid values and can
> > > > be ignored.
> > > >
> > > > So while a lot of uses may be 'happy' with the values the
> > > > perf framework gives, sometimes you do need to directly
> > > > read the relevant registers.
> > > >
> > > >         David
> > > >
> > > > -
> > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keyne=
s, MK1 1PT, UK
> > > > Registration No: 1397386 (Wales)
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish
>
>
>
> --
> Regards,
> Atish
