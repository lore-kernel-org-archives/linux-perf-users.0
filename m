From: Ingo Molnar <mingo@elte.hu>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Sat, 28 Jan 2012 13:01:51 +0100
Message-ID: <20120128120151.GA10390@elte.hu>
References: <4F22D8D9.3010108@rgmadvisors.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F22D8D9.3010108@rgmadvisors.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Steets <asteets@rgmadvisors.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: linux-perf-users.vger.kernel.org


* Andrew Steets <asteets@rgmadvisors.com> wrote:

> prctl(PR_TASK_PERF_EVENTS_DISABLE) doesn't appear to disable 
> perf event counters.  Here is a demonstration program:

btw., what's your usecase?

Thanks,

	Ingo
