Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 13:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiBWN7q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiBWN7h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 08:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C108B0C69
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:59:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FACDB81FDB
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 13:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFF0C340E7;
        Wed, 23 Feb 2022 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645624746;
        bh=6oMtpOnVJIo4+SgJH1DmxTYj72KT/okXihbtgIuDEUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=araFVi6AYbECMb+/wSipeEE19A56sCzlVtuL1sYGJTuD1Ob/vHqwR1GxNPuL5U6mj
         nYZLHmV8MGZl+GoMSc8sCjxCeuVKrqUGjBZmD7/iJ9KfwFUkwYO5yVAVA+y2485Tpw
         9zfoELyfcY0nLyOAHnS3TTDhyYC5CqqHa0wDIItwU5WG00qPnInaMUnIia4TahiMvP
         xMVhO0gLPkgvGA39N18e27Nuruy58Xx7TJ+ysLid2xK/anFiDL0kO0iP7lBU/ix8t7
         45pvtWH6BI28QD15wunZXq2GaMGH5mHc7PwIfcPZNDAQqGL2YgO+7jo6ZiCdVR+hz+
         N4M/km+YZ7mDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81483400FE; Wed, 23 Feb 2022 10:59:03 -0300 (-03)
Date:   Wed, 23 Feb 2022 10:59:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     olsajiri@gmail.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] libperf: Fix read_size calculations
Message-ID: <YhY9p9wsYgXtdYnt@kernel.org>
References: <20220223131349.134897-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223131349.134897-1-tz.stoyanov@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 23, 2022 at 03:13:49PM +0200, Tzvetomir Stoyanov (VMware) escreveu:
> Reading the counters from perf descriptor fails because of size
> mismatch when PERF_FORMAT_GROUP is set. The group count must include the
> parent and the count of siblings.

Yeah, it should match the calculation done in the kernel, in
__perf_event_read_size(), that has...

static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
{
        int entry = sizeof(u64); /* value */
        int size = 0;
        int nr = 1;

        if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
                size += sizeof(u64);

        if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
                size += sizeof(u64);

        if (event->attr.read_format & PERF_FORMAT_ID)
                entry += sizeof(u64);

        if (event->attr.read_format & PERF_FORMAT_GROUP) {
                nr += nr_siblings;
                size += sizeof(u64);
        }

        size += entry * nr;
        event->read_size = size;
}

So this bug has been with us since forever (well, 2017), so we need:

Fixes: 5c30af92f2b1e9d8 ("libperf: Adopt perf_evsel__read() function from tools/perf")

To fix it in libperf and probably:

Fixes: de63403bfd14ae8d ("perf tools: Add perf_evsel__read_size function")

To get this to stable kernels versions predating the move of this
function to libperf.

Jiri?

- Arnaldo
 
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> ---
>  tools/lib/perf/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 210ea7c06ce8..4597a53c0152 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -299,7 +299,7 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
>  		entry += sizeof(u64);
>  
>  	if (read_format & PERF_FORMAT_GROUP) {
> -		nr = evsel->nr_members;
> +		nr += evsel->nr_members;
>  		size += sizeof(u64);
>  	}
>  
> -- 
> 2.34.1

-- 

- Arnaldo
