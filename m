From: David Ahern <dsahern@gmail.com>
Subject: Re: perf top -z not working?
Date: Mon, 22 Oct 2012 07:12:19 -0600
Message-ID: <50854633.30206@gmail.com>
References: <507EA40D.60206@cs.utoronto.ca> <507EB776.9030304@core.kaist.ac.kr> <20121022014618.GA7924@ghostprotocols.net> <50853311.3040707@cs.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45819 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab2JVNMW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Oct 2012 09:12:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1922221pad.19
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Oct 2012 06:12:22 -0700 (PDT)
In-Reply-To: <50853311.3040707@cs.utoronto.ca>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

On 10/22/12 5:50 AM, Ryan Johnson wrote:
>>>> It seems that `perf top -z' does not behave as advertized, at
>>>> least not on the 3.2.0-25 kernel (Ubuntu) that I'm running. The
>>>> man page states that it should "zero history across display
>>>> updates" but the counts still seem to accumulate (the total
>>>> samples reported rises monotonically) and processes still show up
>>>> in the display long after they have exited. Pressing `z' or `Z'
>>>> seems to have no effect, either.
>> Are you using the --tui or --stdio interface? Try with both and check if
>> it works in one of them, I bet the problem is with --tui.
> --stdio does the same, so I'll have to try updating my kernel like
> Chulmin suggested (haven't had time to do that yet)

The kernel has nothing to do with the feature. From builtin-top.c, this 
part is either not happening or more likely not happening correctly.

     if (top->zero)
         symbol__annotate_zero_histogram(symbol, top->sym_evsel->idx);
     else
         symbol__annotate_decay_histogram(symbol, top->sym_evsel->idx);

I recall it working recently - last year or so. Can you try different 
versions -- say 3.0, 3.2, 3.4 and latest? If you have a copy of Linus' 
tree or Arnaldo's git tree it should not take much time.

David
