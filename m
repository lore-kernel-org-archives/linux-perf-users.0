Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF4FEB64D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 13:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjFVNla (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFVNl3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 09:41:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B960A1997
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 06:41:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so124531cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687441287; x=1690033287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dYmvC/hXGKGQmdemIaaiU9pyTNq7S3KecRuExgDS2o=;
        b=Xt9yTQ7WJixOAPhODtcxsYVNDcBny65+rMo3fRq1SseCQn5XDM3r1ktsqgOB/J8Svi
         vezGLwgTnLld1Xf8U2nVMo1iLZVT/pEAA1z/g3gAdNcFDvL0h7z2hHhPGEj2wKrBT6gN
         aO44jBNPstT+0eBhdCXfQ4olziQ22eGo7RJvP8o/BfqejvAoPm4bZt/eLmxWaiGeRVii
         J7NIce8tzjREr7BDbDw+2UnE09f+faI3P9YqJdmrYNz3llKORESNmWbIKD98KCFgff/f
         bHO6k1Dtlj7tvmz//Zeagc3PosKsJVD0cy7bFX8lCzQYDrkOEz/Gb+cdtCtFuiIhRXWt
         tp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441287; x=1690033287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dYmvC/hXGKGQmdemIaaiU9pyTNq7S3KecRuExgDS2o=;
        b=ePrq0kmBbixjgOCnyp9J9hTPyUEDeXn5p+DUM7MW6aT8SKxDLit3I3XG/ao+vkoaiW
         Scs78bOMCp4z2RPKvrZlRjRY7R7Z2B9kWHWCxePUF5nuPnoPLnsqOPxDIGZ9KNInIGOa
         yVgoimJ5k7A7e7FJu9Kv7PovAL8FIVJE5F5lGEzr8wJssvusdGBZGvjiHzCQ89OJ7sfC
         ef33lubcHUsIP8zD7QAYAEaDDWLTkyTWV93YDpdEm/DjlsvtfzhCPGrCvIe7dOz6ulFY
         xIucV/QQGULZ13sSef3YtfKZyeE18bpHsM1GzUVeGNksnYP6cCcE0ol8HItIXwyD7i7I
         RGqQ==
X-Gm-Message-State: AC+VfDxj1nLXeuDU8QMhJQSw/rpQqUCijbXA/NMOydJ42LLvb4Jo9jbr
        yoqVzMrCSeCgw2C5KkjugDqKT9T+yx3vq2sKZX7iJoeyoOroPFJv1JqR5A==
X-Google-Smtp-Source: ACHHUZ5WdWImB6zhLcmB/HnX4N/EKYMSrBc//KmdOwOrJRjwOSX//xGazX8grRczdp+oQGOyAwCDDRme9vwTny2lbSI=
X-Received: by 2002:a05:622a:15c5:b0:3f8:5b2:aef4 with SMTP id
 d5-20020a05622a15c500b003f805b2aef4mr1591364qty.28.1687441286642; Thu, 22 Jun
 2023 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
In-Reply-To: <ZJQSUHLe9Cqpw21n@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 06:41:14 -0700
Message-ID: <CAP-5=fWTkFnZbCTgU2hRAcJwZopmVJ7=4zwvA4Pd-KGBipgg2Q@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 22, 2023 at 2:20=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > Can you provide an example that is breaking?
>
> I only have a very long auto generated example[1], because it's not
> easy to make a non scheduling event and it's also dependent on the system=
. The example
> works on a SKX.

Thanks, I have an SKX so I can try to repro.

> >
> > Wrt event order, cases like:
> > ```
> > $ sudo perf stat -e '{data_read,data_write}' -a --no-merge sleep 1
> >
> > Performance counter stats for 'system wide':
> >
> >          1,960.81 MiB  data_read [uncore_imc_free_running_1]
> >            438.48 MiB  data_write [uncore_imc_free_running_1]
> >          1,961.85 MiB  data_read [uncore_imc_free_running_0]
> >            438.79 MiB  data_write [uncore_imc_free_running_0]
> >
> >       1.001127356 seconds time elapsed
> > ```
> > Reorder events so that the PMUs match (ie the -e order would 2x
> > data_read followed by 2x data_write). This covers more cases now so
> > that perf metric (aka topdown) events aren't broken when coming out of
> > metrics:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/util/parse-events.c?h=3Dperf-tools-next#n2139
>
> How is any tool supposed to handle arbitary output reordering like
> that? Perf is not just for humans, but also for tools.
>
> It cannot just look up the events by name because there might be multiple
> instances of the same event in different groups.
>
> The only reliable way to match is to match on the original order,
> but that totally breaks down with these changes.

Did you check the code/changes? The order that is preferred is the
original insertion order into the evlist. There is a warning triggered
when regrouping occurs. It shouldn't occur if a tool is careful,
avoids wildcard event matching within a group, etc.

Having different PMUs within a group would be broken so this has
always been historically fixed but previously just for uncore events.
With hybrid, core events can now open on >1 PMU and so we need to fix
all cases. This introduces a problem like, "perf stat -e
'{cycles,faults}' ..." where cycles will open on 2 PMUs but faults
being a software event doesn't get wildcard expanded so is only
grouped with one. There are still improvements needed in this area but
failing the parsing and requiring every PMU be listed would be quite
hostile to users.

Another issue is that kernel PMUs don't always fail perf_event_open
for a group due to not having enough information in the fake PMU used
for testing. I've asked for kernel fixes but was told that the tool
should handle these. Because of this we need to force metrics not to
group events but then that breaks the perf metric (aka topdown) events
that require a group. The perf metric events are also super fussy with
needing slots to be a leader and so on, so this is handled by
parse_events__sort_events_and_fix_groups.

> The same actually applies to humans reading the output too,
> if it's ambigious for the tool it will be ambigious to the human too.
> perf stat shouldn't reorder events ever.

I don't believe there is a deliberate attempt to hide information, the
change was made so that when looking at say per-core information an
uncore count doesn't get repeated making a counter look broken:
https://lore.kernel.org/r/20230125192431.2929677-1-namhyung@kernel.org

> >
> > Given the original commit message there seems little point to give the
> > 0 counts, but perhaps it is something that could be done on the more
> > tool oriented CSV and JSON output formats.
>
> It's not 0 counts, it's <not supported>. But even 0 counts can
> be important.
>
> We should always output when something doesn't count so that
> the user knows something is wrong. Hiding problems is always a bad idea
> and not an improvement.

I don't think there's any disagreement on that. In fact the
perf-tools-next code will now always display a metric result even if a
divide by 0 happened during computation, or on hybrid if an event
doesn't apply to one PMU the other PMU will show 0/not counted/not
supported, the previous behavior was to hide hybrid events that only
worked on 1 PMU.

The original patch series tried to clean up the aggregation logic, but
then that regressed output and so should_skip_zero_counter was added.
The check is pretty conservative, preferring to display 0s. I wonder
in your case it is hiding it because there are multiple sockets.
Getting a simpler test will help diagnose the problem and come up with
the appropriate fix.

Thanks,
Ian

> -Andi
>
> [1] Long example for SKX:
>
> perf stat -o p3 -x\; -e '{cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x3c=
,umask=3D0x0/u,cpu/event=3D0x0,umask=3D0x3/u,cpu/event=3D0x3c,umask=3D0x2/u=
,cpu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0xb1,umask=3D0x1/u,cpu/event=3D=
0xb1,umask=3D0x2,cmask=3D1/u},msr/tsc/,duration_time,dummy,uncore_imc/event=
=3D0x4,umask=3D0x3/,uncore_imc/event=3D0x4,umask=3D0xc/,cs:u,minor-faults:u=
,major-faults:u,migrations:u,{cycles:u,cpu/event=3D0x0,umask=3D0x3/u,cpu/ev=
ent=3D0xc2,umask=3D0x2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0xc4,um=
ask=3D0x40/u,cpu/event=3D0xb1,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},=
{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xc2,umask=3D0x2,cmask=3D1/u,cp=
u/event=3D0x3c,umask=3D0x0/ku,cpu/event=3D0xc0,umask=3D0x0/ku},{cpu/event=
=3D0x79,umask=3D0x8/u,cpu/event=3D0xa8,umask=3D0x1/u,cpu/event=3D0x79,umask=
=3D0x4/u,cpu/event=3D0x79,umask=3D0x30/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu=
/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0=
x10,umask=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=
=3D0x40/u},{cpu/event=3D0x11,umask=3D0x2/u,cpu/event=3D0x11,umask=3D0x1/u,c=
pu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x=
3c,umask=3D0x1/u},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0x10,umask=
=3D0x80/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,c=
pu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x3c,umask=3D0x0/ku,cpu/event=
=3D0x3c,umask=3D0x1/u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=
=3D0x3,cmask=3D1/u},{cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=3D0x3c,umask=
=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/=
event=3D0xc2,umask=3D0x2/u},{cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0xc2=
,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cpu/event=3D0x3c,uma=
sk=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0x9c,umask=3D0x1/u,=
cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0=
x3c,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},{cpu/event=3D0x3c,umask=3D=
0x0/u,cpu/event=3D0x9c,umask=3D0x1,cmask=3D4/u,cpu/event=3D0x3c,umask=3D0x2=
/u,cpu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=
=3D0xc0,umask=3D0x0/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0x3c,uma=
sk=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/u,cp=
u/event=3D0xd,umask=3D0x3,cmask=3D1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/=
event=3D0xe,umask=3D0x1/u,cpu/event=3D0x79,umask=3D0x30/u,cpu/event=3D0x3c,=
umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0xe,umask=3D0x1/=
u,cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cp=
u/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0=
xc5,umask=3D0x0/u,cpu/event=3D0xc3,umask=3D0x1,edge=3D1,cmask=3D1/u,cpu/eve=
nt=3D0x3c,umask=3D0x1/u},dummy,{cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0=
xc2,umask=3D0x2/u,cpu/event=3D0xd,umask=3D0x3,cmask=3D1/u,cpu/event=3D0x3c,=
umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/event=3D0x9c,umask=3D0x1=
/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=
=3D0x3c,umask=3D0x1/u,cpu/event=3D0xe,umask=3D0x1/u},dummy,{cpu/event=3D0xa=
3,umask=3D0x6,cmask=3D6/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=3D0xa3,u=
mask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D1/u},{cpu/event=
=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D2/u,cp=
u/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x5e,umask=3D0x1/u,cpu/event=3D0x9=
c,umask=3D0x1,cmask=3D4/u},{cpu/event=3D0x9c,umask=3D0x1/u,cpu/event=3D0x3c=
,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umask=3D0x1/=
u,cpu/event=3D0xe,umask=3D0x1/u},{cpu/event=3D0xc2,umask=3D0x2/u,cpu/event=
=3D0xd,umask=3D0x3,cmask=3D1/u},dummy,dummy,emulation-faults,dummy,{cpu/eve=
nt=3D0xa3,umask=3D0x6,cmask=3D6/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=
=3D0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D1/u},{=
cpu/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=3D0xb1,umask=3D0x1,cmask=
=3D2/u,cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=3D0x5e,umask=3D0x1/u,cpu/ev=
ent=3D0x9c,umask=3D0x1,cmask=3D4/u},{cpu/event=3D0x79,umask=3D0x30,edge=3D1=
,cmask=3D1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x87,umask=3D0x1/u,=
cpu/event=3D0xab,umask=3D0x2/u,cpu/event=3D0xa2,umask=3D0x8/u},{cpu/event=
=3D0x85,umask=3D0x10/u,cpu/event=3D0x85,umask=3D0x4/u,cpu/event=3D0x3c,umas=
k=3D0x0/u,cpu/event=3D0x8,umask=3D0x10/u,cpu/event=3D0x8,umask=3D0x4/u},{cp=
u/event=3D0xc5,umask=3D0x0/u,cpu/event=3D0xc3,umask=3D0x1,edge=3D1,cmask=3D=
1/u,cpu/event=3D0xe6,umask=3D0x1f/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/ev=
ent=3D0xd1,umask=3D0x4/u,cpu/event=3D0xd1,umask=3D0x20/u,cpu/event=3D0xa3,u=
mask=3D0x5,cmask=3D5/u,cpu/event=3D0x3c,umask=3D0x0/u},{cpu/event=3D0x14,um=
ask=3D0x1/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u,c=
pu/event=3D0x3c,umask=3D0x1/u,cpu/event=3D0x11,umask=3D0x2/u},{cpu/event=3D=
0xc2,umask=3D0x2/u,cpu/event=3D0xe,umask=3D0x1/u,cpu/event=3D0x79,umask=3D0=
x30/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x3c,umask=3D0x2/u},{cpu/e=
vent=3D0xc2,umask=3D0x2/u,cpu/event=3D0x10,umask=3D0x1/u,cpu/event=3D0xb1,u=
mask=3D0x1/u,cpu/event=3D0x10,umask=3D0x20/u},{cpu/event=3D0x10,umask=3D0x8=
0/u,cpu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,cpu/eve=
nt=3D0x11,umask=3D0x1/u},{cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x9c,u=
mask=3D0x1,cmask=3D4/u,cpu/event=3D0x3c,umask=3D0x2/u,cpu/event=3D0x3c,umas=
k=3D0x1/u},dummy,{cpu/event=3D0xa3,umask=3D0x4,cmask=3D4/u,cpu/event=3D0xb1=
,umask=3D0x1,cmask=3D1/u,cpu/event=3D0xb1,umask=3D0x1,cmask=3D3/u,cpu/event=
=3D0xb1,umask=3D0x1,cmask=3D2/u},{cpu/event=3D0xc0,umask=3D0x0/u,cpu/event=
=3D0x5e,umask=3D0x1/u,cpu/event=3D0xa2,umask=3D0x8/u,cpu/event=3D0xa3,umask=
=3D0x6,cmask=3D6/u,cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x60,umask=3D=
0x8,cmask=3D6/u},{cpu/event=3D0x3c,umask=3D0x0/u,cpu/event=3D0x60,umask=3D0=
x8,cmask=3D1/u,cpu/event=3D0x60,umask=3D0x8,cmask=3D6/u},{cpu/event=3D0xc2,=
umask=3D0x2/u,cpu/event=3D0x10,umask=3D0x1/u,cpu/event=3D0xb1,umask=3D0x1/u=
},{cpu/event=3D0x10,umask=3D0x20/u,cpu/event=3D0x10,umask=3D0x80/u,cpu/even=
t=3D0xb1,umask=3D0x1/u,cpu/event=3D0x10,umask=3D0x10/u},emulation-faults,{c=
pu/event=3D0x10,umask=3D0x10/u,cpu/event=3D0x10,umask=3D0x40/u,cpu/event=3D=
0x11,umask=3D0x1/u,cpu/event=3D0x11,umask=3D0x2/u},emulation-faults,{cpu/ev=
ent=3D0x11,umask=3D0x2/u,cpu/event=3D0x11,umask=3D0x1/u,cpu/event=3D0xb1,um=
ask=3D0x1/u}' ~/pmu/pmu-tools/workloads/BC1s
> grep uncore p3
