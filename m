Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F4C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Mar 2022 22:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiCYWJU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Mar 2022 18:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiCYWJT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Mar 2022 18:09:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170532EE6;
        Fri, 25 Mar 2022 15:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6F661301;
        Fri, 25 Mar 2022 22:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10676C340ED;
        Fri, 25 Mar 2022 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648246064;
        bh=JA7X9DXFOgnaCslKi7MjdG2Cm8f7cAztxV6RoopqFac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQQ8llIiOO72O0syag3DN8OLb1UEqemLbQI1msZd6EN7qEag8TzT37bnSQ25HCEdk
         5b9bS/ou0UAIi8BW7BXRkyxIBRuDHKdgD+aYo+6Fd7PPpd3ezxhqwt0Rq5H007K8hV
         7RQ1tcj/ONvNw/iFalV41oUme3NC/S1xv+3JcbFqF3r2hMatvFGMuh5SkE4KP86lfN
         a7CbDdo0yus8pI6QVzeEn7jJT2G0CEXTDZc2z3/T/flXTF9nDhTTjlSXn7dBNt9NgU
         Vzf3gr0KKq/T3GrotcVDyjP5DSsdq2xynJfV1EuBG9g0ggHliqG8g0oGnx+57Euv2M
         wmhj/CUBYTpFQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8CBDF40407; Fri, 25 Mar 2022 19:07:40 -0300 (-03)
Date:   Fri, 25 Mar 2022 19:07:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Steinar H. Gunderson" <sesse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Message-ID: <Yj49LDY3S/ANeN0V@kernel.org>
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org>
 <YjpFcLiCTjHZWzzA@google.com>
 <52d31321-66e1-f189-2ffc-7c93239eea74@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d31321-66e1-f189-2ffc-7c93239eea74@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 23, 2022 at 09:58:00AM +0200, Adrian Hunter escreveu:
> On 22/03/2022 23:53, Steinar H. Gunderson wrote:
> > On Tue, Mar 22, 2022 at 06:32:18PM -0300, Arnaldo Carvalho de Melo wrote:
> >> I saw there was some issue, should I proceed and apply this v3 patch or
> >> wait for some v4?
> > 
> > There are two issues in play:
> > 
> >  1. PT event synth doesn't support reading inline information from DWARF
> >     yet, and my patch to add it runs into some problems. This is not
> >     relevant for this patch at all.
> >  2. The results from v3 don't quite match the ones from v1, and neither
> >     of us are entirely sure why. My personal feeling is that the one
> >     from v1 are the wrong ones, but it's up to Adrian to say whether we
> >     want to try to investigate deeply here.
> 
> V3 is good.  Please take that.

Thanks, applied.

- Arnaldo

