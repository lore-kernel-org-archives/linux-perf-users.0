Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607D139579
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Oct 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531411; cv=none; b=J5eRh/1ZeX4W1reHyt0K37kinSIF5nPIQWXCeHXpaOebxz0hHYT8UqepGjZmAaRbU18c+1s6C+esN2SmVKKHubTFxVSUcEN2GZ4KPxR/w7JTynkFLDt824IhZncSOoG6kT7s2My16hikq2Jvah6NI3wt76McBQRrRhOn/iKtD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531411; c=relaxed/simple;
	bh=gguTeSP019wVZZA/rAKWFDEKPDVx0leTyKUWhXrrqwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEDQk2NH/0ez6gGy1kgTDhialB5lDeo56TN/TKsOue4rfzrDX98r1xgCm13S+Nim4HZUVLiAgZoiZSSdnldpff5eHzdcY1Ob2eHvcNJOOQIpXrIErP/fwmlc0WzAGPdjNbKoEnfuHmsR9R3UriaH1xSLFuXOFNS3Vq9AMfjKar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r05/NPms; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r05/NPms"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso5629529f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Oct 2025 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760531407; x=1761136207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKrs5BBSGYon5hQmCysFGRBLhefHUknlfwhPY8d6mGo=;
        b=r05/NPmsythmYeTwVUg3tBMcAnhLH/XtFWXs0dt920nnFxatugMR3/3VMiB0vT9hEc
         MB75rljfhN4f8r3ZzHsV6Q77YH0vQYRWiwetSLMCLlUjtnu0d5RVFBxb3t7Cq5dLD8RR
         ZH0wzhmCVh3o/ZeyS1rIXYEn1xcknNEoxc2DvEoQNFCPzMBgj26UUvofXOIccBJ7IkKS
         YOljLFUulaF7WytkwH5g6ffURaAkoamdR3kXOOphVhE0clmh4BSIXzbkb0lt2tjXZigg
         vWi7Yqe+m0IJdLWa8qLkfCvUKpnyE40n//jW8KjU1UU4VWOByEnPdV2eZ/e5mi1ascEr
         BgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531407; x=1761136207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKrs5BBSGYon5hQmCysFGRBLhefHUknlfwhPY8d6mGo=;
        b=uePuzzK6mCwaqzJjWpqsPA/vupfpzb8DK5L9ccfDAR7RxhBLmob0wqAqTfpEZXj2kF
         4bifP7w084d8at99xRcvxNpU0/KM6aGOMNm7j864LjfZ55rL34nC6PBMY7jUAgPqjMYF
         kGzgez58oIsY91ES/oLVTHhCc9OuniWPA5DgLmibVxQrN5ygxLTboyB5UAv9yiAQrj47
         GXGj1+eFKIyjQcJ+IeNZAslHS+zMc9fHFZcpFm2ECop9zzpXiA2OHnV7kg9+mgeU+Jyg
         1gnOuppGK/jc6eOsodQE79wWMEO2hQZfjNTVpfAl/MY5Nq5RBryOEGyAh+rMnJbSCFPJ
         7Ovg==
X-Forwarded-Encrypted: i=1; AJvYcCV4CXFkCG7S6hPGmVtr18DCEAlvRzjhDGynBr3VoGDVlx73WggbeZNpvSBtWr2Ky0IleE0ydlINQN5CvE8U6LA4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+wo0weA8e+rQ+kVAMlFUGaH1jDB6Bs5bcGoHxgLnM6aGxlzc
	x4JQfMn+OaX62nJApFWQsTWYfEBwpFM61k8OJHIoXUABbp6nZC6wopcAdsM1l884Y2s=
X-Gm-Gg: ASbGncsgp8t4lePcMK6vBdcRUZXQO1PHozslaGhKbypP3ulZXWiyBPfn4kEBNHSrn+0
	rHwPfpjo6as/5TNuU0FDHLsSDMAR5G1Sn1aY+u/Kl5ImvU3gVmH7borpKgHnaDEyXXaPSvQdESC
	q+iLv1SdXtLCHj9MX0HZxYs1SKX47mi1UU2oYPcZ4GUbuLKzj6QkYjles0Bi2V4ijpOUWjiw3PL
	YBujjQZhTXT52KYJLuR51Knqb9lw7NZR+IIPgddR+RdD9XvFgPJY/GdvF6kJM0i5Wyc0XdirzWI
	qhu/QWJvTqdt68FrDnXfvrxHWitfkRAwu1DurepQ8S/yaw3KPugGYcNTeqfZk/AHGHWUzBFl5ey
	aJMAElAKFeiNvRwOaIOSe9hogngLXqEOYQjXbnlR6aa7V0MTVus00wSqF+NseIA==
X-Google-Smtp-Source: AGHT+IEJgL7G+N3GmBnYQg1sjLSSfgVQHpajjUaA/C0z/ta/sjmOFXGtL/ZuhwhVQxk+l9PUrwPJDA==
X-Received: by 2002:a05:6000:2203:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-4266e8e91b6mr19673488f8f.63.1760531407483;
        Wed, 15 Oct 2025 05:30:07 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab500706sm179801005e9.3.2025.10.15.05.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:30:07 -0700 (PDT)
Message-ID: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
Date: Wed, 15 Oct 2025 13:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools annotate: fix a crash when annotate the same
 symbol with 's' and 'T'
To: Tianyou Li <tianyou.li@intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, wangyang.guo@intel.com, pan.deng@intel.com,
 zhiguo.zhou@intel.com, jiebin.sun@intel.com, thomas.falcon@intel.com,
 dapeng1.mi@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20251013161046.2075335-1-tianyou.li@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251013161046.2075335-1-tianyou.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/10/2025 5:10 pm, Tianyou Li wrote:
> When perf report with annotation for a symbol, press 's' and 'T', then exit
> the annotate browser. Once annoate the same symbol, the annoate browser
> will crash. Stack trace as below:
> 

Hi Tianyou,

Can you explain why this only happens the second time and what you did 
to fix it in the commit message. It took me a minute to work out.

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

This should have a fixes tag. Maybe commit 1d4374afd000 ("perf annotate: 
Add 'T' hot key to toggle data type display")? Or earlier if only 's' 
and not 's' and 'T' are required to reproduce.

> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> ---
>   tools/perf/ui/browsers/annotate.c | 3 +++
>   tools/perf/util/annotate.c        | 2 +-
>   tools/perf/util/annotate.h        | 2 ++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 8fe699f98542..1e0873194217 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -1163,6 +1163,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   		}
>   	}
>   
> +	if (browser.arch == NULL)
> +		evsel__get_arch(evsel, &browser.arch);
> +

This technically only needs to be called if symbol_annotate2() doesn't 
get called. So it could be on an "else" after "if (not_annotated || 
!sym->annotate2)".

I looked to see if it's better to save the arch in *notes, seeing as 
that's where the annotation is cached, but it doesn't feel any nicer 
than the way you've done it.

You don't need to check the return value for errors because we only get 
here if it worked previously and dso__annotate_warned() is false. But it 
might be worth a comment or checking it anyway to avoid doubt.

Other than that, looks good.

Thanks
James

>   	/* Copy necessary information when it's called from perf top */
>   	if (hbt != NULL && he != &annotate_he) {
>   		annotate_he.hists = he->hists;
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

