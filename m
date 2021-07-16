Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F21C12002
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC217613CF
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 19:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhGPTFA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhGPTE7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 15:04:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D693613FB;
        Fri, 16 Jul 2021 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626462122;
        bh=yEJPtfa1Zq9q4W78R+9+eAYYn+4rYdqmirT/S5/Ry9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FppLyN5o6EEWSYbitYlSG2BEyRKmPAo6szPGpPCVLZEB2Lj66ON/vKdtiATJvafwB
         zKBsbFN6Cc039RK4gJSU4uYRNLgUHtrhfnTC1b2uB/ckeTuvwarNXdkhlzJERE5CIe
         uhxd9RZu8yqDu6Ynp0e5SLjggPH2a/NXevLr1c5Znhienvh9PJHZItX3yXuV/GuewT
         W2W1AjhjlEyJLKfscBdGiqugrmk8mTCcUQd7YV7VdnQViCnGOWw2dXIIMleLEeV3a8
         u8qQ4VgaehjVCCoI1YzwhvVzeGFm0MUbBHu1/6EpXe6niPM2TpiTqRiEw+4ZriYCSQ
         m5njaHIXO8lvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFB0C403F2; Fri, 16 Jul 2021 16:01:59 -0300 (-03)
Date:   Fri, 16 Jul 2021 16:01:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] perf data: close all files in close_dir
Message-ID: <YPHXp2yGpdiBDCA/@kernel.org>
References: <20210716141122.858082-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716141122.858082-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 16, 2021 at 04:11:20PM +0200, Riccardo Mancini escreveu:
> When using perf report in directory mode, the first file is not closed on
> exit, causing a memory leak.
> The problem is caused by the iterating variable never reaching 0.

Thanks, applied.

- Arnaldo
 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Fixes: 145520631130bd64 ("perf data: Add perf_data__(create_dir|close_dir) functions")
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
> Hi Arnaldo, 
> 
> I think this patch might have gone lost in the mailbox, submerged by
> other mails.
> I'll take advantage of the resend to add the missing 'Fixes:' tag.
> 
> I didn't flag this as v2 since it contains no logical change, let me
> know if doing so would've been better.
> 
> Changes from first send: 
>  - collected ack from Namhyung
>  - added Fixes: tag
> 
> Original: https://lkml.kernel.org/lkml/20210621214220.167927-1-rickyman7@gmail.com/
> 
> Thanks,
> Riccardo
> ---
>  tools/perf/util/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 8fca4779ae6a8e90..70b91ce35178c5f9 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -20,7 +20,7 @@
>  
>  static void close_dir(struct perf_data_file *files, int nr)
>  {
> -	while (--nr >= 1) {
> +	while (--nr >= 0) {
>  		close(files[nr].fd);
>  		zfree(&files[nr].path);
>  	}
> -- 
> 2.23.0
> 

-- 

- Arnaldo
