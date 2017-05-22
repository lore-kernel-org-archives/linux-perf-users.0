From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/7] generate full callchain cursor entries for inlined
 frames
Date: Mon, 22 May 2017 18:06:43 +0900
Message-ID: <20170522090643.GA20009@sejong>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <2176198.pfBDoCjSEJ@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:39194 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757559AbdEVJGs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2017 05:06:48 -0400
Content-Disposition: inline
In-Reply-To: <2176198.pfBDoCjSEJ@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kernel-team@lge.com

Hi Milian,

On Thu, May 18, 2017 at 10:05:36PM +0200, Milian Wolff wrote:
> On Donnerstag, 18. Mai 2017 21:34:04 CEST Milian Wolff wrote:
> > This series of patches completely reworks the way inline frames are handled.
> > Instead of querying for the inline nodes on-demand in the individual tools,
> > we now create proper callchain nodes for inlined frames. The advantages
> > this approach brings are numerous:
> > 
> > - less duplicated code in the individual browser
> > - aggregated cost for inlined frames for the --children top-down list
> > - various bug fixes that arose from querying for a srcline/symbol based on
> >   the IP of a sample, which will always point to the last inlined frame
> >   instead of the corresponding non-inlined frame
> > - overall much better support for visualizing cost for heavily-inlined C++
> >   code, which simply was confusing and unreliably before
> > - srcline honors the global setting as to whether full paths or basenames
> >   should be shown
> > 
> > For comparison, below lists the output before and after for `perf script`
> > and `perf report`. The example file I used to generate the perf data is:
> 
> And of course shortly after sending this patch series I notice the first 
> issues ;-) The new behavior shows confusing results for `-g function` because 
> match_chain uses sym->start. I fixed this locally to compare the actual 
> function name if either of the two symbols is an inlined fake symbol:

Why not making the fake symbol has start addr of the sample IP and
length of 1.  The histogram sort code also compares the sym->start
which might confuse the output of the children mode too IMHO.

Thanks,
Namhyung


> 
> https://github.com/milianw/linux/commit/
> a1fa4486c19976f36d6ee7df263676e888c2bdb9
> 
> Before resending this whole series, it would be great if people could review 
> the stuff in here such that I know whether I'm on the right track.
> 
> You can checkout my clone from github for quick testing:
> 
> https://github.com/milianw/linux/commits/wip/distinguish-inliners
> 
> Thanks
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
