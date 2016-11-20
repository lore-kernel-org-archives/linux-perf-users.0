From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Can not trace perf-probe event (made to probe the main
 function) with perf-top
Date: Sun, 20 Nov 2016 22:26:17 +0900
Message-ID: <20161120222617.39bc8304001c7690f82d52b4@kernel.org>
References: <CABvthiqxj=FCj-hg1Bhdnx=sTMZVt78nAM_N89HuuzfkBf7ZJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbcKTN01 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 20 Nov 2016 08:26:27 -0500
In-Reply-To: <CABvthiqxj=FCj-hg1Bhdnx=sTMZVt78nAM_N89HuuzfkBf7ZJw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HOUSSEN Franck <fghoussen@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hello Franck,

On Sat, 19 Nov 2016 17:36:39 +0100
HOUSSEN Franck <fghoussen@gmail.com> wrote:

> Can not trace perf-probe event (made to probe the main function) with
> perf-top ? (see ReadMe.txt - works with perf-report and -s option)
> Can someone help ? Missing option ? Known bug / limitation ?

From ReadMe.txt;
----
~> sudo perf top -K --stdio -s sym,dso -e probe_main:main
   PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% [1Hz probe_main:main],  (all, 4 CPUs)
   -------------------------------------------------------------------------------------------
----
Have you tried to run ./main program while running "perf top"?

Since the main function is just called once when starting run
the main program, without invoking it, the probe_main:main
may never be occured.

Thanks,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
