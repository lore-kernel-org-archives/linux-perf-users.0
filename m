From: Milian Wolff <mail@milianw.de>
Subject: Re: Access to backtraces from user-space tracepoint callback in perf-script?
Date: Wed, 14 May 2014 10:47:43 +0200
Message-ID: <1944165.rOQGbuz1ZM@milian-kdab2>
References: <1998748.ORBRrU6aol@milian-kdab2> <4531806.6Q1YW4Luy6@milian-kdab2> <87lhu5mc68.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:39714 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaENIrq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 14 May 2014 04:47:46 -0400
Received: from milian-kdab2.localnet (unknown [188.111.54.34])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 1FE806280E09
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2014 10:47:44 +0200 (CEST)
In-Reply-To: <87lhu5mc68.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Wednesday 14 May 2014 09:33:35 Namhyung Kim wrote:
> Hi Milian,
> 
> On Wed, 07 May 2014 14:46:31 +0200, Milian Wolff wrote:
> > On Tuesday 29 April 2014 17:44:54 Milian Wolff wrote:
> >> Hello,
> >> 
> >> today I played around with perf-script(-python) and custom tracepoints.
> >> What I could not figure out so far is how to print a backtrace from the
> >> python callback. Can someone explain me how this is done, or point me to
> >> the documentation for this?
> > 
> > Ping? Could someone help me here please?
> 
> As far as I know it's not possible currently.. I vaguely recall that
> there's a patch to support the feature but unfortunately it didn't get
> reviews..

Is it this one: https://lkml.org/lkml/2014/4/3/217 ?

If so, could I kindly ask the perf developers to take a look at that? It would 
be an immensely useful feature for third-party tool developers to have.

Cheers
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
