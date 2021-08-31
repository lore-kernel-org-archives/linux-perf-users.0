Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B64C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B5C60FE8
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbhHaTsk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhHaTsj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:48:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADC9D60FC3;
        Tue, 31 Aug 2021 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439263;
        bh=6qWa4iDpk/xVe1Ft/BT0+AL0cYx8U0yvB8CfDL4WQfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyZ5Ln5LBqUbTkqlMgcgGVtZWzWO+JDaM6fVY/djKM2f7F+jDsm/7HRWLsOuhi/JI
         1T9udOjykm/dL/+ZSsPysnLu/bAbr+LJQjsHeJjfZzH1DKgnilKImOKgXOAClzRKNM
         xBGzMqet3qI0XD20LBWNneMR6PAeyueT+mJcGpY1bXwNDKyY94I2eTO5UjhjOoNRU1
         0++gaNdfRrAQCWwRocf2okajwLfynB58qc1MOjYuR/xeEHmkz6RM+BZQqgxkyUen2v
         swRUq6mJHx2XlXoH03a4NoXKrsyknOo1SfTVh6K/5t4mdo0cVUZfiCcMruON/RJXvA
         NDBSHIdqdYANA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 329C24007E; Tue, 31 Aug 2021 16:47:41 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:47:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 22/37] perf evsel: move test_attr__open to success
 path in evsel__open_cpu
Message-ID: <YS6HXQ1DOA4uZVht@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <b3baf11360ca96541c9631730614fd7d217496fc.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3baf11360ca96541c9631730614fd7d217496fc.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:28AM +0200, Riccardo Mancini escreveu:
> test_attr__open ignores the fd if -1, therefore it is safe to move it to
> the success path (fd >= 0).

Nicely spotted, applied.

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a1a88607fd59efcb..d2b0391569286080 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2011,11 +2011,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			bpf_counter__install_pe(evsel, cpu, fd);
>  
> -			if (unlikely(test_attr__enabled)) {
> -				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
> -						fd, group_fd, evsel->open_flags);
> -			}
> -
>  			if (fd < 0) {
>  				err = -errno;
>  
> @@ -2024,6 +2019,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  				goto try_fallback;
>  			}
>  
> +			if (unlikely(test_attr__enabled)) {
> +				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
> +						fd, group_fd, evsel->open_flags);
> +			}
> +
>  			pr_debug2_peo(" = %d\n", fd);
>  
>  			if (evsel->bpf_fd >= 0) {
> -- 
> 2.31.1

-- 

- Arnaldo
