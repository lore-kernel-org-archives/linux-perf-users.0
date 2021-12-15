Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF9DC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Dec 2021 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhLOO7j (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Dec 2021 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhLOO7i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Dec 2021 09:59:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC42C061574
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 06:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 272CDB81F94
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Dec 2021 14:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBDAC34605;
        Wed, 15 Dec 2021 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639580375;
        bh=NQpzckMtuzZ7CWbnQJsC2wjs4Gw/PmwUcVrZDSnjNMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cp1YSA4XmFYTBiEZNsFHAt2letSn0v9x7BIooXPB3sVObAwfeh2wyJkhyUvsrnKQB
         F2fmwwZv9B5aBJY48gB3IHEJbz+Td8vG88ffo0/1QRrYANa9I6fLfzAf+GYktrI3aW
         cZmg4JfhNlnJPDJMU4aWqFrerNnu7YMWiaW00cmgxHiyXGLjw5N04MCenboMiXw4S8
         PmL+O5xdOhtRDrBaMk9XHTtZMuFCkf9z4CIxh1gUT/N4d+/I6pYWmhfFB1UZ07nzur
         WELHf8Cxl8JH1K8+9OtobNILrkydYS/3eiyCSgW5Ex+7kBE5uag1Y57obQKAHZOX4U
         J505aLUFMjYKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E581405D8; Wed, 15 Dec 2021 11:59:34 -0300 (-03)
Date:   Wed, 15 Dec 2021 11:59:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: perf probe: adding probe on C++ member/namespace function or
 versioned symbols
Message-ID: <YboC1QIP342BBz5t@kernel.org>
References: <2119579.vFYbnVOWES@milian-workstation>
 <d2ddc34f-3825-4b95-e6d3-fd25604b6867@arm.com>
 <7294720.PQYz5cM6gx@milian-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7294720.PQYz5cM6gx@milian-workstation>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 15, 2021 at 02:10:33PM +0100, Milian Wolff escreveu:
> On Donnerstag, 9. Dezember 2021 11:47:52 CET James Clark wrote:
> > On 08/12/2021 20:08, Milian Wolff wrote:
> > > Hey there,
> > > 
> > > how can one escape function names for `perf probe`? It seems like the
> > > current parser is confused by the `:` which is common in C++ symbol
> > > names.
> > > 
> > > ```
> > > $ perf probe -F --exec /usr/lib/libQt5Widgets.so | grep syncBacking
> > > QWidgetPrivate::syncBackingStore
> > > QWidgetPrivate::syncBackingStore
> > 
> > It might not be obvious, but you have to get the mangled name with 'nm -D',
> > and then pass the mangled name with --no-demangle to perf and then it works:
> > 
> >   sudo ./perf probe --no-demangle --exec libQt5Widgets.so.5 --add
> > '_ZN14QWidgetPrivate16syncBackingStoreEv'
> > 
> > Maybe the docs could be updated to make it clearer, or print a warning
> > message, or get perf to output mangled symbols in addition to demangled
> > with -F.
> 
> Thank you, that indeed works. But it's _very_ unintuitive. Generally, I think 
> there are many languages out there which produce demangled names containing 
> colons - could we come up with a way to allow specifying a demangled symbol 
> including colons (and maybe even @@), that does not conflict with the existing 
> `:` for the line suffix? For C++ (and Rust?) at least, we could handle two 
> colons differently from just one. What do you think?

I agree, we need to lift this limitation.

- Arnaldo
 
> > > $ perf probe --exec /usr/lib/libQt5Widgets.so --add
> > > QWidgetPrivate::syncBackingStore
> > > Semantic error :There is non-digit char in line number.
> > > ...
> > > ```
> > > 
> > > Additionally, it is also not possible to pass a versioned symbol either:
> > > ```
> > > $ nm -aD /usr/lib/libQt5Widgets.so | grep syncBacking
> > > 0000000000197480 T
> > > _ZN14QWidgetPrivate16syncBackingStoreERK7QRegion@@Qt_5_PRIVATE_API
> > > 00000000001973b0 T
> > > _ZN14QWidgetPrivate16syncBackingStoreEv@@Qt_5_PRIVATE_API Semantic error
> > > :SRC@SRC is not allowed.
> > 
> > If adding mangling fix doesn't work for this one, you could try removing
> > some of the name processing in probe-event.c like:
> > 
> > 	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes 
> */
> > 	p = strpbrk(nbase, ".@");
> > 	if (p && p != nbase)
> > 		*p = '\0';
> > 
> > > ...
> > > ```
> > > 
> > > Is there a workaround available for this?
> > > 
> > > Thanks
> 
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts



-- 

- Arnaldo
