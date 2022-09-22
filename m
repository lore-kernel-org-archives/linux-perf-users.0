Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC5FECAAD8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIVT1M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiIVT1L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 15:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1651106F74
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 12:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D092637A3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 19:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0FDC433D7;
        Thu, 22 Sep 2022 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663874829;
        bh=Xi3lMX6hVlnMb1P059agb8lPU+GfJW9du0Lzj0aIb+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ynwzzjos6aq5xPfrbdsqTGiwmhfDTkvbffwXxWlDzGdLwtfsyFOWYzBAw56lrxRWv
         He4zJL1ve2scpwHE3REWCjTmQeSY0QniVFhSPolMijyL9AMRssLBH0Yd4ESgaBXxEq
         4N1ZoCXsJrspOi91zecDWWcoPHBzS1KugtB1t4TFgGhz3x2jo8zCQtZ/Yjb7tlh5Uk
         S00tvNR/XChIHrneFbp6HiYMSic5JJO/GiJ7l/4tNynPzMd1m0Wc5b6KXnyCwHdA3a
         KYrqwnNTXGjj2FNDOnBV43Rkam802NYbf+InF0/z2wn4xSEWMWML836lossyyzs4Fr
         o5ihejQx7lZqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A5F1403B0; Thu, 22 Sep 2022 20:27:07 +0100 (IST)
Date:   Thu, 22 Sep 2022 20:27:07 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     Stefano Sanfilippo <ssanfilippo@chromium.org>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf genelf: Fix error code in jit_write_elf()
Message-ID: <Yyy3Cx1ervgKd1OV@kernel.org>
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
 <20220922141438.22487-2-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922141438.22487-2-shangxiaojing@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 22, 2022 at 10:14:35PM +0800, Shang XiaoJing escreveu:
> The error code is set to -1 at the beginning of jit_write_elf(), but it is
> assigned by jit_add_eh_frame_info() in the middle, hence the following
> error can only return the error code of jit_add_eh_frame_info(). Reset
> the error code to the default value after being assigned by
> jit_add_eh_frame_info().

You forgot to add:

Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
Fixes: 086f9f3d7897d808 ("perf jit: Generate .eh_frame/.eh_frame_hdr in DSO")

Applied.

- Arnaldo
 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  tools/perf/util/genelf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index ed28a0dbcb7f..2e45b204494a 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -331,6 +331,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
>  					       eh_frame_base_offset);
>  		if (retval)
>  			goto error;
> +		retval = -1;
>  	}
>  
>  	/*
> -- 
> 2.17.1

-- 

- Arnaldo
