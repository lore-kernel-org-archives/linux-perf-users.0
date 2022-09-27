Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D06C07E9D
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Sep 2022 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiI0MYb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiI0MYU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Sep 2022 08:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402BE122045
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Sep 2022 05:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A77E6618AC
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Sep 2022 12:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66DDC433D6;
        Tue, 27 Sep 2022 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664281455;
        bh=5Vn3chzpOUWhGEzWYyITfoS9FZDoVFqFKN1VO4PsJ4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKiZSJKjnBWRzmp2FyIe9m29zBAfvUGzwK6RwMGYMDFzJF4RbxkzQ+M+SAXiGSSrR
         k2K99NKHLn42K6y1WzjYaMY4SabtNM/0/TM03hU2vVICDQjYhp3aMG3b5FQKEFvksz
         jQmGJDXMS5ak4wxezWDjcSztRnJ9O7GATrwaGEQW4AU8cs4l/HDnAWKOp7n3rApMdO
         /Tdd+6bcEWGatghKUo0qjPnFRttMWRKf5ptXho4Lv3AJGxREgGng5B1tBJjexdm2xO
         6DcSrCYCdkcfoZxdOS1EgQnkL+j4WXCl2V/ciUeEqaxOb3XkeoLow9VbcvPtZ/Ojvi
         3Nvb+2OYAAwXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8BA5D403B0; Tue, 27 Sep 2022 13:24:12 +0100 (IST)
Date:   Tue, 27 Sep 2022 13:24:12 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yuan Can <yuancan@huawei.com>, Simon Que <sque@chromium.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/5] perf machine: Remove unused struct process_args
Message-ID: <YzLrbMeBn2+gJDep@kernel.org>
References: <20220927013931.110475-1-yuancan@huawei.com>
 <20220927013931.110475-2-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927013931.110475-2-yuancan@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Sep 27, 2022 at 01:39:27AM +0000, Yuan Can escreveu:
> After commit a93f0e551af9("perf symbols: Get kernel start address by symbol
> name"), no one uses struct process_args any more, so remove it.
 

Thanks, applied.

- Arnaldo

> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  tools/perf/util/machine.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2a16cae28407..76316e459c3d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1128,10 +1128,6 @@ static struct dso *machine__get_kernel(struct machine *machine)
>  	return kernel;
>  }
>  
> -struct process_args {
> -	u64 start;
> -};
> -
>  void machine__get_kallsyms_filename(struct machine *machine, char *buf,
>  				    size_t bufsz)
>  {
> -- 
> 2.17.1

-- 

- Arnaldo
