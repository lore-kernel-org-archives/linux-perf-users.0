Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94707C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 21:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AB960720
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 21:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGWUW4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGWUW4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 16:22:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECAEC061757
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jul 2021 14:03:29 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s5so2733865ild.8
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jul 2021 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4YpTcp3h+RgxTPRET9ugOvi0BQtHn/1JEwwqbGkE/U=;
        b=McPl8puxnnTzPUlKiCepnHDluFGdGfpsoJG9x9z+8k0jttFilOAFD/NzvxAniBB4Vn
         BOrG/jORLwFSuHSl5mbW+4i0QugLS+Q2uXgv1qUy33jHkPvE0CDpF2Jkqrmtdb3/wmL7
         LKWdW68pxiHZEL4zDHKDvWLSRjEHMHZOpSHSI8HSPlimI+lvY6iF2X+F6lI3vkQV+5dG
         jDPRGyDnBhEqBOBWTUtJQeHbbZfjv/YgnNdMekoAnUtB0ismdyj0qY843hGLe6TlPo1E
         qnw43GFu1ADCcOMO0X7afn6TGBuLoiMGMl65CN7JwvB7fTgFf86pFDeMwusxKw+rUWWG
         t24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4YpTcp3h+RgxTPRET9ugOvi0BQtHn/1JEwwqbGkE/U=;
        b=HLcqg+uJN5HvDMCLBKqrfTTcQyNt8syEJAh+z4zjp4fklrJhBNj5FWCJec4nG/Dgu6
         h5BqD8r4EWiwYqpnK/nKLuRiwDriCi87c4eMqp2pPrLCP0oKZNqdGDV5AjoMKoAEAKxN
         tor4lggY7utYufqudh0II7gmZVhbtV9OZRBwpbL+DUsjUo1nKlTQr+hO/URYplBqe+Ag
         pwSEbtsZHByv41vbhTPQscKAkJOsO/dqMaAyyHaUgKRqEaVbfiSOTCZ0DS/mVEkW6ByP
         /FziE2FArivhtBCphqNoXzz5kzciHPCAXgks3HnDOmGpVRkZiCSTyrSQkhKzWWzrwIWE
         MBvQ==
X-Gm-Message-State: AOAM5339CX7rbX/CD81k2SmPtRXy9EbpVpLKp0qK6sbfF1Rl/wqyploP
        IJ5ODczHVIZryqVjC+6R2IUiEvld75bYiNjON7xtxA==
X-Google-Smtp-Source: ABdhPJzioucCwSXORMWbzuA2mStjVTrtGgEk04mE58I9viVa45egooDKurLRScco2qFR1s/S8sckjQPdaXNN5LnJ0Vk=
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr4794985ilf.129.1627074208652;
 Fri, 23 Jul 2021 14:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com> <20210715013343.2286699-5-irogers@google.com>
 <YPsKLa0Qe5/as4Jh@kernel.org> <YPsQGZOXqoy7Tfe6@kernel.org> <YPsQ5En9N7xG1Cya@kernel.org>
In-Reply-To: <YPsQ5En9N7xG1Cya@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jul 2021 14:03:16 -0700
Message-ID: <CAP-5=fWUr91jLgD-BDYK08v0ELQtypFHDop7QW4uFOPscncCQw@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf doc: Add info pages to all target.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 23, 2021 at 11:56 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jul 23, 2021 at 03:53:14PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Jul 23, 2021 at 03:27:57PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Wed, Jul 14, 2021 at 06:33:40PM -0700, Ian Rogers escreveu:
> > > > Enabled to ensure that info pages build.
> > >
> > > How did you test this? I tried installing texinfo, that is where
> > > makeinfo belongs:
> > >
> > > =E2=AC=A2[acme@toolbox perf]$ rpm -qf /usr/bin/makeinfo
> > > texinfo-6.7-10.fc34.x86_64
> > > =E2=AC=A2[acme@toolbox perf]$ rpm -q texinfo
> > > texinfo-6.7-10.fc34.x86_64
> > > =E2=AC=A2[acme@toolbox perf]$
> > >
> > > And then:
> > >
> > > =E2=AC=A2[acme@toolbox perf]$ make -C tools/perf O=3D/tmp/build/perf =
install-doc
> > > make: Entering directory '/var/home/acme/git/perf/tools/perf'
> > >   BUILD:   Doing 'make -j24' parallel build
> > >   INSTALL Documentation-man
> > > make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> > > =E2=AC=A2[acme@toolbox perf]$
> >
> > Also:
>
> We get closer if we do:
>
> =E2=AC=A2[acme@toolbox perf]$ make -C tools/perf/Documentation/ install-i=
nfo
> make: Entering directory '/var/home/acme/git/perf/tools/perf/Documentatio=
n'
>   ASCIIDOC perf.xml
>   DB2TEXI  perf.texi
> /bin/sh: line 2: docbook2x-texi: command not found
> make: *** [Makefile:289: perf.texi] Error 127
> make: Leaving directory '/var/home/acme/git/perf/tools/perf/Documentation=
'
> =E2=AC=A2[acme@toolbox perf]$

Do you need to install docbook2x?

$ dpkg -S /usr/bin/docbook2x-texi
docbook2x: /usr/bin/docbook2x-texi

Thanks,
Ian

> - Arnaldo
