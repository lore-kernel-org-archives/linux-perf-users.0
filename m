Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D22FC00145
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Dec 2022 18:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiLLSyR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiLLSxm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Dec 2022 13:53:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F235B65F3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 10:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46696611D0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Dec 2022 18:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A451C433D2;
        Mon, 12 Dec 2022 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670871190;
        bh=WQA8BP7yxNp5RFg2kA+KJSFkyZ3hS2AeQuAtN3XPCn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rh94Ds51rLw61oplIjfxfPNA7lYouOPaWUnZQVQxo8rgqbplh/Cux+R2dNpEVNCTA
         cbk9NlXzFCBtGM4IlgIx+QUVofQm0IcdjE0UPpvmAGMlFCM3YSuVoq7i7krUWQWG0a
         /JwXTV4cxM+ypxZ6gYVsYCRH8pYhW4Ngth4ng777c/SPhyPhomXFBzrdrP5a/46ml9
         puvFDUl/LB/eWSc8gKHOu74vfxGHwPjmR7D2uvDA9wvUedIQ7PaSZ7QHjSz/f1sD4E
         IkbNKGhxNzYvr64PgwQe3E5iFAXx9oQn/TDUfja5qY4Ns+u2KsQzJiVxvWqmQHIA6i
         lPVNvF6pp0H+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 98B7540483; Mon, 12 Dec 2022 15:53:07 -0300 (-03)
Date:   Mon, 12 Dec 2022 15:53:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Khem Raj <raj.khem@gmail.com>, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] perf python: Account for multiple words in CC
Message-ID: <Y5d4k7fDxfRP7hcN@kernel.org>
References: <20221205025534.150006-1-raj.khem@gmail.com>
 <7d262374-1217-d79a-ff2d-d6626a98e195@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d262374-1217-d79a-ff2d-d6626a98e195@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Dec 05, 2022 at 01:01:10PM -0800, Florian Fainelli escreveu:
> On 12/4/22 18:55, Khem Raj wrote:
> > Sometimes build systems may append options e.g. --sysroot etc. to CC
> > variable especially in cross-compile environments like yocto project
> > where CC varable is composed of cross-compiler name and some needed
> > options for it to work in a relocatable environment. Therefore separate
> > out the compiler name from rest of the options in CC, then add the
> > options via second argument to Popen() API
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Fangrui Song <maskray@google.com>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: John Keeping <john@metanate.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> 
> FWIW:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks, applied.

- Arnaldo

