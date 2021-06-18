Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B0FC48BE8
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5F061351
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 15:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhFRP6A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhFRP57 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Jun 2021 11:57:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49D84611CD;
        Fri, 18 Jun 2021 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624031750;
        bh=wTpF7edP6a1CdELRrQFTLFJpMG3CKyu5Zw4pKadsKn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTHDO5fdOh+9BSBzT2xeClM9zuWSqZFsNX4z3Cl1gjCt2t9KkKXgC6yZ7Vzx2nNiA
         GBJzhqyKSVnzYNvSZJEwrIXbOOvnL66LNxdjfL6MXjMhd6hcPyXcxc6eDFfGEM898z
         T6q6eWoIbgYjOmyPxBH0roY68GrzM0n4vKyEoKYCi0fUHmJu3oCz8miogxCLS2x173
         vcfh6wjMcMUWKOV84Hr8lnIexmEbXhmwsb5pN+bk7DynEx1U9a3ipvwogtn0JybRSP
         K56pBJgsZqlIwJRawVAvbIBSEyWJxl7W+5Ob2LfvblmZJjH4WYWVUVUu7f+somOIuN
         /yUoSHPt35KqA==
Date:   Sat, 19 Jun 2021 00:55:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf/probe: Add --bootconfig to output definition
 in bootconfig format
Message-Id: <20210619005546.2305361ac828528a1d9eb808@kernel.org>
In-Reply-To: <162282412351.452340.14871995440005640114.stgit@devnote2>
References: <162282409255.452340.4645118932261585719.stgit@devnote2>
        <162282412351.452340.14871995440005640114.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Sat,  5 Jun 2021 01:28:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +int show_bootconfig_events(struct perf_probe_event *pevs, int npevs)
> +{
> +	struct strlist *namelist = strlist__new(NULL, NULL);
> +	struct probe_trace_event *tev;
> +	struct perf_probe_event *pev;
> +	char *cur_name = NULL;
> +	int i, j, ret = 0;
> +
> +	if (!namelist)
> +		return -ENOMEM;
> +
> +	for (j = 0; j < npevs && !ret; j++) {
> +		pev = &pevs[j];
> +		if (pev->group && strcmp(pev->group, "probe"))
> +			pr_warning("WARN: Group name %s is ignored\n", pev->group);
> +		if (pev->uprobes) {
> +			pr_warning("ERROR: Bootconfig doesn't support uprobes\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +		for (i = 0; i < pev->ntevs && !ret; i++) {
> +			tev = &pev->tevs[i];
> +			/* Skip if the symbol is out of .text or blacklisted */
> +			if (!tev->point.symbol && !pev->uprobes)
> +				continue;
> +
> +			/* Set new name for tev (and update namelist) */
> +			ret = probe_trace_event__set_name(tev, pev,
> +							  namelist, true);
> +			if (ret)
> +				break;
> +
> +			if (!cur_name || strcmp(cur_name, tev->event)) {
> +				printf("%sftrace.event.kprobes.%s.probe = ",

Oops, I must not sleep well. this must be "%s.probes = ".
And I found this forgot to support return probes too.
Let me update it...

Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
