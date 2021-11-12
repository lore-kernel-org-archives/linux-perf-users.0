Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87592C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7012460F39
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhKLOl7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 09:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhKLOl6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 09:41:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E862B60D43;
        Fri, 12 Nov 2021 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636727948;
        bh=JAa7NCY+oENx/lVL6Gfrcsu2H0fqnD17kiSKndaVdUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjoS8WacygdhTFaVWTEurPrV0ZeuPmuntwYJPuLybD7m+gPHCPubBF/4toMnFddbO
         dVeMBMffjkGB4qKi4wQJ+fPu8z8FBCOjZlnmednrow8cwZIiHnJ09T/pgA8wsKMn7J
         0BwqdKiMkLPwBoOnx6RjcoN8qWzCF7VEf/H1cg7HJjAqxETm+s1zkH1tc+sxVEX0Yk
         ucEAgLQrtPxppAO9NN0Dxe3tD2eHRWSORc0lxd3WmrRGrUUmI+K3giQkFo0KoGDl1M
         O5YrR/XdvUiZcQ58wxl7zWWt32149QDNtSCn+mfoba0qftzg9257twEqV0xDdv/9Sf
         B0vRft4e4eBWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E264410A1; Fri, 12 Nov 2021 11:39:05 -0300 (-03)
Date:   Fri, 12 Nov 2021 11:39:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     debian-kernel@lists.debian.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        ben@decadent.org.uk, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
Message-ID: <YY58idSor+lJ84KF@kernel.org>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 11, 2021 at 10:34:33PM -0800, Ian Rogers escreveu:
> Hi,
 
> Debian currently tries to match the Linux perf tool to the version of
> the kernel that it is being run upon. Reaching out to Ben Hutchings,
> he explained to me that this was done back in 2010 due to kernel and
> Linux perf incompatibilities. This was likely the case, but it was a
> bug in the Linux perf tool that should have been fixed. It is the goal
> of the tool to be backward compatible. A problem with matching the
> tool to the kernel version is that users miss out on new features and
> fixes (this topic came up in a recent interview of the maintainer
> Arnaldo Carvalho de Melo [1]).
 
> Ben Hutchings informs me that making it so that Debian ships the
> latest Linux perf tool requires updates both to the linux-base and
> linux source packages. The Linux perf tool also has many other often
> optional dependencies, like libunwind, libbpf, libpfm4, libtraceevent,
> etc. In general, having the dependency will unlock more features.
> Linux tools has its own copies of libbpf and libtraceevent, and so
> these may pose some versioning issues.

We can use LIBBPF_DYNAMIC=1 to use the distro libbpf-dev package, which
currently is going thru some growing pains as libbpf is 0.x, with
several APIs being deprecated, others renamed, and that has been a
source of friction, but should be past us with v1.0. Till then the perf
codebase is being adjusted to allow it to be seamlessly built with the
in-kernel version and with whatever libbpf-devel the distro has.
 
> I think it'd be great to get Debian shipping the latest version of
> Linux perf for its users. Hopefully we can agree to change how Debian
> packages perf currently and then work out the best way to package and
> keep it up-to-date. I look forward to everyone's help and input.

I also keep the tarballs available at:

https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/

Where there are instructions on how to build this detached tarball.

I regularly build perf on lots of distros, including:

  debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , Debian clang version 11.1.0-4
  debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
  debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
  debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
  debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0

Ditto for ubuntu.

A complete list can be found in each pull request I send to Linus, see
in the last one:

  https://lore.kernel.org/all/20211107204947.1394255-1-acme@kernel.org/

Search for BUILD_TARBALL.

There is also the output for 'make -C tools/perf build-test' that tests
building with lots of combinations of optional libraries, for instance,
with LIBBPF_DYNAMIC=1, etc.

- Arnaldo
