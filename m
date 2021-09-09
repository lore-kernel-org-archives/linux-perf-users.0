Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B11C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743A860E94
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355377AbhIINWj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356138AbhIINNr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 09:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A85F610E8;
        Thu,  9 Sep 2021 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631191497;
        bh=Q34YuFVBa7rJl2hvP7F4gDmEAOURCSx7q0llYz6NC3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPHiUWVzlf7auvMzn/r7iIkTSliqiIzXZ4rOh5lJw7PPhKj+fNrH8ssvz8TP798sT
         80HkPILilTb5krjNoEQQYg4fUogH4L4bNzR2tIdKBLdJ3jcS0YZvQnciQ90Rs7Emgz
         i4ZYlD2DLmwLKiy0hfeZxtNDo28sTSQuGkPCQSZLW2NhKq6tSca29nOe40OASgcHL2
         yD4bHRoj7PNmZU75ohMEwe0E56YZFF5wGqhcukqBLmjz5z30hZaSBtv/uY/T8Ao/Ya
         eNFTj/kv1hqCVd05+1W6fTnKQI0+ehRTlZjZGPi+S3oKFCK90/NirJGYBGTBEkRI8Y
         DA04nRO04bidA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F6864038F; Thu,  9 Sep 2021 09:44:54 -0300 (-03)
Date:   Thu, 9 Sep 2021 09:44:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        jolsa@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] perf scripts python: fix passing arguments to
 stackcollapse report
Message-ID: <YToBxo9L3BOfWzVY@kernel.org>
References: <20200427142327.21172-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427142327.21172-1-mpetlan@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Apr 27, 2020 at 04:23:27PM +0200, Michael Petlan escreveu:
> The '--' prevented arguments from being passed to the script, such as:
> 
>   $ perf script report stackcollapse -i my_perf.data

Thanks for resending, applied,

- Arnaldo

 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/scripts/python/bin/stackcollapse-report | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/bin/stackcollapse-report b/tools/perf/scripts/python/bin/stackcollapse-report
> index 356b9656393d..21a356bd27f6 100755
> --- a/tools/perf/scripts/python/bin/stackcollapse-report
> +++ b/tools/perf/scripts/python/bin/stackcollapse-report
> @@ -1,3 +1,3 @@
>  #!/bin/sh
>  # description: produce callgraphs in short form for scripting use
> -perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py -- "$@"
> +perf script -s "$PERF_EXEC_PATH"/scripts/python/stackcollapse.py "$@"
> -- 
> 2.18.1
> 

-- 

- Arnaldo
