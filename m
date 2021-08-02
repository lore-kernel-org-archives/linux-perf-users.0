Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A17C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B7F610FB
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhHBPoW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhHBPoV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 11:44:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1340AC061760
        for <linux-perf-users@vger.kernel.org>; Mon,  2 Aug 2021 08:44:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k4so10683095wms.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Aug 2021 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAWuQ/JvoX+qW03VDGPJ9Ofp3oF3NSH0evX+ItLfT0M=;
        b=OY1dHlSBGhnSjUiSRde6FOpi/D/J7vDN3qiynTmUlf6bnERXdwDmKC+7PzgqdLk2VQ
         6k3GrRyW36WgMN0o5BCwydoFGH4LJ3/Td+yTEL2V0YgpV6njdbtogAPjJdjk3Zbc5vED
         uxDQrZlBUxtd99jT+x1vQWolvyWpM4AFa8GYKJBYNk9U6K9uhIivv3UR8tFoz+b2YCyd
         3+K4ynU4wb5PxA9Sg88UzIdL+uzuohxlpQG0/uGCx/97aBGwwyM9AMyl7xf+OhyBmuOK
         qWl1yv2dQPqzDtWlA5msz53nVoSicHeDAYeGDn/2tdS/3UYQQB+gKVYy19uWXoVYrYMX
         vYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAWuQ/JvoX+qW03VDGPJ9Ofp3oF3NSH0evX+ItLfT0M=;
        b=do5xeDPbIJGZulWwRLn7si+zbYXsmd3gE86MRvufANI372ju253rBCAmg8uFlS11ID
         k0L3P7/6P5fW5pAthC1wtPLRo7xmxJuVxt16zmCtfT9POJtiHZDBXvfyOD74YLIbxBar
         wD2RVXPfFFvmG/n1hAMsxtJeNLpCMVFXXPE/z3FLvHHFftLTCONe9h1UuTmuYsY9+bWt
         xjAU1jirriz0ww1HqH6C2OQa/hcj/OSGr2ReNlrQlIyc+3523xsW3R8aPJg5Cu0OdjNg
         uA1tFmz4vNX5VT4DaM90S3wqr39S4TjZqrenN3J3P4CEt5pEJYN6HElBD3GXsDFL5++m
         pt7A==
X-Gm-Message-State: AOAM5312DuJ2bUaBZX4Ffjz0LNuTL/tnYpqEbOIoo4hLHeAVSSEJngsz
        EFdmGe+hg79uJyPb0u8V4nLLjlWDUQ1omDJWPGOwew==
X-Google-Smtp-Source: ABdhPJwQk3PjsXlhmERVCZwrj08dYks7ZMB1H5WlB2pmNXlDk+r6SlCK3idLXagGaVe4isrMvVOoC3dYiM8MzdRPtiM=
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr49605wmh.0.1627919050360;
 Mon, 02 Aug 2021 08:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com> <20210721090706.21523-3-james.clark@arm.com>
 <CAJ9a7Viap53OgrM2e_DU4+oymFB41jspbKbvEVFQWROt7ifuXw@mail.gmail.com>
 <20210731060312.GB7437@leoy-ThinkPad-X240s> <CAJ9a7VhdLaP3rkXwscAQpVe+jSgcx02WjY=RmiBkaCB6ObGTjQ@mail.gmail.com>
 <20210802150358.GA148327@leoy-ThinkPad-X240s>
In-Reply-To: <20210802150358.GA148327@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 2 Aug 2021 16:43:59 +0100
Message-ID: <CAJ9a7VhBU4QYWYbzJs2Z91k=NC+xYnmKJ-HH9CKiNdpDxsY1SA@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf cs-etm: Initialise architecture based on TRCIDR1
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On Mon, 2 Aug 2021 at 16:04, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Mon, Aug 02, 2021 at 03:04:14PM +0100, Mike Leach wrote:
>
> [...]
>
> > > > > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > > > > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > > > > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> > > > > +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> > > > > +{
> > > > > +       /*
> > > > > +        * If the ETM trace minor version is 4 or more then we can assume
> > > > > +        * the architecture is ARCH_AA64 rather than just V8
> > > > > +        */
> > > > > +       return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
> > > > > +}
> > > >
> > > > This is true for ETM4.x & ETE 1.x (arch 5.x) but not ETM 3.x
> > > > Probably need to beef up this comment or the function name to emphasise this.
> > >
> > > Yeah, I think it's good to change the function name.  Eventually, this
> > > function should only be used for ETM4.x and ETE.
> > >
> > > Another minor comment is: can we refine the arch version number, e.g.
> > > change the OpenCSD's macro "ARCH_AA64" to "ARCH_V8R4", (or
> > > "ARCH_V8R3_AA64"), this can give more clear clue what's the ETM version.
> > >
> >
> > The purpose of these macros is to inform the decoder of the
> > architecture of the PE - not the version of the ETM.
> >
> > These OpenCSD macros are defined by the library headers
> > (ocsd_if_types.h) and not the perf headers.
> > These have been published as the API / ABI for OpenCSD and as such
> > changing them affects all OpenCSD clients, not just perf.
>
> I understand these macros are defined in OpenCSD lib as APIs, since I
> saw these macros have not been widely used in perf tool (e.g.
> ARCH_AA64), so this is why I think it's good to take chance to refine
> the naming conventions.
>

The macros are used in other tools - so changing now affects those
too. Not something I am prepared to do without good reason.

> > This PE architecture version is used along with the core profile to
> > determine which instructions are valid waypoint instructions to
> > associate with atom elements when walking the program image during
> > trace decode.
> >
> > From v8.3  onwards we moved away from filtering on specific
> > architecture versions. This was due to two factors:-
> > 1. The architectural rules now allow architectural features for one
> > increment e.g. Arch 8.4, to be backported into  the previous increment
> > - e,g, 8.3, which made this filtering more difficult to track.
> > 2. After discussion with the PE architects it was clear that
> > instructions in a later architect version would not re-use older
> > opcodes from a previous one and  be nop / invalid in the earlier
> > architectures. (certainly in the scope of AA64). Therefore
> > the policy in the decoder is to check for all the instructions we know
> > about for the latest version of architecture, even if we could be
> > decoding an earlier architecture version. This means we may check for
> > a few more opcodes than necessary for earlier version of the
> > architecture, but the overall decode is more robust and easier to
> > maintain.
> >
> > Therefore for any AA64 core beyond v8.3 - it is safe to use the
> > ARCH_AA64 PE architecture version and the decoder will handle it.
>
> I have no objection for current approach; but two things can cause
> confusions and it might be difficult for maintenance:
>
> - The first thing is now we base on the bit fields TRCIDR1::TRCARCHMIN
>   to decide the PE architecture version.  In the ETMv4 spec,
>   TRCIDR1::TRCARCHMIN is defined as the trace unit minor version,
>   so essentially it's a minor version number for tracer (ETM) but not
>   the PE architecture number.  But now we are using it to decide the
>   PE architecture number (8.3, 8.4, etc...).
>

This is a slight weakness in the implementation of perf. Ideally one
does need to establish the architecture version of the PE - but perf
/cs-etm is using an assumption regarding the profile and version of
the core, according to the ETM / ETE versiom.
That said - the ETM / ETE version numbers do have a strong
relationship with PE architecture version numbers, so this assumption
holds for the current supported devices.

> - The second thing is the macros' naming convention.
>   E.g. "AA64" gives me an impression it is a general naming "Arm Arch 64"
>   for all Arm 64-bit CPUs, it's something like an abbreviation for
>   "aarch64"; so seems to me it doesn't show any meaningful info for PE's
>   architecture version number.  This is why I proposed to use more
>   explict macro definition for architectures (e.g. ARCH_V8R3, ARCH_V8R4,
>   ARCH_V9R0, etc).
>

For modern cores it is sufficient for the decoder to know the profile
and that it is aarch 64 - so yes the macro is simply saying this a
general AA64 core.
The macros for earlier versions are a little more specific as certain
filtering is used according to the version of the PE.

ARCH_V8R4,  ARCH_V9R0 etc would have no significance to the decoder
and would not be useful. If we get to the stage where we need more
specific PE architecture versions - then these can be added as
required.
Using the ARCH_AA64 macro means that we do not have to update the API
for every version update of the architecture, and there are no changes
required to the perf / cs-etm handling.

> If we really want to use ARCH_AA64, it's better to give some comments in
> the code.
>

There are comments in the OpenCSD headers, though additional ones in
the perf  / cs-etm handling soruce code could be added.

Regards

Mike


> Thanks a lot for shared the background info.
>
> Leo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
