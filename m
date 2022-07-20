Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFECC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jul 2022 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiGTPGN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTPGM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 11:06:12 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB835237F0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:06:11 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id mz20so1847717qvb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=peWRstM5WJ1uEJGZkmycSQe/OQeWUfZo2X2E/jtgHIE=;
        b=B3nCvg0TJPJ01xPscNBbG9bJvIwTSED8ChRDHzsDnzpHrpkq5kI6I0WYnwrCe/rlf/
         UGBnc6YMPm7VCfPkRE+35isAWs7EQSPjpKf6plM6/KET6FqzblisuAVvOmkYMOTRqv7D
         yT/V5LSFdLaH4VlUen6ySWsnZ9kRHclo6nJ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=peWRstM5WJ1uEJGZkmycSQe/OQeWUfZo2X2E/jtgHIE=;
        b=DURxIsGicV0Wt0f9w+kcsczDDfDdzkrfwQRkgCY+fCJcHpdmicq9h0O0QkxDxtj2SI
         KVTa/97+wtAxHHYU1MvRDD4m3i4KNCuZ84Ax7y3bQq4MeXFbddqfqseBpZJOLIaZU3X6
         gK+ciDmTzn88mlfB+l8matBky0K9jWzzVSbkQBgZxR2YQ+nizDa16lWxNkq1NZ/RInuD
         hBzLb8iK1xAG3lD+mRcbyrYgWVMoEpjQSHYdaPORJL5NeTmsO0QWCr+cxcVxrZ4gZcvO
         2DZBmzj8KoCp/i69b96BlYyhDM0zD5nS2CEvYhSc8LbvdXNJE8QCikAWlk1E8YnhPJjC
         Samg==
X-Gm-Message-State: AJIora+W1Og1n6DzO/cZEJuuq27L6cMUBL0DaSix7hAHV6+ZBtNP0erJ
        PxQkxkYWvPklwJwwhdGnTKx+Ug==
X-Google-Smtp-Source: AGRyM1tik7ywgAmljslw0zAjWFHVty/xQFt9POTSmrwXcAU8vvuHFiR+auALSRY1RE27Sfxqa03ZpQ==
X-Received: by 2002:a05:6214:2588:b0:474:4cd:43b1 with SMTP id fq8-20020a056214258800b0047404cd43b1mr2702376qvb.45.1658329570359;
        Wed, 20 Jul 2022 08:06:10 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id bm35-20020a05620a19a300b006b61b2cb1d2sm35654qkb.46.2022.07.20.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:06:09 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 20 Jul 2022 11:06:08 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/3] perf: Align user space counter reading with
 code
In-Reply-To: <20220719223946.176299-2-irogers@google.com>
Message-ID: <ef5125e0-8265-8c16-e904-c95c8ddc2754@maine.edu>
References: <20220719223946.176299-1-irogers@google.com> <20220719223946.176299-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 19 Jul 2022, Ian Rogers wrote:

> Align the user space counter reading documentation with the code in
> perf_mmap__read_self. Previously the documentation was based on the perf
> rdpmc test, but now general purpose code is provided by libperf.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
>  tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
>  2 files changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d37629dbad72..6826dabb7e03 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
>  	 *
>  	 *     if (pc->cap_usr_time && enabled != running) {
>  	 *       cyc = rdtsc();
> -	 *       time_offset = pc->time_offset;
>  	 *       time_mult   = pc->time_mult;
>  	 *       time_shift  = pc->time_shift;
> +	 *       time_offset = pc->time_offset;
> +	 *       if (pc->cap_user_time_short) {
> +	 *         time_cycles = pc->time_cycles;
> +	 *         time_mask = pc->time_mask;
> +	 *       }

From what I've been told, and from what perf_mmap__read_self() actually 
does, many of these MMAP fields need to be accessed by READ_ONCE()
(a GPLv2 only interface) to be correct.

Should we update perf_event.h to reflect this?  Otherwise it's confusing 
when the actual code and the documentation in the header don't match like 
this.  As an example, see the actual code snippets from
perf_mmap__read_self()

		seq = READ_ONCE(pc->lock);
                barrier();

                count->ena = READ_ONCE(pc->time_enabled);
                count->run = READ_ONCE(pc->time_running);

                if (pc->cap_user_time && count->ena != count->run) {
                        cyc = read_timestamp();
                        time_mult = READ_ONCE(pc->time_mult);
                        time_shift = READ_ONCE(pc->time_shift);
                        time_offset = READ_ONCE(pc->time_offset);

                        if (pc->cap_user_time_short) {
                                time_cycles = READ_ONCE(pc->time_cycles);
                                time_mask = READ_ONCE(pc->time_mask);
                        }
                }

                idx = READ_ONCE(pc->index);
                cnt = READ_ONCE(pc->offset);

...


Vince
