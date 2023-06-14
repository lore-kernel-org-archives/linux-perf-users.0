Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E492DEB64DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 13:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbjFNN74 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbjFNN7n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 09:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426FE6C;
        Wed, 14 Jun 2023 06:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33C2960C76;
        Wed, 14 Jun 2023 13:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65392C433C8;
        Wed, 14 Jun 2023 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751181;
        bh=CKdfUKCQGb8QioLhwf7Td2EQbQv2e4ZYDhWzQKHBPj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBE8wpkML173HiESeCsODQvAyNlwWRctt4SgDDggp/WqOHOVrheRPBIUbnt4iop2e
         ot1NrWzV8zUh1xhBXKFCSEg23Epsf0iiEjKSd+iXh6lFf2YUuZz1DBlRaYJ+XsLH1t
         VPp8fcG0JOxP0+MKCNCBDS2YhJQRzF5cJVrvYx24wofX1707NtmIuRU3AKG+7d36c8
         9fNz+IEDNsBWwle/T6PV8OeBGeCOxFrHZuFBRwNSMTKyH5dnxEobRRmpxseRqRp6qf
         9Tw7wJtTVyCitpNewIxpjrH3QiIQCb7/HS0J5WBG2zk6wkexWl5Ger/FjUjKpHEjZP
         2sO3PlEVQYJtw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BD4EA40692; Wed, 14 Jun 2023 10:59:38 -0300 (-03)
Date:   Wed, 14 Jun 2023 10:59:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: remove unneeded variable
Message-ID: <ZInHyuu4zT7xkbKw@kernel.org>
References: <20230614033437.48549-1-luojianhong@cdjrlc.com>
 <475df60d9dd518e20ae9df396c60b69b@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <475df60d9dd518e20ae9df396c60b69b@208suo.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jun 14, 2023 at 11:38:41AM +0800, baomingtong001@208suo.com escreveu:
> fix the following coccicheck warning:
> 
> tools/perf/bench/find-bit-bench.c:127:5-8: Unneeded variable: "err". Return
> "0".

⬢[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/bench/find-bit-bench.c
patch: **** malformed patch at line 117: num_bits)

⬢[acme@toolbox perf-tools-next]$

Please check the process you're following to generate and send the
patch.

There is a doc file for that...

Documentation/process/submitting-patches.rst

Well, two:

Documentation/process/submit-checklist.rst

I'm applying this manually,

Thanks,

- Arnaldo
 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  tools/perf/bench/find-bit-bench.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/find-bit-bench.c
> b/tools/perf/bench/find-bit-bench.c
> index 7e25b0e413f6..70619bc73841 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -124,7 +124,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
> 
>  int bench_mem_find_bit(int argc, const char **argv)
>  {
> -    int err = 0, i;
> +    int i;
> 
>      argc = parse_options(argc, argv, options, bench_usage, 0);
>      if (argc) {
> @@ -135,5 +135,5 @@ int bench_mem_find_bit(int argc, const char **argv)
>      for (i = 1; i <= 2048; i <<= 1)
>          do_for_each_set_bit(i);
> 
> -    return err;
> +    return 0;
>  }

-- 

- Arnaldo
