Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A6C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF161246
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbhI1S45 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhI1S44 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 14:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4659960EE9;
        Tue, 28 Sep 2021 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632855312;
        bh=vHARUzctnEjoBeR9DoEplwWSLU+oFbVvrJzTyQN65Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/hiK95VwImBitL+sNhB6nlFkGaeQxih40q7GWj1a+DjCQnYGwuTxwx/gezGsrvTB
         yVyhfQ2nsxaQDjbIw79m+nhUVfPyjRl/ZIRdE8caQeJPdytl7HEmYwUuB7GzcrZmnO
         TiZRdNgUNQHR1P9BpRQzFTi0PSsXI3xCxAlBnd/yKTqcBh7kWINxda0nnsc89kEqdo
         WET4DCL1xwqypcCDZ+goBF6g1+ADIZl1BbO5BLkGW2izQZnQ+13V3Xdu7ZHWefjij8
         uFwfyB7HxKb+B76SoDzsTigv3K29poFOieQUS23JzPbNma8b7JXQs7twN16KOUKBFc
         1bnN7hS9pUa2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBBD3410A1; Tue, 28 Sep 2021 15:55:08 -0300 (-03)
Date:   Tue, 28 Sep 2021 15:55:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v3 1/2] perf test: Workload test of metric and
 metricgroups
Message-ID: <YVNlDGP8NCWocNtY@kernel.org>
References: <20210917184240.2181186-1-irogers@google.com>
 <YU4iVcVc6uYAWft4@kernel.org>
 <ea23f319-49df-5905-758e-478baf44bdc9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea23f319-49df-5905-758e-478baf44bdc9@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 24, 2021 at 08:39:18PM +0100, John Garry escreveu:
> On 24/09/2021 20:09, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Sep 17, 2021 at 11:42:39AM -0700, Ian Rogers escreveu:
> > > Test every metric and metricgroup with 'true' as a workload. For
> > > metrics, check that we see the metric printed or get unsupported. If the
> > > 'true' workload executes too quickly retry with 'perf bench internals
> > > synthesize'.

> > > v3. Fix test condition (thanks to Paul A. Clarke<pc@us.ibm.com>). Add a
> > >      fallback case of a larger workload so that we don't ignore "<not
> > >      counted>".
> > > v2. Switched the workload to something faster.
> > Hi John, does your Reviewed-by stands for v3 too?
 
> Yeah,
 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo

