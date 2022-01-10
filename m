Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B3C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jan 2022 18:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiAJSou (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbiAJSor (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jan 2022 13:44:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E419C061748
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jan 2022 10:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26642B81757
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jan 2022 18:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90F4C36AF8;
        Mon, 10 Jan 2022 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641840284;
        bh=DERkIBVWHvuaGnWFlbiZirWhUW+Q4EWhlsJI5Rte6sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cm12xWneUMYK2bmgxpYRavG8OXcvbg07+RfTUDTHgF9/E9G7Ctu+JtjnU04Pn0RMZ
         DtjbqtYh2lyXTKK07a6clzB2Mbs3AOiIb0ukdHFvHj43bEF5y2ztgT4//bgsnzf+ab
         og7N24Ljn5w31TNiY2/SMdwrSP3JVReX0sRyTap8jVKodUO+KUj589SPUW+V/+uvsr
         bCuuVjMx/puBufnkO6YYeAd8lHF3L9A+OqMSf1uOBW+z6pmbeAZmVagj+27U5OJxDk
         ZOAuc3yBCxBQP52Cb1xRAy8HMi7cofmEpIY00xRi+59b8aE7N2JcwjJw/emyn0UrD9
         JBb68vRyHLykw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7186C40B92; Mon, 10 Jan 2022 15:44:42 -0300 (-03)
Date:   Mon, 10 Jan 2022 15:44:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Ian Rogers <irogers@google.com>, debian-kernel@lists.debian.org,
        waldi@debian.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
Message-ID: <Ydx+mtl1c7L/bbGJ@kernel.org>
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org>
 <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
 <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jan 10, 2022 at 12:54:31AM +0100, Ben Hutchings escreveu:
> On Sun, 2021-11-21 at 18:18 -0800, Ian Rogers wrote:
> > Hi,
> > 
> > I'd love to package Linux perf as per Arnaldo's prepared tarball for
> > Debian. If I could get help on the Debian side it would be great! The
> > actions that are needed are:
> > 
> > 1) package Arnaldo's tarball for Debian, presumably the build in the
> > sources for linux-perf-5.10 will be a good starting point. The package
> > will be linux-perf and replace the current metapackage of the same
> > name.
> 
> I don't think this buys us anything over building from the kernel tree
> (i.e. the linux source package), but will wait to see what Arnaldo
> says.

Building perf from the kernel sources is fine, but usually the kernel
packaging takes more time to be completed, more tests, etc and if
someone wants to move the perf tools side of things faster, then using
the tarball may be an option.

Another workflow using the tarball allows is to have different packagers
for the kernel and for the perf tools.

But either way is fine, its just a way to allow more ways to package
perf, to try the latest (or an older one) on an arbitrary kernel or
system with different versions of the libraries it links to.

- Arnaldo
 
> > 2) create an updated linux-base that removes /usr/bin/perf
> > 
> > 3) upload the updated linux-base and linux-perf packages for
> > maintainer approval to https://mentors.debian.net/
> 
> linux-base is maintained by the kernel team on salsa.debian.org, where
> you can send merge requests.  If linux-perf is to be a separate source
> package, I think it should be maintained in the same way.
> 
> > 4) some how get the previous Debian linux-perf-[45].* packages removed
> [...]
> 
> They will be removed from the Debian archive through a periodic
> cleanup.
> 
> Ben.
> 
> -- 
> Ben Hutchings
> I say we take off; nuke the site from orbit.
> It's the only way to be sure.
