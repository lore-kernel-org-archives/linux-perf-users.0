Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B3C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 16:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhKVRAq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhKVRAq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 12:00:46 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4DC061574
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 08:57:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id v23so24246200iom.12
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3cQWhZ3KyxeZC2Aw1s8GfD4ZqZAUTGK2A3iroi1T+M=;
        b=mu4megNr6rhKbZ7kOBeyZi7UyP1Dwg/LMpeE+ZVmPGBDeFBoZ6Mb8yTiwJxvgfwJrQ
         +X5zV09jo5MC2W3j/uSGpmFf5Yu8iSjaxJKXe8p3KmKQlki8lkYOTvXeBZSm893FqORk
         9LdlaulcS7hqYJOxRMIaaa8knvq6DF0slIQ8L3EpPGwJ4z5EGigIHoKIDJVv5lZIZQSh
         uV2eaZ0gmn0bKmcYIoNa2gtug/vNKTWg5/rCYuIOB1BO5RNw4qWvJFX3MMgf73stlioS
         vhW24r893LQBi5xkhh7P6ngv0BiBC7RH+LUvGJRI4xIISbylRows4Z9TNWVLDTIX/S0a
         pBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3cQWhZ3KyxeZC2Aw1s8GfD4ZqZAUTGK2A3iroi1T+M=;
        b=apqhcXGfpF90UZsRqK9kSvf2qdUlCLGDFaWhbAKjc9iG33z0Y3EhNtoyhQ+4YB+d4e
         36wX43KWdymn7uVDerRuG7oJkL0TJX3D8m/+JiKec6BecPkYh04CUDYzjDqalJbDDEAe
         cmgB0E458Qgb6e5cgwE6+zrBGBxGoub9UF8+wVMEj/8+WhpbXWN5vSTVQ0qjFXpscNOq
         hv528ia7wvvb3RCGlQZq0EujM3eJWT9EuUGa2HvXI6CQhwv9vCTLs3xHA2RY3hKzgMXq
         eXr2ce2MwStmjYmFou70yKOBw67kl0yS+/wzWNdh5P1tAccnmSmg4MquaWud2G0EeHh9
         qZag==
X-Gm-Message-State: AOAM531aq14hrB1IyzMvlsvb0HACQlyr5f8yB0FJpyEaQnB64MsXrnR7
        mGtxc8lZV+Rm4mz1dQadVeCBCjg4JWu5cAODEpSFZQ==
X-Google-Smtp-Source: ABdhPJy8yxWi225ktH+hyzT/iNtCtHDV90/iYjx8IaleaMT0b6W2R8BzazBGZmGed68fkVcSpy5ka/glK/Vn78YQVPY=
X-Received: by 2002:a6b:b886:: with SMTP id i128mr24607897iof.151.1637600258477;
 Mon, 22 Nov 2021 08:57:38 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org> <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
 <AM9PR10MB4869A06EB83A4AC6DCA955EE899F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM9PR10MB4869A06EB83A4AC6DCA955EE899F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 22 Nov 2021 08:57:26 -0800
Message-ID: <CAP-5=fW-L8YS7gsNAjRkzUtBOCw2md+YWuOCbjVZHd7r=PLH_g@mail.gmail.com>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
To:     "Moessbauer, Felix" <felix.moessbauer@siemens.com>
Cc:     "debian-kernel@lists.debian.org" <debian-kernel@lists.debian.org>,
        "waldi@debian.org" <waldi@debian.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 22, 2021 at 4:54 AM Moessbauer, Felix
<felix.moessbauer@siemens.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Monday, November 22, 2021 3:18 AM
> > To: debian-kernel@lists.debian.org; waldi@debian.org
> > Cc: linux-perf-users <linux-perf-users@vger.kernel.org>; Arnaldo Carvalho de
> > Melo <acme@kernel.org>; ben@decadent.org.uk; Jiri Olsa <jolsa@kernel.org>;
> > Namhyung Kim <namhyung@kernel.org>
> > Subject: Re: Getting the latest and greatest Linux perf features on every Debian
> > kernel
> >
> > Hi,
> >
> > I'd love to package Linux perf as per Arnaldo's prepared tarball for Debian. If I
> > could get help on the Debian side it would be great! The actions that are needed
> > are:
> >
> > 1) package Arnaldo's tarball for Debian, presumably the build in the sources for
> > linux-perf-5.10 will be a good starting point. The package will be linux-perf and
> > replace the current metapackage of the same name.
>
> The current packaging in Debian does not include the perf python bindings.
> Today these bindings are used by more and more tools (e.g. tuned).
> For that, we packaged both a versioned module (linux-perf-<...>) and a python wrapper to load it using 'import perf' (linux-base).
> These patches are currently under review at Debian salsa [1].
>
> All this would be way simpler if perf bindings do not have to be versioned anymore.
> But please also consider that still a lot of people are using 4.19er kernels (don't know since when versioning is no longer required).

Thanks Felix! Is there a specific bug I can look at which describes
what is broken with later versions of perf an 4.19? Perhaps we can add
a workaround for this age of kernel in the command. It is certainly
nobody's intent to have some users without a workable tool. Fwiw, I do
a lot of testing with an older 4.15 based kernel and I'm not aware of
issues.

> [1] https://salsa.debian.org/kernel-team/linux/-/merge_requests/425
>
> >
> > 2) create an updated linux-base that removes /usr/bin/perf
> >
> > 3) upload the updated linux-base and linux-perf packages for maintainer
> > approval to
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmentors.
> > debian.net%2F&amp;data=04%7C01%7Cfelix.moessbauer%40siemens.com%7C
> > 4dbf17b41e4542b4c2de08d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d5
> > 5a%7C1%7C0%7C637731443001828013%7CUnknown%7CTWFpbGZsb3d8eyJWI
> > joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> > 0&amp;sdata=80jfnANxTuGYzw0vErMUQOlpdUWFrDNP5n9ktaVTBaQ%3D&amp
> > ;reserved=0
> >
> > 4) some how get the previous Debian linux-perf-[45].* packages removed
>
> This can easily be achieved using the Conflicts field with a linux-base version that is older than your patched one.

Can I use Conflicts to say that the linux-perf package, that will
provide /usr/bin/perf, will conflict with earlier linux-base releases?
I'm concerned that if linux-base conflicts with linux-perf and
linux-perf conflicts with linux-base, it is quite easy to make
something that becomes wedged :-)

> >
> > After this, when Arnaldo sends out a new tarball we can update the linux-perf
> > package. libbpf and libtraceevent are currently part of linux/tools, but it would
> > be better to depend on the distribution versions, which can be a future update to
> > the packaging.
> >
> > I'd love some feedback on this plan, whether linux-base/linux-perf have a special
> > process, etc. Documentation wise I've seen there is a lot, but:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmentors.
> > debian.net%2Fintro-
> > maintainers%2F&amp;data=04%7C01%7Cfelix.moessbauer%40siemens.com%7
> > C4dbf17b41e4542b4c2de08d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d
> > 55a%7C1%7C0%7C637731443001828013%7CUnknown%7CTWFpbGZsb3d8eyJ
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> > 3000&amp;sdata=Y0L%2Bn%2B0yJqGVnp%2FhCfBVD9V3bZ%2Bffb48vy85jg92M
> > oU%3D&amp;reserved=0
> > looks fairly to the point.
>
> I really like the plan and I'm also willing to support here.
> But please also note that I'm not a Debian sponsor or maintainer of the mentioned packages.

Thanks!
Ian

> Felix
>
> >
> > Thanks,
> > Ian
> >
> >
> >
> > On Fri, Nov 12, 2021 at 6:39 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > wrote:
> > >
> > > Em Thu, Nov 11, 2021 at 10:34:33PM -0800, Ian Rogers escreveu:
> > > > Hi,
> > >
> > > > Debian currently tries to match the Linux perf tool to the version
> > > > of the kernel that it is being run upon. Reaching out to Ben
> > > > Hutchings, he explained to me that this was done back in 2010 due to
> > > > kernel and Linux perf incompatibilities. This was likely the case,
> > > > but it was a bug in the Linux perf tool that should have been fixed.
> > > > It is the goal of the tool to be backward compatible. A problem with
> > > > matching the tool to the kernel version is that users miss out on
> > > > new features and fixes (this topic came up in a recent interview of
> > > > the maintainer Arnaldo Carvalho de Melo [1]).
> > >
> > > > Ben Hutchings informs me that making it so that Debian ships the
> > > > latest Linux perf tool requires updates both to the linux-base and
> > > > linux source packages. The Linux perf tool also has many other often
> > > > optional dependencies, like libunwind, libbpf, libpfm4,
> > > > libtraceevent, etc. In general, having the dependency will unlock more
> > features.
> > > > Linux tools has its own copies of libbpf and libtraceevent, and so
> > > > these may pose some versioning issues.
> > >
> > > We can use LIBBPF_DYNAMIC=1 to use the distro libbpf-dev package,
> > > which currently is going thru some growing pains as libbpf is 0.x,
> > > with several APIs being deprecated, others renamed, and that has been
> > > a source of friction, but should be past us with v1.0. Till then the
> > > perf codebase is being adjusted to allow it to be seamlessly built
> > > with the in-kernel version and with whatever libbpf-devel the distro has.
> > >
> > > > I think it'd be great to get Debian shipping the latest version of
> > > > Linux perf for its users. Hopefully we can agree to change how
> > > > Debian packages perf currently and then work out the best way to
> > > > package and keep it up-to-date. I look forward to everyone's help and input.
> > >
> > > I also keep the tarballs available at:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fmirr
> > >
> > ors.edge.kernel.org%2Fpub%2Flinux%2Fkernel%2Ftools%2Fperf%2F&amp;data=
> > >
> > 04%7C01%7Cfelix.moessbauer%40siemens.com%7C4dbf17b41e4542b4c2de08d
> > 9ad5
> > >
> > e58c3%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637731443001
> > 828013%
> > >
> > 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > I6Ik
> > >
> > 1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=A2TTg%2BElfRv9bslXw6YmEA1
> > R8Iu08Z
> > > hFyv6juVhRj24%3D&amp;reserved=0
> > >
> > > Where there are instructions on how to build this detached tarball.
> > >
> > > I regularly build perf on lots of distros, including:
> > >
> > >   debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 ,
> > clang version 3.8.1-24 (tags/RELEASE_381/final)
> > >   debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-
> > 8+deb10u2 (tags/RELEASE_701/final)
> > >   debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian
> > clang version 11.0.1-2
> > >   debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , Debian clang
> > version 11.1.0-4
> > >   debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9)
> > 11.2.0
> > >   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6)
> > 10.2.1 20210110
> > >   debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian
> > 10.2.1-6) 10.2.1 20210110
> > >   debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9)
> > 11.2.0
> > >
> > > Ditto for ubuntu.
> > >
> > > A complete list can be found in each pull request I send to Linus, see
> > > in the last one:
> > >
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fall%2F20211107204947.1394255-1-
> > acme%40kernel.org%2F&amp;
> > >
> > data=04%7C01%7Cfelix.moessbauer%40siemens.com%7C4dbf17b41e4542b4c2
> > de08
> > >
> > d9ad5e58c3%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6377314
> > 4300182
> > >
> > 8013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> > iLCJBT
> > >
> > iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=foKAv3e5lm5du1yoLqhzIVf
> > vfc7
> > > RkZqRAxmfTFkID9U%3D&amp;reserved=0
> > >
> > > Search for BUILD_TARBALL.
> > >
> > > There is also the output for 'make -C tools/perf build-test' that
> > > tests building with lots of combinations of optional libraries, for
> > > instance, with LIBBPF_DYNAMIC=1, etc.
> > >
> > > - Arnaldo
