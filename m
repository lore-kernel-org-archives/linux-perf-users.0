Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D03EC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545F06102A
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhHaTmY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234715AbhHaTmV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:42:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09DD060F6C;
        Tue, 31 Aug 2021 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438886;
        bh=Q/h/rcc7Azc7x48LlJctFK4Yk9KlVRAwRYtEyT2GKVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acTIp6JqMSQqh/gLADlqOjJVw/uAm/cbra626tqWnkrhMK8idIn9lu3jmD3MwAooP
         gfngHiPFc+20P0ilC0lYES1zQMOtofGInvEdsozcC+KeKggrUHepI0vSoTO8qsqxQl
         FjDckiSmDp3VMBtS6VAC38e2eN/qq/F+sblYLKmve5FRNkr6ygdNpx8vqFpRKMswZ3
         wEt/qaT7YeJo6C0e2iCPR/9Es8Yx3FMa81nMSplYkAf8JYOobhuw8ibekPkSuwfXz+
         E+n6wdmJYWNVEweyp+XLEav6EYiqnfFApTps4OwLGaexCdowz7vm6vh7uy2DlZK7Uv
         DAwmpWJTDv6+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 939CF4007E; Tue, 31 Aug 2021 16:41:23 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:41:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 20/37] perf evsel: separate rlimit increase from
 evsel__open_cpu
Message-ID: <YS6F46/ONZzCWFnT@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <2f256de8ec37b9809a5cef73c2fa7bce416af5d3.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f256de8ec37b9809a5cef73c2fa7bce416af5d3.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:26AM +0200, Riccardo Mancini escreveu:
> This is a preparatory patch for the following patches with the goal to
> separate from evlist__open_cpu the actual opening (which could be
> performed in parallel), from the existing fallback mechanisms, which
> should be handled sequentially.
> 
> This patch separates the rlimit increase from evsel__open_cpu.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 50 ++++++++++++++++++++++++-----------------
>  tools/perf/util/evsel.h |  3 +++
>  2 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index c393bd992322d925..916930ea31450265 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1931,13 +1931,40 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  	}
>  }
>  
> +bool evsel__increase_rlimit(enum rlimit_action *set_rlimit)
> +{
> +	int old_errno;
> +	struct rlimit l;
> +
> +	if (*set_rlimit < INCREASED_MAX) {
> +

The above blank line is not needed
> +		old_errno = errno;

And here it should be used, I'm recycling it for you :-)

> +		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
> +			if (*set_rlimit == NO_CHANGE)
> +				l.rlim_cur = l.rlim_max;
> +			else {

Also when the else clause has {}, the if should have it too, I'm fixing
it.

I see that you just moved things around, but then this is a good time to
do these cosmetic changes.

Applying.

- Arnaldo

> +				l.rlim_cur = l.rlim_max + 1000;
> +				l.rlim_max = l.rlim_cur;
> +			}
> +			if (setrlimit(RLIMIT_NOFILE, &l) == 0) {
> +				(*set_rlimit) += 1;
> +				errno = old_errno;
> +				return true;
> +			}
> +		}
> +		errno = old_errno;
> +	}
> +
> +	return false;
> +}
> +
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads,
>  		int start_cpu, int end_cpu)
>  {
>  	int cpu, thread, nthreads;
>  	int pid = -1, err, old_errno;
> -	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
> +	enum rlimit_action set_rlimit = NO_CHANGE;
>  
>  	err = __evsel__prepare_open(evsel, cpus, threads);
>  	if (err)
> @@ -2046,25 +2073,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	 * perf stat needs between 5 and 22 fds per CPU. When we run out
>  	 * of them try to increase the limits.
>  	 */
> -	if (err == -EMFILE && set_rlimit < INCREASED_MAX) {
> -		struct rlimit l;
> -
> -		old_errno = errno;
> -		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
> -			if (set_rlimit == NO_CHANGE)
> -				l.rlim_cur = l.rlim_max;
> -			else {
> -				l.rlim_cur = l.rlim_max + 1000;
> -				l.rlim_max = l.rlim_cur;
> -			}
> -			if (setrlimit(RLIMIT_NOFILE, &l) == 0) {
> -				set_rlimit++;
> -				errno = old_errno;
> -				goto retry_open;
> -			}
> -		}
> -		errno = old_errno;
> -	}
> +	if (err == -EMFILE && evsel__increase_rlimit(&set_rlimit))
> +		goto retry_open;
>  
>  	if (err != -EINVAL || cpu > 0 || thread > 0)
>  		goto out_close;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a83fb7f69b1ead73..bf9abd9a5cbf9852 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -290,6 +290,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads);
>  bool evsel__detect_missing_features(struct evsel *evsel);
>  
> +enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
> +bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
> +
>  struct perf_sample;
>  
>  void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
> -- 
> 2.31.1

-- 

- Arnaldo
