From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH perf/core  19/22] perf: fix hists_evsel to release hists
Date: Wed, 9 Dec 2015 12:12:23 -0300
Message-ID: <20151209151223.GJ15864@kernel.org>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021129.10245.28710.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53328 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbbLIPMi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 10:12:38 -0500
Content-Disposition: inline
In-Reply-To: <20151209021129.10245.28710.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Wed, Dec 09, 2015 at 11:11:29AM +0900, Masami Hiramatsu escreveu:
> Since hists__init doesn't set the destructor of
> hists_evsel (which is an extended evsel structure),
> when hists_evsel is released, the extended part of
> the hists_evsel is not deleted (note that the
> hists_evsel object itself is freed).

This will help with 'perf report', that doesn't use the
hists->entries_in, top will need to drain that one too, but that can be
done in a follow up patch, after some more thinking, applying this
patch, thanks,

- Arnaldo
 
> This fixes it to add a destructor for hists__evsel
> and to set it up.
> 
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> ---
>  tools/perf/util/hist.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 6e8e0ee..565ea35 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1567,6 +1567,13 @@ static int hists_evsel__init(struct perf_evsel *evsel)
>  	return 0;
>  }
>  
> +static void hists_evsel__exit(struct perf_evsel *evsel)
> +{
> +	struct hists *hists = evsel__hists(evsel);
> +
> +	hists__delete_entries(hists);
> +}
> +
>  /*
>   * XXX We probably need a hists_evsel__exit() to free the hist_entries
>   * stored in the rbtree...
> @@ -1575,7 +1582,8 @@ static int hists_evsel__init(struct perf_evsel *evsel)
>  int hists__init(void)
>  {
>  	int err = perf_evsel__object_config(sizeof(struct hists_evsel),
> -					    hists_evsel__init, NULL);
> +					    hists_evsel__init,
> +					    hists_evsel__exit);
>  	if (err)
>  		fputs("FATAL ERROR: Couldn't setup hists class\n", stderr);
>  
