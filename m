Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B8EB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjF3QqB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjF3Qp6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 12:45:58 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9B3AAF
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 09:45:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-401d1d967beso5031cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688143551; x=1690735551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1HaHiQEs0/Gh9Z+aE1vuPFBV04V5G+Snz9ueYK83G4=;
        b=J5hkHSk6lPoLNvqjPUgYEHN7nfVlHpU+8k3zknYYvrBaHOVv3M6VC5+0Meel7q5bSu
         HvFOs/hlPRl+IfFUTiCJWgTAaHKh1RF10PmKxiduAUrRYnVxFoOScnSz5PaRnK6wwI22
         N9rUU+hMB/AzkZuMqLFZSVHpbjC5t3kJyq4o7gB7us2oqgpv1MwSFvpRDZkM8E5tHHsl
         DJjp9B0APHHAluNDDiBrNvx5WSv5DbUtgsS47zUpYh171xAfmX/fW6Nn9Ci0lJqaDp5C
         Nr2lvUc7u/5iIm9MTb3QUUHxnF7aF9ZsQvfV2HdGhPcB1WYG3clD1D04WgKZBPTEXrkk
         leLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143551; x=1690735551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1HaHiQEs0/Gh9Z+aE1vuPFBV04V5G+Snz9ueYK83G4=;
        b=EeN+YaOfVpgGhhaJ5EWSamusFhGtZX1q1kkyx1w3w23veAtCNkkc1d7XOktamYzDre
         HbHy2uiFHV7HKLYIr1oLGEBcO0EVEUasXLdSOaKTdgOD6FkilzjROhxiRxvYjVpk1qgi
         nl3fJP5RNFeJZ2/5bPOC9/gtwjpJTZVP1NpYz/UU37r2/5ueV64/VC5F2xxd88iSzcX+
         CfUWRnNO/6eheq45nz/HWJikZFcMx5yEBULmsNOPkuS7tdReSyLweEqAhwE43x3FCwUs
         OxXck+0nEHuFIC6Z6ImLNPcZXcnYoEloNyZjFlP3p+6h54HAb2l/yR1zEMnGLC8d9Zvc
         FREw==
X-Gm-Message-State: AC+VfDyOg/kAXiXkUKFla/WhVJf0wgvaZLSFJMdS2eZ+XD8MBhPFkqxY
        JJPdBXGEH5E9jMuVicz7ES1ABG4TSrjNWsmJd0Krvw==
X-Google-Smtp-Source: ACHHUZ6aSD2by+1bGWIfz2c/G5WfNg7bHOGnQpRgPE2iXkGgSqkELpIa1Zk+4kdZoCg2NTAE+RS6USVN5hIKvRNOMeQ=
X-Received: by 2002:ac8:5813:0:b0:3f9:ad2e:4801 with SMTP id
 g19-20020ac85813000000b003f9ad2e4801mr870002qtg.17.1688143551116; Fri, 30 Jun
 2023 09:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com> <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com> <CAP-5=fXwdc4VK=6dEoD4V0Jp+unYghWYTfbN4ER2aYd9R52W1g@mail.gmail.com>
 <01bc8040-92ef-cf8b-967a-6782989ecf33@arm.com>
In-Reply-To: <01bc8040-92ef-cf8b-967a-6782989ecf33@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 09:45:39 -0700
Message-ID: <CAP-5=fVkRc9=ySJ=fG-SQ8oAKmE_1mhHHzSASmGHUsda5Qy92A@mail.gmail.com>
Subject: Re: perf-tools-next: Request for testing hybrid changes
To:     James Clark <james.clark@arm.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 9:14=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 30/06/2023 16:30, Ian Rogers wrote:
> > On Thu, Jun 29, 2023 at 4:14=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> >>
> >>
> >>
> >> On 23/06/2023 15:30, Ian Rogers wrote:
> >>> On Fri, Jun 23, 2023 at 1:42=E2=80=AFAM James Clark <james.clark@arm.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 22/06/2023 21:15, Ian Rogers wrote:
> >>>>> On Thu, Jun 22, 2023 at 11:57=E2=80=AFAM Namhyung Kim <namhyung@gma=
il.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> In this development cycle, we've got a big change in how to handle
> >>>>>> heterogeneous core PMUs. It's mostly tested on Intel hybrid machin=
es
> >>>>>> but caused some troubles on others.  So I'd like to confirm it wor=
ks
> >>>>>> on major platforms without problems.  Especially on ARM64 as it ha=
s
> >>>>>> the big.LITTLE CPUs.
> >>>>>
> >>>>>
> >>>>> Thanks Namhyung. I believe there is a change on ARM64 that makes a
> >>>>> problem of one type into a slightly different problem. The perf par=
se
> >>>>> events logic handles events certain known hardware events using kno=
wn
> >>>>> numeric encodings, for example, the cycles event has a type of 0
> >>>>> (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/parse-events.l?h=3Dperf-tools-next#n286
> >>>>>
> >>>>> The perf_event_open syscall can specify a CPU number of -1 for any.=
 My
> >>>>> understanding is that -1 on ARM translates into choose the PMU of t=
he
> >>>>> current running thread, this means that if a thread migrates from
> >>>>> between core/PMU types it won't be recorded on the alternate PMU ty=
pe.
> >>>>>
> >>>>> The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
> >>>>> this, but appears not to be set on ARM's PMU:
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/dr=
ivers/perf/arm-cmn.c#n2291
> >>>>> Could an ARM64 related person fix this?
> >>>>>
> >>>>
> >>>> Yes I was planning to look into this since this thread [1].
> >>>> It seems like there are still some test failures on Juno which I'm
> >>>> working through now, even after the fix in that thread. And I was
> >>>> thinking that it should be possible to support
> >>>> PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.
> >>>
> >>> Thanks James, my memory of Juno boards was early bring up work and I
> >>> don't recall them having heterogeneous PMUs. Presumably this is
> >>
> >> Juno does seem to report two PMU types:
> >>
> >>    ls /sys/bus/event_source/devices/
> >>    ...
> >>    armv8_cortex_a53  armv8_cortex_a57
> >>    ...
> >>
> >>> another issue, I'm happy to help if you can share more details.
> >>
> >> So it looks like the failure starts at commit 8bc75f699c14 ("perf
> >> parse-events: Support wildcards on raw events"). test__checkevent_raw(=
)
> >> is looking for PERF_TYPE_RAW at this point, but the commit has changed
> >> the opened event to be whatever PMU it found (type 8 on n1sdp for
> >> example) instead of PERF_TYPE_RAW (4) which causes the test to fail.
> >>
> >> Then looking at the latest perf-tools-next (ad5f604e186a), now the eve=
nt
> >> opened goes back to PERF_TYPE_RAW again, but test__checkevent_raw() is
> >> testing for a real PMU type. None of the PMUs have raw type so the tes=
t
> >> still fails.
> >>
> >> This is all on N1SDP which only has one PMU type so
> >> perf_pmus__supports_extended_type() returns false.
> >>
> >> On Juno it's similar, but perf_pmus__supports_extended_type() isn't
> >> called for the raw test for some reason. It doesn't get hit until the
> >> "instructions" and test__checkevent_symbolic_name() test later. I saw
> >> this because I was looking into Arnaldo's suggestion to hard code a
> >> return false for arm there. But it doesn't fix the test failures for
> >> either platform.
> >>
> >> The failures do look slightly different depending on whether there are
> >> heterogeneous PMUs or not, so maybe there are two problems to fix. Her=
e
> >> are the full outputs of the test from both platforms. But I can't real=
ly
> >> think what the fix should be (assuming we should first fix it without
> >> looking at PERF_PMU_CAP_EXTENDED_HW_TYPE yet).
> >>
> >> N1SDP (only the raw test fails):
> >>
> >>  $ ls /sys/bus/event_source/devices/
> >>  ...
> >>  armv8_pmuv3_0
> >>  ...
> >>
> >>  $ ./perf test "Test event parsing" -vvv
> >>      6: Parse event definition strings                                =
  :
> >>     6.1: Test event parsing                                           =
 :
> >>   --- start ---
> >>   test child forked, pid 21636
> >>   running test 0 'syscalls:sys_enter_openat'
> >>   Using CPUID 0x00000000410fd0c0
> >>   running test 1 'syscalls:*'
> >>   running test 2 'r1a'
> >>   FAILED tests/parse-events.c:123 No PMU found for type
> >>   Event test failure: test 2 'r1a'running test 3 '1:1'
> >>   running test 4 'instructions'
> >>   running test 5 'cycles/period=3D100000,config2/'
> >>   running test 6 'faults'
> >>   running test 7 'L1-dcache-load-miss'
> >>   running test 8 'mem:0'
> >>   running test 9 'mem:0:x'
> >>   running test 10 'mem:0:r'
> >>   running test 11 'mem:0:w'
> >>   running test 12 'syscalls:sys_enter_openat:k'
> >>   running test 13 'syscalls:*:u'
> >>   running test 14 'r1a:kp'
> >>   FAILED tests/parse-events.c:123 No PMU found for type
> >>   Event test failure: test 14 'r1a:kp'running test 15 '1:1:hp'
> >>   running test 16 'instructions:h'
> >>   running test 17 'faults:u'
> >>   running test 18 'L1-dcache-load-miss:kp'
> >>   running test 19 'mem:0:u'
> >>   running test 20 'mem:0:x:k'
> >>   running test 21 'mem:0:r:hp'
> >>   running test 22 'mem:0:w:up'
> >>   running test 23 'r1,syscalls:sys_enter_openat:k,1:1:hp'
> >>   running test 24 'instructions:G'
> >>   running test 25 'instructions:H'
> >>   running test 26 'mem:0:rw'
> >>   running test 27 'mem:0:rw:kp'
> >>   running test 28 '{instructions:k,cycles:upp}'
> >>   running test 29 '{faults:k,cache-references}:u,cycles:k'
> >>   running test 30
> >> 'group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,=
instructions:u'
> >>   running test 31 '{cycles:u,instructions:kp}:p'
> >>   running test 32 '{cycles,instructions}:G,{cycles:G,instructions:G},c=
ycles'
> >>   running test 33 '*:*'
> >>   running test 34 '{cycles,cache-misses:G}:H'
> >>   running test 35 '{cycles,cache-misses:H}:G'
> >>   running test 36 '{cycles:G,cache-misses:H}:u'
> >>   running test 37 '{cycles:G,cache-misses:H}:uG'
> >>   running test 38 '{cycles,cache-misses,branch-misses}:S'
> >>   running test 39 '{instructions,branch-misses}:Su'
> >>   running test 40 'instructions:uDp'
> >>   running test 41 '{cycles,cache-misses,branch-misses}:D'
> >>   running test 42 'mem:0/1'
> >>   running test 43 'mem:0/2:w'
> >>   running test 44 'mem:0/4:rw:u'
> >>   running test 45 'instructions:I'
> >>   running test 46 'instructions:kIG'
> >>   running test 47 'task-clock:P,cycles'
> >>   running test 48 'instructions/name=3Dinsn/'
> >>   running test 49 'r1234/name=3Drawpmu/'
> >>   running test 50 '4:0x6530160/name=3Dnumpmu/'
> >>   running test 51 'L1-dcache-misses/name=3Dcachepmu/'
> >>   running test 52 'intel_pt//u'
> >>   ... SKIP
> >>   running test 53
> >> 'cycles/name=3D'COMPLEX_CYCLES_NAME:orig=3Dcycles,desc=3Dchip-clock-ti=
cks'/Duk'
> >>   running test 54 'cycles//u'
> >>   running test 55 'cycles:k'
> >>   running test 56 'instructions:uep'
> >>   running test 57 '{cycles,cache-misses,branch-misses}:e'
> >>   running test 58 'cycles/name=3Dname/'
> >>   running test 59 'cycles/name=3Dl1d/'
> >>   running test 60 'mem:0/name=3Dbreakpoint/'
> >>   running test 61 'mem:0:x/name=3Dbreakpoint/'
> >>   running test 62 'mem:0:r/name=3Dbreakpoint/'
> >>   running test 63 'mem:0:w/name=3Dbreakpoint/'
> >>   running test 64 'mem:0/name=3Dbreakpoint/u'
> >>   running test 65 'mem:0:x/name=3Dbreakpoint/k'
> >>   running test 66 'mem:0:r/name=3Dbreakpoint/hp'
> >>   running test 67 'mem:0:w/name=3Dbreakpoint/up'
> >>   running test 68 'mem:0:rw/name=3Dbreakpoint/'
> >>   running test 69 'mem:0:rw/name=3Dbreakpoint/kp'
> >>   running test 70 'mem:0/1/name=3Dbreakpoint/'
> >>   running test 71 'mem:0/2:w/name=3Dbreakpoint/'
> >>   running test 72 'mem:0/4:rw/name=3Dbreakpoint/u'
> >>   running test 73 'mem:0/1/name=3Dbreakpoint1/,mem:0/4:rw/name=3Dbreak=
point2/'
> >
> > I saw the raw encoding issue on my Raspberry Pi. I also saw a lot of
> > libtraceevent errors. This is concerning me and we need to get a fix
> > for 6.5.
> >
> >> Juno:
> >>
> >>   (/sys/bus/event_source/devices/ output above)
> >>
> >>       3: Parse event definition strings                               =
   :
> >>     3.1: Test event parsing                                           =
 :
> >>   --- start ---
> >>   running test 0 'r1a'
> >>   Using CPUID 0x00000000410fd070
> >>   FAILED tests/parse-events.c:123 No PMU found for type
> >>   Event test failure: test 0 'r1a'running test 1 '1:1'
> >>   running test 2 'instructions'
> >>   Opening: unknown-hardware:HG
> >>   ------------------------------------------------------------
> >>   perf_event_attr:
> >>     type                             0 (PERF_TYPE_HARDWARE)
> >>     config                           0x800000000
> >>     disabled                         1
> >>   ------------------------------------------------------------
> >
> > Here the config has the extended type in it but because ARM PMU's
> > heterogeneous PMUs aren't  supporting that we get divergence. I think
> > this is a legitimate failure until ARM's PMU driver is fixed to enable
> > the extended type information. We can make the test robust to this,
> > but it is probably a good idea to red flag the ARM PMU being wrong.
>
> Shouldn't Perf just not request it if it isn't available? I thought the
> capability stuff was supposed to help with knowing what the kernel will
> support before opening the event.

So there are legacy events like instructions and cycles, the case here
is cycles. The type for the PMU is given as 0, no dynamically
registered PMU has this type, and the config is 0. For homogeneous
PMUs that'd be the end of the story:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n1510

For heterogeneous PMUs we need to open the event for each PMU. This is
because we want to track instructions or cycles on each PMU. The
encoding for this is to put the PMU's type into the extended type part
of the config. This is the 8 before all the 0s of the 0 config value.

In the kernel's core event opening handling is:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/kernel/eve=
nts/core.c?h=3Dperf/core#n11617
```
/*
* PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
* are often aliases for PERF_TYPE_RAW.
*/
type =3D event->attr.type;
if (type =3D=3D PERF_TYPE_HARDWARE || type =3D=3D PERF_TYPE_HW_CACHE) {
type =3D event->attr.config >> PERF_PMU_TYPE_SHIFT;
if (!type) {
type =3D PERF_TYPE_RAW;
} else {
extended_type =3D true;
event->attr.config &=3D PERF_HW_EVENT_MASK;
}
}
```

So without the extended type PERF_TYPE_RAW is used for
PERF_TYPE_HARDWARE or PERF_TYPE_HW_CACHE. However, the capability
needs to be set on the PMU to support extended types otherwise the
code will fail:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/kernel/eve=
nts/core.c?h=3Dperf/core#n11637
```
if (event->attr.type !=3D type && type !=3D PERF_TYPE_RAW &&
   !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
goto fail;
```
For heterogeneous ARM PMUs I believe this is exactly the path taken to
cause the perf_event_open to fail. The resolution is to add the bit to
the PMU's capabilities. I believe doing it here will suffice:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/pe=
rf/arm_pmu.c?h=3Dperf/core#n877
So:
```
.capabilities =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_R=
EGS,
```
becomes:
```
.capabilities =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS |
PERF_PMU_CAP_EXTENDED_REGS | PERF_PMU_CAP_EXTENDED_HW_TYPE,
```
Now strictly speaking you only need this in the case of heterogeneous
PMUs, but that's the case for other bits here and I don't see special
case logic...

> Even without that, Perf has the
> fallback mechanism where it retries opening with fewer options if
> something causes a failure.

The fallback with fewer options is a separate problem. The most common
case for that is that perf is trying to profile both user and kernel
code, but lacks permission. We retry just trying to profile user code.
The problem of permissions is a separate one to opening events on the
correct PMU.

> >
> >>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> >>   sys_perf_event_open failed, error -2
> >>   running test 3 'cycles/period=3D100000,config2/'
> >>   running test 4 'faults'
> >>   running test 5 'L1-dcache-load-miss'
> >>   running test 6 'mem:0'
> >>   running test 7 'mem:0:x'
> >>   running test 8 'mem:0:r'
> >>   running test 9 'mem:0:w'
> >>   running test 10 'r1a:kp'
> >>   FAILED tests/parse-events.c:123 No PMU found for type
> >>   Event test failure: test 10 'r1a:kp'running test 11 '1:1:hp'
> >>   running test 12 'instructions:h'
> >>   FAILED tests/parse-events.c:329 wrong number of entries
> >>   Event test failure: test 12 'instructions:h'running test 13 'faults:=
u'
> >>   running test 14 'L1-dcache-load-miss:kp'
> >>   running test 15 'mem:0:u'
> >>   running test 16 'mem:0:x:k'
> >>   running test 17 'mem:0:r:hp'
> >>   running test 18 'mem:0:w:up'
> >>   running test 19 'instructions:G'
> >>   running test 20 'instructions:H'
> >>   running test 21 'mem:0:rw'
> >>   running test 22 'mem:0:rw:kp'
> >>   running test 23 '{instructions:k,cycles:upp}'
> >>   FAILED tests/parse-events.c:832 wrong number of entries
> >>   Event test failure: test 23 '{instructions:k,cycles:upp}'running tes=
t
> >
> > These failures will relate to not opening enough events, there should
> > be one instructions and cycles event/evsel (both legacy types) per
> > PMU. Similarly below. All these failures will relate to the extended
> > type divergence, could this be a priority for someone, ARM, Linaro..
> > to look at? I'm happy to send emails, be on a call, etc.
> >
>
> Yes a call sounds good. I can do 8am to 6pm BST all next week pretty
> much, if that works for you?

Let me check with my wife. Next week is funny for some odd
"independence" celebration here.

> I think Will has a point that the Arm version without
> PERF_PMU_CAP_EXTENDED_HW_TYPE has existed for a long time, and as far as
> I know new Perf should be compatible with old kernels (including the
> tests?) so we should make sure it works with both versions even if we do
> add PERF_PMU_CAP_EXTENDED_HW_TYPE for Arm later.

Agreed. It's the time machine problem, we can fix this but to fix it
for everyone requires a time machine. Fixing this problem on older
kernels is much more messy as event mapping logic is necessary. Given
a lack of complaints perhaps we just keep older kernels broken with a
failing test.

> I need to go back and re-check my previous message about the usability
> (rather than test) issues on Juno and see which ones, if any, are
> related to these changes. If something that a user could do before
> doesn't work anymore maybe that adds another argument.

Something that looks regressed in the new code is that we get >1
legacy cache event on heterogeneous ARM PMUs but the extended type
isn't set:
Iterating all core PMUs:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n464
The setting of the config will ignore not set the extended type bits:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n434
An example would be:
$ perf stat -e l1d-misses true
There should be two events on a heterogeneous system, but without the
extended type this will just induce unnecessary multiplexing. We
should probably just not iterate in the broken extended type case as
we are for PERF_TYPE_HARDWARE:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n1511

Thanks,
Ian

> > Thanks,
> > Ian
> >
> >> 24 '{faults:k,cache-references}:u,cycles:k'
> >>   FAILED tests/parse-events.c:875 wrong number of entries
>
> [...]
> >>   running test 65 'mem:0/4:rw/name=3Dbreakpoint/u'
> >>   running test 66 'mem:0/1/name=3Dbreakpoint1/,mem:0/4:rw/name=3Dbreak=
point2/'
> >>
> >>
> >>>
> >>> It is great that you'll look to add PERF_PMU_CAP_EXTENDED_HW_TYPE,
> >>> there is also the legacy kernel issue. Do you have a plan there or
> >>> should supporting PERF_PMU_CAP_EXTENDED_HW_TYPE be the plan? As the
> >>> Linux 6.5 merge window will open soon I'm concerned that these fixes
> >>> may only make it into 6.6. Should we do anything short-term for 6.5?
> >>> For example, if extended types aren't supported then disable the
> >>> wildcard matching of PMUs in the "numeric", really PERF_TYPE_HARDWARE
> >>> and PERF_TYPE_HW_CACHE, cases?
>
> Sorry I missed this bit before, but I think that we need both cases to
> work even if we add PERF_PMU_CAP_EXTENDED_HW_TYPE in the future. So yes
> I think some short term tool fix would be needed. Unless it's just the
> tests that are failing rather than any real use cases, then maybe
> nothing needs to be done.
>
> James
>
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> [1]: https://lore.kernel.org/all/ZIxza13x+AwApbQb@kernel.org/
> >>>>
> >>>>> The perf tool is expecting it to be supported and so it tries to op=
en
> >>>>> the event for each core PMU, so the cycles event will open for each=
 of
> >>>>> a BIG.little PMU, however, as the extended type isn't supported the
> >>>>> same event will be opened twice and the migration problem still
> >>>>> exists. This problem exists for all PERF_TYPE_HARDWARE events (10) =
and
> >>>>> all PERF_TYPE_HW_CACHE events (42).
> >>>>>
> >>>>> Assuming the capability issue is fixed, there is still an open issu=
e
> >>>>> about how to properly support these 52 events on older kernels. It
> >>>>> would be possible to use the architecture standard events, so cycle=
s
> >>>>> can map to cpu_cycles, instructions to sw_incr, cache-references to
> >>>>> l1d_cache (probably), etc. I'm not sure this will work for all 52
> >>>>> events and the plumbing in the perf tool isn't straightforward.
> >>>>> There's also the question of whether such a change of events should
> >>>>> happen when we know the perf_event_open will be given a CPU, should
> >>>>> that case not wildcard PMUs?>
> >>>>> I'm happy to provide more context/details.
> >>>>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>> Also we are transitioning from Arnaldo's tree to new repositories =
in
> >>>>>> git.kernel.org:
> >>>>>>
> >>>>>>  * kernel/git/perf/perf-tools (for the fixes on the current dev cy=
cle)
> >>>>>>  * kernel/git/perf/perf-tools-next (for new features for the next =
cycle)
> >>>>>>
> >>>>>> There is a branch with the same name.  Please check out
> >>>>>> perf-tools-next and play with it.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Namhyung
