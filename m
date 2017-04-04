From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] Allow user probes on versioned symbols
Date: Tue, 4 Apr 2017 11:26:04 -0300
Message-ID: <20170404142604.GB12903@kernel.org>
References: <e12df271-9336-28c0-7441-2c20c6824b86@us.ibm.com>
 <20170331173123.GA18286@kernel.org>
 <095e1578-81c6-c62a-007f-1238445406a1@us.ibm.com>
 <20170403144658.GA3744@kernel.org>
 <20170404231802.711ac3e3346fa786259ddcde@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753921AbdDDO0K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2017 10:26:10 -0400
Content-Disposition: inline
In-Reply-To: <20170404231802.711ac3e3346fa786259ddcde@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Em Tue, Apr 04, 2017 at 11:18:02PM +0900, Masami Hiramatsu escreveu:
> On Mon, 3 Apr 2017 11:46:58 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > > > But apart from those problems, I think that one should be able to ask
> > > > for a versioned symbol, to probe just apps using that specific version,
> >  
> > > I agree, but wasn't trying to tackle that at the moment.  I can look into it, though.
> >  
> > > > for instance, we should consider the whole name as two functions, which
> > > > in fact, they are, no?
> >  
> > > I'm not sure I understand what you mean here.  Do you mean we should set a probe at every version of a given symbol name?  For example, if there are symbols:
> > > a@@V2
> > > a@V1.1
> > > a@V1
> >  
> > > ...for a request to set a probe at "a", we'd actually set a probe at all 3?
> > 
> > I think that we should just probe the default for that symbol and have a
> > way to probe all of them, perhaps using the wildcard, i.e.:
> > 
> > [root@jouet linux]# nm /lib64/libpthread-2.24.so  | grep ' pthread_cond_timedwait'
> > 000000000000dd90 T pthread_cond_timedwait@GLIBC_2.2.5
> > 000000000000d6e0 T pthread_cond_timedwait@@GLIBC_2.3.2
> > [root@jouet linux]#
> > 
> >   # perf probe -x /lib64/libpthread-2.24.so pthread_cond_timedwait
> > 
> > should be equivalent to:
> > 
> >   # perf probe -x /lib64/libpthread-2.24.so pthread_cond_timedwait@@GLIBC_2.3.2
> > 
> > Which matches how these versioned symbols are resolved by the linker,
> > no?
> > 
> > I.e. when 'pthread_cond_timedwait' is specified and the symbol table
> > lookup fails, I think we should re-lookup for
> > 'pthread_cond_timedwait@@*', i.e. we should have a
> > symbol__find_default_by_name(), which will take the
> > "pthread_cond_timedwait" and use a symbol comparison using
> > strncmp(strlen(key)), matching, should then look at right after the
> > common part looking for the double @@.
 
> Hm, this 'fallback'process sounds good idea to me.

This is just trying to keep the semantics used by the original user of
this syntax, i.e. the linker.

> BTW, how would we support other SYMBOL@VERSION, since we already
> use '@' for specifying source code?
> One possible way is to support it directly in perf-probe. If it
> failed to find probe point from dwarf, try to find from symbol
> map by using '@VERSION' suffix.

Right, we would be overloading that @ symbol, since version numbers
usually are very different of file source names :-)

- Arnaldo
