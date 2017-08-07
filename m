From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 01/14] perf report: remove code to handle inline
 frames from browsers
Date: Mon, 7 Aug 2017 17:16:27 -0300
Message-ID: <20170807201627.GH3647@redhat.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
 <20170806212446.24925-2-milian.wolff@kdab.com>
 <20170807150710.GQ12201@kernel.org>
 <1919153.sx2P4c3EvB@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdHGUQa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2017 16:16:30 -0400
Content-Disposition: inline
In-Reply-To: <1919153.sx2P4c3EvB@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>

Em Mon, Aug 07, 2017 at 09:22:08PM +0200, Milian Wolff escreveu:
> On Montag, 7. August 2017 17:07:10 CEST Arnaldo Carvalho de Melo wrote:
> > Em Sun, Aug 06, 2017 at 11:24:33PM +0200, Milian Wolff escreveu:
> > > The follow-up commits will make inline frames first-class citizens
> > > in the callchain, thereby obsoleting all of this special code.

> > So you are removing the feature to then reintroduce it, is that it? That
> > is not usual :-\

> > Normally we go on replacing bit by bit or have some ifdef, etc, to then
> > phase out the old code.

> > Perhaps in this case your approach is the best one, still have to look
> > at all of it, and it would help if the people behind the original code
> > could review this, Yao Jin, can you take a look at this patch series,
> > please?
 
> Yes, I also did that in v1 of this patch series. Note that I can easily squash 
> this, if needed. But I personally think for reviewing purposes, having it as 
> separate patches is far better.

Well, if it is a full blown alternative implementation, like it seems to
be (haven't started reviewing yet), probably.

- Arnaldo
