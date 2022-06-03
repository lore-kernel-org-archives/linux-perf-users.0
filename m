Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40821C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiFCTqO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiFCTqM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 15:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6639816;
        Fri,  3 Jun 2022 12:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF67F61A8A;
        Fri,  3 Jun 2022 19:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32625C385B8;
        Fri,  3 Jun 2022 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654285570;
        bh=n/N9nhmQTZNw84Qva5/8HfNa8syd3nJ9CDjN2bnzXTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAUepYyF84wGH17iQgHHWFsvzAcqPQxJuLHy4MVnaYM91QiQTynU4Y2yohrzSkiAz
         KIs9+D10taX7aCedSZmqlk6W8GKaiL+qBkiGk8SM9MCasZfHFuj6Gz2KsyGz/l4umz
         /viez+42ULVtlE7pJ3NW5+hKDSXF8ljXPNnfxg00D+o6Ep+aIWHIoziJy6qiyDxYv+
         bukTBhzOkmwsuOCGPvUH+66WMwecP8731Q4jkXyptAJLhg/n+9KitAg6X7mwQEtOXX
         6whQVCvD9DQ5SM9+0pXA/A+XqKazjKOa4SFuQz/D5gwZIADuHbQNu6xcLYS8lAT966
         Hq7UUZ0weJRwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C09F04096F; Fri,  3 Jun 2022 21:46:07 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:46:07 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v2 1/2] perf vendor events intel: Add metrics for
 Sapphirerapids
Message-ID: <Yppk/4/d3s5tiO6T@kernel.org>
References: <20220528095933.1784141-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUpmtWRYcZQoV26q4ZCGVmORJpTe_Mz3Y=JmH3tXLvapw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUpmtWRYcZQoV26q4ZCGVmORJpTe_Mz3Y=JmH3tXLvapw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jun 01, 2022 at 05:56:24PM -0700, Ian Rogers escreveu:
> On Sat, May 28, 2022 at 2:59 AM <zhengjun.xing@linux.intel.com> wrote:
> >
> > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> >
> > Add JSON metrics for Sapphirerapids to perf.
> >
> > Based on TMA4.4 metrics.
> >
> > https://download.01.org/perfmon/TMA_Metrics-full.csv
> >
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> I didn't find a sapphirerapids to test this on, but non-CPU specific
> event/metric tests passed.
> 
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, applied both.

- Arnaldo

