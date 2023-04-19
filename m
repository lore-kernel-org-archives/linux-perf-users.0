Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442ECC77B73
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 23:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjDSXWT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 19:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDSXWS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 19:22:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4A19A
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 16:22:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51452556acdso252260a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1681946531; x=1684538531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En09xFPrxukQPGMrtSxoWS7NIY2dUf28Hw9SmizN5E8=;
        b=gS2MMLbFXaic3E2igi5ue9CWwyEXnWQRGzKJ5oiJ2o2NNz/2gbNDIkxOI4YfEhZ0sV
         +Wi7JatdplmXdoabzjUOh2fazYKcndAZgN+dlrK95xWPAaotKWUHY9ehrqMgTIA0Wh1t
         ByBEmI0ASVpSTgXq8dXOaktN4gtTDYkpn2gmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681946531; x=1684538531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En09xFPrxukQPGMrtSxoWS7NIY2dUf28Hw9SmizN5E8=;
        b=NM8dGRHB6Us84IN4q+tW4WGYOFkYZjRPJm+9DhvPl2KFyfdXNfsrBfBeOCTev1coqj
         zB42zqrYIBsn33iNq4J+Vgn0lzh1Kl6AfLrHw4pZafNV6kRwAxUpjYGEqBj5/K5o/FFo
         LIUaTNzx+bOHwoyHHp4+qNAL/ZTQEENrCTvWR7Qe/bXAxIFXVSxEoIF6MSkB2CF3qpYl
         a2KUbgaAmhB74FHJWj4I2J5SZGDrit5ipsNKPWx95W9ObjPJUW8ePE6lbUh8nS+xukU7
         llbNgHpusLBJhI1AJS+LnEtQUXbhoVurSrBllfgX9xpKj38vuuSM+AItR92VBnn07XFS
         DXLw==
X-Gm-Message-State: AAQBX9dm8VHhMVsPputrA4zZVAoWjLJeVy+JuV5VYfMAHGgOx2YVaNWJ
        Xa2kUo0nQ8M+J9lxo8Le5xu/4XTJZo7B2Ohy3rSm
X-Google-Smtp-Source: AKy350aChvSnivLcUF7wRVT9Tts2Lp5tgA2pMNS5kQFeqIKwNTpjWzEMnaCkhSSO++g8H5/BvYo3D96AB1h1z09XTJw=
X-Received: by 2002:a17:90b:4c8e:b0:23f:9448:89c2 with SMTP id
 my14-20020a17090b4c8e00b0023f944889c2mr4380591pjb.7.1681946530740; Wed, 19
 Apr 2023 16:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
 <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com> <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
 <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com>
 <CAOnJCULJfSN79MzAwhCrbVzG1rYyrPB3OraFmoZFBxuRCwq01w@mail.gmail.com>
 <CAHVXubjhORBEDok_Zhq5p_Yv4Ty4Hct84dWJZXzo48+40N=CGg@mail.gmail.com> <CAP-5=fX6kaZt68UbMMZzW-zs0RyRWoOS-Tq5NwekWj8k9Shx6g@mail.gmail.com>
In-Reply-To: <CAP-5=fX6kaZt68UbMMZzW-zs0RyRWoOS-Tq5NwekWj8k9Shx6g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 20 Apr 2023 04:51:58 +0530
Message-ID: <CAOnJCU+5EQp-AqrwJpBo6ZPWfybwaGyD3zcC0YrCAsSY4=fqdw@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Ian Rogers <irogers@google.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        paranlee <p4ranlee@gmail.com>,
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
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 19, 2023 at 11:13=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Apr 19, 2023 at 2:21=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Apr 18, 2023 at 10:30=E2=80=AFPM Atish Patra <atishp@atishpatra=
.org> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 11:46=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Atish Patra <atishp@atishpa=
tra.org> wrote:
> > > > >
> > > > > On Fri, Apr 14, 2023 at 2:40=E2=80=AFAM David Laight <David.Laigh=
t@aculab.com> wrote:
> > > > > >
> > > > > > From: Atish Patra
> > > > > > > Sent: 13 April 2023 20:18
> > > > > > >
> > > > > > > On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <alex=
ghiti@rivosinc.com> wrote:
> > > > > > > >
> > > > > > > > riscv used to allow direct access to cycle/time/instret cou=
nters,
> > > > > > > > bypassing the perf framework, this patchset intends to allo=
w the user to
> > > > > > > > mmap any counter when accessed through perf. But we can't b=
reak the
> > > > > > > > existing behaviour so we introduce a sysctl perf_user_acces=
s like arm64
> > > > > > > > does, which defaults to the legacy mode described above.
> > > > > > > >
> > > > > > >
> > > > > > > It would be good provide additional direction for user space =
packages:
> > > > > > >
> > > > > > > The legacy behavior is supported for now in order to avoid br=
eaking
> > > > > > > existing software.
> > > > > > > However, reading counters directly without perf interaction m=
ay
> > > > > > > provide incorrect values which
> > > > > > > the userspace software must avoid. We are hoping that the use=
r space
> > > > > > > packages which
> > > > > > > read the cycle/instret directly, will move to the proper inte=
rface
> > > > > > > eventually if they actually need it.
> > > > > > > Most of the users are supposed to read "time" instead of "cyc=
le" if
> > > > > > > they intend to read timestamps.
> > > > > >
> > > > > > If you are trying to measure the performance of short code
> > > > > > fragments then you need pretty much raw access directly to
> > > > > > the cycle/clock count register.
> > > > > >
> > > > > > I've done this on x86 to compare the actual cycle times
> > > > > > of different implementations of the IP checksum loop
> > > > > > (and compare them to the theoretical limit).
> > > > > > The perf framework just added far too much latency,
> > > > > > only directly reading the cpu registers gave anything
> > > > > > like reliable (and consistent) answers.
> > > > > >
> > > > >
> > > > > This series allows direct access to the counters once configured
> > > > > through the perf.
> > > > > Earlier the cycle/instret counters are directly exposed to the
> > > > > userspace without kernel/perf frameworking knowing
> > > > > when/which user space application is reading it. That has securit=
y implications.
> > > > >
> > > > > With this series applied, the user space application just needs t=
o
> > > > > configure the event (cycle/instret) through perf syscall.
> > > > > Once configured, the userspace application can find out the count=
er
> > > > > information from the mmap & directly
> > > > > read the counter. There is no latency while reading the counters.
> > > > >
> > > > > This mechanism allows stop/clear the counters when the requesting=
 task
> > > > > is not running. It also takes care of context switching
> > > > > which may result in invalid values as you mentioned below. This i=
s
> > > > > nothing new and all other arch (x86, ARM64) allow user space
> > > > > counter read through the same mechanism.
> > > > >
> > > > > Here is the relevant upstream discussion:
> > > > > https://lore.kernel.org/lkml/Y7wLa7I2hlz3rKw%2F@hirez.programming=
.kicks-ass.net/T/
> > > > >
> > > > > ARM64:
> > > > > https://docs.kernel.org/arm64/perf.html?highlight=3Dperf_user_acc=
ess#perf-userspace-pmu-hardware-counter-access
> > > > >
> > > > > example usage in x86:
> > > > > https://github.com/andikleen/pmu-tools/blob/master/jevents/rdpmc.=
c
> > > >
> > > > The canonical implementation of this should be:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/lib/perf/mmap.c#n400
> > >
> > > Thanks for sharing the libperf implementation.
> > >
> > > > which is updated in these patches but the tests are not:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/tools/perf/tests/mmap-basic.c#n287
> > > > Which appears to be an oversight. The tests display some difference=
s
> > >
> > > Yes. It's an oversight. We should make sure that perf mmap tests pass
> > > for RISC-V as well.
> >
> > Yes, that's an oversight, I had a local test adapted from this one but
> > forgot to update it afterwards, I'll do that in the next version.
> >
> > Thanks for your quick feedbacks and sorry for being late,
> >
> > Alex
>
> Thanks Alex, there was an equally likely chance that I wasn't
> understanding things :-) Is there any information on RISC-V PMU
> testing? I know ParanLee is interested. It'd be awesome to have

Are you looking for something specific to RISC-V general or perf on RISC-V?
All the RISC-V PMU patches have been upstream for a while (both in the
Qemu & Linux kernel).
Perf should work out-of-the box when you boot the latest kernel in the
latest version of the Qemu.

Initial KVM[1] patches support got merged during the last merge
window. It doesn't support
event sampling yet. We are working on that.

[1] https://lore.kernel.org/lkml/20230207095529.1787260-1-atishp@rivosinc.c=
om/

> something say on:
> https://perf.wiki.kernel.org/index.php/Main_Page
> on how to run tests, perhaps on QEMU or known to work boards. We can
> also just drop a link on there if there is information. We can also
> add the RISC-V PMU information to the links here:
> https://perf.wiki.kernel.org/index.php/Useful_Links
>

I did not see any arch specific information there. Let us know what
would be good to
add there and we would be happy to add.

> Thanks,
> Ian
>
> >
> > >
> > >
> > > > between x86 and aarch64 that have assumed userspace hardware counte=
r
> > > > access, and everything else that it is assumed don't.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > > Clearly process switches (especially cpu migrations) cause
> > > > > > problems, but they are obviously invalid values and can
> > > > > > be ignored.
> > > > > >
> > > > > > So while a lot of uses may be 'happy' with the values the
> > > > > > perf framework gives, sometimes you do need to directly
> > > > > > read the relevant registers.
> > > > > >
> > > > > >         David
> > > > > >
> > > > > > -
> > > > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton K=
eynes, MK1 1PT, UK
> > > > > > Registration No: 1397386 (Wales)
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Regards,
> > > > > Atish
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish



--=20
Regards,
Atish
