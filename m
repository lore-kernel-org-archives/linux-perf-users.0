Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E7C56201
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 00:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568C820B1F
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 00:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz6x5LnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgKZAVa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:21:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgKZAVa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Nov 2020 19:21:30 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E9A20770;
        Thu, 26 Nov 2020 00:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606350089;
        bh=xc1pCyuv6YMDM1voLnM6v8+2LQbvC8ecZbxy/UPFqlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vz6x5LnH3KAysC+O6usEiodgJBku8UgtxjbxXd1K5bo0uOVWPnVjpovl9bMO0n2ZK
         iYZouFuguyDCBOkPdM3Mh1ao73g2PAmvb7mudI1C9x1xkjrKTuhIgJzMNNi9bIGSbp
         fbeU0buh/S4pUyacsvmyOWx4MP0t3I+xa+oP1LB0=
Date:   Thu, 26 Nov 2020 09:21:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf probe can't remove probes
Message-Id: <20201126092125.402257a8776637d6bd2e090c@kernel.org>
In-Reply-To: <20201125172755.GA53351@kernel.org>
References: <20201125172755.GA53351@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, 25 Nov 2020 14:27:55 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> 
> Masami, have you stumbled on this already?
> 
> [root@seventh ~]# perf probe security_locked_down%return 'ret=$retval'
> Added new event:
>   probe:security_locked_down__return (on security_locked_down%return with ret=$retval)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:security_locked_down__return -aR sleep 1
> 
> [root@seventh ~]# perf probe security_locked_down what
> Added new event:
>   probe:security_locked_down (on security_locked_down with what)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:security_locked_down -aR sleep 1
> 
> [root@seventh ~]#
> 
> 
> [root@seventh ~]# uname -r
> 5.10.0-rc3.bpfsign+
> [root@seventh ~]# perf probe -l
>   probe:security_locked_down (on security_locked_down@git/bpf/security/security.c with what)
>   probe:security_locked_down__return (on security_locked_down%return@git/bpf/security/security.c with ret)
> [root@seventh ~]# perf probe -D '*:*'
> Semantic error :There is non-digit char in line number.
> 
>  Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
>     or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
>     or: perf probe [<options>] --del '[GROUP:]EVENT' ...
>     or: perf probe --list [GROUP:]EVENT ...
>     or: perf probe [<options>] --line 'LINEDESC'
>     or: perf probe [<options>] --vars 'PROBEPOINT'
>     or: perf probe [<options>] --funcs
> 
>     -D, --definition <[EVENT=]FUNC[@SRC][+OFF|%return|:RL|;PT]|SRC:AL|SRC;PT [[NAME=]ARG ...]>
>                           Show trace event definition of given traceevent for k/uprobe_events.

As you can see, "-D" is showing definition. Not delete. (*)
Delete is "-d" or "--del".

(*) this option is for different version of kernel, remote-machine
and boot-time tracing.

> [root@seventh ~]# perf probe probe:security_locked_down
> Semantic error :There is non-digit char in line number.
>   Error: Command Parse Error.
> [root@seventh ~]# perf probe probe:security_locked_down__return
> Semantic error :There is non-digit char in line number.
>   Error: Command Parse Error.

Since you don't pass any option, both are for adding new probe event.

What happen if you run

$ perf probe -d "*:*"

?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
