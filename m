From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v2 01/14] perf report: remove code to handle inline frames from browsers
Date: Mon, 07 Aug 2017 21:22:08 +0200
Message-ID: <1919153.sx2P4c3EvB@agathebauer>
References: <20170806212446.24925-1-milian.wolff@kdab.com> <20170806212446.24925-2-milian.wolff@kdab.com> <20170807150710.GQ12201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:43594 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbdHGTWL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2017 15:22:11 -0400
In-Reply-To: <20170807150710.GQ12201@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Montag, 7. August 2017 17:07:10 CEST Arnaldo Carvalho de Melo wrote:
> Em Sun, Aug 06, 2017 at 11:24:33PM +0200, Milian Wolff escreveu:
> > The follow-up commits will make inline frames first-class citizens
> > in the callchain, thereby obsoleting all of this special code.
> 
> So you are removing the feature to then reintroduce it, is that it? That
> is not usual :-\
> 
> Normally we go on replacing bit by bit or have some ifdef, etc, to then
> phase out the old code.
> 
> Perhaps in this case your approach is the best one, still have to look
> at all of it, and it would help if the people behind the original code
> could review this, Yao Jin, can you take a look at this patch series,
> please?

Yes, I also did that in v1 of this patch series. Note that I can easily squash 
this, if needed. But I personally think for reviewing purposes, having it as 
separate patches is far better.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
