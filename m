Return-Path: <SRS0=rwtg=IE=vger.kernel.org=linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F66C433E0
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 20:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6564FE8
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhCFUA7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Mar 2021 15:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhCFUAq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Mar 2021 15:00:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E1C464FDD;
        Sat,  6 Mar 2021 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615060846;
        bh=bnBGaECuDVghS0w5ta0GfbdEfrZY5uUKeKJqjiiie/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ic4NQweE4TkFvBpcTpSVZ7g/b5MQsBCbmLgQ1xukmEVqgIgSCJbxZxmofi2cuOY2K
         Sbz9QZvaiEh4OkvX5h1Vp70HQnTlSvIooO3BG/FxZWrZoG30eew7ZHrWiu6uzW4Wwr
         OAgjKMgXHYQyc1WCbSTxW0p8lQnlQzacc++DbDSvEM9kNcSBtefht09ueCMtqMSJQc
         nlKpPCEpFGiqp6f+FJuTYTIPYU8ZmUwgVJXu/nOTFuc7afYw8dIk9njPbCHGxtwLD2
         IlcfAH73sN8zJPwr4KHgc0gCrZFH1l7a+qJ3vDWarVeHi3kSA6D73YBmTLZvGUpOU5
         MTNtjQ/aXfU7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D02E940647; Sat,  6 Mar 2021 17:00:41 -0300 (-03)
Date:   Sat, 6 Mar 2021 17:00:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andreas Wendleder <andreas.wendleder@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Safonov <dima@arista.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sedat Dilek # LLVM/Clang v13-git <sedat.dilek@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v5.12
Message-ID: <YEPfaXpQ8S5H7NU8@kernel.org>
References: <20210306145300.3370839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306145300.3370839-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Mar 06, 2021 at 11:53:00AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Linus,
> 
> 	Please consider pulling,

<SNIP>

> Arnaldo Carvalho de Melo (13):
>       tools headers UAPI: Update tools's copy of drm.h headers
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers UAPI: Sync openat2.h with the kernel sources
>       perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
>       tools headers UAPI s390: Sync ptrace.h kernel headers
>       tools headers UAPI: Sync kvm.h headers with the kernel sources
>       Merge remote-tracking branch 'torvalds/master' into perf/urgent

So this one had that v5.12-rc1-dontuse, I'm rebasing to v5.12
(cherry-picking even)/retesting, will resend after all is retested.

Thanks,

- Arnaldo
