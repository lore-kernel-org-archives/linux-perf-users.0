Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F61FC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 12:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEVMMf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjEVMMc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 08:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145AB6
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIdRgPc86wRs8rRQezIuaScS15xj5tHdL0njdi6vrks=;
        b=N16dhJ4kNoW+ZPldgtXyh48VVrV1i4815yGmrvt14sECuRRn8s7VFmJlRCyw8XVhuP6V+F
        zlk++3RYEKg8MKUqZxuNFXHC+j6xVbZoTjLUzUnR01Cmaun4pqngXo+VfTB9gxZ8RgxkM8
        SkGt/BUZlZtosaTMAJ6tZ6AkGF0i4ys=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343--3_4xFoVMpGIad36fGaklA-1; Mon, 22 May 2023 08:11:40 -0400
X-MC-Unique: -3_4xFoVMpGIad36fGaklA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 583A53C02549;
        Mon, 22 May 2023 12:11:40 +0000 (UTC)
Received: from Diego (unknown [10.39.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F1BAC54F80;
        Mon, 22 May 2023 12:11:38 +0000 (UTC)
Date:   Mon, 22 May 2023 14:11:36 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     acme@kernel.org
cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com, irogers@google.com
Subject: Re: [PATCH 1/2] perf stat: Fix JSON metric printout for multiple
 metrics per line
In-Reply-To: <20230120134039.17788-2-mpetlan@redhat.com>
Message-ID: <alpine.LRH.2.20.2305221405430.13334@Diego>
References: <20230120134039.17788-1-mpetlan@redhat.com> <20230120134039.17788-2-mpetlan@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Ian and Arnaldo,

I've recently got back to the JSON test failures. In January, I post two
patches within a patchset. I see that Ian has updated the testcase code,
so the second patch is probably no more needed. However I don't see this
one applied upstream yet, although it seemed on the list, it had got some
acks. Has it been forgotten somehow?

To remind, since the JSON printer engine wasn't ready to print multiple
metrics per line, the JSON output got screwed up in that situation. The
situation happened on some SPR CPUs, where Top-Down metrics are supported.

The patch below fixes the printer to handle this situation correctly.

I remember someone saying that the whole printer engine needs to be
refactored some day, but I'd think that before that happens, it'd be
nice to have it fixed...

What do you think?

Regards,
Michael

On Fri, 20 Jan 2023, Michael Petlan wrote:
> JSON printing engine used to always print metric (even when there should
> be none and other engines (std, csv) would not print it) and the metric
> used to always close the line by printing a closing curly bracket.
> 
> This caused invalid JSON output being generated for top-down metrics,
> when multiple metrics are printed on a single line, so the broken output
> might have looked like:
> 
>   ... "metric-value" : 15.564203, "metric-unit" : \
>   "Memory Bound"}"metric-value" : 14.007787, "metric-unit" : "Core Bound"}
> 
> To fix it, print always the separating comma BEFORE the key:value pairs
> and close the line outside of the JSON metric printing routine.
> 
> Fixes: df936cadfb58 ("perf stat: Add JSON output option")
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/util/stat-display.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 8bd8b0142630..8f80f6b566d0 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -86,7 +86,7 @@ static void print_running_json(struct perf_stat_config *config, u64 run, u64 ena
>  
>  	if (run != ena)
>  		enabled_percent = 100 * run / ena;
> -	fprintf(config->output, "\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f, ",
> +	fprintf(config->output, ", \"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f",
>  		run, enabled_percent);
>  }
>  
> @@ -121,7 +121,7 @@ static void print_noise_pct_csv(struct perf_stat_config *config,
>  static void print_noise_pct_json(struct perf_stat_config *config,
>  				 double pct)
>  {
> -	fprintf(config->output, "\"variance\" : %.2f, ", pct);
> +	fprintf(config->output, ", \"variance\" : %.2f", pct);
>  }
>  
>  static void print_noise_pct(struct perf_stat_config *config,
> @@ -165,7 +165,7 @@ static void print_cgroup_csv(struct perf_stat_config *config, const char *cgrp_n
>  
>  static void print_cgroup_json(struct perf_stat_config *config, const char *cgrp_name)
>  {
> -	fprintf(config->output, "\"cgroup\" : \"%s\", ", cgrp_name);
> +	fprintf(config->output, ", \"cgroup\" : \"%s\"", cgrp_name);
>  }
>  
>  static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
> @@ -431,10 +431,11 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
>  	struct outstate *os = ctx;
>  	FILE *out = os->fh;
>  
> -	fprintf(out, "\"metric-value\" : %f, ", val);
> -	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
> -	if (!config->metric_only)
> -		fprintf(out, "}");
> +	if (unit == NULL || fmt == NULL)
> +		return;
> +
> +	fprintf(out, ", \"metric-value\" : %f", val);
> +	fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
>  }
>  
>  static void new_line_json(struct perf_stat_config *config, void *ctx)
> @@ -623,14 +624,14 @@ static void print_counter_value_json(struct perf_stat_config *config,
>  	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
>  
>  	if (ok)
> -		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
> +		fprintf(output, "\"counter-value\" : \"%f\"", avg);
>  	else
> -		fprintf(output, "\"counter-value\" : \"%s\", ", bad_count);
> +		fprintf(output, "\"counter-value\" : \"%s\"", bad_count);
>  
>  	if (evsel->unit)
> -		fprintf(output, "\"unit\" : \"%s\", ", evsel->unit);
> +		fprintf(output, ", \"unit\" : \"%s\"", evsel->unit);
>  
> -	fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
> +	fprintf(output, ", \"event\" : \"%s\"", evsel__name(evsel));
>  }
>  
>  static void print_counter_value(struct perf_stat_config *config,
> @@ -835,8 +836,11 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>  
>  	printout(config, os, uval, run, ena, avg, s);
>  
> -	if (!metric_only)
> +	if (!metric_only) {
> +		if (config->json_output)
> +			fputc('}', output);
>  		fputc('\n', output);
> +	}
>  }
>  
>  static void print_metric_begin(struct perf_stat_config *config,
> -- 
> 2.18.4
> 
> 

