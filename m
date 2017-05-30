From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/7] generate full callchain cursor entries for inlined
 frames
Date: Tue, 30 May 2017 10:33:03 +0900
Message-ID: <20170530013303.GA2965@sejong>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <4449663.nJV0hUTq9C@milian-kdab2>
 <20170524150237.GA27760@danjae.aot.lge.com>
 <2384048.5gd4jAH0Hk@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:42176 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdE3BdF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 May 2017 21:33:05 -0400
Content-Disposition: inline
In-Reply-To: <2384048.5gd4jAH0Hk@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

On Mon, May 29, 2017 at 08:36:25PM +0200, Milian Wolff wrote:
> On Mittwoch, 24. Mai 2017 17:02:37 CEST Namhyung Kim wrote:
> > On Wed, May 24, 2017 at 03:42:59PM +0200, Milian Wolff wrote:
> > > If you think the above is not a valid assessment, I'll try to change my
> > > patch series to use the IP + 1 trick you suggest. But I really don't
> > > think it's going to work.
> > 
> > So I agree that we should do symbol name comparison, but I still
> > prefer setting fake symbol address to [IP, +1].  That would reduce
> > memory space for annotate as well.
> 
> Can you expand on this? I can implement this, but without having a way to test 
> I don't know whether I'm doing it right or not ;-)
> 
> Note that fake symbols cannot be annotated from `perf report` currently. The 
> browser just does nothing - no error, nothing. So I'm really unsure how this 
> would influence the "memory space for annotate".

Hmm.. nevermind.  I missed that it cannot be annotated.  And if it
aggregates symbols by name, start address might not be necessary.

Thanks,
Namhyung
