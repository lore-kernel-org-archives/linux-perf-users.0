Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43B17C68;
	Wed, 29 Jan 2025 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738125776; cv=none; b=FPQ/o5qtRM5BjZzox104hQC3COYOgcPLY1RTu80UwJU95LeMYsGizsg6iazLDNWwPIRUezNvC7IV8y5Dl5zjya/NuLGjz2NyMDzv7vzZSciHcDE/5w6fIY3eEBBppLV31+cq9nbQSso3FRVLL8N6MaKzR1CatmE+jQg/HFajSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738125776; c=relaxed/simple;
	bh=H15iHNP5Km8nUrQl5M+DQ+siAQycfJUK2Qp3VSaudoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOMotVwngy/m86tiUnYBw+tWkpREt+mxhxWZMidGD4AcxtZoO6p1vPhrjRQC72B4YQmoos1sv6illpoCM4BeI6i+8RQDPBai+AAD0kGbo++22/hJ0sGECSRyR/8LjGUKnal9nslKOQY4bpiETpziYKtaYz+K0/eHKv/GFyC7LKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaxUvvLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaxUvvLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156EFC4CED3;
	Wed, 29 Jan 2025 04:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738125774;
	bh=H15iHNP5Km8nUrQl5M+DQ+siAQycfJUK2Qp3VSaudoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaxUvvLh4f8ud3+m5nFucR/VjTWHZ9ls0AVxCqdw4Z1wPLg5i7KjwyaI0ZM5LhAm+
	 nvWUi985NYCx4mYK9/fiOSMziFV9A20fO0NTnVqspBzlc7oI57e15vaaSxaGsTPFKW
	 hoqTjZUxduKVTiLKRNuXcDsAauCYUFqTtF3o/tAM38IBszu5Dj6X8+7JY4nnCCy+tR
	 K/6JVvQ/NuMi+Hc6enCy6C4Mf/lDvQC1VY2NRmNesSzlB7Ee/wT+QDFn9UyXXc2LP/
	 vy9jknKt4rEvYwPoMbCRggyqbNIUAhSVPfg8NEKknYaRfJjs8yauIFTA+aiiwgRwaf
	 qt9W05b0rLV3w==
Date: Tue, 28 Jan 2025 20:42:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 2/7] perf report: Add parallelism sort key
Message-ID: <Z5mxzGdXJ27O4x-Y@google.com>
References: <cover.1737971364.git.dvyukov@google.com>
 <3e52ed435e0ce98e1108b172fdcadc4749a25c98.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e52ed435e0ce98e1108b172fdcadc4749a25c98.1737971364.git.dvyukov@google.com>

On Mon, Jan 27, 2025 at 10:58:49AM +0100, Dmitry Vyukov wrote:
> Show parallelism level in profiles if requested by user.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/builtin-report.c | 11 +++++++++++
>  tools/perf/util/hist.c      |  2 ++
>  tools/perf/util/hist.h      |  3 +++
>  tools/perf/util/session.c   | 12 ++++++++++++
>  tools/perf/util/session.h   |  1 +
>  tools/perf/util/sort.c      | 23 +++++++++++++++++++++++
>  tools/perf/util/sort.h      |  1 +
>  7 files changed, 53 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 0d9bd090eda71..14d49f0625881 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1720,6 +1720,17 @@ int cmd_report(int argc, const char **argv)
>  		symbol_conf.annotate_data_sample = true;
>  	}
>  
> +	if (report.disable_order || !perf_session__has_switch_events(session)) {
> +		if ((sort_order && strstr(sort_order, "parallelism")) ||
> +				(field_order && strstr(field_order, "parallelism"))) {
> +			if (report.disable_order)
> +				ui__error("Use of parallelism is incompatible with --disable-order.\n");
> +			else
> +				ui__error("Use of parallelism requires --switch-events during record.\n");
> +			return -1;
> +		}
> +	}
> +
>  	if (sort_order && strstr(sort_order, "ipc")) {
>  		parse_options_usage(report_usage, options, "s", 1);
>  		goto error;
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0f30f843c566d..cafd693568189 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -207,6 +207,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  
>  	hists__new_col_len(hists, HISTC_CGROUP, 6);
>  	hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
> +	hists__new_col_len(hists, HISTC_PARALLELISM, 11);
>  	hists__new_col_len(hists, HISTC_CPU, 3);
>  	hists__new_col_len(hists, HISTC_SOCKET, 6);
>  	hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
> @@ -741,6 +742,7 @@ __hists__add_entry(struct hists *hists,
>  		.ip	 = al->addr,
>  		.level	 = al->level,
>  		.code_page_size = sample->code_page_size,
> +		.parallelism	= al->parallelism,
>  		.stat = {
>  			.nr_events = 1,
>  			.period	= sample->period,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 46c8373e31465..a6e662d77dc24 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -42,6 +42,7 @@ enum hist_column {
>  	HISTC_CGROUP_ID,
>  	HISTC_CGROUP,
>  	HISTC_PARENT,
> +	HISTC_PARALLELISM,
>  	HISTC_CPU,
>  	HISTC_SOCKET,
>  	HISTC_SRCLINE,
> @@ -228,6 +229,7 @@ struct hist_entry {
>  	u64			transaction;
>  	s32			socket;
>  	s32			cpu;
> +	int			parallelism;

Can you make it u16 and move to around cpumode to remove paddings?

Thanks,
Namhyung


>  	u64			code_page_size;
>  	u64			weight;
>  	u64			ins_lat;
> @@ -580,6 +582,7 @@ bool perf_hpp__is_thread_entry(struct perf_hpp_fmt *fmt);
>  bool perf_hpp__is_comm_entry(struct perf_hpp_fmt *fmt);
>  bool perf_hpp__is_dso_entry(struct perf_hpp_fmt *fmt);
>  bool perf_hpp__is_sym_entry(struct perf_hpp_fmt *fmt);
> +bool perf_hpp__is_parallelism_entry(struct perf_hpp_fmt *fmt);
>  
>  struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt);
