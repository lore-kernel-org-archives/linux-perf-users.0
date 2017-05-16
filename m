From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf report: fix off-by-one for non-activation frames
Date: Tue, 16 May 2017 10:57:53 +0900
Message-ID: <20170516015753.GB4885@sejong>
References: <20170515150444.6841-1-milian.wolff@kdab.com>
 <12254594.nNfBy6txoy@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:47256 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdEPB54 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2017 21:57:56 -0400
Content-Disposition: inline
In-Reply-To: <12254594.nNfBy6txoy@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Mon, May 15, 2017 at 05:13:06PM +0200, Milian Wolff wrote:
> On Monday, May 15, 2017 5:04:44 PM CEST Milian Wolff wrote:
> > As the documentation for dwfl_frame_pc says, frames that
> > are no activation frames need to have their program counter
> > decremented by one to properly find the function of the caller.
> 
> Note that this leaves the perf build against libunwind in the current, broken 
> state. I do not know how to detect the activation property there. Does anyone 
> else? See elfutils source code for what it is doing:
> 
> https://sourceware.org/git/?p=elfutils.git;a=blob;f=libdwfl/
> dwfl_frame_pc.c;h=296c815b9c73f42d79ac1778d2a0c420b89ee4eb;hb=HEAD

It seems that you can use unw_is_signal_frame().

Thanks,
Namhyung
