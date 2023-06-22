Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95626EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 19:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjFVTJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVTJ2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 15:09:28 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BBA2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 12:09:26 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-57083a06b71so66419817b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 12:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460965; x=1690052965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87BxhSRyXFg8mpf98ax+eIK8SAfXetWB2esvKeG5gKU=;
        b=jeZKGjIpdyPBNPHLYB3XiVRBB0KaTY9T9i9/iK68l2qwxlnkozEaTaGCqxhtbu+p0Y
         Fv1g1qw5QZ6bSvCeaMN5+JYEWq86g+fnoDopCyPI+Ek3TrjT3K+benNdoJIeY7aC15K7
         HpeaOaAOvs7GkKTUGrgpMmO8pV7LSevB+csxy8JCa7RzzzB3hhhZ9xwpt+z1++d/8Ilg
         +uS9aZYpn3SHvv7xECkNcDGzr5TFpJaf8hcLbTMVgmztkH0wrXkZ+cjsDAquI3+d/Gt/
         ndnEY2/JQrOjuJxzWqK27ntjsJ7YVTIHiQeVfO9ffJZT3X1XLIBQPRJc51Q9oiHBxuyA
         +mMQ==
X-Gm-Message-State: AC+VfDwCm9WWoVHCMCP6BU7Fib/080aqj9BWKJIIKWEQcobhHWkKuVd2
        IkTpSO9TjEIy+zvqADU5eXvb1Yhpxj8dNHGJgabdt30h
X-Google-Smtp-Source: ACHHUZ56fjZQMXRRW5uEAcxmSOp8Gg+DFqDQs5ROYu7v2glzTLKlEMXzJPuXyA6R4Z+hzD2+t1aCENaCprTIynZEQMY=
X-Received: by 2002:a25:2e4d:0:b0:bc5:b1d7:bf75 with SMTP id
 b13-20020a252e4d000000b00bc5b1d7bf75mr14690758ybn.23.1687460965204; Thu, 22
 Jun 2023 12:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <ZJOmXU/41HMzanM9@tassilo> <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
In-Reply-To: <ZJQSUHLe9Cqpw21n@tassilo>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 12:09:14 -0700
Message-ID: <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
Subject: Re: Perf stat regression from d15480a3d67
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Andi,

Sorry about the breakage.

On Thu, Jun 22, 2023 at 2:20 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > Can you provide an example that is breaking?
>
> I only have a very long auto generated example[1], because it's not
> easy to make a non scheduling event and it's also dependent on the system. The example
> works on a SKX.
>
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
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2139
>
> How is any tool supposed to handle arbitary output reordering like
> that? Perf is not just for humans, but also for tools.

Is the problem of reordering the output or hiding something?
Do you mean both?

>
> It cannot just look up the events by name because there might be multiple
> instances of the same event in different groups.
>
> The only reliable way to match is to match on the original order,
> but that totally breaks down with these changes.
>
> The same actually applies to humans reading the output too,
> if it's ambigious for the tool it will be ambigious to the human too.
> perf stat shouldn't reorder events ever.
>
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

Right, I wanted to skip (or hide) events that are not reasonable
like with redundant or invalid setups.  It should display those
error results.

Didn't you say you only have problems in uncore events?

>
>
> -Andi
>
> [1] Long example for SKX:
>
> perf stat -o p3 -x\;

It seems you don't use any special aggregation option
which means the global aggr mode is used.  Then I think
should_skip_zero_counter() would return false because
aggr_cpu_id__equal() is true and the result should be printed.
Hmm...


-e '{cpu/event=0xc0,umask=0x0/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x0,umask=0x3/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0xb1,umask=0x1/u,cpu/event=0xb1,umask=0x2,cmask=1/u},msr/tsc/,duration_time,dummy,uncore_imc/event=0x4,umask=0x3/,uncore_imc/event=0x4,umask=0xc/,cs:u,minor-faults:u,major-faults:u,migrations:u,{cycles:u,cpu/event=0x0,umask=0x3/u,cpu/event=0xc2,umask=0x2/u,cpu/event=0xc0,umask=0x0/u,cpu/event=0xc4,umask=0x40/u,cpu/event=0xb1,umask=0x1/u,cpu/event=0xe,umask=0x1/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0xc2,umask=0x2,cmask=1/u,cpu/event=0x3c,umask=0x0/ku,cpu/event=0xc0,umask=0x0/ku},{cpu/event=0x79,umask=0x8/u,cpu/event=0xa8,umask=0x1/u,cpu/event=0x79,umask=0x4/u,cpu/event=0x79,umask=0x30/u,cpu/event=0xc0,umask=0x0/u,cpu/event=0x3c,umask=0x0/u},{cpu/event=0x10,umask=0x20/u,cpu/event=0x10,umask=0x80/u,cpu/event=0x10,umask=0x10/u,cpu/event=0x10,umask=0x40/u},{cpu/event=0x11,umask=0x2/u,cpu/event=0x11,umask=0x1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u},{cpu/event=0x10,umask=0x20/u,cpu/event=0x10,umask=0x80/u,cpu/event=0x10,umask=0x10/u,cpu/event=0x10,umask=0x40/u,cpu/event=0x3c,umask=0x0/u},{cpu/event=0x3c,umask=0x0/ku,cpu/event=0x3c,umask=0x1/u,cpu/event=0xc2,umask=0x2/u,cpu/event=0xd,umask=0x3,cmask=1/u},{cpu/event=0x9c,umask=0x1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0xc2,umask=0x2/u},{cpu/event=0xe,umask=0x1/u,cpu/event=0xc2,umask=0x2/u,cpu/event=0xd,umask=0x3,cmask=1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u},{cpu/event=0x9c,umask=0x1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0xe,umask=0x1/u},{cpu/event=0x3c,umask=0x0/u,cpu/event=0x9c,umask=0x1,cmask=4/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0x9c,umask=0x1/u,cpu/event=0xc0,umask=0x0/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0xd,umask=0x3,cmask=1/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0xe,umask=0x1/u,cpu/event=0x79,umask=0x30/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u},{cpu/event=0xe,umask=0x1/u,cpu/event=0xc2,umask=0x2/u,cpu/event=0xd,umask=0x3,cmask=1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u},{cpu/event=0xc5,umask=0x0/u,cpu/event=0xc3,umask=0x1,edge=1,cmask=1/u,cpu/event=0x3c,umask=0x1/u},dummy,{cpu/event=0xe,umask=0x1/u,cpu/event=0xc2,umask=0x2/u,cpu/event=0xd,umask=0x3,cmask=1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u},{cpu/event=0x9c,umask=0x1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0xe,umask=0x1/u},dummy,{cpu/event=0xa3,umask=0x6,cmask=6/u,cpu/event=0xa2,umask=0x8/u,cpu/event=0xa3,umask=0x4,cmask=4/u,cpu/event=0xb1,umask=0x1,cmask=1/u},{cpu/event=0xb1,umask=0x1,cmask=3/u,cpu/event=0xb1,umask=0x1,cmask=2/u,cpu/event=0xc0,umask=0x0/u,cpu/event=0x5e,umask=0x1/u,cpu/event=0x9c,umask=0x1,cmask=4/u},{cpu/event=0x9c,umask=0x1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0xe,umask=0x1/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0xd,umask=0x3,cmask=1/u},dummy,dummy,emulation-faults,dummy,{cpu/event=0xa3,umask=0x6,cmask=6/u,cpu/event=0xa2,umask=0x8/u,cpu/event=0xa3,umask=0x4,cmask=4/u,cpu/event=0xb1,umask=0x1,cmask=1/u},{cpu/event=0xb1,umask=0x1,cmask=3/u,cpu/event=0xb1,umask=0x1,cmask=2/u,cpu/event=0xc0,umask=0x0/u,cpu/event=0x5e,umask=0x1/u,cpu/event=0x9c,umask=0x1,cmask=4/u},{cpu/event=0x79,umask=0x30,edge=1,cmask=1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x87,umask=0x1/u,cpu/event=0xab,umask=0x2/u,cpu/event=0xa2,umask=0x8/u},{cpu/event=0x85,umask=0x10/u,cpu/event=0x85,umask=0x4/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x8,umask=0x10/u,cpu/event=0x8,umask=0x4/u},{cpu/event=0xc5,umask=0x0/u,cpu/event=0xc3,umask=0x1,edge=1,cmask=1/u,cpu/event=0xe6,umask=0x1f/u,cpu/event=0x3c,umask=0x0/u},{cpu/event=0xd1,umask=0x4/u,cpu/event=0xd1,umask=0x20/u,cpu/event=0xa3,umask=0x5,cmask=5/u,cpu/event=0x3c,umask=0x0/u},{cpu/event=0x14,umask=0x1/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u,cpu/event=0x11,umask=0x2/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0xe,umask=0x1/u,cpu/event=0x79,umask=0x30/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x3c,umask=0x2/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0x10,umask=0x1/u,cpu/event=0xb1,umask=0x1/u,cpu/event=0x10,umask=0x20/u},{cpu/event=0x10,umask=0x80/u,cpu/event=0x10,umask=0x10/u,cpu/event=0x10,umask=0x40/u,cpu/event=0x11,umask=0x1/u},{cpu/event=0x3c,umask=0x0/u,cpu/event=0x9c,umask=0x1,cmask=4/u,cpu/event=0x3c,umask=0x2/u,cpu/event=0x3c,umask=0x1/u},dummy,{cpu/event=0xa3,umask=0x4,cmask=4/u,cpu/event=0xb1,umask=0x1,cmask=1/u,cpu/event=0xb1,umask=0x1,cmask=3/u,cpu/event=0xb1,umask=0x1,cmask=2/u},{cpu/event=0xc0,umask=0x0/u,cpu/event=0x5e,umask=0x1/u,cpu/event=0xa2,umask=0x8/u,cpu/event=0xa3,umask=0x6,cmask=6/u,cpu/event=0x3c,umask=0x0/u,cpu/event=0x60,umask=0x8,cmask=6/u},{cpu/event=0x3c,umask=0x0/u,cpu/event=0x60,umask=0x8,cmask=1/u,cpu/event=0x60,umask=0x8,cmask=6/u},{cpu/event=0xc2,umask=0x2/u,cpu/event=0x10,umask=0x1/u,cpu/event=0xb1,umask=0x1/u},{cpu/event=0x10,umask=0x20/u,cpu/event=0x10,umask=0x80/u,cpu/event=0xb1,umask=0x1/u,cpu/event=0x10,umask=0x10/u},emulation-faults,{cpu/event=0x10,umask=0x10/u,cpu/event=0x10,umask=0x40/u,cpu/event=0x11,umask=0x1/u,cpu/event=0x11,umask=0x2/u},emulation-faults,{cpu/event=0x11,umask=0x2/u,cpu/event=0x11,umask=0x1/u,cpu/event=0xb1,umask=0x1/u}'
~/pmu/pmu-tools/workloads/BC1s
> grep uncore p3

It's a very long list of events but seems mostly core events.
Can we have a smallest reproducer only with uncore events?

Thanks,
Namhyung
