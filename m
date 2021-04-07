Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42740C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Apr 2021 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A1A61382
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Apr 2021 13:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhDGNai (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhDGNae (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Apr 2021 09:30:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 031B6601FB;
        Wed,  7 Apr 2021 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617802225;
        bh=E5XUDlpMU36N2xKHtDFjZatiJfEQ5tXeC1R3M6Spnzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyP5oJWOvZFjrg88LMjB0mOgMZH24NOZAXJOx31xJVseNXL9JVU+EH+uxuWbPJ0zO
         B9kHNjvVjvsF6q+SDOwGpTnc5IeQbJBSVL7ClbpNoEsRpx/MfgMQRegZodf6mUV2VR
         kPWvFPwaHXHupg8XE97KJkhPhON5Z2hL6tvGdfoGGUkYSKRaM+qUNJ8LtwgItWQse9
         CcJwmuUuHJlvZT/T3yvU+U4Jv2BvlZ+QZtoOXRFrPgbi+5dV3tIO5rn41NkagAb5o2
         3OJ1foWTjTMRcjEwUsxEKimHNIeydUa33P5ktC896+1D+8qJpnIdf4pxsUZqb/l1cv
         LVdx3kC5nPnOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E88240647; Wed,  7 Apr 2021 10:30:22 -0300 (-03)
Date:   Wed, 7 Apr 2021 10:30:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 0/4] perf events vendor amd: Fixes, cleanups and updates
 for AMD Zen cores
Message-ID: <YG2z7q6MhhxO+M9p@kernel.org>
References: <20210406215944.113332-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210406215944.113332-1-Smita.KoralahalliChannabasappa@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Apr 06, 2021 at 04:59:40PM -0500, Smita Koralahalli escreveu:
> This series of patches provides a fix for the broken metric and does some
> cleanup for AMD Zen1/Zen2 cores. Additionally, adds Zen3 events.
> 
> The first patch fixes broken L2 Cache Hits from L2 HWPF recommended event.
> 
> The second and third patches addresses the inconsistency by defaulting all
> event codes and umask values to use lower cases and 0x%02x as their
> format.
> 
> The final patch adds Zen3 events.

Thanks, applied.

- Arnaldo

 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Vijay Thakkar <vijaythakkar@me.com>
> Cc: Martin Liška <mliska@suse.cz>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: linux-perf-users@vger.kernel.org
> 
> Smita Koralahalli (4):
>   perf vendor events amd: Fix broken L2 Cache Hits from L2 HWPF metric
>   perf vendor events amd: Use lowercases for all the eventcodes and umasks
>   perf vendor events amd: Use 0x%02x format for event code and umask
>   perf vendor events amd: Add Zen3 events
> 
>  .../pmu-events/arch/x86/amdzen1/cache.json    |  48 +-
>  .../pmu-events/arch/x86/amdzen1/core.json     |  12 +-
>  .../arch/x86/amdzen1/floating-point.json      |  42 +-
>  .../pmu-events/arch/x86/amdzen1/memory.json   |  42 +-
>  .../pmu-events/arch/x86/amdzen1/other.json    |  12 +-
>  .../arch/x86/amdzen1/recommended.json         |   8 +-
>  .../pmu-events/arch/x86/amdzen2/branch.json   |   8 +-
>  .../pmu-events/arch/x86/amdzen2/cache.json    |  60 +--
>  .../pmu-events/arch/x86/amdzen2/core.json     |  12 +-
>  .../arch/x86/amdzen2/floating-point.json      |  42 +-
>  .../pmu-events/arch/x86/amdzen2/memory.json   |  86 ++--
>  .../pmu-events/arch/x86/amdzen2/other.json    |  20 +-
>  .../arch/x86/amdzen2/recommended.json         |   8 +-
>  .../pmu-events/arch/x86/amdzen3/branch.json   |  53 +++
>  .../pmu-events/arch/x86/amdzen3/cache.json    | 402 ++++++++++++++++
>  .../pmu-events/arch/x86/amdzen3/core.json     | 137 ++++++
>  .../arch/x86/amdzen3/data-fabric.json         |  98 ++++
>  .../arch/x86/amdzen3/floating-point.json      | 139 ++++++
>  .../pmu-events/arch/x86/amdzen3/memory.json   | 428 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen3/other.json    | 103 +++++
>  .../arch/x86/amdzen3/recommended.json         | 214 +++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
>  22 files changed, 1775 insertions(+), 201 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
