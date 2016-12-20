From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Inlined functions in perf report
Date: Tue, 20 Dec 2016 18:01:08 +0100
Message-ID: <20161220170108.GA6467@sesse.net>
References: <20161220115954.GA35897@sesse.net>
 <20161220121755.GL3124@twins.programming.kicks-ass.net>
 <2027151.EnbG4A8ymx@milian-kdab2>
 <20161220135450.GA32756@kernel.org>
 <20161220140822.GA10075@sesse.net>
 <20161220143746.GD32756@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161220143746.GD32756@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Dec 20, 2016 at 11:37:46AM -0300, Arnaldo Carvalho de Melo wrote:
>> Woot. Is this available in git somewhere? (Or if not, what do I apply it on
>> top of?)
> Normally you get it from tip, i.e. from:
> 
> git//git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

I suppose perf/core here means a branch named perf/core in that git
repository, but it doesn't seem to contain the patches in question.

I tried applying them on top of that branch by wget-ing down the right
messages from marc.info, but somehow, I must have misapplied them
(it was rather painful, especially since they seemingly come out-of-order
in the archives), because the resulting tree didn't compile.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
