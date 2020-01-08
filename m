From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date: Wed, 8 Jan 2020 23:21:56 +0100
Message-ID: <20200108222156.GE12995@krava>
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

> +	closedir(d);
> +	return ret;
> +}
> +
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	union perf_event event;
> +	char *cgrp_root;
> +	size_t mount_len;  /* length of mount point in the path */
> +	int ret = -1;
> +
> +	cgrp_root = malloc(PATH_MAX);
> +	if (cgrp_root == NULL)
> +		return -1;
> +

hum, we normally use bufs with PATH_MAX size on stack..
is there some reason to use heap in here?

jirka


> +	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX) < 0) {
> +		pr_debug("cannot find cgroup mount point\n");
> +		goto out;
> +	}
> +
> +	mount_len = strlen(cgrp_root);
> +	/* make sure the path starts with a slash (after mount point) */
> +	strcat(cgrp_root, "/");
> +
> +	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
> +					 process, machine) < 0)
> +		goto out;
> +
> +	ret = 0;
> +
> +out:
> +	free(cgrp_root);
> +
> +	return ret;
> +}
> +

SNIP
