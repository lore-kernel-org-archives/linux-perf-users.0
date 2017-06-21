From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH V3 20/37] perf script: Add 'synth' event type for
 synthesized events
Date: Wed, 21 Jun 2017 10:51:45 -0300
Message-ID: <20170621135145.GO13640@kernel.org>
References: <1495786658-18063-21-git-send-email-adrian.hunter@intel.com>
 <1498040239-32418-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdFUNvu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2017 09:51:50 -0400
Content-Disposition: inline
In-Reply-To: <1498040239-32418-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, David Ahern <dsahern@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Wed, Jun 21, 2017 at 01:17:19PM +0300, Adrian Hunter escreveu:
> +++ b/tools/perf/util/event.h
> @@ -252,6 +252,9 @@ enum auxtrace_error_type {
>        PERF_AUXTRACE_ERROR_MAX
> };

> +/* Attribute type for custom synthesized events */
> +#define PERF_TYPE_SYNTH		3000000000

Why don't you make it PERF_TYPE_MAX and bump PERF_TYPE_MAX by one? I.e.
this way we have what can be in attr.type in a nice enumeration, can
validate it more easily (attr.type < PERF_TYPE_MAX) and will not need to 
do those conversions to/from OUTPUT_TYPE_/PERF_TYPE_).

Peter: now its not the PERF_RECORD_ namespace that userspaces want a
chunk of, its PERF_TYPE_, which so far has been pretty stable, grabing
_one_ for event synthesizing things like Intel PT (and ARM's coresight,
I think) directly at include/uapi/linux/perf_event.h's perf_type_id enum
looks cleaner, no?

- Arnaldo
