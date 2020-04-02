From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 5/5] perf synthetic events: Remove use of sscanf from
 /proc reading
Date: Thu, 2 Apr 2020 15:41:03 +0200
Message-ID: <20200402134103.GJ2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-6-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-6-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:45PM -0700, Ian Rogers wrote:

SNIP

> @@ -279,9 +353,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       struct machine *machine,
>  				       bool mmap_data)
>  {
> -	FILE *fp;
>  	unsigned long long t;
>  	char bf[BUFSIZ];
> +	struct io io;
>  	bool truncation = false;
>  	unsigned long long timeout = proc_map_timeout * 1000000ULL;
>  	int rc = 0;
> @@ -294,28 +368,39 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	snprintf(bf, sizeof(bf), "%s/proc/%d/task/%d/maps",
>  		machine->root_dir, pid, pid);
>  
> -	fp = fopen(bf, "r");
> -	if (fp == NULL) {
> +	io.fd = open(bf, O_RDONLY, 0);
> +	if (io.fd < 0) {
>  		/*
>  		 * We raced with a task exiting - just return:
>  		 */
>  		pr_debug("couldn't open %s\n", bf);
>  		return -1;
>  	}
> +	init_io(&io, io.fd, bf, sizeof(bf));
>  
>  	event->header.type = PERF_RECORD_MMAP2;
>  	t = rdclock();
>  
> -	while (1) {
> -		char prot[5];
> -		char execname[PATH_MAX];
> -		char anonstr[] = "//anon";
> -		unsigned int ino;
> +	while (!io.eof) {
> +		static const char anonstr[] = "//anon";
>  		size_t size;
> -		ssize_t n;
>  
> -		if (fgets(bf, sizeof(bf), fp) == NULL)
> -			break;
> +		/* ensure null termination since stack will be reused. */
> +		strcpy(event->mmap2.filename, "");

could you just do 'event->mmap2.filename[0] = 0x0' instad ?

jirka

> +
> +		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
> +		if (!read_proc_maps_line(&io,
> +					&event->mmap2.start,
> +					&event->mmap2.len,
> +					&event->mmap2.prot,
> +					&event->mmap2.flags,
> +					&event->mmap2.pgoff,
> +					&event->mmap2.maj,
> +					&event->mmap2.min,
> +					&event->mmap2.ino,
> +					sizeof(event->mmap2.filename),
> +					event->mmap2.filename))
> +			continue;
>  

SNIP
