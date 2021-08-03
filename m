Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4463CC19F34
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B5E610CC
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhHCLoy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:27563 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235997AbhHCLoR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Aug 2021 07:44:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200829989"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="200829989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 04:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="466640204"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2021 04:44:02 -0700
Subject: Re: [PATCH 2/2] perf: remove shebang from
 scripts/{perl,python}/*.{pl,py}
To:     Jiri Slaby <jslaby@suse.cz>, acme@redhat.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210726091434.5000-1-jslaby@suse.cz>
 <20210726091434.5000-2-jslaby@suse.cz>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d916a46f-91fb-4e11-b72e-b96a73971117@intel.com>
Date:   Tue, 3 Aug 2021 14:44:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726091434.5000-2-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 26/07/21 12:14 pm, Jiri Slaby wrote:
> The scripts cannot be executed on their own. The python ones were always
> installed without x permissions, the perl ones fail anyway:
>   BEGIN failed--compilation aborted at /usr/lib/perf-core/scripts/perl/rw-by-pid.pl line 18.
> so there is no point to have a shebang in them. This causes rpmlint to
> complain too:
>   W: non-executable-script /usr/lib/perf-core/scripts/perl/rw-by-file.pl 644 /usr/bin/perl -w
> 
> Hence drop shebangs in them all and remove x permissions in the
> repository. If anyone wants some of them executable, they need to fix
> the install scripts first.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/scripts/perl/rw-by-file.pl            | 1 -
>  tools/perf/scripts/perl/rw-by-pid.pl             | 1 -
>  tools/perf/scripts/perl/rwtop.pl                 | 1 -
>  tools/perf/scripts/perl/wakeup-latency.pl        | 1 -
>  tools/perf/scripts/python/exported-sql-viewer.py | 1 -

exported-sql-viewer.py is a standalone executable


>  tools/perf/scripts/python/flamegraph.py          | 0
>  tools/perf/scripts/python/libxed.py              | 1 -
>  tools/perf/scripts/python/net_dropmonitor.py     | 0
>  tools/perf/scripts/python/stackcollapse.py       | 0
>  9 files changed, 6 deletions(-)
>  mode change 100755 => 100644 tools/perf/scripts/python/exported-sql-viewer.py
>  mode change 100755 => 100644 tools/perf/scripts/python/flamegraph.py
>  mode change 100755 => 100644 tools/perf/scripts/python/net_dropmonitor.py
>  mode change 100755 => 100644 tools/perf/scripts/python/stackcollapse.py
> 
> diff --git a/tools/perf/scripts/perl/rw-by-file.pl b/tools/perf/scripts/perl/rw-by-file.pl
> index 92a750b8552b..e0e4e23d5597 100644
> --- a/tools/perf/scripts/perl/rw-by-file.pl
> +++ b/tools/perf/scripts/perl/rw-by-file.pl
> @@ -1,4 +1,3 @@
> -#!/usr/bin/perl -w
>  # SPDX-License-Identifier: GPL-2.0-only
>  # (c) 2009, Tom Zanussi <tzanussi@gmail.com>
>  
> diff --git a/tools/perf/scripts/perl/rw-by-pid.pl b/tools/perf/scripts/perl/rw-by-pid.pl
> index d789fe39caab..43fcd4823f21 100644
> --- a/tools/perf/scripts/perl/rw-by-pid.pl
> +++ b/tools/perf/scripts/perl/rw-by-pid.pl
> @@ -1,4 +1,3 @@
> -#!/usr/bin/perl -w
>  # SPDX-License-Identifier: GPL-2.0-only
>  # (c) 2009, Tom Zanussi <tzanussi@gmail.com>
>  
> diff --git a/tools/perf/scripts/perl/rwtop.pl b/tools/perf/scripts/perl/rwtop.pl
> index eba4df67af6b..96ce72e53f8e 100644
> --- a/tools/perf/scripts/perl/rwtop.pl
> +++ b/tools/perf/scripts/perl/rwtop.pl
> @@ -1,4 +1,3 @@
> -#!/usr/bin/perl -w
>  # SPDX-License-Identifier: GPL-2.0-only
>  # (c) 2010, Tom Zanussi <tzanussi@gmail.com>
>  
> diff --git a/tools/perf/scripts/perl/wakeup-latency.pl b/tools/perf/scripts/perl/wakeup-latency.pl
> index 53444ff4ec7f..f8b59f0bd949 100644
> --- a/tools/perf/scripts/perl/wakeup-latency.pl
> +++ b/tools/perf/scripts/perl/wakeup-latency.pl
> @@ -1,4 +1,3 @@
> -#!/usr/bin/perl -w
>  # SPDX-License-Identifier: GPL-2.0-only
>  # (c) 2009, Tom Zanussi <tzanussi@gmail.com>
>  
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> old mode 100755
> new mode 100644
> index 13f2d8a81610..358438a648a9
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>  # SPDX-License-Identifier: GPL-2.0
>  # exported-sql-viewer.py: view data from sql database
>  # Copyright (c) 2014-2018, Intel Corporation.
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> old mode 100755
> new mode 100644
> diff --git a/tools/perf/scripts/python/libxed.py b/tools/perf/scripts/python/libxed.py
> index 2c70a5a7eb9c..3ea5bb8195c4 100644
> --- a/tools/perf/scripts/python/libxed.py
> +++ b/tools/perf/scripts/python/libxed.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>  # SPDX-License-Identifier: GPL-2.0
>  # libxed.py: Python wrapper for libxed.so
>  # Copyright (c) 2014-2021, Intel Corporation.
> diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
> old mode 100755
> new mode 100644
> diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
> old mode 100755
> new mode 100644
> 

