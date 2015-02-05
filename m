From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: What does several of perf configurations (alias, help,
 call-graph) mean ?
Date: Thu, 5 Feb 2015 15:06:32 +0100
Message-ID: <20150205140632.GB16369@kernel.org>
References: <54D3242A.8050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42107 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbbBEOGV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Feb 2015 09:06:21 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 34EA220274
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2015 14:06:20 +0000 (UTC)
Received: from zoo.ghostprotocols.net (ip-94-112-29-173.net.upcbroadband.cz [94.112.29.173])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 324642026F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2015 14:06:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <54D3242A.8050606@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Feb 05, 2015 at 05:04:58PM +0900, taeung escreveu:
> 
> Hi, every one. :-)
> 
> I'm tring to make things about perf configuration neat and tidy.
> Three questions have arisen doing it.
> 
> 1. alias [ util/alias.c : alias_lookup_cb(), util/help.c :
> perf_unknown_cmd_config() ]
> 
>         What kind of alias keys are there ?

I'm unaware of any, this came from the git sources where this concept
of 'alias' must be used.
 
> 2. help [ builtin-help.c : perf_help_config() ]
> 
>         'autocorrect' can have a value of integer type.
>         What does the value mean ?

Also comes from git, where it does things like:

  [acme@zoo linux]$ git ckone
  git: 'ckone' is not a git command. See 'git --help'.

  Did you mean this?
  	clone

But perf doesn't and instead:

  [acme@zoo linux]$ perf repjort
  perf: 'repjort' is not a perf-command. See 'perf --help'.
  [acme@zoo linux]$

I guess this is what 'autocorrect' stands for, unsure tho.
 
> 3. call-graph [ util/callchain.c : perf_callchain_config(),
> parse_callchain_record_opt() ]
> 
>         record-mode can be 'Framepointer style' or  'Dwarf style'.
>         Why does 'Dwarf style' accompany dump-size ?

For these things I think you should try to use 'git blame', figure out
when this was introduced and get the documentation bits from there...
did it, was a bit more complicated as there was code move in these areas
but this is the cset that introduced this feature:

26d330226b9cf6208daae9b0b3697980c8fb51d8

commit 26d330226b9cf6208daae9b0b3697980c8fb51d8
Author: Jiri Olsa <jolsa@redhat.com>
Date:   Tue Aug 7 15:20:47 2012 +0200

    perf tools: Support for DWARF mode callchain
    
    This patch enables perf to use the DWARF unwind code.
    
    It extends the perf record '-g' option with following arguments:
      'fp'           - provides framepointer based user
                       stack backtrace
      'dwarf[,size]' - provides DWARF (libunwind) based user stack
                       backtrace. The size specifies the size of the
                       user stack dump. If omitted it is 8192 by default.
    
    If libunwind is found during the perf build, then the 'dwarf' argument
    becomes available for record command. The 'fp' stays as default option
    in any case.
    
    Examples: (perf compiled with libunwind)
    
       perf record -g dwarf ls
          - provides dwarf unwind with 8192 as stack dump size
    
       perf record -g dwarf,4096 ls
          - provides dwarf unwind with 4096 as stack dump size
    
       perf record -g -- ls
       perf record -g fp ls
          - provides frame pointer unwind
    
    Signed-off-by: Jiri Olsa <jolsa@redhat.com>
    Original-patch-by: Frederic Weisbecker <fweisbec@gmail.com>
 
>         'threshold' can have a value of double type
>         and the value can be entered into callchain_param.min_percent.
>         What does 'threshold' mean ?

Ditto:

  commit 805d127d62472f17c7d79baa001a7651afe2fa47
  Author: Frederic Weisbecker <fweisbec@gmail.com>
  Date:   Sun Jul 5 07:39:21 2009 +0200

    perf report: Add "Fractal" mode output - support callchains with relative overhead rate

But especifically on the function you mention, the meaning looks
obvious, its the minimal percentage that that entry in the callchain
must have to appear on the output.

- Arnaldo
