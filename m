Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24F6C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A151261175
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 15:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJSPIg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhJSPId (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 11:08:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9FC16115A;
        Tue, 19 Oct 2021 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634655980;
        bh=McyFOJTAzTyYw41z1YF9eETGWDWdlZDxE9H0XbVk8m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhcIXXlISyAo2Cp3KUlwK4daus2D5a3p6b8jRrPTNwxwC9VY9xe/ITz1XqrpInmWD
         tZV1+o4jkd9GDy1srZp48JU5tVK1LEQ1JMklLeh6MU965FHX/OpBjOElx3APkAni69
         z3QAq6tj9rfzE/RhPdGPSNz6Qe/kI9VmozvIqYWSYPlTXnxO9fuVvHIw/AEsmP1uL/
         uJmo3HMICI6UotOqZjzUW2OKqktF5Bde9idyb83xWc/b5xkAQWpsBvY0y219iXl1lQ
         NqgLdBmtS6bKigYdrEk37wBcXBuRHJTda6ibxMCcXfyJPgehVAZqNRDavYTe/i+s/J
         xvrrhDO8GydaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BB2D410A1; Tue, 19 Oct 2021 12:06:16 -0300 (-03)
Date:   Tue, 19 Oct 2021 12:06:16 -0300
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
Subject: Re: [PATCH v2 21/21] perf metric: Allow modifiers on metrics.
Message-ID: <YW7e6OvE/juYY8it@kernel.org>
References: <20211015172132.1162559-1-irogers@google.com>
 <20211015172132.1162559-22-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015172132.1162559-22-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 15, 2021 at 10:21:32AM -0700, Ian Rogers escreveu:
> By allowing modifiers on metrics we can, for example, gather the
> same metric for kernel and user mode. On a SkylakeX with
> TopDownL1 this gives:
> 
> $ perf stat -M TopDownL1:u,TopDownL1:k -a sleep 2
> 
>  Performance counter stats for 'system wide':

Hi Ian, can you please take a look on this? this is on my perf/core
branch.

- Arnaldo

[root@five ~]# perf test -vv "for cgroups"
70: Event expansion for cgroups                                     :
--- start ---
test child forked, pid 992568
Using CPUID AuthenticAMD-25-21-0
libpfm was not enabled
metric expr 1 / IPC for CPI
parsing metric: 1 / IPC
metric expr instructions / cycles for IPC
parsing metric: instructions / cycles
found event instructions
found event cycles
Parsing metric events '{instructions/metric-id=instructions/,cycles/metric-id=cycles/}:W'
copying metric event for cgroup 'A': instructions (idx=0)
copying metric event for cgroup 'B': instructions (idx=0)
copying metric event for cgroup 'C': instructions (idx=0)
free(): double free detected in tcache 2
test child interrupted
---- end ----
Event expansion for cgroups: FAILED!
[root@five ~]#

⬢[acme@toolbox perf]$ git bisect bad
c067335fcbfc67c36663dabdb9ccaa96badf9359 is the first bad commit
commit c067335fcbfc67c36663dabdb9ccaa96badf9359
Author: Ian Rogers <irogers@google.com>
Date:   Thu Oct 7 09:56:47 2021 -0700

    perf metric: Allow modifiers on metrics.

    By allowing modifiers on metrics we can, for example, gather the
    same metric for kernel and user mode. On a SkylakeX with
    TopDownL1 this gives:

