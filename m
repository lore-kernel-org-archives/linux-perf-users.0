Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF89C00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 14:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiG2O2x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiG2O2w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 10:28:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152931DC3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 07:28:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v17so6200960wrr.10
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSCRUzqHEeshRCXk0c46IYD/2B5v+syWELOAjW4JLl8=;
        b=ht+dLOTBjToDS/+UkuMYt6260/Cg9KmnKO7XPvOPdsrk7keccvGCS2sa0dK4ivOoda
         WwP87v/UcnAi+HpCgtaUMVc321imz5QObRqhFHnDQwbG/SarxZvLE2U24YsozI1hcGVF
         D5G2cgoJ8cnB8lSQZQfC1ZH9nUoyrwai/sTsLWHvxT+QO6fM/ZE/J2doHTnFtNVuKZZk
         hZwerSx//XqShJnS6yeyzO11muejbNczCrFsDKTl0qh9zMA40Yq+5ZGFSQkQhVKXL0Az
         WXfDRBZyxHtz26kzz+tFSegtY4SOBB46T8TYmk8v86bY/rqQq1/a8bhi6NXBCQOahz2z
         Rz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSCRUzqHEeshRCXk0c46IYD/2B5v+syWELOAjW4JLl8=;
        b=Pq/s0lTGE1eLGOzoMhXfb5idT8Yq/r1o0w5WBwPnrB1O67J1SzTmu6Sw2Pqonu+pOr
         P/tTYZwqYRgV3zXLD4M0eKNTvu8omHFcknoPgtQJHBzNNuRS92PvgN17epwIbsLBzdWA
         HT2kCv280mIdX1qM+AM/C6e4fEHtPtJLY6TG9FCFzICIrcr+jlWG3GPlZvsxvI41keOx
         muKpHDRtJuglgyTwfag0zCcTyLgvww+Rlzgec/MH0IAvYCfxTduNXqYickVGwlLDXEoJ
         mwtG8S4+9Os0LqBpi5zIpdfJioDi2zk+A01LbsZWT1E9ZgU8ebVunVtP3ITqKA3HCCCx
         1Ygg==
X-Gm-Message-State: ACgBeo3jwNKN9hahXrV7LdQQnDqRLCJHn309O63da7lS4FfMR1t+JANM
        7v8NZrg3BNCtXIzACidg90SOOANFd1xLyhm1hVIk3stcQ6gZfo+m
X-Google-Smtp-Source: AA6agR7SF8L2zGkGQ8Oi2s4j6CMeJzn0PTlELJABR3Z3tcIstQ9HpPnm0kwIyZFk86W12xyZOV981Bp6rSI3Bx96yA0=
X-Received: by 2002:a5d:6481:0:b0:21e:6c01:95a2 with SMTP id
 o1-20020a5d6481000000b0021e6c0195a2mr2592575wri.40.1659104928546; Fri, 29 Jul
 2022 07:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <CAP-5=fVwWDyD5R7mkdGEqP1dchDOsdmrAPbaZFE7bUjYM3pYFA@mail.gmail.com>
 <CAP-5=fVyyj4nwam3grTAw94w8Ad+qZP6LDxYZv17vP2ph6pXwA@mail.gmail.com> <YuPGFNZNF+hAGWOa@krava>
In-Reply-To: <YuPGFNZNF+hAGWOa@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 07:28:36 -0700
Message-ID: <CAP-5=fUTX37VS949zKKkXA+a8rtWY_fSjZG+J2gRcqd6uhCw8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Corrections to cpu map event encoding
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 29, 2022 at 4:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Jul 28, 2022 at 07:01:09PM -0700, Ian Rogers wrote:
> > On Fri, Jul 15, 2022 at 10:01 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Jun 14, 2022 at 7:33 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > A mask encoding of a cpu map is laid out as:
> > > >   u16 nr
> > > >   u16 long_size
> > > >   unsigned long mask[];
> > > > However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> > > > after long_size. This means 32-bit and 64-bit builds see the mask as
> > > > being at different offsets. On top of this the structure is in the byte
> > > > data[] encoded as:
> > > >   u16 type
> > > >   char data[]
> > > > This means the mask's struct isn't the required 4 or 8 byte aligned, but
> > > > is offset by 2. Consequently the long reads and writes are causing
> > > > undefined behavior as the alignment is broken.
> > > >
> > > > These changes do minor clean up with const, visibility of functions
> > > > and using the constant time max function. It then adds 32 and 64-bit
> > > > mask encoding variants, packed to match current alignment. Taking the
> > > > address of a packed struct leads to unaligned data, so function
> > > > arguments are altered to be passed the packed struct. To compact the
> > > > mask encoding further and drop the padding, the 4-byte variant is
> > > > preferred. Finally a new range encoding is added, that reduces the
> > > > size of the common case of a range of CPUs to a single u64.
> > > >
> > > > On a 72 CPU (hyperthread) machine the original encoding of all CPUs is:
> > > > 0x9a98 [0x28]: event: 74
> > > > .
> > > > . ... raw event: size 40 bytes
> > > > .  0000:  4a 00 00 00 00 00 28 00 01 00 02 00 08 00 00 00  J.....(.........
> > > > .  0010:  00 00 ff ff ff ff ff ff ff ff ff 00 00 00 00 00  ................
> > > > .  0020:  00 00 00 00 00 00 00 00                          ........
> > > >
> > > > 0 0 0x9a98 [0x28]: PERF_RECORD_CPU_MAP
> > > >
> > > > Using the 4-byte encoding it is:
> > > > 0x9a98@pipe [0x20]: event: 74
> > > > .
> > > > . ... raw event: size 32 bytes
> > > > .  0000:  4a 00 00 00 00 00 20 00 01 00 03 00 04 00 ff ff  J..... .........
> > > > .  0010:  ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00  ................
> > > >
> > > > 0 0 0x9a98 [0x20]: PERF_RECORD_CPU_MAP
> > > >
> > > > Finally, with the range encoding it is:
> > > > 0x9ab8@pipe [0x10]: event: 74
> > > > .
> > > > . ... raw event: size 16 bytes
> > > > .  0000:  4a 00 00 00 00 00 10 00 02 00 00 00 00 00 47 00  J.............G.
> > > >
> > > > 0 0 0x9ab8 [0x10]: PERF_RECORD_CPU_MAP
> > > >
> > > > v2. Fixes a bug in the size computation of the update header
> > > >     introduced by the last patch (Add range data encoding) and caught
> > > >     by address sanitizer.
> > > >
> > > > Ian Rogers (6):
> > > >   perf cpumap: Const map for max
> > > >   perf cpumap: Synthetic events and const/static
> > > >   perf cpumap: Compute mask size in constant time
> > > >   perf cpumap: Fix alignment for masks in event encoding
> > > >   perf events: Prefer union over variable length array
> > > >   perf cpumap: Add range data encoding
> > >
> > > Ping. There was some feedback on this change but nothing to create a
> > > v3. Feedback/acked-by/reviewed-by appreciated.
> >
> > Ping. Feedback appreciated.
>
> hi,
> there's some unanswered feedback:
> https://lore.kernel.org/linux-perf-users/YrwY3SP+jsTwrRBw@krava/
>
> jirka

Thanks Jirka,

Was there a comment in particular? My reply was here:
https://lore.kernel.org/linux-perf-users/CAP-5=fU=BpP4OT2axZLSfRnKxQxmv-HXj8khBgmx3XQMS+abgA@mail.gmail.com/
I double checked, everyone of your comments was answered.

Thanks,
Ian
