Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CD8C4361B
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Dec 2020 00:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D4222D05
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Dec 2020 00:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgLPAR0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:17:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLPARY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Dec 2020 19:17:24 -0500
Date:   Wed, 16 Dec 2020 09:16:40 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608077803;
        bh=9BcpfwUUEyZI0V0MWDNfgQ0ICTZaQgyMU8JVSZMrkxY=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=sb3mjZGtkVqfuy5bTwXWQmvWXSmzWJvOWpSGZtNHc+2ZxMXkykhGE/If9pU9f4BYU
         lc/yVK720ZtQkhy74CCjSiSS+TSxWdO9863oV/sfAIItXGl1lnSfCQaZCPM6fDyaZ8
         GZikC90vItREcKIcP6LlWalszL4syPbFxOb9lCDWzM9Ix1H1NiU4waGT1q7DL/OcmT
         Lw6be7lhUPzYcMOYBsXiU7lTAiyg1EgqXxvLIioa/UwfhZIx/ZzIr7lzOfVcfAFV8m
         NB3I/KzrbB++eoyK/IB0zltUK+kb0z5kSxhR+/KwS6aLIe3X/cAYEpxFq+ob8eL4gu
         Eaj1akgyzdsuw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf probe can't remove probes
Message-Id: <20201216091640.402d51e22dff04fff8ba6d79@kernel.org>
In-Reply-To: <20201126172603.GD53384@kernel.org>
References: <20201125172755.GA53351@kernel.org>
        <20201126092125.402257a8776637d6bd2e090c@kernel.org>
        <20201126172603.GD53384@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 26 Nov 2020 14:26:03 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Nov 26, 2020 at 09:21:25AM +0900, Masami Hiramatsu escreveu:
> > Hi Arnaldo,
> > 
> > On Wed, 25 Nov 2020 14:27:55 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > 
> > > Masami, have you stumbled on this already?
> > > 
> > > [root@seventh ~]# perf probe security_locked_down%return 'ret=$retval'
> > > Added new event:
> > >   probe:security_locked_down__return (on security_locked_down%return with ret=$retval)
> > > 
> > > You can now use it in all perf tools, such as:
> > > 
> > > 	perf record -e probe:security_locked_down__return -aR sleep 1
> > > 
> > > [root@seventh ~]# perf probe security_locked_down what
> > > Added new event:
> > >   probe:security_locked_down (on security_locked_down with what)
> > > 
> > > You can now use it in all perf tools, such as:
> > > 
> > > 	perf record -e probe:security_locked_down -aR sleep 1
> > > 
> > > [root@seventh ~]#
> > > 
> > > 
> > > [root@seventh ~]# uname -r
> > > 5.10.0-rc3.bpfsign+
> > > [root@seventh ~]# perf probe -l
> > >   probe:security_locked_down (on security_locked_down@git/bpf/security/security.c with what)
> > >   probe:security_locked_down__return (on security_locked_down%return@git/bpf/security/security.c with ret)
> > > [root@seventh ~]# perf probe -D '*:*'
> > > Semantic error :There is non-digit char in line number.
> > > 
> > >  Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
> > >     or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
> > >     or: perf probe [<options>] --del '[GROUP:]EVENT' ...
> > >     or: perf probe --list [GROUP:]EVENT ...
> > >     or: perf probe [<options>] --line 'LINEDESC'
> > >     or: perf probe [<options>] --vars 'PROBEPOINT'
> > >     or: perf probe [<options>] --funcs
> > > 
> > >     -D, --definition <[EVENT=]FUNC[@SRC][+OFF|%return|:RL|;PT]|SRC:AL|SRC;PT [[NAME=]ARG ...]>
> > >                           Show trace event definition of given traceevent for k/uprobe_events.
> > 
> > As you can see, "-D" is showing definition. Not delete. (*)
> > Delete is "-d" or "--del".
> 
> Yeah, I was in a hurry and looked at just the first line right after the
> command, didn't want to forget reporting it so sent the "bug" report,
> d0h, sorry about the noise, using -d or --del works.
> 
> But having both -d and -D, in retrospect, wasn't such a good idea :-\

Sorry for confusing :(

Hmm, would we better to remove -D and keep only --definition?
But it is already there, I think we should keep this option
for backward compatibility.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
