Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F3C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D9D61039
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhJHOsB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 10:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242503AbhJHOsA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 10:48:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C35660F58;
        Fri,  8 Oct 2021 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633704365;
        bh=KLXzbMi+/trg1z5YXY89GWNJjA4g33FvXuFqv1Rd9bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddXSJriJsdR6ETVhPhObOHdH7hjFweaOhrXLCWJulakA0+WToKl7r7EerGzIVXVbI
         Vt6k9vmXfP9F+Ne8ylZ0s0JYDsNlfu4+M49FqmDSLdejtiku+PiT9MuVZM4EJwx8Fk
         5rAc3nDFyMtBgmlh4py0I4Dyl3iEFeNv/I2j1yvDAkUB25oOJVnHUFXsIusCwpHpNm
         E/RvcXGueyiwVdp9RJsoxbMFPWcrBXEdVqX0qy3dWKAztgRjbe6NCdSG47MoL3XBl8
         WizvTt0hs/0scUlhne580XwLweqETUe5D4ipVixYMGMsuAgraxEjjMzOqRWKIZ4fUO
         atOFPRRye4P1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44465410A1; Fri,  8 Oct 2021 11:46:02 -0300 (-03)
Date:   Fri, 8 Oct 2021 11:46:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 36/37] perf test/evlist-open-close: use inline
 func to convert timeval to usec
Message-ID: <YWBZqlg3hgsIWq+q@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <b95035ec4a125355be8ea843f7275c4580da6398.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95035ec4a125355be8ea843f7275c4580da6398.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:42AM +0200, Riccardo Mancini escreveu:
> This patch introduces a new inline function to convert a timeval to
> usec.
> This function will be used also in the next patch.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/bench/evlist-open-close.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> index c18aa85725281795..00d0aef564f80d44 100644
> --- a/tools/perf/bench/evlist-open-close.c
> +++ b/tools/perf/bench/evlist-open-close.c
> @@ -26,6 +26,11 @@ static int iterations = 100;
>  static int nr_events = 1;
>  static const char *event_string = "dummy";
>  
> +static inline u64 timeval2usec(struct timeval *tv)
> +{
> +	return tv->tv_sec * USEC_PER_SEC + tv->tv_usec;
> +}
> +
>  static struct record_opts opts = {
>  	.sample_time	     = true,
>  	.mmap_pages	     = UINT_MAX,
> @@ -197,7 +202,7 @@ static int bench_evlist_open_close__run(char *evstr)
>  
>  		gettimeofday(&end, NULL);
>  		timersub(&end, &start, &diff);
> -		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +		runtime_us = timeval2usec(&diff);
>  		update_stats(&time_stats, runtime_us);
>  
>  		evlist__delete(evlist);
> -- 
> 2.31.1

-- 

- Arnaldo
