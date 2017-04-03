From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] Allow user probes on versioned symbols
Date: Mon, 3 Apr 2017 11:46:58 -0300
Message-ID: <20170403144658.GA3744@kernel.org>
References: <e12df271-9336-28c0-7441-2c20c6824b86@us.ibm.com>
 <20170331173123.GA18286@kernel.org>
 <095e1578-81c6-c62a-007f-1238445406a1@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbdDCOrE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2017 10:47:04 -0400
Content-Disposition: inline
In-Reply-To: <095e1578-81c6-c62a-007f-1238445406a1@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Em Fri, Mar 31, 2017 at 02:38:11PM -0500, Paul Clarke escreveu:
> On 03/31/2017 12:31 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 31, 2017 at 11:06:16AM -0500, Paul Clarke escreveu:
> > > Symbol versioning, as in glibc, results in symbols being defined as:
> > > <real symbol>@[@]<version>
> > > (Note that "@@" identifies a default symbol, if the symbol name
> > > is repeated.)
> > > 
> > > perf is currently unable to deal with this, and is unable to create
> > > user probes at such symbols:
> > 
> > On top of what tree/branch should I try to apply this?
> 
> I worked from torvalds/linux.
> 
> > Trying on acme/perf/core:
> 
> Pardon my ignorance, but where can I find that tree?

see below, but I think you got it already :-)
 
> > [acme@jouet linux]$ patch -p1 < /wb/1.patch
> > patching file tools/perf/util/auxtrace.c
> > Hunk #1 FAILED at 1875.
> [...]
> 
> > Apart from that, you are not checking the return of strndup, that
> > however unlikely, can fail, so must be checked.
 
> It's in the middle of strcmp-type function, so all return values are
> valid.  Shall I emit a message and call exit()?

See below for an alternative on how to implement this
 
> > On the style front you sometimes add a space after commas, sometimes
> > not, please make sure you add one.
 
> Ack.
 
> > But apart from those problems, I think that one should be able to ask
> > for a versioned symbol, to probe just apps using that specific version,
 
> I agree, but wasn't trying to tackle that at the moment.  I can look into it, though.
 
> > for instance, we should consider the whole name as two functions, which
> > in fact, they are, no?
 
> I'm not sure I understand what you mean here.  Do you mean we should set a probe at every version of a given symbol name?  For example, if there are symbols:
> a@@V2
> a@V1.1
> a@V1
 
> ...for a request to set a probe at "a", we'd actually set a probe at all 3?

I think that we should just probe the default for that symbol and have a
way to probe all of them, perhaps using the wildcard, i.e.:

[root@jouet linux]# nm /lib64/libpthread-2.24.so  | grep ' pthread_cond_timedwait'
000000000000dd90 T pthread_cond_timedwait@GLIBC_2.2.5
000000000000d6e0 T pthread_cond_timedwait@@GLIBC_2.3.2
[root@jouet linux]#

  # perf probe -x /lib64/libpthread-2.24.so pthread_cond_timedwait

should be equivalent to:

  # perf probe -x /lib64/libpthread-2.24.so pthread_cond_timedwait@@GLIBC_2.3.2

Which matches how these versioned symbols are resolved by the linker,
no?

I.e. when 'pthread_cond_timedwait' is specified and the symbol table
lookup fails, I think we should re-lookup for
'pthread_cond_timedwait@@*', i.e. we should have a
symbol__find_default_by_name(), which will take the
"pthread_cond_timedwait" and use a symbol comparison using
strncmp(strlen(key)), matching, should then look at right after the
common part looking for the double @@.

Perhaps we should somehow mark a struct dso as being versioned, i.e.
having symbols using @@, so that we speed up the search and don't try to
look for such symbols where there are none.

And if we mark the DSO as versioned, perhaps we can just one search
using both strcmp and, not matching, doing the strncmp +
strcmp(strlen(key) + 1, "@@") thing, no?
 
> > Additionaly, I can't reproduce your problem here, on x86_64:
> 
> I just cloned from acme/linux, and will rebase to there, if that's the best tree.

It is, to be precise:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Right now it is the same as the next best thing to do perf development,
the tip tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

You should try, on both, to use the perf/urgent branch if you think this
is a bug fix that should go upstream ASAP, or perf/core, if it is a new
feature or a fix for something introduced during the current development
cycle, i.e. poised to be merged in the next Linus Torvalds merge window.

- Arnaldo
