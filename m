Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A051EB64DA
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFZMc7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZMc6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 08:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0B113
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 05:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010C660DFF
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 12:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88932C433C9;
        Mon, 26 Jun 2023 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687782776;
        bh=AuPnulbbpqjFDkfJs/zeV+ZfkvpC+hu2+1t37uDiU+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvRcPJFXy7he9QnpQZpp/+Ss2HEsFcH28IyJsImjnY93kvhmYtly4+thiyumESiHp
         AdC5O9+4R9vIlQgRrM+QTh9MG8GE7c+5y3H2nOwOZteub4YxUX/BGqMzO4MioGrRG9
         uVqeFZYc+9nqduyGK6wSQxKrx1PfmbfyJxi0gG5SbKajW/HYJua+Ioick4Jdw4srPO
         igTv9MSJltp6M6Rdb1wLWXitRBkRRItKdHBEGuTRsF0qeKEjLcrdPXEJONWJcFCTPT
         A+tXM/SAf8SM1sJwkzpqjN1+AsUzHLR48Kll8aOyTdPcLBaZBMkHu2ZzCGJQ8Lci7q
         f3UIIlCWSwUVA==
Date:   Mon, 26 Jun 2023 13:32:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>, mark.rutland@arm.com
Subject: Re: perf-tools-next: Request for testing hybrid changes
Message-ID: <20230626123249.GC19941@willie-the-truck>
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
 <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 07:30:53AM -0700, Ian Rogers wrote:
> On Fri, Jun 23, 2023 at 1:42 AM James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 22/06/2023 21:15, Ian Rogers wrote:
> > > On Thu, Jun 22, 2023 at 11:57 AM Namhyung Kim <namhyung@gmail.com> wrote:
> > >>
> > >> Hello,
> > >>
> > >> In this development cycle, we've got a big change in how to handle
> > >> heterogeneous core PMUs. It's mostly tested on Intel hybrid machines
> > >> but caused some troubles on others.  So I'd like to confirm it works
> > >> on major platforms without problems.  Especially on ARM64 as it has
> > >> the big.LITTLE CPUs.
> > >
> > >
> > > Thanks Namhyung. I believe there is a change on ARM64 that makes a
> > > problem of one type into a slightly different problem. The perf parse
> > > events logic handles events certain known hardware events using known
> > > numeric encodings, for example, the cycles event has a type of 0
> > > (PERF_TYPE_HARDWARE) and a config of 0 (PERF_COUNT_HW_CPU_CYCLES):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.l?h=perf-tools-next#n286
> > >
> > > The perf_event_open syscall can specify a CPU number of -1 for any. My
> > > understanding is that -1 on ARM translates into choose the PMU of the
> > > current running thread, this means that if a thread migrates from
> > > between core/PMU types it won't be recorded on the alternate PMU type.
> > >
> > > The extended type capability (PERF_PMU_CAP_EXTENDED_HW_TYPE) solves
> > > this, but appears not to be set on ARM's PMU:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/perf/arm-cmn.c#n2291
> > > Could an ARM64 related person fix this?
> > >
> >
> > Yes I was planning to look into this since this thread [1].
> > It seems like there are still some test failures on Juno which I'm
> > working through now, even after the fix in that thread. And I was
> > thinking that it should be possible to support
> > PERF_PMU_CAP_EXTENDED_HW_TYPE on Arm too.
> 
> Thanks James, my memory of Juno boards was early bring up work and I
> don't recall them having heterogeneous PMUs. Presumably this is
> another issue, I'm happy to help if you can share more details.
> 
> It is great that you'll look to add PERF_PMU_CAP_EXTENDED_HW_TYPE,
> there is also the legacy kernel issue. Do you have a plan there or
> should supporting PERF_PMU_CAP_EXTENDED_HW_TYPE be the plan? As the
> Linux 6.5 merge window will open soon I'm concerned that these fixes
> may only make it into 6.6. Should we do anything short-term for 6.5?
> For example, if extended types aren't supported then disable the
> wildcard matching of PMUs in the "numeric", really PERF_TYPE_HARDWARE
> and PERF_TYPE_HW_CACHE, cases?

What does PERF_PMU_CAP_EXTENDED_HW_TYPE buy us on Arm, given that we've
supported heterogeneous PMUs for years without issues? In other words,
what is the benefit of supporting two user ABIs here?

Will
