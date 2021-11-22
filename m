Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4310C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 15:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhKVPFr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 10:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKVPFr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 10:05:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B9FF60F25;
        Mon, 22 Nov 2021 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637593360;
        bh=7wSNO75bXfuaahDi3J/uQGND5FRPawk02C/zGNv5tMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOXzJmRn+LJwPy2lt2M0fWhPHiq6aHHSBvbQlOGMUrG06SH9TMdknykGvJBEwEbpO
         CcgR+TP0F7ZVIc3yqLKHvKTU8jt2Mzl9Lh64jN2qxTg5J2RGoeum5GAGMAxHdB09hB
         dJEQjZ3dmGIIj9XSbQJnsB4uX7ylKLCNdpPJ0svhXeBOBF+gLX9Ry4bI3EntkmFUBx
         z/Cfjvarxjpf/K6+delha/+6BBKXwA4CP1CK+zSIXWYOvBxD/gtCRNT/RBbqIuPsYJ
         dWMMkofFwwfuxGfO3SnirG6cKbVvFole31Y4CDXa4T06EKZlVD/TQj4GYAZD2BNH76
         QOkquvIjKNBcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA42F40002; Mon, 22 Nov 2021 12:02:37 -0300 (-03)
Date:   Mon, 22 Nov 2021 12:02:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: /sys/kernel/tracing/events permissions
Message-ID: <YZuxDVm7q07hRdPy@kernel.org>
References: <2315137.Eos4xDj3du@milian-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2315137.Eos4xDj3du@milian-workstation>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 22, 2021 at 11:55:11AM +0100, Milian Wolff escreveu:
> Hello,
> 
> a recent kernel update on my arch system has lead to breakage with regard to 
> accessing trace events from perf. For example:

I saw some recent changes but haven't yet tried to reflect it into the
perf tools:

commit 79ef0c00142519bc34e1341447f3797436cc48bf
Merge: d54f486035fd89f1 feea69ec121f0670
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Nov 1 20:05:19 2021 -0700

    Merge tag 'trace-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace

    Pull tracing updates from Steven Rostedt:
<SNIP>
     - Have tracefs allow owner and group permissions by default (only
       denying others). There's been pressure to allow non root to tracefs
       in a controlled fashion, and using groups is probably the safest.
<SNIP>

 
> ```
> $ perf record -e sched:sched_switch ls 
> event syntax error: 'sched:sched_switch'
>                      \___ can't access trace events
> 
> Error:  No permissions to read /sys/kernel/tracing/events/sched/sched_switch
> Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'
> 
> Run 'perf list' for a list of valid events
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available 
> events
> ```
> 
> When I then try to run the remount hint from the message above, which used to 
> work just fine, then the error persists, because:
> 
> ```
> $ mount | grep tracing
> tracefs on /sys/kernel/tracing type tracefs 
> (rw,nosuid,nodev,noexec,relatime,mode=755)
> tracefs on /sys/kernel/debug/tracing type tracefs 
> (rw,nosuid,nodev,noexec,relatime,mode=755)
> ```
> 
> and:
> 
> ```
> $ ls -ld /sys/kernel/tracing/
> drwxr-xr-x root root 0 B Mon Nov 22 08:39:15 2021 /sys/kernel/tracing/
> $ ls -ld /sys/kernel/tracing/events/
> drwxr-x--- root root 0 B Mon Nov 22 08:39:26 2021 /sys/kernel/tracing/events/
> ```
> 
> How should this be handled? Is it now required to manually `chmod` the 
> `events` folder, or is there another means to allow non-root to record kernel 
> trace events?

Rostedt, I looked for documentation for this on Documentation/trace/ but
couldn't find, so its just a matter of creating a 'tracing' group and
adding users to this group that then can use tracefs files?

- Arnaldo
