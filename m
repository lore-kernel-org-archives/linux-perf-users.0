Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC309C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 09:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85FE60F44
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 09:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhI1JIU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:08:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:47021 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239816AbhI1JIT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 05:08:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="285669087"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="285669087"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 02:06:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="553912067"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.227.239]) ([10.249.227.239])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 02:06:36 -0700
Subject: Re: [PATCH 1/2] perf iostat: Use system-wide mode if the target
 cpu_list is unspecified
To:     Like Xu <like.xu.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927081115.39568-1-likexu@tencent.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <8b8a984b-6a10-825d-240a-48dc856ae2e7@linux.intel.com>
Date:   Tue, 28 Sep 2021 12:06:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927081115.39568-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 9/27/2021 11:11 AM, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
>
> An iostate use case like "perf iostat 0000:16,0000:97 -- ls" should be
> implemented to work in system-wide mode to ensure that the output from
> print_header() is consistent with the user documentation perf-iostat.txt,
> rather than incorrectly assuming that the kernel does not support it:
>
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) \
>   for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
>   /bin/dmesg | grep -i perf may provide additional information.
>
> This error is easily fixed by assigning system-wide mode by default
> for IOSTAT_RUN only when the target cpu_list is unspecified.
Hello,
Thank you for your fixes.

Tested-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>   tools/perf/builtin-stat.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f6e87b7be5fa..f0ecfda34ece 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2408,6 +2408,8 @@ int cmd_stat(int argc, const char **argv)
>   			goto out;
>   		} else if (verbose)
>   			iostat_list(evsel_list, &stat_config);
> +		if (iostat_mode == IOSTAT_RUN && !target__has_cpu(&target))
> +			target.system_wide = true;
>   	}
>   
>   	if (add_default_attributes())
