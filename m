Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C51C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 07:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643E161C29
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 07:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhF1HZ3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:25:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:59184 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhF1HZ3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Jun 2021 03:25:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="204895212"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="204895212"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 00:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="419069114"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2021 00:22:59 -0700
Subject: Re: [PATCH V2 00/10] perf script: Add API for filtering via
 dynamically loaded shared object
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210627131818.810-1-adrian.hunter@intel.com>
 <e2a57ee8-6489-40d5-04d0-7d985eba961f@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ea9a04ad-26b2-7072-9f45-9ddbd8f61c10@intel.com>
Date:   Mon, 28 Jun 2021 10:23:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e2a57ee8-6489-40d5-04d0-7d985eba961f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 27/06/21 7:13 pm, Andi Kleen wrote:
> 
> On 6/27/2021 6:18 AM, Adrian Hunter wrote:
>> Hi In some cases, users want to filter very large amounts of data
>> (e.g. from AUX area tracing like Intel PT) looking for something
>> specific. While scripting such as Python can be used, Python is 10
>> to 20 times slower than C. So define a C API so that custom filters
>> can be written and loaded.
> 
> While I appreciate this for complex cases, in my experience filtering
> is usually just a simple expression. It would be nice to also have a
> way to do this reasonably fast without having to write a custom C

I do not agree that writing C filters is a hassle e.g. a minimal do-nothing
filter is only a few lines:

#include <perf/perf_dlfilter.h>

int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
{
	return 0;
}

(Actually, the filter program does not have to have any LOC at all, but that
is not much of an example)

Additionally, a script to do the build is fairly trivial e.g. I use this:

$ cat `which make-dlfilter.sh `
#!/bin/bash

set -ex

if test -z "${1}" ; then
        echo "Name required"
        exit 1
fi

name="${1%.c}"

if test "${name}" = "${1}" ; then
        name="${1%.so}"
fi

gcc -c -I ~/include -fpic "${name}.c"

gcc -shared -o "${name}.so" "${name}.o"


> file.   Is the 10x-20x overhead just the python interpreter, or is it
> related to perf?


AFAICT the Python C API used to interface to Python performs fairly similarly
to the Python interpreter.

>                  Maybe we could have some kind of python fast path
> just for filters?

I expect there are ways to make it more efficient, but I doubt it would ever
come close to C.

> just for filters? Or maybe the alternative would be to have a
> frontend in perf that can automatically generate/compile such a C
> filter based on a simple expression, but I'm not sure if that would
> be much simpler.

If gcc is available, perf script could, in fact, build the .so on the fly
since the compile time is very quick.

Another point is that filters can be used for more than just filtering.
Here is an example which sums cycles per-cpu and prints them, and the difference
to the last print, at the beginning of each line.  I think this was something
you were interested in doing?


#include <perf/perf_dlfilter.h>
#include <stdio.h>

#define MAX_CPU 4096

__u64 cycles[MAX_CPU];
__u64 cycles_rpt[MAX_CPU];

int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
{
	__s32 cpu = sample->cpu;

	if (cpu >=0 && cpu < MAX_CPU)
		cycles[cpu] += sample->cyc_cnt;
	return 0;
}

int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
{
	__s32 cpu = sample->cpu;

	if (cpu >=0 && cpu < MAX_CPU) {
		printf("%10llu %10llu ", cycles[cpu], cycles[cpu] - cycles_rpt[cpu]);
		cycles_rpt[cpu] = cycles[cpu];
	} else {
		printf("%22s", "");
	}
	return 0;
}

const char *filter_description(const char **long_description)
{
	return "Print the number of cycles at the start of each line";
}
