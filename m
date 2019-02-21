From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf hist: fix memory leak if histogram entry is reused
Date: Thu, 21 Feb 2019 13:39:09 +0100
Message-ID: <20190221123909.GG10990@krava>
References: <20190221122306.1511-1-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221122306.1511-1-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 21, 2019 at 01:23:06PM +0100, Jonas Rabenstein wrote:
> In __hists__add_entry the srcline of the addr_location is duplicated
> for the hist_entry. If hists__findnew_entry returns an already existing
> hist_entry the srcline has to be freed again as no further reference to
> that duplicated srcline would exists anymore.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  tools/perf/util/hist.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 8aad8330e392..25b8dbdbbe87 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -623,6 +623,9 @@ __hists__add_entry(struct hists *hists,
>  		.ops = ops,
>  	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
>  
> +	if (he && he->srcline != entry.srcline)
> +		free(entry.srcline);
> +
>  	if (!hists->has_callchains && he && he->callchain_size != 0)
>  		hists->has_callchains = true;
>  	return he;

nice, do we have similar issue in here?

jirka


---
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 216388003dea..e65e6822c848 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -966,7 +966,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			.map = al->map,
 			.sym = al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = al->srcline,
 		.parent = iter->parent,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
