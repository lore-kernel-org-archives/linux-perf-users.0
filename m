Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C78C54EE9
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 19:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIVTdV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIVTdU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 15:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375B91080A3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 12:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C05637A7
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 19:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB7EC433D6;
        Thu, 22 Sep 2022 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663875199;
        bh=RUWBdVncb1cyXyMHf3znjeKqcqkci69Wa5DgRjVOzTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jzzm0xlJtKvQ/LV7UwSJyks9E1kEW8/5YuBgF2q2e6f1txrPZQriRHXsfEuDj0t5w
         ro9hEMCg9p3uFCcaZGvurKihmz7S7JlI2pUpqKXO3/83NV5tOtClHxzU6o2b1pdLoK
         Qr7w0CPC3tE+XHMyNK5QqUhi4q6dok69a6vd2kyryddB88LCvvaXu4DY9epFce6GHz
         0Eko+28IuzwYBa8jbuMqrA0hH5193IN9Ybqx+b2u1HrcEIJ1KKqMCSndnG+TYtFrxP
         m344bY+hSSs5JDVbCg9tSqWiEBK8K9OzxVzhKzuBM4JSg4wDIJybYxQQlEJyeCKvEP
         gPVJypp1+uAgw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1016403B0; Thu, 22 Sep 2022 20:33:16 +0100 (IST)
Date:   Thu, 22 Sep 2022 20:33:16 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf stat: Merge cases in process_evlist
Message-ID: <Yyy4fJNyxxXVzHyv@kernel.org>
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
 <20220922141438.22487-3-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922141438.22487-3-shangxiaojing@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 22, 2022 at 10:14:36PM +0800, Shang XiaoJing escreveu:
> As two cases in process_evlist has same behavior, merge these cases.

Applied.

Added the patch below, see:

include/linux/compiler_attributes.h and
tools/include/linux/compiler-gcc.h.

- Arnaldo

Commiter notes:

Added __fallthrough, the kernel has "fallthrough", we need to make
tools/ use it.

---

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e10595f649bcb2b4..7b8e901bce101b63 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -662,6 +662,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
 		switch (cmd) {
 		case EVLIST_CTL_CMD_ENABLE:
+			__fallthrough;
 		case EVLIST_CTL_CMD_DISABLE:
 			if (interval)
 				process_interval();
 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  tools/perf/builtin-stat.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e05fe72c1d87..e10595f649bc 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -662,9 +662,6 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>  	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
>  		switch (cmd) {
>  		case EVLIST_CTL_CMD_ENABLE:
> -			if (interval)
> -				process_interval();
> -			break;
>  		case EVLIST_CTL_CMD_DISABLE:
>  			if (interval)
>  				process_interval();
> -- 
> 2.17.1

-- 

- Arnaldo
