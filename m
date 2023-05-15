Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E14C77B7D
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbjEOVbX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 17:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbjEOVbX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 17:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D10093;
        Mon, 15 May 2023 14:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B14960B59;
        Mon, 15 May 2023 21:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4433C433D2;
        Mon, 15 May 2023 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684186281;
        bh=7050tPmQbarGoQdpQ0e4gbl5kxFwodp7M8tuIoTV/mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZfXvsc7xyPy6AaVUubjLFwe1CmmpXvtiyb4l31GtNUGNeaQQ+1hbiJQK/+ugBcto
         F8R2n9K7BwYE+I7mtyfFgJPcjBb/6nNsc2cpzSSn6dlGOVhXrYUC82nx/oiX5w3o2B
         aTO8c6T88i5MwlYlY+vdrG2IJffGTfBedUCs6wM2bjSkEGp2dbTWAkrSmVAWv2i1Sb
         9wcbrObyOe0GWXFzhoEDj9n7nNAhZyvEIczh/wLU8TVKI8ietxTBoqmfqK0GiFBroE
         xiC6tlcOR5T7QX7JUcjYjw+mNRraSYw2vhzh/blKb4VZ3upPWvSiIKn/TH3e3dKip1
         xTS5vjwbh6JwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93451403B5; Mon, 15 May 2023 18:31:18 -0300 (-03)
Date:   Mon, 15 May 2023 18:31:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, namhyung@kernel.org,
        eranian@google.com, mark.rutland@arm.com, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 4/4] perf test: Add selftest to test IBS invocation
 via core pmu events
Message-ID: <ZGKkpq4ynrdH7ZeE@kernel.org>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-5-ravi.bangoria@amd.com>
 <20230505091648.GC1770668@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505091648.GC1770668@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, May 05, 2023 at 11:16:48AM +0200, Peter Zijlstra escreveu:
> On Thu, May 04, 2023 at 04:30:03PM +0530, Ravi Bangoria wrote:
> > IBS pmu can be invoked via fixed set of core pmu events with 'precise_ip'
> > set to 1. Add a simple event open test for all these events.
> > 
> > Without kernel fix:
> >   $ sudo ./perf test -vv 76
> >    76: AMD IBS via core pmu                                      :
> >   --- start ---
> >   test child forked, pid 6553
> >   Using CPUID AuthenticAMD-25-1-1
> >   type: 0x0, config: 0x0, fd: 3  -  Pass
> >   type: 0x0, config: 0x1, fd: -1  -  Pass
> >   type: 0x4, config: 0x76, fd: -1  -  Fail
> >   type: 0x4, config: 0xc1, fd: -1  -  Fail
> >   type: 0x4, config: 0x12, fd: -1  -  Pass
> >   test child finished with -1
> >   ---- end ----
> >   AMD IBS via core pmu: FAILED!
> > 
> > With kernel fix:
> >   $ sudo ./perf test -vv 76
> >    76: AMD IBS via core pmu                                      :
> >   --- start ---
> >   test child forked, pid 7526
> >   Using CPUID AuthenticAMD-25-1-1
> >   type: 0x0, config: 0x0, fd: 3  -  Pass
> >   type: 0x0, config: 0x1, fd: -1  -  Pass
> >   type: 0x4, config: 0x76, fd: 3  -  Pass
> >   type: 0x4, config: 0xc1, fd: 3  -  Pass
> >   type: 0x4, config: 0x12, fd: -1  -  Pass
> >   test child finished with 0
> >   ---- end ----
> >   AMD IBS via core pmu: Ok
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > ---
> >  tools/perf/arch/x86/include/arch-tests.h      |  1 +
> >  tools/perf/arch/x86/tests/Build               |  1 +
> >  .../arch/x86/tests/amd-ibs-via-core-pmu.c     | 71 +++++++++++++++++++
> >  tools/perf/arch/x86/tests/arch-tests.c        |  2 +
> >  4 files changed, 75 insertions(+)
> >  create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> 
> Arnaldo, ok if I merge this along with the other patches or would you
> rather take it?

That would be ok, checking if you merged already...

- Arnaldo
