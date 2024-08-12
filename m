Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B581187855;
	Mon, 12 Aug 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478901; cv=none; b=SiIfWJ4abpmgywUuh9zj0QlFapWtr1efdpxjR+ZHXfaWyS5T3jx1zEGfchLNmfYW5YgtPV+AaO07Bu5/75/PNM3uDCcaCOz7sUeAylHMH9Fqxmh2DHkFOzHyLxOrZZzgw36sF+w58ZVK9+gez26C0K5uwd2lGfB05dWWZHczBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478901; c=relaxed/simple;
	bh=GEiZXX6SW2BlyQlzywZSCZ9k08V9/YyLuDdMNThbEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asHFxl9WvezqrgRp/TxpyPOJ1raZ8nMiE5PoZIXwZse5ey9MhI3EqkN9SEf70sPkUSV91ILXYioAP+olIXOGyDHzAWOVyyO0klXKRs7/TIgVbTOGahC11w8yXsC1OfpDLIdT8f5g7LwTNWnuVISwusGiw10cVwEZepdy39mJ83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp6nPAso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp6nPAso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B562C32782;
	Mon, 12 Aug 2024 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478901;
	bh=GEiZXX6SW2BlyQlzywZSCZ9k08V9/YyLuDdMNThbEMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pp6nPAsowoI+yZEtmKJSmLJbE8HRiUUWzDivUvauZHzmMS3Awm1n6piExOTogu+Ry
	 2CVFaXO7PHS6ZQ86LR1zlJh7aBSVbtsF1FLWzQ+76mwJUzofJa5tJLLGTHrOUeR/Wo
	 o+un1t0IQnyy3ZIafNLm5gAhZ7EuRtZyJuIOtepqh7LPVO1BmRYnBU9i100auwOfws
	 STP3Q6hBr9qGEyRh3kX3Nlya7v5T8M0fksHL//oxNr8uZzb643Afu4EH1fDo6MN1vo
	 Flg5A4YAozEQxi70m3+ayKLtBY1/+eB1nmZSTltc5QWKZGBPbiXTJWGhtl0rDkRHIz
	 979FkuXj3Vr3Q==
Date: Mon, 12 Aug 2024 13:08:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate-data: Fix a buffer overflow in TUI browser
Message-ID: <ZrozcZL1ganmoViy@x1>
References: <CA+JHD90ZChq4FFyrqVYE9RvK=K2sKoD6T5dyYknK=STST9_AEQ@mail.gmail.com>
 <20240810191502.1947959-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810191502.1947959-1-namhyung@kernel.org>

On Sat, Aug 10, 2024 at 12:15:02PM -0700, Namhyung Kim wrote:
> In get_member_overhead(), k is updated when it has a entry in the
> histogram.  But the entry->hists array is allocated with the number of
> evsel in the group.  So the k should be reset when it iterates the event
> using for_each_group_evsel(), otherwise it'd crash due to a buffer
> overflow.
> 
> Fixes: cb1898f58e0f ("perf annotate-data: Support --skip-empty option")

Thanks, applied to perf-tools-next,

- Arnaldo

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate-data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index c3db80a7589a..a937b55da736 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -46,11 +46,12 @@ static int get_member_overhead(struct annotated_data_type *adt,
>  	struct annotated_member *member = entry->data;
>  	int i, k;
>  
> -	for (i = 0, k = 0; i < member->size; i++) {
> +	for (i = 0; i < member->size; i++) {
>  		struct type_hist *h;
>  		struct evsel *evsel;
>  		int offset = member->offset + i;
>  
> +		k = 0;
>  		for_each_group_evsel(evsel, leader) {
>  			if (symbol_conf.skip_empty &&
>  			    evsel__hists(evsel)->stats.nr_samples == 0)
> -- 
> 2.46.0.76.ge559c4bf1a-goog
