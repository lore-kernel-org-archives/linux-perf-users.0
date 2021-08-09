Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF6C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218BA61052
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 20:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhHIUCB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhHIUCA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 16:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62DB86056B;
        Mon,  9 Aug 2021 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628539299;
        bh=Eq+URu3bwlUYfVc+gzjSPPb11z8iUaCCLWyPR6rHUw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2CWCLM0pG0fEHxdiahKtWoTLBCYjtXbyQVNvkojMfrejIIiBM0hy2taxgWXVfAJ1
         UDLe85d2QiLvGW1A3/KIv3Gj7W82735StTJEI960IJLqsiQLlCXw07izjs7QAp7MLO
         cfvo0Xs+VEwnOoWdVkDy8m+LgVXCZYokrtYf9VfFLs2UOHJAWJKgXe+wa5HgE6nKr+
         aECu/itp1i4uPX1+/3+aQIAhELfnz5R0a03itDFEBn0AVKdcJlQtpNVVuGv2VNuaHc
         0mxa2ujcm36Q/zEnYhp8VxweG0hAcNiVYxkzVKhRdvtUQQcAgrXm1uKicEeJ82esT0
         PE19IPUi8o76A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D123403F2; Mon,  9 Aug 2021 17:01:36 -0300 (-03)
Date:   Mon, 9 Aug 2021 17:01:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 7/9] perf auxtrace: Remove
 auxtrace_mmap__read_snapshot_head()
Message-ID: <YRGJoNdr253SHqlh@kernel.org>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-8-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-8-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 09, 2021 at 07:14:05PM +0800, Leo Yan escreveu:
> Since the function auxtrace_mmap__read_snapshot_head() is exactly same
> with auxtrace_mmap__read_head(), whether the session is in snapshot mode
> or not, it's unified to use function auxtrace_mmap__read_head() for
> reading AUX buffer head.
> 
> And the function auxtrace_mmap__read_snapshot_head() is unused so this
> patch removes it.

Thanks, applied to perf/core.

- Arnaldo

 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/auxtrace.c | 13 +++++--------
>  tools/perf/util/auxtrace.h | 10 ----------
>  2 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index cb19669d2a5b..2dcf3d12ba32 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1686,14 +1686,11 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  	union perf_event ev;
>  	void *data1, *data2;
>  
> -	if (snapshot) {
> -		head = auxtrace_mmap__read_snapshot_head(mm);
> -		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
> -						   &head, &old))
> -			return -1;
> -	} else {
> -		head = auxtrace_mmap__read_head(mm);
> -	}
> +	head = auxtrace_mmap__read_head(mm);
> +
> +	if (snapshot &&
> +	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))
> +		return -1;
>  
>  	if (old == head)
>  		return 0;
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
> -- 
> 2.25.1
> 

-- 

- Arnaldo
