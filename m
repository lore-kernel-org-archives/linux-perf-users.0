Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C78CC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78ABC61186
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 15:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhKGPfx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 10:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231681AbhKGPfw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 10:35:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B477061055;
        Sun,  7 Nov 2021 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636299189;
        bh=oqV/Aft81XAWOlvE1ctJVTIUha35PN0j9579G8jxHmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKU3ipHnAnVUfMFPhy2VpkXmEYMrxjvzunDibXWEhI1wOKra1fp9dNkD+eukdDZEP
         8j2XdTZYG17SKrc+vZBHtFfMC8m0+O5lAT7iOdxB/m8RH1A2eHSaiNv+XO/MNKq36Y
         faYoiHHAB5GNP4RAKgfM6ZXKulSng8jYA7LFLdFhub1/kU+sydMRaXnOWE6Vm7S+FJ
         YtLf653me06r/Yw16/eU4sVfpCvMdC5pKVC0N9WX/ONpe/r+1S53w0BM6SZ8RWk2za
         QWUHEXwsOA/gyPOmF2lRimzYALwnAn+WZCRHZEACIQnaQq5vlkOrvvcnkzeUyaNhWM
         xBKatUYEZdnOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 308F6410A1; Sun,  7 Nov 2021 12:33:07 -0300 (-03)
Date:   Sun, 7 Nov 2021 12:33:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH] perf stat: Fix memory leak on error path
Message-ID: <YYfxsyAdpMXIchQw@kernel.org>
References: <20211107085444.3781604-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107085444.3781604-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Nov 07, 2021 at 01:54:44AM -0700, Ian Rogers escreveu:
> Strdup is used to deduplicate, ensure it isn't overwriting an already

s/overwriting/leaking/g

Right?

- Arnaldo

> created string by freeing first.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-shadow.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 69f3cf3b4a44..e4fb02b05130 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -444,6 +444,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>  						"Add %s event to groups to get metric expression for %s\n",
>  						metric_name,
>  						counter->name);
> +					free(printed);
>  					printed = strdup(metric_name);
>  				}
>  				invalid = true;
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog

-- 

- Arnaldo
