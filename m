From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date: Wed, 8 Jan 2020 23:18:33 +0100
Message-ID: <20200108221833.GD12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-7-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-7-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:

SNIP

> +	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
> +		pr_debug("process synth event failed\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
> +					union perf_event *event,
> +					char *path, size_t mount_len,
> +					perf_event__handler_t process,
> +					struct machine *machine)
> +{
> +	size_t pos = strlen(path);
> +	DIR *d;
> +	struct dirent *dent;
> +	int ret = 0;
> +
> +	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
> +					  process, machine) < 0)
> +		return -1;
> +
> +	d = opendir(path);
> +	if (d == NULL) {
> +		pr_debug("failed to open directory: %s\n", path);
> +		return -1;
> +	}
> +
> +	while ((dent = readdir(d)) != NULL) {
> +		if (dent->d_type != DT_DIR)
> +			continue;
> +		if (!strcmp(dent->d_name, ".") ||
> +		    !strcmp(dent->d_name, ".."))
> +			continue;
> +
> +		if (path[pos - 1] != '/')
> +			strcat(path, "/");
> +		strcat(path, dent->d_name);

shouldn't you also check for the max size of path in here?

jirka
