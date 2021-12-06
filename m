Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D092C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Dec 2021 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhLFUOd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Dec 2021 15:14:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60368 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349005AbhLFUOd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Dec 2021 15:14:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56798CE1811
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Dec 2021 20:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D742C341C1;
        Mon,  6 Dec 2021 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638821461;
        bh=ADkOR+tfn3Q5LiMRtK4T/21uXiIpN9EPy6Fa/R+HHw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMGWATYwko3RqYi5na4UG91hzGVo9EYNU+1ovNWvtAVVsQDbfYuP5rwWICqGHgd3a
         L916sSCoIu3e63BPPkIZH0z8slIPp0BR2FVPI1ynABuPCLQoD5eJU9OOJnUbdLOEMq
         ye7gCLCPmAG5CzH/k/tmIZZApqInskX9oCpwJw11WHnh8AAtSVekxgh8Vi4ug/O4SF
         X4SM5CiYxh8hlZl7wvBtrFESKLeyZjURevZ6tKleMtcKzdNNynGpsOraLhMbfaeqK4
         +rZUqk1iaX3p5jdTOPW9wdetlmFtDmWCAO4KMzygPRCYZnvt9eDQTEzee/UyaShMed
         vn/EiTQcGR9HQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F04740002; Mon,  6 Dec 2021 17:10:59 -0300 (-03)
Date:   Mon, 6 Dec 2021 17:10:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Adrian Bunk <bunk@debian.org>
Subject: Re: [PATCH v2] perf: Drop requirement for libstdc++.so for
 libopencsd check
Message-ID: <Ya5uU11x7cQc46F1@kernel.org>
References: <20211203210544.1137935-1-uwe@kleine-koenig.org>
 <2d97dd02-fd30-005e-5578-065706986a0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d97dd02-fd30-005e-5578-065706986a0c@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Dec 06, 2021 at 10:14:57AM +0000, James Clark escreveu:
> 
> 
> On 03/12/2021 21:05, Uwe Kleine-König wrote:
> > It's possible to link against libopencsd_c_api without having
> > libstdc++.so available, only libstdc++.so.6.0.28 (or whatever version is
> > in use) needs to be available. The same holds true for libopencsd.so.
> > When -lstdc++ (or -lopencsd) is explicitly passed to the linker however
> > the .so file must be available.
> > 
> > So wrap adding the dependencies into a check for static linking that
> > actually requires adding them all. The same construct is already used
> > for some other tests in the same file to reduce dependencies in the
> > dynamic linking case.
> > 
> > Fixes: 573cf5c9a152 ("perf build: Add missing -lstdc++ when linking with libopencsd")
> > Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

