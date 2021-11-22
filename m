Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CAC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 18:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbhKVSkv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237126AbhKVSkt (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 13:40:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7C6360F55;
        Mon, 22 Nov 2021 18:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637606262;
        bh=2Wdn6ARecjYxTE9Lv+1HkfLC5D1q42WAF8HyVw5tmRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkFDpq9XQkmS2/FecqpSdMMRAJk0izhw0stzGEjqPncAXYgJQIE1+9Ju5UNRi8jdP
         8NWHYJAuuLBrYjqS65OUSmJbIhgrPfqxlQh9wGhbfR+56CWAkL+Ln4xveu/Ci1kIUf
         kCGY11m94ONI9Wxeh9+SVlqogNf0yFG7Xu+L/MfWPwRwkZg7nz+RYjFoinX58Q81dx
         8ImoDiepxftAlgDHHsLQ0drpxJxLvAznTd436v0FC3ywZYcIf+Dj5dKfaokxWisNl+
         WMFs7kY4crOXi2p/WtbAlBuKCrJw9bXUenPuWK+JkzY6P6f49K70GTb+wDM7S48hoX
         xSVE0RTgJ789A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87D6F40002; Mon, 22 Nov 2021 15:37:39 -0300 (-03)
Date:   Mon, 22 Nov 2021 15:37:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: /sys/kernel/tracing/events permissions
Message-ID: <YZvjc/0ObrVLbVCJ@kernel.org>
References: <2315137.Eos4xDj3du@milian-workstation>
 <YZuxDVm7q07hRdPy@kernel.org>
 <20211122120155.780d0116@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122120155.780d0116@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 22, 2021 at 12:01:55PM -0500, Steven Rostedt escreveu:
> On Mon, 22 Nov 2021 12:02:37 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
 
> > Em Mon, Nov 22, 2021 at 11:55:11AM +0100, Milian Wolff escreveu:
> > > a recent kernel update on my arch system has lead to breakage with regard to 
> > > accessing trace events from perf. For example:  
 
> Interesting. The change should have made the access to tracefs less
> restrictive, not more. Ah, I think it's the default permissions that caused
> this.
 
> > I saw some recent changes but haven't yet tried to reflect it into the
> > perf tools:

> > commit 79ef0c00142519bc34e1341447f3797436cc48bf
> > Merge: d54f486035fd89f1 feea69ec121f0670
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Mon Nov 1 20:05:19 2021 -0700
> > 
> >     Merge tag 'trace-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> > 
> >     Pull tracing updates from Steven Rostedt:
> > <SNIP>
> >      - Have tracefs allow owner and group permissions by default (only
> >        denying others). There's been pressure to allow non root to tracefs
> >        in a controlled fashion, and using groups is probably the safest.
> > <SNIP>

> > > ```
> > > $ perf record -e sched:sched_switch ls 
> > > event syntax error: 'sched:sched_switch'
> > >                      \___ can't access trace events

> > > Error:  No permissions to read /sys/kernel/tracing/events/sched/sched_switch
> > > Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'
 
> It's not the one commit, but the a clean up to not allow other access by
> default.
 
> To get the old access you need to add:
 
>   sudo chmod -R o+r /sys/kernel/tracing
>   sudo find /sys/kernel/tracing -type d -exec chmod o+x {} \;
 
> > > How should this be handled? Is it now required to manually `chmod` the 
> > > `events` folder, or is there another means to allow non-root to record kernel 
> > > trace events?  
 
> > Rostedt, I looked for documentation for this on Documentation/trace/ but
> > couldn't find, so its just a matter of creating a 'tracing' group and
> > adding users to this group that then can use tracefs files?
 
> I should add that to the documentation.
 
> I believe the commit was the change to the default permissions (for group)
> and not for other.
 
> But to add a group, you can simply add:
 
> sudo addgroup tracing
> sudo chgrp -R /sys/kernel/tracing

sudo chgrp -R tracing /sys/kernel/tracing
 
> And if you only do the above (not the o+* commands explained earlier), then
> only those in the tracing group have access to tracefs.

Ok, I'll try to autodetect this new behaviour and provide a hint for the
recommended behaviour, to create a group and add users to it.

- Arnaldo
