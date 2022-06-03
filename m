Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345D6C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 09:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbiFCJcj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFCJci (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 05:32:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3D2B24E
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 02:32:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x17so9657774wrg.6
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oRAl4dbUfnsiRPLTOS5yGfa0W/muzE/YjY+y0YZxE+Q=;
        b=VZZo5R+1WTZDQEVFN7gS7qZof7sbX7M9Cxkt0hZtijG2cdutDgEZRnOSOOLfRRAkrj
         R/7m4qRMncLN+XC6xjnJnf4dXoGgX5I9Zv7H5PMKI8lPra/aYM15kOcanheJZSIX8I4G
         wIFqaH3aDCcnUOLliaawDzz/PFIhFXo48uapmh9HDcQb/TnHpyPaNO0IO4xg97xt2hiK
         pfHHPi6P8r6h/BtGwa8RbwITDxIsy8q9CnFbEF2q1DAUoQ8clpHkmaEdcp6WPWZ/Lp9c
         fBgY5knVo0Y/d2ebLRvE32AlD2r751pwVA7FiGn2UqsTpF5ZfFePX+F/zIyoTI9TW/Hj
         lHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oRAl4dbUfnsiRPLTOS5yGfa0W/muzE/YjY+y0YZxE+Q=;
        b=pmi1RwG5DyfGBMTdB+0os70W9jfIC6fHpdwN2qw30HkaK9/MqARD3Au5HrTni6S2Qb
         9COq2z0712s1B/Luzp/aqLnbLn4Y/A9p6TnyxZWnURnPaNSEQoF57MFZ2ssSKx+oDm4y
         G8JxkEOJBGqqlt6NgoVLnZCoYKAdpeJrUcptt9vPMv58q+y9kdE3uldCmu+f9vKURx4a
         N9lUaXfC3UU0tue239du/h/c+E1afgpJBhWSACaAnHeWlom3DVQjvrpeiKIdUtV6gQYy
         Z8L9EmA+UGr/K39Fd740Ikj/hJFQZKq+TxrQRTACXOBBpVstYA9GF6BFP1veeRX6MxWd
         nP0A==
X-Gm-Message-State: AOAM530we4od6Dgj0KpCJu9J/KZURy3v6vjQeFko9VYdfT1PHGfc4eCW
        XIVBxz8K3iuvkdlPIQZ6QrI=
X-Google-Smtp-Source: ABdhPJxeiSwV90HV9RfIoJT+xmaBq14fVOMnpxGKzgvrnz/ZLC4OtJe6kmPzNdEc9jDc2dPfg4GXMw==
X-Received: by 2002:a05:6000:1887:b0:20f:e155:9db4 with SMTP id a7-20020a056000188700b0020fe1559db4mr7089389wri.243.1654248754702;
        Fri, 03 Jun 2022 02:32:34 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id b18-20020adfde12000000b0020d0f111241sm6836596wrm.24.2022.06.03.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:32:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 3 Jun 2022 11:32:31 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: a few libperf questions
Message-ID: <YpnVL3ClGTDMxk2K@krava>
References: <5842751-f5a2-4469-53f2-57ef1362568@maine.edu>
 <CAP-5=fVeDJJ_HD=AeK0XSpsY52H58ZynRnnEpOB-z478=NxaiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVeDJJ_HD=AeK0XSpsY52H58ZynRnnEpOB-z478=NxaiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 02, 2022 at 09:25:46AM -0700, Ian Rogers wrote:
> On Thu, Jun 2, 2022 at 8:38 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
> >
> > Hello
> >
> > I work on various perf-related tools in the HPC community, most notably
> > the PAPI performance library.
> >
> > Currently PAPI maintains its own independent code for working with
> > perf_event_open(), but with the advent of libperf I was looking into maybe
> > linking against libperf to avoid all the code/work duplication.  So I had
> > a few questions.
> >
> >         1. What's the licensing of libperf?  Is it GPLv2?
> >
> >                 PAPI is BSD licensed.
> >                 This is something that actually pushes us to libperf
> >                 because if I wanted to (for example) implement the new
> >                 ARM rdpmc code I can't just copy it in to PAPI but
> >                 would have to re-implement from scratch
> 
> I believe that as code in libperf was copied from perf it retains the
> GPL-2.0-only license. Some new code is "LGPL-2.1 OR BSD-2-Clause",
> which makes more sense and would align libperf with libbpf. We've
> talked about rewriting this code in Rust, perhaps when that is done
> the more permissive license could be used.

yep, all the libperf code was copied from perf, so should have the
same license

> 
> >         2. Is it expected that distributions will start shipping
> >                 libperf?  As part of perf or otherwise?
> >
> >                 Telling HPC users they need to dowload an entire
> >                 kernel tree just to build libperf is seen as a huge
> >                 obstacle for many, and just including a snapshot
> >                 of the code into our code tree again starts having
> >                 licensing issues.
> 
> There is a Makefile and an install step, however, I would say libperf
> is *not* ready to be distributed. There was a lot of cleanup effort to
> make libbpf 1.0 and similar should happen to libperf. I particularly

it's currently packaged as sub package of kernel-tools in fedora:

	[jolsa@krava ~]$ rpm -qi libperf
	Name        : libperf
	Version     : 5.17.11
	Release     : 200.fc35
	Architecture: x86_64
	Install Date: Mon 30 May 2022 09:30:12 AM CEST
	Group       : Unspecified
	Size        : 109230
	License     : GPLv2
	Signature   : RSA/SHA256, Wed 25 May 2022 10:46:33 PM CEST, Key ID db4639719867c58f
	Source RPM  : kernel-tools-5.17.11-200.fc35.src.rpm
	Build Date  : Wed 25 May 2022 10:15:25 PM CEST
	Build Host  : bkernel01.iad2.fedoraproject.org
	Packager    : Fedora Project
	Vendor      : Fedora Project
	URL         : http://www.kernel.org/
	Bug URL     : https://bugz.fedoraproject.org/kernel-tools
	Summary     : The perf library from kernel source
	Description :
	This package contains the kernel source perf library.

not sure about other distros

> loathe perf_cpu_map__empty, which isn't doing what it says on the tin.

nice, that one should be easy to fix ;-)

jirka

> 
> >         3. Is libperf planned to be backwards compatible with old kernels,
> >                 or will it be tied to whatever kernel it is shipped with?
> >                 Will it have ABI-stable releases?
> >
> >                 Sort of like with perf, I know only supporting the most
> >                 recent kernel makes life easier for the kernel developers
> >                 but it does make for a library versioning nightmare
> >                 especially if trying to support people on older
> >                 distro releases.
> 
> There is a myth that comes from Debian that perf only supports the
> running kernel. This is wrong and means that bug fixes, improvements,
> etc. are missed out on. This thread discusses it:
> https://lore.kernel.org/linux-perf-users/CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com/
> It would be hugely impactful if someone could fix this, as a lot of
> other distributions follow Debian.
> 
> Given perf doesn't have this problem and it is using libperf, I don't
> think libperf has the problem.

yes, same rules as for perf.. it should be backward compatible

jirka

> 
> > I'm going to try to see if I can get a libperf backend for PAPI going and
> > maybe try to get some of the other HPC parties involved (they tend to not
> > want to deal with kernel development directly for some reason) but I'm not
> > sure if they're going to like how closely bound libperf is to
> > the kernel tree.
> 
> Sounds good. The code is in the kernel tree but I'm not sure it is
> "bound" to it.
> 
> Thanks,
> Ian
> 
> > Vince Weaver
> > vincent.weaver@maine.edu
