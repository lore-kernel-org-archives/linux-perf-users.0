Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E6C61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Mar 2023 02:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCDCFX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Mar 2023 21:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDCFW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Mar 2023 21:05:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CCD60D51;
        Fri,  3 Mar 2023 18:05:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60C0BB81A07;
        Sat,  4 Mar 2023 02:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9586C433D2;
        Sat,  4 Mar 2023 02:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677895519;
        bh=QLpvAveIbamQ4uXMQPNK+a+IIK6TeiMr9c2Yv9xG4sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sizJSK+y6sNIxGmsrxC2tpT6CVt85bLtXjkNucauGRJprQ+2s24pSPuERepNKcW3f
         U6/nWVqPU3foDGkzuI3jI/PM0UWXgcpwSiXOJB8iddfPjg1t6u4rE1PxZRzMO0ShuG
         7Hvi03bEAjn1eb/NSNS/mFhxxg/rJRSkFvYpmMbTveKMdQ88kSTMWM/owbw6hedf6C
         dN8AR8LHLrOnj4UpPiG4p6IY2sjb8qGM6JCuXwdqFOe6x50Pgubv8j4vXYaB2gWpN+
         aKfv2yKNiqOEaP1bgUMorR7KwYMfzWoGs/BiZesqMh4opn1jZKtrpmn+M34uOGZpJL
         4+J670IoDahRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 267564049F; Fri,  3 Mar 2023 23:05:16 -0300 (-03)
Date:   Fri, 3 Mar 2023 23:05:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf tests stat+csv_output: Switch CSV separator
 to @
Message-ID: <ZAKnXGlG2njci4xx@kernel.org>
References: <20230223071818.329671-1-irogers@google.com>
 <Y/dq4yO+zXYLCQ8d@kernel.org>
 <CAP-5=fXuZ=sWJcKFUSPVSpjmHFHzSWQEMfoisvjqzJz2dDOXWQ@mail.gmail.com>
 <ZAEJy6RXAGjd7Erb@kernel.org>
 <CAP-5=fXS0pUsYXDrvwMgGJnYV=+1-PO+nE+b0FHR5YbNZzYSQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXS0pUsYXDrvwMgGJnYV=+1-PO+nE+b0FHR5YbNZzYSQg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Mar 03, 2023 at 04:15:17PM -0800, Ian Rogers escreveu:
> On Thu, Mar 2, 2023 at 12:40 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Mar 02, 2023 at 11:30:36AM -0800, Ian Rogers escreveu:
> > > On Thu, Feb 23, 2023 at 5:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Em Wed, Feb 22, 2023 at 11:18:17PM -0800, Ian Rogers escreveu:
> > > > > Commas may appear in events like:
> > > > > cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
> > > > > which causes the commachecker to see more fields than expected. Use @
> > > > > as the CSV separator to avoid this.
> > > >
> > > > Thanks, applied both patches.
> > >
> > > Thanks Arnaldo, I don't see the patches in the git branches so perhaps
> > > something went wrong?
> >
> > Its in my local branch, I'll push it.
> 
> Thanks Arnaldo! I see the change in perf-tools and perf/urgent which
> means they should appear in Linux 6.3. How do these things get merged
> into perf-tools-next? I'm building upon them for changes targeting
> Linux 6.4.

I'll merge perf-tools into perf-tools-next as soon as Linus merges it.

Till then you can either to the merge yourself and continue working
while the merge upstream happens or perhaps cherry-pick just that
specific cset, then when a merge happens later, it will be noticed as
already applied and skipped.

I'll push some more changes I have to perf-tools (the old perf/urgent),
namely syncing the kernel headers with the copies in tools/ and then
push to Linus after it sits a few days on linux-next/pending-fixes.

- Arnaldo
