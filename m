Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DAC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 23:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhKWXiC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhKWXiB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 18:38:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9400B60FE6;
        Tue, 23 Nov 2021 23:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637710492;
        bh=47O5TjToz0WFowNe6yEwB8NggXB/1IyXNGQaOA02uJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+BMCa5F8mo86vQPn6+sf/yy3tOuK38qRNMkTK6ALN1CqbT1+QK1E5p2jOsNM0Inf
         Z0eqURYWggQBUv9dGwwgDaXh6ddQ2KqVh5z+g7PmlQXS6mcHMQU17NlmjCtbQXrRi1
         lUBEmeZJEhITfbG2CVrR3XC+j4ENEWDGVxFzjw7MpaCTG6BuGJrYqXkx5OP+gh6yXW
         3p0+PGsg3EjRZDi6FfnG1QeHg9cVem7TNbxkmvAWzObqwkVewHFXnS9WX5aFiobyYM
         rS5OcaPWbT48SEJfgUXCe0FDk1ppUvF8wVkmmxPhXZuhszrsmsjrBSZMOdFvHvMIVw
         z7TWcuqmTqC2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 772A640002; Tue, 23 Nov 2021 20:34:49 -0300 (-03)
Date:   Tue, 23 Nov 2021 20:34:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 2/3] perf tools: Fix SMT not detected with large core
 count
Message-ID: <YZ16mRRu7HZzUlYe@kernel.org>
References: <20211123224821.3258649-1-irogers@google.com>
 <20211123224821.3258649-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123224821.3258649-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 23, 2021 at 02:48:20PM -0800, Ian Rogers escreveu:
> sysfs__read_int returns 0 on success, and so the fast read path was
> always failing.

Please split this into two patches, the above part should be in one, and
the strtoull in another.

Also can't we just do as ./tools/perf/util/cputopo.c and use instead
core_cpus_list?

On a 5950x:

⬢[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu31/topology/core_cpus
80008000
⬢[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu31/topology/core_cpus_list
15,31
⬢[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu0/topology/core_cpus
00010001
⬢[acme@toolbox perf]$ cat /sys/devices/system/cpu/cpu0/topology/core_cpus_list
0,16
⬢[acme@toolbox perf]$

- Arnaldo

> strtoull can only read a 64-bit bitmap. On an AMD EPYC core_cpus may look
> like:
> 00000000,00000000,00000000,00000001,00000000,00000000,00000000,00000001
> and so the sibling wasn't spotted. Fix by writing a simple hweight string
> parser.
> 
> Fixes: bb629484d924 (perf tools: Simplify checking if SMT is active.)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/smt.c | 68 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 20bacd5972ad..2636be65305a 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -5,6 +5,56 @@
>  #include "api/fs/fs.h"
>  #include "smt.h"
>  
> +/**
> + * hweight_str - Returns the number of bits set in str. Stops at first non-hex
> + *	       or ',' character.
> + */
> +static int hweight_str(char *str)
> +{
> +	int result = 0;
> +
> +	while (*str) {
> +		switch (*str++) {
> +		case '0':
> +		case ',':
> +			break;
> +		case '1':
> +		case '2':
> +		case '4':
> +		case '8':
> +			result++;
> +			break;
> +		case '3':
> +		case '5':
> +		case '6':
> +		case '9':
> +		case 'a':
> +		case 'A':
> +		case 'c':
> +		case 'C':
> +			result += 2;
> +			break;
> +		case '7':
> +		case 'b':
> +		case 'B':
> +		case 'd':
> +		case 'D':
> +		case 'e':
> +		case 'E':
> +			result += 3;
> +			break;
> +		case 'f':
> +		case 'F':
> +			result += 4;
> +			break;
> +		default:
> +			goto done;
> +		}
> +	}
> +done:
> +	return result;
> +}
> +
>  int smt_on(void)
>  {
>  	static bool cached;
> @@ -15,9 +65,12 @@ int smt_on(void)
>  	if (cached)
>  		return cached_result;
>  
> -	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) > 0)
> -		goto done;
> +	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0) {
> +		cached = true;
> +		return cached_result;
> +	}
>  
> +	cached_result = 0;
>  	ncpu = sysconf(_SC_NPROCESSORS_CONF);
>  	for (cpu = 0; cpu < ncpu; cpu++) {
>  		unsigned long long siblings;
> @@ -35,18 +88,13 @@ int smt_on(void)
>  				continue;
>  		}
>  		/* Entry is hex, but does not have 0x, so need custom parser */
> -		siblings = strtoull(str, NULL, 16);
> +		siblings = hweight_str(str);
>  		free(str);
> -		if (hweight64(siblings) > 1) {
> +		if (siblings > 1) {
>  			cached_result = 1;
> -			cached = true;
>  			break;
>  		}
>  	}
> -	if (!cached) {
> -		cached_result = 0;
> -done:
> -		cached = true;
> -	}
> +	cached = true;
>  	return cached_result;
>  }
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog

-- 

- Arnaldo
