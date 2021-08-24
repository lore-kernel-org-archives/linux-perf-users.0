Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7ACC4320A
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC661265
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhHXP1N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238225AbhHXP1M (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 11:27:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90BB661165;
        Tue, 24 Aug 2021 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629818788;
        bh=1/6Gs0CNxRrQ4al2mN+eLae7c9YMJo5CCUoXMdHvhhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4PJPql0gILM2shQQkzOLFh6frmwNwiLyDJMBrT9aB7zl8tHXPM66D2QTFQTbyD0m
         95YI8Mej0duSGKJVP74+8DWVUkGu88vENnfLw58sU9Ws4TL6d3kfvk1bxSE04IQCcs
         1gNod5jgznbfWED4stu3HwMtv1KDBjSgUD2t/8hQ2oa33Fr/CxJjQ5WqXXV4JeBy03
         U6fVP5BjHP2E18Ward+gSdiLhbJdWze6lX8DP16s5v7WOab4XwgAZqgOyiJ0lQDthO
         ptgQsnu4vOL2FRMH6SZG8X8h1QL6EBs2fSWz+PSbyihe5gUl2azV4T/kJaWOnwc/E8
         gDe8+RLVUEMmA==
Date:   Tue, 24 Aug 2021 16:26:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 1/3] arm64: perf: Add userspace counter access disable
 switch
Message-ID: <20210824152621.GB23146@willie-the-truck>
References: <20210806225123.1958497-1-robh@kernel.org>
 <20210806225123.1958497-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806225123.1958497-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 04:51:21PM -0600, Rob Herring wrote:
> Like x86, some users may want to disable userspace PMU counter
> altogether. Add a sysctl 'perf_user_access' file to control userspace
> counter access. The default is '0' which is disabled. Writing '1'
> enables access.
> 
> Note that x86 also supports writing '2' to globally enable user access.
> As there's not existing userspace support to worry about, this shouldn't
> be necessary for Arm. It could be added later if the need arises.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v9:
>  - Use sysctl instead of sysfs attr
>  - Default to disabled
> v8:
>  - New patch
> 
> ---
>  arch/arm64/kernel/perf_event.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index d07788dad388..74f77b68f5f0 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -286,6 +286,21 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
>  PMU_FORMAT_ATTR(event, "config:0-15");
>  PMU_FORMAT_ATTR(long, "config1:0");
>  
> +static int sysctl_perf_user_access __read_mostly;
> +
> +static struct ctl_table armv8_pmu_sysctl_table[] = {
> +	{
> +		.procname       = "perf_user_access",
> +		.data		= &sysctl_perf_user_access,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};

This should be documented somewhere. Maybe add an entry to
Documentation/admin-guide/sysctl/kernel.rst which points at the doc in patch
3, which needs updating to talk about this control?

Otherwise, looks good:

Acked-by: Will Deacon <will@kernel.org>

Will
