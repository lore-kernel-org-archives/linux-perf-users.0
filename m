Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C99C77B7F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Apr 2023 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjD0VJ0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbjD0VJY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Apr 2023 17:09:24 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312F420C
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 14:09:22 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so46895ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682629762; x=1685221762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNUhSGOlXP2sdNxBSWwV4k/Iqeo2iP8PrrbPJhY7BuA=;
        b=wdrykeXtE4MEGJSCAdNM+35N3D3ulWTKp7nfUItwvMgj867RAazdQ0WP6nwJvSqwjW
         +QM3PZjin9M/7aXmvaz0WieW8KBMAFlEwEVFHbmJm/l66xDl5ySzV71mMSxTYVDtr6WB
         7VIdrFhX6dvO6BeCWggjDB5XRK7XV7b1/1V3VD2HlBSbbLrp8GSs9fkl6M/jxBKcegxW
         /gyhdzDBNyu6D1FKSdEFybUyUXp1kH4U5b4oeTQ4D7DBhP+vcaGhfso0Aj9C0pN1oJCt
         9BQIATT7S0f2rgDWADgHUxHDtBiAcD+/Af7YVJZAKwV9RPC8ihakq+R7sIb+eHOn8L/j
         Vdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629762; x=1685221762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNUhSGOlXP2sdNxBSWwV4k/Iqeo2iP8PrrbPJhY7BuA=;
        b=bP7Qj+PN4LDGQmZNRetEzEqo/eCZCG6gMfoVzJ+XaHsfTrOWmkBJo54ernPdFkC3QW
         XoYfHa1Kkr0oG21PZqZKYcnzEIYFQKNLy7bvjaa7hhpSKdM13NFY2EcQuktRV4FUQBWf
         Dw80LKAejQJghhSypYbBPjz2NFbw2008TkqoOiwqQW546RV7AKkbwzCzXb661V2p6vTK
         DjWtmGBVe4KU4PdtHuzAYEDPDZPiwKAWeXV5M1y59XRafQTLnJiwEK+BF7/uWjfTHAT9
         6lew1g+rQRoSlfPThgFjegjxZniwXBdJNYAue5p4wQ54OJizbDGdxwpNFFqL2Nw7FxVl
         UPeg==
X-Gm-Message-State: AC+VfDxSS5oWKLS9qnivOqDFQeWzlzPTbsyY4oyzX7WrFtcS5SdNAtIc
        tnKyH/eCvvyrwHkPoFd6Iat65/J7EWAhGflhu9DGfQ==
X-Google-Smtp-Source: ACHHUZ70nHtb/GdGztyCGnd62tftQGgL5sON6LnoOc13TW+JSLhGkMPmGz8uDvtCd0K7k7YlBVzUtb4hb8ENsGKM6wo=
X-Received: by 2002:a05:6e02:1bab:b0:326:3219:85df with SMTP id
 n11-20020a056e021bab00b00326321985dfmr87066ili.14.1682629761851; Thu, 27 Apr
 2023 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-2-irogers@google.com>
 <77dd1ab3-9c94-c04a-24de-f8c192a6c8d2@linux.intel.com> <CAP-5=fVBFjnmCuzSud=oGj6nGCs7haMkALGS+ZGJEyD4dSYqTA@mail.gmail.com>
 <CAM9d7chavGHmtKiVkAo7fpUm=B3r3xNYgW__6dZe9D+3nmy7dA@mail.gmail.com>
In-Reply-To: <CAM9d7chavGHmtKiVkAo7fpUm=B3r3xNYgW__6dZe9D+3nmy7dA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 14:09:04 -0700
Message-ID: <CAP-5=fU+E9hFR5SP9oG6kOKecR02fGvcqtFHKwDvHG3GYKLa1w@mail.gmail.com>
Subject: Re: [PATCH v1 01/40] perf stat: Introduce skippable evsels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 27, 2023 at 2:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Thu, Apr 27, 2023 at 1:21=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Apr 27, 2023 at 11:54=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> > >
> > >
> > >
> > > On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> > > > Perf stat with no arguments will use default events and metrics. Th=
ese
> > > > events may fail to open even with kernel and hypervisor disabled. W=
hen
> > > > these fail then the permissions error appears even though they were
> > > > implicitly selected. This is particularly a problem with the automa=
tic
> > > > selection of the TopdownL1 metric group on certain architectures li=
ke
> > > > Skylake:
> > > >
> > > > ```
> > > > $ perf stat true
> > > > Error:
> > > > Access to performance monitoring and observability operations is li=
mited.
> > > > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to =
open
> > > > access to performance monitoring and observability operations for p=
rocesses
> > > > without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capabili=
ty.
> > > > More information can be found at 'Perf events and tool security' do=
cument:
> > > > https://www.kernel.org/doc/html/latest/admin-guide/perf-security.ht=
ml
> > > > perf_event_paranoid setting is 2:
> > > >   -1: Allow use of (almost) all events by all users
> > > >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_=
LOCK
> > > >> =3D 0: Disallow raw and ftrace function tracepoint access
> > > >> =3D 1: Disallow CPU event access
> > > >> =3D 2: Disallow kernel profiling
> > > > To make the adjusted perf_event_paranoid setting permanent preserve=
 it
> > > > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> > > > ```
> > > >
> > > > This patch adds skippable evsels that when they fail to open won't
> > > > fail and won't appear in output. The TopdownL1 events, from the met=
ric
> > > > group, are marked as skippable. This turns the failure above to:
> > > >
> > > > ```
> > > > $ perf stat true
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >               1.26 msec task-clock:u                     #    0.328=
 CPUs utilized
> > > >                  0      context-switches:u               #    0.000=
 /sec
> > > >                  0      cpu-migrations:u                 #    0.000=
 /sec
> > > >                 49      page-faults:u                    #   38.930=
 K/sec
> > > >            176,449      cycles:u                         #    0.140=
 GHz                         (48.99%)
> > > >            122,905      instructions:u                   #    0.70 =
 insn per cycle
> > > >             28,264      branches:u                       #   22.456=
 M/sec
> > > >              2,405      branch-misses:u                  #    8.51%=
 of all branches
> > > >
> > > >        0.003834565 seconds time elapsed
> > > >
> > > >        0.000000000 seconds user
> > > >        0.004130000 seconds sys
> > > > ```
> > >
> > > If the same command runs with root permission, a different output wil=
l
> > > be displayed as below:
> > >
> > > $ sudo ./perf stat sleep 1
> > >
> > >  Performance counter stats for 'sleep 1':
> > >
> > >               0.97 msec task-clock                       #    0.001 C=
PUs
> > > utilized
> > >                  1      context-switches                 #    1.030 K=
/sec
> > >                  0      cpu-migrations                   #    0.000 /=
sec
> > >                 67      page-faults                      #   69.043 K=
/sec
> > >          1,135,552      cycles                           #    1.170 G=
Hz
> > >                        (50.51%)
> > >          1,126,446      instructions                     #    0.99  i=
nsn
> > > per cycle
> > >            252,904      branches                         #  260.615 M=
/sec
> > >              7,297      branch-misses                    #    2.89% o=
f
> > > all branches
> > >             22,518      CPU_CLK_UNHALTED.REF_XCLK        #   23.205
> > > M/sec
> > >             56,994      INT_MISC.RECOVERY_CYCLES_ANY     #   58.732 M=
/sec
> > >
> > > The last two events are useless.
> >
> > You missed the system wide (-a) flag.
> >
> > Thanks,
> > Ian
> >
> > > It's not reliable to rely on perf_event_open()/kernel to tell whether
> > > an event is available or skippable. Kernel wouldn't check a specific =
event.
> > >
> > > The patch works for the non-root mode is just because the event requi=
res
> > > root permission. It's rejected by the kernel because of lacking
> > > permission. But if the same command runs with root privileges, the tr=
ash
> > > events are printed as above.
> > >
> > > I think a better way is to check the HW capability and decided whethe=
r
> > > to append the TopdownL1 metrics.
> > >
> > > https://lore.kernel.org/lkml/20230427182906.3411695-1-kan.liang@linux=
.intel.com/
>
> Maybe we can also check if the event is actually enabled like
> checking the enabled_time.  Then skip the skippable and not
> enabled ones.

Good idea, and I think that addresses Kan's concern over missing
output. I'll add it in v2.

Thanks,
Ian

> Thanks,
> Namhyung
