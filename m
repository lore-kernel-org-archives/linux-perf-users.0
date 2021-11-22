Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC3C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhKVRFF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhKVRFE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 12:05:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC7460F6B;
        Mon, 22 Nov 2021 17:01:57 +0000 (UTC)
Date:   Mon, 22 Nov 2021 12:01:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: /sys/kernel/tracing/events permissions
Message-ID: <20211122120155.780d0116@gandalf.local.home>
In-Reply-To: <YZuxDVm7q07hRdPy@kernel.org>
References: <2315137.Eos4xDj3du@milian-workstation>
        <YZuxDVm7q07hRdPy@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 22 Nov 2021 12:02:37 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Nov 22, 2021 at 11:55:11AM +0100, Milian Wolff escreveu:
> > Hello,
> > 
> > a recent kernel update on my arch system has lead to breakage with regard to 
> > accessing trace events from perf. For example:  
> 

Interesting. The change should have made the access to tracefs less
restrictive, not more. Ah, I think it's the default permissions that caused
this.


> I saw some recent changes but haven't yet tried to reflect it into the
> perf tools:
> 
> commit 79ef0c00142519bc34e1341447f3797436cc48bf
> Merge: d54f486035fd89f1 feea69ec121f0670
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Nov 1 20:05:19 2021 -0700
> 
>     Merge tag 'trace-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> 
>     Pull tracing updates from Steven Rostedt:
> <SNIP>
>      - Have tracefs allow owner and group permissions by default (only
>        denying others). There's been pressure to allow non root to tracefs
>        in a controlled fashion, and using groups is probably the safest.
> <SNIP>
> 
>  
> > ```
> > $ perf record -e sched:sched_switch ls 
> > event syntax error: 'sched:sched_switch'
> >                      \___ can't access trace events
> > 
> > Error:  No permissions to read /sys/kernel/tracing/events/sched/sched_switch
> > Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

It's not the one commit, but the a clean up to not allow other access by
default.

To get the old access you need to add:

  sudo chmod -R o+r /sys/kernel/tracing
  sudo find /sys/kernel/tracing -type d -exec chmod o+x {} \;


> > How should this be handled? Is it now required to manually `chmod` the 
> > `events` folder, or is there another means to allow non-root to record kernel 
> > trace events?  
> 
> Rostedt, I looked for documentation for this on Documentation/trace/ but
> couldn't find, so its just a matter of creating a 'tracing' group and
> adding users to this group that then can use tracefs files?
>

I should add that to the documentation.

I believe the commit was the change to the default permissions (for group)
and not for other.

But to add a group, you can simply add:

sudo addgroup tracing
sudo chgrp -R /sys/kernel/tracing

And if you only do the above (not the o+* commands explained earlier), then
only those in the tracing group have access to tracefs.

-- Steve
