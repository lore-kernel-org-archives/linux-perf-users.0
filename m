Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E580C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B7C6136F
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhJTN0x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhJTN0v (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D62BC610A2;
        Wed, 20 Oct 2021 13:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634736277;
        bh=PqVSHH37BmGQsX1qezJH2oQnq5LUFYlr9s1QmVycycc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvH53djgyaKC1oD0p/S0wBL2d8xSwXmPmpPJ9HdrP458IJuyhyZqZ4slDmPK2R12m
         SxLLglsZmGJtRmUy2lHcZw5d5cTRiB9qwUfiv9dqmqi81jzJmZBXpzgc24suTSqjyK
         CC61WgQJbb3mL1heH24V+76WfVlqPO+bVb99DgF8nrRxHs9JvlbWPaOsl8ykPgQ9SA
         7q9UxlT+jIhIEaXq1eGSq2xjSTXbjnO74Q4AZGof8lr3PHDEauQW33OXFkEpCkZkg1
         kqB2YbiTAuDq8CjxqvBVAKmTXhInOPSIKrcxynP0Nc0RBwQ89+uutVozzLzI6nOgPP
         xh6Z4tAAJq9Zg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2B04410A1; Wed, 20 Oct 2021 10:24:33 -0300 (-03)
Date:   Wed, 20 Oct 2021 10:24:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 04/21] perf pmu: Make pmu_event tables const.
Message-ID: <YXAYkecMsW+Zj8W9@kernel.org>
References: <20211015172132.1162559-1-irogers@google.com>
 <20211015172132.1162559-5-irogers@google.com>
 <d9566a3a-179e-ab3c-6a63-256ea23778b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9566a3a-179e-ab3c-6a63-256ea23778b9@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 19, 2021 at 12:19:24PM +0100, John Garry escreveu:
> On 15/10/2021 18:21, Ian Rogers wrote:

> - bouncing Changbin Du <changbin.du@intel.com> and Jin Yao
> <yao.jin@linux.intel.com>
 
> > Make lookup nature of data structures clearer through their type. Reduce
> > scope of architecture specific pmu_event tables by making them static.

> > Suggested-by: John Garry<john.garry@huawei.com>
> > Acked-by: Andi Kleen<ak@linux.intel.com>
> > Signed-off-by: Ian Rogers<irogers@google.com>
 
> Reviewed-by: John Garry <john.garry@huawei.com>
 
> BTW, We seem to be using > 80 char per line now. Well in metricgroup.h
> anyway, from a brief check. I know checkpatch.pl is ok with this now, but
> some maintainers aren't. Just saying.

I don't have a problem with that:

[acme@quaco ~]$ echo $COLUMNS
273
[acme@quaco ~]$

:-)

- Arnaldo
