Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EB3C43334
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbiFCTQ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348990AbiFCTQT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 15:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEE44A21;
        Fri,  3 Jun 2022 12:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FF3761A2A;
        Fri,  3 Jun 2022 19:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A8AC3411C;
        Fri,  3 Jun 2022 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654283777;
        bh=YEP8hJ7+e45KpwMyDOo+OTvyxSKXQuFPeyH44saUf4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REVc0BjKY5Jx4mVMFM0MKURAehU/wChy8hzlhI1ewKGMhbKtRYmlzicufKzkh9rH1
         DCewmn0PengDs8rJxEKRzrj8QbFsyjcOLyi3DFFTsHEGAHPGLKYDNVbQA15sJXEVeN
         +UP/HxjEGED6zK2CsjAGonVPHugPXE1Qaklk2pljkCZqCIttchH+lLj735pMb6P17p
         FTbcxzZ/bHsIEJC3fXc+Yy+OoVdL3A1p9LxbUCUYAWIQ0j+16JNp3tTefTP54LK/b1
         EyQJp6iu3tGITUHPXTrpT+Jv/DspWdPiULZqAeVyMp2N/2ulI2SDOkEjyLewa5TJ36
         60f8SZqzUXveA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6AA04096F; Fri,  3 Jun 2022 21:16:14 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:16:14 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Ian Rogers <irogers@google.com>, Kevin Nomura <nomurak@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alyssa Ross <hi@alyssa.is>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Joshua Martinez <joshuamart@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf docs: Correct typo of event_sources
Message-ID: <Yppd/rUoWN7na+Iz@kernel.org>
References: <20220603045744.2815559-1-irogers@google.com>
 <13ddd896-d7a6-3539-2dcf-7ffe4f1a2569@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ddd896-d7a6-3539-2dcf-7ffe4f1a2569@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 03, 2022 at 11:30:00AM +0530, Sandipan Das escreveu:
> 
> On 6/3/2022 10:27 AM, Ian Rogers wrote:
> > The sysfs directory is called event_source.
> > 
> > Reported-by: Kevin Nomura <nomurak@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 2 +-
> >  tools/perf/Documentation/perf-stat.txt   | 2 +-
> >  tools/perf/Documentation/perf-top.txt    | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> >  [...]
> 
> Thanks for fixing these.
> 
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>

Thanks, applied.

- Arnaldo

