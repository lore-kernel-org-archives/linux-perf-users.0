Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F69C64E7A
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23E82220B
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 23:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLAXKW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgLAXKW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Dec 2020 18:10:22 -0500
Date:   Tue, 1 Dec 2020 23:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606864181;
        bh=R1LZxKhC63MgOhIWSKRcfmgG/w02ZOoz7xHqWe+Pr7k=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=zsaqQBCXac4ssa46wKGJrHjx78Yx+BKPCLV22+wvuO2lvTanFDGUxj+NCPAd7BT2E
         TQo1DGLBSM79hGhonz/V0LYXVbogx5ZAv/HDAPU3QyZI4crCjRZPDk3x8CH2QsIBsJ
         5osHzXr+wQYAdBUuuOnHChySkw+W5DZWwAQdrdJ8=
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Message-ID: <20201201230935.GD28496@willie-the-truck>
References: <20201130162454.28255-1-james.clark@arm.com>
 <20201130164650.GA25187@willie-the-truck>
 <20201201041040.GC28939@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201041040.GC28939@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 01, 2020 at 12:10:40PM +0800, Leo Yan wrote:
> On Mon, Nov 30, 2020 at 04:46:51PM +0000, Will Deacon wrote:
> > On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
> > > Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> > > This flag is required to get PID data in the SPE trace. Without
> > > it the perf tool will report 0 for PID which isn't very useful,
> > > especially when doing system wide profiling or profiling
> > > applications that fork.
> > 
> > Can perf not figure out the pid some other way? (e.g. by tracing context
> > switches and correlating that with the SPE data?).
> 
> For perf 'per-thread' mode, we can use context switch trace event as
> assisted info to select thread context.  But for "system wide" mode and
> "snapshot" mode in perf tool, since the trace data is continuous, I
> think we cannot use context switch trace event to correlate the SPE
> trace data.

Is there no way to correlate them with something like CNTVCT?

> > Also, how does this work with pid namespaces?
> 
> Here we are studying the implemetation of Intel-PT and Arm CoreSight.
> 
> The context ID is stored into the hardware trace data when record;
> afterwards when perf tool decodes the trace data and detects the
> packet for context ID, it will select the machine's thread context in
> perf [1].  Since the perf tool gathers all the threads infomation in
> perf data file, based on the context ID, it can find the corresponding
> thread pointer with function machine__find_thread() [2].
> 
> Since your question is for "pid namespace", to be honest, I don't know
> how perf tool to handle any confliction for differrent processes share
> the same PID, and I am not sure if you are asking CGroup related stuff
> or not.  If this cannot answer your question, please let me know.

My point was that the pid value written to CONTEXTIDR is a global pid
and does not take namespacing into account. If perf is run inside a pid
namespace, it will therefore not work.

Will
