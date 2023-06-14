Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8BEB64D8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjFNO5d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjFNO5c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 10:57:32 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766DB1A7
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 07:57:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f98276f89cso214371cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686754649; x=1689346649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwEcRzlFxXHK+vcC3gnSqYOFJE4wNjqS53AmFcw7MkM=;
        b=K1sojI3T8ApKsQgj77IakvDfwe3BhMGmZmgBtDOokrz52vlwRL+k50uBugvJrUsRwl
         boEJfUBYlurjmAEGNvu+Hz1ssNSe357Ri9LecCuoqcwpT/rBkHyaT62oNzOPhOhtGbbS
         wgF4Prt41BxhJGEKUOEdkJmC9sz+hvyfaPO+/KQEkiw5OQ5Exc/ysUnCOsqLttYPPDM2
         BZXRkO44TyuzXhA51+jbVxri95k6+IfV3TULoBUVmGBHsrfUW9xpWZe92feT/aHgUkR6
         jb3pqODB+f0gnypWhj5qlHGnsxdqWbnuAO3Qy+2GxdTjB5FoyPlRo6Gdbs6JFxGUWXSW
         pIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754649; x=1689346649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwEcRzlFxXHK+vcC3gnSqYOFJE4wNjqS53AmFcw7MkM=;
        b=MepKPw+LRtbEYwRZIxC6CMgtlr6x78Y4DAXILSt8Y86IyyRXrEv0+6y2t8r0520Rp7
         VvzBddSP5xijFFFjomgnK37s3sS9deOPdLEgn4zqH21keH92tRVwudxdTzaW+V/LaSF2
         OZzK5EtATfbZlo2KQeB5VujRUUvYivzCfA2l/U4aMJri0eZ97ETzYELEzYBwfQQS+bR6
         +wzqQtrms5VWBBgfls1n2VK1E+tsxJN94EXaWS9UUm3UdaFJ+al7YIF6RfSZ7Pq9jBae
         GiiOkVk/G0bRAgVHxXfsLBs8jY+SGKLsIXCgHyJoE2mGgvTPv4wGmaiIAR+wUNSCQET+
         0ymw==
X-Gm-Message-State: AC+VfDzvQchrw2SElYQba9QPdNyH2TdUZxAyjQx412eS8WbdgWpjNPId
        1kkCuLuN4BdIyp3hZnKMhdAJcOAhqIKQVzsuOSZ0h1o8FKrY9AwDQkKU4Q==
X-Google-Smtp-Source: ACHHUZ71Ckt8LLfgCFLnyBQ5quym+7db7fRO878L3wqcQfT6Nszuoiu6jwilAt7zFjWiKNa8s8Wvzx5x7DjTxM13Xns=
X-Received: by 2002:a05:622a:15cd:b0:3f8:5b2:aef0 with SMTP id
 d13-20020a05622a15cd00b003f805b2aef0mr292014qty.24.1686754649444; Wed, 14 Jun
 2023 07:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com> <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
In-Reply-To: <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 07:57:17 -0700
Message-ID: <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
Subject: Re: perf test failures in linux-next on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 14, 2023 at 1:32=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 6/13/23 16:32, Ian Rogers wrote:
> > On Tue, Jun 13, 2023 at 5:54=E2=80=AFAM Thomas Richter <tmricht@linux.i=
bm.com> wrote:
> >>
> >> Hi all,
> >>
> >> I have run the perf test suite on the current 6.4rc6 kernel and see ju=
st one error:
> >> # ./perf test 2>&1 | fgrep FAILED
> >> fgrep: warning: fgrep is obsolescent; using grep -F
> >>  42.3: BPF prologue generation                                       :=
 FAILED!
> >> #
> >>
> >> However when I download the linux-next tree and build kernel and perf
> >> tool with the same kernel config file, I get a bunch of failing test c=
ases,
> >> many with perf tool dumping core:
> >>
> >> # perf test 2>&1 | fgrep FAILED
> >> fgrep: warning: fgrep is obsolescent; using grep -F
> >>   6.1: Test event parsing                                            :=
 FAILED!
> >>  10.3: Parsing of PMU event table metrics                            :=
 FAILED!
> >>  10.4: Parsing of PMU event table metrics with fake PMUs             :=
 FAILED!
> >>  17: Setup struct perf_event_attr                                    :=
 FAILED!
> >>  24: Number of exit events of a simple workload                      :=
 FAILED! core-dump
> >>  28: Use a dummy software event to keep tracking                     :=
 FAILED!
> >>  35: Track with sched_switch                                         :=
 FAILED!
> >>  42.3: BPF prologue generation                                       :=
 FAILED!
> >>  66: Parse and process metrics                                       :=
 FAILED!
> >>  68: Event expansion for cgroups                                     :=
 FAILED!
> >>  69.2: Perf time to TSC                                              :=
 FAILED! core-dump
> >>  74: build id cache operations                                       :=
 FAILED! core-dump
> >>  81: kernel lock contention analysis test                            :=
 FAILED!
> >>  86: Zstd perf.data compression/decompression                        :=
 FAILED! core-dump
> >>  87: perf record tests                                               :=
 FAILED! core-dump
> >>  94: perf all metricgroups test                                      :=
 FAILED!
> >>  95: perf all metrics test                                           :=
 FAILED!
> >> 106: Test java symbol                                                :=
 FAILED! core-dump
> >> #
> >>
> >> I am afraid this will show up pretty soon in the linux tree.
> >> I am going to look into each failure in the next few days.
> >>
> >> What I already found out is that many test cases now fail due to the
> >> event/PMU rework, here is one example:
> >>
> >> # perf test -Fvvvv 95
> >> 95: perf all metrics test
> >> --- start ---
> >> Testing cpi
> >> ....
> >> Metric 'transaction' not printed in:
> >> Error:
> >> The TX_NC_TABORT event is not supported.
> >> ---- end ----
> >> perf all metrics test: FAILED!
> >> # ls -l /sys/devices/cpum_cf/events/TX_NC_TABORT
> >> -r--r--r--. 1 root root 4096 Jun 13 13:49 /sys/devices/cpum_cf/events/=
TX_NC_TABORT
> >> #
> >>
> >> As can be seen, the event is definitely there and supported.
> >> This same test case succeeds in the linux tree!
> >>
> >> Hopefully I can sort out some of the failures before this code show up
> >> in the linux tree.
> >
> > Thanks Thomas, to be clear this is what is in
> > perf-tools-next/linux-next and not 6.4?
>
> Ian,
>
> thanks for your help.
> Correct, I am talking about the linux-next repo. The linux repo is fine.
>
> >
> > Rather than try to do more complicated cases like the metrics tests,
> > it makes sense to dig into why event parsing is failing. Test 6 first
> > of all, could you give output?
> >
> > Thanks,
> > Ian
> >
> We discussed some aspects of this about two weeks ago, but last week
> I was on vacation and now I resumed my work on linux-next.
> We run the linux-next perf test suite every night and I am concerned
> and would like to get this sorted out before it hits Linux 6.5.
>
> Here is the output on my linux-next tree built yesterday:
> # uname -a
> Linux a35lp67.lnxne.boe 6.4.0-rc6-next-20230613d-perf #2 \
>               SMP Tue Jun 13 15:18:43 CEST 2023 s390x GNU/Linux
> # ./perf test -F 6
>   6: Parse event definition strings  :
>   6.1: Test event parsing            :Segmentation fault (core dumped)
> #
> # gdb perf
>   ....
>   (gdb) r test -F 6
>    6: Parse event definition strings                                  :
>   6.1: Test event parsing                                            :
> Program received signal SIGSEGV, Segmentation fault.
> __GI_strcmp () at ../sysdeps/s390/strcmp-vx.S:47
> (gdb) where
> #0  __GI_strcmp () at ../sysdeps/s390/strcmp-vx.S:47
> #1  0x000000000110a18c in test__term_equal_term (evlist=3D0x152ea80) at t=
ests/parse-events.c:1580
> #2  0x000000000110a96a in test_event (e=3D0x14dc758 <test.events+1416>) a=
t tests/parse-events.c:2209
> #3  0x000000000110ac58 in test_events (events=3D0x14dc1d0 <test.events>, =
cnt=3D61) at tests/parse-events.c:2260
> #4  0x000000000110ad52 in test__events2 (test=3D0x1500758 <suite.parse_ev=
ents>, subtest=3D0)
>     at tests/parse-events.c:2272
> #5  0x00000000010f6fac in run_test (test=3D0x1500758 <suite.parse_events>=
, subtest=3D0) at tests/builtin-test.c:236
> #6  0x00000000010f7142 in test_and_print (t=3D0x1500758 <suite.parse_even=
ts>, subtest=3D0) at tests/builtin-test.c:265
> #7  0x00000000010f7b1e in __cmd_test (argc=3D1, argv=3D0x3ffffffa320, ski=
plist=3D0x0) at tests/builtin-test.c:436
> #8  0x00000000010f8404 in cmd_test (argc=3D1, argv=3D0x3ffffffa320) at te=
sts/builtin-test.c:559
> #9  0x00000000011473fc in run_builtin (p=3D0x14f60e8 <commands+600>, argc=
=3D3, argv=3D0x3ffffffa320) at perf.c:323
> #10 0x000000000114776e in handle_internal_command (argc=3D3, argv=3D0x3ff=
ffffa320) at perf.c:377
> #11 0x0000000001147980 in run_argv (argcp=3D0x3ffffff9f94, argv=3D0x3ffff=
ff9f88) at perf.c:421
> #12 0x0000000001147d48 in main (argc=3D3, argv=3D0x3ffffffa320) at perf.c=
:537
> (gdb)
>
> To be honest, I am no expert on the yacc/bison/flex tool chain.
> I understand a little bit about them, but that is it.
>
> When I look at the output of perf test -Fvvvv 6 on linux-next, some thing=
s seem odd,
> I marked them with 3 question masks ???:
>
> # ./perf test -Fvvv 6
>   6: Parse event definition strings     :
>   6.1: Test event parsing               :
> --- start ---
> running test 0 'syscalls:sys_enter_openat'
> Using CPUID IBM,3931,704,A01,3.7,002f
> running test 1 'syscalls:*'
> running test 2 'r1a'
> running test 3 '1:1'
> running test 4 'instructions'
> No PMU found for 'instructions'FAILED tests/parse-events.c:143 wrong numb=
er of entries
> Event test failure: test 4 'instructions'running test 5 'cycles/period=3D=
100000,config2/'
> ??? What is wrong here?
> ??? Output on linux 6.4.0rc3:
> ??? # ./perf stat -e instructions -- true
> ???
> ??? Performance counter stats for 'true':
> ???
> ???         2,965,720      instructions
> ???
> ???        0.002026832 seconds time elapsed
> ???
> ???        0.000056000 seconds user
> ???        0.002048000 seconds sys
> ??? #
> ??? This is fine and works as expected. The s390 PMU for counters
> ??? has a direct mapping for this. So we end up in the s390 PMU
> ??? to retrieve the value.
> ???
> ??? Output on linux-next
> ???# ./perf stat -e instructions -- true
> ???
> ??? Performance counter stats for 'true':
> ???
> ???              0.65 msec task-clock                       #    0.250 CP=
Us utilized
> ???                 0      context-switches                 #    0.000 /s=
ec
> ???                 0      cpu-migrations                   #    0.000 /s=
ec
> ???                49      page-faults                      #   75.375 K/=
sec
> ???         3,367,228      cycles                           #    5.180 GH=
z
> ???         2,880,270      instructions                     #    0.86  in=
sn per cycle
> ???   <not supported>      branches
> ???   <not supported>      branch-misses
> ???
> ???       0.002599176 seconds time elapsed
> ???
> ???       0.000053000 seconds user
> ???       0.002650000 seconds sys
> ???
> ???#
> ??? Somehow we end up in a different PMU. The output is the same as if
> ??? I do not specify an event at all. To reach the s390 specific PMU
> ??? I have to add it explicitly as in:
> ???# ./perf stat -e cpum_cf/instructions/ -- true
> ???
> ??? Performance counter stats for 'true':
> ???
> ???         2,814,522      cpum_cf/instructions/
> ???
> ???       0.001899881 seconds time elapsed
> ???
> ???       0.000050000 seconds user
> ???       0.001928000 seconds sys
> ???
> ???]#
> No PMU found for 'cycles/period=3D100000,config2/'FAILED tests/parse-even=
ts.c:157 wrong number of entries
> Event test failure: test 5 'cycles/period=3D100000,config2/'running test =
6 'faults'
> ...
> ??? Similar output for basicly all events.
>
> No PMU found for 'cycles'running test 59 'cycles/name=3Dname/'
> No PMU found for 'name'Segmentation fault (core dumped)
>
> Hope this helps.
>
> PS: Should we keep the linux-perf-use mailing list as addressee? Not sure
> if everybody else is interested in this?

Smaller list is okay. Could you send me a zip of the sysfs
(/sys/devices) ? At least one issue is that the code didn't find a
core PMU. On non-hybrid x86 this would be /sys/devices/cpu, I think we
spoke about this before for s390 and there are >1. The issue here is
that the test found 0, and we're trying to use PMUs in the code now as
a way to sort events. There's code/comment in util/pmu.c:

'''
/**
 * is_sysfs_pmu_core() - PMU CORE devices have different name other than cp=
u in
 *         sysfs on some platforms like ARM or Intel hybrid. Looking for
 *         possible the cpus file in sysfs files to identify whether this i=
s a
 *         core device.
 * @name: The PMU name such as "cpu_atom".
 */
static int is_sysfs_pmu_core(const char *name)
{
char path[PATH_MAX];

if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpus"))
return 0;
return file_available(path);
}
...
bool is_pmu_core(const char *name)
{
return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
}
'''

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
