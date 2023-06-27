Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225ECEB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 17:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjF0RTd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjF0RTc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 13:19:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BA5198
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 10:19:31 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso17611cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687886370; x=1690478370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBjJTKwL7vgV3jsH8nCrQ0roxswa1psP2GFa+i0N8HY=;
        b=Rp0Kw1Qs355H8V84pEHlLy/4KG6qgT0o3WdQQKlac1LOxRtZMPi27kXfeSBsqegbh8
         +x1Dij5wvH8fwI+fu2F/ODa1yv82sxCydGklIb0PIU5Xc/Qff52stuvVBJU8Ye5N9YJG
         iTiJ2l8EA/odAs2OSbbbC3WPbuS9m+5YHzE56SM/aWstBhdWMkGgJ1tcWfljc314BNFP
         UFUN9yrCUa6pXS06pw6svv4SEKqqeCXkeKOiVrWuXRDAcLNlIS2ZMi01ClkqJmZx261w
         Wq5T/W2fuLq0AfOu0wr1/Z0JDdbVPwJqeJK10HrNa281IEOlje4PONG26Kn1BEkz39Lp
         /zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886370; x=1690478370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBjJTKwL7vgV3jsH8nCrQ0roxswa1psP2GFa+i0N8HY=;
        b=DnLiPkTogB6sX48Z+3+icyJuLYj6uG6COSDfP1USmBQZS++esXx155E2eevV8ueprZ
         bRcHkjEeW/vyYhNrrWSmWXV/YrDeTwJxofddKhjAfr4Sa4Gab+LOYeXCWAzH0dMr3nAs
         hVpbZyPI/bjOm5v5kCNkmENGYqRMDjapHp0T6o8FFa++zB7inAm41/vQ3Noqz/xc356z
         IhT9ELlGvxvd1JSaLHqVCzpMc06hZGbOMTXk4Z+8Ea6bA8J85ymc4PRxxXewwgi3Kvcu
         +DS1RThBxBucxPkpAOgnogSG3bZ9w7734TaqNu8UZQ/y236OEAd6LOpBGnfN3jCgoMW5
         v59A==
X-Gm-Message-State: AC+VfDyYGpS+Z3nDj9xHWhMJXV6W34M0ehTqUEwugM5jR/c15R2zEQxH
        1pvh9B/QoBPWmd+b+8cgFaCHj32P5UnwQfypq3frFg==
X-Google-Smtp-Source: ACHHUZ4jwWSCrq7FmwwM8vfo7rB80rBGxbKjbEqwSR7EzE02DXl4ESDvoaoT0aF3jdU7Zy9PoXq5qJ/C9ohuDqc+z58=
X-Received: by 2002:ac8:5710:0:b0:3ef:343b:fe7e with SMTP id
 16-20020ac85710000000b003ef343bfe7emr2710qtw.2.1687886369968; Tue, 27 Jun
 2023 10:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230626161059.324046-1-james.clark@arm.com> <20230626161059.324046-3-james.clark@arm.com>
 <ZJonE3ZZ2cBUq0U8@google.com> <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
 <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
In-Reply-To: <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 27 Jun 2023 10:19:18 -0700
Message-ID: <CAP-5=fUTzn06DM7o-1qBx7Tauo2Q2ACHmYcvwTmrTOJpzS2=oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 27, 2023 at 9:58=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jun 27, 2023 at 9:43=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Jun 26, 2023 at 5:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> > > > thread__find_map() chooses to exit without assigning a thread to th=
e
> > > > addr_location in some scenarios, for example when there are samples=
 from
> > > > a guest and perf_guest =3D=3D false. This results in a segfault whe=
n adding
> > > > to the histogram because it uses unguarded accesses to the thread m=
ember
> > > > of the addr_location.
> > >
> > > Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
> > > init/exit/copy functions") that introduced the change, I'm not sure i=
f
> > > it's the intend behavior.
> > >
> > > It might change maps and map, but not thread.  Then I think no reason
> > > to not set the al->thread at the beginning.
> > >
> > > How about this?  Ian?
> > > (I guess we can get rid of the duplicate 'al->map =3D NULL' part)
> >
> > It seemed strange that we were failing to find a map (the function's
> > purpose) but then populating the address_location. The change below
> > brings back that somewhat odd behavior. I'm okay with reverting to the
> > old behavior, clearly there were users relying on it. We should
> > probably also copy maps and not just thread, as that was the previous
> > behavior.
>
> Probably.  But it used to support samples without maps and I think
> that's why it ignores the return value of thread__find_map().  So
> we can expect al.map is NULL and maybe fine to leave it for now.
>
> As machine__resolve() returns -1 if it gets no thread, we should set
> al.thread when it returns 0.
>
> Can I get your Acked-by?

Yep:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
