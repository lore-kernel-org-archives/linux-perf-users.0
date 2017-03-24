From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Feedback on patches?
Date: Fri, 24 Mar 2017 12:10:09 -0300
Message-ID: <20170324151009.GC5148@kernel.org>
References: <2870404.LJF2UlfSYK@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935890AbdCXPKZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2017 11:10:25 -0400
Content-Disposition: inline
In-Reply-To: <2870404.LJF2UlfSYK@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Mar 24, 2017 at 12:59:03PM +0100, Milian Wolff escreveu:
> Hey Arnaldo, others.
> 
> Jin Yao has pushed an extremely valuable change set, whichs brings inlined 
> frames into view for perf report. So far, he has not gotten any feedback by 
> anyone except me.

I was observing this from a distance, there was lively discussion, I was
waiting for the dust to settle so that I could then look at the
implementation aspects.
 
> Similarly, I have pushed a changeset that complements his, i.e. the one that 
> adds `-g srcline`. That one has not gotten any feedback whatsoever.

I saw that one now while looking for this one, that I saw earlier today
on my smartphone.
 
> So I'm asking - what is required to get these patches reviewed and included? I 
> consider both extremely important for C++ application developers like me, who 
> face inlined frames regularly due to template code.
 
> Please consider reviewing and merging them.

The more reviewers, the better, I'm making sure the pull requests I send
to Ingo are CCed here, so that one can see what is being done that may
be taking precedence to other stuff.

But always do as you did here, if a reasonable time has passed without
things you think are ready being merged, advocate for it, show numbers,
etc.

I'll try to look at it ASAP.

- Arnaldo
