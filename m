From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/4] Makes all those related functions receive the FILE
 pointer
Date: Fri, 22 Sep 2017 11:03:12 +0200
Message-ID: <20170922090312.GE15856@krava>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuzhoujian <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Sep 18, 2017 at 01:55:20PM +0800, yuzhoujian wrote:

SNIP

>  out_put:
>  	addr_location__put(&al);
> @@ -1605,6 +1617,7 @@ static int process_comm_event(struct perf_tool *tool,
>  	struct perf_session *session = script->session;
>  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  	int ret = -1;
> +	FILE *fp;
>  
>  	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
>  	if (thread == NULL) {
> @@ -1621,8 +1634,9 @@ static int process_comm_event(struct perf_tool *tool,
>  		sample->tid = event->comm.tid;
>  		sample->pid = event->comm.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> -	perf_event__fprintf(event, stdout);
> +	fp = stdout;
> +	fprint_sample_start(sample, thread, evsel, fp);
> +	perf_event__fprintf(event, fp);

please make this simple 'adding fp argument to print functions'
change and just pass stdout in here ... and do the rest of changes
later on

thanks,
jirka
