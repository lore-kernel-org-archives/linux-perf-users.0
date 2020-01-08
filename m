From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date: Wed, 8 Jan 2020 23:01:03 +0100
Message-ID: <20200108220103.GB12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-5-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-5-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:

SNIP

> +	while (*p != NULL) {
> +		parent = *p;
> +		cgrp = rb_entry(parent, struct cgroup, node);
> +
> +		if (cgrp->id == id)
> +			return cgrp;
> +
> +		if (cgrp->id < id)
> +			p = &(*p)->rb_left;
> +		else
> +			p = &(*p)->rb_right;
> +	}
> +
> +	cgrp = malloc(sizeof(*cgrp));
> +	if (cgrp == NULL)
> +		return NULL;
> +
> +	cgrp->name = strdup(path);
> +	if (cgrp->name == NULL) {
> +		free(cgrp);
> +		return NULL;
> +	}
> +
> +	cgrp->fd = -1;
> +	cgrp->id = id;
> +	refcount_set(&cgrp->refcnt, 1);
> +
> +	rb_link_node(&cgrp->node, parent, p);
> +	rb_insert_color(&cgrp->node, &cgroup_tree);
> +
> +	return cgrp;
> +}
> +
> +struct cgroup *cgroup__find_by_path(const char *path)
> +{
> +	struct rb_node *node;
> +
> +	node = rb_first(&cgroup_tree);
> +	while (node) {
> +		struct cgroup *cgrp = rb_entry(node, struct cgroup, node);
> +
> +		if (!strcmp(cgrp->name, path))
> +			return cgrp;

you have it sorted on ids, but only search by path,
why don't we sort it on path right away?

jirka
