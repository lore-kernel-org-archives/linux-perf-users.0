Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D0C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4351E6113E
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 20:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhIIUUn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233423AbhIIUUk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 16:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16B846113A;
        Thu,  9 Sep 2021 20:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631218770;
        bh=Ygvt+lxFNwZzZvL9MPcok+35VpTBUT7ng+KGtgWpVtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoiJq7CJni/xLbLPaPYlLEB/5Srsy6obkNH3wfarP/xhlWi/API1ZcXJru2Q7Wvbo
         3Aj8GuBi7/puA2SKnx+Og+ZGX4qUJLXLJyGGPKGmO5GsBVJL7m+egXF+NxbrHIjSeA
         3/k3PjdrKXQZj5zJpRPWNT6FzZRtu4pobSPHz9iAUveiSePWM8O3tUx4mIVIsYa042
         nWuNdeujxEa/tcokjGhLmhvyVIBvw/T4wvZUSuqQJ5WF7Yoc6Ef052ztyi6PZnUxQ3
         Eluk85H0bA/I0StWkz5E7dDmA16qb7Tg1+nx2YcYN3mXbD6Db/nJA88RW9lwor7OTL
         PzqJaMFtTD28A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A377D4038F; Thu,  9 Sep 2021 17:19:26 -0300 (-03)
Date:   Thu, 9 Sep 2021 17:19:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     mingo@redhat.com, peterz@infradead.org,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] tools/perf: Use long-running addr2line per dso
Message-ID: <YTpsTpyczphPtADn@kernel.org>
References: <20210909112202.1947499-1-tonyg@leastfixedpoint.com>
 <1631205749.uhek9ofd69.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631205749.uhek9ofd69.none@localhost>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 09, 2021 at 12:52:31PM -0400, Alex Xu (Hello71) escreveu:
> Excerpts from Tony Garnock-Jones's message of September 9, 2021 7:22 am:
> > Invoking addr2line in a separate subprocess, one for each required
> > lookup, takes a terribly long time. This patch introduces a
> > long-running addr2line process for each dso, *DRAMATICALLY* speeding
> > up runs of perf. What used to take tens of minutes now takes tens of
> > seconds.
> > 
> > Debian bug report about this issue:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911815
> > 
> > Signed-off-by: Tony Garnock-Jones <tonyg@leastfixedpoint.com>
> 
> This patch seems awfully complicated, especially considering it still 
> uses relatively slow stdio instead of direct library calls. Did you look 
> into calling elfutils instead of libbfd if the latter is not available? 

That would be better, indeed, but since nobody has worked on this area
for white some time and we have it in a far worse shape right now, I'm
inclined to accept his work after I have time to review it.

> It is GPLv2 compatible, so can be linked against perf for distribution. 
> Additionally, elfutils is already used by perf for unwinding, but not 
> addr2line.
 
> On the patch specifically, why was popen changed to socketpair? It looks 
> like it adds significant complexity, and the advanced features of 
> socketpair are not being used (SOCK_DGRAM/SOCK_SEQPACKET, SCM_RIGHTS).

Valid questions, perhaps we can get what Tony did and improve it and
then try working with the library.

- Arnaldo
