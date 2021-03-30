Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A7C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEB0619C7
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 15:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhC3Pqu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhC3Pqm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Mar 2021 11:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 447E061989;
        Tue, 30 Mar 2021 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617119202;
        bh=Gbo18e0zdm2kilYNA5VIkTdaGkhkqxzLYPQJfq+9ayg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iD5cUhyNwaSHFGPGWy1DHqumaX8i9IFq4p/6Ji1zYB+UtjApSg0fXrU6/4mSEAJgF
         Jb9h1o3TW5a6VSO3VGYo3d3p+Tu/0mvQU1bpJgeFN6BamVc/ZWwxlTUgyioI6Cayrx
         JHIJDI4mMMmjur/HQW/TIMvMtwUtHVF3NsFGDBGbrc1MdpNH04c8LYyezcHaMAgoRM
         8j8O/H3oNzhVkCxzOP4TB1HrUiE+eATgM8qvR4U+FlBc5QLsePXiOZphniMCrawSGa
         vk/Pg2OWmOXaZ+nAGUmlu915pPavQLjT3N7eMZk2e+1+4TOJxqpNhG2ax4lp9iaEX8
         MH2lrbA/ru/8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4877A40647; Tue, 30 Mar 2021 12:46:40 -0300 (-03)
Date:   Tue, 30 Mar 2021 12:46:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Fabian Hemmer <copy@copy.sh>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Preserve identifier id in OCaml demangler
Message-ID: <YGNH4F6tbZVJlUWN@kernel.org>
References: <20210226075223.p3s5oz4jbxwnqjtv@nyu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226075223.p3s5oz4jbxwnqjtv@nyu>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 26, 2021 at 02:52:23AM -0500, Fabian Hemmer escreveu:
> Some OCaml developers reported that this bit of information is sometimes
> useful for disambiguating functions for which the OCaml compiler assigns
> the same name, e.g. nested or inlined functions.

Sorry for the delay in processing, applied.

- Arnaldo
 
> Signed-off-by: Fabian Hemmer <copy@copy.sh>
> ---
>  tools/perf/tests/demangle-ocaml-test.c |  6 +++---
>  tools/perf/util/demangle-ocaml.c       | 12 ------------
>  2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
> index a273ed5163d7..1d232c2e2190 100644
> --- a/tools/perf/tests/demangle-ocaml-test.c
> +++ b/tools/perf/tests/demangle-ocaml-test.c
> @@ -19,11 +19,11 @@ int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_u
>  		{ "main",
>  		  NULL },
>  		{ "camlStdlib__array__map_154",
> -		  "Stdlib.array.map" },
> +		  "Stdlib.array.map_154" },
>  		{ "camlStdlib__anon_fn$5bstdlib$2eml$3a334$2c0$2d$2d54$5d_1453",
> -		  "Stdlib.anon_fn[stdlib.ml:334,0--54]" },
> +		  "Stdlib.anon_fn[stdlib.ml:334,0--54]_1453" },
>  		{ "camlStdlib__bytes__$2b$2b_2205",
> -		  "Stdlib.bytes.++" },
> +		  "Stdlib.bytes.++_2205" },
>  	};
>  
>  	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
> diff --git a/tools/perf/util/demangle-ocaml.c b/tools/perf/util/demangle-ocaml.c
> index 3df14e67c622..9d707bb60b4b 100644
> --- a/tools/perf/util/demangle-ocaml.c
> +++ b/tools/perf/util/demangle-ocaml.c
> @@ -64,17 +64,5 @@ ocaml_demangle_sym(const char *sym)
>  	}
>  	result[j] = '\0';
>  
> -	/* scan backwards to remove an "_" followed by decimal digits */
> -	if (j != 0 && isdigit(result[j - 1])) {
> -		while (--j) {
> -			if (!isdigit(result[j])) {
> -				break;
> -			}
> -		}
> -		if (result[j] == '_') {
> -			result[j] = '\0';
> -		}
> -	}
> -
>  	return result;
>  }
> -- 
> 2.30.1
> 

-- 

- Arnaldo
