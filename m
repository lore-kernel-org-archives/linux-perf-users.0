Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF47C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7465661074
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhI0Ml6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234375AbhI0Ml6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 08:41:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E84660F46;
        Mon, 27 Sep 2021 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632746420;
        bh=WgMOABlOvB0w0w8Esx6zVPgVb/yQMODmolBG6FP7UXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GB4cSVctSgvLtTROqPxQDY63uFkjBM9npphoqaUKQdt1xovrTTEbhS1UvsurHdVU7
         TmUTcj422Lg688MyCOwQzIRUIjhK9p1Lq7EsxYdXuwRyGmc1COeWH3SFzP9xaTHiwr
         rohhtsQjSDKdoO/5XL7R+uCXCGgRX+T14a8yImQRZPva36smrBGg14eYTavzBQ16e+
         0Harb5I/FZ0nFyh+P1r1U2xSMfK2CKhkJQ2Rd2MsoDFFn5GUzR3G71ADgSBU28ozET
         HxMO7hxKsW62Xwmow9BcnttVsgon34nvAYgYMdy0VCCYoMQNdoy0NCRrn7e7qvb/C3
         i/PLxnLDparuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BF88410A1; Mon, 27 Sep 2021 09:40:18 -0300 (-03)
Date:   Mon, 27 Sep 2021 09:40:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf iostat: Use system-wide mode if the target
 cpu_list is unspecified
Message-ID: <YVG7spSrPm/oJW8W@kernel.org>
References: <20210927081115.39568-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927081115.39568-1-likexu@tencent.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 27, 2021 at 04:11:14PM +0800, Like Xu escreveu:
> From: Like Xu <likexu@tencent.com>
> 
> An iostate use case like "perf iostat 0000:16,0000:97 -- ls" should be
> implemented to work in system-wide mode to ensure that the output from
> print_header() is consistent with the user documentation perf-iostat.txt,
> rather than incorrectly assuming that the kernel does not support it:
> 
>  Error:
>  The sys_perf_event_open() syscall returned with 22 (Invalid argument) \
>  for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
>  /bin/dmesg | grep -i perf may provide additional information.
> 
> This error is easily fixed by assigning system-wide mode by default
> for IOSTAT_RUN only when the target cpu_list is unspecified.

Looks ok, added:

Fixes: f07952b179697771 ("perf stat: Basic support for iostat in perf")

For stable@vger.kernel.org sake.

- Arnaldo
 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f6e87b7be5fa..f0ecfda34ece 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2408,6 +2408,8 @@ int cmd_stat(int argc, const char **argv)
>  			goto out;
>  		} else if (verbose)
>  			iostat_list(evsel_list, &stat_config);
> +		if (iostat_mode == IOSTAT_RUN && !target__has_cpu(&target))
> +			target.system_wide = true;
>  	}
>  
>  	if (add_default_attributes())
> -- 
> 2.32.0

-- 

- Arnaldo
