Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D6C636D4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Feb 2023 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjBONWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 08:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjBONWd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Feb 2023 08:22:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32F38B61;
        Wed, 15 Feb 2023 05:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B28761BE3;
        Wed, 15 Feb 2023 13:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E3FC433EF;
        Wed, 15 Feb 2023 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676467350;
        bh=dumN+7kPt2PnRMxp9OqZvoUwYsetv6dIXzdfMpWd+PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAAf0zP8SNuxP+KlmRfetHEjWftsa7C11ZjorYiyM0djZ65jhCRdBbbWtHBBu5rwj
         t9lxcLrwMtHAO88QnvCrrazKtKnHSThvlYSRurSJR2q7fjqpEM4M/khX28kTQj22Vz
         74SDrsmV8jmRo+S2JQcBI2GTqEa4xtBLKCVKEh9DPhvKyXJAgz/VVmM9FAwUzmFXVX
         ia6ijJOe3mqGzj7pNa8iwz/xKmnagcBoLYG4j6hoyK4WsH+VzCyynj0VrMA4zBSgah
         8qy8kpFdzIIvk311az3wcP7layk0/I8TTBPhx9CEdqKWDGdf2dwAUY7WWrSMn97RQw
         4uWd8m6UH00ZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E791740025; Wed, 15 Feb 2023 10:22:27 -0300 (-03)
Date:   Wed, 15 Feb 2023 10:22:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jiwei.sun@windriver.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4] perf record: Fix segfault with --overwrite and
 --max-size
Message-ID: <Y+zckxuLUEUK0BmI@kernel.org>
References: <20230215122324.105229-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215122324.105229-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 15, 2023 at 12:23:24PM +0000, Yang Jihong escreveu:
> When --overwrite and --max-size options of perf record are used together,
> a segmentation fault occurs. The following is an example:
<SNIP>
> We add a member variable "thread_bytes_written" in the struct "record"
> to save the data size written by the threads.
> 
> Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
> 
> Changes since v3:
>  - Add Namhyung Kim Acked-by
>    (I don't know whether the problem is caused by my email address, Send again)

Thanks, applied.

- Arnaldo

 
> Changes since v2:
>  - Save data size written by threads to calculate the correct total data size.
>  - Update commit message.
> 
> Changes since v1:
>  - Add variable check in record__bytes_written for code hardening.
>  - Save bytes_written separately to reduce one calculation.
>  - Remove rec->opts.tail_synthesize check.
> 
>  tools/perf/builtin-record.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 29dcd454b8e2..8374117e66f6 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -154,6 +154,7 @@ struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
>  	u64			bytes_written;
> +	u64			thread_bytes_written;
>  	struct perf_data	data;
>  	struct auxtrace_record	*itr;
>  	struct evlist	*evlist;
> @@ -226,14 +227,7 @@ static bool switch_output_time(struct record *rec)
>  
>  static u64 record__bytes_written(struct record *rec)
>  {
> -	int t;
> -	u64 bytes_written = rec->bytes_written;
> -	struct record_thread *thread_data = rec->thread_data;
> -
> -	for (t = 0; t < rec->nr_threads; t++)
> -		bytes_written += thread_data[t].bytes_written;
> -
> -	return bytes_written;
> +	return rec->bytes_written + rec->thread_bytes_written;
>  }
>  
>  static bool record__output_max_size_exceeded(struct record *rec)
> @@ -255,10 +249,12 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  		return -1;
>  	}
>  
> -	if (map && map->file)
> +	if (map && map->file) {
>  		thread->bytes_written += size;
> -	else
> +		rec->thread_bytes_written += size;
> +	} else {
>  		rec->bytes_written += size;
> +	}
>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
