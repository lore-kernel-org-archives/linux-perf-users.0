From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 4/4] Make all print functions receive the fp argument,
 and opens a dump file in process_event.
Date: Tue, 3 Oct 2017 12:43:19 +0200
Message-ID: <20171003104319.GA13755@krava>
References: <1506408797-23657-1-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdJCKnX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Oct 2017 06:43:23 -0400
Content-Disposition: inline
In-Reply-To: <1506408797-23657-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 26, 2017 at 02:53:17PM +0800, yuzhoujian wrote:

SNIP

> -	perf_event__fprintf(event, stdout);
> +	fp = tool->per_event_dump ? per_event_dump_file : stdout;
> +	fprint_sample_start(sample, thread, evsel, fp);
> +	perf_event__fprintf(event, fp);
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2852,6 +2883,8 @@ int cmd_script(int argc, const char **argv)
>  	file.path = input_name;
>  	file.force = symbol_conf.force;
>  
> +	file_name = file.path ? file.path : "perf.data";

you don't need file_name variable, the data file name is
reachable from struct perf_script:

  perf_script::session::file

jirka
