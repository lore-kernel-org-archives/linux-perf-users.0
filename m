From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 4/4] Make all print functions receive the fp argument,
 and opens a dump file in process_event.
Date: Tue, 3 Oct 2017 12:43:27 +0200
Message-ID: <20171003104327.GB13755@krava>
References: <1506408797-23657-1-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506408797-23657-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Sep 26, 2017 at 02:53:17PM +0800, yuzhoujian wrote:

SNIP

> +		fprintf(fp, "%16" PRIx64, sample->phys_addr);
> +	fprintf(fp, "\n");
> +	if (script->tool.per_event_dump)
> +		fclose(fp);
>  }
>  
>  static struct scripting_ops	*scripting_ops;
> @@ -1574,6 +1589,7 @@ static int process_sample_event(struct perf_tool *tool,
>  {
>  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
>  	struct addr_location al;
> +	FILE *fp;
>  
>  	if (perf_time__skip_sample(&scr->ptime, sample->time))
>  		return 0;
> @@ -1601,10 +1617,11 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
>  		goto out_put;
>  
> +	fp = tool->per_event_dump ? per_event_dump_file : stdout;

I know you explained this already, but I still can't see this one
being set:

[jolsa@krava perf]$ grep -r per_event_dump_file builtin-script.c
static FILE                     *per_event_dump_file;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;
        fp = tool->per_event_dump ? per_event_dump_file : stdout;

I think we should use per evsel FILE pointers


jirka
