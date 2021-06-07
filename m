Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5117BC47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 05:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF3D610E7
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 05:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFGFqO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 01:46:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:19856 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGFqN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 01:46:13 -0400
IronPort-SDR: FmGsXn4017DcCq5BGQWgBGQp8n0FfBVyhETZE+VIm0vA0B/o1dpr3W3gEjNM0EjRQXfGZUOpzx
 TTWxWwFtPNAg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="202704604"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="202704604"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 22:44:21 -0700
IronPort-SDR: 0X/pscciBeUWshvi5HVOHY4hJbxSHyBnzMS0gv/EJHLc/Cg0/OEhsTqU54MaSZLxV+v6+WabIp
 vypB0D/hoLvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447366356"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2021 22:44:18 -0700
Subject: Re: [PATCH] perf session: Correct buffer copying when peek event
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210605052957.1070720-1-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <587603d3-c707-49d8-08a9-193a22e5e227@intel.com>
Date:   Mon, 7 Jun 2021 08:44:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210605052957.1070720-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 5/06/21 8:29 am, Leo Yan wrote:
> When peek an event, it has a short path and a long path.  The short path
> uses the session pointer "one_mmap_addr" to directly fetch event; and
> the long path needs to read out the event header and the followed event
> data from file and fill into the buffer pointer passed through the
> argument "buf".
> 
> The issue is in the long path that it copies the event header and event
> data into the same destination address which pointer "buf", this means
> the event header is overwritten.  We are just lucky to run into the
> short path in most cases, so we don't hit the issue in the long path.
> 
> This patch adds the offset "hdr_sz" to the pointer "buf" when copying
> the event data, so that it can reserve the event header which can be
> used properly by its caller.
> 
> Fixes: 5a52f33adf02 ("perf session: Add perf_session__peek_event()")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/session.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 106b3d60881a..e59242c361ce 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1723,6 +1723,7 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
>  	if (event->header.size < hdr_sz || event->header.size > buf_sz)
>  		return -1;
>  
> +	buf += hdr_sz;
>  	rest = event->header.size - hdr_sz;
>  
>  	if (readn(fd, buf, rest) != (ssize_t)rest)
> 

