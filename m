Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97DBC001DE
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGXWjH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGXWjG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 18:39:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891610D1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 15:39:05 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40631c5b9e9so44551cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690238344; x=1690843144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsKPUm+1/LIf2j3Uq5jozTbzzKVgJESjN7eUR+dDD/k=;
        b=yJMRYaoAZhUdlRTw7g+iaENPtanJYDgjb2Q4KRo5v6zLEXy60Oamn/SjKDLyzapnjL
         L0mHQjE9BgYWKqlN0UNzsJzgSIFe2xLnYp23ysIKJtnDL6FRboPWDM+yBT1jbj+NMGfJ
         H6efdSzq8WiAV6kDK4B7xeUOQkbPaUPaH9ioBIgtty1sCEUedmL3e6Zvcqb6FpkLi5jn
         Atl8vB7orogmEGs+qPIge3rU1CrlxBBHE5+F0Qd0reihB4P63WFNJTKvTZVzENOgPFub
         /KmbaUV4tLKf4OTbZUtudqnnmbznxe+q+ZGGDKW09vAFRGnM2uPeUkI8FAqoJ9/vnPHR
         Nw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690238344; x=1690843144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsKPUm+1/LIf2j3Uq5jozTbzzKVgJESjN7eUR+dDD/k=;
        b=OA0Lu4StwMibrGv9Nf4WaRtGCYSGqiuyCgntlLMFu01kQtMSxB0IAoSd3pvnx/9lFC
         EcicEJiUPkB69hc4Qk68X+wWR2BRsRSs5r+6gGxuSeY3ZfMbL8gsUD8PPWO1251qjFfy
         ubFF8zybD3Y9Y6hwn64flkiU1JgXHrOqdQEoCfXB0tcpRmcbqtPrPseP6upllYcHvpsI
         XdXDXi4GR6DJdrww591i0G8L5AKsOKAzlqiu4M+MUDpb/Oasc1xHot6VED89Otnp77e5
         925Mnh+4wZSDVOzKLxpft7Kn5w08PZJ3N24kZ9D0kStNNzM3PA5KIE1kHu7bPxZ0BdBo
         vObA==
X-Gm-Message-State: ABy/qLYG5IVUFhBisLYjimyiWFsd3dGcWNxG8MGAQlEt1WjO4xaNeWKI
        Q4TAEY22K9xH5NTigqRjr9Wg7NuEfayWn49t01dceg==
X-Google-Smtp-Source: APBJJlEBCyIZaRp1g8OODo2/QuQTOParD2vwo3FVPZKBfli16+JHlTnaH1Gv4YbMaar27mBl5a6x5eZ/NpLYL0t3b1c=
X-Received: by 2002:a05:622a:1350:b0:403:ac9c:ac2f with SMTP id
 w16-20020a05622a135000b00403ac9cac2fmr6794qtk.17.1690238344295; Mon, 24 Jul
 2023 15:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
 <CAP-5=fVh5atUjf4sLBYi4CwxYdWJfub_0anXKTdVuJrZkC4-tQ@mail.gmail.com> <CAKwvOd=eZ+m4hJ23S=v-BW0BxuWk=YCW=xRLcD00iTKWBiHjVQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=eZ+m4hJ23S=v-BW0BxuWk=YCW=xRLcD00iTKWBiHjVQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Jul 2023 15:38:52 -0700
Message-ID: <CAP-5=fWSQA6f5V4ntLZC+DsypSJnYXRSkLX0gy232P=yAaukNw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 24, 2023 at 3:27=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 24, 2023 at 2:48=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Jul 24, 2023 at 2:15=E2=80=AFPM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Add a build flag, LTO=3D1, so that perf is built with the -flto
> > > > flag. Address some build errors this configuration throws up.
> > >
> > > Hi Ian,
> > > Thanks for the performance numbers. Any sense of what the build time
> > > numbers might look like for building perf with LTO?
> > >
> > > Does `-flto=3Dthin` in clang's case make a meaningful difference of
> > > `-flto`? I'd recommend that over "full LTO" `-flto` when the
> > > performance difference of the result isn't too meaningful.  ThinLTO
> > > should be faster to build, but I don't know that I've ever built perf=
,
> > > so IDK what to expect.
> >
> > Hi Nick,
> >
> > I'm not sure how much the perf build will benefit from LTO to say
> > whether thin is good enough or not. Things like "perf record" are
> > designed to spend the majority of their time blocking on a poll system
> > call. We have benchmarks at least :-)
> >
> > I grabbed some clang build times in an unscientific way on my loaded la=
ptop:
> >
> > no LTO
> > real    0m48.846s
> > user    3m11.452s
> > sys     0m29.598s
> >
> > -flto=3Dthin
> > real    0m55.910s
> > user    4m2.342s
> > sys     0m30.120s
> >
> > real    0m50.330s
> > user    3m36.986s
> > sys     0m28.519s
> >
> > -flto
> > real    1m12.002s
> > user    3m27.676s
> > sys     0m30.305s
> >
> > real    1m5.187s
> > user    3m19.348s
> > sys     0m29.031s
> >
> > So perhaps thin LTO increases total build time by 10%, whilst full LTO
> > increases it by 50%.
> >
> > Gathering some clang performance numbers:
> >
> > no LTO
> > $ perf bench internals synthesize
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >  Average synthesis took: 178.694 usec (+- 0.171 usec)
> >  Average num. events: 52.000 (+- 0.000)
> >  Average time per event 3.436 usec
> >  Average data synthesis took: 194.545 usec (+- 0.088 usec)
> >  Average num. events: 277.000 (+- 0.000)
> >  Average time per event 0.702 usec
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >  Average synthesis took: 175.381 usec (+- 0.105 usec)
> >  Average num. events: 52.000 (+- 0.000)
> >  Average time per event 3.373 usec
> >  Average data synthesis took: 188.980 usec (+- 0.071 usec)
> >  Average num. events: 278.000 (+- 0.000)
> >  Average time per event 0.680 usec
> >
> > -flto=3Dthin
> > $ perf bench internals synthesize
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >  Average synthesis took: 183.122 usec (+- 0.082 usec)
> >  Average num. events: 52.000 (+- 0.000)
> >  Average time per event 3.522 usec
> >  Average data synthesis took: 196.468 usec (+- 0.102 usec)
> >  Average num. events: 277.000 (+- 0.000)
> >  Average time per event 0.709 usec
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >  Average synthesis took: 177.684 usec (+- 0.094 usec)
> >  Average num. events: 52.000 (+- 0.000)
> >  Average time per event 3.417 usec
> >  Average data synthesis took: 190.079 usec (+- 0.077 usec)
> >  Average num. events: 275.000 (+- 0.000)
> >  Average time per event 0.691 usec
> >
> > -flto
> > $ perf bench internals synthesize
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >  Average synthesis took: 112.599 usec (+- 0.040 usec)
> >  Average num. events: 52.000 (+- 0.000)
> >  Average time per event 2.165 usec
> >  Average data synthesis took: 119.012 usec (+- 0.070 usec)
> >  Average num. events: 278.000 (+- 0.000)
> >  Average time per event 0.428 usec
> > # Running 'internals/synthesize' benchmark:
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >  Average synthesis took: 107.606 usec (+- 0.147 usec)
> >  Average num. events: 52.000 (+- 0.000)
> >  Average time per event 2.069 usec
> >  Average data synthesis took: 114.633 usec (+- 0.159 usec)
> >  Average num. events: 279.000 (+- 0.000)
> >  Average time per event 0.411 usec
> >
> > The performance win from thin LTO doesn't look to be there. Full LTO
> > appears to be reducing event synthesis time down to 60% of what it
> > was. The clang numbers are looking better than the GCC ones. I think
> > from this it makes sense to use -flto.
>
> Without any context, I'm not really sure what numbers are good vs. bad
> ("is larger better?").  More so I was curious if thinLTO perhaps got
> most of the win without significant performance regressions. If not,
> oh well, and if the slower full LTO has numbers that make sense to
> other reviewers, well then *Chuck Norris thumbs up*.  Thanks for the
> stats.

I can at least explain the stats. When perf starts it has to
"synthesize" the state-of-the machine, it generates fake events to
describe the mmaps in each process by reading /proc. This is done most
typically so a virtual address can be turned into a filename and line
number. Generally this is done for the text part of a binary but it
may also be done for the data. Large systems may take a long time to
synthesize all the state for, hence the benchmark.

The result I normally look at above is the "Average time per event",
so without LTO or with thin LTO each event is taking approx. 180
microseconds to create. With full LTO the time taken per event is 110
microseconds, which could be a noticeable start-up time win.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
