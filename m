Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C1BC433E0
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jan 2021 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C17622CF7
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jan 2021 00:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAXAHH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Jan 2021 19:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbhAXAHG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Jan 2021 19:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611446739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zeO9jgxTSyiJSDmbRWmL8FPQld5X/dLvYotSElL8o4=;
        b=BEh86JJrC4rO2J5n+r2XsqQDUHldmZtmGCY0A2EwdK5AUUq+CylgwbCe86jGZiu4qFYNJJ
        EILdanJn1hJla8ZZ/Kn8E5tE8plun69F93+Zla+SgPMC2lNbxIIq1qfOpMTOCouK8sj339
        XQUNC6bWtMCIkSjHPsVOJxPyXdqecBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-CiH7exTBPE27zlcW22yLyQ-1; Sat, 23 Jan 2021 19:05:35 -0500
X-MC-Unique: CiH7exTBPE27zlcW22yLyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 513F759;
        Sun, 24 Jan 2021 00:05:32 +0000 (UTC)
Received: from krava (unknown [10.40.192.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id 895599CA0;
        Sun, 24 Jan 2021 00:05:27 +0000 (UTC)
Date:   Sun, 24 Jan 2021 01:05:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexandre Truong <alexandre.truong@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: Re: [PATCH 4/4] perf tools: determine if LR is the return address
Message-ID: <20210124000526.GE138414@krava>
References: <20210122161854.5289-1-alexandre.truong@arm.com>
 <20210122161854.5289-4-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122161854.5289-4-alexandre.truong@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 22, 2021 at 04:18:54PM +0000, Alexandre Truong wrote:
> On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
> use dwarf unwind info to check if the link register is the return
> address in order to inject it to the frame pointer stack.
> 
> Write the following application:
> 
> 	int a = 10;
> 
> 	void f2(void)
> 	{
> 		for (int i = 0; i < 1000000; i++)
> 			a *= a;
> 	}
> 
> 	void f1()
> 	{
> 		f2();
> 	}
> 
> 	int main (void)
> 	{
> 		f1();
> 		return 0;
> 	}
> 
> with the following compilation flags:
> 	gcc -g -fno-omit-frame-pointer -fno-inline -O1
> 
> The compiler omits the frame pointer for f2 on arm. This is a problem
> with any leaf call, for example an application with many different
> calls to malloc() would always omit the calling frame, even if it
> can be determined.
> 
> 	./perf record --call-graph fp ./a.out
> 	./perf report
> 
> currently gives the following stack:
> 
> 0xffffea52f361
> _start
> __libc_start_main
> main
> f2

reproduced on x86 as well

> +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
> +{
> +	return callchain_param.record_mode != CALLCHAIN_FP || !sample->user_regs.regs
> +		|| sample->user_regs.mask != PERF_REGS_MASK;
> +}
> +
> +static int add_entry(struct unwind_entry *entry, void *arg)
> +{
> +	struct entries *entries = arg;
> +
> +	entries->stack[entries->i++] = entry->ip;
> +	return 0;
> +}
> +
> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread)
> +{
> +	u64 leaf_frame;
> +	struct entries entries = {{0, 0}, 0};
> +
> +	if (get_leaf_frame_caller_enabled(sample))

the name suggest you'd want to continue if it's true

> +		return 0;
> +
> +	unwind__get_entries(add_entry, &entries, thread, sample, 2);

I'm scratching my head how this unwinds anything, you enabled just
registers, not the stack right? so the unwind code would do just
IP -> LR + 1 shift?

thanks,
jirka

> +	leaf_frame = callchain_param.order == ORDER_CALLER ?
> +		entries.stack[0] : entries.stack[1];
> +
> +	if (leaf_frame + 1 == sample->user_regs.regs[PERF_REG_ARM64_LR])
> +		return sample->user_regs.regs[PERF_REG_ARM64_LR];
> +	return 0;
> +}

SNIP

