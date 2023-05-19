Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5061AC77B7A
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 May 2023 13:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjESNhF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 May 2023 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjESNhE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 May 2023 09:37:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F251A1;
        Fri, 19 May 2023 06:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98C7657A6;
        Fri, 19 May 2023 13:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D633CC433D2;
        Fri, 19 May 2023 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684503423;
        bh=hiK8VYTchK7S3+lPacQ5ekj52Lz+h90mgpXJRPZ1faU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWRi8d/MlwSR1R6bPzftqiCGljJm1zyhe4GlcGPD1gnNAG4UhV4pYTRdgBY+zCd4o
         t4J95dEwBDbP0EV8tSCi+Weokx9PSctINNw3afgGtv4h7oJqc4TbX/WmCE82sg5uqz
         VB/DxbqmPtsLuyJ6oGO/Mzj2e3tMMyd6lRTWz+dGWTAWfnUMsHfDR6ptFwoeNXXLUs
         u1ZP24Q7fzj9uUv91mrsUtf573iNZD6lcTo/nIbRF2jSvbmHCb4RKG9z8dVSW7F+i1
         dBgya8n35kbt8hp8klPgSWDkHvTOvq3uJmz02vM5prdHcSXsoKrAhLFHTUKHSPS4WF
         tSp171a3A5/sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 94052403B5; Fri, 19 May 2023 10:37:00 -0300 (-03)
Date:   Fri, 19 May 2023 10:37:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf test attr: Update no event/metric
 expectations
Message-ID: <ZGd7fDmBDEmoiSE7@kernel.org>
References: <20230517225707.2682235-1-irogers@google.com>
 <64f329a9-09a3-aa84-a354-23a919062d09@arm.com>
 <ZGYYJ/biKyeFNJjL@kernel.org>
 <f753beda-2d5e-c391-520a-450b186fd4d4@linux.intel.com>
 <9178149c-45e8-3de4-58db-b8b8d27b3a08@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9178149c-45e8-3de4-58db-b8b8d27b3a08@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, May 18, 2023 at 01:45:06PM -0400, Liang, Kan escreveu:
> Hi Arnaldo,
> 
> On 2023-05-18 8:55 a.m., Liang, Kan wrote:
> > On 2023-05-18 8:20 a.m., Arnaldo Carvalho de Melo wrote:
> >> Em Thu, May 18, 2023 at 08:50:14AM +0100, James Clark escreveu:
> >>>
> >>> On 17/05/2023 23:57, Ian Rogers wrote:
> >>>> Previously hard coded events/metrics were used, update for the use of
> >>>> the TopdownL1 json metric group.
> >>>>
> >>>> Fixes: 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if present")
> >>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>> ---
> >>>>  tools/perf/tests/attr/base-stat            |   2 +-
> >>>>  tools/perf/tests/attr/test-stat-default    |  80 ++++++++-----
> >>>>  tools/perf/tests/attr/test-stat-detailed-1 |  95 +++++++++------
> >>>>  tools/perf/tests/attr/test-stat-detailed-2 | 119 +++++++++++--------
> >>>>  tools/perf/tests/attr/test-stat-detailed-3 | 127 ++++++++++++---------
> >>>>  5 files changed, 249 insertions(+), 174 deletions(-)
> >>>>
> >>> Reviewed-by: James Clark <james.clark@arm.com>
> >> Thanks, applied both patches to perf-tools.
> >>
> > Could you please hold patch 1 for a while?
> 
> Sorry for the noise.
> 
> Ian has addressed my concerns. The patch looks good to me now.
> It also fixes a "Failed" on my Cascade Lake machine.
> 
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, added it,

- Arnaldo
 
> But for long term, we probably need a better solution to avoid keeping
> adding such non-architectural events in the test case.
