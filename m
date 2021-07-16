Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37ACC12002
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 16:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9544D613EB
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhGPQxK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPQxK (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 12:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2377B613E8;
        Fri, 16 Jul 2021 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626454215;
        bh=fR1eM/k0XR7Gjhkw/+2oWO8IaDRE53G+CK69zJwzPmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9xhBcOnRgZA5EVe5cuHX1nLFC/iRx55ZmhUjTRsUURldVwYETJaETU8/sdZpm0Dc
         HuTNbtPmwHNvLU/RaeOGhU50wkb4pzLOD9eP0CgvL1Ky1+zOMh27PzLtRw0WJa049n
         L93kAOJryx5HoULBcauUTuVhZUkGRZWoH5sio+TC108R98ACfrZeplIHVbE0m1ICEJ
         TN4VsWmRvVE/p4Tcy2fH7GRKX7XjicmTKi/ZOLOyp+XfJZGGEr0f9JidLaLhcccvRT
         +bzZwXUtmrEb9Wi/QlwBBFllgC1DDS8qKxsrtR6tBF2b6h+0Byc2FVw9L4jZGlLU+0
         9ruczedy1v6nQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A601403F2; Fri, 16 Jul 2021 13:50:12 -0300 (-03)
Date:   Fri, 16 Jul 2021 13:50:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 19/20] perf test: bpf: free obj_buf
Message-ID: <YPG4xEmVVZetIem9@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <60f3ca935fe6672e7e866276ce6264c9e26e4c87.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f3ca935fe6672e7e866276ce6264c9e26e4c87.1626343282.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:07:24PM +0200, Riccardo Mancini escreveu:
> ASan reports some memory leaks when running the perf test
> "42: BPF filter".
> The first of these leaks is caused by obj_buf never being deallocated in
> __test__bpf.
> 
> This patch adds the missing free.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/bpf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 33bda9c265423547..2cda4a6297e07967 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -276,6 +276,7 @@ static int __test__bpf(int idx)
>  	}
>  
>  out:
> +	free(obj_buf);
>  	bpf__clear();
>  	return ret;
>  }
> -- 

I followed the advice and added the stdlib.h include, elsewhere we're
getting included via some other include by luck.

- Arnaldo

  66     6.97 ubuntu:18.04-x-m68k           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    tests/bpf.c: In function '__test__bpf':
    tests/bpf.c:279:2: error: implicit declaration of function 'free' [-Werror=implicit-function-declaration]
      free(obj_buf);
      ^~~~
    tests/bpf.c:279:2: error: incompatible implicit declaration of built-in function 'free' [-Werror]
    tests/bpf.c:279:2: note: include '<stdlib.h>' or provide a declaration of 'free'
    cc1: all warnings being treated as errors
    /git/perf-5.14.0-rc1/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2

