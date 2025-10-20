Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB523D2A1;
	Mon, 20 Oct 2025 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933448; cv=none; b=qpZOivMybeB/UtnMgFdhxVKPV1+p7dJqUWeUB37AQNC2XfCDlJR3Z2EZla0gPtaXxEMgDFTeiocVx4YAIc1S3tNE2GzXITisWYZlm51wg9YjkSLKKEg3+5ATaW+f2WyPipniENNkf8XBQJjGNF8SfVrEjlFsFm8qil1MrVLmFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933448; c=relaxed/simple;
	bh=5b9mPGg8qzoVhvWjhWuf/Bm8VSlp5qEZoO/S/k9eiRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzY6OvwwbAcd1/be6WMzCGhOCxHMvjwtufa/+Ec4Ler5CkspVJE4obTsFmDs8xWWsarqmoTbqr4aeA8ysfyD+qmpyugnlNTRTwqY4l9kKlNSUOex3T9f3PmQLm1CIr68Xfb7W2Ofxlhze4gdRskPyB908Z4uNUioekTxd4iJ/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRGZeK4t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRGZeK4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8831C4CEF9;
	Mon, 20 Oct 2025 04:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760933447;
	bh=5b9mPGg8qzoVhvWjhWuf/Bm8VSlp5qEZoO/S/k9eiRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRGZeK4tGMVED2PjxLEDlvuZKFLD8N0/fjzqsbvxv+jZDv74jFA+2IcK1Sfj0OZQK
	 iJK153lEqrxm67QOs56hryWIy7MA2FUV0gXJZIaB5WpCkgGQD5RkfGU1CCRLA1vUM3
	 dGKiKtABS/kp8Uv7zwulm1TdwznL5jYc+aBMEeiKDTg08Gl5nHhk06T1vHeHqQ7tgh
	 KORHbakoAeIRT4LpQU75XLIkRpJhgNg6DCk9ELwjeLlNo60hHdDe2cdo4a0j17/cuL
	 wRAFVhS+CyqOf/BSpAD6NuOuLS6YSk6NqVZBhvshSRg6O0oIr4T1qbaT7fB7g+WAvV
	 vwfthiTxSyXZA==
Date: Mon, 20 Oct 2025 13:10:41 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Tianyou Li <tianyou.li@intel.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com,
	thomas.falcon@intel.com, dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf tools annotate: fix a crash when annotate
 the same symbol with 's' and 'T'
Message-ID: <aPW2QSJMhdegFrQH@google.com>
References: <aPRbfdU92XRLR-2N@google.com>
 <20251020021434.29082-1-tianyou.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020021434.29082-1-tianyou.li@intel.com>

On Mon, Oct 20, 2025 at 10:14:33AM +0800, Tianyou Li wrote:
> When perf report with annotation for a symbol, press 's' and 'T', then exit
> the annotate browser. Once annotate the same symbol, the annotate browser
> will crash.
> 
> The browser.arch was required to be correctly updated when data type
> feature was enabled by 'T'. Usually it was initialized by symbol__annotate2
> function. If a symbol has already been correctly annotated at the first
> time, it should not call the symbol__annotate2 function again, thus the
> browser.arch will not get initialized. Then at the second time to show the
> annotate browser, the data type needs to be displayed but the browser.arch
> is empty.
> 
> Stack trace as below:
> 
> Perf: Segmentation fault
> -------- backtrace --------
>     #0 0x55d365 in ui__signal_backtrace setup.c:0
>     #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>     #2 0x570f08 in arch__is perf[570f08]
>     #3 0x562186 in annotate_get_insn_location perf[562186]
>     #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>     #5 0x56476d in annotation_line__write perf[56476d]
>     #6 0x54e2db in annotate_browser__write annotate.c:0
>     #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>     #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>     #9 0x54c03d in __ui_browser__refresh browser.c:0
>     #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>     #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>     #12 0x552293 in do_annotate hists.c:0
>     #13 0x55941c in evsel__hists_browse hists.c:0
>     #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>     #15 0x42ff02 in cmd_report perf[42ff02]
>     #16 0x494008 in run_builtin perf.c:0
>     #17 0x494305 in handle_internal_command perf.c:0
>     #18 0x410547 in main perf[410547]
>     #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>     #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
>     #21 0x410b75 in _start perf[410b75]
> 
> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data type display")
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>

As we have the annotation support, can you please rebase on to the
current perf-tools-next?

Thanks,
Namhyung

> ---
>  tools/perf/ui/browsers/annotate.c | 23 +++++++++++++++++++----
>  tools/perf/util/annotate.c        |  2 +-
>  tools/perf/util/annotate.h        |  2 ++
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 8fe699f98542..ac85df1020a1 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -852,6 +852,18 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
>  	}
>  }
>  
> +static void annotate_browser__symbol_annotate_error(struct annotate_browser *browser, int err)
> +{
> +	struct map_symbol *ms = browser->b.priv;
> +	struct symbol *sym = ms->sym;
> +	struct dso *dso = map__dso(ms->map);
> +	char msg[BUFSIZ];
> +
> +	dso__set_annotate_warned(dso);
> +	symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> +	ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
> +}
> +
>  static int annotate_browser__run(struct annotate_browser *browser,
>  				 struct evsel *evsel,
>  				 struct hist_browser_timer *hbt)
> @@ -1149,10 +1161,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  	if (not_annotated || !sym->annotate2) {
>  		err = symbol__annotate2(ms, evsel, &browser.arch);
>  		if (err) {
> -			char msg[BUFSIZ];
> -			dso__set_annotate_warned(dso);
> -			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> -			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
> +			annotate_browser__symbol_annotate_error(&browser, err);
>  			return -1;
>  		}
>  
> @@ -1161,6 +1170,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  			if (!annotation__has_source(notes))
>  				ui__warning("Annotation has no source code.");
>  		}
> +	} else {
> +		err = evsel__get_arch(evsel, &browser.arch);
> +		if (err) {
> +			annotate_browser__symbol_annotate_error(&browser, err);
> +			return -1;
> +		}
>  	}
>  
>  	/* Copy necessary information when it's called from perf top */
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a2e34f149a07..39d6594850f1 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
>  	annotation__calc_percent(notes, evsel, symbol__size(sym));
>  }
>  
> -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>  {
>  	struct perf_env *env = evsel__env(evsel);
>  	const char *arch_name = perf_env__arch(env);
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index eaf6c8aa7f47..d4990bff29a7 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>  int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>  			     int num_aggr, struct evsel *evsel);
>  int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
> +
> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>  #endif	/* __PERF_ANNOTATE_H */
> -- 
> 2.47.1
> 
