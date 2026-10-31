Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793426955;
	b=o0Rdeztiq1mrkinV9bhnr49m4+9b5C0XUvdz53ogykNjvcPm54KTBeP9LWdntEJmMA/N
	 H9v+PZB6J8+5olnyBIQJUQCNMHDc5Ud18JW7zUq2Wgdp8RFkH9OSELJeGixRX3RF1/6TY
	 YFC9ordswM0i6VHYdnLI97CHslvevroKScQ5bC4e2/8h8s6nJCk+BuVWbxicx/yk+oIDu
	 fjcwTsKAitEjnQBRZGbvHRHTCbRVSEH2Pmte6Mgd6cYrrsrlG63Xbg0rohvBOJqBvtl3c
	 LuLw/IOKvCuq5f8+R9i3caeMRCrtvcrMDvyqjUWb9zKSjkNz66X3ReS4bF/MJZ6ujnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W9cmpLHdgetBFbDQCZYa5zQdrjStin80VjEDZl9jFyE=;
	b=okyYUUw6sk2KkB1POBp0W5OCSCvp7Uc7Bpp9qvgmMCCnB0GsSHZDCLsOf/QIaPJ26Qoc
	 MASs1XkUueKgGj2ryb2aFc4XC/6FTfw3HxfGOdKvt6pk8RE56ZymqZYutWRqS2REY6QPK
	 yeAdhttCijAxQC1z2p7wniCWdBpd8gEnLua/ch6xI7jJ0NqW9qpmVY5MGy1OwPmnzS5fx
	 MwkOJ5QfkK1PIwWt7b9yU6AAC1o9rljDDyY8goxKZu4b8lW2dfJ7CaHpQ/CnpFIclk1t0
	 LkPBQvXzGsAabZUGXslKwMlRgq3xG+H8vsJ4IiQ1qxXz35pN1pSpOczZ/JbVEHGiZgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzxIrEZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61E606A31A;
	Sat, 31 Oct 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzxIrEZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B751F000C1;
	Sat, 31 Oct 2026 06:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793426954;
	bh=W9cmpLHdgetBFbDQCZYa5zQdrjStin80VjEDZl9jFyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dzxIrEZmdMq707FF96Tuazy28fN8HjOmgYpgCwE4ixWeMB37PT5XIxLt8GmuxXL78
	 bomiHdktLE1ft3JVy1LpNTT3IT3HJsXvjhoDfCJZVbC1ROFzdUeFL1MfbZwyQ6Mg0G
	 bv0IMnpDSfpE34LwV+hqzXpgMUrko/ozWMGUQQ2TYTeHASrvempSvDu9g2U7OazY0r
	 cTeVgSKv+7CnePFL3bXVEcrGNvhlL3MN/cHtctmSEwqdx8hc0B7KBYnGsfGqUu1cLu
	 ha8yzK07DsKLgJNVBfO6IMPuFXhnJvow5sbWrBJteXvw4SVwCCwSxGDST/ipa3rUCK
	 x1Myr8ObJEEtg==
Date: Fri, 30 Oct 2026 23:09:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] perf annotate-data: Show event name in the data-type
 title
Message-ID: <auWGB-ONmDMktvRB@z2>
References: <20261029071510.460873-1-wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029071510.460873-1-wutengda@huaweicloud.com>

On Thu, Oct 29, 2026 at 07:15:10AM +0000, Tengda Wu wrote:
> The same data type can be annotated for multiple sampling events, in
> which case the data-type header is printed once per event.  But the
> header only shows the type name and the sample count, so several
> identical-looking headers are emitted and the user cannot tell which
> event each of them corresponds to. E.g.
> 
>   $ perf annotate --data-type=page --stdio --itrace=f
>   Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
>   ============================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>       9.95          0        0x8      long unsigned int   flags;
> 
>   Annotate type: 'struct page' in [kernel.kallsyms] (59480 samples):
>   ============================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>      10.15          0        0x8      long unsigned int   flags;
> 
> Add the event name to the data-type title in both the TUI browser and
> the stdio output, so each header can be attributed to its event.  For
> group events, use evsel__group_desc() to print the group description
> instead of the leader's name, so the whole group is identified.
> 
> While at it, size the underline in the stdio output dynamically based
> on the length of the header line instead of using a fixed-width string,
> so it keeps matching the header as the text grows.
> 
> Result:
> 
>   $ perf annotate --data-type=page --stdio --itrace=f
>   Annotate type: 'struct page' in [kernel.kallsyms] for l1d-miss (59208 samples):
>   ===============================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>       9.95          0        0x8      long unsigned int   flags;
> 
>   Annotate type: 'struct page' in [kernel.kallsyms] for l1d-access (59480 samples):
>   =================================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>      10.15          0        0x8      long unsigned int   flags;
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/ui/browsers/annotate-data.c | 14 +++++++++++---
>  tools/perf/util/annotate-data.c        | 15 ++++++++++++---
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index a15608f6ee53..0f778788df4a 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -340,11 +340,19 @@ static int browser__show(struct ui_browser *uib)
>  	struct hist_entry *he = uib->priv;
>  	struct annotated_data_type *adt = he->mem_type;
>  	struct annotated_data_browser *browser = get_browser(uib);
> +	struct evsel *evsel = hists_to_evsel(he->hists);
>  	const char *help = "Press 'h' for help on key bindings";
> -	char title[256];
> +	const char *evsel_name = evsel__name(evsel);
> +	char buf[512];
> +	char title[sizeof(buf) + 256];
> +
> +	if (evsel__is_group_event(evsel)) {
> +		evsel__group_desc(evsel, buf, sizeof(buf));
> +		evsel_name = buf;
> +	}
>  
> -	snprintf(title, sizeof(title), "Annotate type: '%s' (%d samples)",
> -		 adt->self.type_name, he->stat.nr_events);
> +	snprintf(title, sizeof(title), "Annotate type: '%s' for %s (%d samples)",
> +		 adt->self.type_name, evsel_name, he->stat.nr_events);
>  
>  	if (ui_browser__show(uib, title, help) < 0)
>  		return -1;
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index b3de1ca688a2..25e3169ea8ad 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -2149,16 +2149,23 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
>  	int nr_samples = he->stat.nr_events;
>  	int width = 7;
>  	const char *val_hdr = "Percent";
> +	const char *evsel_name = evsel__name(evsel);
> +	char buf[512];
> +	int len;
>  
>  	if (evsel__is_group_event(evsel)) {
>  		struct hist_entry *pair;
>  
>  		list_for_each_entry(pair, &he->pairs.head, pairs.node)
>  			nr_samples += pair->stat.nr_events;
> +
> +		evsel__group_desc(evsel, buf, sizeof(buf));
> +		evsel_name = buf;
>  	}
>  
> -	printf("Annotate type: '%s' in %s (%d samples):\n",
> -	       he->mem_type->self.type_name, dso__name(dso), nr_samples);
> +	len = printf("Annotate type: '%s' in %s for %s (%d samples):\n",
> +		     he->mem_type->self.type_name, dso__name(dso), evsel_name,
> +		     nr_samples);
>  
>  	if (evsel__is_group_event(evsel)) {
>  		struct evsel *pos;
> @@ -2183,7 +2190,9 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
>  		val_hdr = "Samples";
>  	}
>  
> -	printf("============================================================================\n");
> +	while (len-- > 1)
> +		putchar('=');
> +	putchar('\n');
>  	printf("%*s %10s %10s  %s\n", (width + 1) * nr_members, val_hdr,
>  	       "offset", "size", "field");
>  }
> 
> base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
> -- 
> 2.34.1
> 
