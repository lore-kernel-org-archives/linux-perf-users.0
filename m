Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA189C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924B261059
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbhHaThg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240907AbhHaThf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:37:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D48E860FE8;
        Tue, 31 Aug 2021 19:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438600;
        bh=Bdd2AUfHZRkDnkxyysbUypVEneghpA+reSd88K+srqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUV2gWTYfGktXIAjOfRBzWNrKiB4FZqdwoSeyCTguLsxhymvyj+cdiz77bHHKy7CS
         D1uMYw7CwNX9LUxk8E65djo1YhJzV86CYLClu9eYaMlA4yd//dhSMY36c52J7N/+cJ
         juxdIOS30IeIp/eTxC2OnmXIvsqXJFBzXWBoLoOJgCgvEtTXaeDFeuWqoEosMN+YSg
         bhvTHL3rVZSp4Q42/crpZU73Ar5/NJXr0Ylc+tibNj1S/S5TNoe6+0Vw2tnW9nD5FI
         XOIR4pthQJ77+bQYSX6CaC6QBHM/Bul8KjhdLtSwqFbJfAcmSFGW0qUEezDgVxMUzo
         gjOGprnWKAT8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A0E8F4007E; Tue, 31 Aug 2021 16:36:37 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:36:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 18/37] perf evsel: add evsel__prepare_open function
Message-ID: <YS6ExQdtIkejH46k@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <fa5e78bbb92c848226f044278fdcf777b3ce4583.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa5e78bbb92c848226f044278fdcf777b3ce4583.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:24AM +0200, Riccardo Mancini escreveu:
> This function will prepare the evsel and disable the missing features.
> It will be used in one of the following patches.

Applied, fixed up this:

int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
                        struct perf_thread_map *threads)

I.e. the alignment of the second line with parms, please use this form
in your next patches.

- Arnaldo
 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 14 ++++++++++++++
>  tools/perf/util/evsel.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f0bc89f743915800..4e9a3e62075305f1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1827,6 +1827,20 @@ static void evsel__disable_missing_features(struct evsel *evsel)
>  		evsel->core.attr.sample_id_all = 0;
>  }
>  
> +int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> +		struct perf_thread_map *threads)
> +{
> +	int err;
> +
> +	err = __evsel__prepare_open(evsel, cpus, threads);
> +	if (err)
> +		return err;
> +
> +	evsel__disable_missing_features(evsel);
> +
> +	return err;
> +}
> +
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads,
>  		int start_cpu, int end_cpu)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1c0057e80d080f2f..58aa998e1814ac9e 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -286,6 +286,8 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
>  int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads);
>  void evsel__close(struct evsel *evsel);
> +int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> +		struct perf_thread_map *threads);
>  
>  struct perf_sample;
>  
> -- 
> 2.31.1

-- 

- Arnaldo
