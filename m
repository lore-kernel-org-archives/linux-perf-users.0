Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCDEC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 14:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118196115A
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jul 2021 14:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhGLOex (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:34:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:60929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234869AbhGLOex (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jul 2021 10:34:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="190369944"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="190369944"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 07:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="492128508"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2021 07:31:59 -0700
Subject: Re: [PATCH v4 07/11] perf auxtrace: Remove
 auxtrace_mmap__read_snapshot_head()
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-8-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4c65b6ba-2258-ff36-2ecc-92219e61e578@intel.com>
Date:   Mon, 12 Jul 2021 17:32:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711104105.505728-8-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/07/21 1:41 pm, Leo Yan wrote:
> Since the function auxtrace_mmap__read_snapshot_head() is exactly same
> with auxtrace_mmap__read_head(), whether the session is in snapshot mode
> or not, it's unified to use function auxtrace_mmap__read_head() for
> reading AUX buffer head.
> 
> And the function auxtrace_mmap__read_snapshot_head() is unused so this
> patch removes it.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.c |  5 ++---
>  tools/perf/util/auxtrace.h | 10 ----------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index cb19669d2a5b..7958e17229ea 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1686,13 +1686,12 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  	union perf_event ev;
>  	void *data1, *data2;
>  
> +	head = auxtrace_mmap__read_head(mm);
> +
>  	if (snapshot) {
> -		head = auxtrace_mmap__read_snapshot_head(mm);
>  		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
>  						   &head, &old))

That leaves a nested 'if' which is not kernel style i.e. could be

	if (snapshot &&
	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))


>  			return -1;
> -	} else {
> -		head = auxtrace_mmap__read_head(mm);
>  	}
>  
>  	if (old == head)
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 4f9176368134..d68a5e80b217 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -440,16 +440,6 @@ struct auxtrace_cache;
>  
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  
> -static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
> -{
> -	struct perf_event_mmap_page *pc = mm->userpg;
> -	u64 head = READ_ONCE(pc->aux_head);
> -
> -	/* Ensure all reads are done after we read the head */
> -	smp_rmb();
> -	return head;
> -}
> -
>  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>  {
>  	struct perf_event_mmap_page *pc = mm->userpg;
> 

