From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/4] Replace printf with fprintf for all the output
 functions
Date: Fri, 22 Sep 2017 11:03:04 +0200
Message-ID: <20170922090304.GD15856@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-5-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505714122-39141-5-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:22PM +0800, yuzhoujian wrote:

SNIP

>  static void process_event(struct perf_script *script,
> @@ -1389,21 +1389,30 @@ static void process_event(struct perf_script *script,
>  	struct perf_event_attr *attr = &evsel->attr;
>  	unsigned int type = output_type(attr->type);
>  
> +	const char *evname;
> +	char *file_name;
>  	if (output[type].fields == 0)
>  		return;
>  
> +	evname = perf_evsel__name(evsel);
> +	if (script->tool.per_event_dump == true) {
> +		if (asprintf(&file_name, "%s%s", evname, ".stack") < 0)

what's the 'stack' suffix for? It's text dump, should we use .txt?
Also I think it should be more than 'cycles.stack', more like:

  <ORIGINAL PERF DATA FILE NAME>-script-dump-cycles.txt

or something like this

Arnaldo, thoughts?

thanks,
jirka
