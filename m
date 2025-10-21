Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DF25BEE1
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054979; cv=none; b=eKsMEj6f2Kz0Nt76NEkclwyuOnk5uX0unPD7FGqapRa7m5Yx5XGdNuMxdPwOiXZSjsAkplx/7rgrpKIyx3PofyJipiihwJ/lQInNY44aAOgyEwIgWwiu9169CQ8PKXJhQ2QZYLPHGywuhf5zy9t/mAI3KG8AMY+5qVEDa17etyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054979; c=relaxed/simple;
	bh=a/pdC7vks9Uvhh/hHisPPJtpqJw3X2vPAFPO0qCQTrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucsbxuSUeN+Gxvubg5P2qCpp74NQ56wfYJ4beplrCGwcwtsMOvzTomqMejKcQb090cNjVOFUQOWtaundXuwRQfTteuG3ShjY3JJxWIyJk04NRtDk/xNFkTVNx1LejArDQAtcdzmbQO4ERcbsvah32tXCen+sKhum/TpBhZ1GqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u26yqMGe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u26yqMGe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so36669615e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Oct 2025 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054975; x=1761659775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7bDfwSFVepP2rhzcoAm7tArs0WQG026qy6bbtQD7nU=;
        b=u26yqMGeLi/oG4w3zMxZ1SN2i+JZmcPKWB5fa8ezuhyzzfYG6WSeFVcSk6HB7AoZbC
         5nNGbm4WrfFiO4hl8F0m9P69MdDaT2O9XUaKfPHB22pHQC0wRW1hGuL9rAUV4BaNHLxv
         j4mbsvoglz/eNck3emILAPxLkeFG94i7iJQC3DnvXjhHkERLOsgxpHM07bPdLm+hnkGW
         13S1H0quJxy2LMJiadqYFhnDxNwtkYLzKmh2WYDDqfA0YnCCtFyKR9dxCz2KzgfqUwti
         OxnYoopKlXeRRHOoBiqPlsw2MUjXHno/nT6ZtgZExOcHYXL0QT1x6flGnvUY1Lh/m5Bq
         GhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054975; x=1761659775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7bDfwSFVepP2rhzcoAm7tArs0WQG026qy6bbtQD7nU=;
        b=ec8emQ683kPBOkOcK/lEOsL1i0X16L6i7AxOGWeVnIdd8mdYcdhsqEPjety0qcwfAc
         E6At0Cp36UHFVatfpHyFL8dOd2zqVvdNmvl2Hgbdc7MIM0g3mc7jFtJFpCeBZ5Rij9zx
         jzpe3g9YJoD3i0Kq9Oav945StTcc0acAAY6UnOH4PyL3bUIH8Ry56nVk4cMyhb++KDrk
         okgJkAQja+MqhT+XaTQxRIwqNim0nafs0TFNwHWdZNxOvxiDbA+Y0xh9hb/KuOjIjQ7z
         X4OPn3cJY82AO0n0RdBbfGKYEq+pkRVXLv8pHrsUcZM93xRlTyzADlPVHiKWjp5UBObg
         lI1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+2dVm0xfHcwpDCHoA7hfU2p7V0k9QoBr9P8eWJsUMfwurjr3ftSWvJ4x6pupqxbPBlAiNlaXIPN18+J2Zs8da@vger.kernel.org
X-Gm-Message-State: AOJu0YwOITSs//5FjA5/VxYIn+PNTe2TUEkbEQYxKD3n4mlAq6vW/Utu
	rF1Z5KqS2vJIcUatndO9cGE/+TLeH3Sm1Dp+2qV89lVnoS7YPezFWCYrQT2EhkYkTJI=
X-Gm-Gg: ASbGncs6l3tGJhBlkrPQ0vWpLbR0vbAa1s+Dspsf2hZ6eDFUKmS0cdJUpvcr2A8rr4f
	IHB6kI4SnMAU1Ks5hUNGBb+XBxyRFsRs93BxSOP4l+xCdgZ/Pktn7YEXiW4ejbCyo4LE/VxRVfo
	IcQPeuhnD96Q49VPBWAyvG5t+lpY0sPTVLPl/LfiQPyW85Hap4H4BeZJT0m5nE1F62p5Dohezfs
	+R+fkITs1r8LZlrvhe7bkmBLEG5mAyjGj4M1DXtdzXkH7T2Rcoy+HeskyyRRi1NlycVx+FoPytR
	J8DCw3U5HAxW5kfqin2aA56LedmxBQe064vO1AZPFtOS2j4mwpkkjcsYGT0UvO84QCB0lC+7sLZ
	oCsQM8J22XQPefOGFgBR65ICtCZaQpQJUuAdMu+sM5VdRz6OTd6isoLxq51HOxc69BzIhl1OS5X
	x+PvQ1N6S4SH1KFSqy
X-Google-Smtp-Source: AGHT+IE8OuquALu9kmgnn2aPnlfmmX+90jQVeonnAGU3uNRYXeaTAOMGxAeY/gH4ZW91xJ1yiku57A==
X-Received: by 2002:a05:600c:3b8d:b0:471:60c:1501 with SMTP id 5b1f17b1804b1-47117918c0cmr143310785e9.28.1761054975575;
        Tue, 21 Oct 2025 06:56:15 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf4cf7sm16646765e9.8.2025.10.21.06.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:56:15 -0700 (PDT)
Message-ID: <36509eda-5b0b-41d3-8049-448dd4e67e90@linaro.org>
Date: Tue, 21 Oct 2025 14:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: Tianyou Li <tianyou.li@intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, wangyang.guo@intel.com, pan.deng@intel.com,
 zhiguo.zhou@intel.com, jiebin.sun@intel.com, thomas.falcon@intel.com,
 dapeng1.mi@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aPW2iiNeheOxDGw8@google.com>
 <20251020073005.957524-1-tianyou.li@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251020073005.957524-1-tianyou.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2025 8:30 am, Tianyou Li wrote:
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
>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>      #2 0x570f08 in arch__is perf[570f08]
>      #3 0x562186 in annotate_get_insn_location perf[562186]
>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>      #5 0x56476d in annotation_line__write perf[56476d]
>      #6 0x54e2db in annotate_browser__write annotate.c:0
>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>      #12 0x552293 in do_annotate hists.c:0
>      #13 0x55941c in evsel__hists_browse hists.c:0
>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>      #15 0x42ff02 in cmd_report perf[42ff02]
>      #16 0x494008 in run_builtin perf.c:0
>      #17 0x494305 in handle_internal_command perf.c:0
>      #18 0x410547 in main perf[410547]
>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
>      #21 0x410b75 in _start perf[410b75]
> 
> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data type display")
> Reviewed-by: James Clark <james.clark@linaro.org>
> Tested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> ---
>   tools/perf/ui/browsers/annotate.c | 23 +++++++++++++++++++----
>   tools/perf/util/annotate.c        |  2 +-
>   tools/perf/util/annotate.h        |  2 ++
>   3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 112fe6ad112e..3a81912279ad 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -862,6 +862,18 @@ static s64 annotate_browser__curr_hot_offset(struct annotate_browser *browser)
>   	return al ? al->offset : 0;
>   }
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
>   static int annotate_browser__run(struct annotate_browser *browser,
>   				 struct evsel *evsel,
>   				 struct hist_browser_timer *hbt)
> @@ -1175,10 +1187,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   	if (not_annotated || !sym->annotate2) {
>   		err = symbol__annotate2(ms, evsel, &browser.arch);
>   		if (err) {
> -			char msg[BUFSIZ];
> -			dso__set_annotate_warned(dso);
> -			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> -			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
> +			annotate_browser__symbol_annotate_error(&browser, err);
>   			return -1;
>   		}
>   
> @@ -1187,6 +1196,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   			if (!annotation__has_source(notes))
>   				ui__warning("Annotation has no source code.");
>   		}
> +	} else {
> +		err = evsel__get_arch(evsel, &browser.arch);
> +		if (err) {
> +			annotate_browser__symbol_annotate_error(&browser, err);
> +			return -1;
> +		}
>   	}
>   
>   	/* Copy necessary information when it's called from perf top */
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a2e34f149a07..39d6594850f1 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
>   	annotation__calc_percent(notes, evsel, symbol__size(sym));
>   }
>   
> -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>   {
>   	struct perf_env *env = evsel__env(evsel);
>   	const char *arch_name = perf_env__arch(env);
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index eaf6c8aa7f47..d4990bff29a7 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>   			     int num_aggr, struct evsel *evsel);
>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
> +
> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>   #endif	/* __PERF_ANNOTATE_H */

Reviewed-by: James Clark <james.clark@linaro.org>

