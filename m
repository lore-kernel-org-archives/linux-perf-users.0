Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85AFC3DA6F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 13:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbjHYN2E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjHYN1e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 09:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064AC1FDF
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 06:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9916F63AF7
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F3AC433C9;
        Fri, 25 Aug 2023 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692970052;
        bh=KOqi6oK43Vs2mul+StiSy2eRMxpDXqSEPhel26yKDqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErRAnsjFwADbjKXx4th/qiGQfNDtCMydyU2n9Ih94gTh2yT1Pf+4zfFkmr/904/VO
         9DKrSCpSwFr6Fv6a017yRihQ7TKFcnzkAEbT/m95gVALjQj6pgkylZn8mguRMCPoke
         PyPO+9aHuVJLzqtQ7jP4IoF8a5lp+p5rpUzCydIQJjcITkUU3mVFRNcskm31Tfxvqo
         s6UkTD5sGWW0/W5hd7tL6D19NwjL1KDxEDqJVZXXdlA00LEd4pi0YOXp2wwVaF1aBP
         zxlNjTeN0L3L94xFQG0A5hd4PvkiuYdLjLSfmMuVhrnDfRoWPEO0K4OAj3ciJ6RUyP
         QXlo45bAkfqzw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1692A40722; Fri, 25 Aug 2023 10:27:29 -0300 (-03)
Date:   Fri, 25 Aug 2023 10:27:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        disgoel@linux.ibm.com, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH] perf lock contention: Fix typo in max-stack option
 description
Message-ID: <ZOisQaiysVzoxRon@kernel.org>
References: <20230825104700.440809-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825104700.440809-1-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 25, 2023 at 04:17:00PM +0530, Kajol Jain escreveu:
> Fix typo in max-stack option description by changing lopck contention
> to lock contention.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index c15386cb1033..76d4f8b2bf7d 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2506,7 +2506,7 @@ int cmd_lock(int argc, const char **argv)
>  	OPT_CALLBACK('M', "map-nr-entries", &bpf_map_entries, "num",
>  		     "Max number of BPF map entries", parse_map_entry),
>  	OPT_CALLBACK(0, "max-stack", &max_stack_depth, "num",
> -		     "Set the maximum stack depth when collecting lopck contention, "
> +		     "Set the maximum stack depth when collecting lock contention, "
>  		     "Default: " __stringify(CONTENTION_STACK_DEPTH), parse_max_stack),
>  	OPT_INTEGER(0, "stack-skip", &stack_skip,
>  		    "Set the number of stack depth to skip when finding a lock caller, "
> -- 
> 2.39.3
> 

-- 

- Arnaldo
