Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E432EC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8ED960FE8
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbhHaTkD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240905AbhHaTkD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ABAD60F9E;
        Tue, 31 Aug 2021 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438747;
        bh=x273xtouPAcHm91AALzS9Mid9ylyvIGOadJdw0nv7zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciIY8fC97m41MryMUSIsYfTaPWh6rWkzlHFAmlPQ5NpPrkgYAaqftwuGHE3LkGZvV
         lJWjgjiSGGzfpoqFD6XerG2w21O301dBpb4Fefe/QWt7rti1CIkRpHNj65J+q8nOwd
         ZcqVVBxCLD0tZDMLyQ6hfSKPI9mPRssr+VNvABpIjJrT4nRMIyMoqKIPSZVET+E7hL
         xMpbMFkApJw3NPXoYW+Rdy647/h6vlZI6bvL3mkF0klY9pOhtjlGBkRmb2aLnlXRa0
         +AENoM906JBVtGdvShFDIB9ad4Pc/B60HktI3GZCsuwuDuNnD70L37kcqLiXrr5wDl
         txfIi4RAu7fAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FA794007E; Tue, 31 Aug 2021 16:39:04 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:39:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 19/37] perf evsel: separate missing feature
 detection from evsel__open_cpu
Message-ID: <YS6FWEf41ApoxBee@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <cba0b7d939862473662adeedb0f9c9b69566ee9a.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba0b7d939862473662adeedb0f9c9b69566ee9a.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:25AM +0200, Riccardo Mancini escreveu:
> This is a preparatory patch for the following patches with the goal to
> separate in evlist__open_cpu the actual opening, which could be
> performed in parallel, from the existing fallback mechanisms, which
> should be handled sequentially.
> 
> This patch separates the missing feature detection in evsel__open_cpu
> into a new evsel__detect_missing_features function.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 174 +++++++++++++++++++++-------------------
>  tools/perf/util/evsel.h |   1 +
>  2 files changed, 92 insertions(+), 83 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4e9a3e62075305f1..c393bd992322d925 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1841,6 +1841,96 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	return err;
>  }
>  
> +bool evsel__detect_missing_features(struct evsel *evsel)
> +{
> +	/*
> +	 * Must probe features in the order they were added to the
> +	 * perf_event_attr interface.
> +	 */
> +	if (!perf_missing_features.weight_struct &&
> +	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
> +		perf_missing_features.weight_struct = true;
> +		pr_debug2("switching off weight struct support\n");
> +		return true;
> +	} else if (!perf_missing_features.code_page_size &&
> +	    (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) {
> +		perf_missing_features.code_page_size = true;
> +		pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support, bailing out\n");
> +		return false;
> +	} else if (!perf_missing_features.data_page_size &&
> +	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
> +		perf_missing_features.data_page_size = true;
> +		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
> +		return false;
> +	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
> +		perf_missing_features.cgroup = true;
> +		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
> +		return false;
> +	} else if (!perf_missing_features.branch_hw_idx &&
> +	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
> +		perf_missing_features.branch_hw_idx = true;
> +		pr_debug2("switching off branch HW index support\n");
> +		return true;
> +	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
> +		perf_missing_features.aux_output = true;
> +		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
> +		return false;
> +	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
> +		perf_missing_features.bpf = true;
> +		pr_debug2_peo("switching off bpf_event\n");
> +		return true;
> +	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
> +		perf_missing_features.ksymbol = true;
> +		pr_debug2_peo("switching off ksymbol\n");
> +		return true;
> +	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
> +		perf_missing_features.write_backward = true;
> +		pr_debug2_peo("switching off write_backward\n");
> +		return false;
> +	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
> +		perf_missing_features.clockid_wrong = true;
> +		pr_debug2_peo("switching off clockid\n");
> +		return true;
> +	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
> +		perf_missing_features.clockid = true;
> +		pr_debug2_peo("switching off use_clockid\n");
> +		return true;
> +	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
> +		perf_missing_features.cloexec = true;
> +		pr_debug2_peo("switching off cloexec flag\n");
> +		return true;
> +	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
> +		perf_missing_features.mmap2 = true;
> +		pr_debug2_peo("switching off mmap2\n");
> +		return true;
> +	} else if (!perf_missing_features.exclude_guest &&
> +		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> +		perf_missing_features.exclude_guest = true;
> +		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> +		return true;
> +	} else if (!perf_missing_features.sample_id_all) {
> +		perf_missing_features.sample_id_all = true;
> +		pr_debug2_peo("switching off sample_id_all\n");
> +		return true;
> +	} else if (!perf_missing_features.lbr_flags &&
> +			(evsel->core.attr.branch_sample_type &
> +			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
> +			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
> +		perf_missing_features.lbr_flags = true;
> +		pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
> +		return true;
> +	} else if (!perf_missing_features.group_read &&
> +		    evsel->core.attr.inherit &&
> +		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
> +		   evsel__is_group_leader(evsel)) {
> +		perf_missing_features.group_read = true;
> +		pr_debug2_peo("switching off group read\n");
> +		return true;
> +	} else {
> +		return false;
> +	}
> +}
> +
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads,
>  		int start_cpu, int end_cpu)
> @@ -1979,90 +2069,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	if (err != -EINVAL || cpu > 0 || thread > 0)
>  		goto out_close;
>  
> -	/*
> -	 * Must probe features in the order they were added to the
> -	 * perf_event_attr interface.
> -	 */
> -	if (!perf_missing_features.weight_struct &&
> -	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
> -		perf_missing_features.weight_struct = true;
> -		pr_debug2("switching off weight struct support\n");
> +	if (evsel__detect_missing_features(evsel))
>  		goto fallback_missing_features;
> -	} else if (!perf_missing_features.code_page_size &&
> -	    (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) {
> -		perf_missing_features.code_page_size = true;
> -		pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support, bailing out\n");
> -		goto out_close;
> -	} else if (!perf_missing_features.data_page_size &&
> -	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
> -		perf_missing_features.data_page_size = true;
> -		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
> -		goto out_close;
> -	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
> -		perf_missing_features.cgroup = true;
> -		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
> -		goto out_close;
> -        } else if (!perf_missing_features.branch_hw_idx &&
> -	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
> -		perf_missing_features.branch_hw_idx = true;
> -		pr_debug2("switching off branch HW index support\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
> -		perf_missing_features.aux_output = true;
> -		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
> -		goto out_close;
> -	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
> -		perf_missing_features.bpf = true;
> -		pr_debug2_peo("switching off bpf_event\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
> -		perf_missing_features.ksymbol = true;
> -		pr_debug2_peo("switching off ksymbol\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
> -		perf_missing_features.write_backward = true;
> -		pr_debug2_peo("switching off write_backward\n");
> -		goto out_close;
> -	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
> -		perf_missing_features.clockid_wrong = true;
> -		pr_debug2_peo("switching off clockid\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
> -		perf_missing_features.clockid = true;
> -		pr_debug2_peo("switching off use_clockid\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
> -		perf_missing_features.cloexec = true;
> -		pr_debug2_peo("switching off cloexec flag\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
> -		perf_missing_features.mmap2 = true;
> -		pr_debug2_peo("switching off mmap2\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.exclude_guest &&
> -		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> -		perf_missing_features.exclude_guest = true;
> -		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.sample_id_all) {
> -		perf_missing_features.sample_id_all = true;
> -		pr_debug2_peo("switching off sample_id_all\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.lbr_flags &&
> -			(evsel->core.attr.branch_sample_type &
> -			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
> -			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
> -		perf_missing_features.lbr_flags = true;
> -		pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
> -		goto fallback_missing_features;
> -	} else if (!perf_missing_features.group_read &&
> -		    evsel->core.attr.inherit &&
> -		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
> -		   evsel__is_group_leader(evsel)) {
> -		perf_missing_features.group_read = true;
> -		pr_debug2_peo("switching off group read\n");
> -		goto fallback_missing_features;
> -	}
>  out_close:
>  	if (err)
>  		threads->err_thread = thread;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 58aa998e1814ac9e..a83fb7f69b1ead73 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -288,6 +288,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  void evsel__close(struct evsel *evsel);
>  int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		struct perf_thread_map *threads);
> +bool evsel__detect_missing_features(struct evsel *evsel);
>  
>  struct perf_sample;
>  
> -- 
> 2.31.1

-- 

- Arnaldo
