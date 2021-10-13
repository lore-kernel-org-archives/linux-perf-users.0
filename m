Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE616C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93C06109E
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 16:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhJMQ7a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238067AbhJMQ7T (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 12:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 907616109E;
        Wed, 13 Oct 2021 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634144235;
        bh=Tk/bVs+ZbsdhSuYNIdd8Gg0DOirgfShoPLVvseKnS3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtRLth7FeOp51ALRIZxWWZpisGaIHr3hYq+0X5tRYZCV7bLA2hXopvGPf4ulvqiDd
         HuuZYmYTVXdVm5CUOyIJnSGxzWphgkCUW4EBJ5IJd15wy1IfZBq3OP4KEPyQE5dWr3
         JmXBuo3hGUnppXRAs6cM3zvxAW3V5DWA99xGAX7WMr2mFOIlaJrZr5rx44b0tNvgYl
         L1attCACr3UTjHBWNgr+oEhlcasmAh+kgtxlaKpa1/bRLaEh/B9gR0XzrnmlO8wU89
         S2qsQrrUbOpfCg9YCgg0OI80LaU0gytZpjeFZduaw+tFlokugznkgcMtiP9R0OYSKv
         tMg6diPY7gNiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69CBC410A1; Wed, 13 Oct 2021 13:57:12 -0300 (-03)
Date:   Wed, 13 Oct 2021 13:57:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     kajoljain <kjain@linux.ibm.com>, john.garry@huawei.com,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tools: Enable strict JSON parsing
Message-ID: <YWcP6EZ6Ors5/CGh@kernel.org>
References: <20211007110543.564963-1-james.clark@arm.com>
 <c15fd2bf-104e-6ab0-6496-7e5cf77a218f@linux.ibm.com>
 <e8752b2d-65a7-1ed8-3c68-30d9006261ba@arm.com>
 <5947c093-cff9-f70e-af20-75bc053edf5f@linux.ibm.com>
 <YWCVTnOUM2P4FRPi@kernel.org>
 <0d73d04f-925c-4c97-9a07-18cc64a9c68b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d73d04f-925c-4c97-9a07-18cc64a9c68b@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 12, 2021 at 02:30:51PM +0100, James Clark escreveu:
> On 08/10/2021 20:00, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 08, 2021 at 04:56:55PM +0530, kajoljain escreveu:
> >> On 10/8/21 3:32 PM, James Clark wrote:
> >>> On 08/10/2021 08:43, kajoljain wrote:
> >> Sure. I think then we can skip this change. Not sure if character
> >> number will be helpful.

> >> Patch-set looks good to me.

> >> Reviewed-by Kajol Jain<kjain@linux.ibm.com>

> > Applied ok as-is to my perf/core branch, applied and added your
> > Reviewed-by, thanks.

> Thanks Arnaldo. This does mean that the arm64 build will fail until
> "[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json" is
> applied. I think there is also an arm64 build issue with "[PATCH 02/21] perf
> pmu: Add const to pmu_events_map." which Andrew Kilroy has replied to.

Its all in:

19f8408a634c9515 (HEAD -> perf/core) perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
69125e749c006b4f perf tools: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
1b1d9560a61f1e4e perf vendor events arm64: Categorise the Neoverse V1 counters
abe8733bc3575869 perf vendor events arm64: Add new armv8 pmu events
d211e9e76a466cce perf vendor events: Syntax corrections in Neoverse N1 json
c067335fcbfc67c3 (quaco/perf/core, acme/tmp.perf/core) perf metric: Allow modifiers on metrics.
acf2cb9cf242e9ab perf parse-events: Identify broken modifiers
fb193eca0ae8ddae perf metric: Switch fprintf() to pr_err()
fb8c3a06943cc3c7 perf metrics: Modify setup and deduplication
4965bb2e71371d5f perf expr: Add subset utility
c1d7cd1b36fce16b perf metric: Encode and use metric-id as qualifier
3743f880b3856971 perf parse-events: Allow config on kernel PMU events
844f07a5ddcd46c5 perf parse-events: Add new "metric-id" term
e68f07424b8b3f00 perf parse-events: Add const to evsel name
ace154d9f5dc3331 perf metric: Simplify metric_refs calculation
eeffd53b41dc7077 perf metric: Document the internal 'struct metric'
9aa64400defa07fb perf metric: Comment data structures
353ce4ed869635c7 perf metric: Modify resolution and recursion check
0bffecb0ac304bb2 perf metric: Only add a referenced metric once
937323c22db4cb1e perf metric: Add metric new and free
176b9da84871449d perf metric: Add documentation and rename a variable.
cc6803c12cef80f1 perf metric: Move runtime value to the expr context
9610bca8f117d963 perf pmu: Make pmu_event tables const
95ed79343835656d perf pmu: Make pmu_sys_event_tables const
05335f28549c7cc5 perf pmu: Add const to pmu_events_map.
cac98c8aca3c7dd2 tools lib: Adopt list_sort from the kernel sources
f792cf8a094eac29 perf kmem: Improve man page for record options
eda1a84cb4e93759 perf tools: Enable strict JSON parsing
21813684e46df1c9 perf tools: Make the JSON parser more conformant when in strict mode
08f3e0873ac20344 perf vendor-events: Fix all remaining invalid JSON files

- Arnaldo
