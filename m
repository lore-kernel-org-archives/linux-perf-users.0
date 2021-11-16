Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B58C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 14:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3696152B
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 14:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhKPOtN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237022AbhKPOrX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 09:47:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC8F36140D;
        Tue, 16 Nov 2021 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637073864;
        bh=HrYfThd6CatHJigUGWm2a9FkiQKeMyTlZ1B0o3N0mIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nH67jlwPRRvOri0loJWTe50X8F0jBgcxovT0CnQQ9a/XIVOp5pwsCdKKCY1QvVK/o
         4dfPKHwtA7hcw0oQlaNO0q4gzhCWs2tlZllHTWHYKFXz39OiBbR9HBdmFPWia/Ip1E
         ChXOGZTuQVWRIgep3YoX29j4l18iJykE+7eqk1HfuElqIq+bFyIm8xYJPO2igbNBz2
         9S/lt4kcishRVNPdwolY0SaKVFy+KXN/zRCbBEDW4+VHaR+QmFIj5Wre6Lmu8Fbqzi
         i5DnES+9JdZ0ah9QsiL6SBZQUnsmS7Kw3kej2u+fAGmosecQz0uID9QInIetBki+pv
         r/NrQuimmkuug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7924C4088E; Tue, 16 Nov 2021 11:44:21 -0300 (-03)
Date:   Tue, 16 Nov 2021 11:44:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] perf test: Add basic stress test for sigtrap handling
Message-ID: <YZPDxTv7TwzYTOGU@kernel.org>
References: <20211115112822.4077224-1-elver@google.com>
 <YZOpSVOCXe0zWeRs@kernel.org>
 <YZO4zVusjQ+zu9PJ@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZO4zVusjQ+zu9PJ@elver.google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 16, 2021 at 02:57:33PM +0100, Marco Elver escreveu:
> On Tue, Nov 16, 2021 at 09:51AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Nov 15, 2021 at 12:28:23PM +0100, Marco Elver escreveu:
> > > Add basic stress test for sigtrap handling as a perf tool built-in test.
> > > This allows sanity checking the basic sigtrap functionality from within
> > > the perf tool.
> > 
> > Works as root:
> > 
> > [root@five ~]# perf test sigtrap
> > 73: Sigtrap                                                         : Ok
> > [root@five ~]
> > 
> > Not for !root:
> [...]
> > FAILED sys_perf_event_open(): Permission denied
> > test child finished with -1
> > ---- end ----
> > Sigtrap: FAILED!
> 
> Ah, that shouldn't be the case. It's missing exclude_kernel/hv, and this
> test should work just fine as non-root. Please squash the below as well.
> Let me know if you'd like a v2.
> 
> Ack for your change printing errors as well.

Squashed, thanks!

- Arnaldo
