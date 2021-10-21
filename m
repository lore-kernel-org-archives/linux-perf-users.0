Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C00C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B64E61186
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJUM54 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhJUM54 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 08:57:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 395996120C;
        Thu, 21 Oct 2021 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634820940;
        bh=GstFJ8LhXpiPXIilQcDxhxzvgCjvc/lCyExitImucSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTfaocJnNY/RzyVKr5tnSpzAmDq/HlUAeSbd02LSPEKFiV26TITv5nZlolgj/a1WK
         0z4ZDPrc26X/E1hCwL1ScHNRRejNlBoa7WfuwBeIIsoWDZ2zbkl5f7jZI0bxnW+Xj9
         ojMbhIocWZ4wMk32dZU14JXenO4hqaSz0J9eyR7IC/PVuiFzYlTqxI1LaSixTk2c/M
         /CjYodVprkRf9ixNmT4ujxjX9u/mFrlRQA08A/ilUBqy1o09c3a4XyiwhPw2J4M4Al
         UTrmkBEdb6BCXmohEKPAnFB0RMnh4t2e9RBUAIo6qtvqkpqs8r0HSfJuomIuJoNdBf
         k+Zz2t0c4ZR0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B3CF410A1; Thu, 21 Oct 2021 09:55:37 -0300 (-03)
Date:   Thu, 21 Oct 2021 09:55:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 0/2] perf jevents: Enable build warnings
Message-ID: <YXFjSR6ZRQbMjiG3@kernel.org>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 21, 2021 at 05:16:43PM +0800, John Garry escreveu:
> Currently jevents builds without any complier warning flags enabled. So
> use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS.
> 
> Changes for v2:
> - Add Werror, Wall, and Wextra (James Clark suggestion)

Thanks, applied.

- Arnaldo

 
> Baseline is acme perf/core + mainline commit b94729919db2 ("perf jevents:
> Free the sys_event_tables list after processing entries"):
> 
> 680453e63302 perf jevents: Free the sys_event_tables list after processing entries
> be8ecc57f180 (origin/perf/core) perf srcline: Use long-running addr2line per DSO
> 2b775152bbe8 perf tests vmlinux-kallsyms: Ignore hidden symbols
> 
> John Garry (2):
>   perf jevents: Fix some would-be warnings
>   perf jevents: Enable warnings through HOSTCFLAGS
> 
>  tools/perf/Makefile.config      |  5 +++++
>  tools/perf/Makefile.perf        |  2 +-
>  tools/perf/pmu-events/Build     |  2 +-
>  tools/perf/pmu-events/jevents.c | 10 ++++------
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> -- 
> 2.17.1

-- 

- Arnaldo
