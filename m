From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf branch
Date: Mon, 14 Apr 2014 10:41:07 -0700
Message-ID: <87a9bnizbg.fsf@tassilo.jf.intel.com>
References: <CAH+i1GK4QdEzoa05PUN-Zx8Gzr2-w0RY631a9MzvTvyMAs1fGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42168 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220AbaDNRoH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Apr 2014 13:44:07 -0400
In-Reply-To: <CAH+i1GK4QdEzoa05PUN-Zx8Gzr2-w0RY631a9MzvTvyMAs1fGg@mail.gmail.com>
	(Noah Luther's message of "Sun, 13 Apr 2014 23:55:53 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Noah Luther <nluther@vt.edu>
Cc: linux-perf-users@vger.kernel.org

Noah Luther <nluther@vt.edu> writes:

> Hello,
>
> I am trying to use perf to trace branches as described by the 'perf
> branch' subcommand. Is there support through perf_event_open to access
> the buffer storing branch traces? I saw Akihiro Nagai's presentation
> on 'perf branch', but haven't yet figured out how to enable BTS and
> access the buffer based on the documentation on this page:
>
> http://web.eece.maine.edu/~vweaver/projects/perf_events/perf_event_open.html
>
> If there are any resources that might be of use to me, I would
> appreciate any assistance.

perf branch never made it, but you can use 

perf record -e branches:u -c1 ...
perf script

Also the latest GDB snapshots have builtin support for BTS through
perf in a somewhat more convenient interface.

Keep in mind that BTS is quite slow and often cannot keep up.
In the future ProcessorTrace will be better.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
