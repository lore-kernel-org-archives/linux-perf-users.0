Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CDEB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 18:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGDSAM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDSAL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 14:00:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC610C8
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jul 2023 11:00:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40371070eb7so194171cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jul 2023 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688493609; x=1691085609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ITVnTjoTrmW4ijtLBz3TJw3ejaiQui76i/osaEadM=;
        b=nL6Y9GDwtl7hGAF0tzesGXL5d3F30E5sGaMiUry6/ifr9JZEoW3/a+MzhABQ6Mkwj3
         J27y9GCZenvukwKahy0N8T88+RTjz8r4V4G90Ih4Ys6pRvkrgM7w1A6cCN/T9T/ZAvlq
         mdL43Euefn+3dQwtEwDvgpbH5ZNjttWmyLHNADpokSMRgqfggHxVGZTh+X1QiYAza4U4
         dWoVBy94gCANOAdpNY2aVrJVC4+AStkBJYAcgYWtBTWKqDNDBis6R875ZQQpLsar9CvS
         TvsO582yWFQ4HDLVQyh6KKnLuDHLdu4qFA+kMIiX1+CFdsxcvvv6KjMCpuSWYgGpRIKp
         alRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688493609; x=1691085609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3ITVnTjoTrmW4ijtLBz3TJw3ejaiQui76i/osaEadM=;
        b=aBccSs3rsYqTZ1bfwaAn0tMPPzasDG4QLMFQUCBssmryytYFcXsXPiSdLqts14Xiyq
         G2JeIXaAJ1KvRCvrs0jpaomaNAKwCj58uu5G096x5iITdbMw5yCgjTDk/UOOyCF/OVGc
         isNZ5KQYhOC54o+O1ZPW3WdKJGX+egc6IWvF2pMVZ1Bo0SE8p568Gkams52V3eLkCK3D
         uPuZhBWcYcqIUmCYMZuwDH/MSyff9L7n+s59nyEAzUsRcET+8yX52YbwEsZh3fDhtGJg
         DM8OBNoi8uyFe1XGQ856CmYlDfjNBLt7cdrlPtKUaYUhXoDwDJxdWjcedQXEAY8LXRTo
         AzBQ==
X-Gm-Message-State: ABy/qLYYIKwMPn9hT3ljVcfRstR56HvKeSGHfe9oWnIThms1Mshnaq/a
        LLOUwMsZlHA7BXEUoU1P18aPXiBECSh+ooaPtnBwLw==
X-Google-Smtp-Source: APBJJlGoagyPHFyXPK5x+j0U0wC1hcWCI/zsQabA0V/766yWzalcoN6N4WyKRZJKHLl7c4EaN8Uw6eodwogaT8Vrq6w=
X-Received: by 2002:ac8:5dc8:0:b0:3e3:8c75:461 with SMTP id
 e8-20020ac85dc8000000b003e38c750461mr6013qtx.6.1688493608591; Tue, 04 Jul
 2023 11:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com> <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com> <CAP-5=fXwdc4VK=6dEoD4V0Jp+unYghWYTfbN4ER2aYd9R52W1g@mail.gmail.com>
 <01bc8040-92ef-cf8b-967a-6782989ecf33@arm.com> <CAP-5=fVkRc9=ySJ=fG-SQ8oAKmE_1mhHHzSASmGHUsda5Qy92A@mail.gmail.com>
 <6310725b-cc30-49e4-d405-ed2d5f31b404@arm.com> <cc134bea-dbe3-cf41-4769-440b8c69e9b4@amd.com>
 <10d4d4b1-5611-3276-2422-c297f0530ce1@arm.com> <d10f0677-e7af-963e-faed-5228fd70b3fd@amd.com>
In-Reply-To: <d10f0677-e7af-963e-faed-5228fd70b3fd@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Jul 2023 10:59:57 -0700
Message-ID: <CAP-5=fX8xxubsV2a3Bdtd9gvmEg=qk8ehm921psUDYZ7y20s7g@mail.gmail.com>
Subject: Re: perf-tools-next: Request for testing hybrid changes
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 4, 2023 at 7:48=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> On 04-Jul-23 6:14 PM, James Clark wrote:
> >
> >
> > On 04/07/2023 13:33, Ravi Bangoria wrote:
> >>>> For heterogeneous ARM PMUs I believe this is exactly the path taken =
to
> >>>> cause the perf_event_open to fail. The resolution is to add the bit =
to
> >>>> the PMU's capabilities. I believe doing it here will suffice:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/dri=
vers/perf/arm_pmu.c?h=3Dperf/core#n877
> >>>> So:
> >>>> ```
> >>>> .capabilities =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXT=
ENDED_REGS,
> >>>> ```
> >>>> becomes:
> >>>> ```
> >>>> .capabilities =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS |
> >>>> PERF_PMU_CAP_EXTENDED_REGS | PERF_PMU_CAP_EXTENDED_HW_TYPE,
> >>>> ```
> >>>> Now strictly speaking you only need this in the case of heterogeneou=
s
> >>>> PMUs, but that's the case for other bits here and I don't see specia=
l
> >>>> case logic...
> >>>>
> >>>
> >>> Hi Ian,
> >>>
> >>> I tested the above and it seems to work fine on Arm so I will send it
> >>> shortly. Some of the legacy perf stat use cases are working better wi=
th
> >>> it so it makes sense to me. I also don't see a reason to not always d=
o
> >>> it even for homogeneous PMUs. To be honest I don't see a reason not t=
o
> >>> remove it as a capability and have it as the default behaviour
> >>> everywhere? It all happens in the core code so I'm not sure adding it
> >>> per PMU device is necessary, but maybe there is a reason?

I don't see a reason. I suspect the original reason was to avoid
potential regressions. The only user of the bit is Intel's hybrid, so
I think it should be straightforward to get rid of it.

> >>
> >> EventSelect on AMD is 12 bits where upper nibble is passed via config[=
35:32].
> >> i.e. it conflicts with the semantics of PERF_PMU_CAP_EXTENDED_HW_TYPE.=
 So,
> >> please don't make it default :)
> >>
> >> Thanks,
> >> Ravi
> >
> > Ah, thanks for the answer. It's a bit late now but I wonder why it
> > wasn't added as a completely new argument to perf_event_open. That woul=
d
> > have avoided that. Is there a difference between adding a completely ne=
w
> > argument and adding a new argument by stuffing something into an
> > existing field.
>
> My bad. let me take my words back. I forgot that perf uses generalized ev=
ent
> codes for PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE and does not use actu=
al
> raw config.

Yep. I suspect these type encodings were based on oprofile's behavior
a long time ago. So there are a bunch of legacy types and then after
those numbers come the dynamically registered PMUs that either need to
have json or sysfs event names:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n29

Unfortunately some of the more popular events, and default for things
like perf record, are legacy ones. You can see the hard coding of the
event names in the perf tool here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n341

> Anyway, I think there is still a bit of ambiguity with this code. For ex,
>
>   type =3D PERF_TYPE_HARDWARE;
>   config =3D 0xU00000002;
>
> counts instructions for 0xU =3D 0x0 / 0x1 / 0x3 / 0x4 / invalid pmu `type=
`,
> otherwise perf_event_open() fails. See below simple test:
>
> $ cat test.c
> #include <linux/perf_event.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> static long
> perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
>                int cpu, int group_fd, unsigned long flags)
> {
>         int ret;
>
>         ret =3D syscall(SYS_perf_event_open, hw_event, pid, cpu,
>                       group_fd, flags);
>         return ret;
> }
>
> void loop(unsigned long config_upper_32)
> {
>         struct perf_event_attr pe;
>         int fd;
>
>         memset(&pe, 0, sizeof(pe));
>         pe.type =3D PERF_TYPE_HARDWARE;
>         pe.size =3D sizeof(pe);
>         pe.config =3D config_upper_32 | 0x2;
>         pe.disabled =3D 1;
>         pe.exclude_kernel =3D 1;
>         pe.exclude_hv =3D 1;
>
>         fd =3D perf_event_open(&pe, 0, -1, -1, 0);
>         if (fd =3D=3D -1) {
>                 printf("type: %d, config: 0x%llx: Error\n", pe.type, pe.c=
onfig);
>                 return;
>         }
>
>         printf("type: %d, config: 0x%llx: Ok\n", pe.type, pe.config);
>         close(fd);
> }
>
> int main(void)
> {
>         unsigned long i;
>
>         for (i =3D 0; i < 0x20; i++)
>                 loop(i << 32);
>         return 0;
> }
>
> $ gcc -Wall -g test.c
>
> $ ./a.out
> type: 0, config: 0x2: Ok
> type: 0, config: 0x100000002: Ok
> type: 0, config: 0x200000002: Error
> type: 0, config: 0x300000002: Ok
> type: 0, config: 0x400000002: Ok
> type: 0, config: 0x500000002: Error
> type: 0, config: 0x600000002: Error
> type: 0, config: 0x700000002: Error
> type: 0, config: 0x800000002: Error
> type: 0, config: 0x900000002: Error
> type: 0, config: 0xa00000002: Error
> type: 0, config: 0xb00000002: Error
> type: 0, config: 0xc00000002: Error
> type: 0, config: 0xd00000002: Error
> type: 0, config: 0xe00000002: Error
> type: 0, config: 0xf00000002: Error
> type: 0, config: 0x1000000002: Error
> type: 0, config: 0x1100000002: Error
> type: 0, config: 0x1200000002: Ok
> type: 0, config: 0x1300000002: Ok
> type: 0, config: 0x1400000002: Ok
> type: 0, config: 0x1500000002: Ok
> type: 0, config: 0x1600000002: Ok
> type: 0, config: 0x1700000002: Ok
> type: 0, config: 0x1800000002: Ok
> type: 0, config: 0x1900000002: Ok
> type: 0, config: 0x1a00000002: Ok
> type: 0, config: 0x1b00000002: Ok
> type: 0, config: 0x1c00000002: Ok
> type: 0, config: 0x1d00000002: Ok
> type: 0, config: 0x1e00000002: Ok
> type: 0, config: 0x1f00000002: Ok
> $
>
> Max pmu `type` value on this machine is 17 (i.e. 0x11).

I tried this on an Alderlake with an older kernel. I increased the
loop to 64 values (0x40) as the max pmu type was 30:

$ uname -a
Linux alderlake 5.15.0-72-generic #79~20.04.1-Ubuntu SMP Thu Apr 20
22:12:07 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
$ cat /sys/bus/event_source/devices/*/type|sort -n
1
2
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
$ ./a.out
type: 0, config: 0x2: Ok
type: 0, config: 0x100000002: Ok
type: 0, config: 0x200000002: Error
type: 0, config: 0x300000002: Ok
type: 0, config: 0x400000002: Ok
type: 0, config: 0x500000002: Error
type: 0, config: 0x600000002: Error
type: 0, config: 0x700000002: Error
type: 0, config: 0x800000002: Ok
type: 0, config: 0x900000002: Error
type: 0, config: 0xa00000002: Error
type: 0, config: 0xb00000002: Error
type: 0, config: 0xc00000002: Error
type: 0, config: 0xd00000002: Error
type: 0, config: 0xe00000002: Error
type: 0, config: 0xf00000002: Error
type: 0, config: 0x1000000002: Error
type: 0, config: 0x1100000002: Error
type: 0, config: 0x1200000002: Error
type: 0, config: 0x1300000002: Error
type: 0, config: 0x1400000002: Error
type: 0, config: 0x1500000002: Error
type: 0, config: 0x1600000002: Error
type: 0, config: 0x1700000002: Error
type: 0, config: 0x1800000002: Error
type: 0, config: 0x1900000002: Error
type: 0, config: 0x1a00000002: Error
type: 0, config: 0x1b00000002: Error
type: 0, config: 0x1c00000002: Error
type: 0, config: 0x1d00000002: Error
type: 0, config: 0x1e00000002: Error
type: 0, config: 0x1f00000002: Ok
type: 0, config: 0x2000000002: Ok
type: 0, config: 0x2100000002: Ok
type: 0, config: 0x2200000002: Ok
type: 0, config: 0x2300000002: Ok
type: 0, config: 0x2400000002: Ok
type: 0, config: 0x2500000002: Ok
type: 0, config: 0x2600000002: Ok
type: 0, config: 0x2700000002: Ok
type: 0, config: 0x2800000002: Ok
type: 0, config: 0x2900000002: Ok
type: 0, config: 0x2a00000002: Ok
type: 0, config: 0x2b00000002: Ok
type: 0, config: 0x2c00000002: Ok
type: 0, config: 0x2d00000002: Ok
type: 0, config: 0x2e00000002: Ok
type: 0, config: 0x2f00000002: Ok
type: 0, config: 0x3000000002: Ok
type: 0, config: 0x3100000002: Ok
type: 0, config: 0x3200000002: Ok
type: 0, config: 0x3300000002: Ok
type: 0, config: 0x3400000002: Ok
type: 0, config: 0x3500000002: Ok
type: 0, config: 0x3600000002: Ok
type: 0, config: 0x3700000002: Ok
type: 0, config: 0x3800000002: Ok
type: 0, config: 0x3900000002: Ok
type: 0, config: 0x3a00000002: Ok
type: 0, config: 0x3b00000002: Ok
type: 0, config: 0x3c00000002: Ok
type: 0, config: 0x3d00000002: Ok
type: 0, config: 0x3e00000002: Ok
type: 0, config: 0x3f00000002: Ok


Digging into the numbers a little:
0 is PERF_TYPE_HARDWARE but also the legacy 0 value. I think it should
succeed. It is not clear which PMU you get without a CPU argument to
perf_event_open, on ARM Mark told me it depends on the order the PMU
devices register.
2 is PERF_TYPE_SOFTWARE and I think it should fail.
3 is PERF_TYPE_HW_CACHE and it would be weird to use
PERF_TYPE_HARDWARE with an extended type of PERF_TYPE_HW_CACHE. I
think it should fail.
4 is PERF_TYPE_RAW and "cpu_core", it should succeed but on systems
like ARM where PERF_TYPE_RAW isn't a PMU this should probably fail.
8 is cpu_atom and should succeed.
>=3D31 (0x1f) there are no dynamically added PMUs with these types, I think=
 they should all fail.

Thanks,
Ian

> Thanks,
> Ravi
