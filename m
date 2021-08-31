Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48BC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D70A61074
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbhHaTR5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhHaTR5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7682161057;
        Tue, 31 Aug 2021 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630437421;
        bh=bTQUHDephO2BwXAw6npExcZWHUGXMCAV4h/ZXp453S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoGIT/5ecE7FeDZWcHzNQ7gI5GmMz1XF7CYKFfnRfVVOrS2wCBNW2sUdKh9LoLy2V
         8nxfrCGlGpUZUYMwLFpKJyfmEiEoSxbfi25CFGA2n++CMyNT8va3Q37pmaDFIwbWIz
         +yfhL518zmwR7tyF1towo3fBL6sdXIVZYSJx+eb8E7LL4aR5zzQTCnJQvyQ4sOiRdQ
         w+VlSnS78/7NGBQteJpCbz7nzQGCFYFJ7BAr5FIIzAkZcZtIGPUjVxdpNGEyLKd4ia
         rPD9QI+6z+AhbiDrzU42I0TsS+mS5xrorRHZcsRjCQZbXjM54cUKd1nibOZqPww/uF
         clS2GhacneB+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D664E4007E; Tue, 31 Aug 2021 16:16:57 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:16:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/37] libperf cpumap: improve max function
Message-ID: <YS6AKamBroQIgG7r@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <fb79f02e7b86ea8044d563adb1e9890c906f982f.1629490974.git.rickyman7@gmail.com>
 <YS55LhhuABId0ag7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS55LhhuABId0ag7@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 31, 2021 at 03:47:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Aug 21, 2021 at 11:19:08AM +0200, Riccardo Mancini escreveu:
> > >From commit 7074674e7338863e ("perf cpumap: Maintain cpumaps ordered and
> > without dups"), perf_cpu_map elements are sorted in ascending order.
> > 
> > This patch improves the perf_cpu_map__max function by returning the last
> > element.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/lib/perf/cpumap.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index fb633272be3aaed9..80e03b2f0c60cce7 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -284,14 +284,10 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
> >  
> >  int perf_cpu_map__max(struct perf_cpu_map *map)
> >  {
> > -	int i, max = -1;
> > -
> > -	for (i = 0; i < map->nr; i++) {
> > -		if (map->map[i] > max)
> > -			max = map->map[i];
> > -	}
> > -
> > -	return max;
> > +	if (map->nr > 0)
> > +		return map->map[map->nr-1];
> > +	else
> > +		return -1;
> 
> Applying, but adding spaces around the '-',

I ended up with this, ok?

+++ b/tools/lib/perf/cpumap.c
@@ -282,10 +282,8 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)

 int perf_cpu_map__max(struct perf_cpu_map *map)
 {
-       if (map->nr > 0)
-               return map->map[map->nr-1];
-       else
-               return -1;
+       // cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
+       return map->nr > 0 ? map->map[map->nr - 1] : -1;
 }

