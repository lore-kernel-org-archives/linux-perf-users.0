Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC6C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 02:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhKVCVV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 21 Nov 2021 21:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVCVV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 21 Nov 2021 21:21:21 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75120C061574
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Nov 2021 18:18:15 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id s14so16503628ilv.10
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Nov 2021 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMg4YelF9NtpuAtgtsunbHIlm0HrTucjyQfOk7YTGtA=;
        b=ZI/9SwiNY63woXtiqxrDSV7YIiTKaZgmgJdDJpjHhAmRPnWjVAt/MCnv34pBUfTBKS
         aFVzTsLGtQtonzX2hkvoZvuyZ/1oIunhH4i//qWIlbIBoclmNhKl4AUUWRRbKobaNvaH
         A09Dz9mF1y/eDwNATGChxsk48IhTldsyq7OjIeLBzYVGkZJD/oskF/9lBxS9FFSy5qWE
         XKcw39ksNq+lxQ+XhMeY+W2siMQ4FCBOnoEsEkmvLttQexMJ0Jps/ARs/HD/szNagcsk
         HkBQnRp5cxWCpX0VMK7/WkTRpowQ9ORFEk/q45Ic4jU1JNDDxlB9d/PqfGQ/Uh4KTS/h
         3WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMg4YelF9NtpuAtgtsunbHIlm0HrTucjyQfOk7YTGtA=;
        b=OE529LNg427drXem0tNOq+5Lh2eWPbF61MBC4PH2g9N7wvcVuquyhM1cfkx8Knq12I
         J+opnhCAgRLlT9dcvPKTW4lwnnHnCWOXsuzJvde6d9bN8xnG8Ejndz3M6ii8Bn4yHQBT
         mu65U4ghxmRVxdwOAZKMHvbNSQvM6447hBgro3O46jSy8sILuZT7dr2s3vmykRjYMpp1
         qOU0szEXioJB7/sYE2zhsHu0R0Xis1desPovE50/P+L4kSnyVvUpsdQF13JyP02CDPi4
         5lmREtg5wj1DNd4ao+BpDvGopDvq4eDO8IDy1YlHAprNoR9Uzo6TSzZTDJ72sY/ez1Ov
         Zmjg==
X-Gm-Message-State: AOAM530J/9iwgIgvzIJ0SlioPnrIEMEFkrqo6W85/QxVpxiWwYgKR1Fv
        tFivt/18J9zfr1o7LReAeqCdxmckufmAVGv8OK9NSmFTuQKA6w==
X-Google-Smtp-Source: ABdhPJzYm+GCWhd0rYTRQMheM6DA4Mtgj1MLAaenlVvwbXWh0UmXrnF+94r0PIm/Eos5Of5wu8hXfXuZg3u2wuu4qT4=
X-Received: by 2002:a05:6e02:1048:: with SMTP id p8mr16242257ilj.174.1637547494012;
 Sun, 21 Nov 2021 18:18:14 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org>
In-Reply-To: <YY58idSor+lJ84KF@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 21 Nov 2021 18:18:02 -0800
Message-ID: <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
To:     debian-kernel@lists.debian.org, waldi@debian.org
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ben@decadent.org.uk, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I'd love to package Linux perf as per Arnaldo's prepared tarball for
Debian. If I could get help on the Debian side it would be great! The
actions that are needed are:

1) package Arnaldo's tarball for Debian, presumably the build in the
sources for linux-perf-5.10 will be a good starting point. The package
will be linux-perf and replace the current metapackage of the same
name.

2) create an updated linux-base that removes /usr/bin/perf

3) upload the updated linux-base and linux-perf packages for
maintainer approval to https://mentors.debian.net/

4) some how get the previous Debian linux-perf-[45].* packages removed

After this, when Arnaldo sends out a new tarball we can update the
linux-perf package. libbpf and libtraceevent are currently part of
linux/tools, but it would be better to depend on the distribution
versions, which can be a future update to the packaging.

I'd love some feedback on this plan, whether linux-base/linux-perf
have a special process, etc. Documentation wise I've seen there is a
lot, but:
https://mentors.debian.net/intro-maintainers/
looks fairly to the point.

Thanks,
Ian



On Fri, Nov 12, 2021 at 6:39 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 11, 2021 at 10:34:33PM -0800, Ian Rogers escreveu:
> > Hi,
>
> > Debian currently tries to match the Linux perf tool to the version of
> > the kernel that it is being run upon. Reaching out to Ben Hutchings,
> > he explained to me that this was done back in 2010 due to kernel and
> > Linux perf incompatibilities. This was likely the case, but it was a
> > bug in the Linux perf tool that should have been fixed. It is the goal
> > of the tool to be backward compatible. A problem with matching the
> > tool to the kernel version is that users miss out on new features and
> > fixes (this topic came up in a recent interview of the maintainer
> > Arnaldo Carvalho de Melo [1]).
>
> > Ben Hutchings informs me that making it so that Debian ships the
> > latest Linux perf tool requires updates both to the linux-base and
> > linux source packages. The Linux perf tool also has many other often
> > optional dependencies, like libunwind, libbpf, libpfm4, libtraceevent,
> > etc. In general, having the dependency will unlock more features.
> > Linux tools has its own copies of libbpf and libtraceevent, and so
> > these may pose some versioning issues.
>
> We can use LIBBPF_DYNAMIC=1 to use the distro libbpf-dev package, which
> currently is going thru some growing pains as libbpf is 0.x, with
> several APIs being deprecated, others renamed, and that has been a
> source of friction, but should be past us with v1.0. Till then the perf
> codebase is being adjusted to allow it to be seamlessly built with the
> in-kernel version and with whatever libbpf-devel the distro has.
>
> > I think it'd be great to get Debian shipping the latest version of
> > Linux perf for its users. Hopefully we can agree to change how Debian
> > packages perf currently and then work out the best way to package and
> > keep it up-to-date. I look forward to everyone's help and input.
>
> I also keep the tarballs available at:
>
> https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/
>
> Where there are instructions on how to build this detached tarball.
>
> I regularly build perf on lots of distros, including:
>
>   debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>   debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
>   debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
>   debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , Debian clang version 11.1.0-4
>   debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
>   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
>   debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
>   debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
>
> Ditto for ubuntu.
>
> A complete list can be found in each pull request I send to Linus, see
> in the last one:
>
>   https://lore.kernel.org/all/20211107204947.1394255-1-acme@kernel.org/
>
> Search for BUILD_TARBALL.
>
> There is also the output for 'make -C tools/perf build-test' that tests
> building with lots of combinations of optional libraries, for instance,
> with LIBBPF_DYNAMIC=1, etc.
>
> - Arnaldo
