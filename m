From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same
 function
Date: Mon, 15 May 2017 09:44:30 +0900
Message-ID: <20170515004430.GA22151@sejong>
References: <20170503213536.13905-1-milian.wolff@kdab.com>
 <20170510055352.GA2667@sejong>
 <1673560.Uk8cHjlLU8@agathebauer>
 <87a86igm5q.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:51740 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbdEOAoj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 May 2017 20:44:39 -0400
Content-Disposition: inline
In-Reply-To: <87a86igm5q.fsf@firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

Hi Andi,

On Fri, May 12, 2017 at 07:55:13AM -0700, Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
> >
> > I think I'm missing something, but isn't this what this function provides? The 
> > function above is now being used by the match_chain_inliner function below. 
> >
> > Ah, or do you mean for code such as this:
> >
> > ~~~~~
> > inline_func_1(); inline_func_2();
> 
> This could be handled by looking at columns or discriminators too (which
> some compilers generate in dwarf). srcline.c would need to be changed
> to also call bfd_get_nearest_discriminator() and pass that extra
> information everywhere.

You're right.  The discriminators should be carried too.

Thanks,
Namhyung
