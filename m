From: Andi Kleen <ak@linux.intel.com>
Subject: Re: address output in 'perf script' does not work for addr2line
Date: Fri, 6 Mar 2015 15:19:11 -0800
Message-ID: <20150306231911.GF31334@tassilo.jf.intel.com>
References: <CAJh9x3pz1aLQP_vvfN_Y_BwF4ekcU1mqvZFJz7x7X6QqLkK1jg@mail.gmail.com>
 <20150303162322.GK5187@kernel.org>
 <CAJh9x3rwvAdjXJ67wvNjWjy451zWy1a_7JjDKQacJkwWWL031A@mail.gmail.com>
 <54F61172.4050002@gmail.com>
 <20150303205026.GN5187@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63873 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315AbbCFXTM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Mar 2015 18:19:12 -0500
Content-Disposition: inline
In-Reply-To: <20150303205026.GN5187@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org

> > >Yeah, it worked in the past.
> > >commit 5550171b2a9f8df26ff483051d060db06376b26d  change ip into
> > >relative address ( not sure relative to which address), which makes
> > >addr2line unable to parse.
> 
> > That's Andi's commit.
> 
> Oh well, that, IIRC, was done to make the srcline sort key to work, but
> broke the perf script output, so perhaps its time to change the perf
> script output to use that code and show srcline:lineno, will see.

Yes fixing perf script is best. Then the addr2line hacks are not needed
anymore. addr2line was never fully complete, as it couldn't handle
shared libraries.

However we should make it a new key to not break anything existing.

I'll take a look.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
