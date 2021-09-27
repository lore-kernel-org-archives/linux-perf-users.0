Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48143C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 12:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4A76108E
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 12:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhI0MoY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhI0MoY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 08:44:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C4BB60F4F;
        Mon, 27 Sep 2021 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632746566;
        bh=gVgGt6/KOLoXbOVP69wDG4+s3eLBYuFC4kTa6m/5UO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F74IVW6GGDacVVhAlVJdzken7CZDQ9TqaezNZtgGIE0ds1INNBFEOhDK/9qZOoqE1
         v8Z+wEX+lRfUUIIn8eGVl1KHZ7GO8U9vZf0FlHyykb4Xjk3VgcxYpZ/ml9TX4a31Ah
         pJNir7Xyi6o9IHXZp3C6qFtIlnPZumuSMdrAWbC9YVetx2L8Rm3k50YYe9Wi7v4OaR
         sdKiFJuFvXZBsjrU4cTwQFFV2VvXne44Lywx9gvOVGeQ7FZ036ew31McZD8KWuVv6Y
         vVz8O2YuxjRhxLCwZFVrvxCB0pAxioqXCn634YmmsJKvzBLCC+vV0RLpPDlsnpCTsW
         1tePHQiV1xKkg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2722D410A1; Mon, 27 Sep 2021 09:42:44 -0300 (-03)
Date:   Mon, 27 Sep 2021 09:42:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf iostat: Fix Segmentation fault from NULL
 'struct perf_counts_values *'
Message-ID: <YVG8RM+ofI25Rk2r@kernel.org>
References: <20210927081115.39568-1-likexu@tencent.com>
 <20210927081115.39568-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927081115.39568-2-likexu@tencent.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 27, 2021 at 04:11:15PM +0800, Like Xu escreveu:
> From: Like Xu <likexu@tencent.com>
> 
> If the perf-iostat user specifies two or more iio_root_ports and
> also specifies the cpu(s) by -C which is not *connected to all*
> the above iio ports, the iostat_print_metric() will run into trouble:
> 
> For example:
> 
>  $ perf iostat list
>  S0-uncore_iio_0<0000:16>
>  S1-uncore_iio_0<0000:97> # <--- CPU 1 is located in the socket S0
> 
>  $ perf iostat 0000:16,0000:97 -C 1 -- ls
>  port 	Inbound Read(MB)	Inbound Write(MB)	Outbound Read(MB)	Outbound
>  Write(MB) ../perf-iostat: line 12: 104418 Segmentation fault
>  (core dumped) perf stat --iostat$DELIMITER$*
> 
> The core-dump stack says, in the above corner case, the returned
> (struct perf_counts_values *) count will be NULL, and the caller
> iostat_print_metric() apparently doesn't not handle this case.
> 
>  433	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
>  434
>  435	if (count->run && count->ena) {
>  (gdb) p count
>  $1 = (struct perf_counts_values *) 0x0
> 
> The deeper reason is that there are actually no statistics from the user
> specified pair "iostat 0000:X, -C (disconnected) Y ", but let's fix it with
> minimum cost by adding a NULL check in the user space.

Added:

Fixes: f9ed693e8bc0e7de ("perf stat: Enable iostat mode for x86 platforms")

Please do that next time,

- Arnaldo
 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/perf/arch/x86/util/iostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index eeafe97b8105..792cd75ade33 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -432,7 +432,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>  	u8 die = ((struct iio_root_port *)evsel->priv)->die;
>  	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
>  
> -	if (count->run && count->ena) {
> +	if (count && count->run && count->ena) {
>  		if (evsel->prev_raw_counts && !out->force_header) {
>  			struct perf_counts_values *prev_count =
>  				perf_counts(evsel->prev_raw_counts, die, 0);
> -- 
> 2.32.0

-- 

- Arnaldo
