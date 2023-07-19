Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2DC0015E
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 16:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGSQzx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGSQzw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 12:55:52 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4F172E
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 09:55:51 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40371070eb7so4251cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689785751; x=1692377751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj3T/c8YmvgYfTPVsluIq5bnwE6iaG+nhT4u1XN3xLo=;
        b=AGauPzP+8A9C+sl48+22NswYUFYkLmocOlzOPRtRzGNodahOvDljveR86sZfrkPW3K
         US8iRew1BEtZbAN6hhw0SpfSi8U9+bkjubJXW2G2IC7yVaotwcPSaW0YHtREMyTLs4BI
         KqHsQyyUkVmdqDcwMfjtUQyAmlgkHfu7Pk5s4EdLPxKicFU2T7sTUfShrDVnJzPawepi
         unuF4nvUQhVxecmP8wiKzkcTwrXQVugAnbr/IASM1PWYJIsChQYV4X0cMh1lzmjnDti+
         ES30zALn0mmVGx16mAF/lvdlIo3yX+4luTfgbnMx8TlNWVcAA0znb6RmnaTMG7WHhmRb
         Wc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689785751; x=1692377751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj3T/c8YmvgYfTPVsluIq5bnwE6iaG+nhT4u1XN3xLo=;
        b=e2QvbKtnj5iQFXk49qYXTHpGHxLKEnFmV6T5WRynKx5JqMLJ+PnTvXVojdXfHy91NN
         6tp4sKbiAMfZe4WN8toiy4jN4C6sh0harDRWxjhP6VDObCCIVl6F0O13277eh53tfoMc
         KARxwZ55OT3J0O4WJoi4WKp7DojDlmyPG9u9GBrXTBgBVL+sYiBqKmvwo9rxQlalxgVJ
         xFIIbB8YvSF7T3rI7oyhH1tykSrHqU/JUkuvf21pmA/mnskTKEmdgMKmJy5itzDco0bE
         jXLVa6J/vB664SJbkzCsZwmNsEafbqqjmUXKtWHg5y4wzjpZsSyY7+HoRZHTlrLywLsR
         4i5g==
X-Gm-Message-State: ABy/qLYZhX91fRWyvWvZK99Fe4uCXXGlO0SauVP+QOFf3bSGuA3fO+2o
        YdVjePlm7zzwyYCkY5dUiX0q0fqIoGuEAADkKqpgRQ==
X-Google-Smtp-Source: APBJJlFZiNoYe1axEr2mRKwb20Bd4i3b8lR3RBIA0XbPnU5r0k3J9KjP047hqPmE1v2p3Yuc0NIVMsvEr0fyri/cRVM=
X-Received: by 2002:ac8:5714:0:b0:403:a43d:bd7d with SMTP id
 20-20020ac85714000000b00403a43dbd7dmr625699qtw.4.1689785750750; Wed, 19 Jul
 2023 09:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230713085831.395112-1-changbin.du@huawei.com>
 <b1127b63-6c6a-e42e-ce6c-cf4f24bbc5a1@intel.com> <20230714071914.3jro4kfcvhun2ptd@M910t>
In-Reply-To: <20230714071914.3jro4kfcvhun2ptd@M910t>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 09:55:39 -0700
Message-ID: <CAP-5=fV49y9y8Q3-3rhACMQJiQ+nAh0RfysT8bhpJ5_AOqLScw@mail.gmail.com>
Subject: Re: [PATCH] perf: add new option '--workload-attr' to set workload sched_policy/priority/mask
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 14, 2023 at 12:19=E2=80=AFAM Changbin Du <changbin.du@huawei.co=
m> wrote:
>
> On Fri, Jul 14, 2023 at 10:06:31AM +0300, Adrian Hunter wrote:
> > On 13/07/23 11:58, Changbin Du wrote:
> > > To get consistent benchmarking results, sometimes we need to set the
> > > sched_policy/priority/mask of the workload to reduce system noise.
> > >
> > > For example, CPU binding is required on big.little system.
> > >
> > >   $ perf stat -r 10 -- taskset -c 0 ls
> > >
> > > Nevertheless, the 'taskset' is also counted here.
> > >
> > > To get away of the middleman, this adds a new option '--workload-attr=
' to
> > > do the same jobs for stat and record commands.
> > >
> > >   $ sudo perf stat --workload-attr fifo,40,0x1 -- ls
> > >
> > > Above will make 'ls' run on CPU #0 with fifo scheduler and realtime
> > > priority is 40.
> >
> > Aren't there ways to set up a process then start perf using -p <pid>
> > then let the process continue.
> >
> By that you need a mechanism to pause the new spawnned process and wait p=
erf to
> attach. Or setup the sched properties by the app itself. But sometimes we=
 just
> simply want to run the app through and measure some events. With
> --workload-attr, we do not need extra setup works.

To my naive eyes this looks to be a broadly useful addition. Some thoughts:
 - "cpu-mask" as the command line argument name, this is "-C" and
"--cpu" elsewhere, so perhaps just "cpu" as the mask is perhaps
confusing.
 - could we get a test? Perhaps add a case to tools/perf/tests/shell/stat.s=
h:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat.sh?h=3Dperf-tools-next

Thanks,
Ian

> --
> Cheers,
> Changbin Du
