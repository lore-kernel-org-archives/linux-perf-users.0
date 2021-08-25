Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E68C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17E061058
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 17:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhHYRKs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhHYRKs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 13:10:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32FCF61076;
        Wed, 25 Aug 2021 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629911402;
        bh=Se6ESmp5jjg7dkcXwvKkpQ8Dn3flsBFk+dID+PfAXrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IloKBvV7syb8AMknqj+dTmdrWKQ80QZGX2G2ShAk0GtnIbGrdC6zEgXQi8dc7sTot
         JCT+2T4jcDGUuemC5eQC+ignbTt4FhMNNrM2zOZkzwMfcCKiSWGGRBEV5OHUHmKIdH
         h0grhPsKT7Z9GhkUHBVPhBvx3aP/tIMd0+UoMclYN04qEflbatHmKvslo00W+57dM3
         RM69+yEK2GRiUd7zn1cbToFTopjUKPWS3hrSujljGYYOAQt8ODwA091k+xp9FivVGt
         BrbjkhLQisaOqXjwJ2QlT9rb4cNntv/kEDx6iPmhxK6yVdRsuN9mNHKPVLhDqeOc7/
         SfXUoj/DBIWYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2DC1A4007E; Wed, 25 Aug 2021 14:09:59 -0300 (-03)
Date:   Wed, 25 Aug 2021 14:09:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix *probe_vfs_getname.sh test failures
Message-ID: <YSZ5Z3Y0oWTxxTi7@kernel.org>
References: <20210825164259.833222-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825164259.833222-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 25, 2021 at 05:42:59PM +0100, James Clark escreveu:
> The commit 4d6101f5fd5d ("perf probe: Clarify error message about not
> finding kernel modules debuginfo") changed the error message "Failed to
> find the path for kernel" to "Failed to find the path for the kernel".
> 
> Update the regex so that the tests still skip rather than fail when
> kernel debug symbols aren't present.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index c2cc42daf924..5b17d916c555 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -19,6 +19,6 @@ add_probe_vfs_getname() {
>  }
>  
>  skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for kernel|Debuginfo-analysis is not supported)" && return 2
> +	add_probe_vfs_getname -v 2>&1 | egrep -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)" && return 2
>  	return 1
>  }
> -- 
> 2.28.0

-- 

- Arnaldo
