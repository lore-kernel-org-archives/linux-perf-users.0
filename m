Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADBBC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 20:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiCVUz3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiCVUz3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 16:55:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A91014;
        Tue, 22 Mar 2022 13:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB50DB81DAA;
        Tue, 22 Mar 2022 20:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D891C340EC;
        Tue, 22 Mar 2022 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647982438;
        bh=9jAuSLmCJPwj8SV8wuPWyMh09qiLPip8v2vrMjaG1os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oElMREgC1PdzF7SzFMF9dVMinsYT4Jbh17rKIRaWXonaPOmsbZDKIK8WjB+gay46/
         HTrOKY2VN7UVHUYTg0PjJIkP6P/fjAwT5oFTjVKlJB0r6h+kbTfzRR8tnGl+HmcTpy
         u4gDPhzDhjM7LJaHNE5RQnDjUSw0XZivfk8q99OYa7vjOH58ldN4D4biz8TYCTUwet
         VLoTjQAJwFUkS+mtt8XeFWYhALEqT4zzYdREw2XXqvSp4KpTTDaAzIhwPFGIOMcbcR
         Ao9K55BTL2Z/0aCAyZXXWGPep+U+Uq7VVXNbTp60/FTX+nxPZEylPyLFkD7B0ET66b
         SJKbyrR08I3Xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2A5940407; Tue, 22 Mar 2022 17:53:55 -0300 (-03)
Date:   Tue, 22 Mar 2022 17:53:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: Move slots only with topdown
Message-ID: <Yjo3Y+zLljKU1lVO@kernel.org>
References: <20220321223344.1034479-1-irogers@google.com>
 <ffd440b7-fef9-a5ae-95b7-73c1f8a212ef@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd440b7-fef9-a5ae-95b7-73c1f8a212ef@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Mar 22, 2022 at 07:48:48AM -0400, Liang, Kan escreveu:
> On 3/21/2022 6:33 PM, Ian Rogers wrote:
> > If slots isn't with a topdown event then moving it is unnecessary. For
> > example {instructions, slots} is re-ordered:
> > 
> > $ perf stat -e '{instructions,slots}' -a sleep 1
> > 
> >   Performance counter stats for 'system wide':
> > 
> >         936,600,825      slots
> >         144,440,968      instructions
> > 
> >         1.006061423 seconds time elapsed
> > 
> > Which can break tools expecting the command line order to match the
> > printed order. It is necessary to move the slots event first when it
> > appears with topdown events. Add extra checking so that the slots event
> > is only moved in the case of there being a topdown event like:
> > 
> > $ perf stat -e '{instructions,slots,topdown-fe-bound}' -a sleep 1
> > 
> >   Performance counter stats for 'system wide':
> > 
> >          2427568570      slots
> >           300927614      instructions
> >           551021649      topdown-fe-bound
> > 
> >         1.001771803 seconds time elapsed
> > 
> > Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
> > Reported-by: Kan Liang <kan.liang@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Thanks Ian. The patch works well.
> 
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

