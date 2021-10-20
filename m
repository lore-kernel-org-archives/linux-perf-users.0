Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F5C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 14:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4BD60E0C
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 14:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJTOeR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhJTOeQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 10:34:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21904611B0;
        Wed, 20 Oct 2021 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634740322;
        bh=pcxWEwcGQqT8BhQ5/6s7J9I6P9BEWrln+Wg0sC7KOTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtocx8fWwXFLsm0lBnEsa/5VmGpYPyPqMOGpmH+XVaBTe1AJq3lq0RK0+ESIFIxIF
         EJ0CKupgZaeFI2OvqvZmegDSIpqLFE5S2DHpTEY5ke49bqrUE7JQ7MRJtlGevkJuTF
         mpmcKsmNZES9dvn5/CWiStxy4RsYxfWs3GSOt1KuT5GMR/psPdWWrDfc1FQ1r3VNXV
         xzlzhRIFOEOizA9bF2jRRk5FlarYVQWZ2niToiOwc6C4EO9oU/ZGssxNZrMA5DRUVX
         8dEkN3iwWTvQ5/MlqmYrPmZK4LXlb5Ldo46Y+fqnbjL+H6O0w7IeNmWIp6En5uqWr+
         dzKre6M6cUxdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7A08410A1; Wed, 20 Oct 2021 11:31:59 -0300 (-03)
Date:   Wed, 20 Oct 2021 11:31:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
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
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 00/21] perf metric: Fixes and allow modifiers
Message-ID: <YXAoXxPtzYk+FhhM@kernel.org>
References: <20211015172132.1162559-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 15, 2021 at 10:21:11AM -0700, Ian Rogers escreveu:
> There are 4 main changes in this patch set:
>  - perf metric: Modify resolution and recursion check.
>  - perf parse-events: Add new "metric-id" term.
>  - perf metrics: Modify setup and deduplication
>  - perf metric: Allow modifiers on metrics.

Thanks, applied. Replaced the v1 with this one since it never hit the
published perf/core branch.

- Arnaldo

