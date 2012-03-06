From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] Sort inclusive
Date: Tue, 6 Mar 2012 07:57:53 +0100
Message-ID: <20120306065753.GB5100@elte.hu>
References: <20120305221253.GA30250@dev3310.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:39867 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab2CFG6D (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 6 Mar 2012 01:58:03 -0500
Content-Disposition: inline
In-Reply-To: <20120305221253.GA30250@dev3310.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org


* Arun Sharma <asharma@fb.com> wrote:

> Some of our users have been asking for the ability to sort 
> samples by inclusive time (time spent in the function + all of 
> the callees in the callgraph).

If this feature gets mature enough I'd even suggest that we make 
this the default output mode.

( Sidenote: the patched perf_evsel__add_hist_entry() function 
  seems a tad large now, it might make sense to factor out one 
  or two helper inline functions from it and thus clean up the 
  flow all around. )

Btw., assuming that you are profiling user-space applications 
via call-chains, how do you deal with the lack of dwarf decoding 
done by perf, in particular on 64-bit x86 systems where most 
distros don't compile call-chains into libraries and 
application? In what practical situations does that limitation 
hinder you and what do you do about it - rebuild your apps with 
frame pointers included?

Thanks,

	Ingo
