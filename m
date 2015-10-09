From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf report feature request: folded stack output
Date: Fri, 9 Oct 2015 15:13:41 -0700
Message-ID: <CAE40pdd3eqGLBFuBsP3haUos-+kygfNnagS0rJ5R9=G=_uN_DA@mail.gmail.com>
References: <CAE40pddHkm_SB4mpOBeSfTe8BcfU1js5fiEK96xA95gbjPa1bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38441 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbbJIWOB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Oct 2015 18:14:01 -0400
Received: by igkz10 with SMTP id z10so11880303igk.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2015 15:14:00 -0700 (PDT)
In-Reply-To: <CAE40pddHkm_SB4mpOBeSfTe8BcfU1js5fiEK96xA95gbjPa1bg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Fri, Oct 9, 2015 at 2:24 PM, Brendan Gregg <brendan.d.gregg@gmail.com> wrote:
>
> G'Day,
>
> Maybe someone would like to code this (if not I hope to find the
> time); perf report already has the capability to print captured stacks
> as a call tree. I'd like a new output mode: folded.
>
> Flame graphs[1] consume folded stacks. Eg:
>
> # git clone https://github.com/brendangregg/FlameGraph
> # cd FlameGraph
> # perf record -F 99 -a -g -- sleep 60
> # perf script | ./stackcollapse-perf.pl | ./flamegraph.pl
> out.perf-folded > flame.svg

Typo; that last step should just be:

# perf script | ./stackcollapse-perf.pl | ./flamegraph.pl > flame.svg

Brendan
