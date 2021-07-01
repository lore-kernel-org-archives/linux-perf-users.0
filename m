Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C49EC11F69
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B4B61407
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhGARnD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhGARnD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 13:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99F89613CF;
        Thu,  1 Jul 2021 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625161232;
        bh=xLCtF4ERVx3lvbj2NQhW5MfgdR9rvEAlBwDFrcwnl/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEJ9MlUD87Ql9QHIW5WB3GYn6Vz9rDGcEJaeIijzsOCxhYmTKOfTRLMyfwCa3X/mt
         209o1yjP/k6DjuC71oYIEQ3dYmJXSmFTo3jGNo+H3EmN6fQ0hmuy56/SXQkNBGDBs6
         e9l5mnWpghWY2Mv9TTdtG9buBGFGqf/ObuTgVDJlW4OeAwX7iRhm3v/z2uD53DbRfW
         r9eXLG28Bt9hCTJaNpKoP8aNS6Ag/S313Ek74MXuQU01iDaImrf2iDdETeETEP3wyZ
         jJp+lT5nWsZHWRVWD+4gBJ2IoylpNYQz1z00gIQjskgoiSW5syteDhxyBYhd4iPcXY
         6P3qvBDyxZ/pg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E426C40B1A; Thu,  1 Jul 2021 14:40:28 -0300 (-03)
Date:   Thu, 1 Jul 2021 14:40:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/10] perf script: Add API for filtering via
 dynamically loaded shared object
Message-ID: <YN3+DLZvPsW6q/l5@kernel.org>
References: <20210627131818.810-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Jun 27, 2021 at 04:18:08PM +0300, Adrian Hunter escreveu:
> Hi
>  
> In some cases, users want to filter very large amounts of data (e.g. from
> AUX area tracing like Intel PT) looking for something specific. While
> scripting such as Python can be used, Python is 10 to 20 times slower than
> C. So define a C API so that custom filters can be written and loaded.
> 
> This is V2.
> 
> The main patch is patch 1.
> 
> The other patches add more functionality, except for patch 5 which installs
> the C API header file.

Thanks! applied.

Please consider adding a 'perf test' entry to check if what is produced
is what is expected, also to exercise this code so that we get some
'perf test' segfault if we break something it uses somehow.

- Arnaldo
 
> 
> Changes in V2:
>     perf script: Move filter_cpu() earlier
>     perf script: Move filtering before scripting
>     perf script: Share addr_al between functions
> 	Dropped because they have now been applied.
> 
>     perf script: Add API for filtering via dynamically loaded shared object
> 	Move 2 members of struct perf_dlfilter_sample
> 	Add 'ctx' as an argument to 'start' and 'stop'
> 	Find dlfilter .so files in current directory or exec-path/dlfilters
> 
>     perf script: Add option to list dlfilters
> 	New patch
> 
>     perf script: Add option to pass arguments to dlfilters
> 	New patch
> 
> 
> Adrian Hunter (10):
>       perf script: Add API for filtering via dynamically loaded shared object
>       perf script: Add dlfilter__filter_event_early()
>       perf script: Add option to list dlfilters
>       perf script: Add option to pass arguments to dlfilters
>       perf build: Install perf_dlfilter.h
>       perf dlfilter: Add resolve_address() to perf_dlfilter_fns
>       perf dlfilter: Add insn() to perf_dlfilter_fns
>       perf dlfilter: Add srcline() to perf_dlfilter_fns
>       perf dlfilter: Add attr() to perf_dlfilter_fns
>       perf dlfilter: Add object_code() to perf_dlfilter_fns
> 
>  tools/perf/Documentation/perf-dlfilter.txt | 251 ++++++++++++
>  tools/perf/Documentation/perf-script.txt   |  15 +-
>  tools/perf/Makefile.config                 |   3 +
>  tools/perf/Makefile.perf                   |   4 +-
>  tools/perf/builtin-script.c                |  86 +++-
>  tools/perf/util/Build                      |   1 +
>  tools/perf/util/dlfilter.c                 | 615 +++++++++++++++++++++++++++++
>  tools/perf/util/dlfilter.h                 |  97 +++++
>  tools/perf/util/perf_dlfilter.h            | 150 +++++++
>  9 files changed, 1211 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-dlfilter.txt
>  create mode 100644 tools/perf/util/dlfilter.c
>  create mode 100644 tools/perf/util/dlfilter.h
>  create mode 100644 tools/perf/util/perf_dlfilter.h
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
