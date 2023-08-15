Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E2C001DE
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 17:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbjHORuy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbjHORun (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 13:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF31FC9
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8811760C7F
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30AEC433C8;
        Tue, 15 Aug 2023 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121836;
        bh=AtOiQ9l4U2blPdrTAtQmHvzqzAsBO86Ys0GCRKOclAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3yBahP05nTpgNCmz9N2QqPtQewWwk4EZkl50bRgjXQYFKaB4m3ibTSc31RKVJsCm
         21HBeBM+vAX4u4pbTvrVxM332AHQ9Cg2W7vIf8LSIol8TjvhTpm7p/PHcmxKRPDnW5
         Vb5uRSch0GyoBnX3yN7AJ3sKqa7nPozxPey4BVqWxXjAG6+fKrE7kdIvQJlQc4YqPM
         F51yL4EUVDlLwVCkYjCYNk4dHWwTAX2mkQFmEdTX3BbKIr0juCdkZKJrmKBKV/ycsH
         3oji9AuAMi9HjD/HKqOU+wwsGhXT7hzLoP9JEA1cS4llr/zwbNcgmrPr8Krkt/q3lC
         CBoifVHYLP0OA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62BEA404DF; Tue, 15 Aug 2023 14:50:33 -0300 (-03)
Date:   Tue, 15 Aug 2023 14:50:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] perf scripts python: Update package name for python3
Message-ID: <ZNu66U2HC996PlDN@kernel.org>
References: <20230815131805.1237491-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815131805.1237491-1-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 15, 2023 at 09:18:05PM +0800, Wei Li escreveu:
> 'audit-libs-python' is the package for python2, update it for python3.
> On Ubuntu and Fedora, the new package is 'python3-audit'.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  .../scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py   | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> index 7384dcb628c4..84536b1a27ba 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
> @@ -73,9 +73,9 @@ try:
>  except:
>  	if not audit_package_warned:
>  		audit_package_warned = True
> -		print("Install the audit-libs-python package to get syscall names.\n"
> -                    "For example:\n  # apt-get install python-audit (Ubuntu)"
> -                    "\n  # yum install audit-libs-python (Fedora)"
> +		print("Install the python-audit package to get syscall names.\n"
> +                    "For example:\n  # apt-get install python3-audit (Ubuntu)"
> +                    "\n  # yum install python3-audit (Fedora)"
>                      "\n  etc.\n")
>  
>  def syscall_name(id):
> -- 
> 2.25.1
> 

-- 

- Arnaldo
