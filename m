Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814D8C001B0
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 21:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjGMVYi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGMVYh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 17:24:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABD2D54
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 14:24:35 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40371070eb7so41381cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689283475; x=1691875475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEnC7x1RGQj5oAgSDRnbx2nMzoQyjxYOV4L35ww3geE=;
        b=ZKP5x6Jl2EOy/9UuotbyOkHYPqhA/DGpKs8Xo0oZcLYNI0v7k9L/JflUiYfRLCNmvF
         g0vIgR3441Q8S/5sDIvZzO7Twi/O5MlMknY74PL5rgtMBYkHC0jB5R+np4w3GmJaVnyX
         jqF4ZPoVXp6bN7DtDaqaJdmu7ht6cJyPKTA72sTUyz9UFyFJ5jqWZ6WlF2tU/l3T3xFk
         TGh5asH9/HDVmYpsMR8eUxjid8ih44264CJHjk8hIeU7pz8Apkf0FNxq+H24SrXv6yfR
         MUIc7Tco9L/DI8BhREXcSNzHcgT/FfkqXeV2RbRAIwtMIFwyfGIEpIJDwPDGi2h7b/Tr
         pb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283475; x=1691875475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEnC7x1RGQj5oAgSDRnbx2nMzoQyjxYOV4L35ww3geE=;
        b=b/FEKLl3pPRUgNH6XT6R7hU7lNdndyaC1D+YN45g366blsvZjKzVm/XgozsBXHGblm
         nsDn8zeR6fgmZ1WLwrfg4NT+cG+JPOz16v5DBbFTgPTCIGxnUv5Fhl/R+aFkp1paFg8P
         srkdUJOcl1rcrBlpH0CNB65/S+dV+L/PRzOc5YnliXQFKxKofFLA/CgSRB3LelpxmrRq
         3dud/2/nHVj0DUFCmAi7DZ2EhUdRXKGX1UlvLzt7o7Dr5vrXAR2eD8HtTtYHCi//VRAE
         G7wBjXjLBAnMXr6nkwA3dhU+vXoMxYPh8JyhcNOjzqTT++RDZ0Ry/ggZLYJG8EpPG0Ha
         K98A==
X-Gm-Message-State: ABy/qLbRkkOIrNPfkuLKBV4vRK4cPv9Ub69/B8G2jKgc51qxWNhBK59e
        K+CUDrRM7o9lClxpcnRLKPqPDlZsjFabIw2wBkzDXWDP7aTjDgiKVB/irQ==
X-Google-Smtp-Source: APBJJlHU9qt6Xv9u7Nqy/76Q/OQBmpJgrt/U6yO/T6UlrO3Dg7EwQfcvQTU61KAK3W8A1Qihg/zvNWQDfVuC+t1s2HE=
X-Received: by 2002:ac8:7f11:0:b0:3f9:6930:1308 with SMTP id
 f17-20020ac87f11000000b003f969301308mr656529qtk.13.1689283474807; Thu, 13 Jul
 2023 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZLBgbHkbrfGygM/u@tassilo> <ZLBjI4a3wIMs75lA@kernel.org>
In-Reply-To: <ZLBjI4a3wIMs75lA@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Jul 2023 14:24:22 -0700
Message-ID: <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
Subject: Re: Event reordering regression for software events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 13, 2023 at 1:48=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jul 13, 2023 at 01:37:00PM -0700, Andi Kleen escreveu:
> > Hi Ian,
> >
> > The current post 6.3 linux-perf-next causes some fairly drastic
> > reordering in output for some event combinations. I bisected it down to
> > your patch:
> >
> > commit 347c2f0a0988c59c402148054ef54648853fa669
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Sat Mar 11 18:15:40 2023 -0800
> >
> >     perf parse-events: Sort and group parsed events
> >
> >     This change is intended to be a no-op for most current cases, the
> >     default sort order is the order the events were parsed. Where it
> >     varies is in how groups are handled. Previously an uncore and core
> >     event that are grouped would most often cause the group to be remov=
ed:
> >

So this is a no-op for most current cases where event groups aren't
used. The default order for events is the order they were inserted in.
Unfortunately Intel added perf metric, aka topdown, events where we
need to add or regroup events and also multiple vendors did
BIG.little/hybrid. Previously we'd sort and regroup uncore events
like:

perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_running/d=
ata_write/}'
...

to be say two groups of:

{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_write/=
}
{uncore_imc_free_running_1/data_read/,uncore_imc_free_running_1/data_write/=
}

Rather than how they appear after parsing of:

{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/,=
uncore_imc_free_running_0/data_write/,uncore_imc_free_running_1/data_write/=
}

Presumably toplev already supports this. With hybrid, what is true for
uncore PMUs is now true for core PMUs, so:

perf stat -e '{instructions,cycles}' ...

becomes:

{cpu_atom/instructions/,cpu_atom/cycles/}
{cpu_core/instructions/,cpu_core/cycles/}

Perf metric events require being in a group with the slots event
first. There are assumptions in the perf code that sibling events are
adjacent in the evlist. To fix and maintain all the requirements on
the evlist we've gotten to where we are now. I've tried to make the
code as simple and transparent as possible, but still fulfilling the
requirements coming from perf metric events and hybrid. The logic is
in parse_events__sort_events_and_fix_groups:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2139

where the compare function evlist__cmp and
evsel__compute_group_pmu_name are key. The "group" PMU name is what
attempts to place all events that belong in the same group together,
which include software and aux events.

> > I currently only have a large test case, but for the test case [1] belo=
w
> > most of the "dummy"s and some other software events end up in a row and=
 also in the
> > wrong place, instead of the expected order.
> >
> > good:
> >
> > ...
> > 986476553;ns;duration_time;986476553;100.00;;
> > 0;;dummy;983952237;100.00;;
> > 0;;cs:u;983952237;100.00;;
> > 16532;;minor-faults:u;983952237;100.00;;
> > 0;;major-faults:u;983952237;100.00;;
> > 0;;migrations:u;983952237;100.00;;
> > 3532509496;;cycles:u;23999092;2.00;;
> > ....
> >
> > bad:
> >
> > 1010119571;ns;duration_time;1010119571;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;cs:u [software];1007748753;100.00;;
> > 16496;;minor-faults:u [software];1007748753;100.00;;
> > 0;;major-faults:u [software];1007748753;100.00;;
> > 0;;migrations:u [software];1007748753;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;emulation-faults [software];1007748753;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;dummy [software];1007748753;100.00;;
> > 0;;emulation-faults [software];1007748753;100.00;;
> > 0;;emulation-faults [software];1007748753;100.00;;
> > 3603193382;;cycles:u;23996241;2.00;;
> > 2277091922;;cpu/event=3D0x0,umask=3D0x3/u;23996241;2.00;;
> > 4182126406;;cpu/event=3D0xc2,umask=3D0x2/u;23996241;2.00;;
> > 4364677170;;cpu/event=3D0xc0,umask=3D0x0/u;23996241;2.00;;
> >
> >
> > Unfortunately this totally breaks toplev. It needs to have the dummies
> > in the right location.`
> >
> > Another problem is that it also now adds [software] to lots of software
> > events, which of course also breaks any parsing tools. I haven't bisect=
ed
> > that too, but it needs fixing too.

There's nothing to bisect, the behavior has changed. We can revert the
behavior, break Intel hybrid and Intel perf metric events, but that
would seem unfortunate. Tbh, the mistake here is the assumptions that
toplev is making.

> >
> > I must say using perf recently is frustrating with all the regressions!
> > Please be a bit more careful with compatibility.
>
> That is really unfortunate and indeed perf passed thru a lot of changes
> trying to properly support hybrid systems and verify reference counting
> correctness, a necessary step to resume attempts at being multithreaded.
>
> We have seen a growing number of 'perf test' entries being submitted,
> with writing shell scripts that check if the output from various command
> lines produce expected results.
>
> It would really be great to have new entries that exercise what is
> expected by toplev so that we really are careful with compatibility.

We are careful with compatibility, in fact we've written a number of
tests to ensure the json and CSV output doesn't regress. Kan recently
added some tests for text output, but relying on it is likely a bad
idea. I've heard >1 proposal to do nesting of metrics and the like,
Kan recently removed events and put metric names in the text output
instead, even hiding events that have been programmed.. basically
relying on text output is wrong and toplev is broken in this regard.

Fixing hybrid and perf metric events weren't problems of my invention,
nor were they done with a casual disregard for perf users and no care
about breaking them. That said, testing can always be better so why
not add toplev's tests to tools/perf/tests/shell ? This way I can only
break things if I ignore a test regression.

Thanks,
Ian

>
> - Arnaldo
