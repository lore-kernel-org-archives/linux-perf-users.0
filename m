From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 07/10] perf record: Support synthesizing cgroup events
Date: Fri, 6 Mar 2020 15:14:04 +0100
Message-ID: <20200306141404.GC290743@krava>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <20200224043749.69466-8-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224043749.69466-8-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 24, 2020 at 01:37:46PM +0900, Namhyung Kim wrote:

SNIP

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
> +		/* any sane path should be less than PATH_MAX */
> +		if (strlen(path) + strlen(dent->d_name) + 1 >= PATH_MAX)
> +			continue;
> +
> +		if (path[pos - 1] != '/')
> +			strcat(path, "/");
> +		strcat(path, dent->d_name);
> +
> +		ret = perf_event__walk_cgroup_tree(tool, event, path,
> +						   mount_len, process, machine);
> +		if (ret < 0)
> +			break;
> +
> +		path[pos] = '\0';
> +	}
> +
> +	closedir(d);
> +	return ret;
> +}
> +
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	union perf_event event;
> +	char cgrp_root[PATH_MAX];
> +	size_t mount_len;  /* length of mount point in the path */
> +
> +	if (cgroupfs__mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
> +		pr_debug("cannot find cgroup mount point\n");
> +		return -1;
> +	}
> +
> +	mount_len = strlen(cgrp_root);
> +	/* make sure the path starts with a slash (after mount point) */
> +	strcat(cgrp_root, "/");

the code above checks on this and seems to add '/' if needed,
is this strcat necessary?

jirka
