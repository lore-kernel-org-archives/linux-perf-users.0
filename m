Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78610C56202
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC9121D7E
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 17:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8wZ1Ayz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbgKZR0G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 12:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391347AbgKZR0G (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 12:26:06 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72755206F4;
        Thu, 26 Nov 2020 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606411565;
        bh=2NYIiNNYpC3H3s7SxseGQH3I0YFr06MT1xJN10INj38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8wZ1Ayz3jt23BJsMZzzoXz+J/aJRFLLSPHCEiXQ7fiiCrlaiKOofTqRfsDZktNzp
         V3pqXiQJwIVkfObjD+uu7vgkL6cu34jks/kryjFpECVyLFe8NVeUzGxAL2XigieLrJ
         4Gtvt6H7WIbnMxa96y6o36SKgeo1o7rSuUdoqyGY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0AEEC40E29; Thu, 26 Nov 2020 14:26:03 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:26:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf probe can't remove probes
Message-ID: <20201126172603.GD53384@kernel.org>
References: <20201125172755.GA53351@kernel.org>
 <20201126092125.402257a8776637d6bd2e090c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126092125.402257a8776637d6bd2e090c@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 26, 2020 at 09:21:25AM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> On Wed, 25 Nov 2020 14:27:55 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > 
> > Masami, have you stumbled on this already?
> > 
> > [root@seventh ~]# perf probe security_locked_down%return 'ret=$retval'
> > Added new event:
> >   probe:security_locked_down__return (on security_locked_down%return with ret=$retval)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe:security_locked_down__return -aR sleep 1
> > 
> > [root@seventh ~]# perf probe security_locked_down what
> > Added new event:
> >   probe:security_locked_down (on security_locked_down with what)
> > 
> > You can now use it in all perf tools, such as:
> > 
> > 	perf record -e probe:security_locked_down -aR sleep 1
> > 
> > [root@seventh ~]#
> > 
> > 
> > [root@seventh ~]# uname -r
> > 5.10.0-rc3.bpfsign+
> > [root@seventh ~]# perf probe -l
> >   probe:security_locked_down (on security_locked_down@git/bpf/security/security.c with what)
> >   probe:security_locked_down__return (on security_locked_down%return@git/bpf/security/security.c with ret)
> > [root@seventh ~]# perf probe -D '*:*'
> > Semantic error :There is non-digit char in line number.
> > 
> >  Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
> >     or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
> >     or: perf probe [<options>] --del '[GROUP:]EVENT' ...
> >     or: perf probe --list [GROUP:]EVENT ...
> >     or: perf probe [<options>] --line 'LINEDESC'
> >     or: perf probe [<options>] --vars 'PROBEPOINT'
> >     or: perf probe [<options>] --funcs
> > 
> >     -D, --definition <[EVENT=]FUNC[@SRC][+OFF|%return|:RL|;PT]|SRC:AL|SRC;PT [[NAME=]ARG ...]>
> >                           Show trace event definition of given traceevent for k/uprobe_events.
> 
> As you can see, "-D" is showing definition. Not delete. (*)
> Delete is "-d" or "--del".

Yeah, I was in a hurry and looked at just the first line right after the
command, didn't want to forget reporting it so sent the "bug" report,
d0h, sorry about the noise, using -d or --del works.

But having both -d and -D, in retrospect, wasn't such a good idea :-\

- Arnaldo
 
> (*) this option is for different version of kernel, remote-machine
> and boot-time tracing.
> 
> > [root@seventh ~]# perf probe probe:security_locked_down
> > Semantic error :There is non-digit char in line number.
> >   Error: Command Parse Error.
> > [root@seventh ~]# perf probe probe:security_locked_down__return
> > Semantic error :There is non-digit char in line number.
> >   Error: Command Parse Error.
> 
> Since you don't pass any option, both are for adding new probe event.
> 
> What happen if you run
> 
> $ perf probe -d "*:*"
> 
> ?
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
