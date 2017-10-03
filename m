From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 4/4] Make all print functions receive the fp argument,
 and opens a dump file in process_event.
Date: Tue, 3 Oct 2017 12:44:26 +0200
Message-ID: <20171003104426.GE13755@krava>
References: <1506408797-23657-1-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbdJCKoa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Oct 2017 06:44:30 -0400
Content-Disposition: inline
In-Reply-To: <1506408797-23657-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 26, 2017 at 02:53:17PM +0800, yuzhoujian wrote:

SNIP

> -	fprint_sample_start(sample, thread, evsel, stdout);
> +	/* the dump file name is <ORIGINAL PERF DATA FILE NAME>-script-dump-<EVENT NAME>.txt */
> +	evname = perf_evsel__name(evsel);
> +	if (script->tool.per_event_dump) {
> +		if (asprintf(&filename, "%s%s%s%s", file_name, "-script-dump-", evname, ".txt") < 0)
> +			filename = NULL;
> +		fp = fopen(filename, "a+");
> +		if (!fp)
> +			return;
> +		free(filename);
> +	}
> +	fprint_sample_start(sample, thread, evsel, fp);
>  

SNIP

>  
>  	if (PRINT_FIELD(PHYS_ADDR))
> -		fprintf(stdout, "%16" PRIx64, sample->phys_addr);
> -	fprintf(stdout, "\n");
> +		fprintf(fp, "%16" PRIx64, sample->phys_addr);
> +	fprintf(fp, "\n");
> +	if (script->tool.per_event_dump)
> +		fclose(fp);

so you open and close the file for each sample.. I think
we should store the FILE* in perf_evsel::priv

open it at the first time sample/event is processed
and close at the end of the perf script

jirka
