From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf test 67 dumps core on linux v5.9
Date: Thu, 15 Oct 2020 13:31:40 -0300
Message-ID: <20201015163140.GB308748@kernel.org>
References: <a0474694-ab14-3131-0076-a67dba0586f1@linux.ibm.com>
 <20201015125259.GB1461394@krava>
 <7dab863f-6a2b-edf1-5049-9398cb53a68d@linux.ibm.com>
 <20201015145044.GC1461394@krava>
 <20201015150917.GD1461394@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20201015150917.GD1461394@krava>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Oct 15, 2020 at 05:09:17PM +0200, Jiri Olsa escreveu:
> ah when puting it on top of perf/core I found it's already fixed there:
>   a55b7bb1c146 (tag: perf-tools-tests-v5.10-2020-09-28) perf test: Fix msan uninitialized use.
 
> so we should be fine

For 5.10, yes, but probably we need to send this to stable@ since Thomas
reported it failing on v5.9.

Does a55b7bb1c146 have a Fixes: tag?

Yes!

[acme@five perf]$ git show a55b7bb1c146 | grep Fixes:
    Fixes: commit f5a56570a3f2 ("perf test: Fix memory leaks in parse-metric test")
[acme@five perf]$ git tag --contains f5a56570a3f2 | grep ^v | head -1
v5.9
[acme@five perf]$

So v5.9.1 will probably get this automagically cherry-picked.

Good.

- Arnaldo
