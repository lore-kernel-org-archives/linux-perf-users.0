Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E16C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FF3613CF
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbhGOUNh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243540AbhGOUNA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:13:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95E1613BB;
        Thu, 15 Jul 2021 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626379806;
        bh=FpP4QhskxX86f8X+tcxg6FYVm2dxOTjbiFgMjYW0exo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIEjku86OAHI6k56LN8czXmwQdej6QDHzphuxJrsjzhMy4wCEC7dfxdS2MyLspz3E
         u097+sU1gHU5cP+Cv4VmNIbANwMriHkX5DF4Pu5TIbvTcttEa+yq4SQDmg1Ntuv38J
         XqW5zealnZT2hNudn8L4Sw568HqxwSTvhLzQOG8nn2h31rGUPw+z0enNJXuAI+SB29
         2/N/L3W5jB1bG3o9wJ/SCPoM9oA7Lbfo5/HLHa7DeKyaR+K6e9XDJ2Gne41iSdxwYO
         HQmeDP2VCr/41wGK6OqvBQh8QChqq0y7XPTzcd1aIOQMFDoDaAztqy0Opj0CsRlXYD
         RNv9G0hB8XinQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A190403F2; Thu, 15 Jul 2021 17:10:03 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:10:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 07/20] perf test: maps__merge_in: fix memory leak of maps
Message-ID: <YPCWG85uXmGnDija@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <a1a29b97a58738987d150e94d4ebfad0282fb038.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a29b97a58738987d150e94d4ebfad0282fb038.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:12PM +0200, Riccardo Mancini escreveu:
> ASan reports a memory leak when running the perf test
> "65: maps__merge_in". This is the second and final patch addressing
> these memory leaks.
> This time, the problem is simply that the maps object is never
> destructed.
> 
> This patch adds the missing maps__exit call.

Not really this one, but at least the patch should apply more easily:

Fixes: 79b6bb73f888933c ("perf maps: Merge 'struct maps' with 'struct map_groups'")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/maps.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> index edcbc70ff9d66e22..1ac72919fa358601 100644
> --- a/tools/perf/tests/maps.c
> +++ b/tools/perf/tests/maps.c
> @@ -116,5 +116,7 @@ int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unus
>  
>  	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
>  	TEST_ASSERT_VAL("merge check failed", !ret);
> +
> +	maps__exit(&maps);
>  	return TEST_OK;
>  }
> -- 
> 2.31.1
> 

-- 

- Arnaldo
